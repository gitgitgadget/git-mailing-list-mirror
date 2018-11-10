Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7201F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeKJPdh (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36479 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbeKJPdR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id h192so2845858lfg.3
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hymIUaV3G4BeliWLNm7bIQBei8Z3txsQS1KBgSC6EgE=;
        b=VumYiWSn+39GzIRAeeiIJAl1JCoY8pDMPD7WqvDov/Czk7jRU5wHeh9tykP8iFFIHI
         N4Vz53zZf4TuRpmM3bP4m9L1qRW28bTUAYy3XHJ4Xdho/ciB5R4PynRxauU7JHY5plvt
         qty8e5XaVXcJ5j0sSZ4LKCI1Rry3dWawMhb52Hgt/imrI1EYsCZXX1/LMZEM+GgwxgjE
         r0kQdI4YqvGgA/cGlQp3e1EffBd0YdQ1GlfA7Ifmo9uos4jifgTeLJNCPI/BN6hrgu/I
         aB93t05/r63Z/1vwY34lVypYCLLBboDOyaPfgrSMRk7OwM07AwpJ6ad15mDX4YpB6/S2
         b1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hymIUaV3G4BeliWLNm7bIQBei8Z3txsQS1KBgSC6EgE=;
        b=DtSsKrgdNz8pNsV9DWJryLfphFGjlUgkbLPYdkpxWvtYYp+qp2osecMKAwUk8LrH9+
         DL4IoP2+6pQdGZZ/POFvRRM/zBhZIsYoCDOVxx9YQ1tdJ8tFMwFZ3zsa2jlO5VTjw/ez
         SproBpUVeQ11qzJdvOyfTqUpmsdov0mGqNaRvAOps2iMfrCUhI7675Os5qRrasBmFOOA
         wh48Tg+yLos7bTLWT120w+xGbeNajJa226NsLqlX3s6sFyMbmPd4fK5LKcuiMT5Vxsej
         4SL0C3zRgMj6oJQx6KqGsI+wl/dV0h5QQGnMscchuHRaEIwZjqOKzbp9boWgznMgwa42
         6z5w==
X-Gm-Message-State: AGRZ1gLWy/r6DvYza4l6kK56d4anvINYrpQPXkMmZamnjT++YR/bBu+g
        mwFkyzaFx7P80ALZ+kv4nbp2Ke+M
X-Google-Smtp-Source: AJdET5f9eqKOgUJSGhragdHC74INHt5cTz0n3C/icbGrk735OjIR1+xmvaI7r4SpMZXEKkxFMLPclg==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr7197877lfb.72.1541828969971;
        Fri, 09 Nov 2018 21:49:29 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:29 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/22] blame.c: remove implicit dependency the_repository
Date:   Sat, 10 Nov 2018 06:48:58 +0100
Message-Id: <20181110054910.10568-11-pclouds@gmail.com>
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
 blame.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/blame.c b/blame.c
index d84c937780..43861437f7 100644
--- a/blame.c
+++ b/blame.c
@@ -116,35 +116,38 @@ static void verify_working_tree_path(struct repository *r,
 		die("no such path '%s' in HEAD", path);
 }
 
-static struct commit_list **append_parent(struct commit_list **tail, const struct object_id *oid)
+static struct commit_list **append_parent(struct repository *r,
+					  struct commit_list **tail,
+					  const struct object_id *oid)
 {
 	struct commit *parent;
 
-	parent = lookup_commit_reference(the_repository, oid);
+	parent = lookup_commit_reference(r, oid);
 	if (!parent)
 		die("no such commit %s", oid_to_hex(oid));
 	return &commit_list_insert(parent, tail)->next;
 }
 
-static void append_merge_parents(struct commit_list **tail)
+static void append_merge_parents(struct repository *r,
+				 struct commit_list **tail)
 {
 	int merge_head;
 	struct strbuf line = STRBUF_INIT;
 
-	merge_head = open(git_path_merge_head(the_repository), O_RDONLY);
+	merge_head = open(git_path_merge_head(r), O_RDONLY);
 	if (merge_head < 0) {
 		if (errno == ENOENT)
 			return;
 		die("cannot open '%s' for reading",
-		    git_path_merge_head(the_repository));
+		    git_path_merge_head(r));
 	}
 
 	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
 		struct object_id oid;
 		if (line.len < GIT_SHA1_HEXSZ || get_oid_hex(line.buf, &oid))
 			die("unknown line in '%s': %s",
-			    git_path_merge_head(the_repository), line.buf);
-		tail = append_parent(tail, &oid);
+			    git_path_merge_head(r), line.buf);
+		tail = append_parent(r, tail, &oid);
 	}
 	close(merge_head);
 	strbuf_release(&line);
@@ -155,11 +158,13 @@ static void append_merge_parents(struct commit_list **tail)
  * want to transfer ownership of the buffer to the commit (so we
  * must use detach).
  */
-static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
+static void set_commit_buffer_from_strbuf(struct repository *r,
+					  struct commit *c,
+					  struct strbuf *sb)
 {
 	size_t len;
 	void *buf = strbuf_detach(sb, &len);
-	set_commit_buffer(the_repository, c, buf, len);
+	set_commit_buffer(r, c, buf, len);
 }
 
 /*
@@ -185,7 +190,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 
 	read_index(r->index);
 	time(&now);
-	commit = alloc_commit_node(the_repository);
+	commit = alloc_commit_node(r);
 	commit->object.parsed = 1;
 	commit->date = now;
 	parent_tail = &commit->parents;
@@ -193,8 +198,8 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		die("no such ref: HEAD");
 
-	parent_tail = append_parent(parent_tail, &head_oid);
-	append_merge_parents(parent_tail);
+	parent_tail = append_parent(r, parent_tail, &head_oid);
+	append_merge_parents(r, parent_tail);
 	verify_working_tree_path(r, commit, path);
 
 	origin = make_origin(commit, path);
@@ -211,7 +216,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 		    ident, ident, path,
 		    (!contents_from ? path :
 		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
-	set_commit_buffer_from_strbuf(commit, &msg);
+	set_commit_buffer_from_strbuf(r, commit, &msg);
 
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
@@ -1678,7 +1683,7 @@ static struct commit *find_single_final(struct rev_info *revs,
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
-		obj = deref_tag(the_repository, obj, NULL, 0);
+		obj = deref_tag(revs->repo, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
@@ -1709,14 +1714,14 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 
 	/* Is that sole rev a committish? */
 	obj = revs->pending.objects[0].item;
-	obj = deref_tag(the_repository, obj, NULL, 0);
+	obj = deref_tag(revs->repo, obj, NULL, 0);
 	if (obj->type != OBJ_COMMIT)
 		return NULL;
 
 	/* Do we have HEAD? */
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return NULL;
-	head_commit = lookup_commit_reference_gently(the_repository,
+	head_commit = lookup_commit_reference_gently(revs->repo,
 						     &head_oid, 1);
 	if (!head_commit)
 		return NULL;
@@ -1745,7 +1750,7 @@ static struct commit *find_single_initial(struct rev_info *revs,
 		struct object *obj = revs->pending.objects[i].item;
 		if (!(obj->flags & UNINTERESTING))
 			continue;
-		obj = deref_tag(the_repository, obj, NULL, 0);
+		obj = deref_tag(revs->repo, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
-- 
2.19.1.1231.g84aef82467

