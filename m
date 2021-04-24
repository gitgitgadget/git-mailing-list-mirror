Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62347C433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FED600D4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 13:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhDXN1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhDXN1T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 09:27:19 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2CDC061574
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 06:26:40 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j12so29061348ils.4
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2B8+lArbcp7RYC1fMWPKgJgq63TvCWUR/L0gg7l2fE=;
        b=gUMFIMl+TN8YqKYMpe0jkEQFmQE1kN9N7t19MhB2r5n3fI6bAbhGUeYb4tAWDzo68T
         tIZJ7Z5d5BOSbBRa9FlRJRpcHMJnDVopoSEld08gokBFuPad1aFR4JCrlK0cRZ4IBqOX
         hSujsuMZmi1u7RqPLfuPHWuBXCl/6QCJIYUz3l6Baiw3PoTUJ0XhQnV9nfnDuWpho3m8
         NkseaLK5Q8aKSfmZ3s4LclNwGAtwGOHZR64QFY8jGA7CK6OiHdw++ds+oI9WnNokGdd6
         WpEBN/We0Z2w+FryQzjEUnV8XevFysPHjkJApCtrYT+8d1VAY7znfeV6pG+sWGZnc5HU
         R3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2B8+lArbcp7RYC1fMWPKgJgq63TvCWUR/L0gg7l2fE=;
        b=UAmzsyNmTClCJNpwnT2Ddhj3rSGOky10bPrKDOahcp1HGxVcSDav84jkZOcOrlkgpM
         gW++qu0IJLZN4WJ7PvdkyLw2/BgDxP2ii6sCoSrnYpnX0XgKnwDGe10TCzx0whYc3MA2
         vYhDEgBi6XZv2+8FCAnMtcfK5DNPxImgG5lomH8NhmryODX1bTXZD/iU4UVGqBtQXNxy
         8XLj/FB5265BtbhOQpXvcz/Wjc3BkHgmrxMqCX29aNgQHe191nm9XLYA/m803roTUPEV
         PH8PQc/B/XAYj3nc4nUyq4crfZazjhdODALH+RTkRSwtGESM7te2LYdfiUbc5gIlvDdg
         81AA==
X-Gm-Message-State: AOAM531v7xz6r68gpzCTQwdXaPmJ+L8MLxElBRzMQGoratPAZyu9ngS0
        /H9Euf94pJI9pAwwIElFt2eGa5YW50NLn6RN5m6o7w7us3f0I6LFzPk=
X-Google-Smtp-Source: ABdhPJy09BnDGKdGTVqaOzrPyzHa3+ssp/1uUlO9lm8JxGeQ9tdNkAbrUpg6CaosEnAh9h/af13jxnzLvoOXsvi+yxw=
X-Received: by 2002:a92:cf45:: with SMTP id c5mr6423304ilr.259.1619270799767;
 Sat, 24 Apr 2021 06:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.939.git.1619195245606.gitgitgadget@gmail.com> <YIMsOV/O2Ss+qaeK@nand.local>
In-Reply-To: <YIMsOV/O2Ss+qaeK@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 24 Apr 2021 21:26:28 +0800
Message-ID: <CAOLTT8S9T7-WpgCJXZwt7rU5V72h+EMmRa+onkGjkRm53pEGDw@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] pretty: provide human date format
To:     Taylor Blau <me@ttaylorr.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing,
>
> On Fri, Apr 23, 2021 at 04:27:25PM +0000, ZheNing Hu via GitGitGadget wro=
te:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add the placeholders %ah and %ch to format author date and committer
> > date, like --date=3Dhuman does, which provides more humanity date outpu=
t.
>
> I don't see a reason why this shouldn't exist, and the patch that you
> wrote below looks pretty good to me.
>
> To refresh my memory on if you had missed any spots, I followed
> 0df621172d (pretty: provide short date format, 2019-11-19) as an
> example. You did a fine job here, and I don't think this patch is
> missing anything.
>

Yes, I saw Ren=C3=A9 Scharfe's (have --cc) patch and learned handle way fro=
m it.

> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] pretty: provide human date format
> >
> >     Reasons for making this patch: --date=3Dhuman has no corresponding
> >     --pretty option.
> >
> >     Although --date=3Dhuman with --pretty=3D"%(a|c)d" can achieve the s=
ame
> >     effect with --pretty=3D"%(a|c)h", but it can be noticed that most t=
ime
> >     formats implement the corresponding option of --pretty, such as
> >     --date=3Diso8601 can be replaced by --pretty=3D%(a|c)i, so add
> >     "--pretty=3D%(a|c)h" seems to be a very reasonable thing.
>
> Just to make sure I understand what you wrote: you're saying that the
> pretty formats "%ah" and "%ch" that you propose here could be achieved
> with --date=3Dhuman and --pretty=3D"%ad". Makes sense, but I agree that y=
our
> point about --date=3Diso8601 having a built-in pretty atom makes the case
> for having "%ah" and "%ch".
>

Yes, I tried to explain that "%(a|c)h" makes sense.

> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2=
Fadlternative%2Fpretty_human-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlt=
ernative/pretty_human-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/939
> >
> >  Documentation/pretty-formats.txt | 2 ++
> >  pretty.c                         | 3 +++
> >  t/t4205-log-pretty-formats.sh    | 6 ++++++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
> > index 45133066e412..9cdcdb8bb414 100644
> > --- a/Documentation/pretty-formats.txt
> > +++ b/Documentation/pretty-formats.txt
> > @@ -190,6 +190,7 @@ The placeholders are:
> >  '%ai':: author date, ISO 8601-like format
> >  '%aI':: author date, strict ISO 8601 format
> >  '%as':: author date, short format (`YYYY-MM-DD`)
> > +'%ah':: author date, human style
>
> There's no sorting here, so this place (at the bottom of the author-date
> placeholders) seems just as good as any.
>
> >  '%cn':: committer name
> >  '%cN':: committer name (respecting .mailmap, see
> >       linkgit:git-shortlog[1] or linkgit:git-blame[1])
> > @@ -206,6 +207,7 @@ The placeholders are:
> >  '%ci':: committer date, ISO 8601-like format
> >  '%cI':: committer date, strict ISO 8601 format
> >  '%cs':: committer date, short format (`YYYY-MM-DD`)
> > +'%ch':: committer date, human style
>
> Likewise. The rest all looks good to me, too.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor

Thanks!
--
ZheNing Hu
