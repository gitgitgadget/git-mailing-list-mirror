Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC551DDFD
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167383; cv=none; b=EA2XxPHRrRpmpUauii/fgcXzHNGcPrpsaVnKUNGO92SshJZ1IHMlOUFPrAZFsGyUnb4KC5Z4HGbSsWDQS0fwNbwbhPwgEqLAly1CnA4i9nAsXtak/3S4AodfsvZEiM/kB/Y4oXdGw/n/YdZ2z8UB75/ZVAIftEXGnQ1BdeIIPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167383; c=relaxed/simple;
	bh=pik1lhEDRrMIQqm041TkWTDJzDpSucePoXfKvUySFtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRGRHpPdIJhWHzzXy9ZsNVWqZTYcImURWKy99Oz+QWiYFF4p9UtHfz6YBHxXsVlKUQawoXJzul/nJlMCHFeikSPRQ0QLaqRR3wtMe49b56T69ThYkunotRA7IkyYFgAgFmOaJuM/cAJIsgjKoDcIkytYB0ibr9vtYlH8ux20/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gdv5y56F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x5RHgOlf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gdv5y56F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x5RHgOlf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 460B87A002F;
	Wed, 23 Sep 2026 08:43:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Sep 2026 08:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790167380; x=1790253780; bh=r1BiLt467W
	HT9rfx4rGQ3w+dBWCEGT6kuDpjrJricco=; b=Gdv5y56FDhqeBIHaOk2aw6MbNq
	rUlcMOa7TrFGxws4EFJILkIWe8UH94oO+Qn6QFx4dLDWUOMW6ea2O/LyguYE3n0U
	Tcu84A4F/xLOpxZok/eR6r4gMmxyTOSB6nimLzbFU5xSbgd3QFUvJ9LmzcfKKSWi
	F/xHfANHikXmiKx9L7q7gpyNq3Epigw0YkffdFzm07+mfHxv7TGl04/gcIcXzBd9
	e6LPAr60zGM6C2zBudqWvIf6Egu3hJRAU1lnJDWc5pd8YlKfYY8JmbMab2HcFR3o
	SjgmlJvFqBNw3O3K66byNHZ/EbrWjFfrNxmrjM38nWKwolyvFUVhTCu8k3TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790167380; x=1790253780; bh=r1BiLt467WHT9rfx4rGQ3w+dBWCEGT6kuDp
	jrJricco=; b=x5RHgOlffTYfpJvQ4OVKSvDvqQtq+Gy6jOFDRCNEqjy0BwhcWPS
	t0eE0jIeRulzh7ydUvZSf/++F2po1zYqnu5i5VnoOSacZ1E8adi7SvCGzkLoqBmN
	gkf4e6bg6PX64P1OCzmaPI5BDE1EFwlLwatBI42dHRNEjmt6Xf6Rr89RmUAavEsN
	D0w1RgUZDcj02NsVj5ktYeUkCzmOeG0NINXMSHn6L/seYnEh5LwOCRjOz/+LtMR+
	x8KRMPUfWCs0cJghYi47ssHb2kMgPFNOhIkCLwHNTw1PgxhWur7YuYGludAxJ+fX
	W88JpVlm8xozOTJX6r4ndz71BbrTodlOWhw==
X-ME-Sender: <xms:VMmzaqNjMDvKygWoA8dRMelUP2WXMd64WY7r8hMPlLoqJnub1pcWfg>
    <xme:VMmzav3Ej_zCOBoQUnTIxYEAf9i7JsIa1CH8gSoaWKW4bJydcdPCiJyqysNbgld16
    jCqgFWRweIMPtZvbfCVd3wgvYYTwtlr_qfOZu9wQt4Ty6u_1zbVSa_1>
X-ME-Received: <xmr:VMmzapnAgFbXNXH7ojBc8rLSGnaGSFTf8HUsNUq8VAIw9ii5zNvc7Q>
X-ME-Proxy-Cause: dmFkZTGtRJssjltpTnnohEjOacTnBokL4ViLaoWGuEiJbS3ycdroDg5HJ2BI7JY7rdxFkW
    pkKtOCkXcTtQZW1okBIl9yy0ncStbHt5JrGMY2g+kob2PYQsutcHBCNzr361dVQ/vQYxV+
    KwJVU30XyvU0274PwnBMhiq4lNw3ZcIbSDcxpyh33AwPWawYIelSJJlLnBIazyFRSeQpwo
    rGm5MJWmXNMquj3pQGNjtAkVcCdHIIs23htfOcHn6y12PgFd/cHVY99w11kR2snzp/4aJC
    IZ5ww8XCA7pwM2BDi8KHacDOWgI4urMr/NWl/YhbTUPsiHD+rfhVpcDcanPRyIiHqj5xrA
    hH3ElIdXEsbE90nHxmVO6noPCDMorusmPr3ecW+nkQkbWgsNy1GCPSQGPX7PhMOjnECrYj
    BjmN+CJ1S3UfIl0MUXzRXTrCmxru6lbttK/BBz5f9+Tjc31g3tTOCP2RC0YRa5heDG/qdC
    uLS/Y9jgCPonS0JEw3/1FUzC4kdyXXK1eRTt6GldN2B7hWMD7pGaNTns35AB6D45zmf7PX
    JIZfJV05UjLxoZXE9X3gEQkhGzQaE0IFCmMCfQxZFtU5dg0hnc9NuegxBldA19aLUzkzP0
    EZdyZyngNCTxyfudiXNjZe9v6f2JzCTuKqw8f9Ow2skWUfVbhtBkOc2vG1Rg
X-ME-Proxy: <xmx:VMmzamWhiEIjI76f_cCkUqnN26A0EVoYX7JUgizAGK19mG944BsbNw>
    <xmx:VMmzavsyX6mJNVVg5VaZFrtVo5QxDuZ1NnIOFC5e1RcBx7rfazscFA>
    <xmx:VMmzapaQtlK1bC4SJgvxm9acBonjjDPA_y4OXxf2bMRcBVM8z78FsQ>
    <xmx:VMmzauWbI_IJa0pq9vdcbqEsAM_q4xfvLd-NpjCl9Nd4PJrHK2s-0A>
    <xmx:VMmzak1b-sXmuuRzEu73WrKR9rlErz6WQIkb5E5pzUAIoOfHQbziwrIs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 08:42:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1dc9385 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 12:42:57 +0000 (UTC)
Date: Wed, 23 Sep 2026 14:42:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <arPI8PfvsKUJSypg@pks.im>
References: <xmqqecfez7ie.fsf@gitster.g>
 <20260915162348.97792-1-ggordon@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915162348.97792-1-ggordon@gitlab.com>

On Tue, Sep 15, 2026 at 12:23:48PM -0400, graysongordon-gl wrote:
> From: Grayson Gordon <graysongordon1@gmail.com>
> 
> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
> OCSP "Certificate Status Request" extension and any stapled response a
> server sends is ignored, including responses that explicitly state the
> certificate has been revoked.
> 
> Add an http.sslVerifyStatus boolean that maps to
> CURLOPT_SSL_VERIFYSTATUS. http_options() is already the collect_fn for a
> urlmatch config, so the per-URL form works with no changes:
> 
>     git config http.https://example.com/.sslVerifyStatus true
> 
> Defaults to false/"off". This is due to the nature of the OCSP protocol.
> If enabled, git would expect to receive OCSP stapled responses. If the
> stapled responses were not present, the connection would be blocked as
> the status of the server's certificate could not be verified. This would
> break connections to legitimate services that don't use OCSP as their
> certificate revocation mechanism.
> 
> If the backend can't check the staple, curl_easy_setopt() returns
> CURLE_NOT_BUILT_IN. The error message includes curl_easy_strerror()
> along with the option name, so a libcurl built without status
> verification is easy to identify.

Nit: I feel like this paragraph is excessive information, as it doesn't
give the reviewer any additional context over what the code already
states.

> CURLOPT_SSL_VERIFYSTATUS has existed since libcurl 7.41.0, below our
> 7.61.0 floor, so no version guard is needed.
> 
> The tests that need no OCSP infrastructure stay in t5551, which t5559
> runs over https. The rest need a certificate authority, a responder to
> answer for it and a server configured to staple, so lib-httpd gains an
> opt-in LIB_HTTPD_OCSP mode and t5585 uses it to check that a "good"
> staple is accepted, a "revoked" one is refused, and that the revoked one
> is ignored when the option is off.

Nit: Likewise, this paragraph doesn't add much value.

Other than that I'm happy with this patch. I'll leave it to you (or
others) to decide whether this requires another reroll to address the
two nits.

Thanks!

Patrick
