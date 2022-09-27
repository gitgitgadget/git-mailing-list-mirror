Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE6C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 20:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiI0U5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiI0U5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 16:57:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D56149D2F
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:57:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x18so16799314wrm.7
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=yzfz98q2dztrByC52f9hrlPrszlAs4lsv0IDlH5j8u8=;
        b=imeBIeGR3HapbmDlzJt62qnxIIuUlruyY1IPMse+G6T3BtdVx73RRHfzY4vavoxt2R
         GQ1HDfo4tGpM5JXtFvQ6xEhCB68jcrWvAUJq90fqanMwpr5dLj5SMoLAL5mkaP/IZadq
         qz2mcOmSNAQTPG5S/K2+X0P6lt2rmwJaNLJ8cmKacCBVZeOkukySfyGx64LlDHHxS+x3
         VuLxtUVOebAo6T+RZ5Nn+1k+4SdvBbfvQPPU8z+6DTVH0b5599Q7j5w/ZUXQF06duCTy
         Zpz9ngvXi5pgqnXTsL+rp7XpKmH7bSz6RtqNU/gSWBIXLXV2KHSq18PZ6NxdX0AJUprP
         AOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yzfz98q2dztrByC52f9hrlPrszlAs4lsv0IDlH5j8u8=;
        b=NDe3JAZwcA09/IEUiRHwBJ9etJFK3NZpNcFUR96d/9AGr5XJi5V/4bZuhy9GDFqMWG
         qDxFBeVUQDQ2xL0a5ywR6lfvuOkqdYZz0NdMj4iYCjZXp5Tue/EERWdzrUPV44fcjNvC
         44z0M/1LGQqEFZCpxSlqBe5UwYV+ekE8lHr4+v4K5GazPJSJ5JHhiHFGz1a6afeebUQT
         uHoiAuyqTX5+R3+BscNUsNJsdPVIizMig4VHw+guE2zAqnPmGeL6a8mvfQUZ16vTFEqH
         4kFus8onEFi44f6G7ASR1U+ZhzfEugA9wSzokVsVRsIOTAoyoDyRNWUc/wPzhyz7rjC/
         NvSw==
X-Gm-Message-State: ACrzQf3GOuSH510/hdA5VVpBB4EYkFwQ7/gG4fJ3HpevcH1OhlU3aube
        cWCRGmH0zalRidis39LwTfY/bWdUzQg=
X-Google-Smtp-Source: AMsMyM4oE01UwMmqXh/HKGdCEY4HtKrpcSO0TvCBpoKt0N8lExhR1SGApM3TBl3/B+aPrRC3pqN6Jg==
X-Received: by 2002:adf:9dd0:0:b0:22c:3fe0:42ef with SMTP id q16-20020adf9dd0000000b0022c3fe042efmr14693224wre.348.1664312259609;
        Tue, 27 Sep 2022 13:57:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-20020adfa501000000b0022a2f4fa042sm2628316wrb.103.2022.09.27.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:57:39 -0700 (PDT)
Message-Id: <324eb5acd856f6a8122a5239f9fa1a9a8ecc9ee3.1664312254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
References: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
        <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 20:57:31 +0000
Subject: [PATCH v13 4/6] fsmonitor: deal with synthetic firmlinks on macOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Starting with macOS 10.15 (Catalina), Apple introduced a new feature
called 'firmlinks' in order to separate the boot volume into two
volumes, one read-only and one writable but still present them to the
user as a single volume. Along with this change, Apple removed the
ability to create symlinks in the root directory and replaced them with
'synthetic firmlinks'. See 'man synthetic.conf'

When FSEevents reports the path of changed files, if the path involves
a synthetic firmlink, the path is reported from the point of the
synthetic firmlink and not the real path. For example:

Real path:
/System/Volumes/Data/network/working/directory/foo.txt

Synthetic firmlink:
/network -> /System/Volumes/Data/network

FSEvents path:
/network/working/directory/foo.txt

This causes the FSEvents path to not match against the worktree
directory.

There are several ways in which synthetic firmlinks can be created:
they can be defined in /etc/synthetic.conf, the automounter can create
them, and there may be other means. Simply reading /etc/synthetic.conf
is insufficient. No matter what process creates synthetic firmlinks,
they all get created in the root directory.

Therefore, in order to deal with synthetic firmlinks, the root directory
is scanned and the first possible synthetic firmink that, when resolved,
is a prefix of the worktree is used to map FSEvents paths to worktree
paths.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 builtin/fsmonitor--daemon.c              | 10 +++
 compat/fsmonitor/fsm-listen-darwin.c     | 14 +++-
 compat/fsmonitor/fsm-path-utils-darwin.c | 93 ++++++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 17 +++++
 fsmonitor--daemon.h                      |  3 +
 fsmonitor-path-utils.h                   | 36 ++++++++-
 6 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 0123fc33ed2..d5056a97a06 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
 #include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
 #include "fsmonitor--daemon.h"
@@ -1282,6 +1283,13 @@ static int fsmonitor_run_daemon(void)
 	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
 	state.nr_paths_watching = 1;
 
+	strbuf_init(&state.alias.alias, 0);
+	strbuf_init(&state.alias.points_to, 0);
+	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
+		err = error(_("could not get worktree alias"));
+		goto done;
+	}
+
 	/*
 	 * We create and delete cookie files somewhere inside the .git
 	 * directory to help us keep sync with the file system.  If
@@ -1391,6 +1399,8 @@ done:
 	strbuf_release(&state.path_gitdir_watch);
 	strbuf_release(&state.path_cookie_prefix);
 	strbuf_release(&state.path_ipc);
+	strbuf_release(&state.alias.alias);
+	strbuf_release(&state.alias.points_to);
 
 	return err;
 }
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 8e208e8289e..daeee4e465c 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -26,6 +26,7 @@
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "fsmonitor-path-utils.h"
 
 struct fsm_listen_data
 {
@@ -198,8 +199,9 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
 	const char *path_k;
 	const char *slash;
-	int k;
+	char *resolved = NULL;
 	struct strbuf tmp = STRBUF_INIT;
+	int k;
 
 	/*
 	 * Build a list of all filesystem changes into a private/local
@@ -209,7 +211,12 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 		/*
 		 * On Mac, we receive an array of absolute paths.
 		 */
-		path_k = paths[k];
+		free(resolved);
+		resolved = fsmonitor__resolve_alias(paths[k], &state->alias);
+		if (resolved)
+			path_k = resolved;
+		else
+			path_k = paths[k];
 
 		/*
 		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
@@ -238,6 +245,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			fsmonitor_force_resync(state);
 			fsmonitor_batch__free_list(batch);
 			string_list_clear(&cookie_list, 0);
+			batch = NULL;
 
 			/*
 			 * We assume that any events that we received
@@ -360,12 +368,14 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 		}
 	}
 
+	free(resolved);
 	fsmonitor_publish(state, batch, &cookie_list);
 	string_list_clear(&cookie_list, 0);
 	strbuf_release(&tmp);
 	return;
 
 force_shutdown:
+	free(resolved);
 	fsmonitor_batch__free_list(batch);
 	string_list_clear(&cookie_list, 0);
 
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
index 067cbe6990a..931c9318572 100644
--- a/compat/fsmonitor/fsm-path-utils-darwin.c
+++ b/compat/fsmonitor/fsm-path-utils-darwin.c
@@ -1,5 +1,8 @@
 #include "fsmonitor.h"
 #include "fsmonitor-path-utils.h"
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
 #include <sys/param.h>
 #include <sys/mount.h>
 
@@ -38,3 +41,93 @@ int fsmonitor__is_fs_remote(const char *path)
 		return -1;
 	return fs.is_remote;
 }
+
+/*
+ * Scan the root directory for synthetic firmlinks that when resolved
+ * are a prefix of the path, stopping at the first one found.
+ *
+ * Some information about firmlinks and synthetic firmlinks:
+ * https://eclecticlight.co/2020/01/23/catalina-boot-volumes/
+ *
+ * macOS no longer allows symlinks in the root directory; any link found
+ * there is therefore a synthetic firmlink.
+ *
+ * If this function gets called often, will want to cache all the firmlink
+ * information, but for now there is only one caller of this function.
+ *
+ * If there is more than one alias for the path, that is another
+ * matter altogether.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info)
+{
+	DIR *dir;
+	int read;
+	int retval = -1;
+	struct dirent *de;
+	struct strbuf alias;
+	struct strbuf points_to;
+
+	dir = opendir("/");
+	if (!dir) {
+		error_errno("opendir('/') failed");
+		return -1;
+	}
+
+	strbuf_init(&alias, 256);
+
+	/* no way of knowing what the link will resolve to, so MAXPATHLEN */
+	strbuf_init(&points_to, MAXPATHLEN);
+
+	while ((de = readdir(dir)) != NULL) {
+		strbuf_reset(&alias);
+		strbuf_addch(&alias, '/');
+		strbuf_add(&alias, de->d_name, strlen(de->d_name));
+
+		read = readlink(alias.buf, points_to.buf, MAXPATHLEN);
+		if (read > 0) {
+			strbuf_setlen(&points_to, read);
+			if ((!strncmp(points_to.buf, path, points_to.len))
+				&& path[points_to.len] == '/') {
+				strbuf_addbuf(&info->alias, &alias);
+				strbuf_addbuf(&info->points_to, &points_to);
+				trace_printf_key(&trace_fsmonitor,
+					"Found alias for '%s' : '%s' -> '%s'",
+					path, info->alias.buf, info->points_to.buf);
+				retval = 0;
+				goto done;
+			}
+		} else if (!read) {
+			BUG("readlink returned 0");
+		} else if (errno != EINVAL) { /* Something other than not a link */
+			error_errno("readlink('%s') failed", alias.buf);
+			goto done;
+		}
+	}
+	retval = 0; /* no alias */
+
+done:
+	if (closedir(dir) < 0)
+		warning_errno("closedir('/') failed");
+	strbuf_release(&alias);
+	strbuf_release(&points_to);
+	return retval;
+}
+
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info)
+{
+	if (!info->alias.len)
+		return NULL;
+
+	if ((!strncmp(info->alias.buf, path, info->alias.len))
+		&& path[info->alias.len] == '/') {
+		struct strbuf tmp = STRBUF_INIT;
+		const char *remainder = path + info->alias.len;
+
+		strbuf_addbuf(&tmp, &info->points_to);
+		strbuf_add(&tmp, remainder, strlen(remainder));
+		return strbuf_detach(&tmp, NULL);
+	}
+
+	return NULL;
+}
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
index a90b8f7925b..0d95bbb416f 100644
--- a/compat/fsmonitor/fsm-path-utils-win32.c
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -126,3 +126,20 @@ int fsmonitor__is_fs_remote(const char *path)
 		return -1;
 	return fs.is_remote;
 }
+
+/*
+ * No-op for now.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info)
+{
+	return 0;
+}
+
+/*
+ * No-op for now.
+ */
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info)
+{
+	return NULL;
+}
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 2102a5c9ff5..e24838f9a86 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -8,6 +8,7 @@
 #include "run-command.h"
 #include "simple-ipc.h"
 #include "thread-utils.h"
+#include "fsmonitor-path-utils.h"
 
 struct fsmonitor_batch;
 struct fsmonitor_token_data;
@@ -43,6 +44,7 @@ struct fsmonitor_daemon_state {
 
 	struct strbuf path_worktree_watch;
 	struct strbuf path_gitdir_watch;
+	struct alias_info alias;
 	int nr_paths_watching;
 
 	struct fsmonitor_token_data *current_token_data;
@@ -59,6 +61,7 @@ struct fsmonitor_daemon_state {
 
 	struct ipc_server_data *ipc_server_data;
 	struct strbuf path_ipc;
+
 };
 
 /*
diff --git a/fsmonitor-path-utils.h b/fsmonitor-path-utils.h
index e48592887e7..2624798d2c7 100644
--- a/fsmonitor-path-utils.h
+++ b/fsmonitor-path-utils.h
@@ -1,13 +1,21 @@
 #ifndef FSM_PATH_UTILS_H
 #define FSM_PATH_UTILS_H
 
+#include "strbuf.h"
+
+struct alias_info
+{
+	struct strbuf alias;
+	struct strbuf points_to;
+};
+
 struct fs_info {
 	int is_remote;
 	char *typename;
 };
 
 /*
- * Get some basic filesystem informtion for the given path
+ * Get some basic filesystem information for the given path
  *
  * Returns -1 on error, zero otherwise.
  */
@@ -20,4 +28,30 @@ int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info);
  */
 int fsmonitor__is_fs_remote(const char *path);
 
+/*
+ * Get the alias in given path, if any.
+ *
+ * Sets alias to the first alias that matches any part of the path.
+ *
+ * If an alias is found, info.alias and info.points_to are set to the
+ * found mapping.
+ *
+ * Returns -1 on error, 0 otherwise.
+ *
+ * The caller owns the storage that is occupied by info.alias and
+ * info.points_to and is responsible for releasing it.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info);
+
+/*
+ * Resolve the path against the given alias.
+ *
+ * Returns the resolved path if there is one, NULL otherwise.
+ *
+ * The caller owns the storage that the returned string occupies and
+ * is responsible for releasing it.
+ */
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info);
+
 #endif
-- 
gitgitgadget

