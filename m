Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A543DD86F
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274156; cv=none; b=ha+bMpNm5a785ZfAu++1EPIVt7E1bpKLLPWu805oBzwS6e9sAJEaQoBE0MDdQVIBz2cX+tpIXFjC7sNkDaYfh1jRPxGAOsov6lhwmwtMl1mN028+SjvAqQAsQJuD3qpseZ1CuGW3p6Bk4K8lKUIBELWxtl4N4q2CmzDPfETNkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274156; c=relaxed/simple;
	bh=CkDfxeY7yqVZcsTLzFrK9Nu4bdQFwm/QvtR8mDfQVpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3rGJrIr0a4QbNZ8q0ct4Osq1aBVrRD6qwMSrkYogCkiXicxSSDbVNQmIbzOE7lAe6pU5FXgMU09D/wwxDq6o60kyeHUW4DZ9xP4HPb4MmAee5zZ0hNyqrMB/SyyajV8M/Paccm8F5FpOkEwwFfAg5It8fYA0jq3dF8BwkLZA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSFY3e9L; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSFY3e9L"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c001628so4657864a12.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784274141; x=1784878941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=214O2mQ/9/bfhdgxCIhxO85vTzAC15DPnMFOwgw6wa0=;
        b=RSFY3e9Laf1hVcTvJzOm1tcJNWg59Uyn0X3smZtWu6yReknZXbnWctNTr3ZwxSrLzK
         evFVCUHLHBt9OVMZSeu378ge3GmhHMuqEKJX3344Uxgsnuc2Ezl79RjlEQ3nGImqHt0b
         Y7vBKrtS+EFbwUFH3K+bzqpB1zJDz8YR/Nj0zSp3wXyH+jgKtln8z617MgUP2F7054Ni
         057ny8/3DAUC1YZJclSbv+VTWCn4cHbl2b3N7K7hYPK84CSjZQkItUlR3h0eA3Spmy69
         +EL/uwjxuKRq8H7RpFAtc4AOXRg3U9dHPOoNPSgHf1bcE0HcezhyS21J+a/kQhg4jTqW
         CS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784274141; x=1784878941;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=214O2mQ/9/bfhdgxCIhxO85vTzAC15DPnMFOwgw6wa0=;
        b=sciyo1TsY4ortEuwphhCsPgkKp7VSRZA3gixDp0tlWoShEJOK9Ry96yqEo8Of524JN
         Mb2WcyDUME2TS0snGinrPpt75mybBNVVlbSVrlbSGBtZztQIa/klDzkMW64Twxbcu44k
         TSXGn5QbVHhmCANdFA7mif17cmwl3aXe7T3OPioBsesl/s7ngdzNl2T316Ga8PVisFZB
         R5HlP3PNGnR8F/r8RaeN32K53CXhnkXnYyxbI5ryGSXqb4eNBgj5FRT6UNKARHuoP8mS
         sKEyF9bPW0V/ucwQ8g/g/LAa5ZxKtTSEObiIkoCC0f4NzwcmOMLzRynFct3D+G8W+60Q
         oLFw==
X-Gm-Message-State: AOJu0YwvXXJV/g3AZzUO3OJS6pVWlJzaMF6k99IESRaI/Zqq7MX/MCNw
	hHw7iYcIXBW5+YNgJuZOv33bjaS+EaXPDpXVbkgdpI9lhKDd34q8CSQDReLGffUC2CY=
X-Gm-Gg: AfdE7cmp+EflRndM0CDioActr5NdRwQpfzPORZABHFjyvC9+OGvZVVh2Rp7pJkhPyD8
	BT0gDj20BUE9z6PhVp8b9PENkhryr2jz8KG/vSvarMdtqvZxBhXbtTjTJL8eSASMI24RS8ARMy9
	6ZnAdrhEAAQiw5cxHPCDxLKuL9EaAuAz3K1ngRrbfJo+yRLJEfDyeUjw49No91q+ZFCZkw21HRp
	6/8C8poD4TCcoOkRC8tc6IrYWThCk4ruo1GPW1ZxAs621qhs3AFV9F3WGSDH0wA+n4x3yCUbTIV
	XiqGFRv8HofC5jzE96THF3mleyQliODOsR45Kfhp79M3drcWoaH4AwYGRSlSnCCY1mLO5ANKrx6
	pb4H+obj9JkqVWmnTn1yCSsGBK0Se/p2icbgdHxrADvDrBSOXNQcFCrjeRVjTv2Ksmj+H61br3b
	Y65Gw8Otz9hr0CRsbq7oVISQ/RQO27YItp/TPtTGwvlMW+gWI=
X-Received: by 2002:a05:6a21:a8d:b0:3c3:a490:9674 with SMTP id adf61e73a8af0-3c3ada8c6e1mr1619843637.64.1784274140560;
        Fri, 17 Jul 2026 00:42:20 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dde81sm7117226eec.21.2026.07.17.00.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 00:42:19 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v7] show-branch: convert per-branch flags to commit-slab
Date: Fri, 17 Jul 2026 13:12:06 +0530
Message-ID: <20260717074208.61303-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqfr1i6tqu.fsf@gitster.g>
References: <xmqqfr1i6tqu.fsf@gitster.g>
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

Update documentation to remove the hardcoded branch limit. Add tests
to verify show-branch works correctly with more than 27 branches.
Include revision.h for the shared UNINTERESTING definition.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

Thank you very much for the thorough and insightful review —
the performance observation about subset checking and the
suggestion to remove MAX_REVS entirely were both excellent
points that significantly improve this patch.

> With the new slab-based approach, we skip only when 'p' already
> has all possible revision flags, num_rev. If 'p' already carries
> all the flags that the current 'commit' has (even if it lacks some
> of the other num_rev flags), the traversal could be pruned early,
> but the proposed change fails to do so. Consequently, we proceed
> to propagate the flags (which amounts to a no-op on the slab
> anyway) and, worse, re-queue 'p' for further processing. In a
> densely tangled history with many merges, this would lead to
> significant redundant work and queue thrashing. We instead should
> check whether the flags of 'commit' are a subset of those of 'p'.
> Since the flags_stride is known, introducing a helper, perhaps
> has_subset_rev_flags(commit, p), to perform this check should be
> a straightforward exercise.

Done. Added has_subset_rev_flags(src, dst) which checks whether
every bit set in src's slab words is also set in dst's slab words
using word-level (src[i] & ~dst[i]) == 0 checks across all
flags_stride words. The parent skip condition in join_revs() now
uses this helper:

    if (has_subset_rev_flags(commit, p) &&
        (!commit_is_merge_base || (p->object.flags & UNINTERESTING)))
            continue;

This avoids re-queuing parents that already carry all of the current
commit's reachability bits, preventing redundant propagation and
queue thrashing in dense histories.

> While lifting the limit from 27 to 64 is a welcome improvement,
> I wonder why we stop there and still tolerate a hardcoded MAX_REVS
> limit.

Agreed. MAX_REVS is removed entirely in v7.

> The introduction of flags_stride and
> init_commit_rev_flags_with_stride already lays the groundwork for
> supporting an arbitrary number of flags. The only remaining
> blockages that keep MAX_REVS alive are:
>  - The static ref_name[] array; and
>  - The stack-allocated arrays rev[] and reflog_msg[] in the
>    cmd_show_branch() function.

> If we
>  - dynamically grow the ref_name[] array (perhaps using the
>    ALLOC_GROW macro),
>  - dynamically allocate rev[] and reflog_msg[] in cmd_show_branch()
>    once options are parsed (and thus ref_name_cnt and the reflog
>    flag are known), and
>  - calculate flags_stride at runtime as (ref_name_cnt + 63) / 64,
> then we can get rid of MAX_REVS and the associated boundary checks
> entirely.

All three steps implemented in v7:
- ref_name[] is now a dynamically grown pointer array using
  ALLOC_GROW(ref_name, ref_name_cnt + 2, ref_name_alloc)
- rev[] and reflog_msg[] are allocated with CALLOC_ARRAY after
  all refs are collected and ref_name_cnt is known
- flags_stride is computed at runtime as (ref_name_cnt + 63) / 64

MAX_REVS and all associated boundary checks are removed.

> Since the proposed patch already does 90% of the work needed to
> support an arbitrary stride, it feels like a missed opportunity
> not to take that final step.
>
> Thoughts?

Fully agreed — taking that final step makes the patch complete and
removes a limitation that was only there due to the original
object.flags approach. v7 does exactly that.

---
Changes in v7:
- Add has_subset_rev_flags() and use it in join_revs() to skip
  parents that already carry all of commit's reachability bits,
  avoiding redundant propagation and queue thrashing (Junio)
- Remove MAX_REVS entirely; grow ref_name[] dynamically with
  ALLOC_GROW; allocate rev[] and reflog_msg[] dynamically after
  ref collection; compute flags_stride at runtime (Junio)

 Documentation/git-show-branch.adoc |   2 +-
 builtin/show-branch.c              | 234 ++++++++++++++++++-----------
 t/t3202-show-branch.sh             |  32 ++++
 3 files changed, 180 insertions(+), 88 deletions(-)

diff --git a/Documentation/git-show-branch.adoc b/Documentation/git-show-branch.adoc
index 7e86d54a24..fe65c0a95a 100644
--- a/Documentation/git-show-branch.adoc
+++ b/Documentation/git-show-branch.adoc
@@ -22,7 +22,7 @@ Shows the commit ancestry graph starting from the commits named
 with <rev>s or <glob>s (or all refs under refs/heads
 and/or refs/tags) semi-visually.
 
-It cannot show more than 26 branches and commits at a time.
+It cannot show more than 64 branches and commits at a time.
 
 It uses `showbranch.default` multi-valued configuration items if
 no <rev> or <glob> is given on the command line.
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..4f49a8d05b 100644
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
@@ -226,39 +299,43 @@ static void join_revs(struct prio_queue *queue,
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
+				parents = parents->next;
+				if (has_subset_rev_flags(commit, p) &&
+				    (!commit_is_merge_base || (p->object.flags & UNINTERESTING)))
+					continue;
+				repo_parse_commit(the_repository, p);
+				if (mark_seen(p, seen_p) && !still_interesting)
+					extra--;
+				{
+					int _b;
+					for (_b = 0; _b < num_rev; _b++)
+						if (test_rev_flag_bit(commit, _b))
+							or_rev_flag_bit(p, _b);
+				}
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
@@ -278,7 +355,7 @@ static void join_revs(struct prio_queue *queue,
 			struct commit *c = s->item;
 			struct commit_list *parents;
 
-			if (((c->object.flags & all_revs) != all_revs) &&
+			if (!has_all_rev_flags(c, num_rev) &&
 			    !(c->object.flags & UNINTERESTING))
 				continue;
 
@@ -335,8 +412,9 @@ static void show_one_commit(struct commit *commit, int no_name)
 	strbuf_release(&pretty);
 }
 
-static char *ref_name[MAX_REVS + 1];
+static char **ref_name;
 static int ref_name_cnt;
+static int ref_name_alloc;
 
 static const char *find_digit_prefix(const char *s, int *v)
 {
@@ -409,12 +487,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
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
@@ -511,15 +584,12 @@ static int rev_is_head(const char *head, const char *name)
 
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
@@ -528,17 +598,13 @@ static int show_merge_base(const struct commit_list *seen, int num_rev)
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
@@ -560,8 +626,7 @@ static void append_one_rev(const char *av)
 		match_ref_slash = count_slashes(av);
 		refs_for_each_ref(get_main_ref_store(the_repository),
 				  append_matching_ref, NULL);
-		if (saved_matches == ref_name_cnt &&
-		    ref_name_cnt < MAX_REVS)
+		if (saved_matches == ref_name_cnt)
 			error(_("no matching refs with %s"), av);
 		sort_ref_range(saved_matches, ref_name_cnt);
 		return;
@@ -603,13 +668,12 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
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
@@ -644,14 +708,12 @@ int cmd_show_branch(int ac,
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
@@ -713,8 +775,6 @@ int cmd_show_branch(int ac,
 	const char **args_copy = NULL;
 	int ret;
 
-	init_commit_name_slab(&name_slab);
-
 	repo_config(the_repository, git_show_branch_config, NULL);
 
 	/* If nothing is specified, try the default first */
@@ -778,10 +838,7 @@ int cmd_show_branch(int ac,
 		if (ac != 1)
 			die(_("--reflog option needs one branch name"));
 
-		if (MAX_REVS < reflog)
-			die(Q_("only %d entry can be shown at one time.",
-			       "only %d entries can be shown at one time.",
-			       MAX_REVS), MAX_REVS);
+
 		if (!repo_dwim_ref(the_repository, *av, strlen(*av), &oid,
 				   &ref, 0))
 			die(_("no such ref %s"), *av);
@@ -868,14 +925,17 @@ int cmd_show_branch(int ac,
 		goto out;
 	}
 
+	flags_stride = (ref_name_cnt + 63) / 64;
+	if (!flags_stride)
+		flags_stride = 1;
+	init_commit_rev_flags_with_stride(&rev_flags_slab, flags_stride);
+	CALLOC_ARRAY(rev, ref_name_cnt);
+	CALLOC_ARRAY(reflog_msg, ref_name_cnt);
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
@@ -885,17 +945,15 @@ int cmd_show_branch(int ac,
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
@@ -908,7 +966,7 @@ int cmd_show_branch(int ac,
 	}
 
 	if (independent) {
-		ret = show_independent(rev, num_rev, rev_mask);
+		ret = show_independent(rev, num_rev);
 		goto out;
 	}
 
@@ -958,13 +1016,9 @@ int cmd_show_branch(int ac,
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
 
@@ -973,14 +1027,14 @@ int cmd_show_branch(int ac,
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
@@ -1006,10 +1060,16 @@ int cmd_show_branch(int ac,
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

