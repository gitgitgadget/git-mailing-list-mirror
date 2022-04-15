Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8667CC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353976AbiDON14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354019AbiDON1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:27:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E547572449
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:25:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c6so9904825edn.8
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qmQXkpuCxXor6v80Zp76PBoUmXGAFYfVQQb92r2hTB8=;
        b=leEpT25eod9RAcppkcOgkkPhdN5h280y0unVtJFpvsVqtVuMfVMWiFc2ywazolZLpC
         xkAe+97Fa7wNzx/nc2P7CuxBLV4ecCRdfssnJVfyXk84dMaRSGPooYqWWX3g369CaciZ
         Y2wY5DJu5S44NTXnHxwf3+djqpLMZhcIsVQObNA814GYPvdq9zmd9kND7MwGG3AR1xZI
         gdGK060jUvsBOmuIehLm+JF4sIgSuHtMyLsuZG4IB/0c+nbAscYORp38IMJtzyryArTu
         LppAqiSEFUa7Upiojb0e4VfTT7oQlQoSVBt5db8aTSnKTEKUwNg5MAZWod5GeC5x+89b
         At8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qmQXkpuCxXor6v80Zp76PBoUmXGAFYfVQQb92r2hTB8=;
        b=Fq0w6JgaY5XlmvMWnWDjg15Gfj4k2k/SRZFCVCElKXGrIJtKiQOe++JlgLpR1UK5k3
         ENKehue21VOIIzJ0gG7c8/CWSVUr7TbB9h4ZHgLHTH4PBzuGRvZEN3+yTrKSAHBqJLKK
         KlgG9o8NCJwgIalD+8P1M3zmPyKOAipp5n8nK3mTlOIwpZjpJJLTOVVXHl6MCsvjiWaC
         LBou9ZqGZotGaDJyY6T6Pq9x0JQxF1MOpUGMjGv8egu3P1quQ5vooD0uxV9BuxR7Ybnk
         S/xZys3FCtljvd5ilSnY5O4ZHQEOpHcnbUc/R8nTLW6kwsJNCTPoJd+FNFiZQZzV30Mf
         j3ow==
X-Gm-Message-State: AOAM533nu1ze3isctl5htqEI+T35hpGNwcsVeI48lXhVTD+WTe/MgKox
        ppz3k9Si77xKtg02XutbgECA+AXBKr7RRQ==
X-Google-Smtp-Source: ABdhPJyB63HHUSPnLOvnBkTJnQ/TKut30vS7533EOIFhd6YZ/l0aCNPLFeIDX7YnQMGPepD2Cdo9LA==
X-Received: by 2002:aa7:dc53:0:b0:421:d085:9a0d with SMTP id g19-20020aa7dc53000000b00421d0859a0dmr5001685edu.0.1650029105314;
        Fri, 15 Apr 2022 06:25:05 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906044500b006e8d35ac4cfsm1684677eja.112.2022.04.15.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:25:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfLwe-005ehS-DA;
        Fri, 15 Apr 2022 15:25:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] ci: lock "pedantic" job into fedora 35 and other cleanup
Date:   Fri, 15 Apr 2022 15:17:09 +0200
References: <20220415123922.30926-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220415123922.30926-1-carenas@gmail.com>
Message-ID: <220415.86wnfqbhsf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Fedora 36 is scheduled to be released in Apr 19th, but it includes
> a prerelease of gcc 12 that has known issues[1] with our codebase
> and therefore requires extra changes to not break a DEVELOPER=3D1
> build.
>
> Lock the CI job to the current release image, and while at it rename
> the job to better reflect what it is currently doing, instead of its
> original objective.

The CI job was added in your cebead1ebfb (ci: run a pedantic build as
part of the GitHub workflow, 2021-08-08), and later in 6a8cbc41bac
(developer: enable pedantic by default, 2021-09-03) we made "pedantic"
the default.

Is there any point in having this job at all anymore, or is it just a
"does it compile on Fedora?" now?

Your cebead1ebfb notes that its gcc is ahead of the curve, if that's
what we actually want perhaps s/fedora/linux-newer-gcc/ ?

I think this change would be much clearer if we first delete the
now-redundant pedantic flag, and then later do whatever else that's
needed...

> [...]
> This merges fine to master, maint and next but will need some work to
> get into seen.
>
> Alternatively, the fixes to fix the build could be merged instead, but
> it will still require at least one temporary change to disable a flag
> as the underlying bug[3] is yet to be addressed in gcc (or somewhere
> else in Fedora).

I get the same thing on GCC12 on Debian.

Wouldn't a much more useful thing be to upgrade to gcc12 anyway, and
just set -Wno-error=3Dstringop-overread on gcc12 for dir.(o|s|sp)? Then
we'd find any future issues, and blacklist this one known issue...

Or just set -O1 under the same condition.

> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-depend=
encies.sh
> index 78b7e326da6..660e25d1d26 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -15,8 +15,8 @@ linux-musl)
>  	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
>  		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
>  	;;
> -pedantic)
> +fedora)
>  	dnf -yq update >/dev/null &&
> -	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-=
devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> +	dnf -yq install make gcc git findutils diffutils perl python3 gettext z=
lib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null

Why do we need to install "git" now, I'd think because we're upgrading,
but here we're pinning the old version, what changed?

>  	;;
>  esac
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 280dda7d285..de0f8d36d7c 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -37,10 +37,9 @@ linux-clang)
>  linux-sha256)
>  	export GIT_TEST_DEFAULT_HASH=3Dsha256
>  	;;
> -pedantic)
> +fedora)
>  	# Don't run the tests; we only care about whether Git can be
>  	# built.
> -	export DEVOPTS=3Dpedantic
>  	export MAKE_TARGETS=3Dall
>  	;;
>  esac

