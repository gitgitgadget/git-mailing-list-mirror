Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EFEC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiHWQce (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbiHWQcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:32:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45833103C5F
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h5so16121997wru.7
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=BnY0GYMcF2398tLi6yUu5KZFqOOfqDd/0vxGpV5R1BI=;
        b=hgVpZbNeqLKPVRxjQ0XOUiT0lZI+jNdPsQTQTk0vgHvCti5cUDGFv3Fo+394lL5tRw
         8DkSuLiaB2E9quvpDLUhET6Gx/EeDv2UHKTkVB1CpJiTRcHoZIvIXtanErqXXtNMOR//
         iMqqIJysp04jOq5dChcpa7P7IZMZG3DzgoJa+jsRvAz63bH3npHlgUK7y+90UaFbY5uL
         qdxKA0LKWr8h8A9FFChFBRwpYtkYbb/CGO8DA5jTqC1IH+NAVs1g5EXHQw6l6lWZxIq7
         cdzDC1BPqn+hwTNYs3Y36qNl1jCJqqOPw9gQCpnyHfP+9skN3McLcuNcjZZXfmzIKhLL
         8ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=BnY0GYMcF2398tLi6yUu5KZFqOOfqDd/0vxGpV5R1BI=;
        b=VANL1ubnsychk7vDx6ZuwFGVmOZ2o0frckkFs9mUXw16F+tAfx1i6/v2qxe8KY8zVT
         yL+EQgX2aIUPWCYtH8JpuJYz9BRmSOMB5QoSB2l7Mjj2BukQgUHb3X2z09xUr5nZs/gR
         0N+tQ8Syg+t5MbMddG3oNPjP8Tt8vKtR3AD1EGQx8fSGATaLbto7rIvJ4XkSxD/ap8on
         7D6Rs7FDwiVPUDUE8SeHjlxzPoG42bnhord5s7wg46ZyrqazTPwuYIPab+hqMa7V+GTW
         RVdegrDh5N6Cnql1ZLq1Cqlrc/C5VIpy48zf+7wtvAJCqKblLzkkkwIrnn4rYfEtTIr9
         U6DA==
X-Gm-Message-State: ACgBeo2ZlMf8890o10E3OEPUTrtegTyJUFghQ/4v5Jz7RMgTS3wLrS3B
        kT27qKT3XtU/jzPdJV102scYILmhNAc=
X-Google-Smtp-Source: AA6agR6mkTxYSokLrgmDMofVPew/tDbUrLAfvoQPjJuF31o9RvmAaDtFvgX+h+n4SqvG1j1EP5MNHg==
X-Received: by 2002:adf:fc8b:0:b0:225:5a71:be1a with SMTP id g11-20020adffc8b000000b002255a71be1amr5073678wrr.651.1661259827169;
        Tue, 23 Aug 2022 06:03:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a54d610e5fsm16316305wmq.26.2022.08.23.06.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:03:46 -0700 (PDT)
Message-Id: <15c965801f81d8b5c42223aa422b23302cb9210b.1661259820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
        <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
From:   "edecosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 13:03:40 +0000
Subject: [PATCH v2 4/4] Minor refactoring and simplification of Windows
 settings checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        edecosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: edecosta <edecosta@mathworks.com>

Read the value of 'fsmonitor.allowRemote' from fsmonitor_settings
via fsm_settings__get_allow_remote getter. Remove check_config_allowremote.
Replace switch statement with a simpler if statement. Move the check
for 'fsmonitor.allowRemote' above the remote protocol check.

Signed-off-by: edecosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 31 ++++-----------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index e5ec5b0a9f7..34635e6c849 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -24,23 +24,6 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-/*
- * Check if monitoring remote working directories is allowed.
- *
- * By default, monitoring remote working directories is
- * disabled.  Users may override this behavior in enviroments where
- * they have proper support.
- */
-static int check_config_allowremote(struct repository *r)
-{
-	int allow;
-
-	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
-		return allow;
-
-	return -1; /* fsmonitor.allowremote not set */
-}
-
 /*
  * Check remote working directory protocol.
  *
@@ -170,20 +153,14 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 				 "check_remote('%s') true",
 				 r->worktree);
 
+		if (fsm_settings__get_allow_remote(r) < 1)
+			return FSMONITOR_REASON_REMOTE;
+
 		ret = check_remote_protocol(wfullpath);
 		if (ret < 0)
 			return FSMONITOR_REASON_ERROR;
 
-		switch (check_config_allowremote(r)) {
-		case 0: /* config overrides and disables */
-			return FSMONITOR_REASON_REMOTE;
-		case 1: /* config overrides and enables */
-			return FSMONITOR_REASON_OK;
-		default:
-			break; /* config has no opinion */
-		}
-
-		return FSMONITOR_REASON_REMOTE;
+		return FSMONITOR_REASON_OK;
 	}
 
 	return FSMONITOR_REASON_OK;
-- 
gitgitgadget
