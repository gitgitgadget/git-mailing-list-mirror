Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15A21F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933744AbeFFRD4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:56 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37229 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933567AbeFFRC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:02:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so8237737lfb.4
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ab66qqfWdSHVCK4TYp/fcCwMW+2qbYOcQawq31V2Djw=;
        b=ElaIRAc9uTvP5DoXBxUM1qecVsOMAMwj9VQf2ClFdObQJOXUJvuQBYn565GXSQgVxP
         VOaSLQhSUa6vybIVq1JkMLAKp1GUdpIO06igos3vkIC68ka5644oN8eLL2DY5DkUGds6
         GiJiz8qkf1NWFyBN2DCZbVkeKf9LildcV68Rp5RX7HhJUYciUElnbtuoEYymIy4N6Sw7
         bwSwL7Wove0wSrORlizYEtPn7iPTPOcHz0lslVxs6BfDKDOKBHiCrl64Ypxue3apcmEE
         VEyklJ3ELC1MAzIlS8tbdnux5tSRBidIJDjhF9vGBPAb6L6o35zgFKjKH9j28k3fAHpF
         EfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ab66qqfWdSHVCK4TYp/fcCwMW+2qbYOcQawq31V2Djw=;
        b=SgToZo1ivLC9yMTQlGhQSzNbhBPiKPCuRtTiHniQu6imwYBWIP9jPqrV7PFYLLFc9Q
         +mkZpiltIvyROovGX++6jnsxtxqXf1yvq8oYR8NdApDjFmep1LCjtdCrY+4/ADbMPiLw
         UxSz7yK9kagTvyXdp2iROL7o7BtrlbVJIS5p8JtK0ri5DwUV2SeyrwYcQeJ56LIg7SWB
         +jdyHj+LRu/wzgeoYnSi22g7AHcE2h1oDwA6qke9/BYFiNqead+zOgsvnJ35VoJaZscR
         o4RE/cqSM+WxrdU8HAUUhjK668aAt84wGdES75wr9bVK1Uri3CXyc3xXCeyL/+AwZXw2
         qrgw==
X-Gm-Message-State: APt69E0S9AyaiuSnKeWk64lsEMi1IKxKX3OKklB+DfWyrZDE4skPoZxS
        iEzXHaWonrUZy6hbkA88+JKk2A==
X-Google-Smtp-Source: ADUXVKIM7aAKSvmN428ehQw/sJ5OKgO21p3wev/NwTWNIkGgBXrx/ND5dIKM8wBXnMQufr+TS8HMYg==
X-Received: by 2002:a19:d957:: with SMTP id q84-v6mr2360947lfg.79.1528304576525;
        Wed, 06 Jun 2018 10:02:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:02:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 07/23] attr: remove an implicit dependency on the_index
Date:   Wed,  6 Jun 2018 19:02:27 +0200
Message-Id: <20180606170243.4169-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the attr API take an index_state instead of assuming the_index in
attr code. All call sites are converted blindly to keep the patch
simple and retain current behavior. Individual call sites may receive
further updates to use the right index instead of the_index.

There is one ugly temporary workaround added in attr.c that needs some
more explanation.

Commit c24f3abace (apply: file commited with CRLF should roundtrip
diff and apply - 2017-08-19) forces one convert_to_git() call to NOT
read the index at all. But what do you know, we read it anyway by
falling back to the_index. When "istate" from convert_to_git is now
propagated down to read_attr_from_array() we will hit segfault
somewhere inside read_blob_data_from_index.

The right way of dealing with this is to kill "use_index" variable and
only follow "istate" but at this stage we are not ready for that:
while most git_attr_set_direction() calls just passes the_index to be
assigned to use_index, unpack-trees passes a different one which is
used by entry.c code, which has no way to know what index to use if we
delete use_index. So this has to be done later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c              |  2 +-
 attr.c                 | 57 ++++++++++++++++++++++++++++--------------
 attr.h                 | 10 +++++---
 builtin/check-attr.c   |  4 +--
 builtin/pack-objects.c |  2 +-
 convert.c              |  2 +-
 dir.c                  |  2 +-
 ll-merge.c             |  4 +--
 userdiff.c             |  2 +-
 ws.c                   |  2 +-
 10 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/archive.c b/archive.c
index 4fe7bec60c..3b4db8956a 100644
--- a/archive.c
+++ b/archive.c
@@ -108,7 +108,7 @@ static const struct attr_check *get_archive_attrs(const char *path)
 	static struct attr_check *check;
 	if (!check)
 		check = attr_check_initl("export-ignore", "export-subst", NULL);
-	return git_check_attr(path, check) ? NULL : check;
+	return git_check_attr(&the_index, path, check) ? NULL : check;
 }
 
 static int check_attr_export_ignore(const struct attr_check *check)
diff --git a/attr.c b/attr.c
index 067fb9e0c0..863fad3bd1 100644
--- a/attr.c
+++ b/attr.c
@@ -708,10 +708,10 @@ static struct attr_stack *read_attr_from_array(const char **list)
  * another thread could potentially be calling into the attribute system.
  */
 static enum git_attr_direction direction;
-static struct index_state *use_index;
+static const struct index_state *use_index;
 
 void git_attr_set_direction(enum git_attr_direction new_direction,
-			    struct index_state *istate)
+			    const struct index_state *istate)
 {
 	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
 		BUG("non-INDEX attr direction in a bare repo");
@@ -743,13 +743,24 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	return res;
 }
 
-static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
+static struct attr_stack *read_attr_from_index(const struct index_state *istate,
+					       const char *path,
+					       int macro_ok)
 {
 	struct attr_stack *res;
 	char *buf, *sp;
 	int lineno = 0;
+	const struct index_state *to_read_from;
 
-	buf = read_blob_data_from_index(use_index ? use_index : &the_index, path, NULL);
+	/*
+	 * Temporary workaround for c24f3abace (apply: file commited
+	 * with CRLF should roundtrip diff and apply - 2017-08-19)
+	 */
+	to_read_from = use_index ? use_index : istate;
+	if (!to_read_from)
+		return NULL;
+
+	buf = read_blob_data_from_index(to_read_from, path, NULL);
 	if (!buf)
 		return NULL;
 
@@ -768,15 +779,16 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	return res;
 }
 
-static struct attr_stack *read_attr(const char *path, int macro_ok)
+static struct attr_stack *read_attr(const struct index_state *istate,
+				    const char *path, int macro_ok)
 {
 	struct attr_stack *res = NULL;
 
 	if (direction == GIT_ATTR_INDEX) {
-		res = read_attr_from_index(path, macro_ok);
+		res = read_attr_from_index(istate, path, macro_ok);
 	} else if (!is_bare_repository()) {
 		if (direction == GIT_ATTR_CHECKOUT) {
-			res = read_attr_from_index(path, macro_ok);
+			res = read_attr_from_index(istate, path, macro_ok);
 			if (!res)
 				res = read_attr_from_file(path, macro_ok);
 		} else if (direction == GIT_ATTR_CHECKIN) {
@@ -788,7 +800,7 @@ static struct attr_stack *read_attr(const char *path, int macro_ok)
 				 * We allow operation in a sparsely checked out
 				 * work tree, so read from it.
 				 */
-				res = read_attr_from_index(path, macro_ok);
+				res = read_attr_from_index(istate, path, macro_ok);
 		}
 	}
 
@@ -859,7 +871,8 @@ static void push_stack(struct attr_stack **attr_stack_p,
 	}
 }
 
-static void bootstrap_attr_stack(struct attr_stack **stack)
+static void bootstrap_attr_stack(const struct index_state *istate,
+				 struct attr_stack **stack)
 {
 	struct attr_stack *e;
 
@@ -883,7 +896,7 @@ static void bootstrap_attr_stack(struct attr_stack **stack)
 	}
 
 	/* root directory */
-	e = read_attr(GITATTRIBUTES_FILE, 1);
+	e = read_attr(istate, GITATTRIBUTES_FILE, 1);
 	push_stack(stack, e, xstrdup(""), 0);
 
 	/* info frame */
@@ -896,7 +909,8 @@ static void bootstrap_attr_stack(struct attr_stack **stack)
 	push_stack(stack, e, NULL, 0);
 }
 
-static void prepare_attr_stack(const char *path, int dirlen,
+static void prepare_attr_stack(const struct index_state *istate,
+			       const char *path, int dirlen,
 			       struct attr_stack **stack)
 {
 	struct attr_stack *info;
@@ -917,7 +931,7 @@ static void prepare_attr_stack(const char *path, int dirlen,
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack(stack);
+	bootstrap_attr_stack(istate, stack);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
@@ -973,7 +987,7 @@ static void prepare_attr_stack(const char *path, int dirlen,
 		strbuf_add(&pathbuf, path + pathbuf.len, (len - pathbuf.len));
 		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
 
-		next = read_attr(pathbuf.buf, 0);
+		next = read_attr(istate, pathbuf.buf, 0);
 
 		/* reset the pathbuf to not include "/.gitattributes" */
 		strbuf_setlen(&pathbuf, len);
@@ -1095,7 +1109,9 @@ static void determine_macros(struct all_attrs_item *all_attrs,
  * If check->check_nr is non-zero, only attributes in check[] are collected.
  * Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, struct attr_check *check)
+static void collect_some_attrs(const struct index_state *istate,
+			       const char *path,
+			       struct attr_check *check)
 {
 	int i, pathlen, rem, dirlen;
 	const char *cp, *last_slash = NULL;
@@ -1114,7 +1130,7 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(path, dirlen, &check->stack);
+	prepare_attr_stack(istate, path, dirlen, &check->stack);
 	all_attrs_init(&g_attr_hashmap, check);
 	determine_macros(check->all_attrs, check->stack);
 
@@ -1136,11 +1152,13 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
-int git_check_attr(const char *path, struct attr_check *check)
+int git_check_attr(const struct index_state *istate,
+		   const char *path,
+		   struct attr_check *check)
 {
 	int i;
 
-	collect_some_attrs(path, check);
+	collect_some_attrs(istate, path, check);
 
 	for (i = 0; i < check->nr; i++) {
 		size_t n = check->items[i].attr->attr_nr;
@@ -1153,12 +1171,13 @@ int git_check_attr(const char *path, struct attr_check *check)
 	return 0;
 }
 
-void git_all_attrs(const char *path, struct attr_check *check)
+void git_all_attrs(const struct index_state *istate,
+		   const char *path, struct attr_check *check)
 {
 	int i;
 
 	attr_check_reset(check);
-	collect_some_attrs(path, check);
+	collect_some_attrs(istate, path, check);
 
 	for (i = 0; i < check->all_attrs_nr; i++) {
 		const char *name = check->all_attrs[i].attr->name;
diff --git a/attr.h b/attr.h
index 46340010bb..3daca3c0cb 100644
--- a/attr.h
+++ b/attr.h
@@ -1,6 +1,8 @@
 #ifndef ATTR_H
 #define ATTR_H
 
+struct index_state;
+
 /* An attribute is a pointer to this opaque structure */
 struct git_attr;
 
@@ -60,13 +62,15 @@ void attr_check_free(struct attr_check *check);
  */
 const char *git_attr_name(const struct git_attr *);
 
-int git_check_attr(const char *path, struct attr_check *check);
+int git_check_attr(const struct index_state *istate,
+		   const char *path, struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-void git_all_attrs(const char *path, struct attr_check *check);
+void git_all_attrs(const struct index_state *istate,
+		   const char *path, struct attr_check *check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
@@ -74,7 +78,7 @@ enum git_attr_direction {
 	GIT_ATTR_INDEX
 };
 void git_attr_set_direction(enum git_attr_direction new_direction,
-			    struct index_state *istate);
+			    const struct index_state *istate);
 
 void attr_start(void);
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 91444dc044..f7b59993d3 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -63,9 +63,9 @@ static void check_attr(const char *prefix,
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
-		git_all_attrs(full_path, check);
+		git_all_attrs(&the_index, full_path, check);
 	} else {
-		if (git_check_attr(full_path, check))
+		if (git_check_attr(&the_index, full_path, check))
 			die("git_check_attr died");
 	}
 	output_attr(check, file);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 71056d8294..0a2e801549 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -945,7 +945,7 @@ static int no_try_delta(const char *path)
 
 	if (!check)
 		check = attr_check_initl("delta", NULL);
-	if (git_check_attr(path, check))
+	if (git_check_attr(&the_index, path, check))
 		return 0;
 	if (ATTR_FALSE(check->items[0].value))
 		return 1;
diff --git a/convert.c b/convert.c
index 64d0d30e08..9d5dc32564 100644
--- a/convert.c
+++ b/convert.c
@@ -1302,7 +1302,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(path, check)) {
+	if (!git_check_attr(&the_index, path, check)) {
 		struct attr_check_item *ccheck = check->items;
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
diff --git a/dir.c b/dir.c
index ccf8b4975e..a541be3032 100644
--- a/dir.c
+++ b/dir.c
@@ -280,7 +280,7 @@ static int match_attrs(const char *name, int namelen,
 {
 	int i;
 
-	git_check_attr(name, item->attr_check);
+	git_check_attr(&the_index, name, item->attr_check);
 	for (i = 0; i < item->attr_match_nr; i++) {
 		const char *value;
 		int matched;
diff --git a/ll-merge.c b/ll-merge.c
index a6ad2ec12d..0e2800f7bb 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -371,7 +371,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	if (!check)
 		check = attr_check_initl("merge", "conflict-marker-size", NULL);
 
-	if (!git_check_attr(path, check)) {
+	if (!git_check_attr(&the_index, path, check)) {
 		ll_driver_name = check->items[0].value;
 		if (check->items[1].value) {
 			marker_size = atoi(check->items[1].value);
@@ -398,7 +398,7 @@ int ll_merge_marker_size(const char *path)
 
 	if (!check)
 		check = attr_check_initl("conflict-marker-size", NULL);
-	if (!git_check_attr(path, check) && check->items[0].value) {
+	if (!git_check_attr(&the_index, path, check) && check->items[0].value) {
 		marker_size = atoi(check->items[0].value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/userdiff.c b/userdiff.c
index a69241b25d..e835e78dd5 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -278,7 +278,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	if (git_check_attr(path, check))
+	if (git_check_attr(&the_index, path, check))
 		return NULL;
 
 	if (ATTR_TRUE(check->items[0].value))
diff --git a/ws.c b/ws.c
index a07caedd5a..5b67b426e7 100644
--- a/ws.c
+++ b/ws.c
@@ -78,7 +78,7 @@ unsigned whitespace_rule(const char *pathname)
 	if (!attr_whitespace_rule)
 		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
 
-	if (!git_check_attr(pathname, attr_whitespace_rule)) {
+	if (!git_check_attr(&the_index, pathname, attr_whitespace_rule)) {
 		const char *value;
 
 		value = attr_whitespace_rule->items[0].value;
-- 
2.18.0.rc0.333.g22e6ee6cdf

