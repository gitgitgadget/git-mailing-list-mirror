Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48D214210
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533001; cv=none; b=ZPbRAbMXolIZW8N6JdUmqPHsYR88sMlaulMhFqjKBEj3Cnbbdv2bEg+uypOwm45fEOuYYqii54d2fW8nV/drf67aUjQ9UhcBLWSTXxWjoGlGqrgPtrjUviSnufZm1qZUSJM/S/BQm1dkMWHZ/qk0sWLBJEMWCv2lUZbnRmmcjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533001; c=relaxed/simple;
	bh=8FjjzMoKdEXtBhhZT7LCjmFxAgI5IT4qZo7gnf3nCF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hhx0LK0mNgpKNPsXERiCtVE7igo1DhIUy028VjCWe41UNBOwp86O9Z5NYql+Q3tuHEZG37dcQDrvjXN8cCo810VgDQc1Q6ABFtEbgtsm7Hdtx5NyrUobHNnPlgsHqQrBTQu/Gc0TZSnGtqwUg1vsdtkMOgpBH6w+WMPOZZwU5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IiuR9lF3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okcdcrwN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IiuR9lF3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okcdcrwN"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id C1C791140187;
	Fri, 10 Jan 2025 13:16:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 10 Jan 2025 13:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736532998; x=1736619398; bh=cwSRKhykx2
	ZP2HcwDj39HWu+1Y9ZmTnJUKLVmcpcHUo=; b=IiuR9lF3/eNFPrYg4FFC524BBj
	yCzC14vL6nnF5mpz55/8+Ni/J/uyT4vNZLr+xWJjUeNcoMrafOQ9rjtbK6OCderu
	KIJXbKLp8Rimb0vUMZZOwB/kDNbrP0mauYAea15LQ7dlmVfepXNMeci3WTW+2jCx
	+ssy63PJRvPUS0r4R3A8y4WFWSZpkImfrgqx+NT7PEGOC4yby+a5jwoQTByOPHnH
	vcP/D0AfZ667WLM0dPp614ZOTLoDGmfVHSd7ECDo2XYSUvUuzhJeYElQ8tNEA0Or
	Mk4pFmZY7/kg3Dof5Fqpq2vyYuaTBdCIt/oJVUokt5mtzPpGYuz9DMk9Vqig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736532998; x=1736619398; bh=cwSRKhykx2ZP2HcwDj39HWu+1Y9ZmTnJUKL
	VmcpcHUo=; b=okcdcrwNL2RdN/gHmrNB2yKRUY4DbYOBJTRBHPIysALSJAvSu+C
	M53b9ArNzlLOAFgv0/e3g1PE321wDAwaYTGZe+kAc/VZBp2rJRjj1mg/j1TpeBdH
	imjbPVJtiz5ArN1Q/dIi8APGXgjDN+H44iPXpHetO8sxDRdDS4INx1SNHQ3bcHJv
	F1/1z/tXxnxkOKV0jTM+KgG/C1Dt2B+lwvTb+bwOK5kTZNZk3fX9LzAq5z9HnWBd
	WpeBehC6jtD3Ie6I/JeGT2NnGLgUjdDTTrdVbEgj7HV0FEtQHP+3TG7lYPyZGr3x
	a+y5ExbnzI2KfJc5Nslqdd1bOK10ZBngK9Q==
X-ME-Sender: <xms:BmSBZ1RMaSHmJ0EEs2s9b-dTyrpV--0BaeQEbnPGuELMTo5kYR3sqA>
    <xme:BmSBZ-wTz1ELAwdy0rB2Rp0Eu5Isczh_MSwvRgzQFwIHAykBa6sSrwRAfzjd_xBX7
    XN_bSrtJL2phZfeig>
X-ME-Received: <xmr:BmSBZ63bAd6k69NFZfaM237hjX4mgajIGlk0MEjbZkhLuB5_irImN34s-oig_Xq3MI5IKQz1bLaknmo0rXknWT1YbuefjZbRQbMH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepuggvrhhrihgtkhhsthholhgvvgesghhithhhuhgs
    rdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrug
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BmSBZ9BihwAnmB8CRwsk5YQzmmN-YepeoNluRyDP6-1sthdIpve4wA>
    <xmx:BmSBZ-i2b5BOlwXcD2TC7rsTk60iBAAW17gzHBOrFjPWWcIM30c07w>
    <xmx:BmSBZxrtqyzu32esJbjb2heS1GylbrIPknQsnbPM1f1xonA0LFxScw>
    <xmx:BmSBZ5jhzg4HJaUW1cnpNE04fw_gHsLLkOU77gr_407bbxj6j9y9Wg>
    <xmx:BmSBZ5PXehQJhOjaepSzINY0GoMit32EmkejNJaQujXhady5r5IEP4A->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 13:16:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  derrickstolee@github.com,  stolee@gmail.com,  Johannes.Schindelin@gmx.de,
  peff@peff.net,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] docs: discuss caching personal access tokens
In-Reply-To: <pull.1851.git.1736458019921.gitgitgadget@gmail.com> (M. Hickford
	via GitGitGadget's message of "Thu, 09 Jan 2025 21:26:59 +0000")
References: <pull.1851.git.1736458019921.gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 10:16:36 -0800
Message-ID: <xmqqwmf27cvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Describe problems storing personal access tokens in git-credential-cache
> and suggest alternatives.

> +PERSONAL ACCESS TOKENS
> +----------------------
> +
> +Some remotes accept personal access tokens, which are randomly
> +generated and hard to memorise. They typically have a lifetime of weeks
> +or months.
> +
> +git-credential-cache is inherently unsuitable for persistent storage of
> +personal access tokens. The credential will be forgotten after the cache
> +timeout. Even if you configure a long timeout, credentials will be
> +forgotten if the daemon dies.

Very true.

> +To avoid frequently regenerating personal access tokens, configure a
> +credential helper with persistent storage.

Like libsecret and osxkeychain, you mean?  I am wondering if we want
to be a bit more helpful by being explicit.  I think there is a
section in a maual page that has a list of known and often-used
credential backends, so referring the readers to that section may be
helpful.

> Alternatively, configure an
> +OAuth credential helper to generate credentials automatically. See
> +linkgit:gitcredentials[7].

Indeed.
