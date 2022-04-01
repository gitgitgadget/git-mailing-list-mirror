Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52019C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 10:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbiDAKeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiDAKd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 06:33:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3429026E012
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 03:32:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id bo5so2268186pfb.4
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GcSEuEIk/RX+HVoBZmH68kiDm7ncO1O3eisI2VHGad4=;
        b=U+NkWhxrZ5OwZt9ybv0Ja6JD31v+zyx6idBn27/VWL0navbEQDzp9jAAYHTLJKo9Xw
         RAg0tE61vZHv3OOvLMYSl0KcWo0iRaJ6EHz6mup8LRCubh+0SmFi8L2n/A68U/ZAbUDE
         /E4GhStuRUQx3eCDt3TT8I+l3jeRZvHhQy8O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GcSEuEIk/RX+HVoBZmH68kiDm7ncO1O3eisI2VHGad4=;
        b=I2Qmrahp3S8eP37tKsLmpqyHWnBRt1qBOvDbjjZpIgYcM6V4CJ+uN0oWWt+1Tyzg9K
         mPEtd0My1qtKEWcAE3PWCmE9u3xZRPLUzWK5aMF6+AKSx5Mmygqrddhf9yTaio4AVuJB
         wSmTczJVBY5cp2Reg5MiMZwLzTyDBG/v63ZLrh3XkLtWferZLvq+q4yrSibdlYJhlQs5
         gX6jwAvJBNtz7yN5Uh7K9lmEjTTebCfH3gU3UWRIQIie07FGhVCQjLfUA3Tl/Mfhk7O3
         bBp8pj7DCIxLXoZVdQoF+xqweqaU4oQUmnTM2kM3X4gjRJXV2Mj9jp6+OPkOyCPsrJ16
         Z8BQ==
X-Gm-Message-State: AOAM531HyueaJAjm+FAKRMBmpJxSLrj2w279JYDtODzFQcEGWGydlL/d
        ilzkf7u+huoWqktCOYTs6tY91sUBfdzgwaiumazNIg==
X-Google-Smtp-Source: ABdhPJx97oCYyKBgf+ZWAVqD760UpIPfBnQOd6CFOW8oejUJq4H560D1J5JUujUZYCvNe/uSH2t8B+750x+hJUexrQU=
X-Received: by 2002:a63:4405:0:b0:382:173c:1b97 with SMTP id
 r5-20020a634405000000b00382173c1b97mr14297087pga.532.1648809127672; Fri, 01
 Apr 2022 03:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com> <78501bbf28105ef252976266abb437a278585609.1648476132.git.gitgitgadget@gmail.com>
 <220331.86k0cap2rc.gmgdl@evledraar.gmail.com>
In-Reply-To: <220331.86k0cap2rc.gmgdl@evledraar.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Fri, 1 Apr 2022 11:31:56 +0100
Message-ID: <CACf-nVcwWCaJS7x5Qri+ZUucQKTTyL75=WscTEZkjg014+zMhw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] fetch: add --refetch option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Thu, 31 Mar 2022 at 16:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
> > +--refetch::
> > +     Instead of negotiating with the server to avoid transferring comm=
its and
> > +     associated objects that are already present locally, this option =
fetches
> > +     all objects as a fresh clone would. Use this to reapply a partial=
 clone
> > +     filter from configuration or using `--filter=3D` when the filter
> > +     definition has changed.
>
> Re my comment on negotiation specifics in 2/7, this documentation is
> really over-promising depending on what the answer to that is:
> https://lore.kernel.org/git/220331.86o81mp2w1.gmgdl@evledraar.gmail.com/
>
> I.e. instead of saying that we WILL fetch all objects "just like a
> clone" shouldn't we have less focus on implementation details here, and
> assure the user that we'll make their object store "complete" as though
> --filter hadn't been used, without going into the specifics of what'll
> happen over the wire?

That's not quite the case though: we'll make their object db complete
as if a fresh clone with any specified --filter (including none) from
that remote has been done.

IMO explaining what will happen and to expect (particularly as this is
_not_ transferring some sort of object-delta-set, clone transfers can
be big) is a good thing. If it improves later; then change the docs.

Alternatively, rewording along the lines of "it will fix up your
object db to match a changed filter" is implying that only the missing
bits will be fetched.

Thanks, Rob.
