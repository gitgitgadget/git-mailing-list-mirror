Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AAE1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbeGZNaY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 09:30:24 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36947 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729894AbeGZNaY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 09:30:24 -0400
Received: by mail-yb0-f194.google.com with SMTP id r3-v6so534073ybo.4
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xl4a35BOhviTrjQ3B63T/e0stPIhJrIJUiRjq+bwGmE=;
        b=Otuupi5pQUG7eAN2wspLD+XzqC7si090OLihYemHCPy7cktDwcbqUOAN2FdtuwBwvN
         +siGWHJdF6g8xu0A8xU2M2nQOUreUU1jtwaP8bTat35LYWKntjt9XjvFTbNOd7cwpFCp
         loPRud28peIxNKGY+DL886AnAiV64HTAc//qM/81sipjYOjjyJZkZeIA22YHc1W9uZOi
         yVx6Z759r3IQjwB+15OFR6bC0CwUXMdLLUVnoy1jvb04PCSiPAOW9f962n6EqIbKk4iw
         JyRBgHfvPXGa/Nm1h9ccDBaII1aIw8akRQOPz7bgVxrUNyX+bAQ150QGGoMwTbS5AAr/
         AZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xl4a35BOhviTrjQ3B63T/e0stPIhJrIJUiRjq+bwGmE=;
        b=SoeYPkhrxLxn9xM413m1mmkZc0hrnSadqiRuaiVQndvgt29YBoL9CxObyGhgL0y3MI
         QreDiiBnVTq9jxcLPMCN8Npb/1Vz/20LCLHAxsQbgdcD96CMDcPfOxyNuDMT8lAk2GMZ
         V9B8LIOy/Eo940bghkNfPZHmZytWyr+WgRg8q7Tx1m16t8mB1Bj3R1zRw+i6UqMdbyqC
         B+gNSL6mp2h7Y2K93VsLFbm60VK4oNZA3YIupLvTXYNQg1ETYzxnbA0yLEqMyrklTuio
         jWr/jQNJyzE3qepjCvTWfhjTPwGesCw6I9EcBYRGBkES7LLlevbaQdEgabXgl8ehdPHo
         pD8Q==
X-Gm-Message-State: AOUpUlHm/IFcQ+mfzhv+muoXdptu9sC9daLPZtUxDZyBywn0yP5u1Fsa
        NYlTqXYyGpw5oLkzasMsD6PfugBV
X-Google-Smtp-Source: AAOMgpchConaBaA/30cYwI2iR+GQrL3XRUKodd5s52Vbuntc6TjV+HaV8qb/CZnOTnuwPGo2R8hxOg==
X-Received: by 2002:a25:67d6:: with SMTP id b205-v6mr858458ybc.243.1532607229667;
        Thu, 26 Jul 2018 05:13:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:fb45])
        by smtp.gmail.com with ESMTPSA id w6-v6sm463374ywg.23.2018.07.26.05.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 05:13:48 -0700 (PDT)
Date:   Thu, 26 Jul 2018 05:13:46 -0700
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH] name_rev: add support for --cherry-picks
Message-ID: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From aefa07bc66bb4a116eb84eb46d7f070f9632c990 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 26 Jul 2018 04:14:52 -0700

It's often useful to track cherry-picks of a given commit.  Add
--cherry-picks support to git-name-rev.  When specified, name_rev also
shows the commits cherry-picked from the listed target commits with
indentations.

  $ git name-rev --cherry-picks 10f7ce0a0e524279f022
  10f7ce0a0e524279f022 master~1
    d433e3b4d5a19b3d29e2c8349fe88ceade5f6190 branch1
      82cddd79f962de0bb1e7cdd95d48b48633335816 branch2
    58a8d36b2532feb0a14b4fc2a50d587e64f38324 branch3
    fa8b79edc5dfff21753c2ccfc1a1828336c4c070 branch4~1

Note that branch2 is further indented because it's a nested cherry
pick from d433e3b4d5a1.

"git-describe --contains" is a wrapper around git-name-rev.  Also add
--cherry-picks support to git-describe.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/git-describe.txt   |   5 ++
 Documentation/git-name-rev.txt   |   4 ++
 builtin/describe.c               |   7 +-
 builtin/name-rev.c               | 117 +++++++++++++++++++++++++++++--
 t/t6121-describe-cherry-picks.sh |  63 +++++++++++++++++
 5 files changed, 190 insertions(+), 6 deletions(-)
 create mode 100755 t/t6121-describe-cherry-picks.sh

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index e027fb8c4..13a229bd7 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -60,6 +60,11 @@ OPTIONS
 	the tag that comes after the commit, and thus contains it.
 	Automatically implies --tags.
 
+--cherry-picks::
+	Also show the commits cherry-picked from the target commits.
+	Cherry-picks are shown indented below their from-commmits.
+	Can only be used with --contains.
+
 --abbrev=<n>::
 	Instead of using the default 7 hexadecimal digits as the
 	abbreviated object name, use <n> digits, or as many digits
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 5cb0eb085..df16c4a89 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -61,6 +61,10 @@ OPTIONS
 --always::
 	Show uniquely abbreviated commit object as fallback.
 
+--cherry-picks::
+	Also show the commits cherry-picked from the target commits.
+	Cherry-picks are shown indented below their from-commmits.
+
 EXAMPLES
 --------
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 1e87f68d5..94c84004d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -528,9 +528,10 @@ static void describe(const char *arg, int last_one)
 
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
-	int contains = 0;
+	int contains = 0, cherry_picks = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "contains",   &contains, N_("find the tag that comes after the commit")),
+		OPT_BOOL(0, "cherry-picks", &cherry_picks, N_("also include cherry-picks with --contains")),
 		OPT_BOOL(0, "debug",      &debug, N_("debug search strategy on stderr")),
 		OPT_BOOL(0, "all",        &all, N_("use any ref")),
 		OPT_BOOL(0, "tags",       &tags, N_("use any tag, even unannotated")),
@@ -570,6 +571,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	if (longformat && abbrev == 0)
 		die(_("--long is incompatible with --abbrev=0"));
+	if (cherry_picks && !contains)
+		die(_("--cherry-picks can only be used with --contains"));
 
 	if (contains) {
 		struct string_list_item *item;
@@ -579,6 +582,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		argv_array_pushl(&args, "name-rev",
 				 "--peel-tag", "--name-only", "--no-undefined",
 				 NULL);
+		if (cherry_picks)
+			argv_array_push(&args, "--cherry-picks");
 		if (always)
 			argv_array_push(&args, "--always");
 		if (!all) {
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 0eb440359..7b21556ad 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -7,9 +7,13 @@
 #include "parse-options.h"
 #include "sha1-lookup.h"
 #include "commit-slab.h"
+#include "trailer.h"
+#include "object-store.h"
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
+static const char cherry_picked_prefix[] = "(cherry picked from commit ";
+
 typedef struct rev_name {
 	const char *tip_name;
 	timestamp_t taggerdate;
@@ -19,9 +23,12 @@ typedef struct rev_name {
 } rev_name;
 
 define_commit_slab(commit_rev_name, struct rev_name *);
+define_commit_slab(commit_cherry_picks, struct object_array *);
 
 static timestamp_t cutoff = TIME_MAX;
 static struct commit_rev_name rev_names;
+static struct commit_cherry_picks cherry_picks;
+static int do_cherry_picks = 0;
 
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
@@ -38,6 +45,26 @@ static void set_commit_rev_name(struct commit *commit, struct rev_name *name)
 	*commit_rev_name_at(&rev_names, commit) = name;
 }
 
+static struct object_array *get_commit_cherry_picks(struct commit *commit)
+{
+	struct object_array **slot =
+		commit_cherry_picks_peek(&cherry_picks, commit);
+
+	return slot ? *slot : NULL;
+}
+
+static struct object_array *get_create_commit_cherry_picks(struct commit *commit)
+{
+	struct object_array **slot =
+		commit_cherry_picks_at(&cherry_picks, commit);
+
+	if (!*slot) {
+		*slot = xmalloc(sizeof(struct object_array));
+		**slot = (struct object_array)OBJECT_ARRAY_INIT;
+	}
+	return *slot;
+}
+
 static int is_better_name(struct rev_name *name,
 			  const char *tip_name,
 			  timestamp_t taggerdate,
@@ -76,6 +103,47 @@ static int is_better_name(struct rev_name *name,
 	return 0;
 }
 
+static void record_cherry_pick(struct commit *commit)
+{
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	struct trailer_info info;
+	int i;
+
+	buffer = read_object_file(&commit->object.oid, &type, &size);
+	trailer_info_get(&info, buffer);
+
+	/* when nested, the last trailer describes the latest cherry-pick */
+	for (i = info.trailer_nr - 1; i >= 0; i--) {
+		const int prefix_len = sizeof(cherry_picked_prefix) - 1;
+		char *line = info.trailers[i];
+
+		if (!strncmp(line, cherry_picked_prefix, prefix_len)) {
+			struct object_id from_oid;
+			struct object *from_object;
+			struct commit *from_commit;
+			struct object_array *from_cps;
+
+			if (get_oid_hex(line + prefix_len, &from_oid)) {
+				fprintf(stderr, "Could not get sha1 from %s", line);
+				break;
+			}
+
+			from_object = parse_object(&from_oid);
+			if (!from_object || from_object->type != OBJ_COMMIT)
+				break;
+
+			from_commit = (struct commit *)from_object;
+			from_cps = get_create_commit_cherry_picks(from_commit);
+			add_object_array(&commit->object, NULL, from_cps);
+			break;
+		}
+	}
+
+	free(buffer);
+}
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int generation, int distance, int from_tag,
@@ -91,6 +159,10 @@ static void name_rev(struct commit *commit,
 	if (commit->date < cutoff)
 		return;
 
+	/* if a cherry pick we see for the first time, remember it */
+	if (do_cherry_picks && !name)
+		record_cherry_pick(commit);
+
 	if (deref) {
 		tip_name = to_free = xstrfmt("%s^0", tip_name);
 
@@ -402,6 +474,32 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 	strbuf_release(&buf);
 }
 
+static void show_cherry_picks(struct object *obj, int always,
+			      int allow_undefined, int name_only, int level)
+{
+	struct object_array *cps;
+	int i;
+
+	if (obj->type != OBJ_COMMIT)
+		return;
+
+	cps = get_commit_cherry_picks((struct commit *)obj);
+	if (!cps)
+		return;
+
+	for (i = 0; i < cps->nr; i++) {
+		struct object *cherry_pick = cps->objects[i].item;
+		int j;
+
+		for (j = 0; j < level; j++)
+			fputs("  ", stdout);
+
+		show_name(cherry_pick, NULL, always, allow_undefined, name_only);
+		show_cherry_picks(cherry_pick, always, allow_undefined,
+				  name_only, level + 1);
+	}
+}
+
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
@@ -420,6 +518,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
+		OPT_BOOL(0, "cherry-picks", &do_cherry_picks, N_("include cherry-picked commits")),
 		{
 			/* A Hidden OPT_BOOL */
 			OPTION_SET_INT, 0, "peel-tag", &peel_tag, NULL,
@@ -430,6 +529,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	};
 
 	init_commit_rev_name(&rev_names);
+	init_commit_cherry_picks(&cherry_picks);
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 	if (all + transform_stdin + !!argc > 1) {
@@ -464,10 +564,9 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (commit) {
+		if (commit)
 			if (cutoff > commit->date)
 				cutoff = commit->date;
-		}
 
 		if (peel_tag) {
 			if (!commit) {
@@ -506,9 +605,17 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 	} else {
 		int i;
-		for (i = 0; i < revs.nr; i++)
-			show_name(revs.objects[i].item, revs.objects[i].name,
-				  always, allow_undefined, data.name_only);
+		for (i = 0; i < revs.nr; i++) {
+			struct object *obj = revs.objects[i].item;
+			const char *name = revs.objects[i].name;
+
+			show_name(obj, name, always, allow_undefined,
+				  data.name_only);
+
+			if (do_cherry_picks)
+				show_cherry_picks(obj, always, allow_undefined,
+						  data.name_only, 1);
+		}
 	}
 
 	UNLEAK(revs);
diff --git a/t/t6121-describe-cherry-picks.sh b/t/t6121-describe-cherry-picks.sh
new file mode 100755
index 000000000..838e0acc0
--- /dev/null
+++ b/t/t6121-describe-cherry-picks.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='git describe should show cherry-picks correctly
+
+           C
+ o----o----x
+      |\ 
+      | .--o
+      |\  C1
+      | .--o
+       \  C2
+        .--o
+          C3
+
+C1 and C3 are cherry-picks from C, and C2 from C1.  Verify git desribe
+handles c and its cherry-picks correctly.
+'
+. ./test-lib.sh
+
+GIT_AUTHOR_EMAIL=bogus_email_address
+export GIT_AUTHOR_EMAIL
+
+test_expect_success \
+    'prepare repository with topic branches with cherry-picks' \
+    'test_tick &&
+     echo First > A &&
+     git update-index --add A &&
+     git commit -m "Add A." &&
+
+     test_tick &&
+     git checkout -b T1 master &&
+     git checkout -b T2 master &&
+     git checkout -b T3 master &&
+     git checkout master &&
+
+     test_tick &&
+     echo Second > B &&
+     git update-index --add B &&
+     git commit -m "Add B." &&
+
+     test_tick &&
+     git checkout -f T1 &&
+     rm -f B &&
+     git cherry-pick -x master &&
+
+     test_tick &&
+     git checkout -f T2 &&
+     rm -f B &&
+     git cherry-pick -x T1 &&
+
+     test_tick &&
+     git checkout -f T3 &&
+     rm -f B &&
+     git cherry-pick -x master
+'
+
+test_expect_success 'Verify describing cherry-picks' '
+     git describe --contains --all --cherry-picks master >actual &&
+     echo -e "master\n  T1\n    T2\n  T3" >expect &&
+     test_cmp expect actual
+'
+
+test_done
-- 
2.17.1

