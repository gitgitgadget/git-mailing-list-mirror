Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BD42013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdBOAf1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:27 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33658 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdBOAf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:26 -0500
Received: by mail-io0-f173.google.com with SMTP id g18so1951444ioe.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U/UPa20nKnWB/D9XEpdiEkpie7WNAEjetHKlXovaDK0=;
        b=pGwYEI8Zub/7gaZ4xjvr0PmNjsEAQTMKxBCkFxa/oaX7VNeySWHYGZNbn4p6xoe5U9
         H8FMFiHj4CU/69p3BI499wqZZNbceNSLF8mHeLGIJuZ/4v5w5xPLWA0O6pLg63GN/KPu
         jSxLymQ6T6A56fsvPsYg4lqU2dFdDxHWPcfoAfneE4OrqubBLZE89uls6OwuotcHIolv
         gXq8ZZzzUpEmuaQNZnBPJ6S8GGSU2VCkNdVYN7A7rrwLcLrt2CEy2K+6PWsTL9DX3pmQ
         jehUOtLRJilSB47+cXRBajDhIf0OBFrjbJ7oySfouXjohkG3r917sJjTYYmrFdMYKtKx
         AX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U/UPa20nKnWB/D9XEpdiEkpie7WNAEjetHKlXovaDK0=;
        b=oW3RwjGh+c00lor3pCAvVBYHUH7Ks/bs1iVfo4MnLciCgsliUb1I553tjohpEJlFMT
         by6395eimIWpd9Q02kzc0im99fxjHtw6NjBk3Bs28KGHt1fzQ9T/l8j4i4uzz+/k3282
         g9nQ2sQeJm5ZAV50PSXFo7/qw2LHzIHoKeVJAuQ+ggOCyeqZ5B4phM8+Ha2kN3e2WiMx
         XcXMBUf50yhGoQswReTjpOrvgwvZDyTRGOHlE+Yj0ltWHMV08F0Gwqk3epGAzkIp5zYc
         7K+0beGd4xdTs+34a4bSJR4LOa+bfm/LeNxYWLtmrpdjBymB0sisvfC2gDnlHsVcx++W
         HV5A==
X-Gm-Message-State: AMke39lgycH3q2dfxKt8L0TrZ3RleFSLQPNFWuk69cS+r4DrxL4/iQpTccHGKKfOB/opQsoJ
X-Received: by 10.98.12.77 with SMTP id u74mr34531975pfi.116.1487118915103;
        Tue, 14 Feb 2017 16:35:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id b67sm3307279pfj.81.2017.02.14.16.35.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/14] update submodules: add submodule_go_from_to
Date:   Tue, 14 Feb 2017 16:34:18 -0800
Message-Id: <20170215003423.20245-10-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
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
 submodule.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |   5 ++
 2 files changed, 156 insertions(+)

diff --git a/submodule.c b/submodule.c
index d3fc6c2a75..194cba9535 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1252,6 +1252,157 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+static int submodule_has_dirty_index(const struct submodule *sub)
+{
+	ssize_t len;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-index", "--cached", "HEAD", NULL);
+	cp.no_stdin = 1;
+	cp.out = -1;
+	cp.dir = sub->path;
+	if (start_command(&cp))
+		die("could not recurse into submodule %s", sub->path);
+
+	len = strbuf_read(&buf, cp.out, 1024);
+	if (len > 2)
+		ret = 1;
+
+	close(cp.out);
+	if (finish_command(&cp))
+		die("could not recurse into submodule %s", sub->path);
+
+	strbuf_release(&buf);
+	return ret;
+}
+
+void submodule_clean_index(const char *path)
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
+		die("could not clean submodule index");
+}
+
+/**
+ * Moves a submodule at a given path from a given head to another new head.
+ * For edge cases (a submodule coming into existence or removing a submodule)
+ * pass NULL for old or new respectively.
+ *
+ * TODO: move dryrun and forced to flags.
+ */
+int submodule_go_from_to(const char *path,
+			 const char *old,
+			 const char *new,
+			 int dry_run,
+			 int force)
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
+	if (!dry_run) {
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
+			submodule_clean_index(path);
+		}
+	}
+
+	if (old && !force) {
+		/* Check if the submodule has a dirty index. */
+		if (submodule_has_dirty_index(sub)) {
+			/* print a thing here? */
+			return -1;
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
+	if (!dry_run)
+		argv_array_push(&cp.args, "-u");
+	else
+		argv_array_push(&cp.args, "-n");
+
+	if (force)
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
+	if (!dry_run) {
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
index 84b67a7c4a..570953a351 100644
--- a/submodule.h
+++ b/submodule.h
@@ -91,6 +91,11 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
 
+extern int submodule_go_from_to(const char *path,
+				const char *old,
+				const char *new,
+				int dry_run, int force);
+
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific envirionment variables, but
-- 
2.12.0.rc0.16.gd1691994b4.dirty

