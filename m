Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3AAB1F454
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeKJPdN (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37436 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeKJPdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so3383179lja.4
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9avNCQWrFpCoWc/ot5Oz/z2FCmNhV/7UYA4gWwx4+aM=;
        b=P+vsnFj8smy+zhr9q5OwTRXLn/oqGt1sgebZTfZHKyHzPqGYbVOJ4Pm4ZhWhD3MXmh
         DDoHemW1bc0PzevARYdOgYdFlLaMshfaQovWhNAhvBkTN7Oanxfzr07baVz61gP/Ln0C
         76vYLSa8Y6a4LGbB19vzQXbDrGcfRxhcw5K6hT4Qtd0i86VLkM8UXOQzXooi4IDBV63N
         FkXMXcbUi1gMj/Jdd4b8xCPI06hkekZl4Mp5vyvSyjEfu81qRpEiQX5930qOxxlflo3T
         d6WKf2T3AIDCo9t97cTQquERGFU6rNr7fjYo9c3Svw3jbC7QW1vyKvbGLFE0wYh/BeEP
         KMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9avNCQWrFpCoWc/ot5Oz/z2FCmNhV/7UYA4gWwx4+aM=;
        b=Zw1os+K9ohKT4gDrWumYDHceBrQdSL3LD5f5yuhKkSEzqVjZHKHFGk9GFIPiGfVnDk
         vIY8Cj5gcf1cMc/p7CqdpycQ8EjEWVUWzQlvD18dMUEOh1WOhdtT6rPt7mTwpc77kwan
         XHw4Z+hCORk+dBGwGWoh69SJaPZb0L0AN0vKPnKKa4W2by92c/wSY/iEli5kCu8USq9R
         imAa3uABm8j2Q4fLP0lueaILEa8C+6naaOf0DBjiFHjxbKuEkndxe3jsPGvnIdBxTkF2
         IYqBaV5ixN7T6oGIWY25qCIaLq+EeXMintb46h3s9jC/Ozx8KjjM/uIG2xB4Rqrf5sEs
         q96w==
X-Gm-Message-State: AGRZ1gKOJnb/HQyftSOcqvg7eMJxOlW1AYq6QOV4fbfMY1otvWtknvXo
        59NM/f62HvahIGr8gsyLvDMRSF8B
X-Google-Smtp-Source: AJdET5dIXn/Sx74A+og0yF/XRbrQlUnijt2ANqGQmXF1lgzV8Os9KPm2ESyEv+HrnAPNrOAoT2ssoA==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr819241ljj.49.1541828964886;
        Fri, 09 Nov 2018 21:49:24 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:24 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/22] notes-merge.c: remove implicit dependency on the_index
Date:   Sat, 10 Nov 2018 06:48:53 +0100
Message-Id: <20181110054910.10568-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/notes.c |  2 +-
 notes-merge.c   | 12 +++++++-----
 notes-merge.h   |  5 ++++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index c05cd004ab..15a6c78855 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -808,7 +808,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_merge_usage, options);
 	}
 
-	init_notes_merge_options(&o);
+	init_notes_merge_options(the_repository, &o);
 	o.verbosity = verbosity + NOTES_MERGE_VERBOSITY_DEFAULT;
 
 	if (do_abort)
diff --git a/notes-merge.c b/notes-merge.c
index bd05d50b05..0c22f09b28 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -18,11 +18,13 @@ struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
 };
 
-void init_notes_merge_options(struct notes_merge_options *o)
+void init_notes_merge_options(struct repository *r,
+			      struct notes_merge_options *o)
 {
 	memset(o, 0, sizeof(struct notes_merge_options));
 	strbuf_init(&(o->commit_msg), 0);
 	o->verbosity = NOTES_MERGE_VERBOSITY_DEFAULT;
+	o->repo = r;
 }
 
 static int path_to_oid(const char *path, struct object_id *oid)
@@ -127,7 +129,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
 	       oid_to_hex(base), oid_to_hex(remote));
 
-	repo_diff_setup(the_repository, &opt);
+	repo_diff_setup(o->repo, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -190,7 +192,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
 	       len, oid_to_hex(base), oid_to_hex(local));
 
-	repo_diff_setup(the_repository, &opt);
+	repo_diff_setup(o->repo, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -350,7 +352,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 
 	status = ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
 			  &local, o->local_ref, &remote, o->remote_ref,
-			  &the_index, NULL);
+			  o->repo->index, NULL);
 
 	free(base.ptr);
 	free(local.ptr);
@@ -711,7 +713,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		/* write file as blob, and add to partial_tree */
 		if (stat(path.buf, &st))
 			die_errno("Failed to stat '%s'", path.buf);
-		if (index_path(&the_index, &blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
+		if (index_path(o->repo->index, &blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
 			die("Failed to write blob object from '%s'", path.buf);
 		if (add_note(partial_tree, &obj_oid, &blob_oid, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
diff --git a/notes-merge.h b/notes-merge.h
index 6c74e9385b..99f9c709c5 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -6,6 +6,7 @@
 
 struct commit;
 struct object_id;
+struct repository;
 
 #define NOTES_MERGE_WORKTREE "NOTES_MERGE_WORKTREE"
 
@@ -15,6 +16,7 @@ enum notes_merge_verbosity {
 };
 
 struct notes_merge_options {
+	struct repository *repo;
 	const char *local_ref;
 	const char *remote_ref;
 	struct strbuf commit_msg;
@@ -23,7 +25,8 @@ struct notes_merge_options {
 	unsigned has_worktree:1;
 };
 
-void init_notes_merge_options(struct notes_merge_options *o);
+void init_notes_merge_options(struct repository *r,
+			      struct notes_merge_options *o);
 
 /*
  * Merge notes from o->remote_ref into o->local_ref
-- 
2.19.1.1231.g84aef82467

