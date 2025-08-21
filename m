Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177C1D6195
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772173; cv=none; b=ba9LC8JnU80Y/IdVBqHkblfkQzI5oIz5r3gc9ZIgcKZre4YLAsjIVPTo27SESzlNgY7sWeaYQjlHCe6QjITEQsd/8qJk+bYL3tvQVgMXxisuWeT9mc3cBqfZdYmBXm6cEITMlH0500yrC7TXRuqIdmpdIJD0R7ZktNvx3O0f948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772173; c=relaxed/simple;
	bh=/h0Ce7evSCHH+6YeN4qruP3Zifu7dizTDS0T9LkFp/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWxPY8QPUwnPESA+sG6TsASPDbHhjxtGr8pECMcczfMlK5UGCFkHdq8I/sCyVnLhLVNjj63mA4xJ2P4BXHlittDenm7HOoBaCFTC5xHPYbD4aW9Jq1SJw4QtJTbwPriIsEIf+qzGtGBqWvAikmDdpMkhDI3UMopRtGgfBdbnCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fryQ33fG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2xue3P4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fryQ33fG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2xue3P4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A1BC4EC0176;
	Thu, 21 Aug 2025 06:29:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 06:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755772170; x=1755858570; bh=sPbg16CpO4
	DZ9VvvzBDWxe4FoQkicASQ6rxSGCL+hf4=; b=fryQ33fG8XW26gQILfS/hQLWz9
	nWSPMUleNfEE2qgP8wIDclzgUYwNL+MPLVN/GLvcEzSakqd15AbsMclRuZC5hWQE
	Q+Jw2OIUEcOOuKUXS9W/yMKTpXNRUr2bi84EaMN2+q3CM0haOSTptqLge1916n9s
	LDSdE+CYpb7b+o2h9SvvVvX2xPzzooSx+cqCq57yMtBk4lwCDdz9CLL6+Xm/JaGl
	QJswmUW9OYMfEXT5s2vsZHZ//FhwXbidvEok5QmGh4futZG9yzJv5M7HL0D/VlQc
	73ANeFH0nFAd+ztv8l98Vbk+FCm945m6OW0xO1mY45Q3L9rJZdUVClxDI5jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755772170; x=1755858570; bh=sPbg16CpO4DZ9VvvzBDWxe4FoQkicASQ6rx
	SGCL+hf4=; b=c2xue3P4JPvD1vHVqZ3oLxsNBDVxcJZCCJ0NP6rZOhYckl+KnwO
	bZt8LuF2ilqOyt89vg0gDNcSEv3GyQGDgXNE+g3JMtEaXeD+CC+/VyG3V9DAFPJh
	TR6HQlPSQD930Txp2udobZRHCYybHd4w8qs7W92TVu0kyzPA5rETXtBJYBG76VPO
	DAfNxzv6b1UeIGIXXxRE0BSgE0toPemZx/wXbIKC4fylrKQP+hfygdM8HZ5MJU9J
	3j4DjuvAdeSvysmd6TYiNQDDJo9D2bJehYepRdpHPGozHmhkNywn2BHeJErTOTjx
	bsP96LfOdA9JAmCX8Or9JA+wQjgcfiV+Kfw==
X-ME-Sender: <xms:CvWmaHy_zFVbT1PDVU8QHS9SNJtlPvDUYr9pgmtb7FtkdOfmNIm_CQ>
    <xme:CvWmaCj4BL-RB3ZGCSXJhTd8tNeZ_Bc66Mbq-m5rlZPg__uE2rMVvuwevPOj3dPZz
    5nrPHyZ4dI59g4l4Q>
X-ME-Received: <xmr:CvWmaKwcvCkTJ_mxleWQUjy48DNXm3NvxhdLBNX0fj-tjGgVEHFPbO_9vwIOTcRe-5OckBb-XNqQMnKN3pBldWWSxBCOjhgVbDbbeDLkuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CvWmaNI4zMfES4Sp2hKRFmNf3Fv7VggEcJmdy5gQRFWzV9XHiwJ6Pg>
    <xmx:CvWmaJReKhWdCEOI4fa-ZvAWE1jE81PiNx63ztSSu70QUGoW6vKnYw>
    <xmx:CvWmaNpGRgrSlgG9SsFkpXjAywQ8GGGcRdgnbUKWfif8nES2GiHQ_Q>
    <xmx:CvWmaGrHukPKY6Rg3zJUW8MjZrRvVYlPPQOHxRe7LN3QJ-AL7b9hyw>
    <xmx:CvWmaNd0sSojRDC1IzsWWJ2SXAB56gvc32FVO0XYCCUzsEL5k5LXf44p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:29:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a82c193 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 10:29:29 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:29:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for
 --format=nul
Message-ID: <aKb1BjPfmjBvHrm0@pks.im>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250820144247.79197-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820144247.79197-2-lucasseikioshiro@gmail.com>

On Wed, Aug 20, 2025 at 11:42:46AM -0300, Lucas Seiki Oshiro wrote:
> Other Git commands that have nul-terminated output (e.g. git-config,
> git-status, git-ls-files) have a flag `-z` for using the null character
> as the record separator.
> 
> Add the `-z` flag to git-repo-info as an alias for `--format=nul`,
> making it consistent with the behavior of the other commands.

Yeah, it's common indeed to have `-z` for nul-terminated output.

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 2870828d93..f2dc71193c 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
>  SYNOPSIS
>  --------
>  [synopsis]
> -git repo info [--format=(keyvalue|nul)] [<key>...]
> +git repo info [--format=(keyvalue|nul)|-z] [<key>...]

Not a 100% sure, but I think this would actually need to be formatted as

    [(--format=(keyvalue|nul)|-z)]

Looks a bit ugly though, so maybe the existent version is good enough?
Others may have a more informed opinion.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 8c6e7f42ab..b2ec66e454 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -115,20 +115,27 @@ static int print_fields(int argc, const char **argv,
>  static int repo_info(int argc, const char **argv, const char *prefix,
>  		     struct repository *repo)
>  {
> -	const char *format_str = "keyvalue";
> +	const char *format_str = NULL;
>  	enum output_format format;
> +	int format_nul = 0;
>  	struct option options[] = {
>  		OPT_STRING(0, "format", &format_str, N_("format"),
>  			   N_("output format")),
> +		OPT_BOOL('z', NULL, &format_nul, N_("alias for --format=nul")),
>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
>  
> -	if (!strcmp(format_str, "keyvalue"))
> -		format = FORMAT_KEYVALUE;
> -	else if (!strcmp(format_str, "nul"))
> +	die_for_incompatible_opt2(!!format_nul, "-z",
> +				  !!format_str, "--format");

Makes sense, we only want one of "--format=" or "-z".

> +	format_str = format_str ? format_str : "keyvalue";
> +
> +	if (format_nul || !strcmp(format_str, "nul"))
>  		format = FORMAT_NUL_TERMINATED;
> +	else if (!strcmp(format_str, "keyvalue"))
> +		format = FORMAT_KEYVALUE;
>  	else
>  		die(_("invalid format '%s'"), format_str);
>  

And here we then determine which format was picked. Looks reasonable.

Patrick
