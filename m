Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEB5211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 02:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfALCOz (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:14:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40848 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALCOz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:14:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so7563557plq.7
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tVC6VAnV2qMWdNylKhgFxBWK3x4De3lUfLZd9cOdObg=;
        b=L9rar38DWePANK+pwqqLcsKQ+cFnzRVJxEMAwv35L5+fB07SEFFCfli/lim4WbtVzB
         FtT8X2QCiXstodCEncAC2zjEU6kgip5pwDr/wc4oOzMTzUFrhp2TBegkeeeIQM/xL30w
         ZkKMp/tQVkig0bR45y1XyZaLKhjzG8mvy2MYOEfIanjucmXN4IaTrlDqs60GrScKKyFv
         pimEM6r/LAZpqCPr5EnehewgkRAUCz1PI02fM/k4aJmwCY/i3sXI+RANnS5gYWpjUVIG
         O+uK3Z0xU1if8I6teXXHEbdCVfrtPxNubHXburxoAc6fQCG1supgU5r6oJDgZ7k8nu2X
         dHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tVC6VAnV2qMWdNylKhgFxBWK3x4De3lUfLZd9cOdObg=;
        b=IvVCxge6XhhnHMaDEKIkD++WfOXURh4FrkR4sN9FJklCOltNThzIqPG83Ur8E9RmrX
         Ip79IWDFzN3d5sw6JOhywrs+A5Ih2C87JvuJwuRRhdaFpTcc6pjWJ3SIDocGtow1jTwN
         qceTXwRVnxyp+cNxGkrSPXZQA4ydXt3GKFmtyHUdSpCYmbGeIO2dlfzukZUyNgAk5kY2
         5CaaPCSFOgl/75/MkVObixWbVbkmChcRz7obeAsvU36VgP8oKq05ANRZDcsrAoZZTVv4
         Q0znommJsY+NjMByWv8sMwBDSnHXJ6ziX2IAma6tTtzwl9NJWkVZDLjj30siM/nPkhCy
         tSCA==
X-Gm-Message-State: AJcUukc6Icb5CnANmD7iRzA5l6yoTY4SGUQjAHPvU09THMCTM4qew8iA
        YIL9FwL00v9BpiYIKAuAcyrQDfI/
X-Google-Smtp-Source: ALg8bN6MFe7L9e2klpmthlNejaP0U8RwvlQLyB2rwi9Cka1Auht54SzMKeSzAwALLb8VMX2/uoBdyQ==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr16994829plo.316.1547259294539;
        Fri, 11 Jan 2019 18:14:54 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id o66sm153118631pgo.75.2019.01.11.18.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 18:14:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Jan 2019 09:14:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/11] read-cache.c: remove the_* from index_has_changes()
Date:   Sat, 12 Jan 2019 09:13:31 +0700
Message-Id: <20190112021332.11066-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190112021332.11066-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
 <20190112021332.11066-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c      |  6 +++---
 cache.h           |  6 +++---
 merge-recursive.c |  2 +-
 read-cache.c      | 12 +++++-------
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 611712dc95..a9ffc92eaa 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1719,7 +1719,7 @@ static void am_run(struct am_state *state, int resume)
 
 	refresh_and_write_cache();
 
-	if (index_has_changes(&the_index, NULL, &sb)) {
+	if (repo_index_has_changes(the_repository, NULL, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
 	}
@@ -1777,7 +1777,7 @@ static void am_run(struct am_state *state, int resume)
 			 * the result may have produced the same tree as ours.
 			 */
 			if (!apply_status &&
-			    !index_has_changes(&the_index, NULL, NULL)) {
+			    !repo_index_has_changes(the_repository, NULL, NULL)) {
 				say(state, stdout, _("No changes -- Patch already applied."));
 				goto next;
 			}
@@ -1831,7 +1831,7 @@ static void am_resolve(struct am_state *state)
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
-	if (!index_has_changes(&the_index, NULL, NULL)) {
+	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
 			"If there is nothing left to stage, chances are that something else\n"
 			"already introduced the same changes; you might want to skip this patch."));
diff --git a/cache.h b/cache.h
index fdcd69bfb0..326e73f391 100644
--- a/cache.h
+++ b/cache.h
@@ -706,9 +706,9 @@ extern int unmerged_index(const struct index_state *);
  * provided, the space-separated list of files that differ will be appended
  * to it.
  */
-extern int index_has_changes(struct index_state *istate,
-			     struct tree *tree,
-			     struct strbuf *sb);
+extern int repo_index_has_changes(struct repository *repo,
+				  struct tree *tree,
+				  struct strbuf *sb);
 
 extern int verify_path(const char *path, unsigned mode);
 extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
diff --git a/merge-recursive.c b/merge-recursive.c
index a596d95739..df00896b25 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3412,7 +3412,7 @@ int merge_trees(struct merge_options *o,
 	int code, clean;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!o->call_depth && index_has_changes(istate, head, &sb)) {
+	if (!o->call_depth && repo_index_has_changes(o->repo, head, &sb)) {
 		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
 		return -1;
diff --git a/read-cache.c b/read-cache.c
index 61cc0571da..2549477ed2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2365,22 +2365,20 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-int index_has_changes(struct index_state *istate,
-		      struct tree *tree,
-		      struct strbuf *sb)
+int repo_index_has_changes(struct repository *repo,
+			   struct tree *tree,
+			   struct strbuf *sb)
 {
+	struct index_state *istate = repo->index;
 	struct object_id cmp;
 	int i;
 
-	if (istate != &the_index) {
-		BUG("index_has_changes cannot yet accept istate != &the_index; do_diff_cache needs updating first.");
-	}
 	if (tree)
 		cmp = tree->object.oid;
 	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
-		repo_diff_setup(the_repository, &opt);
+		repo_diff_setup(repo, &opt);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
-- 
2.20.0.482.g66447595a7

