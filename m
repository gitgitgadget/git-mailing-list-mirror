Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72882C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiEYPC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245019AbiEYPBg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977DBAFACE
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t6so30521671wra.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=nv3AM7+miUpGMmChd2BIiaEpxyIu6rURBs+ylLKYy1vamv2wzhar4B402UD/n3atFR
         N3XKuAaRg7sFwgHSPx0i+rR8PuA3E9xALAbUMe+LVoEHkxpdYxpJP9ulaTh91z3GOXQG
         ApyJ8nlkuQg4tm2ofJrPcAg14DWuckISQb23Ay7ukXi9w9qZ3oSlxawgltCFBTZ4QLSA
         WJvbiPAfnOE2HMvsiR/uCRluazWj07Toohf4PTh6tajT4gVjzjwOUpLyFY223NG1RCeR
         iVZPAuvAAQxT7m+RSDJCEOVw5M/8GMMlBQJ9FphsbkF2eQhHPHwTxUAbD/Ul1gsj+wpd
         CqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=fPeHMKeiTdwXruQTyM7waJBDRVYIxBoWYtdaHz0J6mfa6XyghpgVCfqVCzsLvgD3/A
         E9aPvCettZEcXzrVCtk/S825NGq3e0OCoTnajDp3VBsJheEASvhMOn2JHIE56SNgHall
         RaWmR8s3p5gL/Y7UmZ6bHxNXtc7OjXCamF6ntAWjRhrOPdm4dOj7eCvGk06MCSKE1xeg
         IW9m7In+gq0bZzVUGcPgYyd46/ow+ZWF4Rm7c+jOcVcZLVGRStAZMyGXChr+gH9zBSMc
         xiRztOG1jzaOhSpEeLHdyXFyaOMwBMy4QKBoXw8668juvmZqHFwqb9cjZJI7WV3LRLLP
         XEjw==
X-Gm-Message-State: AOAM532lHEcJbhCFQD94vWg+EO+gODZRyklqkfsrIcFDDxDCOiyBr/LR
        Z3dUtm3kaFGtJndzLldjJjzrHj/154U=
X-Google-Smtp-Source: ABdhPJwXEOUTpkI6P3nJWkAHML09TT9JdguFzC6A8RMKRIA47jqY7jTB0GsEpOMv3BWqZMLMPVYEqA==
X-Received: by 2002:a5d:5262:0:b0:20f:fcaf:7d83 with SMTP id l2-20020a5d5262000000b0020ffcaf7d83mr3591113wrc.532.1653490893336;
        Wed, 25 May 2022 08:01:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1-20020a1ccc01000000b00397342e3830sm5672594wmb.0.2022.05.25.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:32 -0700 (PDT)
Message-Id: <ea19a06e8cb263a5a33a099c1782fb6d535d571f.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:47 +0000
Subject: [PATCH v8 25/30] fsmonitor: on macOS also emit NFC spelling for NFD
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

