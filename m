Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19133C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034F360FBF
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhHTQx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhHTQx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 12:53:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05DC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:53:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u15so6243376plg.13
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:from:to:subject:date:cc:message-id:mime-version
         :content-transfer-encoding;
        bh=c9jN3CWvQOduTRLQpqdzEWLYC3ojDZkb4fge/6XiJZg=;
        b=LVf+aUySn0EcvOc+70f2w1d19By+xvNYUZ6GEM7VRgM7zA2da2OM/dKgamGsJSvYxe
         Aae8leu/HPXtrCJ+MP33d+ylyIiOu9icZlhQSuxly97qEwvHUmBm1DZCRhKgEJtkjXJM
         BwpQxxZheHHF2kSp6sKSgaaBoYt/GNexNP+8/KMDmycPLl6BLJp6YVIeDj/fVnDGxwof
         LAJtz7NsoIjY/gCpb7FbOxDt9pvfLT4JCBLrfxOK230mPS3sDf2pMpuLMU2eMfpcj4T6
         Ta+hTXxmwhebeUUxM93jxE9o9CwySCCUpxLLsyXcGLfRya0HD+3udNtuae4BtAzuUeqm
         SP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:subject:date:cc:message-id
         :mime-version:content-transfer-encoding;
        bh=c9jN3CWvQOduTRLQpqdzEWLYC3ojDZkb4fge/6XiJZg=;
        b=pMTtLu9WHIOyydKCnsJQleVP/nW0GpJYv4EF2H1DaOuvmxSZ+4EYORyfpJukp5lgoP
         4CmQpe+CcEJPm+HLIuazdpkEyUT1ficRWGPs/VE4IqfnuoE68vPJ+BpU1xJARvn8ump1
         Of5qmxSWyt3u8+tO+mZes5TmIRImzB/D+UDFKMkiSwZ5E57Z5l52bh3DfOTv1/bETIV5
         KwN+yt7wRXJVoxyvR7sntWQFmPuZH7X8cTHoDvkJ3VR9cnsKHZgvlMLD9X1Eihqh8FWE
         4sXadAqqXt5yNeByTCT2v/0EbNQmsg+zBb7CCsE2mtwC3KCGp8Ey7UMyvdgG1t/otMGG
         QsZg==
X-Gm-Message-State: AOAM532/PlEgleD8ICJhgrb8iLQcTcGMMzmjPWhmQ8zav7eTbgPbYhK7
        uZFq2xk+wMZVuOQnk8avcy0=
X-Google-Smtp-Source: ABdhPJyCzSfeZ4e4ueLM1SYagCpxw03TVFH19rklhlVnLuNik0OrXMLCW2Em9KgpGR3ryZ/z5IMlLw==
X-Received: by 2002:a17:90a:384b:: with SMTP id l11mr5560538pjf.208.1629478400140;
        Fri, 20 Aug 2021 09:53:20 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id q4sm6525883pjd.52.2021.08.20.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 09:53:19 -0700 (PDT)
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: [GSoC] The Final Git Dev Blog(s)
Date:   Fri, 20 Aug 2021 20:05:32 +0530
CC:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <m2lf4wys5o.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git Developers,

This is my last week with Git under the Google Summer of Code banner.
This week's update will be different from usual, as I have split it into
two separate posts.

These are:

1. The Technical Report: https://atharvaraykar.me/gitnotes/final-report

   This is a largely impersonal report that describes the current status
   of my work.
   Mentors: this is what I will be submitting to Google as my final work
   product. Do let me know if it is missing anything.


2. Reflections on Working With the Git Community:
   https://atharvaraykar.me/gitnotes/final-reflection

   This is a blog post that I wrote mostly for myself, and other people
   interested in contributing to Git. It covers my personal experience
   with my time here with the many ups and downs. I also wanted to thank
   all the people who helped and collaborated with me in these 14 weeks.

This won't be the last time you will see me on the list, of course. I
still have patches waiting to make it to the list, and other work
undergoing review=E2=80=94the only difference now is that it won't be under=
 the
GSoC banner anymore.

Have a great weekend!

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
