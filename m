Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBA5ECAAD3
	for <git@archiver.kernel.org>; Sat, 10 Sep 2022 20:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiIJUCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Sep 2022 16:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIJUCR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2022 16:02:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408AC4CA37
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 13:00:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b5so8796157wrr.5
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=2xTdcA64T5fsLpr6jfslMo1bzEjJhpSDuoIBKlYqSKA=;
        b=dETlUOjxq2J0VrnJaTmWj7Ohu0ahRzQ2xXgjXt8HtIhi+62mqpju+HJ6f5XCcERBu8
         GKFuFfoIlIX/X05Z6irpOUIVwp+1cUzyR1MRYXjp6rvbiRPKgIgl1n+gQk/9uJmpcF3I
         GooZ3pBx2/oGhuZ1Vd6MhypN1mLsoD6lhQbAAFjqBJhKnIRpHM7oelAo/7eSX1/95oOk
         D5MDYlCjnSIXpnuC1e1pPeY+YchOLwu0Jh64AbVDmeyW+MNMhZJ2hMWWV5M9L5PALqrZ
         7PcKqghQEOaEX4bMoTCWj86xLa4oIM5D8W3KJ0V+b6idKPV/jJgowVwaZW2r6t3+wyxn
         gPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2xTdcA64T5fsLpr6jfslMo1bzEjJhpSDuoIBKlYqSKA=;
        b=In4Exybajw5hPmrcA0KPYtziqXYI7SGV7YmdzL7ItL0hKEJv0R9Yfqr7+A7leQZfjS
         d52gg4I07FCqMTa8m5dBVNziz9QJSAPAs0LyaCSeobEU+axrDmx3sFiJCR1OM6Rp1vkt
         34QiQ1J9nEjwLEWsFu7iSjw9ZpJPWHalhOVCxYXgqcfguOdpKyvLa8AcTq+kHGw57qaL
         AMqHZepCDXQTnOFWV7ARwNY7bnY02NO0vUwubq34HWwlHnRRm5mQMeMEw258dIUbk04v
         4Ae5lHhvCncB7HnDJT9e3c7V+w0L8kBcP7u39TpHt4lb5GBxaeKTq/Xfb6gv4rKBRf08
         dW+g==
X-Gm-Message-State: ACgBeo0lMjVhDeiDBpTcKLzZF7Ge65FIU0+KSilznlE5hIWYqJFzDujz
        sTcHimRoQi23RD1pLL+RVjTyCaKq2r4=
X-Google-Smtp-Source: AA6agR5Gp/ixTM7Xgau5uJ6ItaJeLAbrdiyT08715ijYCGvXqmaMbSiovYtOHo2kKqOYgoIi6kGvFQ==
X-Received: by 2002:a05:6000:80a:b0:229:4632:d1d1 with SMTP id bt10-20020a056000080a00b002294632d1d1mr11029584wrb.73.1662840038181;
        Sat, 10 Sep 2022 13:00:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003a63a3b55c3sm4536803wmc.14.2022.09.10.13.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 13:00:37 -0700 (PDT)
Message-Id: <b7d6cf44695c7b6285573f454ebfd3866fe49f38.1662840031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Sep 2022 20:00:31 +0000
Subject: [PATCH v5 4/4] fsmonitor: deal with synthetic firmlinks on macOS
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

When FSEevents reports the path of changed files, if the path invloves
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
 builtin/fsmonitor--daemon.c              |  8 +++
 compat/fsmonitor/fsm-listen-darwin.c     |  6 +-
 compat/fsmonitor/fsm-path-utils-darwin.c | 91 ++++++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 17 +++++
 fsmonitor--daemon.h                      |  6 ++
 fsmonitor-path-utils.h                   | 26 +++++++
 6 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 2c109cf8b37..2559150d9e7 100644
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
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 8e208e8289e..179886bc15b 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -26,6 +26,7 @@
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "fsmonitor-path-utils.h"
 
 struct fsm_listen_data
 {
@@ -209,7 +210,9 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 		/*
 		 * On Mac, we receive an array of absolute paths.
 		 */
-		path_k = paths[k];
+		path_k = fsmonitor__resolve_alias(paths[k], &state->alias);
+		if (!path_k)
+			path_k = paths[k];
 
 		/*
 		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
@@ -238,6 +241,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			fsmonitor_force_resync(state);
 			fsmonitor_batch__free_list(batch);
 			string_list_clear(&cookie_list, 0);
+			batch = NULL;
 
 			/*
 			 * We assume that any events that we received
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
index 067cbe6990a..1f1550c485a 100644
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
 
@@ -38,3 +41,91 @@ int fsmonitor__is_fs_remote(const char *path)
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
+ * matter altogteher.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info)
+{
+	DIR * dir;
+	int read;
+	int retval;
+	struct dirent *de;
+	struct strbuf alias;
+	struct strbuf points_to;
+
+	retval = 0;
+	dir = opendir("/");
+	if (!dir)
+		return -1;
+
+	strbuf_init(&alias, 256);
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
+			if ((strncmp(points_to.buf, path, points_to.len) == 0)
+				&& path[points_to.len] == '/') {
+				strbuf_addbuf(&info->alias, &alias);
+				strbuf_addbuf(&info->points_to, &points_to);
+				trace_printf_key(&trace_fsmonitor,
+					"Found alias for '%s' : '%s' -> '%s'",
+					path, info->alias.buf, info->points_to.buf);
+				retval = 0;
+				goto done;
+			}
+		} else if (errno != EINVAL) { /* Something other than not a link */
+			trace_printf_key(&trace_fsmonitor, "Error %s", strerror(errno));
+			retval = -1;
+			goto done;
+		}
+	}
+
+	done:
+	closedir(dir);
+	strbuf_release(&alias);
+	strbuf_release(&points_to);
+	return retval;
+}
+
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info)
+{
+	int len = info->alias.len;
+
+	if (!len)
+		return NULL;
+
+	if ((strncmp(info->alias.buf, path, len) == 0)
+		&& path[len] == '/') {
+		struct strbuf tmp;
+		const char *remainder = path + len;
+		int rem_len = strlen(remainder);
+
+		strbuf_init(&tmp, info->points_to.len + rem_len);
+		strbuf_addbuf(&tmp, &info->points_to);
+		strbuf_add(&tmp, remainder, rem_len);
+		return strbuf_detach(&tmp, NULL);
+	}
+
+	return NULL;
+}
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
index dc211de514f..0ca366bfe08 100644
--- a/compat/fsmonitor/fsm-path-utils-win32.c
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -87,3 +87,20 @@ int fsmonitor__is_fs_remote(const char *path)
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
index 2102a5c9ff5..98cbb430083 100644
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
@@ -167,5 +170,8 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
  */
 void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
 
+char *fsmonitor_resolve_alias(const char *path,
+	struct alias_info *alias);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */
diff --git a/fsmonitor-path-utils.h b/fsmonitor-path-utils.h
index e48592887e7..7d9d71cb043 100644
--- a/fsmonitor-path-utils.h
+++ b/fsmonitor-path-utils.h
@@ -1,6 +1,14 @@
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
@@ -20,4 +28,22 @@ int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info);
  */
 int fsmonitor__is_fs_remote(const char *path);
 
+/*
+ * Get the alias in given path, if any.
+ *
+ * Sets alias to the first alias that matches any part of the path.
+ *
+ * Returns -1 on error, 0 otherwise.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info);
+
+/*
+ * Resolve the path against the given alias.
+ *
+ * Returns the resolved path if there is one, NULL otherwise.
+ */
+char *fsmonitor__resolve_alias(const char *path,
+	const struct alias_info *info);
+
+
 #endif
-- 
gitgitgadget
