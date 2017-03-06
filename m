Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B8120133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbdCFVIU (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:08:20 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32777 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754655AbdCFVII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:08:08 -0500
Received: by mail-pf0-f174.google.com with SMTP id w189so65075105pfb.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FtDn0V7Sfsv5oCR0qQZPCiqF41A3KnWc9E8IwKGlx9Q=;
        b=s7imJGMbRRya3AjadMqX7LxzcZhHXb8uZwnW6QmThITYJulkC63q6o6TlnlWm+GTHm
         RZLsIl6D7o7DGh2ynAnF8nLPVB8a46qTRppQw/Flbh+X/JU3ns838EMCrlmVYTI0Aq84
         yco+oYdpO4rURVvBGOhrFoiZAS+3baSu7NUO/gYlqDDlfh0BVsbeBLw6RnC/V1ATksb9
         /t2DamH7xLrYc8qtZ78HbCHZd+ySz7CPUDjaYaG3gUaSy9Q0UbAuBTpzHU7ZSRwqfAfC
         oKPu7iws5KmO+JMMpu5BoR0M/VCaUKrLPKR+LUMrU+lunzUQMepuU5tN/2Xgg11a14BK
         fH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FtDn0V7Sfsv5oCR0qQZPCiqF41A3KnWc9E8IwKGlx9Q=;
        b=Y0bm7YCHFfbuGr9RyaSrzejcRUzCBKL3S3vPQRPhmR70u7wAnsTXmdHDCDjqYCiCHd
         731wWG/BHjAPmr+LsRGDv1+xSFN4SJdMZlUkWeDtcw2WEdz/nVNMbh1VRjGt28mExnCp
         upa/boIXUqXrpb0wARVSMeKbqLUqJu5CKpuKToB7jmeEjLp4MQc92uZFdvYUCAX1rZuB
         tXR4vrGkECVIU2JA6fucgFL7u9U4WApbU8mXbCSLViAuUnBwtipdg5E91xHvaQ40szvz
         7yY7rYb1iMGr3orImtTBhPfHoRB7o/fnvsMrVXnMH23bS09tLFRMe1OW8whDvpmcI08z
         SAfA==
X-Gm-Message-State: AMke39mEZMyLKTK7Csx5tvVEqNu2HjMqkIWx8fL+nFoNZuiIXx8Zsizic6GQdIjUc6Pslywy
X-Received: by 10.99.102.135 with SMTP id a129mr23172609pgc.220.1488833978665;
        Mon, 06 Mar 2017 12:59:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id 185sm41322469pfg.13.2017.03.06.12.59.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:37 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 12/18] update submodules: add submodule_move_head
Date:   Mon,  6 Mar 2017 12:59:13 -0800
Message-Id: <20170306205919.9713-13-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we introduce the options and flag for commands
that modify the working directory, e.g. git-checkout.

This piece of code will be used universally for
all these working tree modifications as it
* supports dry run to answer the question:
  "Is it safe to change the submodule to this new state?"
  e.g. is it overwriting untracked files or are there local
  changes that would be overwritten?
* supports a force flag that can be used for resetting
  the tree.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |   7 ++++
 2 files changed, 142 insertions(+)

diff --git a/submodule.c b/submodule.c
index 0b2596e88a..bc5fecf8c5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1239,6 +1239,141 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+static int submodule_has_dirty_index(const struct submodule *sub)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-index", "--quiet", \
+					"--cached", "HEAD", NULL);
+	cp.no_stdin = 1;
+	cp.no_stdout = 1;
+	cp.dir = sub->path;
+	if (start_command(&cp))
+		die("could not recurse into submodule '%s'", sub->path);
+
+	return finish_command(&cp);
+}
+
+static void submodule_reset_index(const char *path)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+
+	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
+	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
+
+	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
+
+	if (run_command(&cp))
+		die("could not reset submodule index");
+}
+
+/**
+ * Moves a submodule at a given path from a given head to another new head.
+ * For edge cases (a submodule coming into existence or removing a submodule)
+ * pass NULL for old or new respectively.
+ */
+int submodule_move_head(const char *path,
+			 const char *old,
+			 const char *new,
+			 unsigned flags)
+{
+	int ret = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const struct submodule *sub;
+
+	sub = submodule_from_path(null_sha1, path);
+
+	if (!sub)
+		die("BUG: could not get submodule information for '%s'", path);
+
+	if (old && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+		/* Check if the submodule has a dirty index. */
+		if (submodule_has_dirty_index(sub))
+			return error(_("submodule '%s' has dirty index"), path);
+	}
+
+	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
+		if (old) {
+			if (!submodule_uses_gitfile(path))
+				absorb_git_dir_into_superproject("", path,
+					ABSORB_GITDIR_RECURSE_SUBMODULES);
+		} else {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "%s/modules/%s",
+				    get_git_common_dir(), sub->name);
+			connect_work_tree_and_git_dir(path, sb.buf);
+			strbuf_release(&sb);
+
+			/* make sure the index is clean as well */
+			submodule_reset_index(path);
+		}
+	}
+
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+
+	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
+	argv_array_pushl(&cp.args, "read-tree", NULL);
+
+	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
+		argv_array_push(&cp.args, "-n");
+	else
+		argv_array_push(&cp.args, "-u");
+
+	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
+		argv_array_push(&cp.args, "--reset");
+	else
+		argv_array_push(&cp.args, "-m");
+
+	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
+
+	if (run_command(&cp)) {
+		ret = -1;
+		goto out;
+	}
+
+	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
+		if (new) {
+			struct child_process cp1 = CHILD_PROCESS_INIT;
+			/* also set the HEAD accordingly */
+			cp1.git_cmd = 1;
+			cp1.no_stdin = 1;
+			cp1.dir = path;
+
+			argv_array_pushl(&cp1.args, "update-ref", "HEAD",
+					 new ? new : EMPTY_TREE_SHA1_HEX, NULL);
+
+			if (run_command(&cp1)) {
+				ret = -1;
+				goto out;
+			}
+		} else {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_addf(&sb, "%s/.git", path);
+			unlink_or_warn(sb.buf);
+			strbuf_release(&sb);
+
+			if (is_empty_dir(path))
+				rmdir_or_warn(path);
+		}
+	}
+out:
+	return ret;
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
diff --git a/submodule.h b/submodule.h
index 6f3fe85c7c..4cdf6445f7 100644
--- a/submodule.h
+++ b/submodule.h
@@ -96,6 +96,13 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
 
+#define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
+#define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
+extern int submodule_move_head(const char *path,
+			       const char *old,
+			       const char *new,
+			       unsigned flags);
+
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific envirionment variables, but
-- 
2.12.0.rc1.52.ge239d7e709.dirty

