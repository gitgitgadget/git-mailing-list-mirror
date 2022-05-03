Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316F3C433FE
	for <git@archiver.kernel.org>; Tue,  3 May 2022 10:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiECKaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiECKa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 06:30:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D7E75
        for <git@vger.kernel.org>; Tue,  3 May 2022 03:26:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso1083908wma.0
        for <git@vger.kernel.org>; Tue, 03 May 2022 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lrGZ6FQtWBe8UARFSRcO3xMWRg1SdzwTvZSU3zZIWsQ=;
        b=l2QoKqnwFpH/I9/lFoduJ0Rm9uZ/+xTOXKSyyg0w9kjx4Hb0yP5SyiVU8FEGWGd4nU
         0Xggf0xtjSibzAyy+dpsH53IetP2fFYCl/LVAha+Pd3bUaX5p0DxrDuFal+iV3MM/wxW
         muewgXvSm139khxVsGCFuFy+IoP/tmlaoPduimtsWm4gyxLHM3ROUTrcDTwzDPjocm8b
         fZQMgVMUt93RoAW1Y1mIgwyyxCTlP7qlaJKTkfrVAD10Fy4h++QWn4wzjHMbMSBXdply
         oGli2b5jPPBuE1nY3KFcncLZ3DPq63EDz5HCSuUAhKR9dsE3GjrVonypP/EhMXOtG56y
         /Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lrGZ6FQtWBe8UARFSRcO3xMWRg1SdzwTvZSU3zZIWsQ=;
        b=XmWLiF07uZmKoH+XjiUcrYSUhyn1hVpKchGikyQQCRih492DyiyE1aLAqBwVhuSB0X
         ZWsQuyauxQBKZKhLmiqC55ncoeu6DOwEmhKGZmZHHL9GLFCjth8w4Yi4+B/RnqeJs8PZ
         KAVZL3OGknlGmYyN37l3JVD0Oq6vBaiMxoOq6bpO8Sg6d4Il7RF9b4EZ/OmmdRr0yPQX
         2eBRSkOQkjleRBhEWGn3kN8t4bbQcAg1FngqHVB7k/P4q8iA0VcyLnneCQQRdjfHui+7
         +bFP++92NdLTTvGUjxX5fv1sp3Cz1uMOenvFTyu/8iZNhCQrwE6OC1kBX7sVHgC7Gmti
         10ew==
X-Gm-Message-State: AOAM5302HStgw7VqJLFZJZ/xpVo9t2GAS7YTQ3A7/6ZHVGiryEc4Th7v
        wBylwcrfNkqTZpzFuKIMGmrKHIE33cc=
X-Google-Smtp-Source: ABdhPJwKHtMeeZ6sE3nmaIkTdHeNpS4UE/nhdsvglLaov4MBV9J4JqrIiMzbzS1aaHjjY+pJ7vD2PA==
X-Received: by 2002:a05:600c:3b85:b0:393:edbb:ab9d with SMTP id n5-20020a05600c3b8500b00393edbbab9dmr2751269wms.126.1651573611842;
        Tue, 03 May 2022 03:26:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14-20020adfaa0e000000b0020c5253d8f6sm8868281wrd.66.2022.05.03.03.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:26:50 -0700 (PDT)
Message-Id: <3b944102ff28ca8d8b66ddac707a48252f0843b2.1651573607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 May 2022 10:26:42 +0000
Subject: [PATCH v2 1/6] trace2 docs: a couple of grammar fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bb13ca3db8b..adf867e1013 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -24,8 +24,8 @@ for example.
 
 Trace2 is controlled using `trace2.*` config values in the system and
 global config files and `GIT_TRACE2*` environment variables.  Trace2 does
-not read from repo local or worktree config files or respect `-c`
-command line config settings.
+not read from repo local or worktree config files, nor does it respect
+`-c` command line config settings.
 
 == Trace2 Targets
 
@@ -34,8 +34,8 @@ Format details are given in a later section.
 
 === The Normal Format Target
 
-The normal format target is a tradition printf format and similar
-to GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
+The normal format target is a traditional printf format and similar
+to the GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
 environment variable or the `trace2.normalTarget` system or global
 config setting.
 
@@ -635,7 +635,7 @@ process may be a shell script which doesn't have a session-id.)
 +
 This event is generated after the child is started in the background
 and given a little time to boot up and start working.  If the child
-startups normally and while the parent is still waiting, the "ready"
+starts up normally while the parent is still waiting, the "ready"
 field will have the value "ready".
 If the child is too slow to start and the parent times out, the field
 will have the value "timeout".
@@ -949,7 +949,7 @@ atexit elapsed:3.868970 code:0
 
 Regions::
 
-	Regions can be use to time an interesting section of code.
+	Regions can be used to time an interesting section of code.
 +
 ----------------
 void wt_status_collect(struct wt_status *s)
@@ -1103,9 +1103,9 @@ Thread Events::
 
 	Thread messages added to a thread-proc.
 +
-For example, the multithreaded preload-index code can be
+For example, the multi-threaded preload-index code can be
 instrumented with a region around the thread pool and then
-per-thread start and exit events within the threadproc.
+per-thread start and exit events within the thread-proc.
 +
 ----------------
 static void *preload_thread(void *_data)
-- 
gitgitgadget

