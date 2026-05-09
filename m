Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9037B030
	for <git@vger.kernel.org>; Sat,  9 May 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778324481; cv=none; b=Shq2hvBT/hBwOk3S7tNkzwyld0oBJt5n2kL4CbgHS7+IQ0fL2GuZIF5+d5SfEw6dKj9a44ZE5CEtEXbpTQUn1R3x8sWxcCLdG+Ybr0KZFABk+EczQ4DQ6QpSCJ9SgL9F007l8tQjj9xmdrC6R3WgzwgbRSjhooVtPmFyEHiY2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778324481; c=relaxed/simple;
	bh=Stw3xWRJg0zSYzzP5Na6v0TzHKnAqcfxyD2+1+OisuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WjPq3EW/EdjFjlLaX8ZwnSB25U2/QWOr+LTLCkcSg5wu067UpES84gaLa48oFj8NDjRVomcRZcvygxAoMFUl+30ut/JVG2fPjQr5lN7tA53usECAV0UomXfj5WgdrZHe1LMqIJh69Eu1SuxI34VCz6FT9dLYc1+uV73qlHaT80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PTmjqtUu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ohmZfQg/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PTmjqtUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ohmZfQg/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 64BDFEC00A9;
	Sat,  9 May 2026 07:01:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 09 May 2026 07:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778324477; x=1778410877; bh=DgBtuaEzV8
	SJ9mWbkximrC8c1L7C0H45uqZ2R5hmgIQ=; b=PTmjqtUuJ6/DXAG3VtQp+plHDj
	MGN5EDwRypx3ytGmVWyEmdHuvH4jSMQNj7t+hvq/jcc9Tlk8GTdVMRMbSxGfmeoQ
	ZALrvXrJuZD6S2QG0DKbb46ZMDMk5j0WAZZL3J+ad81DGuz7Bw7JEdZxAOtOgsYh
	wwinT1gFd13q+I25v9edhssun2OqqjpQAZzyb76noMJqYwXB8EIrDHZ7hFUVG45N
	5NX2m8/PiIiYr722ZUXR5f+ekVpl7UFp4IGrIx+VmkUl6Ktvw6NQ+0PIXytXd14Q
	2Gcjw/7sZhY//j0MFclDQJAzkcRFu5z0SRW8EtRSbnLsg9TE0JfRv7isFIDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778324477; x=1778410877; bh=DgBtuaEzV8SJ9mWbkximrC8c1L7C0H45uqZ
	2R5hmgIQ=; b=ohmZfQg//1KI32HSLmRxHIpIYJhM5Hgzt+ive5wdeBdqk9Di493
	ZVP7EL8AiQ2QJVZAIOP5bh4AzxdbSE94OzObBjsp2zinTInzlBhteo72UK2gNTob
	hF7SqwNyr0Z34JQ38vj2IkJ1CSYJLel3bJAgaI8fT1aE7IH+fWLv7roYPUhkYcPa
	4H0smkmMZvF8QfEFQQNNOoDfvoS3g6LF00VqRvNcUqmPnxgWaSvhdcTiLlmkw1P0
	nG7OESYao3pTij4wTx4vdyQLlG6+zWoCcZjlfXyIoD8it+ZzA/zZhTtJHJKJ1Zyj
	ovMLoBUbzod3xcnHD9vpgEtIgL5QMIuMpMg==
X-ME-Sender: <xms:_BP_aZ-LFsrlo2PR-Kxzsp-5Cy4YBXI_WnICC95VTsnxrzxDFSBmlw>
    <xme:_BP_aaQzal2BduIaudbZ6o3S-Vgu69IAsNGk7ZQ7f50teHKSMxYWT7UgQ5Gp4wB8Q
    ff2ZQQ2m4gI-ov5UIjWdtuJK0WnEnzG210YADA2X7YI6TSN27jLzA>
X-ME-Received: <xmr:_BP_abeNc3cjGW_8ShWXBltPW3DiospAg-C_ve1bqLcua5hEadw7gkOQYMEFxltAR4b1Pge_7ZfIa9pwfbQ_PypQUenXw3hF4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeekueejgeetveejteegieelueejieejfeeugeeiteeitdelffdvffehieeh
    udefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hrohhikhesuggvlhgrhigvugdrshhprggtvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhr
    ghdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_BP_aUTCrjTON0HRC6kKM693JArQg2SGN0YsBID3uBqhRe8qGu2rjw>
    <xmx:_BP_afKmv9ubN258FxJgP2LLYrKAhPECmssJI8kVKkBTrfsWV_Aj-Q>
    <xmx:_BP_aZL4sVx37CliKbUfEPCupRsJF1DRXUwxYm7FLySanRJhcjHzPg>
    <xmx:_BP_aShrcrNHe_tzMo1i7UGV0NLXxP3kO9nNFAH13rC6ciwSQ9Ed0A>
    <xmx:_RP_adD89fghjnG-s67lrm997y5G4RgJ8ULpRej7BMuQHFFwOdzipQ1a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 07:01:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>,  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v5] revision.c: implement --max-count-oldest
In-Reply-To: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
	(Mirko Faina's message of "Thu, 30 Apr 2026 21:52:45 +0200")
References: <cover.1777249165.git.mroik@delayed.space>
	<2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
Date: Sat, 09 May 2026 20:01:15 +0900
Message-ID: <xmqqjytcdeys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> --max-count is a commit limiting option sets a maximum amount of commits
> to be shown. If a user wants to see only the first N commits of the
> history (the oldest commits) they'd have to combine --max-count with
> --skip. This is not very user-friendly.
> ...
> +test_expect_success 'log --max-count-oldest=3 --reverse --oneline' '
> +	test_when_finished rm expect &&
> +	git log --oneline | tail -n3 | tac >expect &&
> +	git log --oneline --max-count-oldest=3 --reverse >actual &&
> +	test_cmp expect actual
> +'

"tac" is not portable, and breaks macOS CI jobs.

  https://github.com/git/git/actions/runs/25591146540/job/75128929633#step:4:2058

Wouldn't

  git log --oneline --reverse | head -n3 >expect

be equivalent?
