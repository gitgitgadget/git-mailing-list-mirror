Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5A41FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 15:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbdFMPda (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 11:33:30 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36063 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbdFMPd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 11:33:29 -0400
Received: by mail-it0-f65.google.com with SMTP id 185so11932968itv.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uDW74GcDrzzwfh/jr/0T405knCuoQ0XUHH5KB27itJI=;
        b=qJROPrAeTu9NLr4xolqGiRroh5CUe75AMKXPT1Whq7M4AysD0a1ftC7sBsJBHgbbQ9
         km5mqSoCtaplJ154KHyjKLJ85VXeSrUEIdcUTlTvnakpkxutfCnYAq+lovQz8NOjgWJQ
         TOcpjJFPUZ3lBZVBYM2rP3O+7Yv1pybl9MVxr0jztlZ/BmZGGKix2kHbUXLzqKjA0P7n
         7sNbIMUSR45u7vht7oRjsKokZWvi3qcqrhSOLrbLIoN4Q4Us1BNf+ctKUFpzuf1DzWTh
         0rKAGYZtvmGiF+NqvZmgvC7eMcyAMkSVqsmVjMZqADFh7nUkPlwNnrRbv5BrApunIjPJ
         8Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uDW74GcDrzzwfh/jr/0T405knCuoQ0XUHH5KB27itJI=;
        b=sW33HJbTDyZkQZ2fOeChaGAfo42C+LMPA/vm7Exo184t3QU2DdviUFDG3olOdT++kN
         BaclfryA5yHMG+iqns/SY9gyTei6DGFxf88xd0NZwK6XPt4/nhlW497jgjaIPHLpLuP/
         ISXwQYNOipP1ZQewVZZnOvLNpDKfIlDCRRLKMpKTrsw3o9cLcJBvHOv+m2y0f5H0rWfI
         w/zU8KIylt1mMdH70MT4XJzY7MFH4KD/SbE1VWlYLeY/hRiuO1Hy0A6MdO8wgKV4BK33
         uK7cCkIVjzqh0EX3jshYuf6LEtOTOZDR5IGRPz7tZv7JmsryhPfig9TUkq0+1dCeMBoI
         /viQ==
X-Gm-Message-State: AKS2vOwI65Z5Pmf4UIN4w05tynqlFJJ2XbPjiyTb2fT0ewAUhd8lZPi9
        vWvmyWtUpSoceA==
X-Received: by 10.36.33.210 with SMTP id e201mr534047ita.112.1497368008553;
        Tue, 13 Jun 2017 08:33:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id a138sm1076899ioa.15.2017.06.13.08.33.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 08:33:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] git-stash: fix pushing stash with pathspec from subdir
References: <6200f6bf1a9ac81d02391b898d203d650c6af962.1497353866.git.ps@pks.im>
Date:   Tue, 13 Jun 2017 08:33:26 -0700
In-Reply-To: <6200f6bf1a9ac81d02391b898d203d650c6af962.1497353866.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 13 Jun 2017 13:38:34 +0200")
Message-ID: <xmqqr2yn9a2h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The `git stash push` command recently gained the ability to get a
> pathspec as its argument to only stash matching files. Calling this
> command from a subdirectory does not work, though, as one of the first
> things we do is changing to the top level directory without keeping
> track of the prefix from which the command is being run.
>
> Fix the shortcoming by storing the prefix previous to the call to
> `cd_to_toplevel` and then subsequently using `git rev-parse --prefix` to
> correctly resolve the pathspec. Add a test to catch future breakage of
> this usecase.

It sounds more like a simple bug than "shortcoming" ;-), and the
right approach to fix it is to add the original prefix before the
pathspecs before using them, which is exactly what your patch does.
Looks good.

I suspect that "rev-parse --prefix" needs a bit of tweak to make it
truly usable for pathspecs with magic, but that is a totally
separate issue.

Thanks.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git-stash.sh     |  3 +++
>  t/t3903-stash.sh | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 2fb651b2b..e7b85932d 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -19,6 +19,7 @@ OPTIONS_SPEC=
>  START_DIR=$(pwd)
>  . git-sh-setup
>  require_work_tree
> +prefix=$(git rev-parse --show-prefix) || exit 1
>  cd_to_toplevel
>  
>  TMP="$GIT_DIR/.git-stash.$$"
> @@ -273,6 +274,8 @@ push_stash () {
>  		shift
>  	done
>  
> +	eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"
> +
>  	if test -n "$patch_mode" && test -n "$untracked"
>  	then
>  		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 3b4bed5c9..4046817d7 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -812,6 +812,22 @@ test_expect_success 'stash -- <pathspec> stashes and restores the file' '
>  	test_path_is_file bar
>  '
>  
> +test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
> +	mkdir sub &&
> +	>foo &&
> +	>bar &&
> +	git add foo bar &&
> +	(
> +		cd sub &&
> +		git stash push -- ../foo
> +	) &&
> +	test_path_is_file bar &&
> +	test_path_is_missing foo &&
> +	git stash pop &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar
> +'
> +
>  test_expect_success 'stash with multiple pathspec arguments' '
>  	>foo &&
>  	>bar &&
