Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B1BC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB6F20801
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6PA8W2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJVlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:41:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44948 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJVlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:41:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id a49so3081494otc.11
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XxsTFq8Vx2vjyxUL+1LSp/WNkG/TrulLpn5SaLCbv4=;
        b=h6PA8W2A6mETMWeQFmPuoadXj+niPiYT0kUEOnc2V/1H/3VtMMqKZ7soYV4MfMza1Q
         W2/0qtCnTvY/XyGuCOgPJBU+FIQq03NzuGgcaCe30DYln89Hi0swPbp2fNGx/gCwW51e
         /xFPOtq/vYMoR/bJfWNIrnX2T8kIcz7rQ3P9u5TQAOMXJSwtWEkw3A13GPUoA2U8DgJ2
         Tn2XxkOppr5dhQ1qPr0IGE2ESmcx8AWLXHRwTQRZJxlrf8lWUvQ0HRAhJ1uHoWbMZMbH
         mB5kJdMnJr4nvWnjfXhXeuaOg6RSPHmKUgCukhRgFJTSZ3Dd6CNWhkXP8Fu6r4AcFP3r
         KE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XxsTFq8Vx2vjyxUL+1LSp/WNkG/TrulLpn5SaLCbv4=;
        b=kUmjNpYj43Un8Qe0goKn7rrgJBiGKJU4uNmBn1CyGUAyv4Shu206y4UxSZuWGk9Pdl
         BZ0dOWj3EzGbrwNpD786in/SKJW3XYXT8uE9C+MOS7C1lJzzSFMWIVbZpynKEAZz8ZCD
         wEdxO/qsYoVc+riv9m3Cgev862QIIo4Lmx2exsIlOUM+QchD5J/KYIYGh0r1AAsej7Cu
         pt58neUdnL/srguTSTYy/P5rgvOfgycMpFgSfHrWyj9j7zdnnvJKxeQF9yKrgUt/IUKd
         dxe6UX5ibYpVLNlUUe+tlaSyAl/KerGt43IApHvE5Xzy2MxEPm/MkznffANbcGzeFAaS
         fy1w==
X-Gm-Message-State: AGi0PubYuyG/jNrfscbz8JaB0UIZkm+Z+uhwNQxVg+cqjgOwGAjWbVhL
        +T1uUUBct+NIsTqEp/OaK6nMV7k8SwWKT2F/iIs=
X-Google-Smtp-Source: APiQypJsYMYMvlPc+TfAkxfpS1c6kq4SPqYQh4/yNup4P8D3XaAtdEC2d7UXTji2Lyur3OhOXr12T/iYr+IB8S+y4jg=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr5822824oti.162.1586554912517;
 Fri, 10 Apr 2020 14:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
 <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com> <e15c599c874956f1a297424c68fe28e04c71807b.1586541094.git.gitgitgadget@gmail.com>
 <xmqqtv1rhyaj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtv1rhyaj.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Apr 2020 14:41:41 -0700
Message-ID: <CABPp-BGUdUB2ePCWFvxFfnCTx3QBgvOH2pm-CZ9YvpM2Bt4qyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rebase: reinstate --no-keep-empty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bryan Turner <bturner@atlassian.com>,
        Sami Boukortt <sami@boukortt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 1:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > That commit viewed this, though as
> > turning that flag into a no-op.
>
> Sorry, but I do not understand this sentence.

Hmm...it wouldn't hurt to just drop the two sentences with "no-op" in them.

> > Provide users a way to drop commits which start empty using a flag that
> > existed for years: --no-keep-empty.  Interpret --keep-empty as
> > countermanding any previous --no-keep-empty, but otherwise leaving
> > --keep-empty as the default.
>
> But everything after that sentence down to here was very clear.

:-)

> > This might lead to some slight weirdness since commands like
> >   git rebase --empty=drop --keep-empty
> >   git rebase --empty=keep --no-keep-empty
> > look really weird despite making perfect sense (the first will drop
> > commits which become empty, but keep commits that started empty; the
> > second will keep commits which become empty, but drop commits which
> > started empty).
>
> That is true.  Do we leave it to others (or our later selves) to
> think about the UI further?  That is fine by me, but in that case we
> may want to add " We may want to rethink the option names later",
> perhaps?

The names might not be great, but since --no-keep-empty and
--keep-empty already existed for years and prior to 2.16 and were
about how to handle commits which started empty, it seemed reasonable
to (re)use them.  My personal preference would be that for commits
whose keep/drop state can be determined solely by looking at its
contents of the commit before the rebase (whether that's because they
start empty or for whatever other reasons), I'd rather recommend that
people just fire up an interactive rebase and pick out the commits
they don't want to keep.  So, my own bias would be that I wouldn't
recommend that new people use either --keep-empty or --no-keep-empty.
In my mind, the --[no-]keep-empty flags are just for backward
compatibility, so going through effort to rename or alias doesn't seem
like it makes a lot of sense.

I don't have a strongly held position here and I'm happy to hear
alternate viewpoints, but that's the thought process I went through
when creating this change.

> > +--no-keep-empty::
> >  --keep-empty::
> > +     Do not keep commits that start empty before the rebase
> > +     (i.e. that do not change anything from its parent) in the
> > +     result.  For commits which become empty after rebasing, see
> > +     the --empty and --keep-cherry-pick flags.
>
> keep-cherry-pick will appear later, not here, right?

--keep-cherry-pick is the new flag added by jt/rebase-allow-duplicate.
I guess I should technically probably wait until I create a commit on
top of that series and this one to mention it.  Or rebase Jonathan's
commit, and combine the two series (adding his second since mine might
be viewed as a bugfix).
