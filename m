Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF821D6195
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772169; cv=none; b=MR4sJ+x/bHqAZAIFQjN9DaeCw+qvSSuEmw1SVABy7F25WGppXOT6U1RUph9IOagJCG4D/W6VHuZhDIWb46j1A80R+4+D+6QUZXn4Qa2o1D+qXWhAZV7eW5fB8/BVhVyuBCZfwR2cSJ1OJpLVtXar37/qn2X0WSXxrD1ahc7GxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772169; c=relaxed/simple;
	bh=94cG8eOYv2E5ZsNO3m1uEJRigu7JiHVzLpS1dcG5zew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvrq0NHDP0DBU6pC4/hU/FeMBDb+LEmiC0zddW0p7WSFKVqt4MGxJk3OmHIoh1ePkvQDGvRynT0AICrwSNMLrLhuJHTu7Z0s/3HQMT3cBjcH+nHTRZeH6sSTAZxdjGlhHXLQBj70jLbARKCxNwa9GKj9ZtV4KUbemlbcU7vo5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kfmpsaAy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JRrBFoHB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kfmpsaAy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JRrBFoHB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9580014000D0;
	Thu, 21 Aug 2025 06:29:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 06:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755772166; x=1755858566; bh=si8RULNsq2
	87/hjAUaqa3WFTZwL72ca2EeHc5Wk7Vng=; b=kfmpsaAy/74BagnHfca/iTKNUa
	bUZ2mCKcLDU/Fotsqtm7AI/poNSyDFkXIbyIHmb59hv94+t/Zkosd4jQHtYX6fAj
	iqrc7YjSLzflF8w8f+1DIfwIvWmtPBTxtUrnnCr+Kn2U4cBaJcEH/zBWVzDfqZhm
	nz2XqW6lW2w3sI612Vnlu7C//15E7Ui8nTvvaG1kR4vygpJZrkGKM1QtIlbKMYjE
	elDMW9jp8fwYEQ2vOXSmk+sL/j106Tw12v4HcyU0Rl8gGOzypALu06tXlC2V1KXn
	ME/j06jBpgpffmozrzkPJ5EJVy1BPUgGgRIME+5Jc6hE8BkTWufMnVenl2zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755772166; x=1755858566; bh=si8RULNsq287/hjAUaqa3WFTZwL72ca2EeH
	c5Wk7Vng=; b=JRrBFoHBIBk/lDFOkHIgAImcnGZXbbG5QVRgOsbGbsDbo++802f
	Mbe+fA89q4Bm45hcpmCEpLTdoWub8iY8oiO82BmWBkCRCTqX17Dm0FA9m3N1Ednc
	UsbOS7elJAuOeN195t6RJ6p1c8I8YqOA82+P2nQmHV1YdxFzerjKyqL6NcBiOHIn
	hB192alxe+34ZzeRUdlftADIhvC5JdKtmyM/c6CuISN67vS+C2toQsJ3L4Prd33R
	AXre6uCIvaz1HfDRxi/opuDT4o77oL7gWpc0C9lnZi9jws3b1Tm5+wlrcAVL4L4K
	GZ9ZbnbDcRLW1UIOP7ysevkaYxX2U0od6UA==
X-ME-Sender: <xms:BvWmaNYu1v8xJB17Aa04M-Waka-mOhANNhCsDt6D5ZLWt0gI3eK-DQ>
    <xme:BvWmaHo9DFI3U1O_hU5eP65M0OQAJfNvBWnO9W0RVKRFNSUJtXtM6C-25j4Ux_3CS
    Kot6Km8vTdLrgdpwg>
X-ME-Received: <xmr:BvWmaJZMtE-9oglzvD9twIP8cuUwYR3wMnfQRocVJ4BMjLwtiZ0AZJvXjAbvmngFF07ZZUjf8dCDt4HqU0PfBNfPTl4emw3OipnHShAx1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:BvWmaHTbPAUrCziabeE7AbhNCuP8RI7wT1Y2nLPNPdkdw0BNaLasnQ>
    <xmx:BvWmaI4pldlVGL-Uh1xfkgVvOUUrSIpMRr0cv_Sz5ArkbybeOqWnqw>
    <xmx:BvWmaExPk4jj1_gBBAyuyEI0FdNv0phvxyeH_1hIFdVmwzdI8QbswA>
    <xmx:BvWmaPTLNeVZOyiUzsNq06w1CkRFAEvJtHmdL-zrBCF5Jhi5ilk6qg>
    <xmx:BvWmaEk_kcFadXhKb0ufwpB3Cdk_UpDv2aGaxYP6mXT_kzkr1vvWlG5f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:29:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e17e180 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 10:29:24 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:29:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [GSoC PATCH 0/2] repo: add -z and objects.format
Message-ID: <aKb1AfeIWB_SfJiI@pks.im>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820144247.79197-1-lucasseikioshiro@gmail.com>

On Wed, Aug 20, 2025 at 11:42:45AM -0300, Lucas Seiki Oshiro wrote:
> Hi!
> 
> This patchset adds two features to `git repo info`. They are unrelated,
> but I preferred to send them together to avoid merge conflicts and
> because they are small.
> 
> - The first patch adds the `-z` as an alias for `--format=null`, as
>   requested in [1]
> 
> - The second patch adds `objects.format`, which retrieves the same value
>   as `git rev-parse --show-object-format`
>   
> Thanks!
> 
> [1] https://lore.kernel.org/git/mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg/

What this cover letter doesn't mention is the base of the topic. I
assume it's v2.51.0 with lo/repo-info merged into it?

Patrick
