Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D8DECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 07:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiIHHmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiIHHm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 03:42:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E485D51C5
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 00:42:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u6so22986685eda.12
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=45P64uOUFZB3lj4DeJZQcG0g5no+F7hh1qzrb0qPyJY=;
        b=RPDrs+KfFpw9mNCu9geODkfTVqHkHkOMWPMGfoDAoQDQLNbMxTdt+2JU+O8d+8nF4E
         umxFWqF8p1eEv/4EHAxau13owxfCjYhpysmOKIGZpnxSeraLg3Bciq+eBw9y7QlJyuJ6
         9DsqJD94fbNUnRu0RAAFG808+E/ZVde0dpGugcs3JYohx6T3bHpvHzGvfu35Hykr+qrr
         knrtOleauTaOvLCNg5Kd+4OwHJwCyArvInTdXN0Gc9VgQ3JLgGIq8nLUQQIiZksJuwXW
         gveWWb4uknZgtTzzk3Rg86SC91AK+abM20uOHzv2UcAH7AQEuJDCBYuZtddQ/MN1E7K3
         DtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=45P64uOUFZB3lj4DeJZQcG0g5no+F7hh1qzrb0qPyJY=;
        b=EmyXjPAgTeQfAujwOkvd3IkiSCyLVwNpHx0mJNQ7eZOEDsahbwVmJPM++iz7970Wq0
         1MoIYKRy7KLxJszI1kHYkHiVxVJuYYQRG+iGwAzfvDxwcr6wFLWnXBrXVPd8AfdrUdtk
         Gd/mHMxYimvqNqkR3U76kPKftw5tUWz7mLtzh7VuPBmbVmFOhuPtEUZpP+0Gm70SCjd1
         dB+omqnK2LddXggiaYTIhuHI1SmQlesKcvNj0XXetHi1DvXCiKLnEF7BubDyQZ5/L0WH
         0msmr/mJNFnM3NpFJ0Qf8dcd6JvFk5LtTjW7IX+1iEFK72DaYx5dFLjYy7qqrFwLyzdd
         zkKQ==
X-Gm-Message-State: ACgBeo3wuBeteZW0kvNXkYMAEUvXE1Lweo2vUa55dLFc+mxjC6jYludq
        yb4MJoM+6ANNve8LiHZKKx07owW6BJ1jbg==
X-Google-Smtp-Source: AA6agR7Uw2MuJHKB/vUrQ9LpSVqH4UpT37dFCEJ6hMAWVYhHzyGeWvCNpl7aHw4Zz6sqsVUyLN771w==
X-Received: by 2002:a05:6402:4150:b0:44a:ec16:def4 with SMTP id x16-20020a056402415000b0044aec16def4mr6082113eda.21.1662622943815;
        Thu, 08 Sep 2022 00:42:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b00450206d9dfbsm745797eds.84.2022.09.08.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 00:42:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oWCB4-001HFR-0N;
        Thu, 08 Sep 2022 09:42:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] cmake: avoid editing t/test-lib.sh
Date:   Thu, 08 Sep 2022 09:39:38 +0200
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com>
Message-ID: <220908.86a67al3c1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 23 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 7f5397a07c6c (cmake: support for testing git when building out of the
> source tree, 2020-06-26), we implemented support for running Git's test
> scripts even after building Git in a different directory than the source
> directory.
>
> The way we did this was to edit the file `t/test-lib.sh` to override
> `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
> directory.
>
> This is unideal because it always leaves a tracked file marked as
> modified, and it is all too easy to commit that change by mistake.
>
> Let's change the strategy by teaching `t/test-lib.sh` to detect the
> presence of a file called `GIT-BUILD-DIR` in the source directory. If it
> exists, the contents are interpreted as the location to the _actual_
> build directory. We then write this file as part of the CTest
> definition.
>
> To support building Git via a regular `make` invocation after building
> it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (for
> convenience, this is done as part of the Makefile rule that is already
> run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
> up to date).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .gitignore                          |  1 +
>  Makefile                            |  1 +
>  contrib/buildsystems/CMakeLists.txt |  7 +------
>  t/test-lib.sh                       | 11 ++++++++++-
>  4 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index a4522157641..b72ddf09346 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,6 +2,7 @@
>  /fuzz_corpora
>  /fuzz-pack-headers
>  /fuzz-pack-idx
> +/GIT-BUILD-DIR
>  /GIT-BUILD-OPTIONS
>  /GIT-CFLAGS
>  /GIT-LDFLAGS
> diff --git a/Makefile b/Makefile
> index 04d0fd1fe60..9347ed90da7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3028,6 +3028,7 @@ else
>  	@echo RUNTIME_PREFIX=\'false\' >>$@+
>  endif
>  	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> +	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
>
>  ### Detect Python interpreter path changes
>  ifndef NO_PYTHON
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index fe606c179f7..29d7e236ae1 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1067,14 +1067,9 @@ endif()
>  #Make the tests work when building out of the source tree
>  get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
>  if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
> -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
> -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
>  	#Setting the build directory in test-lib.sh before running tests
>  	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
> -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
> -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> +		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
>  	#misc copies
>  	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
>  	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 55857af601b..4468ac51f25 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -42,7 +42,16 @@ then
>  	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
>  fi
>  GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
> -if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
> +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> +then
> +	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> +	# On Windows, we must convert Windows paths lest they contain a colon
> +	case "$(uname -s)" in
> +	*MINGW*)
> +		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
> +		;;
> +	esac
> +elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
>  then
>  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>  	exit 1

As pointed out in the v1 this breaks the cmake<->make interaction in
some scenarios, but from some brief testing there seemed to be an easy
workaround which didn't suffer from that problem:
https://lore.kernel.org/git/220811.86sfm3ov5z.gmgdl@evledraar.gmail.com/
