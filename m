Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EEAC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjHJUkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjHJUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F3B2D40
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c93638322so274466666b.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699994; x=1692304794;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pvj7xNw91xVkXjXziYyUb1oHNtWmQxz8O7lU4iJcn9c=;
        b=cZOc4Pzt0JYrGa2A3Or3gBdohJCFCmpRJgqo4AvckN+oY8FG5knNcE7RsG/gs3IxSp
         io33ISt2+b39Hes6lbrlER5s/88eN37O8q95r1kVHqfu0K0VJ+7fWKE/c7VuP4kO8m4C
         puu2EbGMCiX7voFXbexqt9Sia+WcfkElDmIOl/2/LnSyt129Z+m4NxM1etZRkt5QxUX4
         pdFeOz/4TYQnSue2b75mB8BK81Ki7tiTMB9aNWVg5Khw970tHz6ke0ytkm5RDG9ZGX4k
         gugVlqrhi58Dq8oGalkPUBIzCai3ke9HsljmoL68FTmR71dL/uDFUfnOfvI6znf08YZi
         n0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699994; x=1692304794;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pvj7xNw91xVkXjXziYyUb1oHNtWmQxz8O7lU4iJcn9c=;
        b=BZtNdLGSa/Yrh1N1GWKcz1dIXMaVFSNMCc5Jj767k/98iKDhxdZTG/ZQywfR/uMnw+
         un+8M1mdzmF6oWeXc98e/e7Qcv0BDAWFTwiWLellyAhUjDPEVhJVmReqliel+m2VPhjB
         PDgx3USGZ9aXi6Bn6tZIQWHwjKsaEuyjL8s+y5Z3x3wilzsrT0ArAFY58SJ48s8q8yLh
         MjvjgbAcB7ktpdAXNeP7bGWBflurfW01UGx88oL4W49uxYPOTmGRyieNAJ2ByV8mrIwU
         qjkvueo1N6syrjyIGFONgrywsg0Xc9qD3lH9gss+VJhSnMO5gaZGt6u6nvh9/cM3jQaW
         Epbw==
X-Gm-Message-State: AOJu0YxT0zhvOboGCTsNq8+OzB4G7689tSgjiEkXMhtERHrElIIvnKkj
        9tnF4hV5xwk4mbBqBv2FTSPtiCozvho=
X-Google-Smtp-Source: AGHT+IE9pRGMYS6tpOfUtvOfY2Wvi/cx6juBpj1zgh9xr58v2BtXIU+ox2m8FOG77CIsStIiKKUtkA==
X-Received: by 2002:a17:907:2c59:b0:99c:ae54:6654 with SMTP id hf25-20020a1709072c5900b0099cae546654mr20527ejc.14.1691699994050;
        Thu, 10 Aug 2023 13:39:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id kd7-20020a17090798c700b0099ba3438554sm1370402ejc.191.2023.08.10.13.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:53 -0700 (PDT)
Message-ID: <86c4255d63d7f38b7a4811e5667404bce04f77f8.1691699987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:46 +0000
Subject: [PATCH v2 7/8] maintenance: fix systemd schedule overlaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'git maintenance run' command prevents concurrent runs in the same
repository using a 'maintenance.lock' file. However, when using systemd
the hourly maintenance runs the same time as the daily and weekly runs.
(Similarly, daily maintenance runs at the same time as weekly
maintenance.) These competing commands result in some maintenance not
actually being run.

This overlap was something we could not fix until we made the recent
change to not use the builting 'hourly', 'daily', and 'weekly' schedules
in systemd. We can adjust the schedules such that:

 1. Hourly runs avoid the 0th hour.
 2. Daily runs avoid Monday.

This will keep maintenance runs from colliding when using systemd.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e52129e485c..6f8df366fbe 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2350,11 +2350,11 @@ static int systemd_timer_write_timer_file(enum schedule_priority schedule,
 
 	switch (schedule) {
 	case SCHEDULE_HOURLY:
-		schedule_pattern = xstrfmt("*-*-* *:%02d:00", minute);
+		schedule_pattern = xstrfmt("*-*-* 1..23:%02d:00", minute);
 		break;
 
 	case SCHEDULE_DAILY:
-		schedule_pattern = xstrfmt("*-*-* 0:%02d:00", minute);
+		schedule_pattern = xstrfmt("Tue..Sun *-*-* 0:%02d:00", minute);
 		break;
 
 	case SCHEDULE_WEEKLY:
-- 
gitgitgadget

