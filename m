Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE2283CA4
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330038; cv=none; b=YyIEY61fprs0D1BpkG8LlrqR/HelY9P+pEgdt6NEPdxd1GSdRSMGEzx+FbXVGRkcQq0zKnUcjisHjWIaibdj8/q8xZezs83uy5LgQZ8qLILoOquUGJ3EEYU2WiUxduhTTNP+baJ+/vNIRejTOkiWNbckwIA0O6fpXcTL5KcyjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330038; c=relaxed/simple;
	bh=Ngf19GSF51peiyZih9RBxRAw+RY+NDFzsDt6Y7xRINU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCeMikSnmVmb1GQU/vIadPWv+V4lx/2OFcwXvkZ9x9qvqa1qFf83G+D21GmGG5sxa7Sb4D80WLSEf+pCPTw/S4fbu1u+AKYOMNuc/L25GAEIP5xpGKDpBQOae0fBD6zTXtTKmaL57eQ3Ja0qTarCQfy8d7hMPRSRTWfhYoSmFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KHJtJBOg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lA53y8zB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KHJtJBOg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lA53y8zB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAC64114005B;
	Tue, 22 Apr 2025 09:53:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 22 Apr 2025 09:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745330033; x=1745416433; bh=h/scdoJfeN
	IWguGynboc2axaB7bWQB66UsZwDeKV/sc=; b=KHJtJBOgbRUcn76SadDSoYqQQV
	RXFhV6reTxaNwj+/LO2vgq337FDNIsbNbOqygfInTpvCb9UEaJ2EAsNaPy7ik+CD
	v1xaBCjOZ+7lwqoRj+TyPsrgcZ/dYa+pqDut+MIK+QZe3Qjv6hdEvu7mo0pPbqo2
	KwhvCO23QItp3dBpcfLZQU69bVHtls7YW52NP2zeDtLrEyzkkrEzc1jzDxyImVnX
	CtBUxkphuLvgt8ACIpYsCMHs21DmvBwAH6KgGl62HSQan8yLISJDK8eyaJAwvcRq
	VpRfX98OXcywXEr09LP94xjWkwrYdtPdEfcKuYjTmecZIjfCFZpmWDsLNtKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745330033; x=1745416433; bh=h/scdoJfeNIWguGynboc2axaB7bWQB66UsZ
	wDeKV/sc=; b=lA53y8zBgTBIUfge0zCUgN34kH+HOoA3fVNhN60uNj9SrUYE1qM
	N7guQuVZp0negCK2SQ0JZqfBmcuMl2pm+yB6CZLIKp1WBs/ZozD1wN7gqAKiw2ZQ
	H+q7C7P4TLvpZDdhqN7qIlgu34oIaJ+doIQV+HdRWVKRin7AMxEK6vyiJPz0b7ll
	I6RbqBfta1plOwx0zFxDP8CUdMAH2G8w9N8qL/EoghtFKhlLZQvKh3/vNfuK1nlK
	a4swCq5V2/bT/YlpNE0Aag1NbPUEUSmRAAk7ujCLw+BuBTiw1PGdKuabQ8VggE0i
	H1qi0dyaIkKQYKgely6gfkT1CNDdjUzGJNg==
X-ME-Sender: <xms:cZ8HaA8RmVRPbMcPNY6spE51dK0yiXL-alT-vpdXMJ3Gv2678mjlgA>
    <xme:cZ8HaIvZSY5ezYw2R2Dno_FdHR0ARLjDmxJyW_KxpeSI_8P7StOKNgDyb-iqityXq
    xu4SLWNwHWm9JqXHA>
X-ME-Received: <xmr:cZ8HaGDaaPxouplaQoovaNZdo3Lh3uEXlNDJMGMC6NHqOQlIJuSd65tzTHdw9M_R1ldEtKISdmCvCVm6sJFQZ29NkuwE88v4wdxZT0Rc0qc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepudevueehvdfgleelvedvtdduhefgvddutddtffeg
    gfekffdvheejieeggfekkeehnecuffhomhgrihhnpeguvggsihgrnhdrohhrghdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhrrghnrghvrdhpjeesihgsmhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cZ8HaAenOoLsHi1vtBXn054-OCHuqAvs3932Qz4bZiMY1Ei55ScLDA>
    <xmx:cZ8HaFMswW3sJSKTSJExeiA9ek5wHo7kroA76vC5SQamrssgpQ1jCw>
    <xmx:cZ8HaKkNfaAvgSMY-OOagLF__gnn3M8qGQkHYfapQ_wF0dhEGfAuyQ>
    <xmx:cZ8HaHs47kdDVrsp_bPWcjL4Hs2vzJsTZHE-hpcYvSg-eJhUksMW8Q>
    <xmx:cZ8HaM_eTsPfKj_yY7FZA_SFQgU2jBbiXQyHoG1zwE_zpLvmJ4JnZAy3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:53:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77151500 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 13:53:50 +0000 (UTC)
Date: Tue, 22 Apr 2025 15:53:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Pranav P <pranav.p7@ibm.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG]: backfill min batch size test case failure on s390x
Message-ID: <aAefbU-MmY_734oB@pks.im>
References: <BY5PR15MB35396BEBCAB2C559080F08C6A0BB2@BY5PR15MB3539.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR15MB35396BEBCAB2C559080F08C6A0BB2@BY5PR15MB3539.namprd15.prod.outlook.com>

Hi,

On Tue, Apr 22, 2025 at 12:31:18PM +0000, Pranav P wrote:
> Hi,
>
> When running `make test` on an s390x machine in Debian it is failing on 'do partial clone 2, backfill min batch size'
> Reference: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1102106
>
> After processing the command line arguments structure member min_batch_size should have had the value 20
>
> Instead of having the value 20 (--min-batch-size=20) it was having a very large value
>
> min_batch_size in `struct backfill_context` is of type `size_t` and since in the function cmd_backfill, in the
> options struct it is passed on to OPT_INTEGER, which eventually causes
>
> ```
> *(int *)opt->value = strtol(arg, (char **)&s, 10);
> ```
> in parse-options.c line 188. This is writing the data in the first 4 bytes of min_batch_size and on big endian
> systems this will lead min_batch_size to be a big number. This issue is immediately visible in little endian systems.
>
> Changing OPT_INTEGER to OPT_MAGNITUDE seems to be working on x86 and s390x

Yup, indeed.

> ```
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index 18f9701487..33e1ea2f84 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -123,7 +123,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>                 .sparse = 0,
>         };
>         struct option options[] = {
> -               OPT_MAGNITUDE(0, "min-batch-size", &ctx.min_batch_size,
> +               OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
>                             N_("Minimum number of objects to request at a time")),
>                 OPT_BOOL(0, "sparse", &ctx.sparse,
>                          N_("Restrict the missing objects to the current sparse-checkout")),
> ```
>
> But on systems where size_t which not be unsigned long, this might lead to an issue.
> So, one other suggestion I have is to change the data type of min_batch_size from size_t to int. But I am not able to
> determine whether a practical upper bound for min_batch_size would exceed what an int variable can store.
> With that clarification, I can a raise patch for the issue.

True, as well. Overall the current state is a bit unfortunate because
it's so easy to get this wrong, and the compiler won't even spit out a
warning.

> I am fairly new to opensource and was following the `git bugreport`. So I am extremely sorry for any lack of clarity in the report.

No need to be sorry, this bug report contains all the details we'd need
and is of quite high quality :) The only thing is that we've already got
this bug reported via [1].

The underlying issue is addressed via [2], which has already been merged
to `next`. It also fixes the underlying issue you observed with
different integer widths as well as with signedness.

Thanks!

Patrick

[1]: https://lore.kernel.org/git/89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de/
[2]: https://lore.kernel.org/git/20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im/
