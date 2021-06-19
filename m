Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42899C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 21:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D2C601FE
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 21:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhFSVrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 17:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFSVry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 17:47:54 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB8C061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 14:45:43 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l12so15203011oig.2
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wxjwypMMvt429b2I0P94FlyPcwHYQnLgr/Ye11Bs/bM=;
        b=qwKO2A5IRsSIjuGDjgdZ/XSYn0rnEGprDKP7chbSIoW1T525u9tjgOlTJAMRyrZpFy
         d/tx+SlB55o7DRB5O71qIoqRmLOEr9mWJitMkqM5Z0YJmDtKD3vgJWKvwEIimV4v2Djc
         BxvTOBTS72CKwjMcqRMnwzNCyjteSbUABtwZPZeqvDOos3QbvO6c57FM6BRmWBzAs2sE
         Vvp2J2lPDQpryZyvTdukKuUoJBmoANbpRKmgvqZuVln4MJSLjJmL3cTHb47kM0HLipf5
         XpSzT5cZPMuD4W8ELiwYA1rmKjXjuFxx9l4b/qSrWTy465altaeEDSwJ8ksBDTwO3DmS
         bgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wxjwypMMvt429b2I0P94FlyPcwHYQnLgr/Ye11Bs/bM=;
        b=F/gtJFHGg++jFJn6xFNOTGyIz0hfw+Oc6zhDS/IG1li86+IYg1EWjZZbsk6mEntNob
         7BV5BiyVqT15gcp8apI5DfBuGCAW29N+5Sskxse1maR0EYTuBdtlksJ9l+OGkYeBrSd6
         FG+DJV+Rds8x7Oheb4Okl14qvitc+QDL4nsDn5STb2KkYdbUlkKRZpVsKisocacZUmT6
         Q+r0a12e1S214cwzoOgmWQ8paqaoUxmeaUrWlckv5bSQt1jVCxfxxZyNM+t2noBHBXuS
         o0i07VPF5HN9fkblPPAMIQQvT/2ZwWPXM45ycZ436hd55qsDZadRjDqT2yP/8WZrDdaA
         vb1A==
X-Gm-Message-State: AOAM5334GPmUR8YbysvVFX9UCovUD1Suwd4PoI8x6PealJb5gebWbojG
        tg1+sBh/Nb+U2jeiCCpsEC8=
X-Google-Smtp-Source: ABdhPJwCnrXc2y17HyBu8sjtrzUcesUYE6aSgjhMcMmzVZoupGm+ROMpTEnp0eRLwyj8+nV4RtiHng==
X-Received: by 2002:aca:f547:: with SMTP id t68mr19600300oih.75.1624139142815;
        Sat, 19 Jun 2021 14:45:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w186sm2689199oib.58.2021.06.19.14.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 14:45:42 -0700 (PDT)
Date:   Sat, 19 Jun 2021 16:45:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <60ce6584e36a3_d067c2084@natae.notmuch>
In-Reply-To: <CAPig+cRHBFodZ=ZJzpU208AWMSD-V6xH8zKZwmDPJk5eeu571w@mail.gmail.com>
References: <60cc1749b1c4d_5d12520825@natae.notmuch>
 <CAPig+cTr2fEYN2y7FyKaspuaCpAq6wNtHgg_8RcrOmvsN5+XaA@mail.gmail.com>
 <60ccc3332428c_5eaa2208df@natae.notmuch>
 <CAPig+cRHBFodZ=ZJzpU208AWMSD-V6xH8zKZwmDPJk5eeu571w@mail.gmail.com>
Subject: Re: Only 27% of reviewed-by tags are explicit, and much more
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Fri, Jun 18, 2021 at 12:00 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> > I've updated the script to consider all responses to the cover letter=

> > that start with 'Re: '.
> >
> > Anyway, with the updated script the explicit reviewed-bys are 40%, an=
d
> > here are the stats:
> >
> >   5. Eric Sunshine: 38% (45/116)
> >
> > You got considerably more, from 17 to 45, but still pretty far from a=

> > 100%.
> =

> The numbers produced by your script don't agree with my own
> investigative spelunking through my own mailbox. What I found is that,
> via 33 emails, I've given my Reviewed-by: to 133 patches[1]. If the
> 116 computed by your script is accurate, then that means that not all
> of my Reviewed-by:'s made it into the project, which is believable.
> Nevertheless, according to my own mailbox -- accounting for 133
> patches -- I have almost certainly given an explicit Reviewed-by: to
> all 116 of those patches your script found, which means the script
> output should probably be "100% (116/116)".

No, the fact that you gave your Reviewed-by doesn't mean Junio took the
trailer, or even the patch.

Take for example this one:

https://lore.kernel.org/git/CAPig+cTgoD-GvpoBQ6tcGX4T2XhuKccJAZ40P76vxVD_=
PfEc9A@mail.gmail.com/

You said Reviewed-by, but Junio put Helped-by in the commit message of
d228eea514 (worktree: accept -f as short for --force for removal,
2018-04-17).

Or this one:

https://lore.kernel.org/git/CAPig+cTcqSa6AfeMQivnSdL=3Dy2+WWw2MtSavDciMc8=
4RcKURMA@mail.gmail.com/

You gave it, but Junio didn't even mention you in any of the commits of
this series, like 6b15595151 (t3200: unset core.logallrefupdates when
testing reflog creation, 2018-06-22).

Same for:

https://lore.kernel.org/git/CAPig+cQ2NRO4yaFkcGmUpY3TZcWkdg-vu6d7Fq7JgHzY=
SkcRgg@mail.gmail.com/
https://lore.kernel.org/git/CAPig+cS4Bj4N8d1a29z8=3Df30owOec1pB=3DyF32ZUP=
mDH2Tu2kXA@mail.gmail.com/
https://lore.kernel.org/git/CAPig+cTaOTfwzodKSabdy9HFbF66RuEXwmvjZ8QuQVFM=
aVpA7w@mail.gmail.com/
https://lore.kernel.org/git/CAPig+cSC8RZJ-+uP=3DZExVH2ZyexfQmLjzdjoBA7yuW=
kdYE4EGQ@mail.gmail.com/
https://lore.kernel.org/git/CAPig+cQ-yLnjrsB1E-7=3DUXfGzuJHat6YtfS8EVRNP2=
dcjj_6TA@mail.gmail.com/
https://lore.kernel.org/git/CAPig+cT0-ftZZyRORx-W2_Nit6XdgrpiyGS=3DpRjGtH=
oz1jW+Kg@mail.gmail.com/

These were never merged:

https://lore.kernel.org/git/20160216050915.GA5765@flurp.local/
https://lore.kernel.org/git/CAPig+cSSdGeMuV1XLqROXvSeYfmkNc_N7E_pzfJWdDR6=
wfD80A@mail.gmail.com/

This one Junio changed the title of the patch, so the script could not
find it:

https://lore.kernel.org/git/CAPig+cSuCouNCuKa99mct4UMPykuMVy3+7sqB6y+v+Ut=
P2oeTw@mail.gmail.com/

However, there were instances where my code did skip your mails because
they were in a patch series that was sent as in-reply-to another patch
series. My code did not consider those cases.

Taking a look at all the instances from all the people where a
Reviewed-by is nested deep inside a thread I noticed that with very few
exceptions almost all of them refer to the entire patch series. So I
updated the code to simply consider all the replies in the thread.

I ran the numbers yet again and now it's 62% explicit Reviewed-bys.

You have 94% making you the second top explicit giver, there's still 4
commits that got your Reviewed-by implicitly, and 2 that my script
could not find because the title was changed.

https://lore.kernel.org/git/CAPig+cQxAxFUFE8j2O7iaZoAby9ioNd6Wf1OVAr5qU7k=
TrQOyQ@mail.gmail.com/
https://lore.kernel.org/git/CAPig+cRgLyjNW+7EwXZB-=3DxNej=3DFR_1dqneR8Vaa=
HzFaYHiOBA@mail.gmail.com/
https://lore.kernel.org/git/CAPig+cTFsZCowqNxmNtr1za+O6KjZmqJBZLGmUFd77rH=
mD+5pQ@mail.gmail.com/
https://lore.kernel.org/git/20150918222524.GA22410@flurp.local/

1. Jonathan Nieder: 89% (281/314)
2. Jeff King: 11% (28/248)
3. Stefan Beller: 69% (132/190)
4. Matthieu Moy: 67% (88/131)
5. Eric Sunshine: 94% (110/116)
6. Derrick Stolee: 71% (73/102)
7. Taylor Blau: 75% (63/83)
8. Michael Haggerty: 85% (47/55)
9. Elijah Newren: 89% (42/47)
10. Johannes Schindelin: 48% (17/35)
11. Jonathan Tan: 71% (23/32)
12. Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy: 33% (10/30)
13. Ronnie Sahlberg: 100% (16/16)
14. SZEDER G=C3=A1bor: 0% (0/14)
15. Luke Diamand: 7% (1/13)
16. Felipe Contreras: 8% (1/12)
17. Johannes Sixt: 40% (4/10)
18. =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason: 66% (6/9)
19. Stefano Lattarini: 62% (5/8)
20. Torsten B=C3=B6gershausen: 28% (2/7)

Although we have many people in the 60%, 70%, 80%, and 90% range,
there's still plenty in 10% and 20%.

Here's the histogram:

https://i.imgur.com/jwqEp5H.png

Still pretty far from 100%.

Cheers.

-- =

Felipe Contreras=
