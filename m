Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B815A47
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731761373; cv=none; b=GJLyOblazIT4mM23KlnrE1vO3S7f16gD9jlTXKhz9F4F4TFcnXm3rufMtVLviUyGnXuPsjSnSqUIP2n4JH6CtBybSc7zIQsqihCM/ltf7Q0bb1vnbRyrVkUg2CRm/nuBHZN9xUwuTK0IyU7cvf/0qLaXYvse+53jZuMmEP1a4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731761373; c=relaxed/simple;
	bh=RbCafr+k3CcgYdHrONRy76sonjRqR4xK3TAK9WsIVSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa3lQoUAEMcHLAMRvBVYNSP9gwHor6QHap06Kf5bi/tM2hH7e/772E9S8xhGH1zQn3yUim8kvhizrU1R4xTsb9DMDzNMh9YC+HyAdbs+ChqChQImQC9SCghTEam3qtv8FOavejHkQXIwd0r/U9chR0+0dHgxFhHeSpuSnsLolN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVZua4Eu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVZua4Eu"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ea1e5fc65bso355719a91.3
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 04:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731761371; x=1732366171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0CCd54j+cwwpuyRfIk3QEzJXgOlE0tX96I8u8WIDcbY=;
        b=QVZua4EulEIsIWXgkzHBOVYyT8F8mUol7aGaCFk5QMN8dVWO+fwLPZS98+qMTxaPks
         3YsSuaxkzNZfedQHCZCT2B9Ign2xcdlfSd5oBB1mS2l0Bs0o/79Ikm+LBHWEp+xtamVO
         8qJzcN2+TEpXSVEE9fpMdAiMH6b3wfGJO6bbjjNgsGcMyaKCVZtBmruEUCrocGkvc5FJ
         SxJZyxZqyaorA/uNegVYgYeqm6ENIVXccXX9MjyTM/w0bRUNntF4QQ5fe5H/PG0D1X9c
         kD3xO0mo2iDexazJneiwD/WKMzG5t0kfPeFx0bL0BsDzJ6xBCwtgdaUbKgVj53TlSlvq
         uX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731761371; x=1732366171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CCd54j+cwwpuyRfIk3QEzJXgOlE0tX96I8u8WIDcbY=;
        b=FsjFgidvG/D2OSbRVice0q9jD+sZkxaXuOh57PtICdXIrpzkn0J58Tee0Yjf+ObYen
         Wxzvhv9TP+hiD6L+ZPvXdX4Xd29kqKuIDumejyYzrX6tXq304fEhRxTkToIImydNdijz
         gBsLc9nm7Vxex2BgfZF4niFTwK6c1BgO3HMKj5PpePId9toedNQoqNDYXEGQ5zqugCjp
         qdwucmGi4G2COkynmfyiGG/3HYbuNeZJzlRrEJFOyuUH2TVbXezRdGclvvC1ejzaUlDz
         cvvN/d5sS8JA78/i4RCjKb81oaRJyTIzvhmsIaoEVM5jsZzM5y/paNuiNp4LoDQIV/Mz
         ooGw==
X-Gm-Message-State: AOJu0Yya1pnFbhPnhCQnKKsTK+tu63gj8tcHw7kml7+v36AmSy0+eoH2
	2ivKqNvoSHpOkG4eAi3ps67swYoScc3VcHM3LmzRKmvyLGxvAyAX
X-Google-Smtp-Source: AGHT+IFymQg5tPgaV+iHlah35x1mFM/AuUXLubFYv4TZplja2Y3QOy5KBm3CF7Nf+NuGJ66aXFpBvA==
X-Received: by 2002:a17:90b:1344:b0:2e0:9a63:9017 with SMTP id 98e67ed59e1d1-2ea1559acb4mr6782378a91.23.1731761371335;
        Sat, 16 Nov 2024 04:49:31 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024ab569sm4474666a91.32.2024.11.16.04.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 04:49:30 -0800 (PST)
Date: Sat, 16 Nov 2024 20:49:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 1/8] builtin: pass repository to sub commands
Message-ID: <ZziU3wmP0pigGRRr@ArchLinux>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-1-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-1-761f8a2c7775@gmail.com>

On Fri, Nov 15, 2024 at 02:42:14PM +0100, Karthik Nayak wrote:

[snip]

> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> index 5250913d99eba18a28878d3904cb7b2399670d02..e5b1fe287e3ec94f0d8a3a99adb68842d52992f6 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -1,8 +1,11 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
>  #include "test-tool.h"
>  #include "parse-options.h"
>  #include "strbuf.h"
>  #include "string-list.h"
>  #include "trace2.h"
> +#include "repository.h"
>  
>  static int boolean = 0;
>  static int integer = 0;
> @@ -282,14 +285,16 @@ int cmd__parse_options_flags(int argc, const char **argv)
>  	return parse_options_flags__cmd(argc, argv, test_flags);
>  }
>  
> -static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED)
> +static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED,
> +		      struct repository *repo UNUSED)
>  {
>  	printf("fn: subcmd_one\n");
>  	print_args(argc, argv);
>  	return 0;
>  }
>  
> -static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED)
> +static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED,
> +		      struct repository *repo UNUSED)
>  {
>  	printf("fn: subcmd_two\n");
>  	print_args(argc, argv);
> @@ -319,7 +324,7 @@ static int parse_subcommand__cmd(int argc, const char **argv,
>  
>  	printf("opt: %d\n", opt);
>  
> -	return fn(argc, argv, NULL);
> +	return fn(argc, argv, NULL, the_repository);

Do we need to pass the real "the_repository" variable here. From my
understanding, we could just pass `NULL` to avoid including the
"repository.h" and the macro. However, I am not familiar with the
"test-tool" helper. It my comment was wrong, please ignore.

Thanks,
Jialuo
