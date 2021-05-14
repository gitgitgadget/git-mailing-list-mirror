Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AEAC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0315D61421
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhENAu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 20:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhENAu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 20:50:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2DCC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 17:49:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p12so35945924ljg.1
        for <git@vger.kernel.org>; Thu, 13 May 2021 17:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9eibChle7IUA2J0mlp+R/Ux9jyoTbcwTj45JYXGIvg=;
        b=DXBP1EQPivlwQoC+C6mVVuaqBy0QeCa7PvkGp6nknsDkQtwjh2cEEQSAvzMH4Fy1Jq
         IJ/KSzEpVH3ooE60mT9HGJnTs3R1yHV1XQL7wecM9mwIVLFpbxMtTP1TtWpx6ISX7UsQ
         cN4/o6GNezo/eHQ2xMkAyTEtQVy9YZ034fFtwWELJH8akUNLbeUsKyQHBXvkoJXkYaFy
         ssIrFzxyFiVCUjUGbF3kCCiGDGPZAWfPrvZwe8Em6nAydV9DTutj+WhACQc2zNjwNhf4
         +aTOV3MKle22HB2r3RSfp9+u+wNPJNM8RygYfUkGkvK45yDh97BDpQLsKRwjqyFBXcXk
         ieTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9eibChle7IUA2J0mlp+R/Ux9jyoTbcwTj45JYXGIvg=;
        b=ivjDIMo4WmJF4qopruObZJGIXduO1sF6FXJqyV24vk99WezIqZMxVnwjWdqUO+M1iv
         +sYaKs3OXmp9xPngLxc6nUggXZ6zDNsE4iwRD2CI/6UOtpoHUJmS/DLsmylirSR3ZkyU
         QNWVTM8tWA8K8BOSou55qCL8CuGNsl68k7zxBpgPD+nT+u/u8ZGoVY5vEaWYNegctYR5
         MBewReM65q1NyOtkizgPAx0J5dqTmXtNYLLvnfAdcZD5B3/rb4wEkmH5I7HhfKX1VZG1
         +WvSg6GCH4mfBwJ4eV90yVi0EhxhF4E2GfPdbWaqNKdgdTaswTsaJLOLLv5CZmnR3bbm
         OVWA==
X-Gm-Message-State: AOAM530ZiSNMEnJJ56WxsVNv41lPc+TiyBd+7HuFLWA+RLUmdHzNn6mS
        rJ29B9rR/4DfVnLxY2Io5rCx/HnaLWnQ/gH0pgc=
X-Google-Smtp-Source: ABdhPJwSbjkORb3zfK/eiNt27u5Sf8wgLqIg49mIjxroSjw0CeVsiKZzAWuCYtNdqYVMZkdn2y+6GUGtNyS78gIxRWs=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr37549911ljg.74.1620953355024;
 Thu, 13 May 2021 17:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <87r1iakbyn.fsf@osv.gnss.ru>
In-Reply-To: <87r1iakbyn.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 13 May 2021 18:49:03 -0600
Message-ID: <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
Subject: Re: Rebase options via git pull
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 7:23 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Hello,
>
> Is there a way to specify additional options for "git rebase" when it's
> invoked via:
>
>   git pull --rebase
>
> ? What if rebase is used implicitly due to "pull.rebase" being set
> accordingly?
>
> In particular, I'd like to be able to:
>
>   git pull --rebase --no-fork-point
>
> but it doesn't work.

It would be cumbersome, but you could run `git config rebase.forkPoint
false` before pulling and `git config rebase.forkPoint true` after.

-Alex
