Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129FC48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 11:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EBB61423
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 11:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhF0L0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 07:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhF0L0v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 07:26:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D76C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 04:24:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o3so2146589plg.4
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=tqCocaOOuv06SSJwL/dF17RNwigYghwaREOfLNQpFR0=;
        b=QmjornXTM3zDLCxRcZ6FnqSsT8KoccKQ7O7+wu4VcGzL22/y9/rXGWQBg2rZXmw2lu
         T+fOFNJ68xF5Fkp/U9o+hpmstrYmiYGMEc7lxYfa1r1EtGEjsx9/dz5Bcrblf6IbmYi1
         yOoM6qxSIi+xpj/fT08HCyW/KNo0LAmV4NBflgq0/4i5HtxBge7/ECyk2iD+LDrjWqSq
         FKPr0rd8sBw4XKJmpiDwuF4fSPIyTVs4UBjtG8xdjRciT3iz8tyBBG7/SyQU/+i5lHKb
         4wZhmb28Zku+TJllB0VkSsjTUSSC7Vz7qLklbsjUhGi8+0Fr+yXI71Iy3QWqYaR0bBeX
         ZQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=tqCocaOOuv06SSJwL/dF17RNwigYghwaREOfLNQpFR0=;
        b=i1hpJ15KRur8V0eE1tDmF3y7BA3UmREa/BoY5VQBz1iVPtsPOkbUzLMis48jQOiCwr
         AZdLdaeV8nsT3nUifExKPyWhFgEeC03vNkUeuS2L863HQNSReccLihTd9ksxHLLqqM77
         T5WXhh+WAValFxicusuWB5hy6jFVkP+MAE/7r1joPwoRfSnnfR4D6fMzpY8yi0ciXCz2
         djMna9FcP4Uu9Oh4jpxQzUS+oNDb2o1Oahc26Z50xmckve9DxYa4YEcQJ8XRc2paVDmO
         NTFEfW5/g0gS/CDWBifUNU3RB8U/xlQDtpD3GKkXyb/zxxfWRvOtvZ6TNxfAVPcWCtTJ
         6Jiw==
X-Gm-Message-State: AOAM5316nrUnNzBIYSpPSldCjF5DgfkMJEQY10JrrWlPQJk4UqBo9ahL
        m7BGYjHIn65lna9YKRazsUXrkTOhzVkY1Q==
X-Google-Smtp-Source: ABdhPJwhOiPp5clsQB6DPJbVdExFQim+oSARdWahzXrXsYn18K6PL5bGoZXqcb8UHIh2M7M1BilfFg==
X-Received: by 2002:a17:90a:6b0e:: with SMTP id v14mr5697407pjj.148.1624793067552;
        Sun, 27 Jun 2021 04:24:27 -0700 (PDT)
Received: from smtpclient.apple ([119.82.122.143])
        by smtp.gmail.com with ESMTPSA id f12sm10603379pfc.100.2021.06.27.04.24.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jun 2021 04:24:27 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=94_Week_6?=
Message-Id: <4E38928E-A98D-4F57-8866-8A237B31DDE0@gmail.com>
Date:   Sun, 27 Jun 2021 16:54:23 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the latest instalment of my weekly Git blog:
https://atharvaraykar.me/gitnotes/week6

A peek:

  * Project progress and current strategy.
    (mostly relevant to mentors)

  * Reflections:
    - How does Git even start?
      (https://atharvaraykar.me/gitnotes/week6#how-does-git-even-start)
      This was just something I was curious about, not really important
      to my project. If anyone knows the answer to what I asked in that,
      section, it would be nice to know!

Thanks.
---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

