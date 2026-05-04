Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40CBA45
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853493; cv=none; b=Zz1EGpyCbEpR/Iee9inCzdDcg2dmDTPHSWffZ5KoK3vkxwl3tAP4o/YlJ/u8vRF4zZA4Hk5o1SASeSWZjVkjykkwEKei5cUSFve49a9idaodOR1o87YSKi6y5pz4OP/8aLE6gQRGl+54dg5LS1Vgm3lbOoVWDtqHtNxeYH1egYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853493; c=relaxed/simple;
	bh=3feaBS7YpToQjdQn9GLDtJW5TLGBQsswd/4x5C8yLo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EypRrPEoDLjzhRJh2zM8dDHgGOONdJXQT+udWunywkaKMh8XmddOhhBlekeTLCxXLR2jaLRHhTmU/M0SgZquSIZPqE4DXUepHgOTc0FPwCOp7YcHJmfn+s0NwVpV7I5cxoxEUXKJoMnrscyTc1xGf9x+dNK5jv081KjRmhHPU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MBjgALAE; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MBjgALAE"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7991db3dc98so36960467b3.0
        for <git@vger.kernel.org>; Sun, 03 May 2026 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777853490; x=1778458290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hlbDf3T8cmwpofChck7LJi9fNZWdganB/cnsTuQm6Y=;
        b=MBjgALAEOKsriwqt+/Sy4ujI4in4heUsPkd8iXoz2f076DHs3iwPRVyiNJXCH3PeKE
         mLsrxHNURzCFNvlPUSlG/r9TVGhhBc4mSPGUu22XA7OImgR9l00sUAfhUU2yFcxv0+w8
         ZHwyjuLLRc71Mo/Dg/74LQ1YH0GDaJuX1TIwXMvYyv3JTRW79X4frt0PzH/6OVJNAEJ6
         9b0fNKr6EOjnpYAULBL9u0pT2GgAYjNpiGrZ9Os+f7CnApI/ztbi5fy+wz4MQoQmVEh4
         XTs/6jgRkEgYMmtS4Sr3LP13Z2LHnBCoAxwvTMyDI43odikdmL6X2OrlG7Tm5+v6Ib5U
         4TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853490; x=1778458290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hlbDf3T8cmwpofChck7LJi9fNZWdganB/cnsTuQm6Y=;
        b=kIJwSuNv8x98+QwIqZsoqEoh6Qi8PWpwAgFR5Y1k54iOgBSE+FqrdAlZ/Eu1HiBE/4
         7bBB3xgfjYlIpHPpiX3NsmIcZjyZbww67FYfGCQQhV6xOzBiTC6Fhzj/+gT4Hg1xB/TC
         ijA2kKQ/YBqX4OEJ2MzNoNA1BqN5v9qxDcD3+gc7uur570ypxl5MxUOwEN2yntXllTlT
         wCr+Mh7ddVYv+RTWqwn1OV1YueD+QqUaB8WyMuqwAd2MchVR1jtwMKLz+arx/SEKaTEs
         ejTVIjnNcZXoxayPd3mpP8NQ2Xw7branR7z35/G+D5ID3mO5HmLjKHpNAlACVeXcZQXn
         UpjA==
X-Gm-Message-State: AOJu0Yx5ugP4S2zOEWKtFm/gz5usx7u4+UbSwMXoS3++reGJgTEPHJcG
	xQ6t41tHsDdwqVnCi8pTNez976EACCRDHH6nmWF9RGXdR0B9fzVdEPFA4SmjDRLtP50kzO5rzJW
	Y351/Vy2+7mpY
X-Gm-Gg: AeBDietYHlqYeO5O2HY0N4VFDGgelXmsYi695enxsUHZSHyReblCxd1hDu0z6HfDT/S
	ATO97S3P712Gs+PCkCXoZ1UDB38P08MXVtQkhiX6pnIx4OWhEfsxtR4AGgSCC+XOwrQ+C39e1lh
	bc99M6Vb+nTOjjDVsNS2yiKd0J0N40lieOACoYN3E3qrRCv82KmgRAcm5A+TfFDM0EA9tPoaeIL
	A0UiMXIWqPkvbd+/M7++qlsMya0yJNy/2VkxkHvdh//9jfXUtcniwLo2I5NC/PNpVZV11RlJu6m
	s+kOtzNOck4Scr9UcLWSI7dfzbUTWNTird2WrY5vETRO1/cNXsHPzIYnHo4zODkSYxFqrPTmkTj
	S6XwS8nZLBbNMdTA+RBWMhZEJSTATbW4QULrjDB8s95Oqk12lNqD28eEZsq0q8D6VMGFU3tcvgg
	Z0Y2DPymx/AkcI2AWSXf364QhVRRWDh2pBT8aetW+67v6pDnRhPqMxSUd26FXiZDfFWGozrcV0b
	tBY6/7Iq02SgeMcAbIT+umSrj6zA1r4G8dC7f5cvxPMTWUESc6eOkNoomydHUq9o4Ax4vgvn3C/
	VRDt8RBCRwG2O+iKnRC0bCPwso0=
X-Received: by 2002:a05:690c:c4e8:b0:7b2:64f4:a2c0 with SMTP id 00721157ae682-7bd76f7ed0cmr82089817b3.5.1777853490480;
        Sun, 03 May 2026 17:11:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66896398sm41947917b3.48.2026.05.03.17.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:11:30 -0700 (PDT)
Date: Sun, 3 May 2026 20:11:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 5/7] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <f50f8df01a9f216d5b4388b2fe4ff58077b574f3.1777853408.git.me@ttaylorr.com>
References: <cover.1777853408.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777853408.git.me@ttaylorr.com>

When 'pack-objects' is invoked with '--path-walk', it prevents us from
using reachability bitmaps.

This behavior dates back to 70664d2865c (pack-objects: add --path-walk
option, 2025-05-16), which included a comment in the relevant portion of
the command-line arguments handling that read as follows:

    /*
     * We must disable the bitmaps because we are removing
     * the --objects / --objects-edge[-aggressive] options.
     */

In fb2c309b7d3 (pack-objects: pass --objects with --path-walk,
2026-05-02), we adjusted this behavior to also pass "--objects", but
still disable use of reachability bitmaps.

Fortunately, disabling reachability bitmaps is not strictly necessary.
Consider a couple of pack-objects use-cases: one during repacking, when
we would ordinarily generate reachability bitmaps, and another for
serving fetches and clones, when we would ordinarily read existing
bitmaps:

 - When attempting to generate reachability bitmaps, we would fail to do
   so since path-walk reveals objects through the
   `add_objects_by_path()` callback rather than, e.g., `show_commit()`,
   so the bitmap selector's `index_commit_for_bitmap()` was never called
   for any commit.

   The selection routine then had no candidates and bitmap writing was
   effectively a no-op.

 - On the bitmap-reading side, an invocation like "git pack-objects
   --use-bitmap-index --path-walk" never even tried to consult a bitmap,
   even when one was sitting on disk that could have answered the
   request.

Neither restriction is required. They are discussed in turn:

 - For bitmap-writing, all we need is for `index_commit_for_bitmap()` to
   see each commit that path-walk visits. The path-walk callback already
   groups commits into a single batch keyed by `OBJ_COMMIT`, so invoking
   `index_commit_for_bitmap()` from there gives the bitmap selection
   routine the same input it would have gotten from `show_commit()` in
   the regular traversal.

   The candidate set of commits is identical, though the ordering
   differs. Bitmap selection is sensitive to commit ordering, but
   commits are visited in the same order as we see them from
   `get_revision()` so bitmap selection should be identical with or
   without `--path-walk`.

 - For bitmap-reading, all we need is for `revs->tree_objects` (and so
   on for blobs and tags) to be set, otherwise bitmap traversal would
   only emit commit objects.

   In commit fb2c309b7d3, those flags are set via passing "--objects",
   so bitmap traversal under "--path-walk" packs everything just like
   any other "--use-bitmap-index" invocation.

If an existing reachability bitmap is unable to satisfy the request (no
bitmap on disk, haves not in the bitmapped pack, etc.) we fall through
to path-walk's own enumeration, just as the regular traversal falls back
when a bitmap is unavailable.

In other words: "--path-walk --use-bitmap-index" uses reachability
bitmaps when available, and otherwise enumerates via path-walk.

The regression in t5310 deserves a word about pack-reuse. With
pack-reuse enabled (the default), the output pack copies whole regions
of the existing bitmapped pack before `traverse_bitmap_commit_list()`
even runs, so a naive test would happily pass even if, say,
`revs->blob_objects` is set to 0. We test both with and without
pack-reuse enabled. When pack-reuse is disabled, pack-objects must
enumerate the resulting bitmap without copying any existing on-disk in
the rev_info setup that pack-reuse would otherwise paper over.

Update Documentation/git-pack-objects.adoc to drop the "ignored"
claim about --use-bitmap-index in favor of describing the new
fallback chain.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  6 +++--
 builtin/pack-objects.c              | 10 +++++++-
 t/t5310-pack-bitmaps.sh             | 36 +++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 6c7bbff5be5..60e594c7bc4 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -406,8 +406,10 @@ Incompatible with `--delta-islands`. Path-walk supports
 the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
 `sparse:oid=<blob>`, `tree:0`, `object:type=<type>`, and `combine:`
 over any of those. Other filter forms fall back to the regular object
-traversal. The `--use-bitmap-index` option will be ignored in the
-presence of `--path-walk`.
+traversal. When `--use-bitmap-index` is specified with `--path-walk`, a
+successful bitmap traversal is used for object enumeration, with
+path-walk remaining as the fallback traversal when the bitmap cannot
+satisfy the request.
 
 
 DELTA ISLANDS
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba00d8148ab..1a5f1afd32e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4732,6 +4732,15 @@ static int add_objects_by_path(const char *path,
 			continue;
 
 		add_object_entry(oid, type, path, exclude);
+
+		if (type == OBJ_COMMIT && write_bitmap_index) {
+			struct commit *commit;
+
+			commit = lookup_commit(the_repository, oid);
+			if (!commit)
+				die(_("could not find commit %s"), oid_to_hex(oid));
+			index_commit_for_bitmap(commit);
+		}
 	}
 
 	oe_end = to_pack.nr_objects;
@@ -5193,7 +5202,6 @@ int cmd_pack_objects(int argc,
 	if (path_walk) {
 		strvec_push(&rp, "--boundary");
 		strvec_push(&rp, "--objects");
-		use_bitmap_index = 0;
 	} else if (thin) {
 		use_internal_rev_list = 1;
 		strvec_push(&rp, shallow
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f693cb56691..69c5da1580a 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -577,6 +577,42 @@ test_bitmap_cases
 
 sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
 
+test_expect_success 'path-walk repack can write and use bitmap indexes' '
+	test_when_finished "rm -rf path-walk-bitmap" &&
+	git init path-walk-bitmap &&
+	(
+		cd path-walk-bitmap &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git repack -a -d -b --path-walk &&
+		git rev-list --test-bitmap --use-bitmap-index HEAD &&
+
+		git rev-parse HEAD >in &&
+
+		git rev-list --objects --no-object-names HEAD >expect.raw &&
+		sort expect.raw >expect &&
+
+		for reuse in true false
+		do
+			: >trace.txt &&
+
+			GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+			git -c pack.allowPackReuse=$reuse pack-objects \
+				--stdout --revs --path-walk --use-bitmap-index \
+				<in >out.pack &&
+			grep "\"category\":\"bitmap\",\"key\":\"bitmap/hits\"" trace.txt &&
+
+			git index-pack out.pack &&
+
+			list_packed_objects out.idx >actual.raw &&
+			sort actual.raw >actual &&
+			test_cmp expect actual || return 1
+		done
+	)
+'
+
 test_expect_success 'incremental repack fails when bitmaps are requested' '
 	test_commit more-1 &&
 	test_must_fail git repack -d 2>err &&
-- 
2.54.0.4.g6aa0d38a4ec

