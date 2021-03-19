Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67972C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2956F6198B
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 23:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCSXWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 19:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCSXV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 19:21:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E943C061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 16:21:56 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so9797632otb.7
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=or7Tnje+YkZ4h6GtFDUOUt7hW9wsnmcLoAAZn4RGYik=;
        b=fShiVdrYhcABXsM0BcHSC3J7uIDm5MbFiQ8rsVOmmHnQhAGQiECgE4BhAefNO6e61z
         Z9I0b7Ed2ojYXM6B6JmCkpyx9AShEnOEkcYoXfQD/sbZR/ky/egDcJ63R1naUec3hZA+
         inwj7iETN34YrVg8B+2jMFPX3XpS+CnPd3w/AOPhzWW+W/eXk78vDN7UWJ2NnqWifuNl
         M6nnA+npCrukQt09ZWpSk+94GJPqqFGSw1VSxVVdOFa8EDCU0nscHJQDVU6WMdWC+rbJ
         CXLhvo2X5QkBSZQ4u4jBJ4UV3PRJcIRlLzQzlMjr9gjyp123zXbofsKpbTIIH+Om5/Kr
         dASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=or7Tnje+YkZ4h6GtFDUOUt7hW9wsnmcLoAAZn4RGYik=;
        b=FFBqBzM8X7pNe5UgkoUZ1Q7sIzOZkMoH/+goVRhSYDvOBIdhQobJZZF8oj/wDGnBES
         Q4qbR6qBgNtU4Wtyh4kJbPYziN+11kQelLjJ1KDfNwrqD71bue8xrJ2aNnQU6CgJXkBv
         3RXTUeWG5jgaqGRi/WFJltixd3g/Lev1v5hywNcV/xKSImHZeEqm5pVlAaNukAVXgq/e
         A1F2zIIE+ZYXG68OyT044HZL2ck7QUE61KzkRCsDQRyp0N96H3XYvRd6fHHwYRzBoh5D
         MVIZJH28MrIaMq8m6IJS1tWcrAS0ryxToOUU0I0ATtW5N0Ilw158YrW2src3LPnSIgcp
         e8Dw==
X-Gm-Message-State: AOAM5300ZAUNQm8NMcFeFFmNlW6aXsXGpXhMYodLdv5q3C4FkHFLjmy9
        F6mA0Y3B8Uw9qpLl2xuUHgTTyQH17D8YIj4SQkg=
X-Google-Smtp-Source: ABdhPJylHFoYFmaHI2d+wKNOBJGdMVgiYXUvrtyiFdBdMkFLjDiCa1KSiDvt+gn8qOFek3tOMsx7Qhflm5FOZda0DWo=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr2898388otf.345.1616196115965;
 Fri, 19 Mar 2021 16:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
 <pull.905.v2.git.1616016485.gitgitgadget@gmail.com> <80cccc70-296a-05d2-94a8-0e005e4abe1d@gmail.com>
In-Reply-To: <80cccc70-296a-05d2-94a8-0e005e4abe1d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Mar 2021 16:21:44 -0700
Message-ID: <CABPp-BGm1R0OVywK50eMf9OWKv95nA+V2bzX6WLm2iFvfN_i9Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Declare merge-ort ready for general usage
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 19, 2021 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/17/2021 5:27 PM, Elijah Newren via GitGitGadget wrote:
> > This series depends on ort-perf-batch-10[1], and obsoletes the ort-rema=
inder
> > topic[2] (that hadn't been picked up yet, so hopefully this doesn't cau=
se
> > any confusion)
> >
> > With this series, merge-ort is ready for general usage -- it passes all
> > tests, passes dozens of tests that don't under merge-recursive, and
> > merge-ort is is already significantly faster than merge-recursive when
> > rename detection is involved. Users can select merge-ort by (a) passing
> > -sort to either git merge or git rebase, or (b) by setting pull.twohead=
=3Dort
> > [3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=3Dort.
> >
> > Changes since v1:
> >
> >  * subsumed the ort-remainder topic (the first 10 patches), which has
> >    already been reviewed by both =C3=86var and Stolee[2].
> >  * the next two patches were the original v1, reviewed by Stolee
> >  * the final patch is new and adds testing.
>
> Sorry for the delay in looking at this. I read the two series before
> this, and found this to be a good union of them.
>
> My only question on the final patch is a two parter:
>
> 1. Did you mean to go this far?

At least, yes.

> 2. Did you want to go farther?

I like your suggestion in the other email; I'll resubmit to take
advantage of it.  :-)

> Mostly: how much do we want to prepare for ORT as the default
> strategy, at the expense of reducing testing of the recursive
> strategy?

We definitely should prepare for merge-ort as the default.  There's a
question of how soon the switch should be, but no question in my mind
that we should move towards it.

What do others think is needed before we switch the default?
Personally, I think there are three things:

1) merge-ort must handle the same cases that merge-recursive does
2) merge-ort must provide some benefit over merge-recursive
3) folks on the mailing list need to be comfortable with the default switch=
.

What would others add?

The first 2 conditions are already met, in spades.  For all the code
that calls merge-ort, merge-ort handles all the same cases, is more
correct, more performant, and more featureful than merge-recursive.  I
was surprised by how smooth the roll-out was and has continued to be
for internal users at $DAYJOB.

The only question is item #3.  If it weren't for that, I'd say we
should switch the default now, because AFAICT delaying the default
switch will just delay when expanded testing occurs, and I have run
out of other ways to expand testing.  But I realize I'm the only one
who knows that and is comfortable with that.  So I'm not proposing a
default switch yet; I want to hear feedback on what others want to see
done before we switch.  (At some point in the future, say another year
or two, I'll ask what needs to be done before we *delete*
merge-recursive.[ch].  But that's still off in the distant future.)
