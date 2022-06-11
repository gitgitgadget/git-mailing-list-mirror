Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF386C43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 01:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbiFKBu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 21:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiFKBu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 21:50:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D66BFD4
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 18:50:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m25so827325lji.11
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 18:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1OWDRYmYbU2VFgMCJg/HbG35fonLx/pTTREezlSahB4=;
        b=U8RfK9IDyW49n1IJJrp90WsMCJy1JcCYwMr+R9ODPCx7Zr75YMVHKawoBa3bVEO/ND
         emLwTvV+NAK98ARzyEHeBMSTcw34gwiHDuFWZO0unwiuWJ/lAB89OFxi7aDdPHHa/eWc
         Hi7Rbsfi4ZAZz5yDbkKzVnbjYsewUZSeEolc7FMi3rtob0ppQZiuy2xJKtfqHGn8UzH8
         nsw1GY929BhxugAWKeaaljrZd0k0A4qu+YVLoK6zSUTD68O1skBRmfv4nGk2d9ek3p19
         0ssoMFnh7V6niq3VOSoVDkCSQE59LNFAx0tXRL6vwPpQCKzJLRw5FAF2vrv0pF2zN6gJ
         9hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1OWDRYmYbU2VFgMCJg/HbG35fonLx/pTTREezlSahB4=;
        b=gKZgOmsCuP5WcFVQc/0zxLwAMcTduNCp4S5g6Xue3CWuvcEV7euFkSsm8cHAlXu5zN
         Vxjx/8VKCZOEJWZanwyfQE8WRQK00V6KBKzR/Y4ciPWct3slUg0GF2lIZtQ6ciB1yPe6
         vhy/FRXc0L2zXvT37MUTPQBFuggqHRF/8l2fY5ykDsCYl7gM/c/zC6R8r2GUP2FTNJFB
         31sg9TtOhY3WjNKDG8JWd4Qg2r0iHhu4jkTVXCtWHkl33P7w3Xi0E0tr8SnNgRp24pU2
         EmD0P+XcQjAEVXsk3Xg0bAVkoa5rKC+ugRpOVhS8Ycj6p5X+yIdDdGFh5eXdflSV5XVC
         PObw==
X-Gm-Message-State: AOAM530TM1jNN6LNkAYWeYhB9J/advio6UZ2Ra1DVdMFshIcNXFWxNDJ
        J9OFRBMjUXmjUE6MfzkKGEvEjmj5WFffYNHzXetC/70bq8ECfqer
X-Google-Smtp-Source: ABdhPJy4ftwYEtc++5F1b4Rm/C1nfww2JAeQHoCtwmOrQMsUe3Wu3buOHrfO9xbbX7U54d56rD5JCVhc+KlfKvtc0XY=
X-Received: by 2002:a2e:9cd4:0:b0:255:6f4a:2d8 with SMTP id
 g20-20020a2e9cd4000000b002556f4a02d8mr25981147ljj.515.1654912252719; Fri, 10
 Jun 2022 18:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <cover.1654871915.git.chiyutianyi@gmail.com> <a327f484f7f7466597930e87686e7156beabdc45.1654871916.git.chiyutianyi@gmail.com>
 <0b9bc499-18c7-e8ab-5c89-f9e1a98685bc@web.de> <xmqqczfgcigc.fsf@gitster.g>
In-Reply-To: <xmqqczfgcigc.fsf@gitster.g>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Sat, 11 Jun 2022 09:50:41 +0800
Message-ID: <CAO0brD3ZmZUnBSKGcsXHJacZkOgbgow8-2ykBoF1k6V=5stfeg@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] object-file.c: do fsync() and close() before
 post-write die()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 11, 2022 at 5:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > Am 10.06.22 um 16:46 schrieb Han Xin:
> >> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> >>
> >> Change write_loose_object() to do an fsync() and close() before the
> >> oideq() sanity check at the end. This change re-joins code that was
> >> split up by the die() sanity check added in 748af44c63e (sha1_file: be
> >> paranoid when creating loose objects, 2010-02-21).
> >>
> >> I don't think that this change matters in itself, if we called die()
> >> it was possible that our data wouldn't fully make it to disk, but in
> >> any case we were writing data that we'd consider corrupted. It's
> >> possible that a subsequent "git fsck" will be less confused now.
> >
> > This is done before renaming the file, so git fsck is going to see (at
> > most) a tmp_obj_?????? file, which it ignores in either case, right?
>
> Yes, I thought I pointed that out in my review on the previous
> round, but I missed that it was still here in this round X-<.
>
> Thanks for noticing.
>

Yes, agree with both of you, I'll be removing this patch in the next series=
.

This patch was first introduced in v10[1], close_loose_object() was moved
to end_loose_object_common(), but it was put back in v12[2]. It is indeed
no longer necessary now.

1. https://lore.kernel.org/git/patch-v10-3.6-0e33d2a6e35-20220204T135538Z-a=
varab@gmail.com/
2. https://lore.kernel.org/git/patch-v12-2.8-54060eb8c6b-20220329T135446Z-a=
varab@gmail.com/

Thank you both.
-Han Xin

-Han Xin
