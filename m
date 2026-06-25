Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581596BB5B
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369343; cv=none; b=WtYnOt1u3NOIigo2OlRT2BDsFr8Ld9BoYcgSSuppuv3lKx/lb8XKAprPBcwkZg0v8auYfxtiTl3xHUle7ujecuCautSMSQEb+yJS/KBI6OdnVhwcKQwskYNFZDcGEDc8fVLQl8qH7VPqoh8oNKbZSobfgnKMhMiBAvCBw1abMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369343; c=relaxed/simple;
	bh=0aV0W+O8AChtMCwv1YdbuZTb6dx+qqiG0AxNLbvcA6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnW6HiKbcyfo820xMDgHPDrl5KJUo/Ihu2bpGvzi7hO01Kdy876aOOc85XZcDZJAwwuV31YXYmX8ARbzqTLcVInm9p9I8FoshL2L0V4ZnJBiUBV2saBU/1uEt67/s/FEqdQhNJMveJKS+bo8pB4Mx8vp+dYFpU2zcajgomyoTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WQTAyO2n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fS3I14GR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WQTAyO2n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fS3I14GR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FE0D7A00CE;
	Thu, 25 Jun 2026 02:35:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 25 Jun 2026 02:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782369341; x=1782455741; bh=nWdwuG+381
	KO2jJJZ7XLuWRiUx5Y5pdQjD4lfXF+J6Q=; b=WQTAyO2n0a83mpv8Ivy57fXfyf
	iN+tvZBeHJH2lj9b0oI45MaCIK/oUnb2dxOilRZhHtipi8WYRqLEXUD/9sDx26dN
	XrP8iFtz4Qrwau9nBjFIjHidzIIg3t7E2ic8/S/TbIPrr9+2ZEr9gYNwB0TQJ2h3
	VksIB6pZZ9T4u5nXB08hEzVrC9Q08dXi95T7g0aKX5mhAopxDQsYuvfPGocIZVN/
	mW7yY4Jrrvbck/HmrnU1ef4+CE+2h0qMD9ZqUYrGJGD9J3UaboEVrniAABZsWawV
	kcatSXyL08SBuAcmGqPbhJBpznRZAPKD4m1ivbrYLIGCzosDBJTr51KLk7dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782369341; x=1782455741; bh=nWdwuG+381KO2jJJZ7XLuWRiUx5Y5pdQjD4
	lfXF+J6Q=; b=fS3I14GRTdMIVLW9PwRIaY4tncyUMNmPAuzeNHRbLV3+pKPG7pI
	5c+oD7zw9QCspHcRnG4EvCLeCh4TkKeQK4eHR28yJWqLeIs23EhBRUtEEE2Od2Zy
	Ro0eu/pgUv/qy5jaM2tSBesofIgu9u/EsQs+rkqhZSOV90v9EIx7yWwUb0MqJXUQ
	5+IXEPBRkZ8FumHSaVgMZEe/MN5/xwnpY3xyaEAZobymRyq5cdCZ3LhriljQzNfq
	OQImCof7sJlOgs7DjM2Aw2HyJ6KePEeFPbNU/Cf1b7OHy4m47etS2AR+nMwM04xM
	Jj7pQNkTt86XMTcSfI+ouQ0SEHPYEmqpceQ==
X-ME-Sender: <xms:Pcw8ag6hjFAcVAfhJ5Chtbe0a9MmQ2Uq2Ry0pAtbbVJ4NPB19saJjQ>
    <xme:Pcw8ao7nqaQ88HrnlBIN7O4gPMduEU7L4Kd1mCaE9UCqNNaAgqcLo0WE7glJMnVbz
    4yUFFh6wZAJaHRSybo1jBgjB7esOb5f0egDuNdfcxZt9Ekhwm54>
X-ME-Received: <xmr:Pcw8akc5M8u47Bnx6WrAmskspc9y8-UbjWSX8C7kq42krB_u6-6XpLX0z3NTmC9ZpUz19gTUzCFEoYRDn8b4Ul2rzFZSHRpmbRVSCelRkA>
X-ME-Proxy-Cause: dmFkZTFAPhkoUC0kHphpIPFRZNVZ7cUpKz6Kgpae/Gl6igDqXO64PF3zYrmN/mC6wQyPY2
    SstG1ahHDvHSTzsZXKImHv9KDO7K5A3gqo9hbuHsFrqM3jNUF39VbE1VRCZ81wQ9+W6yl1
    l8B+YaV8djWGg3x7CLlZEFogTf8e6EPhZ9HJBumFB11Z9aIhzmKgiI5TmpkPfjsjmrcAf3
    5Tp+q5v4mpLIKaS9P7qzhxEV1UzpMrEhawhwa+tSePNZWw7Xp/p0ooPhwK+YlPCe6rn2Fr
    V0Roe+xMMmm9yvL0QNQvi0hpCLKe+aVtzo3FFnoGGP6zDmaLUvYjPzMJ6U2rj7ylUVuuDy
    x8/mfQ8AeV1y8zvSP0cdUN3lW1DRUiG2Y7N/7lc4IC/9ncNYjxVQ2LqFgmyNJqCIiKMDsE
    qwsHyCC6uS5B9hYf3Cok1wnJz1n+2IOYP1Rs15Xfcpjy23xQJZ+jDy4vn6t4Ton+mgmjiM
    QF7WnG4dBwK6qrIaGiAPXCi7UbnwVJevEayktD7xAWlSozT/oe/j2SJyogQe5gyrI1axEB
    q4NxAoq+CpcCv4ifW44l1eE0LYy8z0arzsr+a/2epzsGxUpCn5r8r3VQ7DTB0KvGQ1IkrN
    nRZGZqg6ufSEXsOGrqZBa28sDcMd0c5lY9vyrD/oVqMkc+Y2APYYOUNkncUg
X-ME-Proxy: <xmx:Pcw8akA72cKbJEGLBOSZy5_zQCTh8TNiCXponzjE6m2_iFkAVaqszw>
    <xmx:Pcw8av_v-u1bMnqbfe6_y8B6oRe-Z9XyNqI4jrR4ORtcm6Zr8sKiYA>
    <xmx:Pcw8anKXIXd5ZYFn0nkBTi_PO08KZBi_UkHwhGrpd-eH5z2pdr3VFw>
    <xmx:Pcw8agj7YOiznJSv-rLnIVBeKO7qgIKlhM17nw0FdN18YAsliwJtCA>
    <xmx:Pcw8augNUfwx65_loUuJnoaOLmfb09xmPuvKRAwKL4uBHNEXhg4e_dbM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 02:35:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0712248f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 06:35:40 +0000 (UTC)
Date: Thu, 25 Jun 2026 08:35:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 08/11] refs/files: lazy-load configuration to fix
 chicken-and-egg
Message-ID: <ajzMOViv2sIbLzS0@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
 <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-8-018475013dbc@pks.im>
 <ajxKh-IrC2EPWJnW@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajxKh-IrC2EPWJnW@denethor>

On Wed, Jun 24, 2026 at 04:36:28PM -0500, Justin Tobler wrote:
> On 26/06/22 10:28AM, Patrick Steinhardt wrote:
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 79fb6735e1..d0f379dcd6 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -84,12 +84,14 @@ struct files_ref_store {
> >  	unsigned int store_flags;
> >  
> >  	char *gitcommondir;
> > -	enum log_refs_config log_all_ref_updates;
> > -	int prefer_symlink_refs;
> > -
> >  	struct ref_cache *loose;
> > -
> >  	struct ref_store *packed_ref_store;
> > +
> > +	struct files_ref_store_write_options {
> > +		enum log_refs_config log_all_ref_updates;
> > +		int prefer_symlink_refs;
> > +		bool initialized;
> > +	} write_opts_lazy_loaded;
> 
> It might be nice to leave some sort of breadcrumb comment to future
> readers to explain why we lazy load this configuration.

Fair, will do.

Patrick
