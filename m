Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89040D58F
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765650; cv=none; b=YxhHvIIWqJ6vswUSyvu4D7LwGwnwOdGljwlUC0Ld5p95D+pYggs5kUCfwCpbilBBNzl0c0AzbCJ2lUBAE3Opmj3laaPjPCKMrY4iKGDRoG1SguNPWIPS4p93zUCJLQcOdWh7SPcoMA+TCgSd6IT3PzyjHB+bJsPlqakQEZX18tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765650; c=relaxed/simple;
	bh=GRmjSj8ZkplyYYOLDKF/c64PYGdcShXc4AuN11mCGzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjAkls8S9mJRFxn1wfztMYgKBzR5q9HmiB7kxgr3BZ18lQqt6vsGlSwKapJEFFm1MW4249GekuUH/Qr7xI4uWypdFswMo36FgXk2ftuT+vZagCxZXA8FWYe2roC6mqyZaWuj0Arm2AkzGwzqv2Ekm70YWDs9DI0xR9+COTPG66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZxiCwGxv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZcwxrB2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZxiCwGxv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZcwxrB2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFD587A0138;
	Thu, 18 Jun 2026 02:54:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 02:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781765647; x=1781852047; bh=6ga6j5L4oR
	fjMqYEdJUbn3sWAd4XvUC1PKqPjZ/BYNQ=; b=ZxiCwGxvkDkE34tHndiH/ldo3a
	hHjzhnYyrA2slImfYQm6d7caCdCDuhIHA5zo8D3ZNXntG4SdTCzpQ1Em8eFtEoO+
	g9DIipxk64atpm3z0A++/4f9gp5/oPvRAzpWokqfxa65b37hnqkLAfV2kGL8RALR
	w7dw7LTv60gG5pmLYXf5q1qELfNFprFirAArgZWKQPo1+NPusWIjc20PmMWv66ke
	6JxWW6RObYoKp2v6qnYNLVfmfC447fKz3MVt4XLA+ZffbjWwChtb7YJwMCMA0+EY
	G6wl1wJIFZ5mB7i3/AzCZoURmLQFy3zNaFLpOOtZqJxcfceQ8OqPPMO1me3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781765647; x=1781852047; bh=6ga6j5L4oRfjMqYEdJUbn3sWAd4XvUC1PKq
	PjZ/BYNQ=; b=PZcwxrB22pdi2ZoA8i5E6SgEN8ofTiwlsx/SSrqrrshy6lHOKXa
	zysZx1W9FHyiW8DFDbuX6ddDLyARkE8G2iV6Gk9vVe88gIpZUPBrteh4HS9SOrt0
	OXtQQ6iSjfMCKIAnXWVKpzjg7V5SiLTmTx+1dAPpv7eZ7fiLJuGRX6d1FR4nWyKk
	nlxys7t6FaS7JBh6rKXR8DTSOzbt5ZvknP3oV9p0aS9JZCSgMpa3XVy5rqmYTrIS
	dRfbH6RseMOia90JapxBvUbfUJYdqYreFCgsFzSYFeV1f2fSJjBsK8WDWYNsGIox
	q5qNPYZqFewGsSj1pAg/+X49WEnt0SzjBEw==
X-ME-Sender: <xms:D5Yzav3lr11gxrC63hYbkW0K-B8XWZQBrE9RCV-pOgdBzh0s3t7WDw>
    <xme:D5YzalH78LpYocleNQDQKa2QvvtWD5fb_SQx1LWH9U43f3rR-TVU7FSl5VRwTYCoM
    OX9MT-_CTQTn9rpXosHsacyhAL04dpl1FB4-vRfwdSHwsKQ5ySaUg>
X-ME-Received: <xmr:D5Yzak7V-3S13rNQbRp_pWFJj9I5B0PKxlKLhaHZbqxhCfphVi70cTJOYzYN6jKVRXeHcMCd501MD83YT9A4viotKRyQ94fkuCPHrv_dwQ>
X-ME-Proxy-Cause: dmFkZTFJvsQ/e1JuJmviG9AB3wvQkoteeJ8ofAiJeiXOryqiLBKPFIerKjRNUtZ9CpAwXY
    SEaHO+JaMNVlGPmzgA08HsBQTskgYvrF2Vq9I5dmdr/UdlJ/Fm8kC6CgVpnyVbDmulINFG
    KZH49m5HSpl2tX3KfQLf4WxnrfBw8wHKygroHJZaqkCLjkHOJ6sxjkNUyD12comYHi6QYS
    /g4QCruM5J7YxIAG3Mg8d+oOsnc6LIwrUT84WFRjCY1RkJbnHS6TxOXlEI8+JRvbvB/C95
    Q6FpUBqETAhgRgIXJQfjnWAXQuXIdecvB2B9bRN9VSOfoebBHvvelsCOSNz7JfxnPC+Sfm
    OVhIc9ENCJv6rjyEYgIr2gqwLcf/m3XmETu+XhOh7Lglt3xVjBM196HC2EonSzobtZmEbN
    yFvlkMUlHgpEIsnKs/TBH2Rd3VKSh5zB2DCoeVL0q1UJOgPLD9gIwUd88hZMLKxztxNI8E
    Fv+fTNWuCm4yQ1GyBFSBz/YsWBIrwS4XKG8Nt7pYXJPGDJzBp/Ri5HRE18mF/Onmbc2Ypt
    CuMGLT9Z4mtzTJESsDNSyy1DdSUCzGNYiR4ButdHgEfofaOg184ziCUhlQ45fLwEqfqHZi
    xy1sTDaLFKueipomCOpxJpTFl3aTKH0wCjFKZJSjfUdcs+VxKIwECegIfvEA
X-ME-Proxy: <xmx:D5Yzajv05TF7gPPSGCpPMVylA34gfY2cqb4upjyci46_-9eg5HZiZA>
    <xmx:D5Yzat40-9X8j4sR0B9sGJCGz2TRT_rX36AIiushZRxgHawNy-TaWA>
    <xmx:D5YzamVEs1w7Atu8XfIqUgIEvto0gibJAdSWrinP2nAb_KbePXOu9w>
    <xmx:D5Yzan_wzbLf-J1AxL86TQ5hfS_JNsY4UTV_sAz5DawOzJn5lzOkxQ>
    <xmx:D5Yzaj9Kz-2FQ3r67cZf-iOQ9YcpYWz6PeukOIHOXTqYc4G_Q_itXLFy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac42d2c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:04 +0000 (UTC)
Date: Thu, 18 Jun 2026 08:53:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/8] setup: don't apply "GIT_REFERENCE_BACKEND"
 without a repository
Message-ID: <ajOWBVqNVlS7grtG@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-3-f4854aa99859@pks.im>
 <ajLapsLze_zF-dsS@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajLapsLze_zF-dsS@denethor>

On Wed, Jun 17, 2026 at 12:43:02PM -0500, Justin Tobler wrote:
> On 26/06/15 03:56PM, Patrick Steinhardt wrote:
> > @@ -2030,6 +2031,24 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
> >  			setup_git_env_internal(repo, gitdir);
> >  		}
> >  
> > +		/*
> > +		 * The env variable should override the repository config
> > +		 * for 'extensions.refStorage'.
> > +		 */
> > +		ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
> > +		if (ref_backend_uri) {
> > +			char *format;
> > +
> > +			free(repo_fmt.ref_storage_payload);
> > +
> > +			parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
> > +			repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
> > +			if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> > +				die(_("unknown ref storage format: '%s'"), format);
> > +
> > +			free(format);
> > +		}
> > +
> >  		if (startup_info->have_repository) {
> >  			struct strbuf err = STRBUF_INIT;
> 
> Hmmm, we only invoke `apply_repository_format()` if we indeed have a
> repository (having just GIT_DIR_ENVIRONMENT set isn't enough). Should we
> instead nest this logic right above `apply_repository_format()` in the
> same block?

Yup, that makes sense indeed.

Patrick
