Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1976C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 00:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiK0Aa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 19:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK0AaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 19:30:25 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAAA10FD0
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:30:24 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q71so6850299pgq.8
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vU6rihRXHkf2mSyG2YoKlB5oedLQ2xknbU6RLbgmss=;
        b=M/JEj/O5++SQZEoXmiAxAuLd+/NpzHKnqc2raNSMv0qY6gb65tzv88wh7SN48JISCb
         OVaRletrC8+xG880g0qOTrf5NO++qVByA6A+RFBW7asz24AkBiSTPdZf6qg0crHsvqpA
         jka7UURcXO57Sxh7dDisnUzm0kTV02vxgqmd7LUNbL/cfR0sNt+NZ1oCeUFGH/mcQzlt
         yY5OEtPBWKWepKVK1eq4ecZZ3XcSyAD/JhALnqB+pN12YpwlioXgzO1nEa7sTEOctG0h
         bL6MtYPqTsX9vAVF4HuLdnxnYbmlxymf6BC+LU8inFeqBMZuzOuM7qT69qZCEUVRJgMt
         ih0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vU6rihRXHkf2mSyG2YoKlB5oedLQ2xknbU6RLbgmss=;
        b=wilcUUFibI3ZA1InsGDQLcs+VrJhjopufVmC0P12VP0eFHGk3k2Br7DJj6CE4S1Buy
         bkmWzGq/ZEG6tPRgfzNaAo3bqr2rlPwWiozMITzUgceuWTi/wCMJt3XCmpHDK3Pa3Qy3
         PKkFjyYXfwPyxXPJTqUUTL690BoIF62JVUbDpTyRR5Mj5TmYUBCmc7Xqfrz8bhRx3Bau
         w791mWVt+Yp1PnJfhvlAuqI4rYiNCCcfnnsFcmloidDGJt9IoCaGdJnvu91Pp1J6OKoo
         U5OmcreuY/bN4hE1GKTyZSoQ72owFs+Kb6efzIQVED6r5pNba0Lqxi6RrdtFDfLvn8xO
         jrTA==
X-Gm-Message-State: ANoB5plDCS+9FOGmdGW8gKQLGvouT6RrdwRVuzCP7+GUoJqSUGCLjDh9
        JBXAruWOQzXMdI/06f+uYsg=
X-Google-Smtp-Source: AA0mqf4dLHn0k2zGNGuDg6r0yDkwFEbhBWF53LVJQj+WD++0873EROZOlOPSc6IUFeRgj9l4PfBIWg==
X-Received: by 2002:a65:4688:0:b0:477:7aee:a464 with SMTP id h8-20020a654688000000b004777aeea464mr25374297pgr.595.1669509024206;
        Sat, 26 Nov 2022 16:30:24 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c200-20020a624ed1000000b00574d8d64560sm2292759pfb.175.2022.11.26.16.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 16:30:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 4/4] ci: install python on ubuntu
References: <20221124153934.12470-1-worldhello.net@gmail.com>
        <20221125095954.4826-5-worldhello.net@gmail.com>
Date:   Sun, 27 Nov 2022 09:30:23 +0900
In-Reply-To: <20221125095954.4826-5-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 25 Nov 2022 17:59:54 +0800")
Message-ID: <xmqq4julb5nk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Python is missing from the default ubuntu-22.04 runner image, which
> prevent git-p4 from working. To install python on ubuntu, we need to
> provide correct package name:
>
>  * On Ubuntu 18.04 (bionic), "/usr/bin/python2" is provided by the
>    "python" package, and "/usr/bin/python3" is provided by the "python3"
>    package.
>
>  * On Ubuntu 20.04 (focal) and above, "/usr/bin/python2" is provided by
>    the "python2" package which has a different name from bionic, and
>    "/usr/bin/python3" is provided by "python3".
>
> Since the "ubuntu-latest" runner image has a higher version, so its safe
> to use "python2" or "python3" package name.

Makes sense.  Just out of curiousity (read: not a suggestion to
change anything), what happens if you say "apt install python" on a
recent system?

Will queue.  Thanks.

> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  ci/install-dependencies.sh | 2 +-
>  ci/lib.sh                  | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index b569893b38..d8fafc8ed2 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -15,7 +15,7 @@ case "$runs_on_pool" in
>  ubuntu-*)
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
> -		$UBUNTU_COMMON_PKGS $CC_PACKAGE
> +		$UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
>  	mkdir --parents "$P4_PATH"
>  	pushd "$P4_PATH"
>  		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 927b4529b0..cb30699f34 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -232,12 +232,12 @@ ubuntu-*)
>  		break
>  	fi
>  
> -	if [ "$jobname" = linux-gcc ]
> +	PYTHON_PACKAGE=python2
> +	if test "$jobname" = linux-gcc
>  	then
> -		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
> -	else
> -		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
> +		PYTHON_PACKAGE=python3
>  	fi
> +	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
>  
>  	export GIT_TEST_HTTPD=true
