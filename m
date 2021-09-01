Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D0C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7715861058
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhIAVxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhIAVxr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 17:53:47 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1727CC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 14:52:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so1569873otk.9
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEZWk/wNQ1eM17uwQeeRTfh+AChUwbBw1tp6srOHOSY=;
        b=giP6LQbnvTnGJVXu5Feai9BVUehbG3FjMzz6cwn6vjByDPy/ySZWob0OATo76pjGjC
         I32JKN0BzfwJzKFxnLXsOVOUfeq1UnU+q/1TlaCHoRXxVg/6KFIpQ1HhMgJ9LIZHW3O2
         oPoO7y5URU8LL+ExSX9O1X6HXYGsy3ZsJieqLqA3zMjurkUOa0xqgs2VN2A6aUGC82gH
         1i4J/6dTuEiy0AWbH/t6p/DNqLO0jWSQo1gev6kZLzg2/voQiFxRhKWPFFk8qTZiXijk
         NUyo1t0YSdcL/W4NC3WqL0t3pGvSLdlzpWz+AtxGS+i/qE1Vkaew6PqgpqBo0SLlzjto
         OemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEZWk/wNQ1eM17uwQeeRTfh+AChUwbBw1tp6srOHOSY=;
        b=KGo9qNanNK8e/74nCfh7aisd6y+o8QhznPrSIKG1EACrW7FJtiDZj3r0YMGIrfApcP
         SLxv949DkgxAUpNx5+B9WskadwnEOjZktcJeJ/qDalxAaCSVLcMJjOF5EDe2CYanDZbK
         IBSreN4kkx+7Xd1UM9mb9avH14Np0jhvwpvcWkvw/5WlVH7JBgRLQ0URKkknCAKPB99r
         45RA2z02j5QcO1PWJR6blr8druMWh9mwshCqEsYaW0Pf4JvU6MrfVGsN+dAyv5mwsDHR
         QhWlsJ2e7CMnnH6aYYKYLgH063+Ga6PXJmAziQhfU5hfd5OmVoNj6zofF5HyeLlcRVxa
         JVnA==
X-Gm-Message-State: AOAM531Qk+57UG95WIVV3yGgKijtcnADgRhsbs3UaS4ysbrOHAX0sfko
        DgAd/t4SqIALv466CpxKy99EktxTAo6lfpU/CqFbrmfV
X-Google-Smtp-Source: ABdhPJwUc6MN7YOtq7/lde545sPHg3EJ7tD0zvy4H4KDwm8PJzVV38mR8rQQ1RYb+1BNDAT4GDxsvodkWUrQyW2rCvU=
X-Received: by 2002:a9d:7cc3:: with SMTP id r3mr1349484otn.345.1630533169314;
 Wed, 01 Sep 2021 14:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
 <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com> <328b5d6e76f598590d24b35ec23b5fd854c6cf05.1630503102.git.gitgitgadget@gmail.com>
 <xmqq7dg0oxdm.fsf@gitster.g>
In-Reply-To: <xmqq7dg0oxdm.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Sep 2021 14:52:38 -0700
Message-ID: <CABPp-BFEvSXHAzFFs8VaWK5QUTj6Zyow9863p=qM6G8v3OPy1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] test-lib-functions: optionally keep HOME, TERM and
 SHELL in 'test_pause'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 1, 2021 at 1:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +# Usage: test_pause [options]
> > +#   -t
> > +#    Use your original TERM instead of test-lib.sh's "dumb".
> > +#    This usually restores color output in the invoked shell.
> > +#    WARNING: this can break test reproducibility.
> > +#   -s
> > +#    Invoke $SHELL instead of $TEST_SHELL_PATH
> > +#    WARNING: this can break test reproducibility.
> > +#   -h
> > +#    Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
> > +#    This allows you to use your regular shell environment and Git aliases.
> > +#    WARNING: this can break test reproducibility.
> > +#    CAUTION: this can overwrite files in your HOME.
> > +#   -a
> > +#    Shortcut for -t -s -h
>
> As this is not end-user facing but facing our developer, I do not
> deeply care, but I find the warnings in this help text problematic.
>
> Because a new process instance of $PAUSE_SHELL is run, the options
> you add when inserting test_pause does not affect what happens in
> the tests after you exit the $PAUSE_SHELL [*], right?

I think the warning was less about what happens after test_pause is
complete and the testcase resumes, and more intended to convey that if
the user tries to manually copy & paste snippets of code from the test
into $PAUSE_SHELL, then the use of these flags can cause the result of
those pasted commands to differ.  If so, a small rewording might be in
order, e.g. "WARNING: this can cause commands run in the paused shell
to give different results".  I'd also say the CAUTION would perhaps
benefit from some rewording (since the option itself doesn't cause
files to be overwritten), e.g. "CAUTION: using this option and copying
commands from the test script into the paused shell might result in
files in your HOME being overwritten".

> Of course, you can modify the repository or the working tree files
> used in the test in the $PAUSE_SHELL, and that can break "test
> reproducibility"---if you run "git ls-files -s" and take its output
> in a temporary file, a step later in the test that runs "git status"
> will see an extra untracked file, for example, and such a change may
> (or may not) unnecessarily break the tests.
>
> But it is not anything new introduced by these options.  It is
> inherent to test_pause itself.
>
> If we want to add a warning to the help text here, I think it should
> be written in such a way that it is clear that the warning applies
> to any use of the test_pause helper, not just to the form with the
> options.
>
> Thanks.
>
>
> [Footnote]
>
> * If we had an alternative implementation of test_pause that does
>   not use a separate $PAUSE_SHELL process, but instead like
>   inserting a read-eval-print loop, that would be far more powerful
>   and useful debugging aid.  You can not just stop the execution of
>   the test, and observe the files in the test repository and the
>   environment variables---you can also access shell variables and
>   functions.
>
>   Such a test_pause from another world would deserve a "if you touch
>   anything, the damage is permanent" warning even more than the
>   current one, because you can modify even a shell variable to
>   affect the execution of the test after you leave the paused state.
