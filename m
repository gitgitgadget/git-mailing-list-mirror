Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AA143750
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279778; cv=none; b=gnIEQFSBOdi+b5+WUQ07B2u1/jh6Aqs+LSrGfkapJkoGJ62Aqp1+FMxxfugnVgjJfRKsopcLwIHD1P1H2PQwvHUjKaz95z7s3OWs/St+QSeFs7pplrw/BqjqwdkJ97JNSI5QH0vQskL+68lSImB/lt3VlQ054bHG28xhkEzYGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279778; c=relaxed/simple;
	bh=olvTi/kOXGSZL565SaxB7et0HiC7jzsTYg7SJ49en4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGjIbMhe2H6kzogyzREtMUxwY+hgMSTlL4nEZHrzVx+iMlJFdXYOqmPN9jtx3GC4/0aRScQyDyAfaKS5YiE+uuhfduwwhuhasqPGeGdVtlqfBGkCOjgdQUPIc/3bFzkGEl4Rl8G/sVnaaFBpr7KXSpUjJBARlzizn2atMIsnymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R20p4bnX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R20p4bnX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc75972f25so3198325ad.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710279776; x=1710884576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5ZZYZud/0cf0OTTI2s3sX9vzvX9Af7wrVnFAWtTNLQ=;
        b=R20p4bnXY8E1i3Eq1202NsGzzVIWxpNewSiAhb/hSVZwIuf6ksBsj7EWFdFCFiT5/M
         UKss7lo42mhEIAAKR8lPQ5t+UEO5dnpJG4AcznUrdJ3IhKjv0NccHagt7NDEFifqxbeQ
         gK1Bb/hCK9aPJFuRs8ABRbImQ4CLFHQu7zq0MhjQqBXA/G+3U2aPjVsUB7+ff2n0gYMl
         ULG0WIzZyp3oWKTN+C2QMAIeCLtxGHHmW/zN0rzV2Vx/e0y5XgJGXBFmN0aycqE705m4
         bMP+snUpdQmejAWgniDDUqjHxkaKGEtuB8yVhGPea1V7GeGhvceWpEga+shDsQZlGrXG
         0AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279776; x=1710884576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5ZZYZud/0cf0OTTI2s3sX9vzvX9Af7wrVnFAWtTNLQ=;
        b=sADgLhJUgkFZirgYBC1d6ZEU/PRWd1y6Ty6AikN2296nW26SW+E8bc92QQAbkYV91u
         6raKqUltKRzv8ei9v7iJu+FVS8LQxXHp/m+B3Wi0mgSH5BbZLkNe3Rd6X5LAoufWaRIO
         C1UjxvUMvu4RxU0NTjWogINrrEfl5IcT5NjaXcnUntlFyvJys4FQ+RrRxRjr7CVelDi/
         kDaQzbzd/5xLVvetdfpHU6wS2Y19/bWnqK/HnFlhLP7EYen+bvkjQQfOMBlzE0GB8Prz
         jUmrUnWSMcT++bP+agddsOLatwYIqcv14ykTJlI4yVICn8D7yoAlonzM4GivbCMe+Rbj
         LJtQ==
X-Gm-Message-State: AOJu0YyQzQa4vN+JXyYaUjyoqlvXs/R+6I2zOW2Is4SvEKUPvZ84UaUA
	RB+MvJrvxBTwj2tD0CQ1QAparB+5o9ZXUzlH7PG4LTAup15+W8iaf2ydELWmBSIAUkYC8FQnsLJ
	bTA==
X-Google-Smtp-Source: AGHT+IHx6QbxrqTJivC4LG1+zIXdZ4TkgbKZxRYwPn+9PuSvDw55ThXyPmA/iZTMkaMNCMbBWpzOJQ==
X-Received: by 2002:a17:902:db0e:b0:1dd:7d6a:d6c8 with SMTP id m14-20020a170902db0e00b001dd7d6ad6c8mr5878505plx.14.1710279775904;
        Tue, 12 Mar 2024 14:42:55 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:7646:f9ff:942e:a372])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b001dd6ebd88b0sm5053759plx.198.2024.03.12.14.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:42:55 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:42:50 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/6] parse-options: recognize abbreviated negated
 option with arg
Message-ID: <ZfDMWoRuftBcg-19@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
 <20240303121944.20627-2-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240303121944.20627-2-l.s.r@web.de>

On 2024.03.03 13:19, René Scharfe wrote:
> Giving an argument to an option that doesn't take one causes Git to
> report that error specifically:
> 
>    $ git rm --dry-run=bogus
>    error: option `dry-run' takes no value
> 
> The same is true when the option is negated or abbreviated:
> 
>    $ git rm --no-dry-run=bogus
>    error: option `no-dry-run' takes no value
> 
>    $ git rm --dry=bogus
>    error: option `dry-run' takes no value
> 
> Not so when doing both, though:
> 
>    $ git rm --no-dry=bogus
>    error: unknown option `no-dry=bogus'
>    usage: git rm [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
> 
> (Rest of the usage message omitted.)
> 
> Improve consistency and usefulness of the error message by recognizing
> abbreviated negated options even if they have a (most likely bogus)
> argument.  With this patch we get:
> 
>    $ git rm --no-dry=bogus
>    error: option `no-dry-run' takes no value
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  parse-options.c          |  5 +++--
>  t/t0040-parse-options.sh | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 63a99dea6e..e4ce33ea48 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -391,7 +391,7 @@ static enum parse_opt_result parse_long_opt(
>  					ambiguous_option = abbrev_option;
>  					ambiguous_flags = abbrev_flags;
>  				}
> -				if (!(flags & OPT_UNSET) && *arg_end)
> +				if (*arg_end)
>  					p->opt = arg_end + 1;
>  				abbrev_option = options;
>  				abbrev_flags = flags ^ opt_flags;

So this part allows us to recognize when we've attached an option onto a
negated flag (like "--no-foo=bar"). Looks good.


> @@ -412,7 +412,8 @@ static enum parse_opt_result parse_long_opt(
>  			if (!skip_prefix(arg + 3, long_name, &rest)) {
>  				/* abbreviated and negated? */
>  				if (allow_abbrev &&
> -				    starts_with(long_name, arg + 3))
> +				    !strncmp(long_name, arg + 3,
> +					     arg_end - arg - 3))
>  					goto is_abbreviated;
>  				else
>  					continue;

And now we fix the abbreviation match. So if arg="no-foo=bar", (arg+3) =
"foo=bar" and thus never matches a long_name. We fix that by only
comparing up to the first equal sign. Also looks good.

> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index ec974867e4..8bb2a8b453 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -210,6 +210,22 @@ test_expect_success 'superfluous value provided: boolean' '
>  	test_cmp expect actual
>  '
> 
> +test_expect_success 'superfluous value provided: boolean, abbreviated' '
> +	cat >expect <<-\EOF &&
> +	error: option `yes'\'' takes no value
> +	EOF
> +	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
> +	test-tool parse-options --ye=hi 2>actual &&
> +	test_cmp expect actual &&
> +
> +	cat >expect <<-\EOF &&
> +	error: option `no-yes'\'' takes no value
> +	EOF
> +	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
> +	test-tool parse-options --no-ye=hi 2>actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'superfluous value provided: cmdmode' '
>  	cat >expect <<-\EOF &&
>  	error: option `mode1'\'' takes no value
> --
> 2.44.0

Test looks good as well.
