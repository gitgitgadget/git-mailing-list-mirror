Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CC2798F5
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523028; cv=none; b=dNw+yLAFj21yNAoPBd5VsByI+kFtWJeLDuA0azy8FFjWBhu14qwEk8Bw2gqL+I9UkMmFguFmYabQDkEhAzvR/ZkFxwVtYJFtJD8q+zyxhIvSyAp8XxWjWGiaiPJLDaK2z23PtLLksze6+1zzfph41HC4IxbZL6W2WsZjzcUaOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523028; c=relaxed/simple;
	bh=ZeSfVyx8rKteKxi+NFDK3pb02ShPSpkAesd7WLaUusY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dkkqo852yTy5vsB8lxpbjc/tjJ3MHkFIKHDRWIe8MO+h8gUZlewEfp0TMfGc3vkq0SZX1xbplcdX8wsQwR6mwZ/MrRMJP0qI6r32NnFtch3c9NS+xN5g2lvaPkxDZBB94q9EqJAetq7vleTuLZmJbfiS61Rk7siWjCi/XH3F7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NMDIKa5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGwYyfmu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NMDIKa5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGwYyfmu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C4CD7A01E2;
	Wed, 10 Sep 2025 12:50:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 12:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757523024; x=1757609424; bh=Nqhpi2lQhB
	OFOaq+J3r5jxbmXwFQCZ0EyQ4hdz5ONcI=; b=NMDIKa5pSmMvTr/CRFsI4Y7MIs
	sjfxxBFyO9DIvY9vnE9/f0Khj5LUWoY7mpdP+vuYP6wRaMPQoiIcqxvXGn3EWXHj
	EiTd4kPPxJbssYZRl70oEIPmNEKnKE43d6g55wokhf+9+ikTzRw+e+fPTJ+3PG7m
	aZ54DRbUTKGjZnDgnIXPrTwx8ASzYCR89AsuemLMQdCrGbR5lPbgVAo80b93tfRa
	yTofGeDM22jNptYY6VgwUhzbI+vevfbeRGIZEK0Zt1VXaUq+QgC6G+GHNLXu5xpR
	znjIz/6nlJqY1SpQvcPTKnkZKKaAgn/GlZryNsGXzHz6yQtdotcnqnsX4jrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757523024; x=1757609424; bh=Nqhpi2lQhBOFOaq+J3r5jxbmXwFQCZ0EyQ4
	hdz5ONcI=; b=lGwYyfmupEMLFl5snMkQJIY3hrNI/BJm2s7wsQ+BC5/C+eektPK
	rr+fKZxe/BuEBJoMdh+evdMl2r5cS7U3D+qSrCqaI97sg1POxmlamYTyP2lssFfM
	pXCRIJRsg6oJmb0VUtNi0GvL9B0Q+ighlqQEB8J8uXGI+GYMsMHnlh/GQ4bGTX+f
	QOrgCGUuKYITmXO/9u2h2h2Mb6km+JI0B57d3lH080xk+a29GrUmfRHHXn3r2WT6
	/5jAAaGuvvTvBWtG4rLE6puw6PlcqyWiTfwwqh6CUHD3/x/y25mwTlW/bvPqO+Mq
	B5hFhLcbbUBTfDW7Ir61/E+2KyusFyZMWDw==
X-ME-Sender: <xms:T6zBaAFBf02hcUoFFXs8RxVcGkG0QuwbhluhM79Zg_gt77slmhGPMA>
    <xme:T6zBaGNon6U9voyiOdKPBfXhrCB4z-pxSz7bbFMep86RzzkIAb3k-0ranwJAjYK4R
    p5_S8TQy7aTkaE3bA>
X-ME-Received: <xmr:T6zBaJ4Zed-KIC1YOtfsdQnQ3DJ4UgHwoqRmW-2wJCdaIHnviNuR-Mpg4n2EFQQXqEjfGjB4MoTpJMS-twBJvs_i1E1RVlZ8RB2odhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:T6zBaBgMvBb8DUcrmK4IgqsTBT7PikWBkhTg5UauBnjVTdJyS0gvhg>
    <xmx:T6zBaGdssKjQF0RKOYy-NPvwaEtJsTMcooleR8ZI6y9_nTSITE27_g>
    <xmx:T6zBaByufV492GIAVzCFODnHXe7Mh60g6QvRB1wlaqDUqIuR6iM2Ww>
    <xmx:T6zBaN0wjGdtcK8tlXg03jwnEB5PxZOw1V-LuJgVjOmiRAREwJtUYA>
    <xmx:UKzBaHTclmD2v1djWOm_3IkYAcs-JLWWdBeucaFvuBAgRAMFyErA8FZz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 12:50:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] gpg-interface: refactor 'enum sign_mode' parsing
In-Reply-To: <20250910080839.2142651-2-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 10 Sep 2025 10:08:38 +0200")
References: <20250910080839.2142651-1-christian.couder@gmail.com>
	<20250910080839.2142651-2-christian.couder@gmail.com>
Date: Wed, 10 Sep 2025 09:50:22 -0700
Message-ID: <xmqq348utfox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index c06ee0b213..3994a8f898 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -37,8 +37,6 @@ static const char *const fast_export_usage[] = {
>  	NULL
>  };
>  
> -enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_WARN_VERBATIM, SIGN_WARN_STRIP };
> -
> ...
>  static int parse_opt_sign_mode(const struct option *opt,
> -				     const char *arg, int unset)
> +			       const char *arg, int unset)
>  {
>  	enum sign_mode *val = opt->value;
> +
>  	if (unset)
>  		return 0;
> -	else if (!strcmp(arg, "abort"))
> -		*val = SIGN_ABORT;
> -	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
> -		*val = SIGN_VERBATIM;
> -	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
> -		*val = SIGN_WARN_VERBATIM;
> -	else if (!strcmp(arg, "warn-strip"))
> -		*val = SIGN_WARN_STRIP;
> -	else if (!strcmp(arg, "strip"))
> -		*val = SIGN_STRIP;
> -	else
> -		return error("Unknown %s mode: %s", opt->long_name, arg);
> -	return 0;
> +
> +	if (!parse_sign_mode(arg, val))
> +		return 0;
> +
> +	return error("Unknown %s mode: %s", opt->long_name, arg);
>  }

I am not sure if it is correct for the "unset" codepath doing
nothing on *val before returning, but changing that is of course not
in scope of this patch at all.  And the result of the change in this
function is very pleasing to read.  And ...

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 06e7fb5060..2f4f0e32cb 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -1125,3 +1125,20 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
> ...
> +int parse_sign_mode(const char *arg, enum sign_mode *mode)
> +{
> +	if (!strcmp(arg, "abort"))
> +		*mode = SIGN_ABORT;
> +	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
> +		*mode = SIGN_VERBATIM;
> +	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
> +		*mode = SIGN_WARN_VERBATIM;
> +	else if (!strcmp(arg, "warn-strip"))
> +		*mode = SIGN_WARN_STRIP;
> +	else if (!strcmp(arg, "strip"))
> +		*mode = SIGN_STRIP;
> +	else
> +		return -1;
> +	return 0;
> +}

... this is of course very much expected.

> diff --git a/gpg-interface.h b/gpg-interface.h
> index 60ddf8bbfa..44856cc55f 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -104,4 +104,19 @@ int check_signature(struct signature_check *sigc,
>  void print_signature_buffer(const struct signature_check *sigc,
>  			    unsigned flags);
>  
> +/* Modes for --signed-tags=<mode> and --signed-commits=<mode> options */
> +enum sign_mode {
> +	SIGN_ABORT,
> +	SIGN_WARN_VERBATIM,
> +	SIGN_VERBATIM,
> +	SIGN_WARN_STRIP,
> +	SIGN_STRIP,
> +};

And this is much easier to read in the header file for all to see.

> +/*
> + * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
> + * otherwise.
> + */
> +int parse_sign_mode(const char *arg, enum sign_mode *mode);
> +

Nice.


