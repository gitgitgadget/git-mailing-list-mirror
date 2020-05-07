Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F1AC35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8160120CC7
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNhR5JKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGXhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgEGXhs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 19:37:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9EC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 16:37:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j14so5967860lfg.9
        for <git@vger.kernel.org>; Thu, 07 May 2020 16:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tbBI8oN93LSkDKs6GfBq/v8ui1a++57AuO1sLSZBaiM=;
        b=FNhR5JKdEWn0lXiDQrCI0/pj8ldrBa3Nw42Nu8YvUBAWBGD8cntYzOXVKCpzKz5y5r
         tOJUTZaBN/URV34OSfd8L/skPAq7rL3fNubP3qbuh4uInBPA02eM+SO3m5ntDYa0x0yP
         +MsrJUmXkFjHqzBcDblEHiBLXsqJjrduGA6/PN2a9j2n1Wa0Rl+taoYWTj7Ay+OM7dRg
         Fijd4wNmlGkbLzLuB8EwmLGEfEYOzyMGLJotV6fc6xcsi82dPfPiqRcb89IB/nm9CS6Y
         xEeYOXzq9Zjdpu0yvCXmao7wrvHe17LzoGkDyKfqW13vZD8qUyOoLtDxO6PENBF9J3YX
         d9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tbBI8oN93LSkDKs6GfBq/v8ui1a++57AuO1sLSZBaiM=;
        b=kRCk0+0Oim6TBXFu3aVAy7cc6GPWG5DYaevxTFiv3m0FPuG9ZWOrkDnVRnPCvTGr/e
         DvbQKaa8masrHo3/PzekoM5YLDPVXFraKJZGmgocFyaFuc740m9zWHaqbx977ZRlpWap
         lmFqAyAm6brNYNUDiYwMvDjr5kJbgOaJNByy0g5/d22CpSHzKmPHa0VH/YTdTCm1qCh3
         wy86ORLT0JmBX54rr8lHflUuL4sw0xr20CMO3bp2Gtoc+gmXo/YuDH/55mpSOGjlO0nl
         J9xkFtpp5eT4O/cF9pFdE05RmCGLRActc8xe3bbJm4k3qkSFJlZM2i+T7KKCOiUUYvvp
         m1/g==
X-Gm-Message-State: AGi0PuZP18sHetptIK3mIEc4BCL/ZUM0/eJo22JAc74YDbz8Dx+mOQbj
        zl7AfZQ06uEGFwrEGovbVuJ+/QKRkZJsU2qFMSyIJUaG
X-Google-Smtp-Source: APiQypJAQrIEyRsLWxPrDRiAcpRu9E23xmEMVfcoyWWfOt7svW12fGkgzYLIS5viNWtbeb2KzpcZGQAORzdeyvzRU44=
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr10527963lfe.14.1588894665841;
 Thu, 07 May 2020 16:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
 <06da01d624c7$acb17090$061451b0$@nexbridge.com>
In-Reply-To: <06da01d624c7$acb17090$061451b0$@nexbridge.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Thu, 7 May 2020 16:37:34 -0700
Message-ID: <CA+KyZp7Ur3kW3qrCe3hOz16gA9y_B7rSGin62=eKMjCCqLsR4w@mail.gmail.com>
Subject: Re: check if one branch contains another branch
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I assume that:

git branch -d  xxx

will prevent a delete if the current branch doesn't contain xxx..
I don't want to have to checkout  origin/dev in order to run that command,
that's one part of the problem


On Thu, May 7, 2020 at 4:31 PM Randall S. Becker <rsbecker@nexbridge.com> w=
rote:
>
> On May 7, 2020 6:59 PM Alexander Mills, Wrote:
> > To: git@vger.kernel.org
> > Subject: check if one branch contains another branch
> >
> > I am looking for a command:
> >
> > 1>  if branch x contains branch y
> >
> > right now all I can find is
> >
> > 2> if current branch contains commit y
> >
> > can someone please accomplish #1 ?
> > Crazy hard to find an answer to #1 online.
> > The user case is to delete old local branches by comparing them with th=
e
> > remote integration branch.
> >
> > more info if needed:
> > https://stackoverflow.com/questions/61669056/how-to-determine-if-
> > integration-branch-contains-feature-branch
>
> Looking at this slightly differently, if you try to delete a branch, git =
branch -d feature-branch, and the branch has not been merged, then the dele=
te will fail. A simple way of looking at it is if the HEAD of the branch ha=
s no successor commits then it is not merged (not 100% decisive, but git br=
anch -d is). It is not really that a branch has been merged, but that a com=
mit has successors, meaning that it has been merged. However, unless you ar=
e using GitLab, a git merge --squash will not answer your question even if =
the branch was merged.
>
> A better way of looking at this is in terms of Pull (GitHub, BitBucket) o=
r Merge (GitLab) requests. Has there been a Pull Request for a branch and h=
as the branch been closed? Meaning that when you do a git fetch --prune, yo=
ur merged/deleted branches go away unless you are on that branch. Looking a=
t the Pull Request history is much more useful in determining whether a bra=
nch has been integrated into a main development branch or production branch=
 in a GitFlow process.
>
> It is a different way of looking at the problem, but IMHO, a more represe=
ntative way when taking developers and deployment into account.
>
> Regards,
> Randall
>


--=20
Alexander D. Mills
New cell phone # (415)730-1805
linkedin.com/in/alexanderdmills
