Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A286143C43
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279846; cv=none; b=dYLWnmLq9tnOWMcfSGZQCE4a0aiYL94Juifmh0MXYTl9HO/coEfwdhpaEAolExy4ee6T7bnNshnR37AoMgBRAu5nFyetQLr5ji+tlHPNfu0Gk4wG4MrErNBz70p7l5BH5+6VoRL0Zftm6LxpF+lfPAPwMBD4md8xCXGSvZugav0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279846; c=relaxed/simple;
	bh=ULJ57p/ysH0TQLNiGqPwYHWnmWtJ+q8H4//ueW+K5u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixVJc/y9OOzU06gjJnXdwIUBDZzVo0Y55K4MBlO99sjTRNYcyQXErbbAgk0wOGLo+9n95quLeRoNuFlqPMmYhWckW5K4ue0qkrrmtBi4eAZ5Oqg4lwsTRG7XztxpnOCMOKP48V5Mbp4CwCmdGrucRponU7VmJAY+x9etyEKKAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8DaYlAd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8DaYlAd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e617b39877so4449962b3a.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710279844; x=1710884644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9H9nNG8OcC5oJxaalVTDNCOF2XM1uCeSpAHKbzTKJU=;
        b=t8DaYlAdMiYIP4RJUPmJfjanUXsSYygtACbmoxQSoHE+292JJkIiLFHeVDNtOOx8b3
         XUNglrEOz26TagkkF9AxFlfw9gkpsR9fTrwR3j3eaYJcUiSWMvU23+y6qzdgbkczA4On
         FBDtMvvZrw97ewGHrw9Q5UoYC2CGH/qV2xoacirVPqyyoE73M4HysCCdxBV2VeKhqYuM
         kKMXnfu5iuDRlxQDdPZQzmL/TvH3t54uicQfKxghssjUokNZikE9/EZSE/pfcR9CmX3O
         R9tOWD/7rZRAAulsJ5pfOmPLVx6QIu3gqD0OiFOpHzdI9FrBrPQUjrESMrhG27YThEie
         BYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279844; x=1710884644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9H9nNG8OcC5oJxaalVTDNCOF2XM1uCeSpAHKbzTKJU=;
        b=scV0XdNFVm4ecEXPylnkdpU2zY8vJ8R4vjNqv8g2iJ0O4A6OLFTtkvrWX0qMoD/G1m
         smkyUBcEabPFJlWHudON1CQbzV8mir0FBvo3Ogn8clf2mmwf/RaJx1Hxs7941aGIkf7Z
         X39cFOuKAMBv7X6RInSlULDRO6ZSu9qp62q0Ufpi70zBHUHyYRSusrvBXNtOpgiAcW5x
         uuFRWmgt1daBAu9shdEbuffsaXxwsz1RayDzciz45Sk1Ck0uSO4z70z+R3cFIts4IeQA
         dAk4ZlLVGFTNUaz2Axq+8+XRrkTh0DwNxGGV6rdYOMQ0Joh03GR044EfJ4wB5xnqzQQp
         h7/g==
X-Gm-Message-State: AOJu0YzCk/QNsENuFtSMZjb7D5UwR0n7EhhdEhmc47Z8n65kxrmqPUuP
	qJAGwhz8TW2MTitRKFubUCtsk+zzR9T+gfEAKwzAKEFAtl7yh1+tkuJwTr+h847lYnFJywdY/9A
	0Rg==
X-Google-Smtp-Source: AGHT+IGHLiWltKaj7x6qd8WTGHSblm9vNSOhbWruogemWeDPHkoudAAbUzRnOYokgpCGGN3bI6oTWQ==
X-Received: by 2002:a05:6a00:928c:b0:6e6:a8f5:6dc9 with SMTP id jw12-20020a056a00928c00b006e6a8f56dc9mr842727pfb.2.1710279844047;
        Tue, 12 Mar 2024 14:44:04 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:7646:f9ff:942e:a372])
        by smtp.gmail.com with ESMTPSA id z19-20020a62d113000000b006e6b2beb030sm660564pfg.48.2024.03.12.14.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:44:03 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:43:59 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] parse-options: normalize arg and long_name before
 comparison
Message-ID: <ZfDMn-3dKDQwYx_v@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
 <20240303121944.20627-6-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240303121944.20627-6-l.s.r@web.de>

On 2024.03.03 13:19, René Scharfe wrote:
> Strip "no-" from arg and long_name before comparing them.  This way we
> no longer have to repeat the comparison with an offset of 3 for negated
> arguments.
> 
> Note that we must not modify the "flags" value, which tracks whether arg
> is negated, inside the loop.  When registering "--n", "--no" or "--no-"
> as abbreviation for any negative option, we used to OR it with OPT_UNSET
> and end the loop.  We can simply hard-code OPT_UNSET and leave flags
> unchanged instead.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  parse-options.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 008c0f32cf..d45efa4e5c 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -382,28 +382,42 @@ static enum parse_opt_result parse_long_opt(
>  	const struct option *options)
>  {
>  	const char *arg_end = strchrnul(arg, '=');
> +	const char *arg_start = arg;
> +	enum opt_parsed flags = OPT_LONG;
> +	int arg_starts_with_no_no = 0;
>  	struct parsed_option abbrev = { .option = NULL, .flags = OPT_LONG };
>  	struct parsed_option ambiguous = { .option = NULL, .flags = OPT_LONG };
> 
> +	if (skip_prefix(arg_start, "no-", &arg_start)) {
> +		if (skip_prefix(arg_start, "no-", &arg_start))
> +			arg_starts_with_no_no = 1;
> +		else
> +			flags |= OPT_UNSET;
> +	}
> +
>  	for (; options->type != OPTION_END; options++) {
>  		const char *rest, *long_name = options->long_name;
> -		enum opt_parsed flags = OPT_LONG, opt_flags = OPT_LONG;
> +		enum opt_parsed opt_flags = OPT_LONG;
> +		int allow_unset = !(options->flags & PARSE_OPT_NONEG);
> 
>  		if (options->type == OPTION_SUBCOMMAND)
>  			continue;
>  		if (!long_name)
>  			continue;
> 
> -		if (!starts_with(arg, "no-") &&
> -		    !(options->flags & PARSE_OPT_NONEG) &&
> -		    skip_prefix(long_name, "no-", &long_name))
> +		if (skip_prefix(long_name, "no-", &long_name))
>  			opt_flags |= OPT_UNSET;
> +		else if (arg_starts_with_no_no)
> +			continue;

We only allow double negation ("--no-no-foo") if the canonical form
starts with "--no-". Makes sense.


> +		if (((flags ^ opt_flags) & OPT_UNSET) && !allow_unset)
> +			continue;

I don't think the "& OPT_UNSET" is required here, as we never set any
flags other than OPT_UNSET, but I think it's fine to keep it for
clarity.


> -		if (!skip_prefix(arg, long_name, &rest))
> +		if (!skip_prefix(arg_start, long_name, &rest))
>  			rest = NULL;
>  		if (!rest) {
>  			/* abbreviated? */
> -			if (!strncmp(long_name, arg, arg_end - arg)) {
> +			if (!strncmp(long_name, arg_start, arg_end - arg_start)) {
>  				register_abbrev(p, options, flags ^ opt_flags,
>  						&abbrev, &ambiguous);
>  			}
> @@ -412,24 +426,10 @@ static enum parse_opt_result parse_long_opt(
>  				continue;
>  			/* negated and abbreviated very much? */
>  			if (starts_with("no-", arg)) {
> -				flags |= OPT_UNSET;
> -				register_abbrev(p, options, flags ^ opt_flags,
> +				register_abbrev(p, options, OPT_UNSET ^ opt_flags,
>  						&abbrev, &ambiguous);
> -				continue;
> -			}
> -			/* negated? */
> -			if (!starts_with(arg, "no-"))
> -				continue;
> -			flags |= OPT_UNSET;
> -			if (!skip_prefix(arg + 3, long_name, &rest)) {
> -				/* abbreviated and negated? */
> -				if (!strncmp(long_name, arg + 3,
> -					     arg_end - arg - 3))
> -					register_abbrev(p, options,
> -							flags ^ opt_flags,
> -							&abbrev, &ambiguous);
> -				continue;
>  			}
> +			continue;
>  		}
>  		if (*rest) {
>  			if (*rest != '=')
> --
> 2.44.0
> 
> 
