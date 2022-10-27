Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337ABFA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 19:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiJ0TPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiJ0TPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 15:15:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5E3DF13
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:15:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso2381124pjc.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l6zm+CkFV1CKuXRhv8YRBtwhEyGmS7YrD1ytJfhKebU=;
        b=Q9nP8mBXpCveUjWk5KfJ3vBAtjVzmUV2OAzHh3wfxo1GQJb64QZtNs5YnmU8esNnOf
         86IhDusSLyr0shJO90ydJYbDRhOq12yn4v/6O9+xOGmLr8KfjM6AWC0o7P6dEm1gDj9N
         TdFjVrpZsQy8MjP3AfYAxLptTvO6q0dCLd5IIYzJem1sCA0RLFQUTW38Xk48joafKJRb
         Sw+xYtpP1dmfaQ6YU4bBrG9hMtGMRMSphJVItAa0dtFBz6RU2R4H7gOtGK2xpqgLciXh
         qQSbZR54gy60eebwAo//txvwW5j0ucL9S0y0mPpw4zUAaEH75L9+KH09puySfkudxl0d
         NTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6zm+CkFV1CKuXRhv8YRBtwhEyGmS7YrD1ytJfhKebU=;
        b=rCppkFKfV/gW7Cbw1VaPMPIZRwMMdLvsT4QTfcE7ftdmZix5riRwhrYP6y9P0eMo0H
         Uguw8V2WrivW/kF1Zvy4qvpIzzOeX1fJlgpDrbdfRisb6Ip8jpzKGqcRTOcK3E8o+TA/
         uhFQOOUIx0nnXsAumUQq0o5A7lQt+Oko0lTKcFk2/UVgSJpTEW3PiOYvhOtPx+Va7pTn
         Nnj5Qz0pDFiLw0clWc+XQet2kS+bwpITjKaE5+co9+0xlG/zCgzRZhrXhDN+To2XP1DR
         L/hAJAoEyu9g5WQi0Jrygj3M2nu13CnkXJtHDAEw+NNMLyRjaRVNqyrQj0gufUgWitOQ
         U8cA==
X-Gm-Message-State: ACrzQf1pLLwBK6LWAXd8wzBsgddQUwshWBqlZhXlULpFo1t4OcjZCnYs
        pJDqVRbNHkGa1w/ekrtPvCp2BCuFBNRtkNtX67k=
X-Google-Smtp-Source: AMsMyM7hRG6VdC0RkhAW7DCCwvOKBBMSOX5Qjj31LgpyQuhQn3c5GKG4DruDudDT73ybH/65z2xth1mUxTndPY3R6wI=
X-Received: by 2002:a17:903:2cf:b0:186:61b8:84d3 with SMTP id
 s15-20020a17090302cf00b0018661b884d3mr40920175plk.34.1666898143530; Thu, 27
 Oct 2022 12:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
 <b0008377-2cb5-72ff-e94b-8182065b3436@iee.email> <CAB9Jk9BBddd5d0wKFB0eJw1OMMAQj88J9Bn1Yn1rbK_F1mEs1A@mail.gmail.com>
 <2ed22fa1-4d9d-e50a-18cf-048007272729@iee.email> <CAB9Jk9DPdVmmb2DPDKPm5FLGr-XJa5kNouCYmcjh534Y2z1rVQ@mail.gmail.com>
 <xmqqo7txmazv.fsf@gitster.g> <CAB9Jk9BC1PVxuuNggZuDh1OMe3kdTvCzwkoo7Bkm35nRqAaL4g@mail.gmail.com>
 <xmqq1qqtm7i0.fsf@gitster.g>
In-Reply-To: <xmqq1qqtm7i0.fsf@gitster.g>
From:   Angelo Borsotti <angelo.borsotti@gmail.com>
Date:   Thu, 27 Oct 2022 21:15:31 +0200
Message-ID: <CAB9Jk9D1g3a+AHoPneMAzc6uTiW89zYQ32cNFJtxFZ71Eh9QHQ@mail.gmail.com>
Subject: Re: Git add documentation error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Git tracks contents.  What it means is that you should stop thinking
> in terms of "changed files".  Each commit (and its tree) represents
> a complete snapshot.

Sure. I know it well and know that this is one of the most important
features of git.

> "git add C1.java" is a way to make sure that, if you make a commit,
> the resulting "snapshot" includes the current contents stored in the
> C1.java file as you have on the filesystem at the time of issuing
> "git add" command.

The behavior I have seen tells me that the safest thing to do is to
have a list of the files of the software, and build a script that makes
a git add for each of them, to be run each time before I make a commit.

Concerning the fact that changes are somehow "immaterial", this is
good for a software that is developed by one person, but when there
are several, and the released software has some unwanted changes
in it, one may wonder who changed what. It could happen that a developer
added some changes of his own without telling anybody (perhaps using
files that he has prepared for a next version).

Have a good night
-Angelo

On Thu, 27 Oct 2022 at 20:44, Junio C Hamano <gitster@pobox.com> wrote:
>
> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
> > Hi
> >
> > I have displayed the contents of the commits with the command you indicate,
> > but they still look much the same:
> >
> > D:\gittest>git ls-tree -r --name-only 91ef45d
> > C1.java
> > C2.java
> > C3.java
> > C4.java
> > C5.java
> >
> >
> > D:\gittest>git ls-tree -r --name-only 8ec0c2f
> > C1.java
> > C2.java
> > C3.java
> > C4.java
> > C5.java
> >
> > I thought that in the second one I would see only the changed file.
>
> Git tracks contents.  What it means is that you should stop thinking
> in terms of "changed files".  Each commit (and its tree) represents
> a complete snapshot.  Back when you created 8ec0c2f, did you or did
> you not have C1.java?  You said you did not modify it, so I assume
> you did have it.  As a commit is a complete snapshot of the
> contents, when you list the contents of 8ec0c2f, it should be
> included.
>
> To put it another way, if you "git checkout --detach 8ec0c2f" in
> order to go back to the state you were back when you created that
> commit, do you or do you not want to see C1.java and C2.java?  In
> order to be able to reproduce the then-current state, of course
> you do want to see, and because each commit is a complete snapshot,
> you can see C1 and C2.
>
> "git add C1.java" is a way to make sure that, if you make a commit,
> the resulting "snapshot" includes the current contents stored in the
> C1.java file as you have on the filesystem at the time of issuing
> "git add" command.  If you made or did not make changes to C1.java
> before running "git add C1.java" is immaterial.  We may optimize out
> and make it a no-op if we know you did not make any changes, but it
> does not change the fact that the resulting commit will store, and
> more importantly, you will be able to recover, the then-current
> contents of C1.java out of that commit.
