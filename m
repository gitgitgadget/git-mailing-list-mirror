Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0ABC43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 02:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiGHC1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 22:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiGHC1U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 22:27:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF873932
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 19:27:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d2so35510995ejy.1
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 19:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2f1TWZ2YhqqAQAfEBS5MliKKh33fgPxEYgpRrVNEds=;
        b=f3t52jm+slV/U73qx/qNDNadxx+pvE0hZk2ydcCYTQtI9TXQihX643XJ8QMD0fBCN3
         j33X46potqsJVIxPEnzshloxyEREBPOYPL9JaPzHwWwcE/dAk+c0FL3et9c6Af0SdwSm
         azB4ESrDcQC+/O60/M5sylOy/OFKkhb/KJ3uzL6pSMypIAV+x+5BWEZyhAcW99Ylv9Yd
         P1nz9wMpqAlcVWNghU7CFyRfliV1cMHFbajkSBdToAR2KxcHPmMBc3+c/OhMZ3KwFnoD
         7xKJ4T4HJryYoCSOoG4i9EtlXqcmfCizR5bYI1hn9ujxlsHS7r02iEHMd+jeRPfn1CcH
         AUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2f1TWZ2YhqqAQAfEBS5MliKKh33fgPxEYgpRrVNEds=;
        b=nB4ng4/QYWTBP0uw0PCBzCcJrUhql5qbdCSfYqZoyZJF9BnX+xGkM9PEia/aZDc74f
         HIWa71tIT994fnWnBZDrwrrDOsZA7w/IKJtG1LqyQUCn49UF4mvSwuTnmjbOHxDlNqeY
         igCBt7HSUSc9n1WYf+HvUKP5wVjcZxxpJiK9YXapnSQXAbqves0eAKINPAvRGYZ1VQdv
         rM1dYF5QZu3fV4vdmYjQOwIDszYlBZs55ekoI90koObJffQCKqpHQVQU66XQDirS78EM
         7IDQXmHS00q93pbobM+YotRgY0coiH9ylOKOBiqUn3W8URxrVK9EZDgeHZg7BgF+l31a
         WD0w==
X-Gm-Message-State: AJIora9ifz9XjYCSOgzR1+OnO43Xs1t1jEzEpF9ALF4HO8BXQGB7Yefu
        BevH4ldzfik5iXoK8ow3aTJ/h+5Vir2XXdpTebw=
X-Google-Smtp-Source: AGRyM1tSMdcg31GdZIwipfPMq2qcHwRsJQ8XwZn0bGJcjsPBEW16NjBo0Tq/m5aXLQvrL/9VfzI9lTIuhnYrZLN1BOo=
X-Received: by 2002:a17:906:a245:b0:708:ce69:e38b with SMTP id
 bi5-20020a170906a24500b00708ce69e38bmr1267992ejb.100.1657247235856; Thu, 07
 Jul 2022 19:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com> <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
 <CABPp-BFqLP51q9RkJr=16+Aqq7R=tYqL5mZGUq-dvfn8LL2AMQ@mail.gmail.com>
 <7dd69bb1-8bc7-3ae9-6265-bdba660b4c4a@github.com> <CABPp-BHOSHYLEpH_222X_Pv_hZeDwy10zLejrVgwgf6W-pFVyw@mail.gmail.com>
 <84da5ea6-b6a9-7756-66f4-a3832144a68e@github.com>
In-Reply-To: <84da5ea6-b6a9-7756-66f4-a3832144a68e@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Jul 2022 19:27:04 -0700
Message-ID: <CABPp-BFQbG-qQK2biKMV7cE641BzNwk324Gn5eEFUyiz7k4c4g@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] rebase: add --update-refs option
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 5, 2022 at 3:22 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 7/4/22 11:57 AM, Elijah Newren wrote:
> > Actually, I checked out ds/rebase-update-ref just now to try it, and
> > it seems like it does the right thing:
> >
> >     pick 111111 first commit
> >     pick 222222 second commit
> >     fixup 555555 fixup! second commit
> >     update-ref refs/heads/branch1
> >
> >     pick 333333 third commit
> >     pick 444444 fourth commit
>
> Thanks for trying it out! This is definitely the main goal of the
> feature, although it is also helpful when resolving conflicts or
> doing 'edit' steps.
>
> >     # Ref refs/heads/branch2 checked out at '...'
> >
> > The last line was very disorienting to me at first and made me think
> > we had a bug, but the update-refs stuff is built on top of the normal
> > rebase mechanism and branch2 will be updated by that logic rather than
> > by the special update-refs handling.  If I add another branch with a
> > few commits on top of branch2, then branch2 is indeed updated and
> > after the pick of 444444 (and the additional branch, say branch3,
> > would be updated by the normal rebase logic instead of by the
> > update-refs handling).  So it all works correctly, but users might get
> > worried or confused along the way wondering whether it will function
> > correctly.
>
> I'll add a patch that removes the comment in the case of the HEAD
> ref. Thanks for the idea!

Thanks, that'd improve things.  I'm curious whether it'd be even
better to have an update-ref line for HEAD, so that users don't wonder
whether it's omitted from the updates.  (That would leave an open
question whether you filter out HEAD before actually calling
update-ref, or use some other mechanism to make it all work behind the
scenes.)

> > Another part that users might find disorienting is that at the end,
> > the rebase reports:
> >     Successfully rebased and updated refs/heads/branch2.
> > which is correct but totally ignores the fact that it *also* rebased
> > and updated other branches.
>
> Good point. I can add an extra message at the end (as well as a
> warning for any refs that did not properly update at the end).

Sounds good.
