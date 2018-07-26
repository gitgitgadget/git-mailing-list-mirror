Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490E31F597
	for <e@80x24.org>; Thu, 26 Jul 2018 14:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbeGZP4n (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 11:56:43 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45321 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbeGZP4m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 11:56:42 -0400
Received: by mail-yw0-f193.google.com with SMTP id 139-v6so649410ywg.12
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=70LQcyHQ9ua6qp2a96C03BHLH4iKvojcszMD2lVKM/w=;
        b=QvLmUG7hmhP2Bxc18l/T53lKyEYpS8c7fHzw7OtetbSsroGVKZTu/k85WU/eb+879/
         t5aA5RUNRgRJWt7t2loLwlfOZjL6WvDKnqmGI7b6y9h+z25TTIt6bCycTu0bmlr8Ru0A
         f8qrtDcayDQJueFu3RcQ8co3pbycMALo2pPOTkuewPJeVHC/0eLL3xQ4td3R5tPGH7NS
         DhPItw1X2TPnjyB/PDzPaFI+QvjmQP6jgnv4gK41ICcbj+wzMJ0T6i+KWVsH7dVPB9v+
         AZEpvbxTcSdeK0Lac1MMK9V8TbZWqIzOUimuhSWw9KP0XtIfzUvg5V4RPC3+WewAnWb+
         dNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=70LQcyHQ9ua6qp2a96C03BHLH4iKvojcszMD2lVKM/w=;
        b=eG58kbcxHXKPHDI6JMOaGMz4Hi2mB95OgdsuXd+yS5xmNLw8KQE6VMLmqHItwBDgqr
         t8QVJb5AOaLaDumMdJTi3eaRKHkzft8WgZ9FIgkyBJIPFYgriug++6O2Z096uueIDoOr
         lrlQ9cHTPKI6hOc0BjpwyBMk1X99vQeKl7KgJnbGg0WOUMtmC7TvF+k3CrNGhmbDoJB2
         +3AfBRS7R7kW3rcPh04GEE5PmDbLY2nWuHq3n2NzWfqAug4PFTlNvP7lGHumFBpZtwss
         5DcA936Vnaa8yx0awr/d1G7a5ZB2tb8IqVfrtFeIa0F1Yvs6rpi0PKrCW0sCqXBRAW9T
         7s3Q==
X-Gm-Message-State: AOUpUlFlFuXD7z9Y0q9vUWLDlE+oVNV7dbVm06Z7JjuobQgLkDe0C/+1
        l1cQrUq3tv+LQA3Tzyj6fiZxlZYk
X-Google-Smtp-Source: AAOMgpcDPzg7+7QTpAEkRLQlhgRJj9FhS/BxKYy37jwW64xQOUFox8Z9D0qq2Id30cqsG3vateAaGQ==
X-Received: by 2002:a81:4a07:: with SMTP id x7-v6mr1039899ywa.281.1532615972237;
        Thu, 26 Jul 2018 07:39:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::d338])
        by smtp.gmail.com with ESMTPSA id k9-v6sm1240462ywh.33.2018.07.26.07.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 07:39:31 -0700 (PDT)
Date:   Thu, 26 Jul 2018 07:39:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2] name_rev: add support for --cherry-picks
Message-ID: <20180726143930.GW1934745@devbig577.frc2.facebook.com>
References: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From a6a88c3da252d69547ac8b463098fc4f4c03f322 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 26 Jul 2018 04:14:52 -0700
Subject: [PATCH] name_rev: add support for --cherry-picks

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

v2: - Remove a warning message for a malformed cherry-picked tag.
      There isn't much user can do about it.
    - Continue scanning cherry-pick tags until a working one is found
      instead of aborting after trying the last one.  It might miss
      nesting but still better to show than miss the commit entirely.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/git-describe.txt   |   5 ++
 Documentation/git-name-rev.txt   |   4 ++
 builtin/describe.c               |   7 +-
 builtin/name-rev.c               | 115 +++++++++++++++++++++++++++++--
 t/t6121-describe-cherry-picks.sh |  63 +++++++++++++++++
 5 files changed, 188 insertions(+), 6 deletions(-)
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
index 0eb440359..adffae0fe 100644
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
@@ -76,6 +103,45 @@ static int is_better_name(struct rev_name *name,
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
+			if (get_oid_hex(line + prefix_len, &from_oid))
+				continue;
+
+			from_object = parse_object(&from_oid);
+			if (!from_object || from_object->type != OBJ_COMMIT)
+				continue;
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
@@ -91,6 +157,10 @@ static void name_rev(struct commit *commit,
 	if (commit->date < cutoff)
 		return;
 
+	/* if a cherry pick we see for the first time, remember it */
+	if (do_cherry_picks && !name)
+		record_cherry_pick(commit);
+
 	if (deref) {
 		tip_name = to_free = xstrfmt("%s^0", tip_name);
 
@@ -402,6 +472,32 @@ static void name_rev_line(char *p, struct name_ref_data *data)
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
@@ -420,6 +516,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
+		OPT_BOOL(0, "cherry-picks", &do_cherry_picks, N_("include cherry-picked commits")),
 		{
 			/* A Hidden OPT_BOOL */
 			OPTION_SET_INT, 0, "peel-tag", &peel_tag, NULL,
@@ -430,6 +527,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	};
 
 	init_commit_rev_name(&rev_names);
+	init_commit_cherry_picks(&cherry_picks);
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 	if (all + transform_stdin + !!argc > 1) {
@@ -464,10 +562,9 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (commit) {
+		if (commit)
 			if (cutoff > commit->date)
 				cutoff = commit->date;
-		}
 
 		if (peel_tag) {
 			if (!commit) {
@@ -506,9 +603,17 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
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

