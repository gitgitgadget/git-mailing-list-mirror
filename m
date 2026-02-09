Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738632BF2F
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628118; cv=none; b=lo08dQlkBgQL1hXrB+tk5G3qs0B0qFTzPXhZIdakzVqZz+e8s2o1Sj1gFEdK8vIejJTMhZnkWQB0e7PvWexLm+NXpwr+5IlPzmXEqBTA8D1nqpHPp9bkyyO1uccNefAV/OWK7x6Roi2x31u+IJbwbkvh98kv62eA5/AmZlNt+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628118; c=relaxed/simple;
	bh=TlG2rLRwRFqgQPvB+UzHNxMX621T2kJSvCIH+HczjrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auztRbGiFsWlKn2aoGweKhV/6INmJaBupf8E75yD/ppwRSAXqaQGWxYXigBH1F1kNOeZgfkNro3WAtuDaxsMhK+MNMwyWdsKkjYSUbeexVZlodWnPJ4jOP1PXOf1CchlStmZt311XD7LU2y1F0kBaUaYBn+aJmOnCO+NcUx24uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UutcfBTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbRhfiPW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UutcfBTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbRhfiPW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 91DE81D00177;
	Mon,  9 Feb 2026 04:08:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 04:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770628117; x=1770714517; bh=BDscBYNa8S
	U5L4CWTNB5BbjINYI53jGeZsR7xEu93Pw=; b=UutcfBTOhGLph4GDO6EFNPunjp
	5lfFDnASoOgJHM8wJYqyCA0Nn+R/syvwxKeE8UlF4bxh8OkyP7pJTZJ9VsBmVdnV
	NGj8C4umEGEedGLnlT53LWgjmMXYmzJWPK0ABSXij0CApqUXKaHnYrDv07MhxtAf
	FhiFg3WrK5OdBLE+h2qelbncL3CpcAVG38RKQpdeolHgqNswIDgVP88eQto+yXp/
	21k8gudrQaAiDiiL6JVhu1W1sllmglxxbgTaAYU/m7RmobNDB4Dc9ecIb9Te5x3b
	pyhFuh6RylcGNRVK/4vY+7r/ybHRoprBfyvxnfRa4+jBvWgmeM7Kb+rD7pmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770628117; x=1770714517; bh=BDscBYNa8SU5L4CWTNB5BbjINYI53jGeZsR
	7xEu93Pw=; b=JbRhfiPWvkw2Z+2w6wTwSCCuRHYOGoe0BHJak+Sy2PcABp1gilI
	2j8j1ru20lDTEqmNi03M4IHfIRV2jOD/+OExXXsWGVjvhj53u2tkiF6TFtrUuIXD
	vqoIU+xN1ivWKVYHsSTll2U0j90PbNbOsGQmMdrCkPOsh7C3U+OzQWrMjERTc3PU
	qEtQLpd1voAHPnaNsfICrIJZLdpxc7XVprE2aB3J7KdAfMArEgbX3zLjlO869Pem
	+0J5nUnPzFKQmYhRhLHSv9SDL0xQicsg0FSdr1XzFm+ifbtvZwcDqDReM76mUFte
	3sBNKxU/VhmJfW65qwB1x5sOqyEqz9B0dyw==
X-ME-Sender: <xms:FKSJaUjUCXwSgpyMwcrAKOEEOx4ACIAgmvZVn9zpxBMrcB-UJSpQdA>
    <xme:FKSJaQtUub6O9eMyR9fAop8vkMtX_av1-490Kuru83esBDG4tYjuETZr2OGEhupvq
    Jb4Oj5TaWd-zMFmt1VDLuJy9sUnDJIHmN6t9ffuvOQSb96bB_jIeQ>
X-ME-Received: <xmr:FKSJaV4FUgMtbW1w5kO_Ad5HZ_lyhjyQltqSVYshNcVuLWJVrLMlWyIXA2_Yf_0ImbRoe48D3TD7d6YTRf46zKcay5HhW5RUSbykRWpveXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeigeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rghnuhgvlhdrlhgvrhgthhhnvghrsehquhgrnhhttghordgtohhmpdhrtghpthhtohepug
    gvvheshihtrghushgthhdruggvpdhrtghpthhtohephigrnhhnihhkrdhtrghushgthhes
    qhhurghnthgtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:FKSJacMsVHX78B_-hd4MaFNA3fe5jdUjJY4i95foHN1COPQeTu9W1w>
    <xmx:FKSJaTsQSFnPpbnxFIQnTC-Eax6YIL6TVmtmkUwdBHI4f3k_O8bgAQ>
    <xmx:FKSJafYJ2HED2SKqCqob6P2zf_fUF348SZSMDxtnX4YVaxTiOGQg2g>
    <xmx:FKSJaVy4vyKIBGrFKOsgDIrG1y0qMNO-dsGilkcTcX53hYiqOknX3Q>
    <xmx:FaSJaV1tT_y_7HiGYAJCBstH2oWPbELmS3-Fd-1PG0SAMnQQzjaW3HHK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 04:08:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba5c6c8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 09:08:34 +0000 (UTC)
Date: Mon, 9 Feb 2026 10:08:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Yannik Tausch <dev@ytausch.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Manuel Lerchner <manuel.lerchner@quantco.com>,
	Yannik Tausch <yannik.tausch@quantco.com>
Subject: Re: [PATCH v2] merge-file: honor merge.conflictStyle outside of a
 repository
Message-ID: <aYmkCLbhZPPjKqNK@pks.im>
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
 <xmqq4invm2dk.fsf@gitster.g>
 <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
 <fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
 <D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de>
 <xmqqqzqxczeb.fsf@gitster.g>
 <75AA7DD7-F8D8-48DC-ADA0-74E56CFF351D@ytausch.de>
 <3488DCC3-D127-465B-BB95-3D87BB2E48F6@ytausch.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3488DCC3-D127-465B-BB95-3D87BB2E48F6@ytausch.de>

On Sat, Feb 07, 2026 at 10:37:48PM +0100, Yannik Tausch wrote:
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 46775d0c79..f9de636884 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -95,12 +95,10 @@ int cmd_merge_file(int argc,
>  	xmp.style = 0;
>  	xmp.favor = 0;
>  
> -	if (startup_info->have_repository) {
> -		/* Read the configuration file */
> -		repo_config(the_repository, git_xmerge_config, NULL);
> -		if (0 <= git_xmerge_style)
> -			xmp.style = git_xmerge_style;
> -	}
> +	/* Read the configuration file */
> +	repo_config(repo, git_xmerge_config, NULL);
> +	if (0 <= git_xmerge_style)
> +		xmp.style = git_xmerge_style;
>  
>  	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
>  	if (argc != 3)

Makes sense. I was briefly wondering about error handling in the old/new
code, but unknown keys are already handled by `git_xmerge_config()`, and
we'd die in case we see one.

So this patch looks good to me overall, thanks!

Patrick
