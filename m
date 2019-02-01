Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8E31F453
	for <e@80x24.org>; Fri,  1 Feb 2019 20:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfBAUwn (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 15:52:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38027 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfBAUwn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 15:52:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so7555931wml.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=XAs5rT9x0L7szBubxQlwxe8GZPW52a0DiLWxBS/EV70=;
        b=aT0Tn2ZnPTFluwTLyOlrI/uQMhNmGaeNvi4PVRwYjxjnTJv1Yr4aIaznTmMj4Oz5lL
         T7bmq2D9pi3Yc6SP4IeHHdJrec59f1pR1IYO6gkCRPmYJC5CIWUyKNYZDFbfY+NaDg4+
         oNj0MdUYhxSKHucE8fhazCl14Wd4ytffERX//3Vcgt869H+iArgKi2A/nM2o/Z0qAqGS
         a0aHWO7R3WSY4/m21jA5QgVdwf6p+rdjtxOfH26G+4O6PX4xdc5rr6sG8qm+Ty1Kuwll
         KvUI4XniVbgcs4W6Hp76dcbPe3/yh8TjUyhE/Crcn6OH57FFLb2x1ktE5wOq/djgWjfV
         Q5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=XAs5rT9x0L7szBubxQlwxe8GZPW52a0DiLWxBS/EV70=;
        b=nz8JP0zaniWM/mEHmJY/hVOWAHya9QcIOHxZDcctAOHhWeaJlqsmnPLNLxyaFLmD0O
         tkdQ5s6dYo9HcQwZOtEp6FhIyPJysL9Mr5w3EN5JHqDee+i4gWfExtkxVG8dKc4BsEdu
         WHZgyKwgZk0suY9GoK0tbAbQtXpOtBLkI7Vwb3YoY2nrdk4NedWOJNgm9Ljlg6S2tyxk
         4+FcJeb3t0MfQ2jer0DMSEy67bKZLBe8yKwpKQBBRNi1rqoNK5BsKfdMe2XrQzUXzo2m
         scrL3CzBmB6SVKxJtxdRRLygcmi0b9HzOR1G8XrV0C4/a5gnXjRQGxwkr44k/lx2HxIh
         5FGg==
X-Gm-Message-State: AHQUAuZuOq5LJSh6mIYBQe/JEBEi/ryIT2xUH1wjaWjPRX79B6MPaAGW
        uDi0wcBhif7OtaoEuocW4zA=
X-Google-Smtp-Source: AHgI3IaeRupnqJJqd3DBg4Bx0ggAwgofgbzKkBnQkB64wfQvRGWXli+e+ETWxioO3aQox3kANYm1KA==
X-Received: by 2002:a1c:6e01:: with SMTP id j1mr3804673wmc.103.1549054360259;
        Fri, 01 Feb 2019 12:52:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t4sm4823869wrm.6.2019.02.01.12.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 12:52:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 1/2] describe: setup working tree for --dirty
References: <20190201135512.68220-1-koraktor@gmail.com>
Date:   Fri, 01 Feb 2019 12:52:39 -0800
Message-ID: <xmqqzhrfxmco.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Staudt <koraktor@gmail.com> writes:

> We don't use NEED_WORK_TREE when running the git-describe builtin,
> since you should be able to describe a commit even in a bare repository.
> However, the --dirty flag does need a working tree. Since we don't call
> setup_work_tree(), it uses whatever directory we happen to be in. That's
> unlikely to match our index, meaning we'd say "dirty" even when the real
> working tree is clean.
>
> We can fix that by calling setup_work_tree() once we know that the user
> has asked for --dirty.
>
> The --broken option also needs a working tree. But because its
> implementation calls git-diff-index we don‘t have to setup the working
> tree in the git-describe process.

Very nicely described.

>
> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> ---
>  builtin/describe.c  |  1 +
>  t/t6120-describe.sh | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index cc118448ee..b5b7abdc8f 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -629,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			struct argv_array args = ARGV_ARRAY_INIT;
>  			int fd, result;
>  
> +			setup_work_tree();
>  			read_cache();
>  			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
>  				      NULL, NULL, NULL);

And the implementation is as promised in the proposed log message.
Quite straight-forward and obviously right ;-)

> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index d639d94696..7cfed77c52 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -145,14 +145,38 @@ check_describe A-* HEAD
>  
>  check_describe "A-*[0-9a-f]" --dirty
>  
> +test_expect_success 'describe --dirty with --work-tree' '
> +	(
> +		cd "$TEST_DIRECTORY" &&
> +		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
> +	) &&
> +	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+$" out
> +'
> +

Without the fix to the code, this test piece fails with "-dirty"
suffix in 'out'.  Good.

> +test_expect_success 'describe --dirty with --work-tree' '
> +	(
> +		cd "$TEST_DIRECTORY" &&
> +		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
> +	) &&
> +	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+-dirty$" out
> +'

This succeeds with or without the fix to the code; the buggy
behaviour was to claim "-dirty"-ness when the working tree files are
clean.  This new test is not about that buggy behaviour.  It is
rather about the updated code does not mistakenly claim cleanness in
a dirty working tree.  Good.

>  check_describe "A-*[0-9a-f].mod" --dirty=.mod
>  
> +test_expect_success 'describe --dirty=.mod with --work-tree' '
> +	(
> +		cd "$TEST_DIRECTORY" &&
> +		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
> +	) &&
> +	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+.mod$" out
> +'
> +

Likewise.

>  test_expect_success 'describe --dirty HEAD' '
>  	test_must_fail git describe --dirty HEAD
>  '
> @@ -303,8 +327,17 @@ test_expect_success 'describe chokes on severely broken submodules' '
>  	mv .git/modules/sub1/ .git/modules/sub_moved &&
>  	test_must_fail git describe --dirty
>  '
> +
>  test_expect_success 'describe ignoring a broken submodule' '
>  	git describe --broken >out &&
> +	grep broken out
> +'
> +
> +test_expect_success 'describe with --work-tree ignoring a broken submodule' '
> +	(
> +		cd "$TEST_DIRECTORY" &&
> +		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --broken >"$TRASH_DIRECTORY/out"
> +	) &&

OK, this checks the same repository as the existing test does, but
does so from outside the repository.

Looks good.

>  	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
>  	grep broken out
>  '
