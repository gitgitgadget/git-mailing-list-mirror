Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45522C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbiCVS0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbiCVS0I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:26:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469BE90CFC
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:24:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b19so24620111wrh.11
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=WrUgnjcGMGoGGKU/Ehif714ADbETA5wXYLRFv0bS7YcWzVqRFwCggAU7TM0KVbUCz3
         7BGldD50SUPclN7ZloXy+ms9idH2FEBciLaI3mA0uw2Oy2aDc8VuUOgvr1iJH2Y809eh
         IDtRPAwYYNLD08yIkFhxP1JvB6mMvUsnOsiZdcbRb6zTQXBJfGYB8CP1kqYTxf+kc2v3
         UD4j0WOFd8n/peP8uAzCF1C+9dJu3WztgxXfvuT1QzHA37sUi/8K3pQxJiXKBXyYId9R
         CprtyclWrf93DKOZ7VZdCHuDV4LdHaZ3MR5Xwbu8fWZFSN9kgnRiPeTGLVvdTY0a4Vyd
         m1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=GS6lWzF0EvrYMJqSIrew81y/GrQ59BMyu/o8XCeNLZ4alGTUNOUDEjuTfuN7ZHRGL+
         YnPyWX2LXPCd18aMze3dS1/9Pkxjexa3N7O+VogYNQn3RaLsjdUaCjEg2+EF9RUsrVJT
         nxVLPqO/NNXq0YGmj69w/kOvAwCF1mfFJW6eGOh5LBsxRP/fg+FJLPPeTKK/VDsKDCPL
         HSHSiW+lhae012Q1xGGSMSqX4j/g5ei3SDhLn6ekrglRlIkz9OZZflWjbqgIuVt3c6aq
         Ez44l7hSD9Gxx52LQOVdPrB6go3Ocxgvj66qY1Ae5VRxvTJP58pJ1y9Cqw/tnPyuZjc4
         f10A==
X-Gm-Message-State: AOAM533bufbU10s5iZmIqeO3jaQNZnfdNedivAMPD5nEhbDGnJmbIafR
        +SFEFdt/BwpmabAeQNkIHcw5EWhu19Y=
X-Google-Smtp-Source: ABdhPJyyRx/Wvth+f+VqpBNAcWXriNXevrXSUzZER2BZaA/13AoBZsoq+FGpUw8mq6OaM+e0QJEbfg==
X-Received: by 2002:adf:da50:0:b0:204:7d8:b654 with SMTP id r16-20020adfda50000000b0020407d8b654mr11964230wrl.607.1647973445565;
        Tue, 22 Mar 2022 11:24:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c4fd000b0038cbd198602sm1291032wmq.34.2022.03.22.11.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:24:04 -0700 (PDT)
Message-Id: <264397e8bd4b53ecf1d260b99d1895b8d153f82b.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:58 +0000
Subject: [PATCH v3 25/27] fsmonitor: on macOS also emit NFC spelling for NFD
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
index 83d38e8ac6c..823cf63999e 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -155,6 +155,35 @@ static int ef_ignore_xattr(const FSEventStreamEventFlags ef)
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
@@ -305,7 +334,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 
 				if (!batch)
 					batch = fsmonitor_batch__new();
-				fsmonitor_batch__add_path(batch, rel);
+				my_add_path(batch, rel);
 			}
 
 			if (event_flags[k] & kFSEventStreamEventFlagItemIsDir) {
@@ -318,7 +347,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 
 				if (!batch)
 					batch = fsmonitor_batch__new();
-				fsmonitor_batch__add_path(batch, tmp.buf);
+				my_add_path(batch, tmp.buf);
 			}
 
 			break;
-- 
gitgitgadget

