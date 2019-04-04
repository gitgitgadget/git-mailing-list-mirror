Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28AA202BB
	for <e@80x24.org>; Thu,  4 Apr 2019 07:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfDDHYw (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 03:24:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40113 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDHYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 03:24:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so2275354wre.7
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=Lj6jt8OjDmMcvZPJ9uv0N18Lz/DYvBWlzSpMm3MxH0s=;
        b=oimpQ8UJrv0+KHd6HOQOt42XAZlW5tqe57mX/XNUu+sPrNmHUkffE5NWyEx3Dkbf+V
         WdkrwYHuu8KPF/ERhzy2NAtYJL5fq7wiDNs7EN/Ch/f1jiDOBWzhcgnphRysqLmM/0nB
         na+xmZHCw6zGW+Z37iTlU10248oQXwCLVQlQBnIPXz35RRUBo/ctXqIE1cNMGbSoveu2
         BsuF/YeAttcT5Z/tWJlmNskLJsYa8ow2XCl/V5jQOeWjqG25ZXu+RpE/D64WzqmKCQVP
         iheP7zRosuCVkf/o7KySzN3Sq+HOsgNU3RI5DAi1Nq9dITba/Vx8EXSzu/d+5nm52jlq
         NL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=Lj6jt8OjDmMcvZPJ9uv0N18Lz/DYvBWlzSpMm3MxH0s=;
        b=aPxBXfI6iLmq6dEjsvuGWMRaTemnY6jXuht12bPYuEkYZmkP2hysZG2cdoVyqOEWxe
         2Wh6OnV/o28+qRXeTh/rgHbseFGk+30b19SSoNVhY5bcppgnoiQxUEQd/5uWJ2TutUbF
         LhaqrZRrd/MRl9iZntBBC2Cld7LXvkr9mjrxdqjYSe45AWvAx/7jVM/GMGFbs59ydy4w
         dS83zwunp68tSZr9Qo5S6/Z+Rx0Ppl8Tc8Z6Ig8vx6WHwpYhG5JcyUtE8PhI+EnBDf4m
         OorEGEvK83xpbO78iO+V6dSh6dpqAjDJ94iLfe6t2SFIHkheW7RM5yaKSH3Gu1Ycxtf5
         C2aw==
X-Gm-Message-State: APjAAAXrHtyyF0FtRg0xci8iw3rQ/JBvpY9fLl52LBtevFqa18caGXrr
        DWN353qnpzzjmH3wvGMzZBM=
X-Google-Smtp-Source: APXvYqxEK8BMm0n9tRBoBC8Bf8mPdQmPhXZFJtiutQfcdBeFGkIN03JXXbax8WW0MApBgR5MbeyZMg==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr2708813wrn.193.1554362690015;
        Thu, 04 Apr 2019 00:24:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w14sm13646026wrr.16.2019.04.04.00.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:24:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, debian@onerussian.com
Subject: Re: [PATCH v2 1/4] submodule: refuse to add repository with no commits
References: <87lg1eq146.fsf@kyleam.com>
        <20190402183505.31512-1-kyle@kyleam.com>
        <20190402183505.31512-2-kyle@kyleam.com>
Date:   Thu, 04 Apr 2019 16:24:46 +0900
Message-ID: <xmqqv9zufd1d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> When the path given to 'git submodule add' is an existing repository
> that is not in the index, the repository is passed to 'git add'.  If
> this repository doesn't have any commits, we don't get a useful
> result: there is no subproject OID to track, and any untracked files
> in the sub-repository are added to the current repository.
>
> Detect if the path is a repository with no commits and abort to avoid
> getting into this state.  Note that this check must come before the
> 'git add --dry-run' check because an upcoming commit will make 'git
> add' fail in this situation.

OK, in short, in an already-populated repository,

	$ git init junk ;# there was no 'junk' subdirectory
	$ git add junk

would have been a successful no-op, and after the above two
commands,

	$ >junk/one
	$ git add junk

would have added junk/one as a normal blob to the top-level project,
ignoring the fact that the user wanted to eventually populate junk
as a repository and add it as a submodule.  You'll be teaching "git
add" not to do so, and pay attention to the fact that junk/.git exists,
even though junk/.git/HEAD is on an unborn branch.

Which makes sense to me.

> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---
>  git-submodule.sh           |  7 +++++++
>  t/t7400-submodule-basic.sh | 11 ++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 514ede2596..5a9dc9bf7e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -231,6 +231,13 @@ cmd_add()
>  		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
>  	fi
>  
> +	if test -d "$sm_path" &&
> +		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
> +	then
> +	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
> +	    die "$(eval_gettext "'\$sm_path' does not have any commits")"
> +	fi
> +
>  	if test -z "$force" &&
>  		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" > /dev/null 2>&1
>  	then
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index aba2d4d6ee..6adf640143 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -46,6 +46,15 @@ test_expect_success 'submodule update aborts on missing gitmodules url' '
>  	test_must_fail git submodule init
>  '
>  
> +test_expect_success 'add aborts on repository with no commits' '
> +	cat >expected <<-\EOF &&
> +	'"'repo-no-commits'"' does not have any commits
> +	EOF
> +	git init repo-no-commits &&
> +	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
> +	test_i18ncmp expected actual
> +'
> +
>  test_expect_success 'setup - repository in init subdirectory' '
>  	mkdir init &&
>  	(
> @@ -809,7 +818,7 @@ test_expect_success '../bar/a/b/c works with relative local path - ../foo/bar.gi
>  		cp pristine-.git-config .git/config &&
>  		cp pristine-.gitmodules .gitmodules &&
>  		mkdir -p a/b/c &&
> -		(cd a/b/c && git init) &&
> +		(cd a/b/c && git init && test_commit msg) &&
>  		git config remote.origin.url ../foo/bar.git &&
>  		git submodule add ../bar/a/b/c ./a/b/c &&
>  		git submodule init &&
