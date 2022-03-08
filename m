Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68B2C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350700AbiCHWRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350716AbiCHWQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2AB58388
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so2281055wmj.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fZaRUHCUQGI6ja6oRWsed7mGTlu+pk0Joi+yuifJOlM=;
        b=G9tkxh9qviPRoPYfGE7Opg4k1JlR/qzqDDtLIwszMhyOwgZUvjufQ7O3JgrvO7GMGP
         94paTR/8Xy8YPhab52aHswYHd6X4Wiz0bXuBqJVbHbPBSc9cWjow7uDesaRS3C/ycfC1
         vA5dX7mQPzC4T4RzG7KY9WF+MY0MIFg2zK2yMFG3PD2Ig2GF36fSlfAMZp8mYAk9N6iR
         YRUqJlKY2ycdKS8xL0bE4hYNMlVdsyV5OiVHFjaaXa23ZW8jsdXPy9EB8QeaJkZGCUKL
         wCDg3EBf6YCc1LYDCWacK5HhlZUhZERklPh52QBaw5+VcP+1fjBdB9TxFy/E7QPaZtxN
         HMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fZaRUHCUQGI6ja6oRWsed7mGTlu+pk0Joi+yuifJOlM=;
        b=FOZcwz96NSFElZ3pjOQBBDpEXranuoLJvTsMctDGLQwx8iRKemkzn1t3t54qMk6Mt8
         JUTgdPfKc/HExACwQL88/SM65Uauj6d78e7u8MItZjNZ50j2sH0nQ0FU57i+ex1wu3+a
         HI3qWbJWtUKjSm+W+sxjpc2MHU24ZvlOWg4b2T1Tuu3O3c3BGhYjOvr2Jqdxr3PPxzAS
         45BPpvU6B8sIDxrx+Inz4RoKQ58YOInNM01jBJE4z2wdsDqLZL/px1gzdhy4dP/ztYAn
         1m29YOjhzd0OHxDhdxmtO9XgvyO+VdqLdCYFftmFaeXUutd05XHucjUQsenl15Xu4qyU
         XPQw==
X-Gm-Message-State: AOAM5321vqFZIs4W6j/2mcaEmx38Z/6k0XEid96LJI5JhkOhrmpaeE7g
        OGUA7m7v9ORQBymoCmFSENG36DtL4nQ=
X-Google-Smtp-Source: ABdhPJwR2dgTIKkMhAWdunLCbT4XbfZBmYfBhes5irldDW0x/WmtVIau4g2dyIQImztDjISzPoPCoQ==
X-Received: by 2002:a7b:cd82:0:b0:389:77ef:66d7 with SMTP id y2-20020a7bcd82000000b0038977ef66d7mr1020221wmj.171.1646777754402;
        Tue, 08 Mar 2022 14:15:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b00389a623c80esm73868wmb.1.2022.03.08.14.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:54 -0800 (PST)
Message-Id: <95b9d4210d2c888689d2d6ffd60adb4c43d03bcc.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:24 +0000
Subject: [PATCH v2 24/27] fsmonitor: on macOS also emit NFC spelling for NFD
 pathname
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Emit NFC or NFC and NFD spellings of pathnames on macOS.

MacOS is Unicode composition insensitive, so NFC and NFD spellings are
treated as aliases and collide.  While the spelling of pathnames in
filesystem events depends upon the underlying filesystem, such as
APFS, HFS+ or FAT32, the OS enforces such collisions regardless of
filesystem.

Teach the daemon to always report the NFC spelling and to report
the NFD spelling when stored in that format on the disk.

This is slightly more general than "core.precomposeUnicode".

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 33 ++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index b6c33f2cf3b..3332d3b7792 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -227,6 +227,35 @@ static int ef_ignore_xattr(const FSEventStreamEventFlags ef)
 	return ((ef & mask) == kFSEventStreamEventFlagItemXattrMod);
 }
 
+/*
+ * On MacOS we have to adjust for Unicode composition insensitivity
+ * (where NFC and NFD spellings are not respected).  The different
+ * spellings are essentially aliases regardless of how the path is
+ * actually stored on the disk.
+ *
+ * This is related to "core.precomposeUnicode" (which wants to try
+ * to hide NFD completely and treat everything as NFC).  Here, we
+ * don't know what the value the client has (or will have) for this
+ * config setting when they make a query, so assume the worst and
+ * emit both when the OS gives us an NFD path.
+ */
+static void my_add_path(struct fsmonitor_batch *batch, const char *path)
+{
+	char *composed;
+
+	/* add the NFC or NFD path as received from the OS */
+	fsmonitor_batch__add_path(batch, path);
+
+	/* if NFD, also add the corresponding NFC spelling */
+	composed = (char *)precompose_string_if_needed(path);
+	if (!composed || composed == path)
+		return;
+
+	fsmonitor_batch__add_path(batch, composed);
+	free(composed);
+}
+
+
 static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     void *ctx,
 			     size_t num_of_events,
@@ -377,7 +406,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 
 				if (!batch)
 					batch = fsmonitor_batch__new();
-				fsmonitor_batch__add_path(batch, rel);
+				my_add_path(batch, rel);
 			}
 
 			if (event_flags[k] & kFSEventStreamEventFlagItemIsDir) {
@@ -390,7 +419,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 
 				if (!batch)
 					batch = fsmonitor_batch__new();
-				fsmonitor_batch__add_path(batch, tmp.buf);
+				my_add_path(batch, tmp.buf);
 			}
 
 			break;
-- 
gitgitgadget

