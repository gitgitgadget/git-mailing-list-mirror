Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BABC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 19:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBETub (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 14:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBETu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 14:50:29 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF111B326
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 11:50:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ud5so28792315ejc.4
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hK1Xwpxe1scT956SbwFKqD/ITvzWu0lXcHIE7FIiuBI=;
        b=SubHeRoKaYx19btPg6xFJ8OVTQ7NMTDkm2Cl9HHRJz6J6GY5wzRO3EZ6CgKIDwG+rn
         AV41y1FNTEwcrspteMgORpFY6KqFSgIOTCDmryMW9E3+4cp4+y2gkNyxTtpstTvR4Jod
         kv2VB5mBkFCZhe6U+d+BgF/Fv3pRk8CplwkBc6SFyXpCPgYax1owZ95e6PLCE7wJ/7L7
         GohtKYXquxb8gSo0QOoErKtZ5K3pgdQCqMtlRPbv4y30ay+iXqrcBydeq9IEqApVupwi
         Na9OFRDx5A3PHk3MvL7fPnS32B15TD9tw5ntxqojg7BeUaKpzJwivZp6kpW1jbh5s6/o
         9BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hK1Xwpxe1scT956SbwFKqD/ITvzWu0lXcHIE7FIiuBI=;
        b=7IuJhqs9IPYsKcVHVFf5TVm0SbeS4QPC6E7VBbyo1erGdLnbGon0sMP5rFDD5O7z2u
         xMKy9t1gYgd2jU2tvOHNWRSyZMecz0wfxS6b3uBU6TkZaNHip1F/Jnw7e+UGno0vw6Tt
         DAM24Rb0x0mgCqLe101IfN88xsEXYKZ2FEw9bexkw/xtDx9EnHlLFW0+uifAb7Jn9ocZ
         ra966Vmn25PrPU554hHkr+lDjw1spTqdbJmrC7U7uidPJ1sezt66JFZCRbso7xLhT4FC
         Y1I3EvvZCILzLIsPLPVjwylUgry/oUalVlDxzLktC34IZmiUGaVwu+rlwowUP6oY2A7J
         bDeA==
X-Gm-Message-State: AO0yUKUsrPykrbVla5elQiPmENuqh9FaCSCtxUQMcDPnlzZVjfpLW+Np
        fcUUO/iou325Lfy7lCiERwwka9xiC9q0Kg6kQtCJKR4CoXeUPw==
X-Google-Smtp-Source: AK7set/1/L3dEWvekOmLjAgFoyIbVqeJiegPM2AlXZeDGTjgSvrGfUdl9QS9hL/zyD8BSQKb40DU0vVGfw8bTw4Ccyg=
X-Received: by 2002:a17:906:bc95:b0:88a:d760:19ab with SMTP id
 lv21-20020a170906bc9500b0088ad76019abmr4316781ejb.245.1675626627129; Sun, 05
 Feb 2023 11:50:27 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com> <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
In-Reply-To: <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 6 Feb 2023 01:20:15 +0530
Message-ID: <CA+CkUQ-t3-jOaGE4yMHXxREBs3-t35NCAJ3VTSnMSq5072rsBg@mail.gmail.com>
Subject: Re: GSoC 2023
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jan 24, 2023 at 10:08 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> I removed the "Reachability bitmap improvements" idea but left the 2 others:
>
>   - More Sparse Index Integrations (I removed `git mv` in the list of
> commands that need to be improved though)
>   - Unify ref-filter formats with other pretty formats
>
> On both of them I removed all possible mentors except me though. They
> are welcome to tell me that they should be added back.

I'm positive that I'll be available by the time the GSoC contribution
officially starts.
You can add me back to "Unify ref-filter formats with other pretty formats".
I would be happy to co-mentor it with you.

Thanks,
Hariom
