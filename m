Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FEEC388F7
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 23:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F342087E
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 23:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Uhu/Gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgKGXXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 18:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKGXXX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 18:23:23 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22C0C0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 15:23:23 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id r12so2310435qvq.13
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 15:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lUxOFc+p6vUKT/A4+xrvV/0fM4zceLH4bd+j690sYcs=;
        b=n9Uhu/GdXeXgVWVn9oJMBKr72/2L1LRGtuZSOFpyy0++WwYYbwQ69m97heX46g2j6Z
         Om7qk3H7zQjoXCCp/sWm+vxJ3zvHNAsb8h5RRoQATDyyqTCzB/Efq6zkrEDTNB40hYMp
         1G+E+OvwCinO9gZLH0rNYFC69/Kb4ju+jzmH9niUYwn2rmiVc8E4ah6k6DJ8LFw5JUUL
         4snsGoAHnVkFFTvYmKbT/6xxfG2HdYsxUNygBgmnwZIyfEUhg9LOeuS4Q7APO1TtnO5k
         Aob/Dc8CaPznQJ/M9+pH/X9hWbaaVac+Yji7cs8GDX/AZdRBuZ83Ie4GqDmD03b535u7
         ZBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lUxOFc+p6vUKT/A4+xrvV/0fM4zceLH4bd+j690sYcs=;
        b=m6kgAq2Gp87T0LD7mcbFOXR/W9ClZPiEfWipw/rPkVOkxmL0g4LUAdDf3ezBVROWSp
         sEVXlmiZlpw6xyFvhzyVCrFDdy9VH6FDlg4VFE0NkOUgwiybjMo22OhVEVI2VRKJVUF0
         i0CjrvzyaIsEThmTcUOMZa1mFovIYMyPaydHSBvKyo6065Le9oFsxmxWz3onNLhihgJ4
         3y91XvgJh6NUkQ02JJyDGTsYfQjSJZVbtiBES/TqAVgniV4FMUsM7mZ5omwgfUq1uXf6
         qCtTUPJ5Z5wZB8yHOw6vWkL2y//Y+l5B3i74xt9pCmUjuPx9TwIpIycSnuiikV/eK4D7
         P+2g==
X-Gm-Message-State: AOAM532y4hfPDmW+WEec4jdfKwyn9mLL4XCmTobBxdFOmMo+dZ6qADe8
        oVX4U5Q7iqeK9/b8zJwu2hi0eTsQqO/VpXSV55U=
X-Google-Smtp-Source: ABdhPJwOCijmFYx2xIL3L/uke8s2tWgaP5eorb+aekjm707cKFEU7/fLohHFuo4m7x28BY17NA67oyTUGTH5iDqae1I=
X-Received: by 2002:a0c:bda2:: with SMTP id n34mr275578qvg.28.1604791402728;
 Sat, 07 Nov 2020 15:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20201107221916.1428757-1-dgurney99@gmail.com> <20201107224747.GF6252@camp.crustytoothpaste.net>
In-Reply-To: <20201107224747.GF6252@camp.crustytoothpaste.net>
From:   Daniel Gurney <dgurney99@gmail.com>
Date:   Sun, 8 Nov 2020 01:23:11 +0200
Message-ID: <CAGeMgCda8N9qGWqLxX_T+8C4ycczMkRo8mZfoLwSD2DGBPYuLw@mail.gmail.com>
Subject: Re: [PATCH] compat/bswap.h: detect ARM64 when using MSVC
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As far as I know, Windows has always run on little-endian hardware.

That's a fair point, and I doubt there'll be any new developments in
this regard. I'll send a new patch with the simplification you
suggested.
