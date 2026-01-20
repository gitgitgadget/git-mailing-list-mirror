Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEA3659FB
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768889162; cv=none; b=E95+EY4pEFA84iJTR3u+rexkohd3tWF8plIQ0cIJCVh26cA2Uo1zzJD8zNuynHzJbLUuoR0s+yXXMR9l9Huwnu9yJTjPYQtnLEhg+663MQmiFKJ/YVAJm5Fz0STGI9HCCpiV1/lYG6Mp/apGhaBCAa01wE7nWwlQJ6SDnf5lwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768889162; c=relaxed/simple;
	bh=g9ah/znk+C9JivVeyTTMfXB9+jEHlPuOGBRMHFEGYkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFN0eDv5TnGycjJ3CaefzsBqBOMOdyCwS6l5vK/UmFycAhFz4UdyA8KsngbMgcaAcMeQO7qoTHNaQ6Fft2QjHiMpJSGAWVI2B3UbbgFscLvgC4UiepVp7eMr8DaGOvkWMDtuqYRVmVsWHIh1rw0INif9Gm4NJhUhXQoyys0YAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pe5L48ZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUxl/2aT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pe5L48ZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUxl/2aT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BBB5BEC0107;
	Tue, 20 Jan 2026 01:05:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 01:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768889150; x=1768975550; bh=ZKlDRjXl8I
	E0CkjC6+m/8WASTN0BEWmCi2ke3iiYPgI=; b=Pe5L48ZWENds4n5Rc0MbwcJ7RX
	MfCCN1iKHqy2QnVpVF5FVQw5+k2X3cjG8kss8UQRrAzTkjqzCKMFv7im9vX7qNmO
	VgeL5vYfDaCZAyyDWlphS+s//au06+7MtvZCuHW/H1tjJ9Ur+lh/2Pl8bHSn8zUU
	10JAdgpFob2KYN34h5gXvB09jzJjUdPiMRJph+i0ruRgjna1bksHKSq/TiCb8JHi
	X+P660+C9X7DOlXl+232Oq/t+gSuS4FVEnCj18wZ5k6RyZh//onIbRB0/m4q6GHR
	cbB+VeY4CYQJezN779KDjNh3L26k2RXdQLzjMjpwE/3Xe5SASXtENW1jJN+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768889150; x=1768975550; bh=ZKlDRjXl8IE0CkjC6+m/8WASTN0BEWmCi2k
	e3iiYPgI=; b=bUxl/2aTYBT+2N6HPf/E6xoak1JHwLNn7tLYCcah6HwPUhGYqon
	IqGrhGyOzGND6w6UXkzS4qiEiHvTkpa1CdoWB/FWJ+jTMDNl1R1PMyk4Uad1R1GN
	0G4Ql/jMFblN3kGl07cjiWZcuE1J5d4lk3bbi1bEjrt2YgBSKR9M30VcuyLw3BFb
	datp2G6XEawYemBah/tTjLTCeNUjXlQVZs4NFzHN+waosQfxNPB2biian/HaTS7f
	UuIjYpqoVo9fwCjAx2IT78g6lwpnua+GF1yz8JTkhUqszlcthF0p/cO9fpJVUML0
	6u3Wv7URuobAWJqSmUpt1fg+Icg2hAjNXKQ==
X-ME-Sender: <xms:PhtvaQzFluQECvYtFk-qTsTcjJlt0qtRJH_ZsB_wbsQbrPoG6IaUIQ>
    <xme:PhtvabKUd_N7S3oNtunwQ3HKYNlH6zK2AJxhmVqVTNq0IUriloaUJENzKAbl1PZdf
    PrfaHblQUYaX4lfbjRqkTxal85pUmBQs7mZYF13Cs0GYwpZJCiAfzs>
X-ME-Received: <xmr:PhtvaarOrCxZO7Q0MGJMZDlGoEv-kO9xhEIepZhiC8q4PF_hawlHRWC49qXfTKAeTnO4s42yx-Pfmkffs-VN73jYkKmXZHQDehz-L2eQcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghvihhlrgdrjhhnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PhtvaaLkmb12tjrsxTq7bP-F_UDw6N8W2q9DkNfGNLjstNiKJJohUQ>
    <xmx:PhtvafShXXRiqkSFi1voVvW3gzKYhkIa3WrZgF3k4qTPqQsXlnBv9w>
    <xmx:PhtvaZuGS5QP5Hz_5V4B_zoaveaEOFcQtUWrVuJ8XOuCdDpGEZP5WA>
    <xmx:PhtvaQbaNNZdqufDnwJsJVZIXIaHDl7CDDuVwIkLiJqIT60qTteh0g>
    <xmx:PhtvaWpc2iEJB3Jvob0b8BjvBu2dEBUY-TYXGER2DKv0uO58LvYca_3f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 01:05:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 939c2908 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 06:05:48 +0000 (UTC)
Date: Tue, 20 Jan 2026 07:05:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	avila.jn@gmail.com
Subject: Re: [PATCH v4 2/2] repo: add new flag --keys to git-repo-info
Message-ID: <aW8bOfVLcG58t-Uk@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119210932.68893-3-lucasseikioshiro@gmail.com>

On Mon, Jan 19, 2026 at 05:20:20PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 306d3fa2df..2f698c5253 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -29,6 +30,7 @@ enum output_format {
>  	FORMAT_TABLE,
>  	FORMAT_KEYVALUE,
>  	FORMAT_NUL_TERMINATED,
> +	FORMAT_LINES
>  };
>  
>  struct field {

Tiny nit: we also tend to terminate the last enum value with a comma.
The reason here is that it makes it easier to add new values going
forward while only having to change one line.

> @@ -149,6 +151,32 @@ static int print_all_fields(struct repository *repo,
>  	return 0;
>  }
>  
> +static int print_keys(enum output_format format)
> +{
> +	char sep;
> +
> +	if (format == FORMAT_DEFAULT)
> +		format = FORMAT_LINES;
> +
> +	switch (format) {
> +	case FORMAT_LINES:
> +		sep = '\n';
> +		break;
> +	case FORMAT_NUL_TERMINATED:
> +		sep = '\0';
> +		break;
> +	default:
> +		die(_("--keys can only be used with --format=default or --format=nul"));

This error message isn't true anymore, as we also support
"--format=lines" now.

> @@ -162,6 +190,8 @@ static int parse_format_cb(const struct option *opt,
>  		*format = FORMAT_KEYVALUE;
>  	else if (!strcmp(arg, "table"))
>  		*format = FORMAT_TABLE;
> +	else if (!strcmp(arg, "lines"))
> +		*format = FORMAT_LINES;
>  	else if (!strcmp(arg, "default"))
>  		*format = FORMAT_DEFAULT;
>  	else

You also have to adapt `cmd_repo_structure()` to handle this new vaule.
Otherwise it would `BUG()`. I guess the most reasonable change here
would be to treat "lines" and "keyvalue" as equivalent?

Thanks!

Patrick
