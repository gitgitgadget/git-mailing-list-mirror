Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE32451071
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116929; cv=none; b=RQOLJHHiQs3K3GdgKbEIHx76OrruI3ayGbpMEb9x2gcUr9TyXIKif6MtEjgejrkUAg6+6PARnR2HOmXJpbVOL1sta1b4//dTx+N9K9aqYg51Ewm6HrchfY2QhmQzaeo7h7jIfynveFNaH+tHMCjVx5ylENGiQP/tuhaHvsZF8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116929; c=relaxed/simple;
	bh=YtLk+gXXmlQbF2RH9YCpIuqd3WxUF2MStmHa8cSGUPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osy1r+dvrvRAPtlDveGfjGPs1da/7uuQCgv2kEE37weLDLdqiJcC08OzDakd8F3wPFloVAL+iNbXz55hmGRaWb7nsTee7WoPAVgdx9qgw0s0rv96S3L2C/Opjqi3g+p9x5epq44Bx09b1jdeQDLjTPpzFKDSrPdEN5Szexb5XYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6NrPj/i; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6NrPj/i"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc6207127aso26647415ad.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784116926; x=1784721726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/o7NEpfVr62XsJrQ2+PqlDpXPqNYPQyFvexz9KN4mO4=;
        b=g6NrPj/i8sxV0qlnWu67pUJFwu/aQRTgIQ0fJ1M3aTZqfHcll90oARqyjz2a54XkUI
         wCxVvDGQ0WNdAjMbogxt6NwXu1obuOkkjw3er1U3t+4Nl29gBZGGNCt2eiA5fxMO24D5
         1LwyKGVrKwCXjLS+ip0xU6g/qTgOcx1G9iXbEKHaggVo7EDYWuoCK0NPFP47KjuIE35J
         jiQCXSq8ACFFE/Z4aWXGAfbwoEnX+unXQMZWmkKI3f6YYm6BXphnZPo5UrKJz5zwbsZW
         n0d9L6YD2Bj+3j2G9DqpUUVDH0cwStMac6oZCiEcl/jbzIH1pGyG8Ryq3cxEO1Omy6Fn
         9HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784116926; x=1784721726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/o7NEpfVr62XsJrQ2+PqlDpXPqNYPQyFvexz9KN4mO4=;
        b=qBaqkByttFqZ7WaKYrBsGzbYH8WN+AsseeGxm29FMBO3Wgdlxz298d4hG+7rEpHIv7
         t+1DVi/Wnom+6//LIblNdat67w98M8bhVY9hVGJbZaTsf8c/0wP3ZOyPwjw85rk4NNOE
         dr9WoV/BlyXKZqoFdIIugKD+mhWkBOsrTqETnq0RUidnYpgl6Tz0SEqof35taYy1xm1N
         w4B6WSTEEivqB4ahkoy6ZKxZUVi3Flyt8mR2QDIqG7KMjDzejAIKey+oli3z2GiLqnax
         Wa4mdRORnsI7eiYs/PrnJQx+Wz00lN72dQZhkvSK8Luas4EEfohQmHSs8Vhcle5YFvex
         93qw==
X-Gm-Message-State: AOJu0Yw1W9ARvNbUa6DPpHDhF2wr8YMqeM9OURrZNjQieT71kYL4msMQ
	tlJEz7RhUjvAUId7ai8pCyoIXV1hKX5pfH6hB9aiTgqs1XEAiUMbVdOsyec15Eif2uA=
X-Gm-Gg: AfdE7cl9tKOd9lfHVeLg2moI83L7AqV1raMYgRHRqTNQMvYvZ1pm3nPqsRwUgKGsk2b
	UlJS3TOWc/F+WfBxCGUYZMexkHnD99xiD+uDUEoWLEVxzWMXOE/xhj8E5QlqHTUbCccpgJnj0f6
	0D5ZrzGiGbvZAXiJLJOPB1yxTpD8M992lpLXiFn88VYjCn1gelXZKqDR3vsNOShHkOaQXM8KqCF
	odLNu+2ylqUISyZAty7GPTTRuSxjmkyCk/gTrVEBbUpp6WdAHiPgiIKJRU2KsR546W4tfwB+YyJ
	mXNjXqhGc4CDLoksm4cvDPTWxHVsFY6M0ZNSk6vf8pTC/2n+DM/XRMqYjaZzBR29iBWAfz5K6dH
	qjEzTTEYf0pyJyEVTbsdjWIOzSCK7e6EzBZQGSI1seQ1tE/8xuf/d06enlEha68XR85Az4GQZEs
	itjnjK48wdH9dyOQlANMgQVNulq8NKKaJTQCSjpaRoP3/iYDSjPHhREBCIjA==
X-Received: by 2002:a17:902:fc4b:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2cf03cb50bamr23646015ad.14.1784116926317;
        Wed, 15 Jul 2026 05:02:06 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.213])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd432ef79sm674682c88.10.2026.07.15.05.02.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 05:02:05 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v5] show-branch: convert per-branch flags to commit-slab
Date: Wed, 15 Jul 2026 17:31:56 +0530
Message-ID: <20260715120156.53025-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqwluwpvme.fsf@gitster.g>
References: <xmqqwluwpvme.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show-branch uses commit->object.flags to store per-branch
reachability bits, one bit per branch starting at REV_SHIFT.
The flags word has only a fixed number of available bits, limiting
the number of branches that can be shown simultaneously to MAX_REVS.

Convert the per-branch bits to a dedicated commit-slab using uint64_t
as the element type, initialized with a stride via
init_commit_rev_flags_with_stride(). Keep the UNINTERESTING bit in
object.flags where it belongs, as it is used for revision walking and
does not need to be in the per-branch slab. With UNINTERESTING removed
from the slab, REV_SHIFT becomes 0 and all 64 bits of uint64_t are
available for branch tracking, lifting MAX_REVS from 27 to 64 branches.

Add helper functions get_rev_flags_ptr(), peek_rev_flags_ptr(),
has_any_rev_flags(), or_rev_flag_bit(), test_rev_flag_bit(),
has_all_rev_flags(), and has_only_rev_flag_bit() to encapsulate
per-bit slab access cleanly. Use has_only_rev_flag_bit() in
show_independent() to preserve the original semantics: a commit is
independent only if reachable from exactly one tip, not merely if
the i-th bit happens to be set. Update all bit operations to use
UINT64_C(1) for correct 64-bit shifts. Initialize and clear the slab
in cmd_show_branch().

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

Apologies to Patrick for not replying inline to the review before
sending v4. For previous review threads I did reply inline; for that
round I mistakenly folded the response into the annotation only.

Response to Junio's review of v4:

- Restored the TODO comment above REV_SHIFT since the UNINTERESTING
  migration to the slab is not yet complete.
- Removed the local "#define UNINTERESTING 01" and added
  #include "revision.h" to use the shared definition instead.

  Changes in v5:
- Restore TODO comment above REV_SHIFT 
- Remove local UNINTERESTING define, include revision.h instead 

 builtin/show-branch.c | 162 +++++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 59 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..cf037c5814 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "pretty.h"
 #include "refs.h"
+#include "revision.h"
 #include "color.h"
 #include "strvec.h"
 #include "object-name.h"
@@ -35,15 +36,12 @@ static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;
 static struct strvec default_args = STRVEC_INIT;
 
 /*
- * TODO: convert this use of commit->object.flags to commit-slab
- * instead to store a pointer to ref name directly. Then use the same
- * UNINTERESTING definition from revision.h here.
+ * TODO: store a pointer to ref name directly in the commit-slab
+ * instead, and use the UNINTERESTING definition from revision.h
+ * here once that is done.
  */
-#define UNINTERESTING	01
-
-#define REV_SHIFT	 2
-#define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
-
+#define REV_SHIFT	 0
+#define MAX_REVS	(sizeof(uint64_t) * 8)
 #define DEFAULT_REFLOG	4
 
 static const char *get_color_code(int idx)
@@ -79,11 +77,72 @@ struct commit_name {
 define_commit_slab(commit_name_slab, struct commit_name *);
 static struct commit_name_slab name_slab;
 
+define_commit_slab(commit_rev_flags, uint64_t);
+static struct commit_rev_flags rev_flags_slab;
+static int flags_stride; /* number of uint64_t words per commit */
+
 static struct commit_name *commit_to_name(struct commit *commit)
 {
 	return *commit_name_slab_at(&name_slab, commit);
 }
 
+static uint64_t *get_rev_flags_ptr(struct commit *commit)
+{
+	return commit_rev_flags_at(&rev_flags_slab, commit);
+}
+
+static uint64_t *peek_rev_flags_ptr(struct commit *commit)
+{
+	return commit_rev_flags_peek(&rev_flags_slab, commit);
+}
+
+static int has_any_rev_flags(struct commit *commit)
+{
+	uint64_t *f = peek_rev_flags_ptr(commit);
+	int i;
+	if (!f)
+		return 0;
+	for (i = 0; i < flags_stride; i++)
+		if (f[i])
+			return 1;
+	return 0;
+}
+
+static void or_rev_flag_bit(struct commit *commit, int branch)
+{
+	get_rev_flags_ptr(commit)[branch / 64] |= UINT64_C(1) << (branch % 64);
+}
+
+static int test_rev_flag_bit(struct commit *commit, int branch)
+{
+	uint64_t *f = peek_rev_flags_ptr(commit);
+	return f && !!(f[branch / 64] & (UINT64_C(1) << (branch % 64)));
+}
+
+static int has_all_rev_flags(struct commit *commit, int num_rev)
+{
+	int i;
+	for (i = 0; i < num_rev; i++)
+		if (!test_rev_flag_bit(commit, i))
+			return 0;
+	return 1;
+}
+
+static int has_only_rev_flag_bit(struct commit *commit, int branch)
+{
+	uint64_t *f = peek_rev_flags_ptr(commit);
+	int i;
+	if (!f)
+		return 0;
+	for (i = 0; i < flags_stride; i++) {
+		uint64_t expected = (i == branch / 64)
+				    ? (UINT64_C(1) << (branch % 64))
+				    : 0;
+		if (f[i] != expected)
+			return 0;
+	}
+	return 1;
+}
 
 /* Name the commit as nth generation ancestor of head_name;
  * we count only the first-parent relationship for naming purposes.
@@ -215,7 +274,7 @@ static void name_commits(struct commit_list *list,
 
 static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 {
-	if (!commit->object.flags) {
+	if (!has_any_rev_flags(commit)) {
 		commit_list_insert(commit, seen_p);
 		return 1;
 	}
@@ -226,34 +285,34 @@ static void join_revs(struct prio_queue *queue,
 		      struct commit_list **seen_p,
 		      int num_rev, int extra)
 {
-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
-
 	while (queue->nr) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(queue);
 		struct commit *commit = prio_queue_peek(queue);
 		bool get_pending = true;
-		int flags = commit->object.flags & all_mask;
 
 		if (!still_interesting && extra <= 0)
 			break;
 
 		mark_seen(commit, seen_p);
-		if ((flags & all_revs) == all_revs)
-			flags |= UNINTERESTING;
+		if (has_all_rev_flags(commit, num_rev))
+			commit->object.flags |= UNINTERESTING;
 		parents = commit->parents;
 
 		while (parents) {
 			struct commit *p = parents->item;
-			int this_flag = p->object.flags;
 			parents = parents->next;
-			if ((this_flag & flags) == flags)
+			if (has_all_rev_flags(p, num_rev))
 				continue;
 			repo_parse_commit(the_repository, p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
-			p->object.flags |= flags;
+			{
+				int _b;
+				for (_b = 0; _b < num_rev; _b++)
+					if (test_rev_flag_bit(commit, _b))
+						or_rev_flag_bit(p, _b);
+			}
 			if (get_pending)
 				prio_queue_replace(queue, p);
 			else
@@ -263,7 +322,6 @@ static void join_revs(struct prio_queue *queue,
 		if (get_pending)
 			prio_queue_get(queue);
 	}
-
 	/*
 	 * Postprocess to complete well-poisoning.
 	 *
@@ -278,7 +336,7 @@ static void join_revs(struct prio_queue *queue,
 			struct commit *c = s->item;
 			struct commit_list *parents;
 
-			if (((c->object.flags & all_revs) != all_revs) &&
+			if (!has_all_rev_flags(c, num_rev) &&
 			    !(c->object.flags & UNINTERESTING))
 				continue;
 
@@ -410,8 +468,8 @@ static int append_ref(const char *refname, const struct object_id *oid,
 				return 0;
 	}
 	if (MAX_REVS <= ref_name_cnt) {
-		warning(Q_("ignoring %s; cannot handle more than %d ref",
-			   "ignoring %s; cannot handle more than %d refs",
+		warning(Q_("ignoring %s; cannot handle more than %zu ref",
+			   "ignoring %s; cannot handle more than %zu refs",
 			   MAX_REVS), refname, MAX_REVS);
 		return 0;
 	}
@@ -511,15 +569,12 @@ static int rev_is_head(const char *head, const char *name)
 
 static int show_merge_base(const struct commit_list *seen, int num_rev)
 {
-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
 	int exit_status = 1;
 
 	for (const struct commit_list *s = seen; s; s = s->next) {
 		struct commit *commit = s->item;
-		int flags = commit->object.flags & all_mask;
-		if (!(flags & UNINTERESTING) &&
-		    ((flags & all_revs) == all_revs)) {
+		if (!(commit->object.flags & UNINTERESTING) &&
+			has_all_rev_flags(commit, num_rev)) {
 			puts(oid_to_hex(&commit->object.oid));
 			exit_status = 0;
 			commit->object.flags |= UNINTERESTING;
@@ -528,17 +583,13 @@ static int show_merge_base(const struct commit_list *seen, int num_rev)
 	return exit_status;
 }
 
-static int show_independent(struct commit **rev,
-			    int num_rev,
-			    unsigned int *rev_mask)
+static int show_independent(struct commit **rev, int num_rev)
 {
 	int i;
 
 	for (i = 0; i < num_rev; i++) {
 		struct commit *commit = rev[i];
-		unsigned int flag = rev_mask[i];
-
-		if (commit->object.flags == flag)
+		if (has_only_rev_flag_bit(commit, i))
 			puts(oid_to_hex(&commit->object.oid));
 		commit->object.flags |= UNINTERESTING;
 	}
@@ -603,13 +654,12 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
 	 * Otherwise, if it is a merge that is reachable from only one
 	 * tip, it is not that interesting.
 	 */
-	int i, flag, count;
+	int i, count;
 	for (i = 0; i < n; i++)
 		if (rev[i] == commit)
 			return 0;
-	flag = commit->object.flags;
 	for (i = count = 0; i < n; i++) {
-		if (flag & (1u << (i + REV_SHIFT)))
+		if (test_rev_flag_bit(commit, i))
 			count++;
 	}
 	if (count == 1)
@@ -648,10 +698,8 @@ int cmd_show_branch(int ac,
 	char *reflog_msg[MAX_REVS] = {0};
 	struct commit_list *seen = NULL;
 	struct prio_queue queue = { compare_commits_by_commit_date };
-	unsigned int rev_mask[MAX_REVS];
 	int num_rev, i, extra = 0;
 	int all_heads = 0, all_remotes = 0;
-	int all_mask, all_revs;
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
 	char *head;
 	struct object_id head_oid;
@@ -713,7 +761,8 @@ int cmd_show_branch(int ac,
 	const char **args_copy = NULL;
 	int ret;
 
-	init_commit_name_slab(&name_slab);
+	flags_stride = (MAX_REVS + 63) / 64;
+	init_commit_rev_flags_with_stride(&rev_flags_slab, flags_stride);
 
 	repo_config(the_repository, git_show_branch_config, NULL);
 
@@ -779,8 +828,8 @@ int cmd_show_branch(int ac,
 			die(_("--reflog option needs one branch name"));
 
 		if (MAX_REVS < reflog)
-			die(Q_("only %d entry can be shown at one time.",
-			       "only %d entries can be shown at one time.",
+			die(Q_("only %zu entry can be shown at one time.",
+			       "only %zu entries can be shown at one time.",
 			       MAX_REVS), MAX_REVS);
 		if (!repo_dwim_ref(the_repository, *av, strlen(*av), &oid,
 				   &ref, 0))
@@ -870,11 +919,11 @@ int cmd_show_branch(int ac,
 
 	for (num_rev = 0; ref_name[num_rev]; num_rev++) {
 		struct object_id revkey;
-		unsigned int flag = 1u << (num_rev + REV_SHIFT);
+		int first_seen;
 
 		if (MAX_REVS <= num_rev)
-			die(Q_("cannot handle more than %d rev.",
-			       "cannot handle more than %d revs.",
+			die(Q_("cannot handle more than %zu rev.",
+			       "cannot handle more than %zu revs.",
 			       MAX_REVS), MAX_REVS);
 		if (repo_get_oid(the_repository, ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
@@ -885,17 +934,15 @@ int cmd_show_branch(int ac,
 		repo_parse_commit(the_repository, commit);
 		mark_seen(commit, &seen);
 
-		/* rev#0 uses bit REV_SHIFT, rev#1 uses bit REV_SHIFT+1,
-		 * and so on.  REV_SHIFT bits from bit 0 are used for
-		 * internal bookkeeping.
+		/* rev#0 uses bit 0, rev#1 uses bit 1,
+		 * and so on.  All bits are available for branch tracking.
 		 */
-		commit->object.flags |= flag;
-		if (commit->object.flags == flag)
+		first_seen = !has_any_rev_flags(commit);
+		or_rev_flag_bit(commit, num_rev);
+		if (first_seen)
 			prio_queue_put(&queue, commit);
 		rev[num_rev] = commit;
 	}
-	for (i = 0; i < num_rev; i++)
-		rev_mask[i] = rev[i]->object.flags;
 
 	if (0 <= extra)
 		join_revs(&queue, &seen, num_rev, extra);
@@ -908,7 +955,7 @@ int cmd_show_branch(int ac,
 	}
 
 	if (independent) {
-		ret = show_independent(rev, num_rev, rev_mask);
+		ret = show_independent(rev, num_rev);
 		goto out;
 	}
 
@@ -958,13 +1005,9 @@ int cmd_show_branch(int ac,
 	if (!sha1_name && !no_name)
 		name_commits(seen, rev, ref_name, num_rev);
 
-	all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
-
 	for (struct commit_list *l = seen; l; l = l->next) {
 		struct commit *commit = l->item;
-		int this_flag = commit->object.flags;
-		int is_merge_point = ((this_flag & all_revs) == all_revs);
+		int is_merge_point = has_all_rev_flags(commit, num_rev);
 
 		shown_merge_point |= is_merge_point;
 
@@ -973,14 +1016,14 @@ int cmd_show_branch(int ac,
 					  commit->parents->next);
 			if (topics &&
 			    !is_merge_point &&
-			    (this_flag & (1u << REV_SHIFT)))
+			    test_rev_flag_bit(commit, 0))
 				continue;
 			if (!sparse && is_merge &&
 			    omit_in_dense(commit, rev, num_rev))
 				continue;
 			for (i = 0; i < num_rev; i++) {
 				int mark;
-				if (!(this_flag & (1u << (i + REV_SHIFT))))
+				if (!test_rev_flag_bit(commit, i))
 					mark = ' ';
 				else if (is_merge)
 					mark = '-';
@@ -1010,6 +1053,7 @@ int cmd_show_branch(int ac,
 		free(reflog_msg[i]);
 	commit_list_free(seen);
 	clear_prio_queue(&queue);
+	clear_commit_rev_flags(&rev_flags_slab);
 	free(args_copy);
 	free(head);
 	return ret;
-- 
2.54.0

