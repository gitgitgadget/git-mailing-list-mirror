Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2E9C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05EF61042
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbhERIKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345704AbhERIKF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 04:10:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21CC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:08:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso1131468pji.0
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=79Xsp62T2rn1O6XJUsW9j8vWIjGJ3R8QmGAfxq8dGeA=;
        b=PAQcq2rIA3CPNux1AVX46XNTRw7JS8iaWbruKV9I2nCUM92XCfTWMtlvlC/6Gf1dCD
         p6ZD+xI0ftGgbhwXOPZg654VMWXTB0Q60A2VwmHLJsayAkRCid6A8tjIav1rgt2Rjzca
         IsLsRFWoDQxGLKcRhhBAzzEEyh3ixCAsYVE9HQFC3nK1tXb6Vh6RW0JQ6khjw6oNJPUm
         b7ya7rmaCNAsiLCXsrqe17K6I0ED1auVd2jUnoNLBdWMYx80raEdLnY5Q83Vl1iygrSv
         jx7kYTgriWuujS0DljefreGe0hDhohcIx8tVc2nqDxQtI8exnKk1P3Lpcx9UYtnCvhbk
         b8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=79Xsp62T2rn1O6XJUsW9j8vWIjGJ3R8QmGAfxq8dGeA=;
        b=uYINVXorXJh1RryC9zXcJ39YC/jg5tJUbe1Ic666z5FWU0t53OLFht4DKmZW2UqpWR
         AVctoNqkIqA59gu1T/W3DuFpBG1rnCuGFNa52xG5FjT+03EflcCctonZgvDdJZs/mYGK
         ONCM3KcDWKwHjE4ZlUh7l4SEXaKM04FgVjIPCt3Jpw4h2BnmSLtHe4J6qno+06bXA9jV
         so6NvybdxJ+aL/9GoJt9d9ZxAuo+5TzeFxiy6nplc3MpFweQaWpmUJxb620KunZVjLbO
         Ax9Sgu1cOB3yJlX/pFns8Ui5JfWAzFto3HnGsQ9iAxiTjx0+7W5myE2WRsg/QwTSfWyb
         A9uw==
X-Gm-Message-State: AOAM532hfYQ7BSzOGxXuyetpOO92lwYC7VhBTxqDVh8e5Bo/qoOdASo4
        FCLkTPB1k7aZiNwfgXuEDuYLE9cqRSagJB0NYV0=
X-Google-Smtp-Source: ABdhPJyWvyHrRnkU5IiJzVIgNkSz+nYfIjbfmOZuvgGrgZUgcZ/HVDSXPU8cyv1c7eWMgRiv+rSSmtzESsEk1Y2k1rg=
X-Received: by 2002:a17:90a:29c4:: with SMTP id h62mr4330864pjd.177.1621325327525;
 Tue, 18 May 2021 01:08:47 -0700 (PDT)
MIME-Version: 1.0
From:   Teng Long <dyroneteng@gmail.com>
Date:   Tue, 18 May 2021 16:08:36 +0800
Message-ID: <CADMgQSReX+Ue0AtPh6JWNde-pyFC5-r+juQFoKd5fZp5Wv6_Ow@mail.gmail.com>
Subject: Re: [PATCH] Packfile-uris support excluding commit objects
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso wrote:

> It seems like this and your
> http://lore.kernel.org/git/20210506073354.27833-1-dyroneteng@gmail.com
> should be part of one series, not split up.

Obviously, the current series of patches will be longer, and the patches
of the separate documents you mentioned can be repaired and released in
advance. The latter, Junio said, will be added to the queue.

> Per my understanding in
> https://lore.kernel.org/git/87o8hk820f.fsf@evledraar.gmail.com/ this +
> Jonathan's earlier bfc2a36ff2a (Doc: clarify contents of packfile sent
> as URI, 2021-01-20) still makes this whole thing more confusing that it
> needs to be.

> I think we should just have a new uploadpack.excludeObject, and document
> that uploadpack.blobpackfileuri is an (unfortunately named) synonym for
> it. I.e. the actual implementation doesn't care about the objec type it
> just excludes any object listed via an oidmap. No?

Regarding the naming of "uploadpack.blobpackfileuri" and future
scalability issues, I have similar feelings. In next round, I will follow
your naming suggestions about "uploadpack.excludeObject". In addition,
the naming modification may cause a compatible question, although I know
packfile-uris is an experimental feature, I still hope to get some
compatibility-related suggestions.

> I realize you're probably not a native English speaker (neither am I),
> but I honestly can't understand that "This work will be done in a
> further patch recently.". Do you mean something like:
>        ......

Thanks for correcting, I may rewrite the commit message in the next
patch. I'm not a native English speaker, improving :)

> Please send the earlier doc cleanup + the spec change for this + any doc
> updates as one series.

The reason for splitting the two patches is mentioned above, and the
corresponding document modification to support the exclusion of commit
will be added in the next patch series.

> Nit: Split this across two lines.
> Indending with spaces.
> More indenting with spaces, also don't need the {} here.
> Don't indent the "then", also spaces...
> Use ">objh" not "> objh".

Thanks, will correct them in the next round.

> I think by having a uploadpack.excludeObject documented as the primary
>interface to this we could just say "object already listed by an earlier
>exclusion" or something like that.

Thanks, will refer to your suggestions.

> This whole if/else seems like it could be better split up by discovering
> the variable first, using that as a variable, and then avoiding the
> duplication. But if we just used uploadpack.excludeObject...

I will try to modify it, but I am not sure to fully understand what you
mean. If this problem persists in the next patch, please help to point
out the problem.

> Put stuff like this in "test_when_finished"
> You can just use test_commit here, no?

Thanks, now I know about "test_when_finished" and "test_commit".
In addition, there are some problems with using "rm" directly in t5702,
I will replace them in the next patch series.

> Personally I'd just skip this whole "rev-parse HEAD" etc. and just pass
> the tag name(s) created by earlier test_commit, then have
> configure_exclusion ust always do a rev-parse...

Thanks, will use tag name(s) instead of "HEAD".
