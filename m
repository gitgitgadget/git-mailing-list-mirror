Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D02C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 18:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB70122261
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 18:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgJRSnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 14:43:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36515 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgJRSnG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 14:43:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id l16so8026037eds.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 11:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcNcrOh4KrMdpeAps+Fwib72idibRyDKiILFb6O70T0=;
        b=CTvnrOmONY1oh0VAN+AmDq0znAsAVh7S5L7eCW1//wFtI348PCHdiYK2N4yG1f5Bpc
         2kdHOJ57+Oc5Xkf1F9nAWxBRafS9cvom6k3SselzW8AC8QIseb+/Imsv5PRM66fIn9aW
         AO3yQafkoK4cD4AXawkaXtmu4KhdFGNbhlplhnVzQbHjeVfchFDUVdY7m24tzqSsXFZo
         xSvwKrECFTpXUBmIEe+ppa7tjyWly4Rp8dafKWB8+REa8t01+8jnwrKFqJZCetyQANWf
         NJFWf+T3z5LJAgzGBcfcHy/HnorODAFafwmDFjFRZSQeMgliCADrzMEvUUt5rEeKqodG
         Z8Ww==
X-Gm-Message-State: AOAM533QssUpxNeMEhVl7dTcWmd9IeO3u8i2zXX16lksJKOxQd4/kCbd
        g3DDni9L8Ol2lgMCY4bJuPqIv+yHNg4tBQCkkzhgU2CSHPI=
X-Google-Smtp-Source: ABdhPJy4gCkIqhAtG16w7EZ0OEXik3B5p7MHCuyJlgRnoH79yTaL68p0AQEvfegnknma7yX4sHGmEoEvZSYKr8s105I=
X-Received: by 2002:aa7:c0d2:: with SMTP id j18mr15351662edp.89.1603046584077;
 Sun, 18 Oct 2020 11:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201018061052.32350-1-caleb.tillman@gmail.com> <20201018130219.GA6749@konoha>
In-Reply-To: <20201018130219.GA6749@konoha>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Oct 2020 14:42:53 -0400
Message-ID: <CAPig+cR+Jkg3ymFGBXtmLUEB7+XbgX0HvkjV3Z_9Lvk6qsY0qA@mail.gmail.com>
Subject: Re: [Outreachy-Microproject][PATCH 1/1] t0000: replace 'test -[def]'
 with helpers
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     caleb.tillman@gmail.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 18, 2020 at 9:02 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> First of all, I notice that this is a v2 of this PATCH:
>
> So, I think that the subject of the mail should reflect the same. I
> believe that you have used 'git format-patch' to generate this mail
> therefore what you can do is:
>
> 'git format-patch -v2 @~n', where 'n' is the number of commits which you
> want to include in the patch. So in your case it will be:
> 'git format-patch -v2 @~1' and a patch mail will be generated.

Even simpler is to use the short form -<n> where <n> is the number of
patches you want to format, so this can become:

    git format-patch -v2 -1

> Also, you need not put the '[Outreachy-Microproject]' tag in the
> subject, '[OUTREACHY]' will suffice.

Good advice.

> > t0000: replace 'test -[def]' with helpers
> >
> > The test_path_is* functions provide debug-friendly upon failure.

Since this patch is replacing only a single `test -f` (and not
touching anything of the form `test -d` or `test -e`), it would be
more accurate and reviewer-friendly to be explicit and say only `test
-f` in the subject, and `test_path_is_file` in the body rather than
making the commit message unnecessarily and overly generic.

> This commit can be redone to be even more better. This does not exactly
> reflect what has been done. I understand that yes 'test_patch_is_*'
> functions are better and why they are better. But where did you replace
> them, this is left unanswered.

I'm having trouble parsing this. It is unclear what has been left unanswered.

> This is one example of how the commit messages can be, not too verbose
> and not too short, somewhere in the middle:
> https://lore.kernel.org/git/20200118083326.9643-6-shouryashukla.oo@gmail.com/

It doesn't hurt to add a little back history as in the example you
cite, but the commit message of this patch already does a reasonable
job of explaining why this change is a good idea (specifically because
`test_path_is_file` makes for a better debugging experience), so it
doesn't necessarily need more explanation.

> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > @@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
> >  test_expect_success 'git read-tree followed by write-tree should be idempotent' '
> > -     test -f .git/index &&
> > +     test_path_is_file .git/index &&
>
> The change is fine but I feel you can easily find files in which you can
> do the same type of change but in a large quantity. This way you will
> get an even better idea of how the tests work at Git. [...]
>
> Here if you try finding files which had commits over 11-12+ years ago,
> you will find some ancient relics to modernise too!

If we consider that a microproject is meant to give a newcomer a taste
of what it is like to contribute to the Git project -- submitting
patches via email, interacting with reviewers, re-rolling a patch
series, etc. -- then keeping the submissions small and focussed is
preferable to making them large and wide-ranging. This is especially
so with changes like this which are primarily mechanical in nature;
they can easily lead to reviewer-fatigue when done in large numbers.
So, this is a case of smaller-is-better. As such, this submission is a
good size already.
