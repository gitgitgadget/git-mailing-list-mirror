Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216D7C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 10:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiLFKiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLFKiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 05:38:02 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4AEDF5A
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 02:37:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e13so19621782edj.7
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 02:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONHgyRwuZ8GvH+r/0A1VeNZM0kdYc54D32pf3xGf4aM=;
        b=UggGk1HEu0qfl6p/q+lJSGd36AAImWW4W4zLG11LJouG0BnymW825ta2PeVXK96R7N
         zM921rQncgfeXd/Id4l1OK+EEmPijwJ6Bx2jAcEN/0wtjp1TvrrtKuWyqyUNlH3HZ5Hx
         G59XietAlF2NS5ZLyBo2f1BelDc3l3gsqHC6SV7pduubwEa1fnB9bgGnhbmMUyLtaBHI
         raZLsn8NxariEGv8/zNu7HDMJZYgTvLU1Flq0uQqa4TNNn+L1eD0lvArS7UQxMvQNaWa
         x7gCMkuYUJQioOPqmjMwie8FmFZOAJhEydXQFxVnL8W37YFk7P2n1nG2C7IaThXvR7aM
         iG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONHgyRwuZ8GvH+r/0A1VeNZM0kdYc54D32pf3xGf4aM=;
        b=CzTduh03i5Qxvfvsx/5b4pvSfGnXWvv9n2xaUyOquGhHNTf6XNJuhW5MsvXsxCKk/6
         Wzzz+mjwr5a4LVrzemorGeyiOH/sMI4H0LpIrs8lw9LeBT76Ocz8vR6saNpNE9Vrqyea
         VijuygnG/NSCo9Lnm+/XHIAgam7kU10ko/JpmXZJrmyuc735FgNJZBSus1pVZ9wx6+D6
         j6q/xqJgmcr/1E0IWz9N1NCYJG0EnXJQuvrhY3gnMYddF4DZ55LBO9BT94JTUHA+UhKY
         0ROrZefv5XPM9uzF6r/Ev2dxEVb+wnBv0u66oGFV41L629IhzsgMfyicvlhS8dT+qjUg
         UjiQ==
X-Gm-Message-State: ANoB5pmgSSuTHvWYRMa6Ar1VXIYQ7CRe5SO0j4iZwQ74VnoiK0v2k05d
        4uDwoBdx0oxL1YYhtiIweH1eHc0ljuh7DQ==
X-Google-Smtp-Source: AA0mqf7X+IEwd6JNCtktrjdhI9IEXghL3DCbza7/UD1BAwKn8DrwHI9RbNLgCGE2otCn4+uqoSllqg==
X-Received: by 2002:aa7:db9a:0:b0:46b:ada3:4ee with SMTP id u26-20020aa7db9a000000b0046bada304eemr2305555edt.64.1670323077135;
        Tue, 06 Dec 2022 02:37:57 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906698900b007bff9fb211fsm7221035ejr.57.2022.12.06.02.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:37:56 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
Date:   Tue,  6 Dec 2022 11:37:36 +0100
Message-Id: <20221206103736.53909-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206103736.53909-1-karthik.188@gmail.com>
References: <20221206103736.53909-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git check-attr currently doesn't check the git worktree, it either
checks the index or the files directly. This means we cannot check the
attributes for a file against a certain revision.

Add a new flag `--revision`/`-r` which will allow it work with
revisions. This command will now, instead of checking the files/index,
try and receive the blob for the given attribute file against the
provided revision. The flag overrides checking against the index and
filesystem and also works with bare repositories.

We cannot use the `<rev>:<path>` syntax like the one used in `git show`
because any non-flag parameter before `--` is treated as an attribute
and any parameter after `--` is treated as a pathname.

This involves creating a new function `read_attr_from_blob`, which given
the path reads the blob for the path against the provided revision and
parses the attributes line by line. This function is plugged into
`read_attr()` function wherein we go through the different attributes.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Co-authored-by: toon@iotcl.com
---
 archive.c              |   2 +-
 attr.c                 | 120 ++++++++++++++++++++++++++++-------------
 attr.h                 |   7 ++-
 builtin/check-attr.c   |  25 ++++-----
 builtin/pack-objects.c |   2 +-
 convert.c              |   2 +-
 ll-merge.c             |   4 +-
 pathspec.c             |   2 +-
 t/t0003-attributes.sh  |  56 ++++++++++++++++++-
 userdiff.c             |   2 +-
 ws.c                   |   2 +-
 11 files changed, 165 insertions(+), 59 deletions(-)

diff --git a/archive.c b/archive.c
index 941495f5d7..bf64dbdce1 100644
--- a/archive.c
+++ b/archive.c
@@ -120,7 +120,7 @@ static const struct attr_check *get_archive_attrs(struct index_state *istate,
 	static struct attr_check *check;
 	if (!check)
 		check = attr_check_initl("export-ignore", "export-subst", NULL);
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, path, check, NULL);
 	return check;
 }
 
diff --git a/attr.c b/attr.c
index 42ad6de8c7..42b67a401f 100644
--- a/attr.c
+++ b/attr.c
@@ -11,8 +11,12 @@
 #include "exec-cmd.h"
 #include "attr.h"
 #include "dir.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
 #include "utf8.h"
 #include "quote.h"
+#include "revision.h"
+#include "object-store.h"
 #include "thread-utils.h"
 
 const char git_attr__true[] = "(builtin)true";
@@ -729,14 +733,67 @@ static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
 	return res;
 }
 
-static struct attr_stack *read_attr_from_index(struct index_state *istate,
-					       const char *path,
-					       unsigned flags)
+static struct attr_stack *read_attr_from_buf(char *buf, const char *path,
+					     unsigned flags)
 {
 	struct attr_stack *res;
-	char *buf, *sp;
+	char *sp;
 	int lineno = 0;
 
+	if (buf == NULL)
+		return NULL;
+
+	CALLOC_ARRAY(res, 1);
+	for (sp = buf; *sp;) {
+		char *ep;
+		int more;
+
+		ep = strchrnul(sp, '\n');
+		more = (*ep == '\n');
+		*ep = '\0';
+		handle_attr_line(res, sp, path, ++lineno, flags);
+		sp = ep + more;
+	}
+	free(buf);
+
+	return res;
+}
+
+static struct attr_stack *read_attr_from_blob(const char *path,
+					      const char *object_name,
+					      unsigned flags)
+{
+	struct object_id oid;
+	unsigned long sz;
+	enum object_type type;
+	void *buf;
+	struct strbuf sb;
+
+	if (object_name == NULL)
+		return NULL;
+
+	strbuf_init(&sb, strlen(path) + 1 + strlen(object_name));
+	strbuf_addstr(&sb, object_name);
+	strbuf_addstr(&sb, ":");
+	strbuf_addstr(&sb, path);
+
+	if (get_oid(sb.buf, &oid))
+		return NULL;
+
+	buf = read_object_file(&oid, &type, &sz);
+	if (!buf || type != OBJ_BLOB) {
+		free(buf);
+		return NULL;
+	}
+
+	return read_attr_from_buf(buf, path, flags);
+}
+
+static struct attr_stack *read_attr_from_index(struct index_state *istate,
+					       const char *path, unsigned flags)
+{
+	char *buf;
+
 	if (!istate)
 		return NULL;
 
@@ -758,28 +815,19 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 	if (!buf)
 		return NULL;
 
-	CALLOC_ARRAY(res, 1);
-	for (sp = buf; *sp; ) {
-		char *ep;
-		int more;
-
-		ep = strchrnul(sp, '\n');
-		more = (*ep == '\n');
-		*ep = '\0';
-		handle_attr_line(res, sp, path, ++lineno, flags);
-		sp = ep + more;
-	}
-	free(buf);
-	return res;
+	return read_attr_from_buf(buf, path, flags);
 }
 
 static struct attr_stack *read_attr(struct index_state *istate,
-				    const char *path, unsigned flags)
+				    const char *path, const char *object_name,
+				    unsigned flags)
 {
 	struct attr_stack *res = NULL;
 
 	if (direction == GIT_ATTR_INDEX) {
 		res = read_attr_from_index(istate, path, flags);
+	} else if (object_name != NULL) {
+		res = read_attr_from_blob(path, object_name, flags);
 	} else if (!is_bare_repository()) {
 		if (direction == GIT_ATTR_CHECKOUT) {
 			res = read_attr_from_index(istate, path, flags);
@@ -839,7 +887,8 @@ static void push_stack(struct attr_stack **attr_stack_p,
 }
 
 static void bootstrap_attr_stack(struct index_state *istate,
-				 struct attr_stack **stack)
+				 struct attr_stack **stack,
+				 const char *object_name)
 {
 	struct attr_stack *e;
 	unsigned flags = READ_ATTR_MACRO_OK;
@@ -864,7 +913,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	}
 
 	/* root directory */
-	e = read_attr(istate, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
+	e = read_attr(istate, GITATTRIBUTES_FILE, object_name, flags | READ_ATTR_NOFOLLOW);
 	push_stack(stack, e, xstrdup(""), 0);
 
 	/* info frame */
@@ -877,9 +926,9 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	push_stack(stack, e, NULL, 0);
 }
 
-static void prepare_attr_stack(struct index_state *istate,
-			       const char *path, int dirlen,
-			       struct attr_stack **stack)
+static void prepare_attr_stack(struct index_state *istate, const char *path,
+			       int dirlen, struct attr_stack **stack,
+			       const char *object_name)
 {
 	struct attr_stack *info;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -899,7 +948,7 @@ static void prepare_attr_stack(struct index_state *istate,
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack(istate, stack);
+	bootstrap_attr_stack(istate, stack, object_name);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
@@ -954,7 +1003,7 @@ static void prepare_attr_stack(struct index_state *istate,
 		strbuf_add(&pathbuf, path + pathbuf.len, (len - pathbuf.len));
 		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
 
-		next = read_attr(istate, pathbuf.buf, READ_ATTR_NOFOLLOW);
+		next = read_attr(istate, pathbuf.buf, object_name, READ_ATTR_NOFOLLOW);
 
 		/* reset the pathbuf to not include "/.gitattributes" */
 		strbuf_setlen(&pathbuf, len);
@@ -1073,9 +1122,9 @@ static void determine_macros(struct all_attrs_item *all_attrs,
  * If check->check_nr is non-zero, only attributes in check[] are collected.
  * Otherwise all attributes are collected.
  */
-static void collect_some_attrs(struct index_state *istate,
-			       const char *path,
-			       struct attr_check *check)
+static void collect_some_attrs(struct index_state *istate, const char *path,
+			       struct attr_check *check,
+			       const char *object_name)
 {
 	int pathlen, rem, dirlen;
 	const char *cp, *last_slash = NULL;
@@ -1094,7 +1143,7 @@ static void collect_some_attrs(struct index_state *istate,
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(istate, path, dirlen, &check->stack);
+	prepare_attr_stack(istate, path, dirlen, &check->stack, object_name);
 	all_attrs_init(&g_attr_hashmap, check);
 	determine_macros(check->all_attrs, check->stack);
 
@@ -1102,13 +1151,12 @@ static void collect_some_attrs(struct index_state *istate,
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
-void git_check_attr(struct index_state *istate,
-		    const char *path,
-		    struct attr_check *check)
+void git_check_attr(struct index_state *istate, const char *path,
+		    struct attr_check *check, const char *object_name)
 {
 	int i;
 
-	collect_some_attrs(istate, path, check);
+	collect_some_attrs(istate, path, check, object_name);
 
 	for (i = 0; i < check->nr; i++) {
 		size_t n = check->items[i].attr->attr_nr;
@@ -1119,13 +1167,13 @@ void git_check_attr(struct index_state *istate,
 	}
 }
 
-void git_all_attrs(struct index_state *istate,
-		   const char *path, struct attr_check *check)
+void git_all_attrs(struct index_state *istate, const char *path,
+		   struct attr_check *check, const char *object_name)
 {
 	int i;
 
 	attr_check_reset(check);
-	collect_some_attrs(istate, path, check);
+	collect_some_attrs(istate, path, check, object_name);
 
 	for (i = 0; i < check->all_attrs_nr; i++) {
 		const char *name = check->all_attrs[i].attr->name;
diff --git a/attr.h b/attr.h
index 3fb40cced0..0708d6e046 100644
--- a/attr.h
+++ b/attr.h
@@ -169,6 +169,7 @@ struct attr_check {
 	int all_attrs_nr;
 	struct all_attrs_item *all_attrs;
 	struct attr_stack *stack;
+	char *object_id;
 };
 
 struct attr_check *attr_check_alloc(void);
@@ -190,14 +191,16 @@ void attr_check_free(struct attr_check *check);
 const char *git_attr_name(const struct git_attr *);
 
 void git_check_attr(struct index_state *istate,
-		    const char *path, struct attr_check *check);
+					const char *path, struct attr_check *check,
+					const char *object_name);
 
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
 void git_all_attrs(struct index_state *istate,
-		   const char *path, struct attr_check *check);
+				   const char *path, struct attr_check *check,
+				   const char *object_name);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 0fef10eb6b..3e032420ed 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -9,6 +9,7 @@
 static int all_attrs;
 static int cached_attrs;
 static int stdin_paths;
+static char *object_name;
 static const char * const check_attr_usage[] = {
 N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
 N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
@@ -23,6 +24,7 @@ static const struct option check_attr_options[] = {
 	OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
 	OPT_BOOL('z', NULL, &nul_term_line,
 		 N_("terminate input and output records by a NUL character")),
+	OPT_STRING('r', "revision", &object_name, N_("revision"), N_("check attributes at this revision")),
 	OPT_END()
 };
 
@@ -55,27 +57,26 @@ static void output_attr(struct attr_check *check, const char *file)
 	}
 }
 
-static void check_attr(const char *prefix,
-		       struct attr_check *check,
-		       int collect_all,
-		       const char *file)
+static void check_attr(const char *prefix, struct attr_check *check,
+		       int collect_all, const char *file,
+		       const char *object_name
+)
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
-		git_all_attrs(&the_index, full_path, check);
+		git_all_attrs(&the_index, full_path, check, object_name);
 	} else {
-		git_check_attr(&the_index, full_path, check);
+		git_check_attr(&the_index, full_path, check, object_name);
 	}
 	output_attr(check, file);
 
 	free(full_path);
 }
 
-static void check_attr_stdin_paths(const char *prefix,
-				   struct attr_check *check,
-				   int collect_all)
+static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
+				   int collect_all, const char *object_name)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -89,7 +90,7 @@ static void check_attr_stdin_paths(const char *prefix,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		check_attr(prefix, check, collect_all, buf.buf);
+		check_attr(prefix, check, collect_all, buf.buf, object_name);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -177,10 +178,10 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, check, all_attrs);
+		check_attr_stdin_paths(prefix, check, all_attrs, object_name);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, check, all_attrs, argv[i]);
+			check_attr(prefix, check, all_attrs, argv[i], object_name);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 573d0b20b7..f57a0188e6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1318,7 +1318,7 @@ static int no_try_delta(const char *path)
 
 	if (!check)
 		check = attr_check_initl("delta", NULL);
-	git_check_attr(the_repository->index, path, check);
+	git_check_attr(the_repository->index, path, check, NULL);
 	if (ATTR_FALSE(check->items[0].value))
 		return 1;
 	return 0;
diff --git a/convert.c b/convert.c
index 9b67649032..095729004f 100644
--- a/convert.c
+++ b/convert.c
@@ -1308,7 +1308,7 @@ void convert_attrs(struct index_state *istate,
 		git_config(read_convert_config, NULL);
 	}
 
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, path, check, NULL);
 	ccheck = check->items;
 	ca->crlf_action = git_path_check_crlf(ccheck + 4);
 	if (ca->crlf_action == CRLF_UNDEFINED)
diff --git a/ll-merge.c b/ll-merge.c
index 22a603e8af..45a534badf 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -391,7 +391,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 		normalize_file(theirs, path, istate);
 	}
 
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, path, check, NULL);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
 		marker_size = atoi(check->items[1].value);
@@ -419,7 +419,7 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 
 	if (!check)
 		check = attr_check_initl("conflict-marker-size", NULL);
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, path, check, NULL);
 	if (check->items[0].value) {
 		marker_size = atoi(check->items[0].value);
 		if (marker_size <= 0)
diff --git a/pathspec.c b/pathspec.c
index 46e77a85fe..b5217e4c36 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -732,7 +732,7 @@ int match_pathspec_attrs(struct index_state *istate,
 	if (name[namelen])
 		name = to_free = xmemdupz(name, namelen);
 
-	git_check_attr(istate, name, item->attr_check);
+	git_check_attr(istate, name, item->attr_check, NULL);
 
 	free(to_free);
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index b3aabb8aa3..90a3680a31 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -25,7 +25,14 @@ attr_check_quote () {
 	git check-attr test -- "$path" >actual &&
 	echo "\"$quoted_path\": test: $expect" >expect &&
 	test_cmp expect actual
+}
+
+attr_check_revision () {
+	path="$1" expect="$2" revision="$3" git_opts="$4" &&
 
+	git $git_opts check-attr -r $revision test -- "$path" >actual 2>err &&
+	echo "$path: test: $expect" >expect &&
+	test_cmp expect actual
 }
 
 test_expect_success 'open-quoted pathname' '
@@ -33,7 +40,6 @@ test_expect_success 'open-quoted pathname' '
 	attr_check a unspecified
 '
 
-
 test_expect_success 'setup' '
 	mkdir -p a/b/d a/c b &&
 	(
@@ -80,6 +86,26 @@ test_expect_success 'setup' '
 	EOF
 '
 
+test_expect_success 'setup branches' '
+	(
+		echo "f	test=f" &&
+		echo "a/i test=n"
+	) | git hash-object -w --stdin > id &&
+	git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
+	git write-tree > id &&
+	git commit-tree $(cat id) -m "random commit message" > id &&
+	git update-ref refs/heads/branch1 $(cat id) &&
+
+	(
+		echo "g test=g" &&
+		echo "a/i test=m"
+	) | git hash-object -w --stdin > id &&
+	git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
+	git write-tree > id &&
+	git commit-tree $(cat id) -m "random commit message" > id &&
+	git update-ref refs/heads/branch2 $(cat id)
+'
+
 test_expect_success 'command line checks' '
 	test_must_fail git check-attr &&
 	test_must_fail git check-attr -- &&
@@ -287,6 +313,15 @@ test_expect_success 'using --git-dir and --work-tree' '
 	)
 '
 
+test_expect_success 'using --revision' '
+	attr_check_revision foo/bar/f f branch1 &&
+	attr_check_revision foo/bar/a/i n branch1 &&
+	attr_check_revision foo/bar/f unspecified branch2 &&
+	attr_check_revision foo/bar/a/i m branch2 &&
+	attr_check_revision foo/bar/g g branch2 &&
+	attr_check_revision foo/bar/g unspecified branch1
+'
+
 test_expect_success 'setup bare' '
 	git clone --template= --bare . bare.git
 '
@@ -306,6 +341,25 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+test_expect_success 'bare repository: with --revision' '
+	(
+		cd bare.git &&
+		(
+			echo "f	test=f" &&
+			echo "a/i test=a/i"
+		) | git hash-object -w --stdin > id &&
+		git update-index --add --cacheinfo 100644 $(cat id) .gitattributes &&
+		git write-tree > id &&
+		git commit-tree $(cat id) -m "random commit message" > id &&
+		git update-ref refs/heads/master $(cat id) &&
+		attr_check_revision f f HEAD &&
+		attr_check_revision a/f f HEAD &&
+		attr_check_revision a/c/f f HEAD &&
+		attr_check_revision a/i a/i HEAD &&
+		attr_check_revision subdir/a/i unspecified HEAD
+	)
+'
+
 test_expect_success 'bare repository: check that --cached honors index' '
 	(
 		cd bare.git &&
diff --git a/userdiff.c b/userdiff.c
index 151d9a5278..364f5a5ea2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -412,7 +412,7 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, path, check, NULL);
 
 	if (ATTR_TRUE(check->items[0].value))
 		return &driver_true;
diff --git a/ws.c b/ws.c
index 6e69877f25..8cc3e429c1 100644
--- a/ws.c
+++ b/ws.c
@@ -78,7 +78,7 @@ unsigned whitespace_rule(struct index_state *istate, const char *pathname)
 	if (!attr_whitespace_rule)
 		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
 
-	git_check_attr(istate, pathname, attr_whitespace_rule);
+	git_check_attr(istate, pathname, attr_whitespace_rule, NULL);
 	value = attr_whitespace_rule->items[0].value;
 	if (ATTR_TRUE(value)) {
 		/* true (whitespace) */
-- 
2.38.1

