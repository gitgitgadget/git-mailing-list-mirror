Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475951F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfAWXjO (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36518 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAWXjK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so1159157wmc.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=w8/46vMLhtmZnNgLCNAq+NNoIZO1iF3dqaEGYukKG5I=;
        b=bVmq7ESUbcB5CLp17Z4zgCKNc512gMI/VvjpHKjMtYSi8Oj4in5Nb4AtM+BR6IV3Rw
         bN4QAp24jN/pJ7ayxLVKvU/e6ZJYjdH6IhmgbhVs1qL4GIopuldTWbgwrRIROvInTF60
         CuOL4PU9Snmc/GYtvn7P9Ha02ag4z7LqfhGKYG2AGeS5qbyHdlNAmp08awwrTZ7zg5WQ
         FIm4jKekF5VsHNGh3KB/M/MeTyFwMy9RKBHa2qH+nw0YIA5g6Ohs8T9DX//iE9i/K0+s
         Fm+lPytycKndc6fSXPhkoJrxQ7LlXIJctW9Gc5gJCaXyA88pDI6O8L+pA4YyN0EvBbDq
         SbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=w8/46vMLhtmZnNgLCNAq+NNoIZO1iF3dqaEGYukKG5I=;
        b=pkraa1YyrJcpfkIPoj1o9TOF36QR8ETvydfgt21qO91k1UvXD1ZqWC65Ne+UKfNnyb
         kM/GiWL6vZwvKZiI/ciSqDteCN+mWYI4Tz9kWgfDKtl3j+peGhEPVEdilbC1HzQb/EC0
         D9XetFO3w49r+OaUQ0M7UtJ6tpHPaP302qIQTxx1pCFZ8VtmeBfxNWgvkKdkvbV52B4z
         /4Uu5R3mOa8/pQYuuzQ/gWNGEXiJgWe+Fxpnf/Fez6TzoozKNh5hsuZkZAU+f/KjSPH/
         zVcJwyP3BN6AzzGZfUAMPOlu7wYZCal6FrGQjvnMnZ/Wf3Mo+evgin9gyAVRFf4ldn3R
         XqJw==
X-Gm-Message-State: AJcUukewRTczFMFXF4nas6IMEI6Rr9usq46CFrlu+u7Pu7WY5nPpw7H0
        87c9Kv8Ql5dHf1I0fLV8yco=
X-Google-Smtp-Source: ALg8bN6xDOvtT5Fy44me3m7cpeDenWn2t3hqYTVlMmekq1t36okLtvYMB8ME+5VXtQJDj9vKmlp7Og==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr130085wma.19.1548286748256;
        Wed, 23 Jan 2019 15:39:08 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u10sm83859083wrr.33.2019.01.23.15.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
Date:   Wed, 23 Jan 2019 14:19:16 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqqzhrr54h0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index fe65144152..bcdcc71592 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -37,7 +37,8 @@ osx-clang|osx-gcc)
>  	brew update --quiet
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time

Isn't this comment now stale?

It would be, under this new arrangement of the code, most natural
for Those who want to use gnu-time to arrange it to be somehow added
to $BREW_INSTALL_PACKAGES, no?

> -	brew install git-lfs gettext
> +	test -z "$BREW_INSTALL_PACKAGES" ||
> +	brew install $BREW_INSTALL_PACKAGES

It is unclear how this relates to "encapsulate Travis-specific"; it
is guessable that perhaps only under Travis we'd use
BREW_INSTALL_PACKAGES, but it still is unexplained why under other
CIs we don't do lfs or gettext (if that is the plan---that is not
clear, either).

>  	brew link --force gettext
>  	brew install caskroom/cask/perforce
>  	;;
> diff --git a/ci/lib.sh b/ci/lib.sh
> index c26bb6a274..4456dbbcb0 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -1,8 +1,26 @@
>  # Library of functions shared by all CI scripts
>  
> -# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
> -# want here. We want the source branch instead.
> -CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> +if test true = "$TRAVIS"
> +then
> +	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
> +	# what we want here. We want the source branch instead.
> +	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> +	CI_COMMIT="$TRAVIS_COMMIT"
> +	CI_JOB_ID="$TRAVIS_JOB_ID"
> +	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
> +	CI_OS_NAME="$TRAVIS_OS_NAME"
> +	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
> +
> +	cache_dir="$HOME/travis-cache"
> +
> +	url_for_job_id () {
> +		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
> +	}
> +
> +	BREW_INSTALL_PACKAGES="git-lfs gettext"
> +	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> +	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> +fi

OK.  I actually was expecting this to be something like

	case "$CI_TYPE" in
	Travis) ... the reindented travis specific stuff here ... ;;
	*) echo >&2 "unknown CI_TYPE: $CI_TYPE"; exit 1 ;;
	esac

to make it equally easy to add not just the second one but the third
one.

> @@ -28,7 +46,7 @@ skip_branch_tip_with_tag () {
>  # job if we encounter the same tree again and can provide a useful info
>  # message.
>  save_good_tree () {
> -	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
> +	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"

Makes sense.  $CI_COMMIT is still coming from $TRAVIS_COMMIT but is
that different from "git rev-parse $CI_BRANCH" I wonder (thinking
aloud, not suggesting any changes).

> @@ -38,7 +56,7 @@ save_good_tree () {
> ...
> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> index 7aef39a2fd..d2045b63a6 100755
> --- a/ci/print-test-failures.sh
> +++ b/ci/print-test-failures.sh
> @@ -69,7 +69,7 @@ do
>  	fi
>  done
>  
> -if [ $combined_trash_size -gt 0 ]
> +if [ -n "$TRAVIS_JOB_ID" -a $combined_trash_size -gt 0 ]

I do not quite understand this change.

If this wants to say that "we know how to show failures only when we
know the job id", then testing for $CI_JOB_ID would be more
appropriate, and if this wants to say that "we know how to show
failures only when we are running under travis", then it would be
more appropriate to switch on test "$TRAVIS" = true that is used at
the beginning of ci/lib.sh (or if you would switch to "case $CI_TYPE"
there, use the same construct).  I cannot quite make an argument to
support the use of $TRAVIS_JOB_ID in either case.

> +test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
>  gem install asciidoctor
>  
>  make check-builtins

OK, BREW_INSTALL_PACKAGES has an assignment in the travis specific
section to trigger install of two separate packages, and there is no
assignment to ALREADY_HAVE_ASCIIDOCTOR in the travis specific
codepath, so we will end up installing asciidoctor here.  Makes
sense, even though this one too is under-explained just like the
other one is.

