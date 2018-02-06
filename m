Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995C21F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeBFAcL (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:32:11 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:43359 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeBFAb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:31:59 -0500
Received: by mail-pg0-f53.google.com with SMTP id f6so175322pgs.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q0F8T4mWVXLONFGtLZlkDxIY0W4Elc2c9x54S79mCoc=;
        b=dhOv8C8UwCC2iwBtc4ctVydF96GxlGEqVl4SUCqo+ntSZOg4WN4acUvBMfrY88vpyx
         fjzUPOsd6vzx8bqGioilUmUVGxobUkDn5FRMom0GjWpN3owyGS3kXR1mgaDlutzP3UNW
         lgZgWd/7QA9p9oTQN1ZXygpf9a3nh3amgnMbiwdu1WpHrb+udCMkcAc6Z0QDO969qAce
         itlgikfM+6aZhnJRy8vnIvCE86huM++z0Qq4QML+4L+KjPjvh2XI8lKdv0OceK9qzKiH
         Ve8lWGlzSGc1cgTnd/KjwABEGbuB7h90ieu4FV1XQfzoC1S8oew5Wn8RHFv2/QGqoyWw
         KaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q0F8T4mWVXLONFGtLZlkDxIY0W4Elc2c9x54S79mCoc=;
        b=N3lH27n64yMwf3XqQt40zb7T1n+/bSN5REKjixb7BCNazq6rmcQiNENSRdws9rfvVe
         i80p8BOGYc8v5mJghDTIPgePlPsf3XUZ8OxuE6nrSDmeQUDpuo56J1JPoSNAaRnELugF
         lx1n/2DsYl2RbS3Sk/sbwvlnVVavrkkVylzVUyGbAtDTYmwxYc5CcFPJvT3abnQXFJpx
         aiotKnmee90l34m2xOgA/wmqlD5YHTP053poAOPGvMb38blQYlVbGQ0mgoxZ5rosyAog
         QbKFnFKHqrEdl4UBn0Aml+ZQluN2FwxgqreiE0o0zLcFDFyGz8myOVS3NTNVMXoRH+N/
         /Tyw==
X-Gm-Message-State: APf1xPBCHzAMPy1fwxjIVRloAee3AXQN76Cvx+T10KGTyASfD5OMXvvy
        /2UvgEPwNSmAD0cppUKqIYCykxICV0M=
X-Google-Smtp-Source: AH8x2272VnfNLbz8erXFaatiHCNeqd1sG5tXFCDZiq5OtNVx4TmMbyzhgmpVd/rM9f3JfGMcGiNr0A==
X-Received: by 10.101.92.195 with SMTP id b3mr439982pgt.319.1517877118243;
        Mon, 05 Feb 2018 16:31:58 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p1sm14504860pfb.82.2018.02.05.16.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:31:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 188/194] commit: add repository argument to in_merge_bases
Date:   Mon,  5 Feb 2018 16:17:43 -0800
Message-Id: <20180206001749.218943-90-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/branch.c                           |  4 ++--
 builtin/fetch.c                            |  2 +-
 builtin/log.c                              |  2 +-
 builtin/merge-base.c                       |  2 +-
 builtin/receive-pack.c                     |  2 +-
 commit.c                                   |  4 ++--
 commit.h                                   |  3 ++-
 contrib/coccinelle/submodule_reading.cocci |  8 ++++++++
 fast-import.c                              |  2 +-
 http-push.c                                |  2 +-
 pack-bitmap-write.c                        |  2 +-
 submodule.c                                | 12 ++++++------
 12 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2d752c6614..f525b7e2b5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -132,7 +132,7 @@ static int branch_merged(int kind, const char *name,
 	if (!reference_rev)
 		reference_rev = head_rev;
 
-	merged = in_merge_bases(rev, reference_rev);
+	merged = in_merge_bases(the_repository, rev, reference_rev);
 
 	/*
 	 * After the safety valve is fully redefined to "check with
@@ -142,7 +142,7 @@ static int branch_merged(int kind, const char *name,
 	 * a gentle reminder is in order.
 	 */
 	if ((head_rev != reference_rev) &&
-	    in_merge_bases(rev, head_rev) != merged) {
+	    in_merge_bases(the_repository, rev, head_rev) != merged) {
 		if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
 				"         '%s', but not yet merged to HEAD."),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b516b176f0..14eccf3f0d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -695,7 +695,7 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	}
 
-	if (in_merge_bases(current, updated)) {
+	if (in_merge_bases(the_repository, current, updated)) {
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
 		strbuf_add_unique_abbrev(&quickref, current->object.oid.hash, DEFAULT_ABBREV);
diff --git a/builtin/log.c b/builtin/log.c
index bb9d909f59..e8bb899e52 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1325,7 +1325,7 @@ static struct commit *get_base_commit(const char *base_commit,
 		rev_nr = DIV_ROUND_UP(rev_nr, 2);
 	}
 
-	if (!in_merge_bases(base, rev[0]))
+	if (!in_merge_bases(the_repository, base, rev[0]))
 		die(_("base commit should be the ancestor of revision list"));
 
 	for (i = 0; i < total; i++) {
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 426882818c..00e9f11d92 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -104,7 +104,7 @@ static int handle_is_ancestor(int argc, const char **argv)
 		die("--is-ancestor takes exactly two commits");
 	one = get_commit_reference(argv[0]);
 	two = get_commit_reference(argv[1]);
-	if (in_merge_bases(one, two))
+	if (in_merge_bases(the_repository, one, two))
 		return 0;
 	else
 		return 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7d00f0bad6..2b41affaf5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1118,7 +1118,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
-		if (!in_merge_bases(old_commit, new_commit)) {
+		if (!in_merge_bases(the_repository, old_commit, new_commit)) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
 			return "non-fast-forward";
diff --git a/commit.c b/commit.c
index 98e04b949f..900ecf84b8 100644
--- a/commit.c
+++ b/commit.c
@@ -1040,7 +1040,7 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 
 		other = with_commit->item;
 		with_commit = with_commit->next;
-		if (in_merge_bases(other, commit))
+		if (in_merge_bases(the_repository, other, commit))
 			return 1;
 	}
 	return 0;
@@ -1072,7 +1072,7 @@ int in_merge_bases_many_the_repository(struct commit *commit, int nr_reference,
 /*
  * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
  */
-int in_merge_bases(struct commit *commit, struct commit *reference)
+int in_merge_bases_the_repository(struct commit *commit, struct commit *reference)
 {
 	return in_merge_bases_many(the_repository, commit, 1, &reference);
 }
diff --git a/commit.h b/commit.h
index ea2c5f528c..0f3cdc6375 100644
--- a/commit.h
+++ b/commit.h
@@ -232,7 +232,8 @@ extern void prune_shallow(int show_only);
 extern struct trace_key trace_shallow;
 
 int is_descendant_of(struct commit *, struct commit_list *);
-int in_merge_bases(struct commit *, struct commit *);
+#define in_merge_bases(r, c1, c2) in_merge_bases_##r(c1, c2)
+int in_merge_bases_the_repository(struct commit *, struct commit *);
 #define in_merge_bases_many(r, c, n, co) in_merge_bases_many_##r(c, n, co)
 int in_merge_bases_many_the_repository(struct commit *, int, struct commit **);
 
diff --git a/contrib/coccinelle/submodule_reading.cocci b/contrib/coccinelle/submodule_reading.cocci
index 30935ac21d..b9da6a08d3 100644
--- a/contrib/coccinelle/submodule_reading.cocci
+++ b/contrib/coccinelle/submodule_reading.cocci
@@ -24,3 +24,11 @@ expression H;
  format_commit_message(
 +the_repository,
  E, F, G, H)
+
+@@
+expression E;
+expression F;
+@@
+ in_merge_bases(
++the_repository,
+ E, F)
diff --git a/fast-import.c b/fast-import.c
index b1ff3d47df..f68d3fbd87 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1773,7 +1773,7 @@ static int update_branch(struct branch *b)
 		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
 
-		if (!in_merge_bases(old_cmit, new_cmit)) {
+		if (!in_merge_bases(the_repository, old_cmit, new_cmit)) {
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, oid_to_hex(&b->oid),
diff --git a/http-push.c b/http-push.c
index c7fa9ee15a..6af853d245 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1571,7 +1571,7 @@ static int verify_merge_base(struct object_id *head_oid, struct ref *remote)
 	struct commit *branch = lookup_commit_or_die(&remote->old_oid,
 						     remote->name);
 
-	return in_merge_bases(branch, head);
+	return in_merge_bases(the_repository, branch, head);
 }
 
 static int delete_remote_branch(const char *pattern, int force)
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f684ed5ea2..9ac581920b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -286,7 +286,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		if (stored->bitmap == NULL) {
 			if (i < writer.selected_nr - 1 &&
 			    (need_reset ||
-			     !in_merge_bases(writer.selected[i + 1].commit,
+			     !in_merge_bases(the_repository, writer.selected[i + 1].commit,
 					     stored->commit))) {
 			    bitmap_reset(base);
 			    reset_all_seen();
diff --git a/submodule.c b/submodule.c
index b399cf46e4..6125bfbdde 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1753,7 +1753,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object *o = &(commit->object);
-		if (in_merge_bases(b, commit))
+		if (in_merge_bases(the_repository, b, commit))
 			add_object_array(o, NULL, &merges);
 	}
 	reset_revision_walk();
@@ -1768,7 +1768,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 		contains_another = 0;
 		for (j = 0; j < merges.nr; j++) {
 			struct commit *m2 = (struct commit *) merges.objects[j].item;
-			if (i != j && in_merge_bases(m2, m1)) {
+			if (i != j && in_merge_bases(the_repository, m2, m1)) {
 				contains_another = 1;
 				break;
 			}
@@ -1829,18 +1829,18 @@ int merge_submodule(struct object_id *result, const char *path,
 	}
 
 	/* check whether both changes are forward */
-	if (!in_merge_bases(commit_base, commit_a) ||
-	    !in_merge_bases(commit_base, commit_b)) {
+	if (!in_merge_bases(the_repository, commit_base, commit_a) ||
+	    !in_merge_bases(the_repository, commit_base, commit_b)) {
 		MERGE_WARNING(path, "commits don't follow merge-base");
 		return 0;
 	}
 
 	/* Case #1: a is contained in b or vice versa */
-	if (in_merge_bases(commit_a, commit_b)) {
+	if (in_merge_bases(the_repository, commit_a, commit_b)) {
 		oidcpy(result, b);
 		return 1;
 	}
-	if (in_merge_bases(commit_b, commit_a)) {
+	if (in_merge_bases(the_repository, commit_b, commit_a)) {
 		oidcpy(result, a);
 		return 1;
 	}
-- 
2.15.1.433.g936d1b9894.dirty

