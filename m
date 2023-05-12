Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA5C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 03:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbjELDqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 23:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239682AbjELDqw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 23:46:52 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069CA1FF1
        for <git@vger.kernel.org>; Thu, 11 May 2023 20:46:52 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso13899569276.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 20:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683863211; x=1686455211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpxRninhNQpunStHzrulWsUCpd/hx1v7hgDplDrPFHM=;
        b=XKJLIGJVwZx/lpUPu3l64JiFUFy2D5f+Q4cayQpPtMj0VVMEotlClC+oy6pKRkl25p
         aBiIkvyvuN16q+rlYt/5yO9EaCfJnDW5Koc7XxVWlXDwS2/R0XqtelWROjPbNX33Xlxn
         w2FOiEVpf19NbxeTvrQKq6LeF0G28Nb4AjZ4OOutNxD6NPy+wJzmjmTE28n5dRt1dyfj
         aDG6IXFdHNwjbHpId8XE/hYhXuRbk0e2dNq66Pok9mELKe4B/H+9Bd62B3uNmcXP4b7G
         VajGHDLN67et3r5+Rz7ZVvCViBOwVVN621O2FETqNtvL4Q55zJlgdoMqGigItO7XSvMT
         +W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683863211; x=1686455211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpxRninhNQpunStHzrulWsUCpd/hx1v7hgDplDrPFHM=;
        b=jU3dx3DdjvfEdUohAXQu+hNP1iqsbT0LDr2Lo83fAkkqPrK/oFpbOy1fmgIFtLrwnx
         JblOpQi17431xjm8w5OLZKQZ+KksQVNdbrC8i/3gTh6XfohYZ4c8AMwyQ3CYnbZfBQIU
         otpwHfGqXYwELClfYA9yU1zNnlp+HhdStTH5i8bdxqxyD3/mUGHx7PB+48f7crjzhTKD
         B7k02wOP58/Hc0m1IskPQjhWpw8LnOJhGExYQiLZBvJN8dr9sPp+WHeC7/JWuBX3eCNs
         EcK6/alHra4/3akkfSJLjM2+1x2C071D4MnuvXFypTwSB89WK9VvQ/r1nf3QykltxdaB
         DBSw==
X-Gm-Message-State: AC+VfDzNLFs/qtq75ie0aZ/RMyT/bqAhx7/m7VQRf/HVtPHu1+s9FmGh
        8w+S5nRkLKqLuIpsrbh7EJTYL6o7WSK1SjmLeRQ=
X-Google-Smtp-Source: ACHHUZ571bJRJwfahUEuRVLxK+yFGIu4dQpN88WbUepi4Q5gTufoTqqdoNAPPDWWuMJnGCbWxhQVHzLwxWccXq7JhJM=
X-Received: by 2002:a25:ad24:0:b0:ba6:d45e:680c with SMTP id
 y36-20020a25ad24000000b00ba6d45e680cmr2142517ybi.13.1683863211063; Thu, 11
 May 2023 20:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo7mqs7rp.fsf@gitster.g> <CAMP44s0GAiFhoHFo4Ex464utf2Jm1F-LEdX2PZdUGEdp5x6Liw@mail.gmail.com>
 <ZF2tDgngoBHZojLf@nand.local>
In-Reply-To: <ZF2tDgngoBHZojLf@nand.local>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 11 May 2023 22:46:39 -0500
Message-ID: <CAMP44s0N7tLmpEbScVDDc=M2NG=vx+SoMLu4Vc_vRcS7dvLOgQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2023, #04; Thu, 11)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 10:05=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
> On Thu, May 11, 2023 at 08:36:36PM -0500, Felipe Contreras wrote:
> > Junio C Hamano wrote:

> > > * ds/merge-tree-use-config (2023-05-10) 1 commit
> > >   (merged to 'next' on 2023-05-11 at e0dab53028)
> > >  + merge-tree: load default git config
> > >
> > >  Allow git forges to disable replace-refs feature while running "git
> > >  merge-tree".
> > >
> > >  Will merge to 'master'.
> > >  source: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
> >
> > Why was this series merged after only 11 minutes of review window? Are =
patches
> > from GitHub favored over all others?
>
> Certainly not.
>
> The reason that this was merged quickly is because both of the first two
> reviewers had already seen the patch and reviewed it earlier on the
> git-security list. The patch that Stolee sent was urgent enough to merit
> a quick merge.

There's a quick review, and there is zero review.

Even Derrick Stolee wanted more time for the public list to review the patc=
h.

If the eyeballs of the public list are not wanted after a security
review, then why bother sending it here? Just merge it directly from
git-security.

I don't think that's desirable though. I share the opinion of Linus
Torvalds that security fixes are not special: they are just another
fix. Therefore they should go through the same process as any other
patch, because just like any other patch, they can introduce
regressions, and benefit from more eyeballs.

If "given enough eyeballs, all bugs are shallow", I fail to see why we
would want less eyeballs for security fixes. I for one found two
issues with the patch, my first comment was a bit more than an hour
later, and it's already merged.

I don't think that's ideal.

Cheers.

--=20
Felipe Contreras
