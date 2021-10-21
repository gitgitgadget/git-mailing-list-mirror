Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB84C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BAF6120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJUO17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJUO1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6598C06122B
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so891223wmz.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b7cpQJtN1ExFiwysgLweLmA1ZMe7XzGXY14S4s0cGpE=;
        b=lSPi2vlbBXm/RCckuqguXjbzcBSfLE0dDcPz/IGxaz55n26XeH+PGwrbY5oOtrQBFi
         Gs0wWeKabESNw0oFS5qt2PVpLqqQjy3UsLWI0jCBSUv2IYot4hqz+9l3fZCZjv5mD0Lj
         jOFegg1qL4PoZ5eBPy9QIptF9/FEQk5E8URq7aDH/67s5PxKPHnc+GJsmjt8MXQz1jmN
         bhnSbcGWK3MQ8og+hM6vEVAxpBC1UTnQQf0GOt92lwNEU8pHGy0y/+6FmBrOFrXLUdPB
         3KR+JmeFyhSaEsq0Or1hA0RLhTkh3UQOk9355jsp6aXCvKbnkY/2NHHrg/OXCuVr2H63
         fs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b7cpQJtN1ExFiwysgLweLmA1ZMe7XzGXY14S4s0cGpE=;
        b=keFujNttWQ3rAuKVXGTEg8oXLzEeOsnuY3gs2a98dAQbFDahRFrnhXLMuWoD//6xAu
         SHP+ulx9jSc6NxEIKY76ZqFNea0FTDLNPKe2jkI/m5zV3pv2UN40tGp8O3RlauUNplAp
         8MEcps7xXJ5q3vt34KFwUA+D3GPSIsona7PicvOYEjMGfWfqlD3V+jg6I5WEIgbcmqb9
         +gaxxRLRvBcscPx/PcWHZ73mO3fFpYTClCsFfgrN3SHgabV6N1gjqMHnjB8zbUdOj1mO
         Qdn+vT8j4t1e4t3BZ2rGTgEPsdfhv1lZ5xwZPMV2e7AAFjrAi3mABGornGBO4mR7xhTu
         hs5w==
X-Gm-Message-State: AOAM532E58+0vHyirgZ3GQVTBtVxXZwSOJSPtjerM/E8G29id8chvTf7
        GtG6L7/DahdC9rFyXrqC55rCWd3I5gA=
X-Google-Smtp-Source: ABdhPJxqzuIaAI99taleoWQ5RLYtpGXzliWogsiShnWyXK0Ir7/TfQbaNMiXBYZkDlrUKMesVqDBBQ==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr21510504wmi.2.1634826318512;
        Thu, 21 Oct 2021 07:25:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y26sm4734477wma.15.2021.10.21.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:18 -0700 (PDT)
Message-Id: <6fa71fdc8255e6e58fe391671a980f1e75887b45.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:52 +0000
Subject: [PATCH v4 12/29] fsmonitor--daemon: add pathname classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to classify relative and absolute
pathnames and decide how they should be handled.  This will
be used by the platform-specific backend to respond to each
filesystem event.

When we register for filesystem notifications on a directory,
we get events for everything (recursively) in the directory.
We want to report to clients changes to tracked and untracked
paths within the working directory.  We do not want to report
changes within the .git directory, for example.

This classification will be used in a later commit by the
different backends to classify paths as events are received.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 81 +++++++++++++++++++++++++++++++++++++
 fsmonitor--daemon.h         | 61 ++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 8988440b7c1..1618f1aa27f 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -121,6 +121,87 @@ static int handle_client(void *data,
 	return result;
 }
 
+#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
+
+enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
+	const char *rel)
+{
+	if (fspathncmp(rel, ".git", 4))
+		return IS_WORKDIR_PATH;
+	rel += 4;
+
+	if (!*rel)
+		return IS_DOT_GIT;
+	if (*rel != '/')
+		return IS_WORKDIR_PATH; /* e.g. .gitignore */
+	rel++;
+
+	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
+			strlen(FSMONITOR_COOKIE_PREFIX)))
+		return IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX;
+
+	return IS_INSIDE_DOT_GIT;
+}
+
+enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
+	const char *rel)
+{
+	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
+			strlen(FSMONITOR_COOKIE_PREFIX)))
+		return IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX;
+
+	return IS_INSIDE_GITDIR;
+}
+
+static enum fsmonitor_path_type try_classify_workdir_abs_path(
+	struct fsmonitor_daemon_state *state,
+	const char *path)
+{
+	const char *rel;
+
+	if (fspathncmp(path, state->path_worktree_watch.buf,
+		       state->path_worktree_watch.len))
+		return IS_OUTSIDE_CONE;
+
+	rel = path + state->path_worktree_watch.len;
+
+	if (!*rel)
+		return IS_WORKDIR_PATH; /* it is the root dir exactly */
+	if (*rel != '/')
+		return IS_OUTSIDE_CONE;
+	rel++;
+
+	return fsmonitor_classify_path_workdir_relative(rel);
+}
+
+enum fsmonitor_path_type fsmonitor_classify_path_absolute(
+	struct fsmonitor_daemon_state *state,
+	const char *path)
+{
+	const char *rel;
+	enum fsmonitor_path_type t;
+
+	t = try_classify_workdir_abs_path(state, path);
+	if (state->nr_paths_watching == 1)
+		return t;
+	if (t != IS_OUTSIDE_CONE)
+		return t;
+
+	if (fspathncmp(path, state->path_gitdir_watch.buf,
+		       state->path_gitdir_watch.len))
+		return IS_OUTSIDE_CONE;
+
+	rel = path + state->path_gitdir_watch.len;
+
+	if (!*rel)
+		return IS_GITDIR; /* it is the <gitdir> exactly */
+	if (*rel != '/')
+		return IS_OUTSIDE_CONE;
+	rel++;
+
+	return fsmonitor_classify_path_gitdir_relative(rel);
+}
+
 static void *fsm_listen__thread_proc(void *_state)
 {
 	struct fsmonitor_daemon_state *state = _state;
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 3009c1a83de..7bbb3a27a1c 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -30,5 +30,66 @@ struct fsmonitor_daemon_state {
 	struct ipc_server_data *ipc_server_data;
 };
 
+/*
+ * Pathname classifications.
+ *
+ * The daemon classifies the pathnames that it receives from file
+ * system notification events into the following categories and uses
+ * that to decide whether clients are told about them.  (And to watch
+ * for file system synchronization events.)
+ *
+ * The client should only care about paths within the working
+ * directory proper (inside the working directory and not ".git" nor
+ * inside of ".git/").  That is, the client has read the index and is
+ * asking for a list of any paths in the working directory that have
+ * been modified since the last token.  The client does not care about
+ * file system changes within the .git directory (such as new loose
+ * objects or packfiles).  So the client will only receive paths that
+ * are classified as IS_WORKDIR_PATH.
+ *
+ * The daemon uses the IS_DOT_GIT and IS_GITDIR internally to mean the
+ * exact ".git" directory or GITDIR.  If the daemon receives a delete
+ * event for either of these directories, it will automatically
+ * shutdown, for example.
+ *
+ * Note that the daemon DOES NOT explicitly watch nor special case the
+ * ".git/index" file.  The daemon does not read the index and does not
+ * have any internal index-relative state.  The daemon only collects
+ * the set of modified paths within the working directory.
+ */
+enum fsmonitor_path_type {
+	IS_WORKDIR_PATH = 0,
+
+	IS_DOT_GIT,
+	IS_INSIDE_DOT_GIT,
+	IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX,
+
+	IS_GITDIR,
+	IS_INSIDE_GITDIR,
+	IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX,
+
+	IS_OUTSIDE_CONE,
+};
+
+/*
+ * Classify a pathname relative to the root of the working directory.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
+	const char *relative_path);
+
+/*
+ * Classify a pathname relative to a <gitdir> that is external to the
+ * worktree directory.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
+	const char *relative_path);
+
+/*
+ * Classify an absolute pathname received from a filesystem event.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_absolute(
+	struct fsmonitor_daemon_state *state,
+	const char *path);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */
-- 
gitgitgadget

