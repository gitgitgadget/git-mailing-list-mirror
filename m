Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8B748F
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726147; cv=none; b=byVPiMjBnGqs8erXDZgJEbElkNbjo+vR+qTvG9Uw2kxVovNx/6pS3Mokl97q1SGxG2w+F3WhCu3ey+CEGRDVnujDxT0J3VBi30BM6/8s4Ulu4kE8r7pHgKtsEQWnJq9Mb3cwSof7bET8SaWaB+Z+w0CekT4onCeX1TAszYQ4bnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726147; c=relaxed/simple;
	bh=o1dKaS25/EoKwzRXaUx/mA5/rG4HsPDEqzhoHG7kFEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWa7l6J1BPHQrKv/+9NDBDQUMMf/AIBYR3PYQqCoqerqVWQlUHWJiruYYP1iyhRBPBpSrEdG+hOfe2cV0PqWyfdPLjjw9iRuJgsPVxtaLxvMyrTKhlx23SBPnK7TVE8j9buYX9peI9CwjnqKMGG4GqZenKX2DJAWRkEqFXwNA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cd3MWPs1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p495l1Dh; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cd3MWPs1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p495l1Dh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3573F11403CB;
	Fri, 28 Feb 2025 02:02:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 02:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740726144; x=1740812544; bh=fsmX4HN1x/
	muMtCYai774JlLaklT8lHEMaNAqjuCkxk=; b=cd3MWPs1wxCAaSFee7PzfvV7cZ
	yVY3lwPXwwrvMt14oAF5SuwWXd/dthkP8T26UrKBoa9i+k0IqIFset85WjQ/9zsk
	0Wl2kDN7r724toq5ki+mQ3SD+2/cGKRstKJ0c7Hfyq5arRTbybGhXvG0sqySVGjE
	fY6VWBy/6h2zoPy8nGU/vaB4TyoC2DXpqqq95lJAastr3ZTSBb4M1TYqbE8C6CeW
	nZd81mIPmq2PojUzpwrh55yhpR2K+QrxB0OBH4m1TG9MIPvlns+44jD3kG7jhOOI
	bNlhop41OBAQc5dHR7u8QRDb6Ag8hRYepeXw65Fkov2RHmX1w25ajGn8Aw1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740726144; x=1740812544; bh=fsmX4HN1x/muMtCYai774JlLaklT8lHEMaN
	AqjuCkxk=; b=p495l1Dhe2WdldJOBoSA2gxZFX9XAOwnX5myPQZTVYrq6sJXP7c
	42e7+8fY2I48PHl2Fa9kNeRW5CfuMHVFyOwKQtpxNSBo/tdxWi7s2gDaR3zVsqPi
	RUiuCUjaEKS60S+tn5LVkI16lqWGIF1j7agqh7WSTSBva4K6uOjkHVw8pWoT5GdX
	CRXt1L38mQFLtsKT51ErxWiJupYGHjfAY3SS62SCF/18C4HRf0g0lH+sCe1a0B9B
	C87/+gpC0PmePgblGAJa8SfHBCMtBliIXF5pSjDW1cXhaUj8u/fgExhOJ59fNV3i
	rvD15k+wxqZAI3eV7UYV3h8Oj8kJx1xSWuA==
X-ME-Sender: <xms:gF_BZyO9G1WWTa4hkEPfoCiP-WjlBlhgl7tQA_Tv51Tgio2yR4p0iA>
    <xme:gF_BZw8W9ybELnooA9qcWW2y_KERK2E9P3MG21ouoB1mIyKKvkRjFN9O98E4fRcIH
    g713jHe-RNfDuf9OA>
X-ME-Received: <xmr:gF_BZ5Q2OuQBF62INVO6ildQRoPLnjZkNXdSMOvCP6CGCkJq7c7PyVdDtGSNfZnbIzyuZB-cEZyGHH6jkeDl6AOkKfNYWTiChttRJ5FYf6pJHayD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhgseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:gF_BZyuhJWfAJqNZPSpyUWF_wT6vTqGfZ4R7Ky0Gc9M-jlQNF59Z_Q>
    <xmx:gF_BZ6cFutNhPGPgabqrn1kIfZuhnuAcSJH85UsMwzpKO4mdA2719g>
    <xmx:gF_BZ20OI9CJSwXA279SD_QOHjDe8xsVvkKgeqMbrJvdUouecsd_BQ>
    <xmx:gF_BZ--j_GLQfX6FNxoQyo8h1-3tOKRj2vwi1ufnG7Q-OWYbSr5wnQ>
    <xmx:gF_BZ7qAaxvdbKrs115-H-GcKhDQfR7Z5LKCQ3bgsqV0tV5berkpkYCr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 02:02:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac722f6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 07:02:21 +0000 (UTC)
Date: Fri, 28 Feb 2025 08:02:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Thorsten Glaser <tg@debian.org>
Cc: git@vger.kernel.org
Subject: Re: gitweb.js build mistake
Message-ID: <Z8FfeEDHZocWHKeM@pks.im>
References: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>

On Fri, Feb 28, 2025 at 06:34:43AM +0100, Thorsten Glaser wrote:
> From ed9863971d37ed53628a5871a4a569ccd6287f53 Mon Sep 17 00:00:00 2001
> From: mirabilos <tg@debian.org>
> Date: Fri, 28 Feb 2025 05:33:10 +0000
> Subject: [PATCH] Unbreak content of gitweb.js
> 
> The former $^ adds all prerequisites, including the
> (proper) new dependency on the generator script.

The commit message could use a bit of polishing. How about the
following:

    gitweb: fix generation of "gitweb.js"

    In 19d8fe7da65 (Makefile: extract script to generate gitweb.js,
    2024-12-06) we have extracted the logic to build "gitweb.js" into a
    separate script. As part of that the rules that builds the script
    has gained a new dependency on that script.

    This refactoring is broken though because we use "$^" to determine
    the set of JavaScript files that need to be concatenated, and this
    implicit variable now also contains the build script itself. As a
    result, the build script ends up ni the generated "gitweb.js" file,
    which is wrong.

    Fix the issue by explicitly only passing the JavaScript files.

> Signed-off-by: mirabilos <tg@debian.org>

We typically require plain names instead of aliases in the SOB.

> ---
>  gitweb/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index d5748e9359..2a8f97cef8 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -118,7 +118,7 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
>  $(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
>  $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> -	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
> +	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES)) && \
>  	mv $@+ $@

We could avoid repetition by filtering out any files that we don't care
about, like so:

    $(filter %.js,$^)

In any case, thanks for discovering and fixing this issue!

Patrick
