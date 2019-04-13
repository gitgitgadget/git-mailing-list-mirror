Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AAB520248
	for <e@80x24.org>; Sat, 13 Apr 2019 10:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfDMKQR (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 06:16:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35418 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfDMKQR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 06:16:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so6372790pgf.2
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IbrHRoZ6GiKWyKBohdQXCR7/SHdhzTAVrzgeb7Qp6+w=;
        b=Iv+i3MmvfU4yLCzG0uoEl13idmXaaAWxNgoGekq+9j6ml6fjE5ppqyAoLpjH4p9DoQ
         lHXTRVkkX/0AGZyVDF7MNWowcNhOJatercNWS1+kkpOz8JV9tIsGrFIvRc8Giw+tfEtn
         yDwCHkqMfL8lVn1fYGH/Wyelsox9Hbcdcj2v4KCkdaP7DcwJd2bCzFTdfKbJ74yY/vnT
         1Az9r2aWG6CX7L7tdCTkYwGEsQMw4pxgsOC4swpmKEmykzGvSh0bNsDasi0nq4C46nT2
         7ucBMTze6nRoIvAG+1u2xKk2cB0IAUhCLvJPs974hpgS0ASN4lzR6g3ZvKGX/QXUSuBT
         h/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbrHRoZ6GiKWyKBohdQXCR7/SHdhzTAVrzgeb7Qp6+w=;
        b=swcBcWL8KZQjSiJD9X+/jfJGi4AhlSxk27sDHGPOa7fgmfiEWK3xwu0Dbe+V4BmYWt
         uJwoUyF0inUwsgguMG4hwaOeSy8Tv44GUXt2yAczkmTayLr3w3z0dHWZ8VmfeK3yoG79
         r3+1gRQ3FnZXt12t94vHdySO+JuWzeGvc6pu7oAMVOXhm0+9bS0NKYV/iCgq72lE9Bru
         gkxL/iXbWjTeMjdw/UcLrTV2iFFRQryhY94V9WryKtnLOsc2+K0X8niUvpmsG4mUEYry
         b3UtUn4HXM3J3AvTGVWId3sUwCRAz4BRyKdDsL5xS1g+u4Cr/b8ekN2KmWxgCCKro527
         DD+Q==
X-Gm-Message-State: APjAAAXaP12hfPO4eQkX5qOAtKCp8b2PIOQhnqB+3PFAEar5HsZrHP+Z
        ae243VMDTu8kQRWP7yjs5W8=
X-Google-Smtp-Source: APXvYqwqcyVjsz9Zwo504N0EchzjuQottFqhKW7/ttckURe+11fto3uyeAZ3UFgCFYDkrnzGKQXToA==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr63291511pfh.187.1555150575807;
        Sat, 13 Apr 2019 03:16:15 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id h20sm65120144pfj.40.2019.04.13.03.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 03:16:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Apr 2019 17:16:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     dstolee@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        pclouds@gmail.com, stefanbeller@gmail.com, szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3* 11/33] commit.c: add repo_get_commit_tree()
Date:   Sat, 13 Apr 2019 17:16:00 +0700
Message-Id: <20190413101600.713-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <nycvar.QRO.7.76.6.1904121624160.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1904121624160.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the implicit dependency on the_repository in this function.
It will be used in sha1-name.c functions when they are updated to take
any 'struct repository'. get_commit_tree() remains as a compat wrapper,
to be slowly replaced later.

set_commit_tree() is added just to simplify the filtering in
commit.cocci.

Any access to "maybe_tree" field directly will result in _broken_ code
after running through commit.cocci because we can't know what is the
right repository to use.

the_repository would be correct most of the time. But we're relying less
and less on the_repository and that assumption may no longer be
true. The transformation now is more of a poor man replacement for a C++
compiler catching access to private fields.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 OK how about this? set_commit_tree() is added to keeps that long line
 in commit.cocci down. I also make commit.cocci generate invalid
 repo_get_commit_tree() code this time.

 commit-graph.c                  |  2 +-
 commit.c                        |  9 +++++----
 commit.h                        | 10 ++++++++--
 contrib/coccinelle/commit.cocci | 14 +++++---------
 merge-recursive.c               |  2 +-
 5 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 47e9be0a3a..dcab53cda5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -356,7 +356,7 @@ static int fill_commit_in_graph(struct repository *r,
 	item->object.parsed = 1;
 	item->graph_pos = pos;
 
-	item->maybe_tree = NULL;
+	set_commit_tree(item, NULL);
 
 	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low = get_be32(commit_data + g->hash_len + 12);
diff --git a/commit.c b/commit.c
index a5333c7ac6..d852bf60c1 100644
--- a/commit.c
+++ b/commit.c
@@ -340,7 +340,8 @@ void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 	}
 }
 
-struct tree *get_commit_tree(const struct commit *commit)
+struct tree *repo_get_commit_tree(struct repository *r,
+				  const struct commit *commit)
 {
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
@@ -348,7 +349,7 @@ struct tree *get_commit_tree(const struct commit *commit)
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("commit has NULL tree, but was not loaded from commit-graph");
 
-	return get_commit_tree_in_graph(the_repository, commit);
+	return get_commit_tree_in_graph(r, commit);
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
@@ -358,7 +359,7 @@ struct object_id *get_commit_tree_oid(const struct commit *commit)
 
 void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 {
-	c->maybe_tree = NULL;
+	set_commit_tree(c, NULL);
 	c->index = 0;
 	free_commit_buffer(pool, c);
 	free_commit_list(c->parents);
@@ -406,7 +407,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->maybe_tree = lookup_tree(r, &parent);
+	set_commit_tree(item, lookup_tree(r, &parent));
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
diff --git a/commit.h b/commit.h
index 42728c2906..7342727e46 100644
--- a/commit.h
+++ b/commit.h
@@ -32,7 +32,7 @@ struct commit {
 
 	/*
 	 * If the commit is loaded from the commit-graph file, then this
-	 * member may be NULL. Only access it through get_commit_tree()
+	 * member may be NULL. Only access it through repo_get_commit_tree()
 	 * or get_commit_tree_oid().
 	 */
 	struct tree *maybe_tree;
@@ -143,9 +143,15 @@ void repo_unuse_commit_buffer(struct repository *r,
  */
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
-struct tree *get_commit_tree(const struct commit *);
+struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
+#define get_commit_tree(c) repo_get_commit_tree(the_repository, c)
 struct object_id *get_commit_tree_oid(const struct commit *);
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
 /*
  * Release memory related to a commit, including the parent list and
  * any cached object buffer.
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index c49aa558f0..ee1dc29234 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -11,18 +11,14 @@ expression c;
 + get_commit_tree_oid(c)->hash
 
 // These excluded functions must access c->maybe_tree direcly.
+// Note that if c->maybe_tree is written somewhere outside of these
+// functions, then the recommended transformation will be bogus with
+// repo_get_commit_tree() on the LHS.
 @@
-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
+identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|set_commit_tree)$";
 expression c;
 @@
   f(...) {<...
 - c->maybe_tree
-+ get_commit_tree(c)
++ repo_get_commit_tree(specify_the_right_repo_here, c)
   ...>}
-
-@@
-expression c;
-expression s;
-@@
-- get_commit_tree(c) = s
-+ c->maybe_tree = s
diff --git a/merge-recursive.c b/merge-recursive.c
index 6c40c61c47..048fea71a0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -170,7 +170,7 @@ static struct commit *make_virtual_commit(struct repository *repo,
 	struct commit *commit = alloc_commit_node(repo);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
-	commit->maybe_tree = tree;
+	set_commit_tree(commit, tree);
 	commit->object.parsed = 1;
 	return commit;
 }
-- 
2.21.0.682.g30d2204636

