Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A630199920
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665838; cv=none; b=bZP6nDUaT30e/MmHs5Kggrx+JuhcJrRm2joO0G+PW9TwjyFlHuyfYOmh0u1ugvdU8Ab2vOIXcY0eWorIVLov+ywPs2hLiQuorC6S2URNvrBAjttWvNjctgtU5dl+jFoTomDRmR+zHdipeYD9OKXjMz5FoouKES2BAN+pWimubzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665838; c=relaxed/simple;
	bh=JGyVf3WysDyKlq/jd2FPVGp/IXAoKnGl4csfWRKUflI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrxszmMKv7okiai9x30JKdOfzM86VIJW1zPXrB5l3lIsIQgxbUaefUCP7JnF8rU9lm/M7/KMjOuAH92IFws0QpVMwq0o+yP/Wxr8EgsVM8f76H40rOb6aN0s8hftTBW1J7lQH2LCUGK8uloGFwqKHRDWYTG5nZ4HW4CYm5GiIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9Q5Sr4C; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9Q5Sr4C"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2caced6038eso73629265ad.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784665835; x=1785270635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CRQQlZwTtsfWVwtxNZhntMRoQHUxiCg/lrmn/WA3hgE=;
        b=k9Q5Sr4CFUCGJ00EmzMaYbqCNUJbZy8CiXQa6YoH08LuqGKJFixFQG54d+FjQqXEHX
         nVEuRVogQWtCXd1ALPAe6s+wEhukGWXYaADUZF0/dl5dOyIAlX4W86zxn01S1tuuPFrJ
         mIyn0R4Hk/xgCqkFpmDAo59vgjclKqIEDOsylpT8ucR+18XCnOtWv5AjYtxPVA/baWd9
         O+3mfu5Um5VtrBYdHqks4C+/6aTxUA41AiloOA72ZkTMIC0gOslpOyHPq7D0c6q81SER
         vDj5b3cR6vD3PmR+tu3iJ2kK/FShkNU8BYqWD2AeqXC6H9GRQg3qao+OTwq3+wZtJPQ/
         jKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784665835; x=1785270635;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CRQQlZwTtsfWVwtxNZhntMRoQHUxiCg/lrmn/WA3hgE=;
        b=gC5pwHwl6BYKGlBS/tvbHCUQ/fKxq7RkzCuHjfphNSDHKRPJ1wMnzKfkWFnWEHC9nt
         3DcpXIKgf1iVYpc87NSjWZc8E0gMn5/L0Vnukv6oUFQD4KdFYnRdTFZTbLlRW7MQc1rm
         qggR5okohRtW1KH7NGcw/bLZiApSYC3j9nNFYG86kbwSoKNqYEBW5F67vbKruVprv5di
         JwnT0OkhTSOr0ETwcnqB7axYx88tWw+2XkGCe/qwu6ULTmiSXbdr835fkPe8NyZ+JOUU
         /p89rN1lukSZcw58x72jeXMHNIDd6cpm7QuweDshIWmlspo8Jw/uj6MzTMNyhjKAVQme
         +hYw==
X-Gm-Message-State: AOJu0YzEsaOR99gtJj671PuHADkAk7UFXOtxVcIA+XEnArs3ctu+wtHY
	qalq9KDpqmDiEFdDGJ+byUZ8nHZYfrPMRHeP9lUmeKNXvQlQK9Zh4tYlVgA5j+4R
X-Gm-Gg: AR+sD11HoCjo7Vem0Ck0U53FaNgyEn5XFBdHZYxBZDYVUH8Mmt4pI/M3hioH7FyYRNE
	iJd4JyTnUFDNN0/MAgcXQqj3n83a9ytnxWeXYJJFMV3RJX/Kdfc+KusEhpEo241WittnhjkKyfJ
	8wYshuE7uMrC3qLDg7zpV8a5pShKnzVn8psEQtbtdvqysKHL4ndqYP6zk3+GWB1cw70N1LJfs3E
	wt1AQZJKdCzwt5gvYbFPa9cqN2fhMcMpO3IVWqFD5BSg53P74JrxfAMVy+ZsxBQfm5hlVNoUBKT
	w5BnPG/5mvONaobTFZYF/LWFhB9APPvDkR1503enhklAthl7J79HAwVfoXjtrXsD8RAHeWnyyFM
	WrmnZGMASxOM/pk3sMsaw3bHjzwRmWDwjTvJxd1aPJKhSCPfydunfucDNwHRq6AxqAPBUe52bz/
	rxD9D90iqbn10s8OrXN5yZLX25eJ0B9Fgap+XBiSYcCYvfb3rlQUNAwS4dFtU=
X-Received: by 2002:a17:903:1a45:b0:2cc:bdb9:3c04 with SMTP id d9443c01a7336-2cf8dd6effamr14792505ad.17.1784665835150;
        Tue, 21 Jul 2026 13:30:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f0:1007:a448:f8a6:2886:f025:b749])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc193f8sm3902165eec.1.2026.07.21.13.30.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 13:30:34 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v10] show-branch: convert per-branch flags to commit-slab
Date: Wed, 22 Jul 2026 02:00:24 +0530
Message-ID: <20260721203025.85044-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqzezkw4zq.fsf@gitster.g>
References: <xmqqzezkw4zq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

show-branch uses commit->object.flags to store per-branch
reachability bits, one bit per branch starting at REV_SHIFT.
The flags word has only a fixed number of available bits, limiting
the number of branches that can be shown simultaneously.

Convert the per-branch bits to a dedicated commit-slab using uint64_t
as the element type, initialized with a stride via
init_commit_rev_flags_with_stride(). Keep the UNINTERESTING bit in
object.flags where it belongs, as it is used for revision walking and
does not need to be in the per-branch slab. With UNINTERESTING removed
from the slab, REV_SHIFT becomes 0 and all 64 bits of uint64_t are
available for branch tracking.

Add helper functions get_rev_flags_ptr(), peek_rev_flags_ptr(),
has_any_rev_flags(), or_rev_flag_bit(), test_rev_flag_bit(),
has_all_rev_flags(), has_only_rev_flag_bit(), and
has_subset_rev_flags() to encapsulate per-bit slab access cleanly.
Use has_only_rev_flag_bit() in show_independent() to preserve the
original semantics: a commit is independent only if reachable from
exactly one tip. Use has_subset_rev_flags() in join_revs() to skip
parents whose flags already include all of the current commit's flags,
avoiding redundant propagation and queue thrashing in dense histories.

Fix join_revs() to correctly propagate UNINTERESTING to parents using
a local commit_is_merge_base variable, without smudging the commit
itself, matching the original behavior.

Remove the hardcoded MAX_REVS limit entirely by dynamically growing
the ref_name[] array with ALLOC_GROW, and allocating rev[] and
reflog_msg[] dynamically after all refs are collected. Compute
flags_stride at runtime as (ref_name_cnt + 63) / 64 so the slab
supports an arbitrary number of branches.

Remove the hardcoded branch limit from documentation since there is
no longer a fixed maximum. Add tests to verify show-branch works
correctly with more than 27 branches. Include revision.h for the
shared UNINTERESTING definition.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

> Hmph. I hate to say this, but I am finding it difficult to trust
> your "carefully" at this point.
>
>     $ make
>     $ ./git show-branch master next
>     Floating point exception (core dumped).

You are right to not trust it. I missed this completely. I ran the
full test suite but did not run the binary manually before sending.
That was the wrong approach. I have now run every mode manually
before sending this version.

> The code simply discards the initialization for that slab, leaving
> name_slab BSS-initialized. Consequently, all members in the struct
> are initialized to 0, including the '.slab_size' member.
>
> This init_commit_name_slab() call is not moved elsewhere; it simply
> disappeared without an explanation.
>
> When commit_to_name() tries to look up a commit in the slab, it
> first attempts to determine which slab should contain the data for
> the commit... And we all know what would happen when you divide by zero.

Fixed. init_commit_name_slab(&name_slab) is restored before
repo_config(). It was removed in v7 without being moved elsewhere —
a clear oversight that I should have caught by running the binary.

As said above I ran every mode manually this time:

  $ ./git show-branch master
  $ ./git show-branch -a
  $ ./git show-branch --merge-base master origin/next
  $ ./git show-branch --independent master origin/next
  $ ./git show-branch --reflog master
  $ ./git show-branch --list master origin/next
  $ ./git show-branch --topics master origin/next
  $ make -C t t3202-show-branch.sh

All tests pass. No crashes in any mode.

---
Changes in v10:
- Restore init_commit_name_slab(&name_slab) before repo_config()
  that was accidentally dropped in v7. Without it, name_slab.slab_size
  is 0 causing division by zero on first commit lookup.

 Documentation/git-show-branch.adoc |   2 -
 builtin/show-branch.c              | 236 ++++++++++++++++++-----------
 t/t3202-show-branch.sh             |  32 ++++
 3 files changed, 179 insertions(+), 91 deletions(-)

diff --git a/Documentation/git-show-branch.adoc b/Documentation/git-show-branch.adoc
index 7e86d54a24..3df107b7f4 100644
--- a/Documentation/git-show-branch.adoc
+++ b/Documentation/git-show-branch.adoc
@@ -22,8 +22,6 @@ Shows the commit ancestry graph starting from the commits named
 with <rev>s or <glob>s (or all refs under refs/heads
 and/or refs/tags) semi-visually.
 
-It cannot show more than 26 branches and commits at a time.
-
 It uses `showbranch.default` multi-valued configuration items if
 no <rev> or <glob> is given on the command line.
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..4f02f0678e 100644
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
@@ -35,15 +36,11 @@ static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;
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
 #define DEFAULT_REFLOG	4
 
 static const char *get_color_code(int idx)
@@ -79,11 +76,87 @@ struct commit_name {
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
+
+static int has_subset_rev_flags(struct commit *src, struct commit *dst)
+{
+	uint64_t *s = peek_rev_flags_ptr(src);
+	uint64_t *d = peek_rev_flags_ptr(dst);
+	int i;
+	if (!s)
+		return 1; /* src has no flags, trivially a subset */
+	if (!d)
+		return 0; /* dst has no flags but src has some */
+	for (i = 0; i < flags_stride; i++)
+		if (s[i] & ~d[i])
+			return 0;
+	return 1;
+}
 
 /* Name the commit as nth generation ancestor of head_name;
  * we count only the first-parent relationship for naming purposes.
@@ -215,7 +288,7 @@ static void name_commits(struct commit_list *list,
 
 static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 {
-	if (!commit->object.flags) {
+	if (!has_any_rev_flags(commit)) {
 		commit_list_insert(commit, seen_p);
 		return 1;
 	}
@@ -226,39 +299,41 @@ static void join_revs(struct prio_queue *queue,
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
-		parents = commit->parents;
-
-		while (parents) {
-			struct commit *p = parents->item;
-			int this_flag = p->object.flags;
-			parents = parents->next;
-			if ((this_flag & flags) == flags)
-				continue;
-			repo_parse_commit(the_repository, p);
-			if (mark_seen(p, seen_p) && !still_interesting)
-				extra--;
-			p->object.flags |= flags;
-			if (get_pending)
-				prio_queue_replace(queue, p);
-			else
-				prio_queue_put(queue, p);
-			get_pending = false;
+		{
+			int commit_is_merge_base = has_all_rev_flags(commit, num_rev);
+			parents = commit->parents;
+
+			while (parents) {
+				struct commit *p = parents->item;
+				int _b;
+				parents = parents->next;
+				if (has_subset_rev_flags(commit, p) &&
+				    (!commit_is_merge_base || (p->object.flags & UNINTERESTING)))
+					continue;
+				repo_parse_commit(the_repository, p);
+				if (mark_seen(p, seen_p) && !still_interesting)
+					extra--;
+				for (_b = 0; _b < num_rev; _b++)
+					if (test_rev_flag_bit(commit, _b))
+						or_rev_flag_bit(p, _b);
+				if (commit_is_merge_base)
+					p->object.flags |= UNINTERESTING;
+				if (get_pending)
+					prio_queue_replace(queue, p);
+				else
+					prio_queue_put(queue, p);
+				get_pending = false;
+			}
 		}
 		if (get_pending)
 			prio_queue_get(queue);
@@ -278,7 +353,7 @@ static void join_revs(struct prio_queue *queue,
 			struct commit *c = s->item;
 			struct commit_list *parents;
 
-			if (((c->object.flags & all_revs) != all_revs) &&
+			if (!has_all_rev_flags(c, num_rev) &&
 			    !(c->object.flags & UNINTERESTING))
 				continue;
 
@@ -335,8 +410,9 @@ static void show_one_commit(struct commit *commit, int no_name)
 	strbuf_release(&pretty);
 }
 
-static char *ref_name[MAX_REVS + 1];
+static char **ref_name;
 static int ref_name_cnt;
+static int ref_name_alloc;
 
 static const char *find_digit_prefix(const char *s, int *v)
 {
@@ -409,12 +485,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
 			if (!strcmp(refname, ref_name[i]))
 				return 0;
 	}
-	if (MAX_REVS <= ref_name_cnt) {
-		warning(Q_("ignoring %s; cannot handle more than %d ref",
-			   "ignoring %s; cannot handle more than %d refs",
-			   MAX_REVS), refname, MAX_REVS);
-		return 0;
-	}
+	ALLOC_GROW(ref_name, ref_name_cnt + 2, ref_name_alloc);
 	ref_name[ref_name_cnt++] = xstrdup(refname);
 	ref_name[ref_name_cnt] = NULL;
 	return 0;
@@ -511,15 +582,12 @@ static int rev_is_head(const char *head, const char *name)
 
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
@@ -528,17 +596,13 @@ static int show_merge_base(const struct commit_list *seen, int num_rev)
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
@@ -560,8 +624,7 @@ static void append_one_rev(const char *av)
 		match_ref_slash = count_slashes(av);
 		refs_for_each_ref(get_main_ref_store(the_repository),
 				  append_matching_ref, NULL);
-		if (saved_matches == ref_name_cnt &&
-		    ref_name_cnt < MAX_REVS)
+		if (saved_matches == ref_name_cnt)
 			error(_("no matching refs with %s"), av);
 		sort_ref_range(saved_matches, ref_name_cnt);
 		return;
@@ -603,13 +666,12 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
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
@@ -644,14 +706,12 @@ int cmd_show_branch(int ac,
 		const char *prefix,
 		struct repository *repo UNUSED)
 {
-	struct commit *rev[MAX_REVS], *commit;
-	char *reflog_msg[MAX_REVS] = {0};
+	struct commit **rev = NULL, *commit;
+	char **reflog_msg = NULL;
 	struct commit_list *seen = NULL;
 	struct prio_queue queue = { compare_commits_by_commit_date };
-	unsigned int rev_mask[MAX_REVS];
 	int num_rev, i, extra = 0;
 	int all_heads = 0, all_remotes = 0;
-	int all_mask, all_revs;
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
 	char *head;
 	struct object_id head_oid;
@@ -712,9 +772,7 @@ int cmd_show_branch(int ac,
 	};
 	const char **args_copy = NULL;
 	int ret;
-
 	init_commit_name_slab(&name_slab);
-
 	repo_config(the_repository, git_show_branch_config, NULL);
 
 	/* If nothing is specified, try the default first */
@@ -728,6 +786,8 @@ int cmd_show_branch(int ac,
 			   show_branch_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (all_heads)
 		all_remotes = 1;
+	if (reflog)
+		CALLOC_ARRAY(reflog_msg, reflog + 1);
 
 	if (extra || reflog) {
 		/* "listing" mode is incompatible with
@@ -754,7 +814,6 @@ int cmd_show_branch(int ac,
 	/* If nothing is specified, show all branches by default */
 	if (ac <= topics && all_heads + all_remotes == 0)
 		all_heads = 1;
-
 	if (reflog) {
 		struct object_id oid;
 		char *ref;
@@ -777,11 +836,6 @@ int cmd_show_branch(int ac,
 		}
 		if (ac != 1)
 			die(_("--reflog option needs one branch name"));
-
-		if (MAX_REVS < reflog)
-			die(Q_("only %d entry can be shown at one time.",
-			       "only %d entries can be shown at one time.",
-			       MAX_REVS), MAX_REVS);
 		if (!repo_dwim_ref(the_repository, *av, strlen(*av), &oid,
 				   &ref, 0))
 			die(_("no such ref %s"), *av);
@@ -868,14 +922,18 @@ int cmd_show_branch(int ac,
 		goto out;
 	}
 
+	flags_stride = (ref_name_cnt + 63) / 64;
+	if (!flags_stride)
+		flags_stride = 1;
+	init_commit_rev_flags_with_stride(&rev_flags_slab, flags_stride);
+	CALLOC_ARRAY(rev, ref_name_cnt);
+	if (!reflog_msg)
+		CALLOC_ARRAY(reflog_msg, ref_name_cnt);
+
 	for (num_rev = 0; ref_name[num_rev]; num_rev++) {
 		struct object_id revkey;
-		unsigned int flag = 1u << (num_rev + REV_SHIFT);
+		int first_seen;
 
-		if (MAX_REVS <= num_rev)
-			die(Q_("cannot handle more than %d rev.",
-			       "cannot handle more than %d revs.",
-			       MAX_REVS), MAX_REVS);
 		if (repo_get_oid(the_repository, ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
 		commit = lookup_commit_reference(the_repository, &revkey);
@@ -885,17 +943,15 @@ int cmd_show_branch(int ac,
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
@@ -908,7 +964,7 @@ int cmd_show_branch(int ac,
 	}
 
 	if (independent) {
-		ret = show_independent(rev, num_rev, rev_mask);
+		ret = show_independent(rev, num_rev);
 		goto out;
 	}
 
@@ -958,13 +1014,9 @@ int cmd_show_branch(int ac,
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
 
@@ -973,14 +1025,14 @@ int cmd_show_branch(int ac,
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
@@ -1006,10 +1058,16 @@ int cmd_show_branch(int ac,
 	ret = 0;
 
 out:
-	for (size_t i = 0; i < ARRAY_SIZE(reflog_msg); i++)
+	for (i = 0; i < ref_name_cnt; i++)
 		free(reflog_msg[i]);
+	free(reflog_msg);
+	free(rev);
+	for (i = 0; i < ref_name_cnt; i++)
+		free(ref_name[i]);
+	free(ref_name);
 	commit_list_free(seen);
 	clear_prio_queue(&queue);
+	clear_commit_rev_flags(&rev_flags_slab);
 	free(args_copy);
 	free(head);
 	return ret;
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index a1139f79e2..d04f642998 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -283,4 +283,36 @@ test_expect_success '--reflog handles missing reflog' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'show-branch with 30 branches succeeds' '
+	git checkout initial &&
+	for i in $(test_seq 11 30)
+	do
+		git checkout -b branch$i initial &&
+		test_commit --no-tag branch$i || return 1
+	done &&
+	git show-branch $(git for-each-ref \
+		--sort=version:refname \
+		--format="%(refname:strip=2)" \
+		"refs/heads/branch*") >actual &&
+	test_line_count -ge 30 actual
+'
+
+test_expect_success 'show-branch --independent with 30 branches' '
+	git show-branch --independent $(git for-each-ref \
+		--sort=version:refname \
+		--format="%(refname:strip=2)" \
+		"refs/heads/branch*") >actual &&
+	test_line_count -ge 30 actual
+'
+
+test_expect_success 'show-branch --merge-base with 30 branches' '
+	git rev-parse initial >expect &&
+	git show-branch --merge-base $(git for-each-ref \
+		--sort=version:refname \
+		--format="%(refname:strip=2)" \
+		"refs/heads/branch*") >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
-- 
2.54.0

