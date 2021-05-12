Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BEC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 10:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE04613EB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 10:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhELKic (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 06:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhELKib (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 06:38:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A001BC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 03:37:22 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o21so20732343iow.13
        for <git@vger.kernel.org>; Wed, 12 May 2021 03:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DcqO4s/J3KsznghF7zASp29Q3B5x12ROzgkbRu/yXGA=;
        b=kCaZsKl3yd278MzFPmqfP+TwMysjv38nXnlszod22n7EpCqbwo5Qpf9+bpHE6cNUxS
         hPcm2xveApDD9YtUQ6BR3Bg60t0+5T9bvD1Srge4Uutm/suvCs+vuzkTZankT9DY1alH
         D9mrrzYoYS4ijrDvNL5TwjTlcOcMrIA3KbfBfS9x4Y9gUi3nPImWtzEVg0bUG5p/jGMg
         JD3AKm0vE+bcm4N1pLy1t4DmzdlFWphVG08A641qRpw2mopTwxmlrpBq7ZpYI/yFa5ea
         9ARXlu3TNgA0DteF0QCjYfeDyt1rlfryMQIOW7RZ14BsXonAyXoiccqMLCfoWXagjFdt
         W26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DcqO4s/J3KsznghF7zASp29Q3B5x12ROzgkbRu/yXGA=;
        b=Wtc0Fw9FSdHt2ieYIn8/YfQWfbbLWWMltHlEonDYVsdaQpD6rrN2wRX0pkhmGuhwMd
         Tv0Hqok580evo5QPylxO+AqA+9vlCgvZK4gOnX5FzhoqM5VYRuVQ7YScFZmUObCKIqXp
         b1e/9s2g5hnV2tjSjDT2eKGY1ndXIixTY13lrVX4Jhwlu8jpQMbRihVR1KfYRYgl1i7a
         5bhxDQnyW+cEZhF+nta5t05YEqy9htyHyLt/OFjuj6B9UiZQu7aYs4Kz95aQUhNz2Hzd
         SdHLVPwq3B6di+kIq2dhhW2FBKR5wWBpofyMhwt9X6loWJnLUUqmdtZ7XAnecpkCJHNZ
         GWpw==
X-Gm-Message-State: AOAM533E5NLWvVhnslpKqSJqUB/4/ZCSy34US1hYG/6xfQJriSCAj70s
        4b30AR3Vakjurpmf2U+Xbv14UQyj+JKEExnGjaY=
X-Google-Smtp-Source: ABdhPJzoW5XrtJzwGIjrvwusCIWafs58wMkYWNfEZ1ClNtRIN4GXQV43bcMUz6qoA8uNo29kx/Ib3ct+GO48gSAWDDo=
X-Received: by 2002:a5e:c00e:: with SMTP id u14mr22871691iol.106.1620815842061;
 Wed, 12 May 2021 03:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com>
 <pull.949.v5.git.1620747320947.gitgitgadget@gmail.com> <xmqq35usivi4.fsf@gitster.g>
In-Reply-To: <xmqq35usivi4.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 12 May 2021 18:37:05 +0800
Message-ID: <CAOLTT8SroeHvZRiRMoeBAPo-nuAvYOzxRx=fq=DxnpUfy4zVsw@mail.gmail.com>
Subject: Re: [PATCH v5] [GSOC] ref-filter: fix read invalid union member bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +     test_when_finished "cd .. && rm -rf ./test" &&
>
> Not a very good practice to chdir around, even if you have
> when-finished clean-up.  Not worth risking "rm -rf" at random
> places when for example somebody breaks when-finished.
>

OK.

> Instead...
>
> > +     mkdir test &&
>
> Place everything below ...
>
> > +     cd test &&
> > +     git init &&
> > +     cat >expect <<-\EOF &&
> > +     refs/heads/main
> > +     EOF
> > +     git add . &&
> > +     git branch -M main &&
>
> This is in a freshly created repository without commit.  Does
> "branch -M" work for such an unborn branch?  Perhaps start this
> block like so:
>

I think "git branch -M" before "git commit" also will be fine.
Of course it's okay to put it after commit and before "test_cmp".

>         git init test &&
>         (
>                 cd test &&
>                 test_commit initial &&
>                 git branch -M main &&
>                 cat >expect <<-\EOF &&
>                 refs/heads/main
>                 refs/tags/initial
>                 EOF
>                 git remote add origin nowhere &&
>                 ...
>
> > +     git commit -m "test" &&
> > +     git remote add origin nowhere &&
> > +     git config branch.main.remote origin &&
> > +     git config branch.main.merge refs/heads/main &&
> > +     git for-each-ref --format=3D"%(color:#aa22ac)%(refname)" >actual =
&&
> > +     test_cmp expect actual
>
> ... up to here inside a (subshell).
>

I get it now. By executing cd in the subshell, the "cd .." step can be
omitted.

> By the way, your use of "git branch -M" makes the test work whether
> the default initial branch name is still 'master' or already 'main'
> by forcing the branch used for testing to be 'main'.  Clever ;-).
>

Hh, real knowledge comes from practice. Yesterday, I tried it on the old
version of git on some classmates=E2=80=99 computers, and there was an erro=
r,
so using "git branch -M main" can avoid this error.

> Will queue with all of the above suggestions squashed in; please see
> if the result is good when it is pushed out later today.
>
> Thanks.
>

Thanks!
--
ZheNing Hu
