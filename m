Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03E1BC07A
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773805; cv=none; b=R9moqHgyCNQS54ZtKtX8I8wzZ5RVbePcjZJMVHWxe1hYm7+//PySLmijUHgqYyO+2LPna7ymfv14YQbcBayUbfRm+T+79pInLlPWocyx67JR1orbEGq/32BOUPYRa9tEQmQeGBBwxGSUn0SJ4mhJL4oQTpCQppCBoPwefVFQwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773805; c=relaxed/simple;
	bh=b5jGh6cfkWaQas/Nuwj7L0+qt/KpXRBO/imi/yc+tFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuAZkJzplwTF8DpBGUvisnJrxq4rpHDJcp4nEfPhgAfZU8UfNoyCo7mMZc3K/VFUcY9yqDrSgP392n9W29ud/w4DbyP+2II6qHbKsXE3TUcM8Zkd3zDiNzSVPqVCMD8P41peEjHcP2RExB5I1EpjWYg/0ecuXgOFq7OEXrO0ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyEPp3bc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyEPp3bc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso5453415e9.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750773802; x=1751378602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cLdfYrOIobhzawpbKRD0c4HPvX6x6Vlsl2x8ROgrjtw=;
        b=TyEPp3bcjQcn+8V5T+Gs+9GzJk2ivIZeDbNL1riWz04nxc+GOwAaR9VNPRvd7LuOiL
         6aRzhYFLDjRVts7qaQUQ6fjSp3mOfuHmpylzL6xxoVy/S5Dx8SkmLqh7nKUmByrTEYNb
         gsTx0WKrvATGkr4DxO1LnGLEHWDobeedu/HADBr/xpipESnXEl0IVGK+hh9+Ezdnhb+q
         ejPNA0Jm/pmGwxEj3TRwn3Ns3L9LALypA4BvyYEQ50+31DsEMFPiz7GZJ5mOXgkm9QyC
         j6MqMya8WMExgJdW+rSzJEvDKXlvWSq1JAyTf9PnEXgix6500gqwKm1WPHldmX41VmpQ
         VYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773802; x=1751378602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLdfYrOIobhzawpbKRD0c4HPvX6x6Vlsl2x8ROgrjtw=;
        b=NuDdPcPhN0sjQFLfFi6sXwARMhDmlqnc0ZKTIBibJbzenBycI/v7rGCYI5YLsRn/y+
         egH9LNmtHTuPUkVr6TXfob5NNJ/5/4dYPMFRqw4eHWcxDm2xhcxQTiX95rfoO4XR41C/
         f1Je0DdUEPUHRg2ST5mYvXw6I9afI3YJ1k8PkbJAZKs1P/GMDqYWzvNMdjnLxdJk9L8t
         xPZVjUQipyUmUki6LRQtA4PLLjqBApI6+/6BAwiS+/p9P8ZjlX/iWvs2OVxofbqgqCoH
         6HTFV4nrRD+zteSbgCe5LjTQbvwEieUjZE72O10WcobbRUFMaI2/jBkaxGgW8QRkWWLA
         gLFg==
X-Forwarded-Encrypted: i=1; AJvYcCUYkQHQqDR2Ml+ZBqTLacNSLgvgUBjQpYpBKfs/D14gPVg3OAYo6cDC28ctnI7T0BxAWqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmy8GUI2mWFetrD+ySEsevQPSzbqbG3cL3R5K9POJP8Z5cr2Ie
	rOO6kmFoMfQCNvtQWjWsaxeLT5bDYts+oDswqvlSn6s4UG3ZnD6Vd2Am
X-Gm-Gg: ASbGncuJQucqqIL1cpblPDvo9d8P58Bv6U0ZOQk5kMwyOIihrnK9nmkgZVb8//AMSKg
	YWtTFioCZsK52R+R4J1x+V0Pf1kZ6L3rKto+2nFQa6NMpmJLlNPxwmnAYjHKeD19XiMVETCv+aH
	pZ4t10epgsD29Du36JNl6PfiMyceWZG+7uYa/hiTjeOUGwiIKhhY1AsExO+EUurFADxSIZGjrk0
	9pgi3VJPtYslEZ13W+JH0Iod3HtTrEp1wAH+wsYwZRlkPU6F+euFeQLJrPP2fCv3AAAE1jIFAx1
	PuvL0W+zqvyNitezf+ib4gj2WAKFLOw33jMDRXVEavvOYCLw+gAusQ3hnMivgSAM+uB5d95ecco
	x82k4gONk8WQ4HljOCcxjUON9iMi9BUEVvO8RxQ==
X-Google-Smtp-Source: AGHT+IGje90DT4dymO8qtlsPHzY1822B92T8MP/2aJz3yM/5TANtEPy9AKuvdMhdg3Q2A+DhTwEKPA==
X-Received: by 2002:a05:6000:2906:b0:3a5:2599:4163 with SMTP id ffacd0b85a97d-3a6d130cd5bmr13518424f8f.47.1750773800013;
        Tue, 24 Jun 2025 07:03:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8068fd0sm2109514f8f.38.2025.06.24.07.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:03:19 -0700 (PDT)
Message-ID: <f50c6e4d-f789-4779-a8de-288b7341283f@gmail.com>
Date: Tue, 24 Jun 2025 15:03:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-2-lucasseikioshiro@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250619225751.99699-2-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 19/06/2025 23:57, Lucas Seiki Oshiro wrote:
> Create a new Git subcommand called repo-info. `git repo-info` will query
> metadata from the current repository and outputs it as JSON or plaintext.
> 
> Also add entries for this new command in:
> 
> - the build files (Makefile and meson.build)
> - builtin.h
> - git.c
> - .gitignore
> 
> In option parsing, use PARSE_OPT_KEEP_UNKNOWN_OPT to allow the users
> specify after the flags the information that they want to retrieve.

That should not necessary, the option parser will keep any arguments 
that do not begin with "-" without this flag. Using 
PARSE_OPT_KEEP_UNKNOWN_OPT is intended for accepting options that are 
passed to another command and prevents the option parser from 
complaining about unknown options which is not what we want here.

Best Wishes

Phillip

> 
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>   .gitignore          |  1 +
>   Makefile            |  1 +
>   builtin.h           |  1 +
>   builtin/repo-info.c | 21 +++++++++++++++++++++
>   git.c               |  1 +
>   meson.build         |  1 +
>   6 files changed, 26 insertions(+)
>   create mode 100644 builtin/repo-info.c
> 
> diff --git a/.gitignore b/.gitignore
> index 04c444404e..b2f3fb0047 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -139,6 +139,7 @@
>   /git-repack
>   /git-replace
>   /git-replay
> +/git-repo-info
>   /git-request-pull
>   /git-rerere
>   /git-reset
> diff --git a/Makefile b/Makefile
> index 70d1543b6b..50e3a3cbcc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1308,6 +1308,7 @@ BUILTIN_OBJS += builtin/remote.o
>   BUILTIN_OBJS += builtin/repack.o
>   BUILTIN_OBJS += builtin/replace.o
>   BUILTIN_OBJS += builtin/replay.o
> +BUILTIN_OBJS += builtin/repo-info.o
>   BUILTIN_OBJS += builtin/rerere.o
>   BUILTIN_OBJS += builtin/reset.o
>   BUILTIN_OBJS += builtin/rev-list.o
> diff --git a/builtin.h b/builtin.h
> index bff13e3069..cc6bc95962 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -216,6 +216,7 @@ int cmd_remote_ext(int argc, const char **argv, const char *prefix, struct repos
>   int cmd_remote_fd(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_repack(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_replay(int argc, const char **argv, const char *prefix, struct repository *repo);
> +int cmd_repo_info(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_rerere(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_reset(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_restore(int argc, const char **argv, const char *prefix, struct repository *repo);
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> new file mode 100644
> index 0000000000..a5c43e253f
> --- /dev/null
> +++ b/builtin/repo-info.c
> @@ -0,0 +1,21 @@
> +#include "builtin.h"
> +#include "parse-options.h"
> +
> +int cmd_repo_info(int argc,
> +		  const char **argv,
> +		  const char *prefix,
> +		  struct repository *repo UNUSED)
> +{
> +	const char *const repo_info_usage[] = {
> +		"git repo-info",
> +		NULL
> +	};
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT);
> +
> +	return 0;
> +}
> diff --git a/git.c b/git.c
> index 07a5fe39fb..27a2b3569b 100644
> --- a/git.c
> +++ b/git.c
> @@ -611,6 +611,7 @@ static struct cmd_struct commands[] = {
>   	{ "repack", cmd_repack, RUN_SETUP },
>   	{ "replace", cmd_replace, RUN_SETUP },
>   	{ "replay", cmd_replay, RUN_SETUP },
> +	{ "repo-info", cmd_repo_info, RUN_SETUP },
>   	{ "rerere", cmd_rerere, RUN_SETUP },
>   	{ "reset", cmd_reset, RUN_SETUP },
>   	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
> diff --git a/meson.build b/meson.build
> index 7fea4a34d6..06f2f647ba 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -645,6 +645,7 @@ builtin_sources = [
>     'builtin/repack.c',
>     'builtin/replace.c',
>     'builtin/replay.c',
> +  'builtin/repo-info.c',
>     'builtin/rerere.c',
>     'builtin/reset.c',
>     'builtin/rev-list.c',

