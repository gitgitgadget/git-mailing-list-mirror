Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDBAC433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BFD61247
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhKKWhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhKKWhR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 17:37:17 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1697C061767
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 14:34:27 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mn13-20020a17090b188d00b001a64f277c1eso3669135pjb.2
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=f3Ee4uJKtNTmYI6jrYHdJhK8rJLXTgYRTcXtrtJE1Xc=;
        b=hXRQdfvTPLef5MPAlB66BL0oY5Gihwa5tQkYeRtmwrCJV/UcvLz0ueABh9CES4BiNw
         TJBow3wqqCWOPSS4w+5KCWPxpqohg5LLvZoL08UlkZ/8wFvGJSievHpwbtp8D7uOY2dj
         /inKq3P5ziXguqVbu8wD2x5/QYH9H+FV7WgS2aoV/F03dJqdh4Te4fQvDgtiqFwDWztB
         FeQR+JL8d/igxiuSnYHe4ZiwBISvJYya8gkeMiQ1IgVjKX2rA37t7/DPpbqVCXT9cAZZ
         sJ9wQAeLoEUWu2gO11fxtG7SUFOxJhWx1BGzD4J43TVvBZEkg8qCQYEQrcTbEeyPQjPm
         Bc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=f3Ee4uJKtNTmYI6jrYHdJhK8rJLXTgYRTcXtrtJE1Xc=;
        b=cf/SMEh0MKt3xwM2dkOgq05OBlxdtDPla+jnDZU2XaLptHmGlNmb3WFDHp61Jr9/XR
         SfgEBD4BdeR0Tx710qp70x8bqtEJ1WUoNJLxqtgyacUTTbus14pI81MOB+k18rC12vbG
         kesQlOzaqR5Jq75c5KkxwWcTKHIcS3o/oy3HSrQwEwfGkm+4EtlqScs1ZE9xSLr3AEJL
         Ku9Ly8tOqsBFFkzULljxK/eIf/Ih4xMqo2Osn5GkrAmFKfwUllz6VDhgE3Owq9lqWSFI
         MIAkEkLMCeTJcWd3Q83jnxfikNJe8UNzIzxnD7n28l3/ZJhrmA8y1g0gaPJyxGITx3r3
         eqgw==
X-Gm-Message-State: AOAM530Ebvv00EEKDhSGiyXIyi3aKN1RczSOp/JKraknPnl1SdZkmGjD
        Y4DVkWx354PhwjUjmwb2S+zDlLvw7luzh7kc4SMSALh8ANmnFDAXc96bt5EuR53/xlor9Ok+N5K
        ewSbTgNAw0+v16xx1mpQ0C1aT7YtKkPNTEWqO2Ph++Sqk2fpPhpQ7zIWyoD2wn90=
X-Google-Smtp-Source: ABdhPJza6v7AbCCDRsFQengMvi1tK7zEdrZEvMOd8zlzEbyqZGssZ3vIVuVnlrlNrJoiNf2G1E2WhqjfoEzfDw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:2812:884f:9c76:ae35])
 (user=steadmon job=sendgmr) by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP
 id t13-20020a1709027fcd00b001428ab3ec0emr2910031plb.4.1636670067213; Thu, 11
 Nov 2021 14:34:27 -0800 (PST)
Date:   Thu, 11 Nov 2021 14:34:25 -0800
Message-Id: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] trace2: increment event format version
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 64bc752 (trace2: add trace2_child_ready() to report on background
children, 2021-09-20), we added a new "child_ready" event. In
Documentation/technical/api-trace2.txt, we promise that adding a new
event type will result in incrementing the trace2 event format version
number, but this was not done. Correct this in code & docs.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 4 ++--
 trace2/tr2_tgt_event.c                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index ef7fe02a8f..bb13ca3db8 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -128,7 +128,7 @@ yields
 
 ------------
 $ cat ~/log.event
-{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"2","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"3","exe":"2.20.1.155.g426c96fcdb"}
 {"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
 {"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
 {"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
@@ -391,7 +391,7 @@ only present on the "start" and "atexit" events.
 {
 	"event":"version",
 	...
-	"evt":"2",		       # EVENT format version
+	"evt":"3",		       # EVENT format version
 	"exe":"2.20.1.155.g426c96fcdb" # git version
 }
 ------------
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 70cfc2f77c..3a0014417c 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -20,7 +20,7 @@ static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
  * a new field to an existing event, do not require an increment to the EVENT
  * format version.
  */
-#define TR2_EVENT_VERSION "2"
+#define TR2_EVENT_VERSION "3"
 
 /*
  * Region nesting limit for messages written to the event target.

base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
-- 
2.34.0.rc1.387.gb447b232ab-goog

