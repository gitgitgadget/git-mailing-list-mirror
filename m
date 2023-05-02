Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A86C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 19:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjEBTZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEBTZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 15:25:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D51BF9
        for <git@vger.kernel.org>; Tue,  2 May 2023 12:25:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso3244886b3a.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683055522; x=1685647522;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2cXvLkzdHIwROH09NB2HQCr0KkF1R0gu4S5JJ67Ap8=;
        b=W4vt6Z2BOIh/3cOhClr9c2NyCSP4NAtslfL/XXvikRuWeGjg3Fn6k7TeD5mV6Z6/qZ
         +DfY5TsfRG+sPlLgNa59O98iINMEQZ4O3uKChGaFbWml2vMIM6p4TkaYMSjLVs42GNrF
         TAxh6Zc9Wwpimn79R+PVTuZv2kGewAivIPaugzFsTxkW//nF+mCY6pcAxasMNGrONEmY
         4rtVoxX4v+O6dr0n3DdcW3q3SF4N7q5UEH6FP/ArqTQxPBOWRudvUB7mMFgSZKLik/dK
         PyvVoEvtkdH7MoPtSOkoxfw/FEnSBC0vBcpq1jfoiZCXHZhcShdROTf6/AO+d8Pg9Mbr
         +44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055522; x=1685647522;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2cXvLkzdHIwROH09NB2HQCr0KkF1R0gu4S5JJ67Ap8=;
        b=fIJEfKhQeNDPD/PzrfjFU0F/iDukTqojGaksmrE9M+6FeD5UEpvx1rn2WZ3ObpfErR
         cCe02GPy/dZ8S//P6OU7wVZE/7Ig2xM5HvlokaNZrQ/Fm/FIrFcFHKY++IrxE/nbo5pm
         Oy+Oghl9em1wrYgRY+5XvnjWzzJk3UozL/jXu6FU9U2z+sn+uG9vs1RqaXwd/CZEgg8i
         6mLlXP4QcVURtxqPmTsFOPm1Obs4tJ++KnK+33XlJb2qpeq93/12ZOZvLqz22P3u8sx7
         2kc+9gK3cKGsc2IYDJpXHa7NCUMY+lZpXsjLFZ8oRF5X9nPJDKXyIZ3W/7jhXFPa3OgB
         CXtQ==
X-Gm-Message-State: AC+VfDw9iezZfcvztZm9J3uhF4Zrs/EvhQAGf6W45d9UbHO5lni8+EUH
        tyCMUtSy0T9ciCPjbAMuh5Zn4rMpZWk=
X-Google-Smtp-Source: ACHHUZ4ec1N5/OH1XB0HaBj0iL+KfloCkwa5F69qpO/zbpf8s5ZLSm4Dw3mXzsNs8rLiuBckw9hcUA==
X-Received: by 2002:a05:6a00:15c4:b0:63d:24c0:1223 with SMTP id o4-20020a056a0015c400b0063d24c01223mr26522302pfu.29.1683055522145;
        Tue, 02 May 2023 12:25:22 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s18-20020a056a00195200b0063b96574b8bsm22105728pfk.220.2023.05.02.12.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 12:25:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v9 1/2] t1092: add tests for `git diff-files`
References: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
        <20230502172335.478312-1-cheskaqiqi@gmail.com>
        <20230502172335.478312-2-cheskaqiqi@gmail.com>
Date:   Tue, 02 May 2023 12:25:21 -0700
In-Reply-To: <20230502172335.478312-2-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Tue, 2 May 2023 13:23:34 -0400")
Message-ID: <xmqqjzxqzgbi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> +test_expect_success 'diff-files with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	test_sparse_match test_must_fail git diff-files folder2/a &&

In "sparse" directories at this point of test, "folder2" is outside
the cone(s) of interest and is not instantiated.  The reason why
the command fails is because the command line parsing that is
generic to all users of the revision machinery requires you to have
a disambiguating double-dash before such a pathspec that tries to
match a path that does not exist in the working tree and is not
specific to "diff-files".

I wonder how interesting and useful this test is.  Without
accompanying test that uses disambiguating double-dash properly,
e.g. "git diff-files -- folder2", I doubt it is very much useful.

> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	# Add file to the index but outside of cone for sparse-checkout cases.
> +	# Add file to the index without sparse-checkout cases to ensure all have
> +	# same output.
> +	run_on_all mkdir -p folder1 &&
> +	run_on_all cp a folder1/a &&

Now, "folder1" also has not been instantiated in sparse ones while
the full one of course has it, so "-p" in "mkdir -p" makes sense.
After these commands, all three will share the same "folder1/a".

> +	# file present on-disk without modifications
> +	# use `--stat` to ignore file creation time differences in
> +	# unrefreshed index
> +	test_all_match git diff-files --stat &&
> +	test_all_match git diff-files --stat folder1/a &&
> +	test_all_match git diff-files --stat "folder*/a" &&

Because in all three repositories, "folder1/a" exists in the working
tree, the "you need to disambiguate" error like the first test
(whose utility I questioned) would not trigger.

What does this demonstrate, though?  That instantiating a file on
the working tree, even outside the cone(s) of interest in a sparsely
checked out working tree, makes it part of the interesting set
automatically?  As there is no difference between the indexed
contents and what is in the working tree, we cannot tell from this
test if that is the case (not a complaint, just an observation).

But ...

> +	# file present on-disk with modifications
> +	run_on_all ../edit-contents folder1/a &&
> +	test_all_match git diff-files &&
> +	test_all_match git diff-files folder1/a &&
> +	test_all_match git diff-files "folder*/a"

... it is shown by doing the same test with modified contents?

For consistency with the earlier "the same contents" test, we should
use "--stat" here, too.  Or even "--stat -p".

Alternatively, we could refresh the index before running diff-files
(here and also before the earlier "the same contents" test), I
guess.

> +'
> +
>  test_done

Thanks.
