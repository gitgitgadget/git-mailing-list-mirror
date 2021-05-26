Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02627C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 14:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEDD6108D
	for <git@archiver.kernel.org>; Wed, 26 May 2021 14:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhEZOjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhEZOju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 10:39:50 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B74C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 07:38:19 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c196so1682906oib.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Se/NEQ8wZ4Vwp3O/csa6MSux7CqrHhCY0ikZfHN2Hlo=;
        b=LgdP2d30Rl/HzErEmp8EYiKRN9S2szSciC7Gp51D1/7tUmMBcnWrDvpu4UTK1X5NEx
         AK4sbY2NYCvC1a4rQauQezBg8RkigwwdjqEqykra59pc5taOAwigBXcNKtV2ChfCb2Y4
         UzWGAJQrk3V45jaLhR9qEG1P1LPkXWlpZoccDpt7mIhWYzZOO6XJVmmnqlalFEnG9YgG
         9L7Mvwc1/Nd4IoZ+NN34ciGXaepdlZmH+OxZNtlBOVKBGvC36kIE/jweSqPic40WMZSL
         FRGXGglcbgX82kBGDZtOnBTZLBeuS7xOE7DRhCY2W9gncT5wVPQmVmGI1YnGHSY5UW1w
         my8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Se/NEQ8wZ4Vwp3O/csa6MSux7CqrHhCY0ikZfHN2Hlo=;
        b=MfvdL1pjlzFgUP8bm7V4sNnOYE5UBYDBVJo61Izt/qEOKBe5LR1tgjhztVi/XKBi2w
         POA/7elNU52P7yeH6fao1ey+IIQNvqTBpRbdKPmFY2ICZgOxXehW8rlHQ2gEKmkSmtF2
         O3N+F3/Oju46O4lHR3XmNPDjHsNGQF6t1sYXsMG33+RtnooI2Snq0AN+LkdXEUJOrvih
         hdLg/K2V35LqVs9AsAdu3yX9UNUJPerl0GO+HZRkXMOp+DAQs6Q9R92EuSAPfuVWoS06
         Tb70O1bXd2T8ShPPprJSHOg/OJ3sX1rUxk9Syu+4RVfdWrkDTBsfQ1ZeCwEjsNHVmXh7
         lOeQ==
X-Gm-Message-State: AOAM533Q9+ObB9t4YVbzounIHgUdR/bgk/uBCloBWqF7oT0VmC6U9Lgy
        4Al44kXepmsPQlnKYMn2SFAgtYeapuUHXT+qSixZnx7Z4sw=
X-Google-Smtp-Source: ABdhPJynGGqP7wC1vroC3nybbX2hsCKQ4pT1cZzlXUPFFQBSv75CKMUEGvHPgKg4kCmMuCZtJOSWC3cHhMwPVG8WrlA=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr2094032oiw.167.1622039898859;
 Wed, 26 May 2021 07:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
In-Reply-To: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 May 2021 07:38:08 -0700
Message-ID: <CABPp-BGBY9kwqRQ+soa8=W2F+=8eQRYS3vWS_7UCC0K0qNTW1g@mail.gmail.com>
Subject: Re: time needed to rebase shortend by using --onto?
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Git Mailing List <git@vger.kernel.org>, entwicklung@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 3:13 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> I have a kernel topic branch containing 4 patches on top of Linux v5.4.
> (I didn't speak to the affected customer, so I cannot easily share the
> patch stack. If need be I can probably anonymize it or ask if I can
> publish the patches.)
>
> It rebases clean on v5.10:
>
>         $ time git rebase v5.10
>         Performing inexact rename detection: 100% (36806539/36806539), do=
ne.
>         Performing inexact rename detection: 100% (36806539/36806539), do=
ne.
>         Performing inexact rename detection: 100% (36806539/36806539), do=
ne.
>         Performing inexact rename detection: 100% (36806539/36806539), do=
ne.
>         Successfully rebased and updated detached HEAD.
>
>         real    3m47.841s
>         user    1m25.706s
>         sys     0m11.181s
>
> If I start with the same rev checked out and explicitly specify the
> merge base, the rebase process is considerably faster:
>
>         $ time git rebase --onto v5.10 v5.4
>         Performing inexact rename detection: 100% (36806539/36806539), do=
ne.
>         Performing inexact rename detection: 100% (36806539/36806539), do=
ne.
>         Performing inexact rename detection: 100% (36806539/36806539), do=
ne.
>         Performing inexact rename detection: 100% (36806539/36806539), do=
ne.
>         Successfully rebased and updated detached HEAD.
>
>         real    1m20.588s
>         user    1m12.645s
>         sys     0m6.733s
>
> Is there some relevant complexity in the first invocation I'm not seeing
> that explains it takes more than the double time? I would have expected
> that
>
>         git rebase v5.10
>
> does the same as:
>
>         git rebase --onto v5.10 $(git merge-base HEAD v5.10)
>
> . (FTR:
>
>         $ time git merge-base HEAD v5.10
>         219d54332a09e8d8741c1e1982f5eae56099de85
>
>         real    0m0.158s
>         user    0m0.105s
>         sys     0m0.052s
>
> , 219d5433 is v5.4 as expected.

That does seem surprising, though if an automatic gc completed between
the two commands that could certainly explain it.  If that theory is
correct, it would suggest that it'd be difficult for you to reproduce;
running again with either command would give you something closer to
the lower time both times.  Is that the case?  (Also, what's the
output of "git count-objects -v"?)

>
>         $ git version
>         git version 2.29.2
>
> That's from the Debian package 1:2.29.2-1~bpo10+1 on a Debian 10 box.)
>
> Best regards
> Uwe

I'd love to try this with git-2.32.0-rc1 (or even my not-yet-upstream
patches that optimize even further) with adding "--strategy=3Dort" to
your rebase command to see how much of a timing difference it makes.
Any chance the patches could either be published, or you could retry
with git-2.32.0-rc1 and add the --strategy=3Dort command line option to
your rebase command(s)?

Elijah
