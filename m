Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA92E173B
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438919; cv=none; b=G/60iwc1E5DIIqGYv3rgSPaCXrsKpSYc8s+7nh58zFAN3Rnw64UJNTEcOrZylVJbfd8v9cU2BtOFlcIPce3htR/ZgfvDAlFuckf2I2H/4SEgGAVu3WuNgrVbZ7IZ62ykAPSULhEVkV8H/okki/f0jSVUl8OKPKBmfXJ3giE7Bdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438919; c=relaxed/simple;
	bh=q+r3qOXayh3pF0/djw7N+AEpYYEL6d+kCdHqgTNanGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfZw+vN4z2kFi20MYaVzAKprCVGz82QxXSOFCBeMlhAOzzhS+oaJ5nKSPD8KXCt/XAZh2+2EKkt+/eOkyR9ejRs0eMytJnOUYo+xSlE4b8sM6ODDUAuJZvuCRe30oep2QOFahFBDcqyIapUvjQ75DEfd4j+geE47Fm+eTQ1i1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=aDCvisPS; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="aDCvisPS"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66077e90382so2984216d50.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1780438915; x=1781043715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YyYesYC+0BYyvjynADuQvaxHS063b2S8+lK+j+V0jx0=;
        b=aDCvisPSg8f4aXa7/3A6KY26Ec5F715XrNmXMrYpBAhN4jRF+XKo6AO6c7IflVheRM
         Ozh29CmP083qV+qqz3cvYM1hj1QR8uWyWiIsVVw54+oGN/QD4YiEISBZRGL6tszYzQYg
         pJ0OogabNk1wRJvQ3v6Y8qSLJpBLKoGm3bkMX6uiRjHxwGmG+QcwLpvv5ew5t0lrr54s
         PqeqZbXH/Eo9efznCeGTMCx9d0o6jq4gi15FEU5GNTMij/cNB1y0cCR+mlaV4wIKHtwK
         Lqjh7v2vdMM6yJM15MUemLsaMhAdaumklnqazJA+lcpIZNNnVkOCwIIv/sYC5DOhJ5Up
         2DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438915; x=1781043715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyYesYC+0BYyvjynADuQvaxHS063b2S8+lK+j+V0jx0=;
        b=nNhzVMnntIpRiQ6gT7l+iqIVhX1cmmsKitCfIU9H+ULka1dqiTjqNVVYwqiJWBAw8Q
         9BYRtPjQeuBdGzcGIcTc8/yMOxpBw38Q3NElgTog1GRyVL9tAId7PEiaV29rCc35Ba0M
         +y3y5R+d6NeGlZuOxOHgVqPHlqXLFhHKLOQ0IM7GfhzZmskv49wcoRx3jVxPlnvIJ9s+
         gy7lBOvi/wrWSZ7u8rLl+lnC6tE6GxDkdv+OGp3LWDZG++z8QgQK4Ry0QBBTHPXNMYcD
         Nvcim0PayLBjwJaIgGCGF978hnUXEPHWKR0jJZ+SePV6TbStSiYHGvAKijAxFpxRhDJl
         E0Nw==
X-Gm-Message-State: AOJu0YxIECel7JUo3RcG0KIEE7p/HSLZu4yrKjzAEqd889bo8eqDvxt5
	2yvyazk7mgkCfn9FNz6PfcZfFjmRAxtYsEVL1VgEf1/tsTCTKhQwJtSxJht0MAq/gZKrZJ9x+ZI
	XNpFxy40=
X-Gm-Gg: Acq92OGpVWKpRMMXHtVd5WHfGNV+E7ij+RwjlOy0eaOclEMP2NCeuEw9N5GY7/7W3/n
	qoZw00wc+KVCV8hqtPviV/7w3HIhzQvOfv+HsEH4kUOWFCVDsm1FQMISLMCVcS1Zs1gPIHCkdEV
	5WQGt42naom/kZhi9g/1+qk7O+vA6AhyNdPs4hAaWcgouOJZUc26BwvDeVvoyR201DmDzA4LelW
	+6IHnmWzKFOEI8ZDmvK4WbZCdDESYifroODNkcHFGdwQZZ9QHyiZvXhZ8IT04S+rY6h8qfUaqI6
	q2fFhCfBIlGBGjrIUMiQzZkQZmy5o4A91bYJ70uyf4hHtgWRE+P2rhgPro0hrgT1kP3s1xPDs/t
	UkrKMaLMFtqxkGzcpa/tOOcwO27FIHnSoAdBD5qNZYlSFx4pQFI+71fgPzlRXkeavXBpWnvUj+V
	SzNxl5hVBjfmQeanfkibkKUhHZjubGt8LASm8M5C3Qp96IrGPZl8xhZCI5egEbwDQOSlYAeg+jH
	RIQwqNl7Ri1vjtPw7kbMHC33Q2F5P42pJ/Yrv+5xZaQJa9OLMcT31pdM6lg6WsfeTkT7eay1RrE
	GHnzcd2dDiPK0pT6/riCGT5p/PA=
X-Received: by 2002:a05:690e:146:b0:660:4983:3134 with SMTP id 956f58d0204a3-660dc04d54fmr562549d50.60.1780438914986;
        Tue, 02 Jun 2026 15:21:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d6484af2sm718327d50.20.2026.06.02.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:21:54 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:21:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/4] pack-objects: support `--delta-islands` with
 `--path-walk`
Message-ID: <ae57607b57f810ca76e926530eeb5710df2e5b80.1780438896.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1780438896.git.me@ttaylorr.com>

Since the inception of `--path-walk`, this option has had a documented
incompatibility with `--delta-islands`.

When discussing those original patches on the list, a message from
Stolee in [1] noted the following:

    this could be remedied by [...] doing a separate walk to identify
    islands using the normal method

In a related portion of the thread, Peff explains[2]:

    The delta islands code already does its own tree walk to propagate
    the bits down (it does rely on the base walk's show_commit() to
    propagate through the commits).

    Once each object has its island bitmaps, I think however you
    choose to come up with delta candidates [...] you should be able
    to use it. It's fundamentally just answering the question of "am
    I allowed to delta between these two objects".

That is similar to what this patch does, and it turns out the cheaper
option is sufficient: perform the same island side effects from the
path-walk callback rather than doing a second walk.

Recall how delta-islands are computed during a normal repack:

 - `show_commit()` calls `propagate_island_marks()` for each commit,
   which merges the commit's island bitset onto its root tree object and
   onto each of its parent commits.

 - `show_object()` for a tree records the tree's depth derived from the
   slash-separated pathname. Subsequent `resolve_tree_islands()` uses
   that depth to walk trees in increasing-depth order, propagating each
   tree's marks to its children.

 - At delta-search time, `in_same_island()` enforces that a delta
   target's island bitmap is a subset of its base's: every island that
   reaches the target must also reach the base.

Path-walk's enumeration callback is `add_objects_by_path()`. It already
adds objects to `to_pack`, but until now did not perform the
island-related side effects. Two things are needed:

 - For each commit batch, call `propagate_island_marks()` on commits,
   exactly as `show_commit()` does.

   We have to be careful about the order in which we call this function,
   and we must see a commit before its parents in order to have
   island marks to propagate.

   The path-walk batch preserves that order. Path-walk appends commits
   to its `OBJ_COMMIT` batch as they come back from the same
   `get_revision()` loop the regular traversal uses, and
   `add_objects_by_path()` iterates the batch in array order. So every
   commit reaches `propagate_island_marks()` in the same sequence that
   `show_commit()` would have seen it, and the descendant-first chain
   that the algorithm relies on is intact.

   Skip island propagation for excluded commits to match the regular
   traversal, whose `show_commit()` callback is only invoked for
   interesting commits. Boundary commits may still be present in
   path-walk's callback so they can serve as thin-pack bases, but they
   should not contribute island marks.

 - For each tree batch, record the tree's depth from the path. Use the
   `record_tree_depth()` helper from the previous commit so both
   callbacks behave identically, including the max-depth-wins behavior
   when a tree is reached via more than one path. The helper accepts
   both the `show_object()` path shape ("foo", "foo/bar") and the
   path-walk shape with a trailing slash ("foo/", "foo/bar/"), so depths
   recorded from either traversal mode are directly comparable.

   This is implicit in the implementation sketch from Peff above.
   `resolve_tree_islands()` sorts trees by `oe->tree_depth` in
   increasing-depth order before propagating marks down, so that a
   parent tree's marks are finalized before its children inherit them.
   Without recording the depth at path-walk time, every
   path-walk-discovered tree would land at depth 0 in `to_pack`, the
   sort would lose its ordering, and children could inherit marks from
   parents whose own contributions had not yet been merged in.

With those two pieces in place, `resolve_tree_islands()` receives the
same island inputs from path-walk as it would from the regular
traversal, so the existing island checks can be reused unchanged.

Drop the documented incompatibility between `--path-walk` and
`--delta-islands`, and add t5320 coverage for path-walk island repacks
with and without bitmap writing, as well as the same-island case where a
delta remains allowed.

[1]: https://lore.kernel.org/git/9aa2471b-0850-4707-9733-d3b33609f5f2@gmail.com/
[2]: https://lore.kernel.org/git/20240911063203.GA1538586@coredump.intra.peff.net/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc | 14 +++++++-------
 builtin/pack-objects.c              | 22 ++++++++++++++++++----
 t/t5320-delta-islands.sh            | 29 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 0adce8961a3..65cd00c152f 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -402,13 +402,13 @@ will be automatically changed to version `1`.
 	of filenames that cause collisions in Git's default name-hash
 	algorithm.
 +
-Incompatible with `--delta-islands`. When `--use-bitmap-index` is
-specified with `--path-walk`, a successful bitmap traversal is used for
-object enumeration, with path-walk remaining as the fallback traversal
-when the bitmap cannot satisfy the request. The `--path-walk` option
-supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter
-types can be combined with the `combine:<spec>+<spec>` form.
+When `--use-bitmap-index` is specified with `--path-walk`, a successful
+bitmap traversal is used for object enumeration, with path-walk
+remaining as the fallback traversal when the bitmap cannot satisfy the
+request. The `--path-walk` option supports the `--filter=<spec>` forms
+`blob:none`, `blob:limit=<n>`, `tree:0`, `object:type=<type>`, and
+`sparse:<oid>`. These supported filter types can be combined with the
+`combine:<spec>+<spec>` form.
 
 
 DELTA ISLANDS
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ec02e2b21d2..f48ea7a888b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4737,13 +4737,29 @@ static int add_objects_by_path(const char *path,
 
 		add_object_entry(oid, type, path, exclude);
 
-		if (type == OBJ_COMMIT && write_bitmap_index) {
+		if (type == OBJ_COMMIT) {
 			struct commit *commit;
 
+			if (!write_bitmap_index && !use_delta_islands)
+				continue;
+
 			commit = lookup_commit(the_repository, oid);
 			if (!commit)
 				die(_("could not find commit %s"), oid_to_hex(oid));
-			index_commit_for_bitmap(commit);
+			if (write_bitmap_index)
+				index_commit_for_bitmap(commit);
+			/*
+			 * Skip island propagation for boundary commits.
+			 * The regular traversal's show_commit() is only
+			 * called for interesting commits; matching that
+			 * here keeps path-walk from doing extra work that
+			 * would only be a no-op anyway (boundary commits
+			 * are not in island_marks).
+			 */
+			if (use_delta_islands && !exclude)
+				propagate_island_marks(the_repository, commit);
+		} else if (type == OBJ_TREE && use_delta_islands) {
+			record_tree_depth(oid, path);
 		}
 	}
 
@@ -5205,8 +5221,6 @@ int cmd_pack_objects(int argc,
 		const char *option = NULL;
 		if (!path_walk_filter_compatible(&filter_options))
 			option = "--filter";
-		else if (use_delta_islands)
-			option = "--delta-islands";
 
 		if (option) {
 			warning(_("cannot use %s with %s"),
diff --git a/t/t5320-delta-islands.sh b/t/t5320-delta-islands.sh
index 2c961c70963..9b28344a0a3 100755
--- a/t/t5320-delta-islands.sh
+++ b/t/t5320-delta-islands.sh
@@ -53,6 +53,35 @@ test_expect_success 'separate islands disallows delta' '
 	! is_delta_base $two $one
 '
 
+test_expect_success 'path-walk island repack respects islands' '
+	GIT_TRACE2_EVENT="$(pwd)/trace.path-walk-islands" \
+		git -c "pack.island=refs/heads/(.*)" repack -adfi \
+		--path-walk 2>err &&
+	test_region pack-objects path-walk trace.path-walk-islands &&
+	test_grep ! "cannot use --delta-islands with --path-walk" err &&
+	! is_delta_base $one $two &&
+	! is_delta_base $two $one
+'
+
+test_expect_success 'path-walk island bitmap repack respects islands' '
+	GIT_TRACE2_EVENT="$(pwd)/trace.path-walk-island-bitmap" \
+		git -c "pack.island=refs/heads/(.*)" repack -a -d -f -i -b \
+		--path-walk 2>err &&
+	test_region pack-objects path-walk trace.path-walk-island-bitmap &&
+	test_path_is_file .git/objects/pack/*.bitmap &&
+	git rev-list --test-bitmap --use-bitmap-index one &&
+	test_grep ! "cannot use --delta-islands with --path-walk" err &&
+	! is_delta_base $one $two &&
+	! is_delta_base $two $one
+'
+
+test_expect_success 'path-walk same island allows delta' '
+	GIT_TRACE2_EVENT="$(pwd)/trace.path-walk-same-island" \
+		git -c "pack.island=refs/heads" repack -adfi --path-walk &&
+	test_region pack-objects path-walk trace.path-walk-same-island &&
+	is_delta_base $one $two
+'
+
 test_expect_success 'same island allows delta' '
 	git -c "pack.island=refs/heads" repack -adfi &&
 	is_delta_base $one $two
-- 
2.54.0.23.gae57607b57f
