Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5D71F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeBFA3d (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:29:33 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44712 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeBFA3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:29:32 -0500
Received: by mail-pg0-f65.google.com with SMTP id r1so169596pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0v/bAUk7333ArPobffS7irkW59pENemQmB6uRylJh8Q=;
        b=pjZu5RNECcK9S0Nho6nNtJNRkoblqb0eMSQXJIQ+wa3Keaa1JKmsPVgSlHq0V7Xpxg
         ndMetz+AFFb8RDZJLYv/AJwol82pcpOvttKcQmD1C/GhrMOiF6rrrUiqMQXGE55xJexd
         fv/t4lrlAr8bnxuuGISqzwYzYDoadkwP3Msu1xtawQ4eWw5JjKkelaVGooM/PG5FldpP
         b1Uzn5nEUdO9m+0JFQ6lgL4rKBqLFAi6EqYoE56bwmvU0xQuqqCrmpEkJ7BiweiwYe+o
         GTFrgNvIQi5ZFe3YxlzgwRiSH3t6t8S/pT+nKvUxuvlHIhZyWrDjR336oS25wVaZnbR0
         nkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0v/bAUk7333ArPobffS7irkW59pENemQmB6uRylJh8Q=;
        b=AeR6Bywjc/hsKeq8zhKrWXfenezhEhpoOffpTjME6XeJiFg8osV93Um1Kq0s5IYNH9
         tv8jfI/XBaDVmemSdVYjbg1agpSla9lzTZen8CJ2K2I45dkH0nA9FvWWpdvujVYIhXpp
         Q+ZoGP18YTH+wPxuhIrm0vNMH3RFnOHSAz7CXRJ5Kouawnbtl0AtZDiW86VsTHN3wjWW
         ENubQxzQTW+WO9WI9EWyojSfgaBblt754GB11AFwcnSGNVlK0icNS/ZXLWaq4GfwScBI
         nCSa+IsBS9SsXgS3pxfEyXi5DLi19KCGmtpIryVKa7LhTf+ayk4L829V879yKwzMgMBN
         BB+Q==
X-Gm-Message-State: APf1xPCRQNsnxAeZmqp+aWIIEdIXAx/t+99U3f9c9enelazCi78GOBWV
        b56h5IxM2q4HCxheiNObI6yzKzUyHAA=
X-Google-Smtp-Source: AH8x226ZdB74GWGtbASA4XOclUlB8KH0zAoSD1ql/N16RRdaESoYRl2/lShKIExdWL+GXr5t/rmgqQ==
X-Received: by 10.98.112.4 with SMTP id l4mr586695pfc.8.1517876971156;
        Mon, 05 Feb 2018 16:29:31 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a3sm7162777pgw.23.2018.02.05.16.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:29:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 171/194] commit: add repository argument to get_merge_bases
Date:   Mon,  5 Feb 2018 16:17:26 -0800
Message-Id: <20180206001749.218943-73-sbeller@google.com>
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
 builtin/log.c       | 2 +-
 builtin/merge.c     | 4 ++--
 builtin/rev-parse.c | 2 +-
 commit.c            | 4 ++--
 commit.h            | 3 ++-
 merge-recursive.c   | 2 +-
 notes-merge.c       | 2 +-
 revision.c          | 4 ++--
 sha1_name.c         | 2 +-
 submodule.c         | 2 +-
 10 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 12426e685f..3ccab366e7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1312,7 +1312,7 @@ static struct commit *get_base_commit(const char *base_commit,
 	while (rev_nr > 1) {
 		for (i = 0; i < rev_nr / 2; i++) {
 			struct commit_list *merge_base;
-			merge_base = get_merge_bases(rev[2 * i], rev[2 * i + 1]);
+			merge_base = get_merge_bases(the_repository, rev[2 * i], rev[2 * i + 1]);
 			if (!merge_base || merge_base->next)
 				die(_("Failed to find exact merge base"));
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 4f5c01c41c..93a736ac36 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1352,7 +1352,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!remoteheads)
 		; /* already up-to-date */
 	else if (!remoteheads->next)
-		common = get_merge_bases(head_commit, remoteheads->item);
+		common = get_merge_bases(the_repository, head_commit, remoteheads->item);
 	else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
@@ -1451,7 +1451,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * merge_bases again, otherwise "git merge HEAD^
 			 * HEAD^^" would be missed.
 			 */
-			common_one = get_merge_bases(head_commit, j->item);
+			common_one = get_merge_bases(the_repository, head_commit, j->item);
 			if (oidcmp(&common_one->item->object.oid, &j->item->object.oid)) {
 				up_to_date = 0;
 				break;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 5911714441..3399176e49 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -282,7 +282,7 @@ static int try_difference(const char *arg)
 			struct commit *a, *b;
 			a = lookup_commit_reference(the_repository, &oid);
 			b = lookup_commit_reference(the_repository, &end);
-			exclude = get_merge_bases(a, b);
+			exclude = get_merge_bases(the_repository, a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
 				show_rev(REVERSED, &commit->object.oid, NULL);
diff --git a/commit.c b/commit.c
index db03550d70..8b1e35d2a1 100644
--- a/commit.c
+++ b/commit.c
@@ -900,7 +900,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 
 		for (j = ret; j; j = j->next) {
 			struct commit_list *bases;
-			bases = get_merge_bases(i->item, j->item);
+			bases = get_merge_bases(the_repository, i->item, j->item);
 			if (!new)
 				new = bases;
 			else
@@ -1025,7 +1025,7 @@ struct commit_list *get_merge_bases_many_dirty(struct commit *one,
 	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
 }
 
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
+struct commit_list *get_merge_bases_the_repository(struct commit *one, struct commit *two)
 {
 	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
 }
diff --git a/commit.h b/commit.h
index b60c287e7d..e671ce68db 100644
--- a/commit.h
+++ b/commit.h
@@ -180,7 +180,8 @@ struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
 
-extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
+#define get_merge_bases(r, r1, r2) get_merge_bases_##r(r1, r2)
+extern struct commit_list *get_merge_bases_the_repository(struct commit *rev1, struct commit *rev2);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index c749785b0b..6e06634993 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2074,7 +2074,7 @@ int merge_recursive(struct merge_options *o,
 	}
 
 	if (!ca) {
-		ca = get_merge_bases(h1, h2);
+		ca = get_merge_bases(the_repository, h1, h2);
 		ca = reverse_commit_list(ca);
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index df66d96811..58b518ae0a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -594,7 +594,7 @@ int notes_merge(struct notes_merge_options *o,
 	assert(local && remote);
 
 	/* Find merge bases */
-	bases = get_merge_bases(local, remote);
+	bases = get_merge_bases(the_repository, local, remote);
 	if (!bases) {
 		base_oid = &null_oid;
 		base_tree_oid = the_hash_algo->empty_tree;
diff --git a/revision.c b/revision.c
index 754d7b438e..c5d376ba0a 100644
--- a/revision.c
+++ b/revision.c
@@ -1473,7 +1473,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
-	bases = get_merge_bases(head, other);
+	bases = get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
 	free_commit_list(bases);
@@ -1568,7 +1568,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
-		exclude = get_merge_bases(a, b);
+		exclude = get_merge_bases(the_repository, a, b);
 		add_rev_cmdline_list(revs, exclude, REV_CMD_MERGE_BASE,
 				     flags_exclude);
 		add_pending_commit_list(revs, exclude, flags_exclude);
diff --git a/sha1_name.c b/sha1_name.c
index a60eaf14d2..7675ec634f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1266,7 +1266,7 @@ int get_oid_mb(const char *name, struct object_id *oid)
 	two = lookup_commit_reference_gently(the_repository, &oid_tmp, 0);
 	if (!two)
 		return -1;
-	mbs = get_merge_bases(one, two);
+	mbs = get_merge_bases(the_repository, one, two);
 	if (!mbs || mbs->next)
 		st = -1;
 	else {
diff --git a/submodule.c b/submodule.c
index f9426beff1..af4a1d2cea 100644
--- a/submodule.c
+++ b/submodule.c
@@ -526,7 +526,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = get_merge_bases(*left, *right);
+	*merge_bases = get_merge_bases(the_repository, *left, *right);
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
-- 
2.15.1.433.g936d1b9894.dirty

