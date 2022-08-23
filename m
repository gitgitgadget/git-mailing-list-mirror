Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075E9C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiHWQcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbiHWQb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:31:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75975FE37E
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so7709707wms.0
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=/zzF2jGn0GacHZ51T7NWmhYhY7TMlOeRLghvEMcULuM=;
        b=BIsCjWo/T8FVLkLcVonGME+2Se0LgMqakXu8NMCNDY+2wU+jqS4py980XNzbd7w0Ro
         9uReYruQ3CNYQt5qwEWSmGXW+yTl0w6NodYI8AJ54KHmJCJqnjVmAzhdHKEQsZ4x31UQ
         DlbHuUYNSlgLnac6q5sdzj8IiOC8Xrsr61ztNRhR/F8mu1zbIsRgAABZuAKz8LwnFLkp
         MSw7D/MgySBp8FJOBawiz5jTkIpk/HgGkbx1M0PdRRp60n12qWl3ws9JzhuuB7vuUo2i
         rhhZXMmsCacnKDDgRgfSVzUnHe3moW58ieHKDBg/+UOwHewbsszAAktcOf3jRnljdNqs
         MYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=/zzF2jGn0GacHZ51T7NWmhYhY7TMlOeRLghvEMcULuM=;
        b=iWSbtVhKufMhmuMpLqnpr/ThQ+bl1md3QDpwIvjHbVEu041H8UDU50Y/MM+9nXN4gR
         AX3UjO18H87ViT3iMcG/F9iIdvKSIIV5t7ohjw4GEi4yBMnGHnxP+Rx/iQj03udG50KK
         0kCHfoLWEvjbnisNTxfSDhdVm73VuNaW44uLsp7zvX7cm0FaIJmpBClnYkEizllG1G8s
         SmEAbTtY1VuxqAhbyde+roVHkSM2SshmPiGjyPSiu0gHt3J+DmQ+JZ1dDSGZNhMdrdjK
         P1ibcLu6qPpxWKH5CldwXVhLTJaYQMGMQ3qXLcFQakgSNk7TQbUFaUUBt2em2RtVJsdX
         AqpA==
X-Gm-Message-State: ACgBeo2DqxLfe9FIv78WSwUIuRNZMy8xwL4B/IDy17EX1sU4xq6nLv9r
        VPBPTEWhOL6eZe2ZT0sf+JBGIR5/518=
X-Google-Smtp-Source: AA6agR5zSPjhukbFwBN7BBzc2GkS0+YF/GvZEI2ITQzHidWujUyPMvxx0y+AASesN180S2jErqz5VQ==
X-Received: by 2002:a05:600c:3516:b0:3a5:c28a:f01d with SMTP id h22-20020a05600c351600b003a5c28af01dmr2245999wmq.165.1661259824572;
        Tue, 23 Aug 2022 06:03:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003a5c244fc13sm22375198wml.2.2022.08.23.06.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:03:44 -0700 (PDT)
Message-Id: <46b4efd96ccf69db1525130efc1d34f13b649159.1661259820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
        <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 13:03:38 +0000
Subject: [PATCH v2 2/4] fsmonitor: macOS: allow fsmonitor to run against
 network-mounted repos
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

Follow-on to the work done to allow Windows to work against
network-mounted repos. Have macOS take advantage of the same
configuration option, 'fsmonitor.allowRemote' that was introduced for
Windows. Setting this option to true will override the default behavior
(erroring-out) when a network-mounted repo is detected by fsmonitor.

The added wrinkle being that the Unix domain socket (UDS) file used for
IPC cannot be created in a network location; instead $HOME is used if
'fsmonitor.allowRemote' is true.

If $HOME is in a network location, allow the user to override this via
the 'fsmonitor.socketDir' configuration option. There the user can
specify any local directory for the location of the UDS file.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 fsmonitor-ipc.c      | 40 ++++++++++++++++++++++++--
 fsmonitor-ipc.h      |  6 ++++
 fsmonitor-settings.c | 67 ++++++++++++++++++++++++++++++++++++++++++--
 fsmonitor-settings.h |  4 +++
 4 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 789e7397baa..1e3f0a6cf48 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -1,7 +1,6 @@
 #include "cache.h"
-#include "fsmonitor.h"
-#include "simple-ipc.h"
 #include "fsmonitor-ipc.h"
+#include "fsmonitor-settings.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -47,7 +46,42 @@ int fsmonitor_ipc__is_supported(void)
 	return 1;
 }
 
-GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
+GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(void)
+{
+#ifdef WIN32
+	return fsmonitor_ipc__get_default_path();
+#else
+	char *retval;
+	SHA_CTX sha1ctx;
+	const char *git_dir;
+	const char *sock_dir;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[SHA_DIGEST_LENGTH];
+
+	if (fsm_settings__get_allow_remote(the_repository) < 1)
+		return fsmonitor_ipc__get_default_path();
+
+	git_dir = get_git_dir();
+	sock_dir = fsm_settings__get_socket_dir(the_repository);
+
+	SHA1_Init(&sha1ctx);
+	SHA1_Update(&sha1ctx, git_dir, strlen(git_dir));
+	SHA1_Final(hash, &sha1ctx);
+
+	if (sock_dir && *sock_dir)
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+					sock_dir, hash_to_hex(hash));
+	else
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+	retval = interpolate_path(ipc_file.buf, 1);
+	if (!retval)
+		die(_("Invalid path: %s"), ipc_file.buf);
+	strbuf_release(&ipc_file);
+	return retval;
+#endif
+}
 
 enum ipc_active_state fsmonitor_ipc__get_state(void)
 {
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
index b6a7067c3af..4d27223c2a6 100644
--- a/fsmonitor-ipc.h
+++ b/fsmonitor-ipc.h
@@ -18,6 +18,12 @@ int fsmonitor_ipc__is_supported(void);
  */
 const char *fsmonitor_ipc__get_path(void);
 
+/*
+ * Returns the pathname to the default IPC named pipe or Unix domain
+ * socket.
+ */
+const char *fsmonitor_ipc__get_default_path(void);
+
 /*
  * Try to determine whether there is a `git-fsmonitor--daemon` process
  * listening on the IPC pipe/socket.
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

