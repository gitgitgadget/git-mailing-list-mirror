Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DEEC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 04:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiCaEbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 00:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCaE1D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 00:27:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D255C184636
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 21:17:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b43so25858617ljr.10
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 21:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yynS2yvwwUuhnTQygr9Uenjcx5ATDezEiydrqmmxaiM=;
        b=P7zYmUrOfZhl0dFYmv/OuFc+MzdvQ5btwcU/QyZLhXfuXt48s81a3AJLjziKivvMj/
         ecEsYZfShotSFse1SDdZF+ss+9WFmpdcQPo2y/WYiu6ds7QyEK9X+i0k07Dk1zLl3HyR
         99VhhdwIFa9JsT5MgrhL4Nev9b2zKt84wl1E+82b7eb9X2amJlrg9I53cU8iaDmjy97T
         R4+Hfq1qD++ND3zOiZNHNZJ0BiX9VnPOXOE/2zP/rqc7YATWjzrM6fwS8S12/Ib0/Jq7
         FoNkoy30/FnRt5HnRVh1Do4ZLHaZYz+6Qj6yuQrHRaglFajg5g4Bm8RC3KnW+RQHeksp
         CGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yynS2yvwwUuhnTQygr9Uenjcx5ATDezEiydrqmmxaiM=;
        b=1eHhldknU/P0a1JcUsfeLs3zTOj12a1VGS5fw/NG8fjlqZNIUKeHtEAkRSDwRGvl33
         dX1fIVAMvn5Znqm4qe/PAdLUP2MlsJqthXwbo/4KucQGkL0Mkgr/W9O78700776PvD+5
         Ef7M40oZi3r+vqlZBKaXVGBzGQynq2uHAE/HsJQeidzK4K5L52Bze7EKhrK8R8wNxY1D
         Z3iRMFtAJ0pUm6Glz7KR8GX8NnQKA4c2M9gnCqH2GEewiX5Kwgq+vt1bbXt2V/mUwmYX
         FZ4xL6SRfeSorIrA58lLY/wuM/ut9GUTp3ny/AioTrFRxCcVhdiJh7yOFRjfq/D4Dv2w
         69Zg==
X-Gm-Message-State: AOAM533bT88zkW6YCYSPTY7F6JMX36wl2rR0q2vH8e1z2cqNI3ZPDCyz
        FcNesXzTvUP335gNUSs8er9ooljdhdvfM0fzatw=
X-Google-Smtp-Source: ABdhPJy1jNdluS2348Ep7C0Du4femKksQFmhQQ1Gmfx6Rs2eUNyv6UqlyC61nCnhLKSniU+n0pZCQNgSvT8rG9tFup4=
X-Received: by 2002:a2e:9447:0:b0:24a:e13d:cfec with SMTP id
 o7-20020a2e9447000000b0024ae13dcfecmr8685537ljh.413.1648700247117; Wed, 30
 Mar 2022 21:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648616734.git.gitgitgadget@gmail.com>
 <xmqqpmm39xhx.fsf@gitster.g> <CANQDOdfWTufEn0NRSAOG991JcS4x8GsCC62UCLUTEc3gD6tfGA@mail.gmail.com>
 <xmqqr16j6ve3.fsf@gitster.g>
In-Reply-To: <xmqqr16j6ve3.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 21:17:14 -0700
Message-ID: <CANQDOdcDY-8TZzCHx+tWZJoD0rsULnfaWRhAOox3drSgxW_+ow@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] bulk-checkin: rename 'state' variable and
 separate 'plugged' boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 1:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> >> We should add a new function, flush_bulk_checking_packfile(), to
> >> flush only the packfile part of the bulk_checkin_state without
> >> affecting other things---the "plugged" bit is the only one in the
> >> current code before this series, but it does not have to stay to be
> >> so
> >
> > I'm happy to rename the packfile related stuff to end with _packfile
> > to make it clear that all of that state and functionality is related
> > to batching of packfile additions.
>
> I do not care about names, though.  If you took that I hinted any
> such change, sorry about that.  _state is fine as-is.
>
> I do care about not ejecting plugged out of the structure and
> instead keeping them together, with proper way to flush the part
> that deflate_to_pack() wants to flush, instead of abusing the
> "finish".
>
> Thanks.

Just to understand your feedback better, is it a problem to separate
the state of each separate "thing" under ODB transactions into
separate file-scope global(s)?  In this series I declared the fsync
state as completely separate from the packfile state.  That's why I
was thinking of it as more of a naming problem, since the remaining
state aside from the plugged boolean is entirely packfile related.

My argument in favor of having separate file-scoped variables for each
'pluggable thing' would be that future implementations can evolve
separately without authors first having to disentangle a single
struct.

Thanks,
Neeraj
