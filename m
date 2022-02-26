Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0037AC433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 06:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiBZG6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 01:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBZG6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 01:58:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1553398
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:57:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v4so6651728pjh.2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzquPUh7/sHxJ10mx7AhI+AXBYhQIvPAoolcGP6Nv/E=;
        b=LJCg9AyU2yCrSIezT5a0xO7UpQSe1RU46d82g+urUbab/r+fTMD/SuonHckWpy8uCM
         3AZaLV7dJX6RA+uJHECQmLTegyuDsccq05ICV+DVSMfVJuEif9rNa28WxysQ+1LllnGA
         57G3QgEwy9ODUvNMxGe2ifHmZrRH34yixgs0STM76DHphnvOMUqB4smEaZC+vK4vqMI8
         raj6xiFub5e/+PRx7sp8dsIJbYHVmi/Lqvcc7CXZHZh2wp883LNzdQr/HSdkNaNRtB4u
         GGqwPkOR6x/vnrKZIWKSi55wCT/bi7lqLNob/50CA3xYFMFgShhQnQY7feiYrUPhQdmM
         Vw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzquPUh7/sHxJ10mx7AhI+AXBYhQIvPAoolcGP6Nv/E=;
        b=Tj9wNclDqnV/F+7HmbJz28XHWMNqZhFsMGhvPUTtqNr9hxW4fzLQVdrsmR9zkw2zr9
         Lzsr56Q+0ZRe9FvekJ+NCVBybZwxdVE+WuYoQ1vWW4MQfK8RBpwc1Uu2pHqfgzFA2oPd
         FPFkPQdY7Z2vGIUGooZcCCgmS92c4UBZB+7P9mx6gPbvpkt/8zhbhZ2OVr/chW328QOO
         eKbQU0GEUSFENMvGvOcaqDKT/ERc9frfAyZRW2yh+atOgEcxuknPI8JKwE9xkhgteqWB
         FkpRSjletiFjp41jF+iXxJreoBSku/s8phiXxIz80zBhiap1Oe0/ZXSC74WY8pHUAV+j
         1GnA==
X-Gm-Message-State: AOAM532xRjcikrGp5uPQmRfQOVsLI8NVXBzP1YHF2vGLaceUwCzIUgCJ
        HYe48qFcfdXbKknMHVWk04A=
X-Google-Smtp-Source: ABdhPJxmmSbu2PDdK4a+gWB0pE3Z00IgfvNISV6yU66X3LA2MfO2UjTndnFf0njpCyI6p6BU3fd64g==
X-Received: by 2002:a17:902:7407:b0:14f:b5f4:6537 with SMTP id g7-20020a170902740700b0014fb5f46537mr10881049pll.32.1645858649440;
        Fri, 25 Feb 2022 22:57:29 -0800 (PST)
Received: from localhost.localdomain ([202.142.80.180])
        by smtp.gmail.com with ESMTPSA id u15-20020a056a00124f00b004f12b8c81ccsm5469250pfi.75.2022.02.25.22.57.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Feb 2022 22:57:28 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Julia Lawall <julia.lawall@inria.fr>, git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Sat, 26 Feb 2022 12:27:04 +0530
Message-Id: <20220226065704.7137-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqa6ee6txq.fsf@gitster.g>
References: <xmqqa6ee6txq.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> wrote:

> Let's instead drop [2/2] for now.  I do not want us to go back to
> shell script that pretends to know about C language, and I do not
> want to block [1/2] by waiting for a replacement.  Fixes in [1/2]
> are pretty much uncontroversial ones that can even be fast-tracked
> down to 'master'.

Though, as a new contributor, I felt bad about dropping the last
patch, but if you think the last patch request needs more discussion
( which I think is needed) - I also in favour of dropping the last
commit.

Would you do this on your side or I will re-submit it with the first
commit?

Thanks :)
