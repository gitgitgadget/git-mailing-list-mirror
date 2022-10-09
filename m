Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06BBC433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJIOh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJIOhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354CB275CD
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p26-20020a7bcc9a000000b003c384e59047so3070621wma.4
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wcm8qpzJovNixZr4FfekgJCx0i3cU8b+4aQdred0fgg=;
        b=N5La4ECgEAxOCg0Zv3uKZ7ZvCUTn6B6O9EWA/TKFL0dOaMzFhVd4SuXwJT7UkkCybr
         Wtdu+en6FSCjiMYRO4Ivx/o1oSmWVINTTRL3BFbgFqhuPQgXXxugW0ylyRxxdPI06AYH
         hYA9EZR9yw48y9xCQSf7cDA5ALeMXoLqwbzZJUV7FoMNl8TP9BYWimCX9+TpqC29h70x
         bu9PXz1tHqcJXzQhRy/EqhdIU8+CCPtz2NYH5DgNuAUB5yJkIL4MjHK3lZOhSfSxfq33
         nLwCGjEAuhYbRQFzdf14URpRf70zftL0Tjg0CoVW2JJSBxCbi2sqtZCE18bhs+SgS1Yz
         0r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wcm8qpzJovNixZr4FfekgJCx0i3cU8b+4aQdred0fgg=;
        b=NsF3vaBk6ZVunvslU8n7XvBEsEPppuj1n0XxxCyGiF7KU44IQoLhRlVUsQdicw+Heh
         trdKSg3evpojxyJj6R8lzj2ELXCAMLa/PBUSU4JZlbDpCJav64lKNV4aXTvIdc5M3OWn
         Qgz3azpOQ4pfV9ha29qs4P5c6OSOTsuovdeN+NfWOyoVE5NWzwqKLb4ZyXniZMzgvndt
         KLwJmFUA0K4mKBiFkO5nfaFHGmtZ3ROR0sShqzbDktTpscBDZjyO4gFSGYnNbQFdlUkr
         qCaHPOO9dh3sVfLnpTUNHGU9SVrUN5nqTvgKOKZth2x5r/6CpI5HWpNb6SG4RACRtUeJ
         PBTQ==
X-Gm-Message-State: ACrzQf2aPUrCnxF8hUp/MqEesLEKclgJsPrcwMAYHdKW62c5U0zKgSpU
        SIdGUtHkh/t7jtB2e644esk7d1+jbMI=
X-Google-Smtp-Source: AMsMyM4PDjcsfmsU9HLCclj5h/aLzUxd7tWF14CqdGo5dw2XnIZm6HGoS/x3dOX5byJICnne2BsUIQ==
X-Received: by 2002:a05:600c:d5:b0:3c0:fba1:d2b9 with SMTP id u21-20020a05600c00d500b003c0fba1d2b9mr9650228wmm.108.1665326262544;
        Sun, 09 Oct 2022 07:37:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm7631593wmc.43.2022.10.09.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:42 -0700 (PDT)
Message-Id: <c5e8b6cfe5da269d27d3f171ccedd119a6db4840.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:29 +0000
Subject: [PATCH 03/12] fsmonitor: avoid socket location check if using hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

If monitoring is done via fsmonitor hook rather than IPC there is no
need to check if the location of the Unix Domain socket (UDS) file is
on a remote filesystem.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 10 ++++++----
 compat/fsmonitor/fsm-settings-win32.c  |  2 +-
 fsmonitor-settings.c                   |  8 ++++----
 fsmonitor-settings.h                   |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 7241c4c22c9..6abbc7af3ab 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -48,13 +48,15 @@ static enum fsmonitor_reason check_uds_volume(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
 {
 	enum fsmonitor_reason reason;
 
-	reason = check_uds_volume(r);
-	if (reason != FSMONITOR_REASON_OK)
-		return reason;
+	if (ipc) {
+		reason = check_uds_volume(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
 
 	return FSMONITOR_REASON_OK;
 }
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index d88b06ae610..a8af31b71de 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -25,7 +25,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
 {
 	enum fsmonitor_reason reason;
 
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index d288cbad479..531a1b6f956 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -60,7 +60,7 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 }
 #endif
 
-static enum fsmonitor_reason check_for_incompatible(struct repository *r)
+static enum fsmonitor_reason check_for_incompatible(struct repository *r, int ipc)
 {
 	if (!r->worktree) {
 		/*
@@ -77,7 +77,7 @@ static enum fsmonitor_reason check_for_incompatible(struct repository *r)
 		reason = check_remote(r);
 		if (reason != FSMONITOR_REASON_OK)
 			return reason;
-		reason = fsm_os__incompatible(r);
+		reason = fsm_os__incompatible(r, ipc);
 		if (reason != FSMONITOR_REASON_OK)
 			return reason;
 	}
@@ -162,7 +162,7 @@ const char *fsm_settings__get_hook_path(struct repository *r)
 
 void fsm_settings__set_ipc(struct repository *r)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason = check_for_incompatible(r, 1);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
@@ -185,7 +185,7 @@ void fsm_settings__set_ipc(struct repository *r)
 
 void fsm_settings__set_hook(struct repository *r, const char *path)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason = check_for_incompatible(r, 0);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index d9c2605197f..0721617b95a 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -48,7 +48,7 @@ struct fsmonitor_settings;
  * fsm_os__* routines should considered private to fsm_settings__
  * routines.
  */
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r);
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc);
 #endif /* HAVE_FSMONITOR_OS_SETTINGS */
 
 #endif /* FSMONITOR_SETTINGS_H */
-- 
gitgitgadget

