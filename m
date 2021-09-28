Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D049CC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB1A61357
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbhI1Xep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243279AbhI1Xei (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:34:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6969C061753
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so1124680wrq.4
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hJTprmd6l9eGdcrH8bWYEQJ64Pw67KrU1jFu1jkOkoM=;
        b=WyTXcdJgtII1WE8LybN9R6z/BMY6WhyiJ/tYUvAkuviF8bNKQizX1PExaJ4rAwlh5F
         tCZ8OKSsq6PJyUEUbtDvqwRqKwwd19X79S2szCC0xpBzLVSSPK9UIM+/5n1T5qQDT1ys
         itDWUoDbqeFtj/eeI1vEmkgy9TP3gYL5dGzJBBGcC9kOv5EFF18P9AepyUAedq1xqVeP
         SBselKr6mnZ7X/JfrhO6456Yy56PlGWAKPFRxJsaOQpM9kJxCg6MhjAjfME1kBbKAbWP
         aWZlUHz2gQna4Gy9H1+wGXbSOBdPazsVdAzA2N5YoGmkNcgem9KPKoe7IFVL20UIRB62
         Z2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hJTprmd6l9eGdcrH8bWYEQJ64Pw67KrU1jFu1jkOkoM=;
        b=L2dlAE6qfeUuDu+yPSEiecJmcm+/vf68yRdFue+O6pTLUddqxXG3CMLchbk1oGFKhH
         YeoJtGRfv33DM32jHn3IQCEWsRrIr+ao6KLza+KnlDGwd35+LBBYxhCWMp+KKhMK71/E
         v/VTAuue4NEWp4HNLl9AJY2Z9py1uGjUs5WGzIoBCoOs7vqR3TWSO6LLQYTzRaf1rSX5
         pERc60q4BIMCu0kRLyZtH8jwvje6bvoovIK0K8aNGUDEhb4ud2ItizOW2hR2+73HBONY
         yX5s12MpND5lz37Ebhq7a4fh2CD/27ODpAiti/ho+jKywaXv5TV8znYXyYT66L5LJ1cQ
         mPxQ==
X-Gm-Message-State: AOAM5309sMDwMIMlau8owxvzob1nCpJu1ECTcL9KMuiPG3Ds3l+xDmVw
        f1A7clHImkzWduk45OVhEvWdrb4itZ0=
X-Google-Smtp-Source: ABdhPJx8mv0hJFAxgt/4JCqyMlefz6/ooHyC0gm1SsTBsiQ4MhIjAOIe7CIxomEUVNU6Th5VKwmUsw==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr3144955wrj.352.1632871976516;
        Tue, 28 Sep 2021 16:32:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n66sm399093wmn.2.2021.09.28.16.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:32:56 -0700 (PDT)
Message-Id: <09dbff1004ed9b7ae501f7b1cfc91cd743195fd6.1632871972.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
References: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
        <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 23:32:48 +0000
Subject: [PATCH v7 6/9] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables bulk-checkin for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
pack functionality and the new bulk-fsync functionality.

There is some risk with this change, since under batch fsync, the object
files will not be available until the update-index is entirely complete.
This usage is unlikely, since any tool invoking update-index and
expecting to see objects would have to synchronize with the update-index
process after passing it a file path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..dc7368bb1ee 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1088,6 +1089,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	the_index.updated_skipworktree = 1;
 
+	/* we might be adding many objects to the object database */
+	plug_bulk_checkin();
+
 	/*
 	 * Custom copy of parse_options() because we want to handle
 	 * filename arguments as they come.
@@ -1168,6 +1172,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	/* by now we must have added all of the new objects */
+	unplug_bulk_checkin();
 	if (split_index > 0) {
 		if (git_config_get_split_index() == 0)
 			warning(_("core.splitIndex is set to false; "
-- 
gitgitgadget

