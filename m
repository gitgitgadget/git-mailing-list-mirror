Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3745ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 00:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiJ1AXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 20:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiJ1AW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 20:22:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780F2A0246
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 17:22:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 21so5678574edv.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P35Yv5uVO3Zuy04zErpaBlKgan7Djld9uqZ80afuNu4=;
        b=MY1KtdV/ZAwR6N48+HMWQ0jBP8Ni6lGoszcy7zY+ff9mPXY4Y1ci97Krs4s8ngOx2z
         Jj+kS1cr6lYGZ3R6RDounveBkDFo3Ab3WO1osxlXiRUEgqewrugAVAReF0Bje4C0B7q/
         ggv+kTfHHVf15wk1kMSmrOmRYKYGPvOC5fEvvXjEgnD9FCtDeLplvUVmnuOM0sfh7R/k
         M5sh6NY65iSycthFTjHl+w4iTp/MSo/AsTKZLgSN4tG35mlyPRk6Jx079MqFalGJ17bj
         wmJznzb8d56iniAiaglZe3czJxMHXqW37dPfQFlUQw04PPUUcKfYo4vnKJ+fe7Ns34YS
         /mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P35Yv5uVO3Zuy04zErpaBlKgan7Djld9uqZ80afuNu4=;
        b=p1XJYxHFFWrMJDC/MTHFz0+0xuz0u8n7PFupXhxlOZG2l8qPtlW43Aiz3UVqMiNaFh
         H45DleIwhM/6cKqxcxza3Hkw+CjYyE9RqxGIyhaLJOqMu4piZIPwf9aB2I5pS+7XVw24
         1KwBBUW7/lsZ/bR97QEXh6yhD3OSDi9Gq8lEdJ7gMDMK5s8yCLIt213DkkizqSh9JVaG
         77gKjvgLgj71v+ZzwH3jXZSLSYtCp2qFPgyaEKXx4p+ZIxr+zb1M6wEDK+fPu5SX4e5T
         6X3k+RFGPpBMTGDCFwmAfSEHU01kPjf6TA9PsyWyxOAWb+uqkItuc0YtdFSEK3+WfsFX
         S1OQ==
X-Gm-Message-State: ACrzQf3qJ72VlYulsSza3yt0/JkzDR0t2TzVQFdJl1tgyTt1/0yINyqG
        z0dX5hBRWoXBkLoNN7va8FXovROJAv6R7Q==
X-Google-Smtp-Source: AMsMyM6UwzuFyO8uvu714TbkN17hCm6rI0imltLflfedkH9agfe9+nXV5vzq18soDPxeCagiV9pSgQ==
X-Received: by 2002:aa7:c252:0:b0:462:aa0d:4144 with SMTP id y18-20020aa7c252000000b00462aa0d4144mr3853399edo.57.1666916575839;
        Thu, 27 Oct 2022 17:22:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906311800b007933047f930sm1410896ejx.157.2022.10.27.17.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 17:22:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooD9C-009gee-0I;
        Fri, 28 Oct 2022 02:22:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Subject: Re: [PATCH v3 9/9] archive: add tests for git archive
 --recurse-submodules
Date:   Fri, 28 Oct 2022 02:17:11 +0200
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
 <f88ebbaf17cbf1a0b57336430bd43ade94406f38.1665973401.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <f88ebbaf17cbf1a0b57336430bd43ade94406f38.1665973401.git.gitgitgadget@gmail.com>
Message-ID: <221028.86wn8k94pu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 17 2022, Heather Lapointe via GitGitGadget wrote:

> From: Heather Lapointe <alpha@alphaservcomputing.solutions>

[In addition to what others mentioned]

> +test_description='git archive --recurse-submodules test'
> +
> +. ./test-lib.sh
> +
> +check_tar() {
> +	tarfile=$1.tar
> +	listfile=$1.lst

This "listfile" is used nowhere?"

> +	dir=$1
> +	dir_with_prefix=$dir/$2

Nor dir_with_prefix?

> +
> +	test_expect_success ' extract tar archive' '
> +		(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile

Aside from what Jonathan mentioned, maybe we can just use one variable
here then?

	mkdir $foo ... <$foo.tar

> +	test_expect_success " validate extra file $path_in_archive" '
> +		test -f $dir/$path_in_archive &&

Instead use "test_path_is_file", and in general for "test <whatever>"
check out if we have a wrapper in test-lib-functions.sh.

> +check_not_added() {
> +	dir=$1
> +	path_in_archive=$2
> +
> +	test_expect_success " validate unpresent file $path_in_archive" '
> +		! test -f $dir/$path_in_archive &&
> +		! test -d $dir/$path_in_archive

Don't test for what a thing isn't, but what it is. Can't we do that
here?

> +test_expect_success 'setup' '
> +	rm -rf repo_with_submodules submodule1 uninited_repo_with_submodules &&

Don't have a test rm -rf stuff from a previous block, but have
"test_when_finished" clean up after that previous test instead.

> +	git init repo_with_submodules &&
> +	git init submodule1 &&
> +	(
> +		cd submodule1 &&

This:
> +		echo "dir1/sub1/file1.txt" > "file1.txt" &&
> +		git add file1.txt &&
> +		git commit -m "initialize with file1.txt"

Looks like you can use test_commit instead.

And note you can use -C, so you won't need the sub-shell either, I think.
> +	) &&
> +	(
> +	    cd repo_with_submodules &&
> +	    echo "file2" > file2.txt &&
> +	    git add file2.txt &&
> +	    git commit -m "initialize with file2.txt" &&

Ditto.

> +	    mkdir -p dir1 &&

Let's drop "-p" here, to check for errors.

> +test_expect_success 'archive with recurse, non-init' '
> +	! git -C uninited_repo_with_submodules archive --recurse-submodules -v HEAD >b2-err.tar

For git, don't use !, use test_must_fail, ! hides segfaults.

Does this test pass when you build with SANITIZE=leak? Then you can do this at the top:

	TEST_PASSES_SANITIZE_LEAK=true
	. ./test-lib.sh

If you can't test that locally pushing to GitHub CI will tell you...
