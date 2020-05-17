Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C8C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 19:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817A820709
	for <git@archiver.kernel.org>; Sun, 17 May 2020 19:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wil1qgqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgEQT1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQT1W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 15:27:22 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D935C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 12:27:22 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u2so542499vsi.13
        for <git@vger.kernel.org>; Sun, 17 May 2020 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EBUnepj42nwovDsTnFxvOz5mdjiLLn4oZIC7H/GSnlQ=;
        b=Wil1qgqhT4Y1Df1/y7lsY+0iaODpgrWajb5LPkB/BzBZ1Oej4fe/OlnKWehnVF1tvz
         /9ZRh6UPSzZjm0YEjAMafsHGYklK8kmtVH/QvfU8vhWXxPCSPqS66kkw/ZDuZgC2/WGc
         b8T/838gS3m3aMn6rzzVZRXGs/5ynsYjrfwoxMu/Jd0k/T53NdbwjrTukfmOu/qTTovy
         yOI/NilRmGHJRpF3Cgx5dU426sRpYcXCDtu9vyOBtGcyhyOJhSKoBWV8hrxu5SR2YBGP
         7X9gtMn0ll2WUFBlidQa0yfq4Q0KmX7Yc6ckKiez2TuljOCMygHGZMOFdGcAareo8iYZ
         6Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EBUnepj42nwovDsTnFxvOz5mdjiLLn4oZIC7H/GSnlQ=;
        b=NNBmVvcrbSTMPS6a0jjOMAnnURsLFJ3olSrAGzrP807IkOCPbv8zb5NCfosJO6dHko
         JX1uAu/nADnWQwAlTBY1AKpTTCSue2T3D2JwwN03GfuT896Q9Nw4HFAScR8zyvZBwzIb
         v2t8k67tgnYbo4ZC0X3LaPQjNKY+4hrhWVHEtTHepeMoiZqxcNMJ7T3vQogGNizcyexg
         CmRY17nQYRTBCAdU4Lon0ykQxeeGALgSASJz3wriy70K8eJbnUQgreF45AeetPkwzBcw
         yqXDubx+x8l/nB7uhHFd5QR6yiQXrm2xiab33Obo51NWwM7ItcDeDlIUxaGSkPFrSBuc
         qGkg==
X-Gm-Message-State: AOAM533DafMNgcmYxVY2juSuFD9vD7Lf4w2nL0bz6M9wTstY6NFbepO0
        mRHno4Pf7qLfQz8HfaOzcSHB6qSCB5zYajgpjxybHw==
X-Google-Smtp-Source: ABdhPJzjboDgc/4r7lFUaK0IkIwaWQLtOEui7kftDDddWZKnNDkA1ueVo4EGnDELnXPKYHF/9yG26LDdonH1iy0pAmM=
X-Received: by 2002:a67:e096:: with SMTP id f22mr8852500vsl.54.1589743641293;
 Sun, 17 May 2020 12:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589739920.git.martin.agren@gmail.com> <4753804d23ba7b1b267b6557077c80f3a8891712.1589739920.git.martin.agren@gmail.com>
 <CAPig+cTMrdeBLzUKKpkuZgSbXULhQb4epNC5qMMTUgqfZ1a0bA@mail.gmail.com>
In-Reply-To: <CAPig+cTMrdeBLzUKKpkuZgSbXULhQb4epNC5qMMTUgqfZ1a0bA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 17 May 2020 21:27:10 +0200
Message-ID: <CAN0heSqkGnYpOvzym+fv6_2_791j6jRwyWMpG9hG4H2KfY6BRQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] git-bugreport.txt: fix reference to strftime(3)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 17 May 2020 at 21:23, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Sun, May 17, 2020 at 2:52 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > When we say "link:strftime[3]", it ends up rendered as "3[1]" and we
> > produce a footnote referring to the non-existing
> > file:///.../git-doc/strftime. Make sure we use gitlink, not link, to ge=
t
>
> s/gitlink/linkgit/

Oops, thanks! At least the diff is correct.

Martin
