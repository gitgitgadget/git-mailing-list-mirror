Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104413F166E
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527659; cv=none; b=BBD5q+Cfrb8evzABzVu0FVcbDAcluJhca9G35vgPV/PWekQEj0WqlHfTF1/Hjx9QV3MHaeYFwYCIn/3a1wAwU5xlyAy5C1A91tOSUujTSJ+R87ARcroCMbZ52SKFyjVeGEWQOGObqLoXjzGq8EkpiJRR30rfl6/SQvs5YGd4lY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527659; c=relaxed/simple;
	bh=IxOx8JPM7WGUK9YScKUXewv5rJMD4tg3LkfBXIq7hc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdSgUOTMExIGbQu8wYHmqLbuCnFAxo+sq8I893Lpoa4mhiSXeoIhMF8Q3wapYqPLZ8fKtodLfr5bhmAvpl8JTmFcYoAR/tbOh35HqDNa3l0pg74XxMgFUjTav8JLN9rILeNugzhxwlledfHi8MjO6UvLgAW14eB3bF74058h0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KqubWOK4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fU+qerS5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KqubWOK4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fU+qerS5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CD717A024B;
	Thu, 26 Mar 2026 08:20:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 26 Mar 2026 08:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527657; x=1774614057; bh=fgwAnChsbB
	+cLaGF0fsfYtBqSf62PFJGNWIAiILBVSc=; b=KqubWOK4o0XqJBRgjmbM33ZaPZ
	HNQeov8E6Y+975i1qRhTEljlyEWCpFcQHJ2XM7VFa6zaRanNGQbIFtiog+s6kbS0
	1M+Gcuqsy2uJQQMB6Mgw5Jca8NvO4tZ7b5J6c+iTNpfZpGzZMCLouefhIjnnXSKy
	zUI3Vh52wKJPChd9yJTTZNrq8pLKtmM55iIcA+bKh2ifQJZfzNWWA4tYolCMPIpS
	QdzURzYlrd6f6O8zgRCUu4p+IuOC+qxj1ZMtp5bJqeXTco6IjMtMcwb97WkYt5Op
	RiBOIgAQyNOjg4kQF+lbqgU/ErGSsizIMkixxgXRO8w4wvyNvZJUYPOdZC3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527657; x=1774614057; bh=fgwAnChsbB+cLaGF0fsfYtBqSf62PFJGNWI
	AiILBVSc=; b=fU+qerS5046vNaeLn2Yug97M/Wz+DT5QeZjiNiB3b83VYLYsqZA
	G4Ba8xgPVLj+NKv9mz1QJ6YWIHxFBs5b+1HQZvgxUYtq3T48DogYDxeoJaNZCU2+
	wTZUtq3+cvQwLqA7RrOu5PaTR4LgK1uYnQsI2Y2wDcdGu92sW4nfXMA+YePAS1qV
	rUvdscFy92X0OUV1UG5eU04farcF2p+9lpgKI2TLUW9wcocKdfpGFa5V8Z8t8iub
	1z4NQT9zrMhPGvc57jF6QQoW2tYPEj5N7UqQtpgU13ae79e/ScvtZYmS5VfeiejQ
	kAwn7qpeQ3AZdYAoJ3Usn6Otnz6mkY7QgxA==
X-ME-Sender: <xms:qCTFach0W5mW1TH1U1IdkV0kMHiIsgZhyFbwpSuOgu5iwVzxlPRNOQ>
    <xme:qCTFaXRtCo4IRgDNZYibMnllI3O0EXTSTfppVF6dyRt56JRzvnKbVmhbo4ZtSuRtF
    ZJta9eRhXh3669EkhRf2MWvOOJ81-3x_nzdSb9aTsuVcnf_7aAn0A>
X-ME-Received: <xmr:qCTFaWWu-kLGOwlQL0v-qOGAQRF96C8YCvfMkUu-NP-fTu2r6jpN-jpIdJYtczHgQQp8R00vpV6T3eWHhrQroCza-7WKmxyU24IU2kCo1JgDCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qCTFaTRtNqfSy3wpuxDjTgvp8DVl_TxRaRffnI2sfIa_k6JcG_g8Mg>
    <xmx:qCTFaYkL7iP3Pfnu0erWAOLLAaJVi1_FsG1TbmX4r-_e30mi27JwUQ>
    <xmx:qCTFaR5fUe35yX9xQEqnu_Vts30LY6xw_U7SHh5PMh3HucH1yj-7OQ>
    <xmx:qCTFaWjPnE5JebnJ6PBEM61cLUJK_TBAEOIWmetS_vmLaOTcdnH4RQ>
    <xmx:qSTFaQAgwtryU9jpryOJwvdjVdF_Hdh-EamS5MAZ5taHoslykhdxLCbG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:20:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5572c202 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:20:55 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:20:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 03/16] urlmatch: add url_is_valid_pattern() helper
Message-ID: <acUkpJjHgYs0jqX4@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-4-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:06AM +0100, Christian Couder wrote:
> diff --git a/urlmatch.c b/urlmatch.c
> index 989bc7eb8b..a8cb6c3bee 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -440,6 +440,18 @@ char *url_normalize(const char *url, struct url_info *out_info)
>  	return url_normalize_1(url, out_info, false);
>  }
>  
> +bool url_is_valid_pattern(const char *url)
> +{
> +	char *normalized = url_normalize_1(url, NULL, true);
> +
> +	if (normalized) {
> +		free(normalized);
> +		return true;
> +	}
> +
> +	return false;
> +}

We could simplify this implementation to:

	bool url_is_valid_pattern(const char *url)
	{
		char *normalized = url_normalize_1(url, NULL, true);
		free(normalized);
		return !!normalized;
	}

> diff --git a/urlmatch.h b/urlmatch.h
> index 5ba85cea13..4e01422a02 100644
> --- a/urlmatch.h
> +++ b/urlmatch.h
> @@ -36,6 +36,17 @@ struct url_info {
>  
>  char *url_normalize(const char *, struct url_info *);
>  
> +/*
> + * Return 'true' if the string looks like a valid URL or a valid URL pattern
> + * (allowing '*' globs), 'false' otherwise.
> + *
> + * This is NOT a URL validation function.  Full URL validation is NOT
> + * performed.  Some invalid host names are passed through this function
> + * undetected.  However, most all other problems that make a URL invalid
> + * will be detected (including a missing host for non file: URLs).
> + */
> +bool url_is_valid_pattern(const char *url);

Okay, this comment is basically copied from `url_normalize_1()`, which
makes sense.

Patrick
