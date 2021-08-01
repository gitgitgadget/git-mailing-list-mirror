Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7132C4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79408610A5
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhHANwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhHANwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 09:52:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B0DC06175F
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 06:51:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so21792163pjv.3
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=AbvxptxQ4JTiJL7J3JYx9QJB7goLXdFEitqlABTC9SA=;
        b=p5pS1Pbry7uCoeEUwKoFJ3cJXjgO1cXXHcP8WdTdxV365+JixCCwn/rOBwNzZ3nEFA
         JwKxuJJa+vl55AD11lanr17p8RNu1JUg1H4hU+R/26a4FkSp1jHAOH/5klIM6VHT9Qlg
         AGm1K97qud5UR6USV59ZSgsMqffsDkcEu692/OqxIP0qwoU1vyNc/p1ACUlIzDtcg+Fd
         4DuMY9HImdYIznGTOb3dmOKpwyXUHivLGNguTbat3kFx553v7DLq0AstElEzem2GOpDV
         1qbtgKcIr3M/z6fISgPnYwklZB1IgRLGTAZCmoa4H3FqELlKXt6tvmOBCVaNNae9h+oz
         y4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=AbvxptxQ4JTiJL7J3JYx9QJB7goLXdFEitqlABTC9SA=;
        b=Jp7a4ScpcoPP42srdZo4CPdUtCm6TMtDr3z8RxdlQ6EN7GDQ77kXtcGkDACAdtJxPG
         eer/KWkkyfEvZONRPqkoAgyjx73ITf95NdQzT8wuDmspdUsENWqHEiuZkyyl30CFeRwv
         P8JNPEyZxu4RPqOKp/qZkIEdSkBhVKlNOZvO/5VhlZK6PKEOX+3x5BhYHVr4h3vCBsW8
         4Ja6oMzIk6nAjpuCCKgymXgDDwnaLdYM1YHJWaUfUiOtJ/z1PS+WGC5hPsFxy9bYyYM3
         d+HMHRfmrRdN9ruRQ6KpKICkFr5dGUuYQhfrNdtiDgV13wGw3d+jDeFawFART64M8vY0
         467g==
X-Gm-Message-State: AOAM532FJ4d2To1NR9is600hEaqTjsljgldSSPPZ7gTTb20Bv/+PCRns
        W6zdNTwruwsHsgy1WADCV2hdMBfzK+86KA==
X-Google-Smtp-Source: ABdhPJw8bB7ZFuH7dny7lV4WSctOdJscVdihDew/8TmuQqKZEraAvkVJOmx65yORO4x5bUI90WmvuQ==
X-Received: by 2002:a17:90a:1957:: with SMTP id 23mr7935272pjh.147.1627825916314;
        Sun, 01 Aug 2021 06:51:56 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id f66sm8428230pfa.21.2021.08.01.06.51.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 06:51:56 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC] My Git Dev Blog =?utf-8?Q?=E2=80=93?= Week 11
Date:   Sun, 01 Aug 2021 19:15:41 +0530
User-agent: mu4e 1.4.15; emacs 27.2
Message-ID: <m2lf5lxog6.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Resent this email, because it bounced off the list again. My new config is
still a bit janky, so bear with me.)

Hi all,

Here=E2=80=99s my weekly Git Blog.

Preview:

- Project progress: where I discuss a rough plan for making =E2=80=99git su=
bmodule=E2=80=99 a
  true builtin.

- Reflections: A summary of last week=E2=80=99s survey answers [1][2], and =
an
  explanation of my own slightly weird email setup that was borne out of the
  troubles I had in the last week.

[1] <https://lore.kernel.org/git/90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail=
.com/>
[2] <https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-wo=
rkflow>

Have a great week!
---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
