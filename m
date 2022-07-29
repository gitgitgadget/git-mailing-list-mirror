Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43E2C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiG2VVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiG2VVT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:21:19 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0046482FB9
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:21:17 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-324293f1414so28316197b3.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CbL9Ir2KX5q6Cu2LUfQ2AMDXH05QQsfhfSAt3jRhbxU=;
        b=ROJz7Vf47jaKGmSTOWMtG3D46Yi+qdRzypb2Oxt+msBjmBI53dyoY3ZdUjQgRztKCL
         GBl5Sx5QDZwZ4Jzm5zsEF3qfZWYh0unlPdQpV/crLIbKqxl6BWCu8rqYMDvHOz48QS6K
         J8BZZS5/UsGqW6q5I3L3bQ8ls/sy1+mh4tAY09z7xBNLX875AyClB9/+Xt52h+kx3wuE
         6GSr/H96NcmJk3zEiyOJNLB1k0E2jJrjQdKNne9TSuSc5uWh+DLidv6jjHmogfMK23ki
         ihYTOWeE7MkFz71XZsq1/xlvAW77M36T0VDV+TEUExf4Idk2TYeduLT0yg2yiUy5eBCf
         SuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CbL9Ir2KX5q6Cu2LUfQ2AMDXH05QQsfhfSAt3jRhbxU=;
        b=SLMfxunLTpIDFPj38oBQsnSBXDImUnES7pBrQMEtiqoZq/55qIGDfU0F28k6mFrva5
         nbY6I1sF9DzwmCaDcgE4msYwiymEPptyjCCXD9BIAKPVEs04t6CUfWggcVTvjHDV+/ey
         HXbpdNKXAAbhpbPFI2DzpjhQgya6oI0RlB3ZoHpJcCXdwbHg1AYxak4uXmeJ1uOSiiKo
         5nYntYUW/AcguRI9aqgIv+7TfsWCJ7r7SaC+bdJV5LZ5y0bjSdWrMeQNAd0O5C+rQDbo
         Wp9yAEV0B0VM6S8S+lJQ/W65NqTgMTa7yRdyjhchpEsmOgTL9Tp0sStEDdb5QvFtTcmo
         SZzQ==
X-Gm-Message-State: ACgBeo1jLx6qnTdymzlqjkiOUcsi5B71tzCM5HfOqUcEE9DV6hGFX06y
        42n7I1zob2Qea9JB17PMzWFQqjdQmOVQH4HAivgdDw7vOEw=
X-Google-Smtp-Source: AA6agR5WbD+JAKzURD649B1Tr8KYr82EupY/O7zbAHUHpGkkZzsfhl6U0wqn62m7SQDs+IL8ZvthqpIqUtU0hbtZ8G8=
X-Received: by 2002:a81:4702:0:b0:31f:2ab0:8770 with SMTP id
 u2-20020a814702000000b0031f2ab08770mr4738995ywa.157.1659129676936; Fri, 29
 Jul 2022 14:21:16 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 29 Jul 2022 23:21:06 +0200
Message-ID: <CAP8UFD2OngQR7KOS3rAFOK0z9VhPNHbXC3PfpO0c4QXP=OhW1Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 89
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>, Tassilo Horn <tsdh@gnu.org>,
        Bruno Brito <bruno@git-tower.com>,
        Philip Oakley <philipoakley@iee.email>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-89.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/589

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on Sunday
July 31st.

Thanks,
Christian.
