Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D1C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 19:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCFTcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCFTcU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 14:32:20 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3158372037
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 11:32:19 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 62-20020a630241000000b004fb3343142dso2353680pgc.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 11:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678131138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ws62YE3FCdF2PEXkJ88qgxmCEN3OFFWke9WSwo6jGmw=;
        b=MPBrcWiSUY8rw36POwdGUm+9t+OjtB4Fl6Xg4tPUIZ5R3cTlIxNYvrRjWW4G9hnhjI
         KC127/qq5NUJ8PkKg8xpk0UJAuVJsL7ryvVprE5NXMY7NZqSTIVAtIPJgCeQCx5diw3X
         IgjAyDHMggOcXygkXH5POk0LcdqEly+UiaCGuMXUqvTXTq2fWCPbtQXAAGfHvCsVSG1G
         5yUKZNAau/Oh5OeWMORcV7vArFU9FnvS6Hzb1KB5zQYuUBviMYveDuA0s3VRSGrVlx/8
         4rniXyqYOvUOst+IhbdxsrWeeNLF+9uVFfglXSBEg7BoF2UAKpvnjMZ3ITCRw918UmDw
         CMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ws62YE3FCdF2PEXkJ88qgxmCEN3OFFWke9WSwo6jGmw=;
        b=uoRv52oHLTL0DUTLceS80giyr4fEX0eHTcGemd59isNCp2xE1FjoGHK3gm0zQop59H
         XH3yZL4ZuRqzVrLXk4GgUOAid+MRnqMeSSxi+LTCC1QTkXo0u2MemlL587MSI8LSwmun
         BFrhaGi/DYL/JtM526Tb5iHYuRb5WVo8Pfw5o24s4z5mBiaWHDrdZiqxxutU65yv5S4H
         iVRnORc/UcYcn7Tvl/m7lfQOzWrKdGKeaMYuS83Rd39q4vDtRo7OdJ2kE1t393/Vlb4w
         BqGLjUNpRSfEFkxmnYnw0mQE6OxF/chJxOc1MeZI0qbpdmuM6Ce+W/DvK6zvmW/lxO2m
         Jk9A==
X-Gm-Message-State: AO0yUKX8/Xt8RgPSXWiZgvn9FSovH1wQDKDo505Zqrc0Vf/nI2J+gvd5
        hAp5DCXrmhi4g/QsNCcEGrH1IUuGKISuzg==
X-Google-Smtp-Source: AK7set/8lrYQS7GryRloTCAVlb9tINkN0lDiRUZSjidlRAk5szAhpUkGbBey3SnFEeZEZx2TkWAaOVuYC5JvSQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:6807:b0:19c:d14b:ee20 with SMTP
 id h7-20020a170902680700b0019cd14bee20mr4766544plk.8.1678131138581; Mon, 06
 Mar 2023 11:32:18 -0800 (PST)
Date:   Mon, 06 Mar 2023 11:32:16 -0800
In-Reply-To: <20230228185642.2357806-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com> <20230228185642.2357806-1-calvinwan@google.com>
Message-ID: <kl6l8rg9ekvz.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 1/6] t4041, t4060: modernize test style
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, peff@peff.net,
        gitster@pobox.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> In preparation for later changes, move setup code into test_expect
> blocks. Smaller sections are moved into existing blocks, while larger
> sections with a standalone purpose are given their own new blocks.

The changes where we moved lines outside of blocks into blocks without
changing them look good to me.

> While at it, have tests clean up after themselves with
> test_when_finished

I believe this came about as part of the discussion in

  https://lore.kernel.org/git/xmqqedqtbbf4.fsf@gitster.g

I think it's good to have tests clean up after themselves, but I'm not
sure if that's what we're doing in all of these cases, see below.

I'm leaving the diff header in place, since the two files have very
confusingly similar tests.

> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
>  test_expect_success 'typechanged submodule(submodule->blob)' '
> +	test_when_finished rm -rf sm1 &&
>  	git diff --submodule=log >actual &&
>  	cat >expected <<-EOF &&
>  	diff --git a/sm1 b/sm1

This hunk and the next...

> @@ -212,9 +215,9 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
>  	test_cmp expected actual
>  '
>  
> -rm -rf sm1 &&
> -git checkout-index sm1
>  test_expect_success 'typechanged submodule(submodule->blob)' '
> +	test_when_finished rm -f sm1 &&
> +	git checkout-index sm1 &&
>  	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 $head4...0000000 (submodule deleted)

were changed so that the "rm -rf" happens in the clean up phase of the
earlier test (test 14) instead of set up phase of the later test (test
15). But, the "rm -rf" actually results in a _different_ state from
before 14, so it isn't actually cleaning up, it really is preparation
for 15's git checkout-index.

You can observe this by running

  ./t4041-diff-submodule-option.sh --run=1-13,15

which fails as expected. On the other hand, it passes if we move the "rm
-rf" into test 15.

Nearly all of the other test_when_finished here have the same problem,
where they 'clean up' state that wasn't changed in the same test body. I
believe they will show similar dependency issues, though I didn't go
through and test them all.

> @@ -643,7 +643,6 @@ test_expect_success 'modified submodule contains modified content' '
>  	diff_cmp expected actual
>  '
>  
> -rm -rf sm1
>  test_expect_success 'deleted submodule' '
>  	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&

This one is fairly obvious, since the test says 'deleted submodule', but
we no longer delete the submodule in the setup.

> @@ -779,9 +780,8 @@ test_expect_success 'diff --submodule=diff with .git file' '
>  	diff_cmp expected actual
>  '
>  
> -mv sm2 sm2-bak
> -
>  test_expect_success 'deleted submodule with .git file' '
> +	mv sm2 sm2-bak &&
>  	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 $head7...0000000 (submodule deleted)
> @@ -804,9 +804,9 @@ test_expect_success 'deleted submodule with .git file' '
>  	diff_cmp expected actual
>  '
>  
> -echo submodule-to-blob>sm2
> -
>  test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
> +	test_when_finished "rm sm2 && mv sm2-bak sm2" &&
> +	echo submodule-to-blob>sm2 &&
>  	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 $head7...0000000 (submodule deleted)
> @@ -836,9 +836,6 @@ test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
>  	diff_cmp expected actual
>  '
>  
> -rm sm2
> -mv sm2-bak sm2

This is the original case that Junio flagged, which I think is an almost
correct use of test_when_finished, since we do get back to an earlier
state before this string of tests, but not to the state before the
actual test with the test_when_finished.

If we want to use test_when_finished here (which I think we do), we
should add another test_when_finished to remove the dependency between
the two tests. like so:

  test_expect_success 'deleted submodule with .git file' '
  +	test_when_finished "mv sm2-bak sm2" &&
  	mv sm2 sm2-bak &&
    git diff-index -p --submodule=diff HEAD >actual &&

...

 test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
	test_when_finished "rm sm2 && mv sm2-bak sm2" &&
+ mv sm2 sm2-bak &&

Currently, they're still dependent because one creates sm2-bak and the
other moves it back, but if we have each test restore sm2, there will be
no more dependency.

