Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFF01F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 05:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbeKNPQ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 10:16:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63224 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNPQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 10:16:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54E0011CD3B;
        Wed, 14 Nov 2018 00:14:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9/fa/ea8T5EfWXraC0VAyvTgqIw=; b=Fkx6jn
        N9lRKDrzMg4hZmiJo3MrCmevPfvl6dxKqZ2tg4U2pdNclWWCQg9uM/MZ1CzjxGo1
        Xwoby6lVkqxfXqgI9saYUMcevmSecqPOUDq4Jvo973qkGnkbVI6f726puGsVk5U2
        4rjwnakXiRRodbidT+Rh0n2qbdygsXYzXnKcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o5x2jOg7GvBTTPLTZfMS6GmYHfA7etm6
        /0ksU0oLEJk/XI7ach5IUw2V44kOl4o0PSk9r7ZkUOLOR92tqJM9OCK/b45A7amd
        E8ITlfeTyRVJVZHH+OX3PZ+DLrmN1soo9fhnxThPuRD8bIgy4I4UwwrNMJisjoeR
        M4Y1xCmC/Zs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DC8911CD3A;
        Wed, 14 Nov 2018 00:14:46 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE1B711CD39;
        Wed, 14 Nov 2018 00:14:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/5] tests: explicitly use `git.exe` on Windows
References: <pull.73.git.gitgitgadget@gmail.com>
        <cd314e1384312cd5b0c0031efd40c6442074e11c.1542030510.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Nov 2018 14:14:44 +0900
In-Reply-To: <cd314e1384312cd5b0c0031efd40c6442074e11c.1542030510.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 12 Nov 2018
        05:48:38 -0800 (PST)")
Message-ID: <xmqq5zx0p7ej.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 337BE568-E7CC-11E8-8314-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/Makefile b/Makefile
> index bbfbb4292d..5df0118ce9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2590,6 +2590,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
>  	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>  	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
> +	@echo X=\'$(X)\' >>$@+

Made me wonder if a single letter $(X) is a bit too cute to expose
to the outside world; as a narrowly confined local convention in
this single Makefile, it was perfectly fine.  But it should do for
now.  Its terseness is attractive, and our eyes (I do not speak for
those new to our codebase and build structure) are already used to
seeing $X suffix.  Somebody may later come and complain but I am OK
to rename it to something like $EXE at that time, not now.

>  ifdef TEST_OUTPUT_DIRECTORY
>  	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
>  endif
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 801cc9b2ef..c167b2e1af 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -900,7 +900,7 @@ test_create_repo () {
>  	mkdir -p "$repo"
>  	(
>  		cd "$repo" || error "Cannot setup test environment"
> -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git" init \
> +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \

Good.

>  			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
>  		error "cannot run git init -- have you built things yet?"
>  		mv .git/hooks .git/hooks-disabled
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1ea20dc2dc..3e2a9ce76d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -49,18 +49,23 @@ export ASAN_OPTIONS
>  : ${LSAN_OPTIONS=abort_on_error=1}
>  export LSAN_OPTIONS
>  
> +if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +then
> +	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
> +	exit 1
> +fi

OK, this tells us that we at least attempted to build git once, even
under test-installed mode, and hopefully people won't run $(MAKE) and
immediately ^C it only to fool us by leaving this file while keeping
git binary and t/helpers/ binary unbuilt.

> +. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +export PERL_PATH SHELL_PATH
> +
>  ################################################################
>  # It appears that people try to run tests without building...
> -test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
> +test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git$X" >/dev/null ||

The latter half of this change is a good one.  Given what the
proposed log message of this patch says

    Note also: the many, many calls to `git this` and `git that` are
    unaffected, as the regular PATH search will find the `.exe` files on
    Windows (and not be confused by a directory of the name `git` that is
    in one of the directories listed in the `PATH` variable), while
    `/path/to/git` would not, per se, know that it is looking for an
    executable and happily prefer such a directory.

which I read as "path-prefixed invocation, i.e. some/path/to/git, is
bad, it must be spelled some/path/to/git.exe", I am surprised that
tests ever worked on Windows without these five patches, as this
line used to read like this:

	"$GIT_BUILD_DIR/git" >/dev/null
	if test $? != 1
	then
		...

Wouldn't "$GIT_BUILD_DIR/git" have failed (and "executable not
found" hopefully won't produce exit code 1) and stopped the test
suite from running even after you built git and not under the
test-installed-git mode?

>  if test $? != 1
>  then
>  	echo >&2 'error: you do not seem to have built git yet.'
>  	exit 1
>  fi
>  
> -. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> -export PERL_PATH SHELL_PATH
> -
>  # if --tee was passed, write the output not only to the terminal, but
>  # additionally to the file test-results/$BASENAME.out, too.
>  case "$GIT_TEST_TEE_STARTED, $* " in
