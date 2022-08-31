Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CC9ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiHaQJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiHaQJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:09:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945DF43E6A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso11960286wmh.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=UH6BST2xsgOSZkwrhMmvFJO7kolfu7XJE/lE1W/C990=;
        b=NkluoF2pA89kig8wZVm2Rv579t3ZE/7X8j2IC63XYZmqbTp2YVTOn5HJWMLCT2A2l8
         /lh+CqIn0z8hEAHDg/AywwZDUXZZKZXyIeLJoQKo31x3kqJQ7NBO0RD9CSpAGiysIR/J
         NnJsVL0/kM/DzdIl9wpU72QxNDjin1VxOe0qPh0yR8ZKkQuHZPyrl85qen11HXPDrF36
         5hGfEOkmnF7JZTSe+PfmY15gG2PXEvfBmgomZ37rfFaARn48EJZnu3/rYq5VBNrAoxDI
         rECUxDYjPy96XmDriNjuI8dj1A3hvi9vw7Oe/CikyaGADkcz9PDLXYtqCjXu5eYH6SU8
         jhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=UH6BST2xsgOSZkwrhMmvFJO7kolfu7XJE/lE1W/C990=;
        b=ZbnvgDbU/tuttvLCEFz7lCkdPjcNfM+SLYGHgy3VtwXj76vNxkM7GBEYGlpOJ2mq3L
         0gO0SfV6ZTde92qi62R0EVNnZzqdAmiER6hSiRJSJm5RgYy5HCkvBkRmeuY+lgE1lK6E
         KP+PADewCh42FtMbmk5FgirXe/FBhRmwfQ3My+K4kLF/IaEUjwl0V7jzbl9cr6gfktbO
         UFiMHQBtLRZufneIRaUY+VTQ7eroypVvXeV3UOFy8DYvZdH6+19LL0iFZL+WYdViTQkU
         a/8l+3csRwTz+VIGBeV1/QJXxvHgrv4dE3dXMrTrtQOM0dTWhrcwYpHvICAgwEBTyv9Q
         GKBw==
X-Gm-Message-State: ACgBeo36qNJUxCNlL2hqpT4YRJXbZ0xCIsIz5ttWBnFtNsAkh4bcvcYg
        5XMfi715uOLidVdmiyJtXKxiCLHhOZk=
X-Google-Smtp-Source: AA6agR6X3XwNuo44x441CkWFOXxcZ0rzmJMOgPCW5xAnt9pY7olB5xa9twUlVqnVlfcNIJ2HFKnJsQ==
X-Received: by 2002:a05:600c:1ca0:b0:3a8:41cf:a31f with SMTP id k32-20020a05600c1ca000b003a841cfa31fmr2527898wms.161.1661962148879;
        Wed, 31 Aug 2022 09:09:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020a1c3b06000000b003a4efb794d7sm2827667wma.36.2022.08.31.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:09:07 -0700 (PDT)
Message-Id: <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
        <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:09:01 +0000
Subject: [PATCH v4 1/4] fsmonitor: add two new config options, allowRemote and
 socketDir
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

Introduce two new configuration options

   fsmonitor.allowRemote - setting this to true overrides fsmonitor's
   default behavior of erroring out when enountering network file
   systems. Additionly, when true, the Unix domain socket (UDS) file
   used for IPC is located in $HOME rather than in the .git directory.

   fsmonitor.socketDir - allows for the UDS file to be located
   anywhere the user chooses rather $HOME.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 fsmonitor-settings.c | 67 ++++++++++++++++++++++++++++++++++++++++++--
 fsmonitor-settings.h |  4 +++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 464424a1e92..a15eeecebf4 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -10,7 +10,9 @@
 struct fsmonitor_settings {
 	enum fsmonitor_mode mode;
 	enum fsmonitor_reason reason;
+	int allow_remote;
 	char *hook_path;
+	char *sock_dir;
 };
 
 static enum fsmonitor_reason check_for_incompatible(struct repository *r)
@@ -43,6 +45,7 @@ static struct fsmonitor_settings *alloc_settings(void)
 	CALLOC_ARRAY(s, 1);
 	s->mode = FSMONITOR_MODE_DISABLED;
 	s->reason = FSMONITOR_REASON_UNTESTED;
+	s->allow_remote = -1;
 
 	return s;
 }
@@ -90,6 +93,26 @@ static void lookup_fsmonitor_settings(struct repository *r)
 		fsm_settings__set_disabled(r);
 }
 
+int fsm_settings__get_allow_remote(struct repository *r)
+{
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->allow_remote;
+}
+
+const char *fsm_settings__get_socket_dir(struct repository *r)
+{
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->sock_dir;
+}
+
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
 {
 	if (!r)
@@ -100,6 +123,7 @@ enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
 	return r->settings.fsmonitor->mode;
 }
 
+
 const char *fsm_settings__get_hook_path(struct repository *r)
 {
 	if (!r)
@@ -110,9 +134,44 @@ const char *fsm_settings__get_hook_path(struct repository *r)
 	return r->settings.fsmonitor->hook_path;
 }
 
+void fsm_settings__set_allow_remote(struct repository *r)
+{
+	int allow;
+
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		r->settings.fsmonitor = alloc_settings();
+	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
+		r->settings.fsmonitor->allow_remote = allow;
+
+	return;
+}
+
+void fsm_settings__set_socket_dir(struct repository *r)
+{
+	const char *path;
+
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		r->settings.fsmonitor = alloc_settings();
+
+	if (!repo_config_get_pathname(r, "fsmonitor.socketdir", &path)) {
+		FREE_AND_NULL(r->settings.fsmonitor->sock_dir);
+		r->settings.fsmonitor->sock_dir = strdup(path);
+	}
+
+	return;
+}
+
 void fsm_settings__set_ipc(struct repository *r)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason;
+
+	fsm_settings__set_allow_remote(r);
+	fsm_settings__set_socket_dir(r);
+	reason = check_for_incompatible(r);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
@@ -135,7 +194,11 @@ void fsm_settings__set_ipc(struct repository *r)
 
 void fsm_settings__set_hook(struct repository *r, const char *path)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason;
+
+	fsm_settings__set_allow_remote(r);
+	fsm_settings__set_socket_dir(r);
+	reason = check_for_incompatible(r);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index d9c2605197f..2de54c85e94 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -23,12 +23,16 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
 };
 
+void fsm_settings__set_allow_remote(struct repository *r);
+void fsm_settings__set_socket_dir(struct repository *r);
 void fsm_settings__set_ipc(struct repository *r);
 void fsm_settings__set_hook(struct repository *r, const char *path);
 void fsm_settings__set_disabled(struct repository *r);
 void fsm_settings__set_incompatible(struct repository *r,
 				    enum fsmonitor_reason reason);
 
+int fsm_settings__get_allow_remote(struct repository *r);
+const char *fsm_settings__get_socket_dir(struct repository *r);
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
 
-- 
gitgitgadget

