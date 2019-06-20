Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60861F462
	for <e@80x24.org>; Thu, 20 Jun 2019 09:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfFTJzs (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 05:55:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39297 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFTJzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 05:55:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so1310433pgc.6
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vu3zC9pM2UbeuPAtGA6ONAVY/TNyoLTb1Mat++/dTkU=;
        b=EELIP1NOzbs65QtjS2YBXCQUN2fehMoohbfEpmd7WW62WfOVnSfBTlrM5ZgVRe0xFu
         OSRNweNgtHSiFkkSl6Zh7TNXeHkAUw2PtUfP+Dwm+eY7nddP/s8XwUT7OQAVyqoPY+rG
         Nkkv3C/lE7n0/U3fMj6Nk4mW04vqtEp7aIlD7Nlh30EECZfTTjRMWyXxEJIyyVahIPxk
         MDyd8p9zJ4uthR6EmH6VN9ts1BlPOQSLRBOMybL0QVz/GFTtVRzLf0NF5ajNpC98jN9D
         H86gGiECvmwxARIcfqoeTTpAAnTJPySlpyrUbdgbAmbQcZf7TPbV4GKcRXsecLVEQWlx
         vFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vu3zC9pM2UbeuPAtGA6ONAVY/TNyoLTb1Mat++/dTkU=;
        b=Nlet+gXpHFdvmK+/5DldTbvzzmzkcDXxp+/9OMbxxAFsK7MpIg9gL6KS2pnXYxgab6
         Y55Ni6gK9qgjOzfyflUdi5CV60aJdgfOEskebKL1CD1BHhqhKVn0ZZB45W3pakGx0uTH
         a8jtY8nYZ8tbJ0sOzUqEodWwa7f1mYLlLhl3D+nKB94jbDNOdi8ioavS2xggZYwngtw6
         8fh/qWBUgQyvrYgLs6u3n0dyOmd53x/u+NK5krJ/yqMVfGEyV9EpoOfZfjLsO3J9+79S
         vfQy4VLrTYBBbGrmH76ra/siJ21sIVndAwPVtRZPkDqt0gpAItHit6sq7l6ptPlol1K+
         xwmA==
X-Gm-Message-State: APjAAAUW+XxLW+o50DFBmZi1zrONFXjNmVoqabApGHQb+I1+SACRO2bp
        QufULdRjpX3RX4njTAYgR+N9F551
X-Google-Smtp-Source: APXvYqzrv3wTNuwu5ZCtwqCLEqL/u6eKkVUryzpUMKWTBvREf+YR5jSomC+j/ZelfvyHO6RPpw31rg==
X-Received: by 2002:aa7:8e50:: with SMTP id d16mr121827030pfr.65.1561024546763;
        Thu, 20 Jun 2019 02:55:46 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id k4sm12097503pfk.42.2019.06.20.02.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:55:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Jun 2019 16:55:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/4] restore: add --intent-to-add (restoring worktree only)
Date:   Thu, 20 Jun 2019 16:55:23 +0700
Message-Id: <20190620095523.10003-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190620095523.10003-1-pclouds@gmail.com>
References: <20190620095523.10003-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git restore --source" (without --staged) could create new files
(i.e. not present in index) on worktree to match the given source. But
the new files are not tracked, so both "git diff" and "git diff
<source>" ignore new files. "git commit -a" will not recreate a commit
exactly as the given source either.

Add --intent-to-add to help track new files in this case, which is the
default on the least surprise principle.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-restore.txt |  7 ++++
 builtin/checkout.c            | 78 +++++++++++++++++++++++++++++++++++
 t/t2070-restore.sh            | 17 ++++++++
 3 files changed, 102 insertions(+)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index d90093f195..43a7f43b2b 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -93,6 +93,13 @@ in linkgit:git-checkout[1] for details.
 	are "merge" (default) and "diff3" (in addition to what is
 	shown by "merge" style, shows the original contents).
 
+--intent-to-add::
+--no-intent-to-add::
+	When restoring files only on working tree with `--source`,
+	new files are marked as "intent to add" (see
+	linkgit:git-add[1]). This is the default behavior. Use
+	`--no-intent-to-add` to disable it.
+
 --ignore-unmerged::
 	When restoring files on the working tree from the index, do
 	not abort the operation if there are unmerged entries and
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f884d27f1f..c519067d3d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -70,6 +70,7 @@ struct checkout_opts {
 	int checkout_worktree;
 	const char *ignore_unmerged_opt;
 	int ignore_unmerged;
+	int intent_to_add;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -392,6 +393,69 @@ static int checkout_worktree(const struct checkout_opts *opts)
 	return errs;
 }
 
+/*
+ * Input condition: r->index contains the file list matching worktree.
+ *
+ * r->index is reloaded with $GIT_DIR/index. Files that exist in the
+ * current worktree but not in $GIT_DIR/index are added back as
+ * intent-to-add.
+ */
+static int add_intent_to_add_files(struct repository *r)
+{
+	char **file_list;
+	int pos, worktree_nr, ita_nr = 0;
+	int ret = 0;
+
+	worktree_nr = r->index->cache_nr;
+	ALLOC_ARRAY(file_list, worktree_nr);
+	for (pos = 0; pos < worktree_nr; pos++)
+		file_list[pos] = xstrdup(r->index->cache[pos]->name);
+
+	discard_index(r->index);
+	if (repo_read_index(r) < 0) {
+		ret = error(_("index file corrupt"));
+		goto done;
+	}
+
+	for (pos = 0; pos < worktree_nr; ) {
+		const char *worktree = file_list[pos];
+		int index_pos = index_name_pos(r->index, worktree, strlen(worktree));
+
+		if (index_pos < 0) {
+			if (add_file_to_index(r->index, worktree, ADD_CACHE_INTENT))
+				ret = error(_("failed to add %s"), worktree);
+			else
+				ita_nr++;
+			pos++;
+			continue;
+		}
+
+		/*
+		 * Try to speed up the scanning process a bit.
+		 *
+		 * The assumption here is file_list[] and r->index->cache[]
+		 * are 90% the same. We can just skip a big chunk of the same
+		 * entries and reduce the number of binary lookups.
+		 */
+		pos++;
+		index_pos++;
+		while (pos < worktree_nr && index_pos < r->index->cache_nr &&
+		       !fspathcmp(file_list[pos], r->index->cache[index_pos]->name)) {
+			pos++;
+			index_pos++;
+		}
+	}
+
+	if (!ret)
+		ret = ita_nr;
+
+done:
+	for (pos = 0; pos < worktree_nr; pos++)
+		free(file_list[pos]);
+	free(file_list);
+	return ret;
+}
+
 static int checkout_paths(const struct checkout_opts *opts,
 			  const char *revision)
 {
@@ -531,6 +595,16 @@ static int checkout_paths(const struct checkout_opts *opts,
 	else
 		checkout_index = opts->checkout_index;
 
+	if (opts->intent_to_add && opts->from_treeish &&
+	    !opts->checkout_index && opts->checkout_worktree) {
+		int ita_nr = add_intent_to_add_files(the_repository);
+
+		if (ita_nr > 0)
+			checkout_index = 1;
+		if (ita_nr < 0)
+			errs = -1;
+	}
+
 	if (checkout_index) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("unable to write new index file"));
@@ -1697,6 +1771,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.overlay_mode = -1;
 	opts.checkout_index = -2;    /* default on */
 	opts.checkout_worktree = -2; /* default on */
+	opts.intent_to_add = 0;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1758,6 +1833,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 			   N_("restore the index")),
 		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
 			   N_("restore the working tree (default)")),
+		OPT_BOOL(0, "intent-to-add", &opts.intent_to_add,
+			 N_("mark new files on working tree as intent-to-add (default)")),
 		OPT_BOOL(0, "ignore-unmerged", &opts.ignore_unmerged,
 			 N_("ignore unmerged entries")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
@@ -1773,6 +1850,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.checkout_index = -1;    /* default off */
 	opts.checkout_worktree = -2; /* default on */
 	opts.ignore_unmerged_opt = "--ignore-unmerged";
+	opts.intent_to_add = 1;
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 2650df1966..acbd80c1cd 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -95,4 +95,21 @@ test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
 	)
 '
 
+test_expect_success 'restore worktree only adds new files back as intent-to-add' '
+	git init ita &&
+	(
+		cd ita &&
+		test_commit one &&
+		test_commit two &&
+		git rm one.t &&
+		git commit -m one-is-gone &&
+		git restore --source one one.t &&
+		git diff --summary >actual &&
+		echo " create mode 100644 one.t" >expected &&
+		test_cmp expected actual &&
+		git diff --cached >empty &&
+		test_must_be_empty empty
+	)
+'
+
 test_done
-- 
2.22.0.rc0.322.g2b0371e29a

