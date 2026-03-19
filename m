Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D03E9F95
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959073; cv=none; b=LCrcB8q/NYO2WZUnDJMLwfIx6o5nEnvoLLNTd942pxyVDT+pUIWnOgh4WxvbEITdHR4xq3kpj29Dib5Y7zpH3sUmpFAPvMasR2bgrZKr5xKsQQHygvm49UbPE+cTHf1ddx4GGJ1GG6UeAHV/f81T3XI9fDd+fzpM+GW7+vAXI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959073; c=relaxed/simple;
	bh=o2CmMEAaUU2Gf3tMZBhHuBtLORlxyBH6GRmJiIDN0qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYGY/w29+0TYhGO3baXFePh8e4hwMHfZxEFicRLyRlWGZpmEL0G1fkz3gUDscrJ9DdtXtm7Jsqrqjgv/2fpMHTccHkhOJ+55JXEi2rfntKT82qnOkPndMFcsOU5A3Om28Hbdn4RMxRrayJmVXZ4GlId50vPhYq3vln/tbe9yROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Q7vSYZcP; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Q7vSYZcP"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-79a40fb9890so1044907b3.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773959067; x=1774563867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dY7s2MdJULjLx8seaAMwxdFtYKmpTivJ9sO80iYGO0Q=;
        b=Q7vSYZcPktKsFsUnm9EcxOzQeB6TZSRgPr5uaSpi3W5eWZux56lGA+HxigTyG11zHI
         ClCQKFF8uueIb6gZt6CHzrKkheiIgjMkmI7vlPYQEHcdCWLwiQE3SCjan901i5PWa+HJ
         o1QYlUmUNMXJ+z3OiLOJg8oJqbFlF+Yy1QrhJYEoNNe78gLe27n+6zGJZ+T2CG3AtUst
         zwW/pyY4Z7SvY52VJN+7bDaMNHTSpt/0fo9bqe8mr2uXZJru9NhkfYuL33htRYq7zgSr
         9Q8+Za1ByahAcqQ+KkgdKqCAF+da+e9MvSUEGqmOSuFrV7ewDPC9j57P5H9po++4Jv9r
         hiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773959067; x=1774563867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY7s2MdJULjLx8seaAMwxdFtYKmpTivJ9sO80iYGO0Q=;
        b=YulDW94N2MuEyiJNijsFWBOyVpPI+CBAth5btPBmvy37Kl1i3O47WBDD7MiS4G4Cg9
         zdOqrBMJvD6Rpu1jt6ejEDHKA3ERVNPkeuSDePZJpCZ0PG61D2hqjAbUJSts9SDbVMw6
         GPqUiuk9HUwkJrvGOfUbogk38laymPdbmabiGFx3tColKPtflG70MASjn9LMNngJXzpO
         mdlIfAnSnksdn5yMzeQy3Kp9z2QH/xXUBRScExcuz4rIFSW1+5hK3oNZB7HwNEW4s84Q
         sowvIaBfL4Rk0mNXz8BjXzdxENN3QQhEf8RGeMIKSoqyc2bGE6f9Gvcee/MSRBwVmep3
         8rCA==
X-Gm-Message-State: AOJu0YxUEtP0q5ZXpAiwlzfDefhdVVg8zpTZ8Vl5/yjvSBeJI7pxqM+v
	bQHt7nOGDBuWOsHmXMIKcSEyJJ7jUo7jo4Dru8peGC8q+X+UoFucda4118FsxpEBXDBaXt8I+Vn
	/h9R8ugxnwmWW
X-Gm-Gg: ATEYQzzNOWe9DgUwqSAzpd2zzJ0auMA9/W13va4PSEbsQ5L2dip9LNstkIEk5dDg5zU
	JkVyUrr49Ud85D+l0uGJNQicgjgrFLVlsxTWJp4/Tp5k76DOeiiTOI0ZXINaeK7SlstFmEBGgOv
	isVaYh3dSbtmN3OUYHZ2+/z8NqRPSfH2qmU3bNocHkrPmt5OtF7N6yHptY/mrXZ5AA5xDBWtbH8
	b+p99bLthEgt6DEmVxUF5AXF8HUGoINrJ3jdqSzbYY1sOI1v/HjZ1Ucpoa40KMuVhyEEICcGdv2
	XYa/GAyzXzOSjCzwEb0399hd2JXfr9eRveoYq1pGLNtGN3zjAfVct78+uj/0/u8nvc5yGDxM2H6
	kt1gQElK+ZGvGApNMcr2Z8iHBNqA//CZ5puD/RgkCd/lKJQMyeLp2RSQSbS3/45ZN5+nNd0ahKN
	RR03D7V8RMmjCYEFZe9wiWyv2SQRZ+44DEZByYXJ7ZcUdAmCrmoJ25jlaFIIFZP22drwQbS691m
	Uwbi7wqK6MqDZRx6xdJr861vGL/Zw==
X-Received: by 2002:a05:690c:81:b0:79a:5a8c:7a1c with SMTP id 00721157ae682-79a90afb6ecmr9907137b3.21.1773959066557;
        Thu, 19 Mar 2026 15:24:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a905bf186sm5036737b3.48.2026.03.19.15.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:24:26 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:24:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/5] pack-objects: support excluded-open packs with
 --stdin-packs
Message-ID: <bd78919e19cfa968556ad4241391120ed56e9dce.1773959041.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1773959041.git.me@ttaylorr.com>

In cd846bacc7d (pack-objects: introduce '--stdin-packs=follow',
2025-06-23), pack-objects learned to traverse through commits in
included packs when using '--stdin-packs=follow', rescuing reachable
objects from unlisted packs into the output.

When we encounter a commit in an excluded pack during this rescuing
phase we will traverse through its parents. But because we set
`revs.no_kept_objects = 1`, commit simplification will prevent us from
showing it via `get_revision()`. (In practice, `--stdin-packs=follow`
walks commits down to the roots, but only opens up trees for ones that
do not appear in an excluded pack.)

But there are certain cases where we *do* need to see the parents of an
object in an excluded pack. Namely, if an object is rescue-able, but
only reachable from object(s) which appear in excluded packs, then
commit simplification will exclude those commits from the object
traversal, and we will never see a copy of that object, and thus not
rescue it.

This is what causes the failure in the previous commit during repacking.
When performing a geometric repack, packs above the geometric split that
weren't part of the previous MIDX (e.g., packs pushed directly into
`$GIT_DIR/objects/pack`) may not have full object closure.  When those
packs are listed as excluded via the '^' marker, the reachability
traversal encounters the sequence described above, and may miss objects
which we expect to rescue with `--stdin-packs=follow`.

Introduce a new "excluded-open" pack prefix, '!'. Like '^'-prefixed
packs, objects from '!'-prefixed packs are excluded from the resulting
pack. But unlike '^', commits in '!'-prefixed packs *are* used as
starting points for the follow traversal, and the traversal does not
treat them as a closure boundary.

In order to distinguish excluded-closed from excluded-open packs during
the traversal, introduce a new `pack_keep_in_core_open` bit on
`struct packed_git`, along with a corresponding `KEPT_PACK_IN_CORE_OPEN`
flag for the kept-pack cache.

In `add_object_entry_from_pack()`, move the `want_object_in_pack()`
check to *after* `add_pending_oid()`. This is necessary so that commits
from excluded-open packs are added as traversal tips even though their
objects won't appear in the output. The `include_check` and
`include_check_obj` callbacks on `rev_info` are used to halt the walk at
closed-excluded packs, since objects behind a '^' boundary are
guaranteed to have closure and need not be rescued.

The following commit will make use of this new functionality within the
repack layer to resolve the test failure demonstrated in the previous
commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  25 +++++--
 builtin/pack-objects.c              |  87 ++++++++++++++++++++---
 packfile.c                          |   3 +-
 packfile.h                          |   2 +
 t/t5331-pack-objects-stdin.sh       | 105 ++++++++++++++++++++++++++++
 5 files changed, 203 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 71b9682485c..b78175fbe1b 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -94,13 +94,24 @@ base-name::
 	included packs (those not beginning with `^`), excluding any
 	objects listed in the excluded packs (beginning with `^`).
 +
-When `mode` is "follow", objects from packs not listed on stdin receive
-special treatment. Objects within unlisted packs will be included if
-those objects are (1) reachable from the included packs, and (2) not
-found in any excluded packs. This mode is useful, for example, to
-resurrect once-unreachable objects found in cruft packs to generate
-packs which are closed under reachability up to the boundary set by the
-excluded packs.
+When `mode` is "follow" packs may additionally be prefixed with `!`,
+indicating that they are excluded but not necessarily closed under
+reachability.  In addition to objects in included packs, the resulting
+pack may include additional objects based on the following:
++
+--
+* If any packs are marked with `!`, then objects reachable from such
+  packs or included ones via objects outside of excluded-closed packs
+  will be included. In this case, all `^` packs are treated as closed
+  under reachability.
+* Otherwise (if there are no `!` packs), objects within unlisted packs
+  will be included if those objects are (1) reachable from the
+  included packs, and (2) not found in any excluded packs.
+--
++
+This mode is useful, for example, to resurrect once-unreachable
+objects found in cruft packs to generate packs which are closed under
+reachability up to the boundary set by the excluded packs.
 +
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 72c9ddbed6b..0d25a856717 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -217,6 +217,7 @@ static int have_non_local_packs;
 static int incremental;
 static int ignore_packed_keep_on_disk;
 static int ignore_packed_keep_in_core;
+static int ignore_packed_keep_in_core_open;
 static int ignore_packed_keep_in_core_has_cruft;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
@@ -1618,7 +1619,8 @@ static int want_found_object(const struct object_id *oid, int exclude,
 	/*
 	 * Then handle .keep first, as we have a fast(er) path there.
 	 */
-	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core) {
+	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core ||
+	    ignore_packed_keep_in_core_open) {
 		/*
 		 * Set the flags for the kept-pack cache to be the ones we want
 		 * to ignore.
@@ -1632,6 +1634,8 @@ static int want_found_object(const struct object_id *oid, int exclude,
 			flags |= KEPT_PACK_ON_DISK;
 		if (ignore_packed_keep_in_core)
 			flags |= KEPT_PACK_IN_CORE;
+		if (ignore_packed_keep_in_core_open)
+			flags |= KEPT_PACK_IN_CORE_OPEN;
 
 		/*
 		 * If the object is in a pack that we want to ignore, *and* we
@@ -1643,6 +1647,8 @@ static int want_found_object(const struct object_id *oid, int exclude,
 				return 0;
 			if (ignore_packed_keep_in_core && p->pack_keep_in_core)
 				return 0;
+			if (ignore_packed_keep_in_core_open && p->pack_keep_in_core_open)
+				return 0;
 			if (has_object_kept_pack(p->repo, oid, flags))
 				return 0;
 		} else {
@@ -3750,8 +3756,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	ofs = nth_packed_object_offset(p, pos);
-	if (!want_object_in_pack(oid, 0, &p, &ofs))
-		return 0;
 
 	if (p) {
 		struct object_info oi = OBJECT_INFO_INIT;
@@ -3763,15 +3767,26 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		} else if (type == OBJ_COMMIT) {
 			struct rev_info *revs = _data;
 			/*
-			 * commits in included packs are used as starting points for the
-			 * subsequent revision walk
+			 * commits in included packs are used as starting points
+			 * for the subsequent revision walk
+			 *
+			 * Note that we do want to walk through commits that are
+			 * present in excluded-open ('!') packs to pick up any
+			 * objects reachable from them not present in the
+			 * excluded-closed ('^') packs.
+			 *
+			 * However, we'll only add those objects to the packing
+			 * list after checking `want_object_in_pack()` below.
 			 */
 			add_pending_oid(revs, NULL, oid, 0);
 		}
-
-		stdin_packs_found_nr++;
 	}
 
+	if (!want_object_in_pack(oid, 0, &p, &ofs))
+		return 0;
+
+	stdin_packs_found_nr++;
+
 	create_object_entry(oid, type, 0, 0, 0, p, ofs);
 
 	return 0;
@@ -3838,11 +3853,23 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 		return 0;
 }
 
+static int stdin_packs_include_check_obj(struct object *obj, void *data UNUSED)
+{
+	return !has_object_kept_pack(to_pack.repo, &obj->oid,
+				     KEPT_PACK_IN_CORE);
+}
+
+static int stdin_packs_include_check(struct commit *commit, void *data)
+{
+	return stdin_packs_include_check_obj((struct object *)commit, data);
+}
+
 struct stdin_pack_info {
 	struct packed_git *p;
 	enum {
 		STDIN_PACK_INCLUDE = (1<<0),
 		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
+		STDIN_PACK_EXCLUDE_OPEN = (1<<2),
 	} kind;
 };
 
@@ -3874,7 +3901,19 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 		if (!info->p)
 			die(_("could not find pack '%s'"), item->string);
 
-		if (info->kind & STDIN_PACK_INCLUDE)
+		if (info->kind & STDIN_PACK_EXCLUDE_OPEN) {
+			/*
+			 * When open-excluded packs ("!") are present, stop
+			 * the parent walk at closed-excluded ("^") packs.
+			 * Objects behind a "^" boundary are guaranteed to
+			 * have closure and should not be rescued.
+			 */
+			revs->include_check = stdin_packs_include_check;
+			revs->include_check_obj = stdin_packs_include_check_obj;
+		}
+
+		if ((info->kind & STDIN_PACK_INCLUDE) ||
+		    (info->kind & STDIN_PACK_EXCLUDE_OPEN))
 			for_each_object_in_pack(info->p,
 						add_object_entry_from_pack,
 						revs,
@@ -3884,7 +3923,8 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 	string_list_clear(&keys, 0);
 }
 
-static void stdin_packs_read_input(struct rev_info *revs)
+static void stdin_packs_read_input(struct rev_info *revs,
+				   enum stdin_packs_mode mode)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strmap packs = STRMAP_INIT;
@@ -3897,7 +3937,8 @@ static void stdin_packs_read_input(struct rev_info *revs)
 		if (!key || !*key)
 			continue;
 
-		if (*key == '^')
+		if (*key == '^' ||
+		    (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW))
 			key++;
 
 		info = strmap_get(&packs, key);
@@ -3908,6 +3949,8 @@ static void stdin_packs_read_input(struct rev_info *revs)
 
 		if (*buf.buf == '^')
 			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
+		else if (*buf.buf == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
+			info->kind |= STDIN_PACK_EXCLUDE_OPEN;
 		else
 			info->kind |= STDIN_PACK_INCLUDE;
 
@@ -3945,6 +3988,20 @@ static void stdin_packs_read_input(struct rev_info *revs)
 			p->pack_keep_in_core = 1;
 		}
 
+		if (info->kind & STDIN_PACK_EXCLUDE_OPEN) {
+			/*
+			 * Marking excluded open packs as kept in-core
+			 * (open) for the same reason as we marked
+			 * exclude closed packs as kept in-core.
+			 *
+			 * Use a separate flag here to ensure we don't
+			 * halt our traversal at these packs, since they
+			 * are not guaranteed to have closure.
+			 *
+			 */
+			p->pack_keep_in_core_open = 1;
+		}
+
 		info->p = p;
 	}
 
@@ -3988,7 +4045,15 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 
 	/* avoids adding objects in excluded packs */
 	ignore_packed_keep_in_core = 1;
-	stdin_packs_read_input(&revs);
+	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+		/*
+		 * In '--stdin-packs=follow' mode, additionally ignore
+		 * objects in excluded-open packs to prevent them from
+		 * appearing in the resulting pack.
+		 */
+		ignore_packed_keep_in_core_open = 1;
+	}
+	stdin_packs_read_input(&revs, mode);
 	if (rev_list_unpacked)
 		add_unreachable_loose_objects(&revs);
 
diff --git a/packfile.c b/packfile.c
index 215a23e42be..076e444e32a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2246,7 +2246,8 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *st
 			struct packed_git *p = e->pack;
 
 			if ((p->pack_keep && (flags & KEPT_PACK_ON_DISK)) ||
-			    (p->pack_keep_in_core && (flags & KEPT_PACK_IN_CORE))) {
+			    (p->pack_keep_in_core && (flags & KEPT_PACK_IN_CORE)) ||
+			    (p->pack_keep_in_core_open && (flags & KEPT_PACK_IN_CORE_OPEN))) {
 				ALLOC_GROW(packs, nr + 1, alloc);
 				packs[nr++] = p;
 			}
diff --git a/packfile.h b/packfile.h
index 8b04a258a7b..b7735c1977d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -28,6 +28,7 @@ struct packed_git {
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 pack_keep_in_core:1,
+		 pack_keep_in_core_open:1,
 		 freshened:1,
 		 do_not_close:1,
 		 pack_promisor:1,
@@ -266,6 +267,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 enum kept_pack_type {
 	KEPT_PACK_ON_DISK = (1 << 0),
 	KEPT_PACK_IN_CORE = (1 << 1),
+	KEPT_PACK_IN_CORE_OPEN = (1 << 2),
 };
 
 /*
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 7eb79bc2cdb..c74b5861af3 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -415,4 +415,109 @@ test_expect_success '--stdin-packs=follow tolerates missing commits' '
 	stdin_packs__follow_with_only HEAD HEAD^{tree}
 '
 
+test_expect_success '--stdin-packs=follow with open-excluded packs' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		git branch -M main &&
+
+		# Create the following commit structure:
+		#
+		#   A <-- B <-- D     (main)
+		#         ^
+		#          \
+		#           C        (other)
+		test_commit A &&
+		test_commit B &&
+		git checkout -B other &&
+		test_commit C &&
+		git checkout main &&
+		test_commit D &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		D="$(echo B..D | git pack-objects --revs $packdir/pack)" &&
+
+		C_ONLY="$(git rev-parse other | git pack-objects $packdir/pack)" &&
+
+		git prune-packed &&
+
+		# Create a pack using --stdin-packs=follow where:
+		#
+		#  - pack D is included,
+		#  - pack C_ONLY is excluded, but open,
+		#  - pack B is excluded, but closed, and
+		#  - packs A and C are unknown
+		#
+		# The resulting pack should therefore contain:
+		#
+		#  - objects from the included pack D,
+		#  - A.t (rescued via D^{tree}), and
+		#  - C^{tree} and C.t (rescued via pack C_ONLY)
+		#
+		# , but should omit:
+		#
+		#  - C (excluded via C_ONLY),
+		#  - objects from pack B (trivially excluded-closed)
+		#  - A and A^{tree} (ancestors of B)
+		P=$(git pack-objects --stdin-packs=follow $packdir/pack <<-EOF
+		pack-$D.pack
+		!pack-$C_ONLY.pack
+		^pack-$B.pack
+		EOF
+		) &&
+
+		{
+			objects_in_packs $D &&
+			git rev-parse A:A.t "C^{tree}" C:C.t
+		} >expect.raw &&
+		sort expect.raw >expect &&
+
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs with !-delimited pack without follow' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+
+		cat >in <<-EOF &&
+		!pack-$A.pack
+		pack-$B.pack
+		pack-$C.pack
+		EOF
+
+		# Without --stdin-packs=follow, we treat the first
+		# line of input as a literal packfile name, and thus
+		# expect pack-objects to complain of a missing pack
+		test_must_fail git pack-objects --stdin-packs --stdout \
+			>/dev/null <in 2>err &&
+		test_grep "could not find pack .!pack-$A.pack." err &&
+
+		# With --stdin-packs=follow, we treat the second line
+		# of input as indicating pack-$A.pack is an excluded
+		# open pack, and thus expect pack-objects to succeed
+		P=$(git pack-objects --stdin-packs=follow $packdir/pack <in) &&
+
+		objects_in_packs $B $C >expect &&
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.53.0.614.gc4fd52e751a

