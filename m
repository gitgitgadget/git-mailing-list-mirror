Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2D2AE78
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679511; cv=none; b=TKyuN8/l0bopx4/x//WJphKiA0DpPOmujcNJD2ki/Ju1mchKkDxvuKA2NfNhP+DAall8XAE19YBlmv9Mwz7wc7LX9fCFQ/CzlqnTqnk51Zx7iOeiV4b+lrkEJNbygArGHP6vvVvjp2Yjt18yxHDAARfmmRIb8EU06vF+YVqA9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679511; c=relaxed/simple;
	bh=YZPEAaKfhRnfwhlGtpuNZ3DFIB73ZjSHdIAMjG18lV4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gjblOv+oTEVzqVaKk5MllEsfi73d70aUceFunS5M3z3MFU/V9+ICTyHieA3UvE/Mst4i4uF+AB9cOFxc14IkvNbVl+N6XxBn8OYDqQTWZYsG+9wJSbxSEI9ZES+b6zIlaVmj11hG0neFWUQVRwVDKMzsL7gOVmQgULKq/90seeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE1jXcLx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE1jXcLx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d8f265cbe6so18168065ad.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788679509; x=1789284309; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jf52RgLW2cqKVexQz0l1HhBakpgC87PAkSKWtMn+lwk=;
        b=OE1jXcLx8gjKEGtrEymw4yxGwSBXIF78nPz91NDPEQTyhHw8MkSBserXifjE4YnVFG
         h3mj2WWK2dyNYmBVErRD5gjI0cp7tKfAOPawoX3+Z2re6IdYBIN+0IexlOLMVV40ar4V
         QyiNnKzyws/xgsxqQUGd6zJiCKjwgs//dngcMLNcz8PuzWw4UtD4e4POFl3W9d+IS0vW
         yzlN8yAnxmedgwcG2lFTFXYsdXDOAtY0zaReGRwEnx4jKflFNqcVUq3MYgLl6xZkO8uD
         P0qm5bko97vdIG4c3lCIdcDJtgFVAKIoy/c/cxNxjPLpR1b7VJwoi3KO/Lko29j34Aw4
         oRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788679509; x=1789284309;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jf52RgLW2cqKVexQz0l1HhBakpgC87PAkSKWtMn+lwk=;
        b=BgMo7mXgBwKf894IKhFrYahGSJk+22Wdf3afKanbXqKKvjlUQ7Uj+Z8K8xdt+GZJHC
         Ev/EXpGcZe7ihL8rnT8VYdOAh3ilktk4gCyFmKkDUWjQQpUN0H4iQlj33oVrs3Q/YZAZ
         zOIKstEZyRBEnGEPFFBngBYmlqipnc6umz5Ipouo5lp4klJgnpi/wnwcCRVnakPfogkM
         a89tbqC2wsWzgvSIQJeAY0zzHdWpM25LYcrhC0jaxJipnV2jhRMt5Nd5iW4sOUxEALMG
         HZBqwxzxg4jAxcdAWG9sZysRu20DnTU5y2cyDsK8+gEgzsMupmZPb0pB/PNfstMq8kgX
         sGug==
X-Gm-Message-State: AFuF++nkVBGG654fIY8rtuHKVP2ccuB4FZsqZ8Qn+V+hryf34Iy5qJc1
	y3iVtaxUPidV/46IopHviR9Wf7mgwaPMFaqE5nfLsS8g0x9K2Lpx9f8L2w9UeOil
X-Gm-Gg: AYBFou1t0PpHOrjUNV2sFLuX5cr7AnwtGZdED8jIDC4vi1uQZ7B5HkNb1MBWJxbOjwX
	o9AS1RywzVpjaK4U2DhMbce5YOh3NrRS+jbjlG9HX7LTvsL3wum4IaSWYWEIvCTbWQaHNYQ0yzF
	jr/dxZIBfVCaFOhT6/sGEPyYvUXXeMgRctTXvnMnruqjDB/O4dyeudTom3xOSq02H9Fw5Vg/TUJ
	Wq+b1bjeRRaf6IkyoSLUw+epeod22uCwHx8g9oime4hWa/9ugjGFxbTA3DtFzGpgICUPZLMAL4W
	QWWVr8Kfw5dYGmsID6yN5Ucz3/62qDrNC7SblQPZ36qwz6Dshy9gv2lMOHuZcQyzEXtQZcniea7
	3I9biONyczQx7228ueQQ/Zhf9B9VunSx3PMOKse1Kulo3t2ZRV/xUJ9NXCz7UB3LZ9EyKhKsEZR
	hEnRt297kOOzaXcV6/YS9fUe5ArgsvjrRlj/2m63Bhd5mnYTA2eki94lY2kTbB3t0=
X-Received: by 2002:a17:90b:2f46:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39b261e763dmr25661587a91.15.1788679508490;
        Sun, 06 Sep 2026 00:25:08 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.15.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-336c2571039sm1816673eec.25.2026.09.06.00.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:25:07 -0700 (PDT)
Message-Id: <7a4fb3845034fe50b83169d518b5d2459259a533.1788679500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
	<pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Sep 2026 07:24:58 +0000
Subject: [PATCH v3 4/6] send-pack: optionally omit shallow boundaries
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When the receiver advertises no commit the shallow client has, pack
generation walks to a shallow boundary and sends its entire tree. A tiny
push can consequently transfer gigabytes of objects the receiver likely
already has.

The client already assumes the receiver has the boundary's parents,
which are absent from the shallow clone. Extend that option to the
boundary itself: push.shallowExcludeBoundary=true adds reachable shallow
grafts as negative tips, letting receive-pack's connectivity check
reject the push if the assumption is wrong.

Only use grafts reached from refs contributing to the pack. An unrelated
graft could otherwise exclude an object another ref needs. Stop at
commits known to both sides, since they already bound the pack.

Also accept "abort" to make no assumption, and "false" to retain the
historical behavior required when seeding a receive.shallowUpdate
receiver.  Keep false as the default for now, so introducing the
mechanism does not change existing pushes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/push.adoc |  23 ++++++
 send-pack.c                    | 122 ++++++++++++++++++++++++++++++
 t/t5538-push-shallow.sh        | 131 +++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)

diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index 28132eedfe..0ad55965e8 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -134,6 +134,29 @@ This will result in only b (a and c are cleared).
 	rely solely on the server's ref advertisement to find commits
 	in common.
 
+`push.shallowExcludeBoundary`::
+	When pushing from a shallow repository, Git can omit the shallow
+	grafts' objects from the generated pack rather than resending the
+	full toplevel tree of those grafts.  This assumes the receiver
+	already has those objects.  If it does not, the receiver rejects
+	the push rather than accepting incomplete history. This setting
+	controls that behavior and accepts three values:
++
+--
+`abort`;;
+	If the push reaches such a boundary, refuse it rather than
+	choosing whether to send or omit it.
+`true`;;
+	Omit the boundary objects (fast). If the receiver does not have
+	them, the push is rejected.
+`false`;;
+	(the default) Send the boundary objects, retaining the historical
+	behavior.  This can send the boundary's entire tree, which may be
+	very large.  This is only needed when pushing to a receiver that
+	accepts new shallow roots (i.e. one with `receive.shallowUpdate`
+	enabled), which is very rare.
+--
+
 `push.useBitmaps`::
 	If set to `false`, disable use of bitmaps for `git push` even if
 	`pack.useBitmaps` is `true`, without preventing other git operations
diff --git a/send-pack.c b/send-pack.c
index f20460fbf4..386ea8b9a2 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -14,6 +14,7 @@
 #include "transport.h"
 #include "version.h"
 #include "oid-array.h"
+#include "oidset.h"
 #include "gpg-interface.h"
 #include "shallow.h"
 #include "parse-options.h"
@@ -55,6 +56,105 @@ static void append_negative_object(struct repository *r,
 	oid_array_append(haves, oid);
 }
 
+static int check_to_send_update(const struct ref *ref,
+				const struct send_pack_args *args);
+
+enum exclude_boundary_mode {
+	EXCLUDE_BOUNDARY_NONE = 0,
+	EXCLUDE_BOUNDARY_YES,
+	EXCLUDE_BOUNDARY_ABORT
+};
+
+static enum exclude_boundary_mode get_exclude_boundary_mode(struct repository *r)
+{
+	const char *value;
+
+	if (repo_config_get_string_tmp(r, "push.shallowexcludeboundary", &value))
+		return EXCLUDE_BOUNDARY_NONE;
+
+	switch (git_parse_maybe_bool(value)) {
+	case 1:
+		return EXCLUDE_BOUNDARY_YES;
+	case 0:
+		return EXCLUDE_BOUNDARY_NONE;
+	default:
+		if (!strcasecmp(value, "abort"))
+			return EXCLUDE_BOUNDARY_ABORT;
+		die(_("bad push.shallowExcludeBoundary value: %s"), value);
+	}
+}
+
+/*
+ * Append shallow grafts bounding contributing refs. Grafts from unrelated
+ * history could exclude objects this push needs, while commits both sides
+ * have make any graft below them irrelevant.
+ */
+static int append_reachable_shallow_grafts(struct repository *r,
+					    const struct ref *refs,
+					    const struct oid_array *advertised,
+					    const struct oid_array *negotiated,
+					    const struct send_pack_args *args,
+					    struct oid_array *haves)
+{
+	struct commit_list *pending = NULL;
+	struct oidset seen = OIDSET_INIT;
+	struct oidset known = OIDSET_INIT;
+	const struct ref *ref;
+	int found = 0;
+	size_t i;
+
+	for (i = 0; i < advertised->nr; i++)
+		oidset_insert(&known, &advertised->oid[i]);
+	for (i = 0; i < negotiated->nr; i++)
+		oidset_insert(&known, &negotiated->oid[i]);
+
+	/* Populate "known" fully before starting the walk. */
+	for (ref = refs; ref; ref = ref->next) {
+		struct commit *commit;
+
+		if (!is_null_oid(&ref->old_oid))
+			oidset_insert(&known, &ref->old_oid);
+
+		if (is_null_oid(&ref->new_oid))
+			continue;
+		if (check_to_send_update(ref, args))
+			continue;
+		commit = lookup_commit_reference_gently(r, &ref->new_oid, 1);
+		if (commit)
+			commit_list_insert(commit, &pending);
+	}
+
+	while (pending) {
+		struct commit *commit = pop_commit(&pending);
+		const struct object_id *oid = &commit->object.oid;
+		struct commit_graft *graft;
+		struct commit_list *parent;
+
+		if (oidset_insert(&seen, oid))
+			continue;
+
+		if (oidset_contains(&known, oid) &&
+		    odb_has_object(r->objects, oid, 0))
+			continue;
+
+		graft = lookup_commit_graft(r, oid);
+		if (graft && graft->nr_parent == -1) {
+			append_negative_object(r, haves, oid);
+			found++;
+			continue;
+		}
+
+		if (repo_parse_commit(r, commit))
+			continue;
+		for (parent = commit->parents; parent; parent = parent->next)
+			commit_list_insert(parent->item, &pending);
+	}
+
+	oidset_clear(&seen);
+	oidset_clear(&known);
+	return found;
+}
+
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
@@ -88,6 +188,13 @@ static int pack_objects(struct repository *r,
 	for (size_t i = 0; i < negotiated->nr; i++)
 		append_negative_object(r, &opts.haves, &negotiated->oid[i]);
 
+	/* Exclude reachable shallow boundaries from the pack. */
+	if (is_repository_shallow(r) &&
+	    get_exclude_boundary_mode(r) == EXCLUDE_BOUNDARY_YES)
+		append_reachable_shallow_grafts(r, refs, advertised,
+						negotiated, args,
+						&opts.haves);
+
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
 			append_negative_object(r, &opts.haves, &refs->old_oid);
@@ -644,6 +751,21 @@ int send_pack(struct repository *r,
 			ref->status = REF_STATUS_EXPECTING_REPORT;
 	}
 
+	/* Honor ABORT before sending any ref-update commands. */
+	if (!args->dry_run && need_pack_data && is_repository_shallow(r) &&
+	    get_exclude_boundary_mode(r) == EXCLUDE_BOUNDARY_ABORT) {
+		struct oid_array probe = OID_ARRAY_INIT;
+		int reachable = append_reachable_shallow_grafts(r, remote_refs,
+								extra_have,
+								&commons, args,
+								&probe);
+		oid_array_clear(&probe);
+		if (reachable)
+			die(_("refusing to push a shallow boundary commit\n"
+			      "Set push.shallowExcludeBoundary to true to omit it (fast),\n"
+			      "or false to send it (needed for receive.shallowUpdate)."));
+	}
+
 	if (!args->dry_run)
 		advertise_shallow_grafts_buf(r, &req_buf);
 
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 10ca7833d8..67db51e60e 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -210,4 +210,135 @@ test_expect_success 'incomplete shallow push rejects without disconnecting' '
 	test_grep ! "unable to parse commit" err
 '
 
+test_expect_success 'shallow boundary exclusion avoids sending the full tree' '
+	git init adv-origin &&
+	# The shallow grafts are intentionally untagged so that no
+	# advertised ref points at them.
+	test_commit --no-tag -C adv-origin a &&
+	test_commit --no-tag -C adv-origin b &&
+
+	git clone --depth=1 "file://$(pwd)/adv-origin" adv-client &&
+
+	# The remote branch advances past the history we have, so its
+	# advertised tip is something we cannot use as a negative tip;
+	# only the shallow graft lets us exclude the full tree.
+	test_commit --no-tag -C adv-origin c &&
+
+	git -C adv-client checkout -b topic &&
+	test_commit --no-tag -C adv-client new &&
+	GIT_PROGRESS_DELAY=0 git -C adv-client \
+		-c push.shallowExcludeBoundary=true \
+		push --progress origin topic 2>err &&
+
+	# Only the new commit, its tree, and the new blob are sent; sending
+	# the full tree is avoided by excluding the shallow graft.
+	test_grep "Enumerating objects: 4, done." err
+'
+
+test_expect_success 'push.shallowExcludeBoundary=false sends full tree' '
+	git init adv-origin2 &&
+	test_commit --no-tag -C adv-origin2 a &&
+	test_commit --no-tag -C adv-origin2 b &&
+
+	git clone --depth=1 "file://$(pwd)/adv-origin2" adv-client2 &&
+	test_commit --no-tag -C adv-origin2 c &&
+
+	git -C adv-client2 checkout -b topic &&
+	test_commit --no-tag -C adv-client2 new &&
+	GIT_PROGRESS_DELAY=0 git -C adv-client2 \
+		-c push.shallowExcludeBoundary=false \
+		push --progress origin topic 2>err &&
+
+	# With the optimization disabled and no advertised ref pointing at
+	# the shallow graft, the full snapshot down to the shallow graft is
+	# resent, including its full tree.
+	test_grep "Enumerating objects: 7, done." err
+'
+
+test_expect_success 'push.shallowExcludeBoundary=abort refuses when a graft is reached' '
+	git init adv-origin3 &&
+	test_commit --no-tag -C adv-origin3 a &&
+	test_commit --no-tag -C adv-origin3 b &&
+
+	git clone --depth=1 "file://$(pwd)/adv-origin3" adv-client3 &&
+
+	# The remote branch advances past the history we have, so its
+	# advertised tip cannot bound the walk; only the shallow graft could,
+	# which is exactly what "abort" refuses to rely on.
+	test_commit --no-tag -C adv-origin3 c &&
+
+	git -C adv-client3 checkout -b topic &&
+	test_commit --no-tag -C adv-client3 new &&
+
+	test_must_fail git -C adv-client3 \
+		-c push.shallowExcludeBoundary=abort push origin topic 2>err &&
+	test_grep "push.shallowExcludeBoundary" err &&
+
+	# The receiver must be left untouched: no ref was created.
+	test_must_fail git -C adv-origin3 rev-parse --verify refs/heads/topic
+'
+
+# A and B are unrelated shallow histories. The receiver has B1 under both
+# names, but lacks the "shared" blob from A1. The client adds cX atop A1 and
+# reintroduces "shared" on a topic atop B1. Pushing A and topic together
+# rejects A as a non-fast-forward, but A still participates in pack selection.
+# Its A1 boundary must not exclude the blob needed by topic.
+test_expect_success 'shallow push does not over-exclude for an accepted ref via a rejected one' '
+	git init tworoot-origin &&
+	git -C tworoot-origin checkout -b A &&
+	test_commit -C tworoot-origin --no-tag has-shared sh shared &&
+	test_commit -C tworoot-origin --no-tag A1 &&
+	git -C tworoot-origin switch --orphan B &&
+	test_commit -C tworoot-origin --no-tag B0 &&
+	test_commit -C tworoot-origin --no-tag B1 &&
+
+	git init --bare tworoot-receiver.git &&
+	git -C tworoot-origin push "file://$(pwd)/tworoot-receiver.git" \
+		B:refs/heads/B B:refs/heads/A &&
+
+	git clone --depth=1 --no-single-branch \
+		"file://$(pwd)/tworoot-origin" tworoot-client &&
+
+	git -C tworoot-client checkout A &&
+	test_commit -C tworoot-client --no-tag cX &&
+
+	git -C tworoot-client checkout -b topic B &&
+	test_commit -C tworoot-client --no-tag reintroduce sh shared &&
+
+	test_must_fail git -C tworoot-client \
+		-c push.shallowExcludeBoundary=true push \
+		"file://$(pwd)/tworoot-receiver.git" A topic &&
+	git --git-dir=tworoot-receiver.git rev-parse --verify topic
+'
+
+# A receive.shallowUpdate receiver needs the boundary snapshot to adopt a new
+# shallow root, so omission must reject rather than create a broken ref.
+test_expect_success 'push to a shallowUpdate receiver rejects a rootless snapshot' '
+	git init seed-origin &&
+	test_commit -C seed-origin s1 &&
+	test_commit -C seed-origin s2 &&
+	test_commit -C seed-origin s3 &&
+
+	# depth-2: a shallow graft at s2, pushing s3 on top of it
+	git clone --depth=2 "file://$(pwd)/seed-origin" seed-client &&
+
+	git init --bare seed-receiver.git &&
+	git --git-dir=seed-receiver.git config receive.shallowUpdate true &&
+
+	# Optimization on: the s2 boundary snapshot is withheld, so the
+	# receiver cannot graft the new root and rejects the push, leaving the
+	# ref uncreated.
+	test_must_fail git -C seed-client \
+		-c push.shallowExcludeBoundary=true push \
+		"file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded 2>err &&
+	test_grep "remote rejected" err &&
+	test_must_fail git --git-dir=seed-receiver.git rev-parse --verify seeded &&
+
+	# Opt-out: the full snapshot is sent, so the same push now succeeds and
+	# the new shallow root is grafted.
+	git -C seed-client -c push.shallowExcludeBoundary=false push \
+		"file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded &&
+	git --git-dir=seed-receiver.git rev-parse --verify seeded
+'
+
 test_done
-- 
gitgitgadget

