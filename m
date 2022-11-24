Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D715C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 09:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKXJRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKXJRu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 04:17:50 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E33AC37
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:17:49 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13bd19c3b68so1340518fac.7
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ff/84xhAHOgEEl8Py5w6FslaxfGFrLB70vjNT6uLJaY=;
        b=n9RWfksqk+nbrWIv7bb2e7QXVuTCZecVaAxFCyXsB+hJUImIPHrRZvvpR2su/ty+oa
         mLVkvCPDjOftdaE9V2p+BMUEs/xyfsMDxe+fU5j1EqLVEbwFEvsZXs3AdCaKdgzxv5Ng
         4jfkgJ65qSKCaxRRQ5UB5cZupKD22xE5XgzvKSx6sGCcheDD6wy9NBeoQ6Dj2XtD9/ik
         NBupYawemNI9TI4ki9uS5VU/l4VoDR+0dSMl54RTs6yUScVd8CA2LhgTLgY28DWGkFWw
         65S9PwEQToGduYky2Ge67MLGyH5xaqktKukf/XL0pY1myWvcKlfxkWfP3C4JUItK6SYf
         oTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ff/84xhAHOgEEl8Py5w6FslaxfGFrLB70vjNT6uLJaY=;
        b=4u7LhFlyh0F0jTlQGj6jrGjVQ+wrh1oZP7mSuMwYcwseKGdwYkSZpiOXfssaA9za3S
         DY+UPSsJ/U0yu8mTyhqtQNhMoHWpTX0jVoyaAqlAQTzvSpYpQgttAShAP+ScBYEslU+Q
         DYy07sbd6maXA6I6eHNiHkS/YryygFfZDkOtBN3YtR9X6L8OZx++Uj4Juv25foFJ1L64
         DlYPP0TstKg7TjliPWv3DXBNVtgho9B60SlCzGdz/8Atu+h7pA1BKA344804Psuh6/F1
         HOh/ftl50h6x+qLHiCQHhE8xbhEmm33rHplbkdBP9yxyedZ0Dm82aa2r+6MjklTtDl2s
         tsyQ==
X-Gm-Message-State: ANoB5pkeOO5X55yohHmZBSw81GPpRu+1AKamx7jSAC3xHgdrGFtzbU7d
        0EVvsn9JfZYsL5swdHkbxYVhKnqcgvSThCJVerY=
X-Google-Smtp-Source: AA0mqf5VsLFF2VVNcG1Ejndz8Iqvh/6nYnN7Z9iYE8RoPDvgxV7mDfzEQxtwIAYOhSyIRSGrJreh6f445elQgsb34uA=
X-Received: by 2002:a05:6870:61d6:b0:137:288:b05e with SMTP id
 b22-20020a05687061d600b001370288b05emr17825731oah.80.1669281468406; Thu, 24
 Nov 2022 01:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221123150233.13039-3-worldhello.net@gmail.com> <n79194n5-8q94-29n4-s447-64r0p2po4r76@tzk.qr>
 <9q4525s6-qrq8-1841-n257-711328352n85@tzk.qr> <5p3n90pq-4ro8-0278-3q8s-r2p568q3o26r@tzk.qr>
In-Reply-To: <5p3n90pq-4ro8-0278-3q8s-r2p568q3o26r@tzk.qr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 24 Nov 2022 17:17:36 +0800
Message-ID: <CANYiYbERKwmRj2DU=d4GCPO-jy+g8pMPBgD+vtzwB2iXRH44Ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] ci: upgrade version of p4
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 4:54 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Me again,
> Hmm. Hold on. While `p4d` now no longer segfaults, it looks as if `git p4`
> is completely broken (see
> https://github.com/dscho/git/actions/runs/3538941550/jobs/5940295721#step:4:2005):
>
>   failure: t9800.3 basic git p4 clone
>         git p4 clone --dest="$git" //depot &&
>         test_when_finished cleanup_git &&
>         (
>                 cd "$git" &&
>                 git log --oneline >lines &&
>                 test_line_count = 1 lines
>         )
>
>   + git p4 clone --dest=/home/runner/work/git/git/t/trash directory.t9800-git-p4-basic/git //depot
>   Perforce db files in '.' will be created if missing...
>   fatal: 'p4' appears to be a git command, but we were not
>   able to execute it. Maybe git-p4 is broken?
>   error: last command exited with $?=128
>   not ok 3 - basic git p4 clone
>   #
>   #             git p4 clone --dest="$git" //depot &&
>   #             test_when_finished cleanup_git &&
>   #             (
>   #                     cd "$git" &&
>   #                     git log --oneline >lines &&
>   #                     test_line_count = 1 lines
>   #             )
>   #
>
> I guess I will keep digging,
> Dscho

I found this is because python is not installed by default on
ubuntu-22.04. This issue is fix in patch 3/3 of reroll v2.

--
Jiang Xin
