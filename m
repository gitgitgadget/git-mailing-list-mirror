Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A21351C0B
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011812; cv=none; b=CHVM4mO7X1S1oyUmJq760LYmEYtDoxXRfhIR1FHZ6xTFBT9or65ZYIMk4but8gdf7Bq0HU8TUfnk0luTm0pMcIOLjD5PIuL8nYvPgV563wgZz1wfylrCDZBVEhMiFT6/A9EVLqFYwzr2v7FdlknsR7MIOHW6+tdkJYEvONbkrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011812; c=relaxed/simple;
	bh=5GxP8qCjuliIk2VMcSu/H5V6QJ59Ws9nnFEIbsgOtz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gqA7wIivt52btIzUtkOq63lk/fuhTrUhweEyEB459uXYz+p8jePpWA9rBmS4v/gPaX0GG1zh7pjziO+fy7QogKNICF96Mq4DXWbuKgOCgfGH9hucEMgh4i1vOoqxi9yUIlBBdRcRENV/lBafUHgPyfrTjWqnxyILAHr7scAOsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jcunmAU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFUJV0oW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jcunmAU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFUJV0oW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0F8C7A01A7;
	Tue,  9 Jun 2026 09:30:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 09 Jun 2026 09:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781011809; x=1781098209; bh=xj1i/PO3HP
	FPbs2oUK+OVDisfl9GVs6kIFvewbCMIVE=; b=jcunmAU+EhTPuXDXE2aBblikga
	m2+ptYi0n8PJ5VSsgbtpw13VvGmJtLzfavN+1x1wic32EfzSKhL/kIF+FziBBO0t
	puSWVtrytEAKBAcv1hL4ZNKMkkTF9yhGKU51wtMFkkIHy1o18A9BjdsyRHMEbiht
	3xO2gsHJ0QBBiqtTTUkd8Qfm2lgX3XT7Bu+r8ASC385XeRFa57AVY2a8fNXsIEX4
	FimaEcsPsFQ2I1qHaJAEiJSHTFAgvqt007QDxBjElUzfESMr8jGVPdk3QU32P0fJ
	du0ZZ55DYVl2oQm9XTQEWyMKf0iTX46mpMzCAbNyL+Cc+sKfHA0rKI8gdOvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781011809; x=1781098209; bh=xj1i/PO3HPFPbs2oUK+OVDisfl9GVs6kIFv
	ewbCMIVE=; b=MFUJV0oWAd3fcjHl8OlnKX1sOSslHuy+epbFBrLi/Y27OBBJoIn
	ne/1qqPYYu3kbSo4TB+/hu47LIqOLbfFHnKiUlJaqVhreLBIDGm/VD1Dvd7CRrwC
	19IbSV/HtClRhoWN/miwOehJ1aOdE7lWLL6bmao17oFc2s+04ZN7NjPOwDW06u2w
	1cKiWDiMExbTA9b1lVIKRqVHApFXF/cQv0hfQpGCuaoRQUg/zAR05GRiCywQgikE
	wSNrZslxJfylonDZcPm95PlSdUwhXTX+y5yDu3uSzx2yUInyyuim/Wsa5ZInXplP
	LpLNXPQOp53hdk6eI4QV5uEPEAKZsZB57qw==
X-ME-Sender: <xms:YBUoalAYUmC9oENHOBBMxEfStwlBC5j3zPJViC_RTBOY3NbFns6wkA>
    <xme:YBUoaofvGJznouMORvK33rIBb6l8c7-Dzp5kqrlr1ZfmQQHzHTYmPbdiNhworWhWP
    mmC0wwN-7rFs7t0XpBoj2zeTmH2GOgZ_JKLPwySn6GJUEY0PZeqYg>
X-ME-Received: <xmr:YBUoak12xUFoz-E9An6blR8cjjwmDNdqTFj-JX838TU1Qsgda1pPpjfrlyvbQLaFg4sJGoTtN0aaYddY4bctC4s0rEVFhFjnFM2Z>
X-ME-Proxy-Cause: dmFkZTED7s8CLbmnrm6AHAj9AV0LiUswWyu8jh3CPHWZCipQVlyrR9rhoQ/HJL8kv9+26l
    YSQ8PrZpEFa2bnSFfE/JtoLCm+V8FfW74nqK1V1Ne5+OTBCFYVJM4ZseOCGPrDrOxhimhZ
    BpXWpCP+P8dBMHURowehNoglwHAQr+RJ3IUQ4fUqs3FmIZCAEk4pEaT4nMqxJJwZ39nzKO
    /QTyec4HcfqgOD0tlaTS8m/PLHYJSsPjme8D9Qqz6oONGanuSRZdtaDKz7oCx5PbUTbcaz
    PVJH/54TBb8kGuYyHFD4Uem+9LfydCT3QnjSzhymdvHoN3Lto+CP7TE1GPRR8LmufMUXpg
    NMa1v82ufrlzUxuKfapZgpzH2u3hi+4076g9xLUCSRPb2INdhXK2BVMgXrHgIdoS+BKobi
    lhtMP6Z2H9oyjZx7oJfy6mj757KuyDOPClh6/NamnBxMwPfIt8Mwdv6kO5moPsQGAZdPiB
    CcYwuKqo0o1X/xpytAOYql8z+naaYd7lmkXY8c91tdd8THLQlYp/znkEJBwg7GnTjcgApz
    ZWGSjyH9MzZ9T16ALAfIImdYGwSto3rOFqa44AHPWpsyJ9F9PQaYOI3b8PHKAdTUVJAFjz
    ItdxIP4cjZqpP7H/PuT6TNInoJcfBLMKmRlyh+SPgtvsXmJ0/B2okkmhkwKQ
X-ME-Proxy: <xmx:YBUoavhC-k-nHpcuB_YeH1TSVDvlb8zHxJVcki7U3lRbelxrPxB-vw>
    <xmx:YBUoatlPYHsoBtfA2-g-yu16ivb6_2ekp7S1th9I-jvAsnTAQZGUKw>
    <xmx:YBUoalbcllFAFNBcNXJRDhQ87KVrDAhByPL7cAJ0_P1L2VcKTD6i-w>
    <xmx:YBUoaoFNH24hIeA_QWfiztjPITdoKOahIelW4ReY19eMfl0mevgEAQ>
    <xmx:YRUoanC2Rv-dhr0ymAceb8pBkd-t-HdLThEK7xC6IS0MlPVhWhvFbmcb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 09:30:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Tuomas Ahola
 <taahol@utu.fi>,  Weijie Yuan <wy@wyuan.org>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/3] Documentation: recommend the use of b4
In-Reply-To: <87a4t32a4g.fsf@emacs.iotcl.com> (Toon Claes's message of "Tue,
	09 Jun 2026 14:04:15 +0200")
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
	<20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
	<87a4t32a4g.fsf@emacs.iotcl.com>
Date: Tue, 09 Jun 2026 06:30:05 -0700
Message-ID: <xmqqh5nbsuxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Anyhow, I don't think it's worth it to keep bike shedding about this. In
> all methods we recommend to Cc people, I think that's more important
> then

Good point to stress about whom to involve.

> caring about how messages are threaded (for example, I've noticed
> LKML doesn't thread at all, i.e. `b4.send-same-thread=no` which is the
> default).

As long as it does not hurt automation, I do not care too much, but
that default is somewhat surprising to me.  The setting actively
discourages tools from finding previous iterations.

> Bottom line, for me this series is good to go in.

Yeah, sounds good to me.
