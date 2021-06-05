Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7343EC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 06:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47BCA61380
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 06:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFEGrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 02:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGrm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 02:47:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF7C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 23:45:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g20so17922087ejt.0
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLdftnGh9+UwGYSzkqGUaqry7yi423eH2MX5IdcTD6U=;
        b=Z61cTzZBGG2hw8z+ZKolcM5F6CBjq8XIm/owka5e9DGQxu8iNFdMGO9v929k3XxJVN
         QHxFQFViUClkY8+erq1R9Kiq14OAtEgIZ4LDdxKEQXyRuLnSyN2bQ5aMZS4MBY5/dFRa
         Cd7viaYeEb0jHxxkGLY98iRjA+2lg1mTIuZZCxF5D7niLHh+VeUyj02S+qgOQjnwsabZ
         Ho7dENqHkHrtqasY9vRqTgiuicLJGDDwae0TjVUnUGDeZtqA9w69WIpZX6ldinmLDBHj
         KEk4CfypQQGEkXJW8T2D7mrBYPLwTGzevgrj6CQBy/BP+A3YmMnl408hzUvTLwmtHHky
         jj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLdftnGh9+UwGYSzkqGUaqry7yi423eH2MX5IdcTD6U=;
        b=nnrolJJyB/TqYoY12eRzj6f8sa9kMrb6b2LJxIVkwQw9HgwRK56or2zkGgctZlLq20
         klzcYgzj1xQGBTsSr4oQe/r9TAGfeI6eXI44IStagEQrFDpWuKjpBcUdpbOluR5Hjj5K
         FLhGfRsDvGMGqW16v6WL4zc7Qo6PrgdupXWHdPXtCXVv1U9gSKf5LceEmQfVJIevAcJX
         DZVYjEQDayOzsT3U0pHmtxhYICuliuuAK+77vCgyw5sFhWrqK6eoWJhhWrVh8egxtGUb
         q2frYmJ14uSo2+wLGCsmT5UU6x1k/N66dAxkxvFlQq67ScN9TiPKN7vf4ugPAW+esnNO
         qM8g==
X-Gm-Message-State: AOAM533GXDcO/TPRtFQUNZZgm5oBTqQrZ+acBfC4z5HkTtLtK8DDW01J
        AzhyEcOJvilckGxH3afa1Akv2gQdnrtQ3HBJEVo=
X-Google-Smtp-Source: ABdhPJyI+u7rHaBt5e+yVLWQJQmyoNv7MsJ45P7Hb8NRBNJqHjin1E2ZIUb8iChIq5AsCQqPknHF1zO4fdrqRcY02uY=
X-Received: by 2002:a17:907:2a8c:: with SMTP id fl12mr7821272ejc.160.1622875538628;
 Fri, 04 Jun 2021 23:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <pull.966.v2.git.1622808751.gitgitgadget@gmail.com> <CAP8UFD0PPU4O+L3p0qJhKpsiB=MvyGJbbtxP6Vu0YeeVQ-Ojmg@mail.gmail.com>
 <CAOLTT8SEXfNcpzKaGzvMXxJ1NS_dw-S--K5a_jQ=d3be5CgpXw@mail.gmail.com>
 <CAP8UFD3SxAh1ZW2TTMqn2e6=qP1YDd5qVd15yFR669+cPr481Q@mail.gmail.com> <CAOLTT8RP1myY32cOMMvU4Q2_XyKsL=+XERij7RYJYM3We0rP8w@mail.gmail.com>
In-Reply-To: <CAOLTT8RP1myY32cOMMvU4Q2_XyKsL=+XERij7RYJYM3We0rP8w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Jun 2021 08:45:27 +0200
Message-ID: <CAP8UFD0xyOseUjSMUJ2fMzHo3d++PN7SOV8eXAvhqTGbkNFwaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 5, 2021 at 7:42 AM ZheNing Hu <adlternative@gmail.com> wrote:

> I want to mention another question:
> If I have a new patch series about %(rest) is based on the current %(raw)
> patch series, should I submit it immediately?

Yeah, I think it's ok to send it as long as you explicitly specify
(using a link for example) the patch series on the mailing list it
depends on.
