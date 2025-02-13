Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E828A2C1
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481461; cv=none; b=ewJP5teKqcgM/RzHfeHR7R+2Sd3txRPEPg7209dewgKmp4BJjNJYvGdvfa5K/IKBP8Ij8IWMapP2LXR36DVC658Vj+rYyCKhIHIiE0T0QQHT+Ha1tdI4eCHWb6cMmm+EBtHIcBrEEito+OAnwGesnznCeN6DEgXYYzeHGlVNUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481461; c=relaxed/simple;
	bh=+Z2L+eWBEJ4V2+Djzey2MfdHXarNvmYs4KIlWug9zlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDMskRizNbtVaPUtyiOI0Y+HFD//ZPjWkvhHVQD/FVkZh3w5/cRAwZ8I3nHtpEwz85nMn+iGfIFvqu1YTfdTc2xZUnKaEJrOAiP1qIJDciZG+XEQZWYJEUYO8oAMuYBnM3yZQ+rJDAHoDBsyZDCLmvLfu+8oFxtDJBBAMZMu3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GINx/i/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQZocS1i; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GINx/i/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQZocS1i"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id DC95D1140155;
	Thu, 13 Feb 2025 16:17:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Thu, 13 Feb 2025 16:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739481457; x=1739567857; bh=AfKFceJrXz
	iauuo+vDKjVxR8EiLmEfUZY2QOvgHiQiY=; b=GINx/i/c6nzP+ANr7jYhqjj45z
	C2KmTfev8FsiB+RNWqYVjJGZ9GZ2Hxdnmo7ItjMwGEGJ88d/K0W0IeuG9iHH6/lh
	Q3/2ElRg5ciVOvglOmiHMqkrlUujGrOQn1A3/WZsNfenwLj/SPncWEaGWlxJA+UI
	fVxUQ2ocC1cwKIlYr9FtqFQHmRMEyqXCS9AmO7eaixfb6aiAkIb4M+CLbpmXL4PD
	s8RNQF5nb0n+qOCAomFcWm0TXYDJOX4iNc3O1lh/0PP/JIaHBIQY9zIgIzDF6yiF
	F46F+VWYQNwKd7VtycLkMF56DH+54aabLzWFwlsiL0mXJ8v0u2YLLcGyewlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739481457; x=1739567857; bh=AfKFceJrXziauuo+vDKjVxR8EiLmEfUZY2Q
	OvgHiQiY=; b=WQZocS1ipu2qpMF6eHIyauA8UpnNb0HD/ORz088PKjZ5/zWw3CN
	wdl5NcdHjMhi4TsUon3LgaO+kGTRpm2M08AJs8WIRg/QtbJAyCTHfIDODkuljhuO
	F2LnDcMrwWHbbshynsqfJV77s271i0t4v3NpyaTjsPUIgYMbottIqE+Ij77JRi/q
	Uni569yEfJubzgzS8e/V8sid1BIpGk8MRlzcUznGXTu5ztoIbiaIkshUVj+0UhwV
	vvfAVYOmSXPqKOOx795Ka6fJk9ZfYw5lEbXjsv3x5zWkTpl3Famk5LsuYLBVvMIg
	aeC0UAbkP2APHXXpF2wA6FybfYS8ocYh2xg==
X-ME-Sender: <xms:cWGuZ6UTwiiv3eM2WQQzGc5atDyTig2W2yrz5JAl3O6FOtkCvT_srw>
    <xme:cWGuZ2m3WjIktxkjKAL5GgcYWOwUrOhKbfAsMMgaIEnsjwwe18Ly9NuLIXk4k-iGv
    a7xf4ypGswvKj1yuw>
X-ME-Received: <xmr:cWGuZ-bFlAtLVRguy3UN3lyJIeIsOOTn3HeaVLk8iLaJYw3kncAt0XZlaeLflLDBwvICfLYFXTLgbeCbwm6LzFvRh1aM_NYXiepuDRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:cWGuZxVTEMGlNnvS2iCIbtFRQ6cFAxG7PsGITXD8VpS_Sk40DFLOAw>
    <xmx:cWGuZ0kCOOi1FlM0ZizFuU7yc5ag2rwZXuM_BremWPCgfstzE8VGLQ>
    <xmx:cWGuZ2crGRx1zt7RWhdWlrAM-QO-IPxO5uCwU_dc4mAuRqq7bkRsPw>
    <xmx:cWGuZ2GWR1v45OQl2EYyadgzdLiYhsMQxZ5KcV55bYo_tCLnXMIUlg>
    <xmx:cWGuZ1Awl4pAlZ8ILH6crTNZCAmcy2FuyaNrVjgTvZ-TgwkOF10mF7n6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 16:17:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] Makefile: remove accidental recipe prefix in conditional
In-Reply-To: <a79e9e9f50410721d85747b03559d55be98bca20.1739478347.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 13 Feb 2025 15:25:50 -0500")
References: <a79e9e9f50410721d85747b03559d55be98bca20.1739478347.git.me@ttaylorr.com>
Date: Thu, 13 Feb 2025 13:17:35 -0800
Message-ID: <xmqq1pw1o87k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Back in 728b9ac0c3 (Makefile(s): avoid recipe prefix in conditional
> statements, 2024-04-08), we prepared our Makefiles for a forthcoming
> change in upstream Make that would ban the recipe prefix within a
> conditional statement by replacing tabs (the prefix) with eight spaces.
>
> In b9d6f64393 (compat/zlib: allow use of zlib-ng as backend,
> 2025-01-28), a handful of recipe prefix characters were introduced in a
> conditional statement ('ifdef ZLIB_NG'), causing 'make' to fail on my
> system, which uses GNU Make 4.4.90.

Yikes.  Thanks for fixing it so quickly.

> Remove the recipe prefix characters by replacing them with the same
> script as is mentioned in 728b9ac0c3.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 90c9662ad3..5b98a9d12f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1703,16 +1703,16 @@ IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
>  
>  ifdef ZLIB_NG
>  	BASIC_CFLAGS += -DHAVE_ZLIB_NG
> -	ifdef ZLIB_NG_PATH
> +        ifdef ZLIB_NG_PATH
>  		BASIC_CFLAGS += -I$(ZLIB_NG_PATH)/include
>  		EXTLIBS += $(call libpath_template,$(ZLIB_NG_PATH)/$(lib))
> -	endif
> +        endif
>  	EXTLIBS += -lz-ng
>  else
> -	ifdef ZLIB_PATH
> +        ifdef ZLIB_PATH
>  		BASIC_CFLAGS += -I$(ZLIB_PATH)/include
>  		EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
> -	endif
> +        endif
>  	EXTLIBS += -lz
>  endif
>  
>
> base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
