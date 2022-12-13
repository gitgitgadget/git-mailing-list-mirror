Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4B1C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 09:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiLMJsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 04:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiLMJsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 04:48:37 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28BCDF84
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 01:48:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qk9so35187345ejc.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2LHyD0PW151z7PAlAJiMKNsxE/TX/oWG3y0C9HxG0m0=;
        b=AiCZRaTjzYo/2g9sTepHkYhxSn9i8p4Yl1uGIMauYArzgWhE02syoyBnIDhZOpO6Iy
         mJEq9Diu/J8Uj/1DS9NTOAeNnTE4UCiO3ro+dPXzeCbrRJ17bzZWCnBgRCl82rQKSOL4
         PrsV9iaV31Qzy6JZZhqNOLnLUlAxo3nnm5wpcWpoYqafjRCtb8e5HppY4RE30lTfkW1U
         fHi1WSiPC+3C5jlN9nJzBhkUGYA18m2dlaq51dNeZkA6VRY96+OK9YN9HzAQ1KJY3LtJ
         jzdA2BYsCkcHqyCF4ntHzbzjgMHUTmhZLe/twe5gYsSZXxL6e13jH/jJ2byH96YfkgL/
         kefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LHyD0PW151z7PAlAJiMKNsxE/TX/oWG3y0C9HxG0m0=;
        b=xHA9aNWtMMg4UIAqLZGYu6URzoxpgsQNCAxoSe89zF2tSfA2lI4By8QyJERg9EldrN
         WEkO+JP/9rYmBz+zZyIcqvOuyAS7qRX9oJ+SSF2+819KZvl8vAprUNN583uK7OxH2zrA
         2TwEKKzfO7R1WoT0Hb1oACdhe1ChuVHrHght24iWCU7JW4PCeoFTkSsrVu+zyxyREITy
         WpLW+69wM2I1KFFv9Ej1z5xPJ72cdCDrNPcWLa1nCSnUgp+62YJmRDOSaPn+cqCnfKb+
         A64cFccz8CpKdhIhXLlK+/VnXt+NNCsb2jF1b6thPNpyHKF1Tn3cW7Ik47n/zVkNil3X
         9K9g==
X-Gm-Message-State: ANoB5plMcT2zom5G7fDD2/Dy+f6OHbmjfG7dc9dk4bqCpzSLvR3U3jWh
        3g+WoNZwA0bQjW2/RaFfZzuR5bwPMzyYxpddrjA=
X-Google-Smtp-Source: AA0mqf7RUflXJUIAlm3425bWcc2nghQcZxL1qUVV1iQ3s8akQVpJcOVSQeolUWxubNK4ekeYG4wWelNDpsTCEk1ctrA=
X-Received: by 2002:a17:906:aec1:b0:7c0:a04b:6795 with SMTP id
 me1-20020a170906aec100b007c0a04b6795mr31374026ejb.16.1670924914401; Tue, 13
 Dec 2022 01:48:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
 <pull.1373.v2.git.git.1667073374852.gitgitgadget@gmail.com> <xmqqa63sqe1b.fsf@gitster.g>
In-Reply-To: <xmqqa63sqe1b.fsf@gitster.g>
From:   Simon Gerber <gesimu@gmail.com>
Date:   Tue, 13 Dec 2022 10:48:23 +0100
Message-ID: <CAAyHH3239rmRR5mhy-cS7XFVuXi2AnYG5nQkFcpKMd4WTfmoBg@mail.gmail.com>
Subject: Re: [PATCH v2] help.c: fix autocorrect in work tree for bare repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Gerber via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Dec 2022 at 02:37, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > --- a/t/t9003-help-autocorrect.sh
> > +++ b/t/t9003-help-autocorrect.sh
> > @@ -60,4 +60,10 @@ test_expect_success 'autocorrect can be declined altogether' '
> >       test_line_count = 1 actual
> >  '
> >
> > +test_expect_success 'autocorrect works in work tree created from bare repo' '
> > +     git clone --bare . bare.git &&
> > +     git -C bare.git worktree add ../worktree &&
> > +     git -C worktree -c help.autocorrect=immediate stauts
>
> The reason why this third line is a sufficient test is...?
>
> If "status" is invoked successfully, it would not exit with non-zero
> status as long as it correctly notices that it was invoked in a
> worktree (as opposed to the current code without your fix, which
> would say "nah, where you are running there is no worktree", that is
> incorrect), but one scenario I am a bit worried about is what if the
> tester has an entry on $PATH that has "git-static" or whatever that
> is similar enough to "status", to cause autocorrect work differently
> from the case where "git status" would be the only plausible case.

Thanks for pointing out that autocorrect could work differently for a
tester depending on what's in their path. I didn't consider that case
at all.

>
> But then we can tell such a tester "don't do that, then" ;-)

I think that's fine in this case.

>
> Let's queue the patch as-is and see what others think.

Awesome, thanks

>
> Thanks.
>
> > +'
> > +
> >  test_done
>
