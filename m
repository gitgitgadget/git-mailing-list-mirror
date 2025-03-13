Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF313AA2F
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834011; cv=none; b=H+f4nbjsENMIbd4ULLHOCTozr1qtcuNdPeRdQVOdyXDqirS6OIIi0WJUkhnxByV/Gw+1fqjseGmZ5VCea00NZ991nwCewpZhyp3STe0IdC55SRea3bqlrZmporOZ2d2aidXQTGl08YBFXf2IBvnlehBCeNImgyOklO0VOAYd0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834011; c=relaxed/simple;
	bh=L8aYXlsgYTW7r0VUZck+pVqsskBcy7fRBD70ndGtQJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DmCgWnZ0wWIWq6bfVYGIycteiClCbbPfN1hoEbUjg1vrjeTxhu9LyCwJRHGNPyWIKsnXKBFDJy6sD23S0B7qISj/Bto0V6a5K5cnzqhmkHUvMl7gtnCSC2LedJMwlBiBaRGDWA7tRuL8OAZ6NRrD+o1sVSxMXsrvwRKzrat3ugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLLilTFz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLLilTFz"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so93946766b.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834007; x=1742438807; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+8si5HEFRgzN0jnJVYf2WA7bOvtvq/Eb8yK4PadRuU=;
        b=ZLLilTFzkqQXrUQH4qnV1tSZfg1mRdATk+abIbqDuTrZ2iRCGouR5PlKvdLlRr7H1B
         1JGbeSCM6nLGa+MGR+XAFTyD6q122s/KnCWyLzfDZIUw9Tts+G+SjwFFjpqN6ZE4NeTn
         xOyT/L/cpvJvvOvOPDDCuYwX2ihINAt/AuIw62arIERUQYFwfB+MyzTzt0lFOwjBYWC6
         BoimY+GpEli+uhUfqmkL8kdT08Ycdc6qAQT0bT2tFk8My7hbhzxnLmoSGYi3EWhw7tMB
         wYysv4M5wlSVC7U4iXfrjk8Imd2AY/4zVgvUaUOjTezbjMH6pGZkENGMxkA17GKPIXI4
         mF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834007; x=1742438807;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+8si5HEFRgzN0jnJVYf2WA7bOvtvq/Eb8yK4PadRuU=;
        b=Tg6Caq2k5HWxipj+eg/pGyc/ZyiE4bts7tBcVK/gDNIOHG9i1G6kvQWPRb7Wv2/6YD
         QwkIfyWaORhoFk9C/aLbEWMfwbH+yUrpyubg7JWebRQyh9T0STknNRHflBMioLiR6c1F
         0HOxRoDR2oBzvTLvAQPgnjJDoEr6C/AM8eX4rm0cq6WSVLE2EHgqX4OIVybZdHvA6eyP
         Ogxf6xwDbfr2/xu6KzjD61qhEx+7EvGoaaK0dkdoq0rvFumfC0DiR+6Hhbt70Ut/TDIr
         A/QIPMKZfezB0HqF6YuIMeBFN8irom+NwehmOHHW1NLeBt8ywFtz/ZxIZSWTdOORQSi/
         o+5Q==
X-Gm-Message-State: AOJu0YzaMC0J0u+u2YoREQ7WtEIB19CuQPT6LWWOYxU6WlH7wIF2EoTj
	uB3nLwFUSFGPfvfsMxk+r82JbEjJawq36hEs6qBDYRzcZ7WZFageRDexBQ==
X-Gm-Gg: ASbGncvDR4qzeJR6ah1CSW/knXO+EZsTY4QnQ/lPOlNsA2dWryexSav6HM4mmE3W48N
	ZJOeAR7xvgnp2YN8IJ18/xyxq27jhaOYqs57/KerGlNUFzK9VdwtXxw4Kzuzz0y3SEDWIAFKmSA
	9RmsCYBpLLct7W7YCVIFiJ/fLXvAa1Gqca+ERcbQ7khlEAbrRhidt7I7qUICSLvFtNm8J3a1Wra
	28MfWXm5arVpxw+/L3HjEKXAqUA4lOMvlhQfTjcoEbC/JotqizD13Qy7dIFptuZ8AqQHQ/UkX0Z
	NhsabP0Z69KNS/UjVHuUUK/lzVxZAujjSjnUfJa4myGY+A==
X-Google-Smtp-Source: AGHT+IF4tbNdDtEH8wCqKbRAWX0ld05j76MojRqm+OJilDea37Q/QZm9202w5wssof/ZoW5OXHqoRw==
X-Received: by 2002:a17:907:c302:b0:ac2:f93:b7c5 with SMTP id a640c23a62f3a-ac2526e1ba9mr2677493066b.31.1741834007171;
        Wed, 12 Mar 2025 19:46:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3a31csm20949266b.127.2025.03.12.19.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:46:46 -0700 (PDT)
Message-Id: <b25225c3cabf7aafc659489e302193fd57829d5e.1741834001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
	<pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Mar 2025 02:46:40 +0000
Subject: [PATCH v2 5/6] merge-ort: fix merge.directoryRenames=false
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
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

There are two issues here.

First, when merge.directoryRenames is set to false, there are a few code
paths that should be turned off.  I missed one; collect_renames() was
still doing some directory rename detection logic unconditionally.  It
ended up not having much effect because
get_provisional_directory_renames() was skipped earlier and not setting
up renames->dir_renames, but the code should still be skipped.

Second, the larger issue is that sometimes we get a cached_pair rename
from a previous commit being replayed mapping A->B, but in a subsequent
commit but collect_merge_info() doesn't even recurse into the
directory containing B because there are no source pairings for that
rename that are relevant; we can merge that commit fine without knowing
the rename.  But since the cached renames are added to the normal
renames, when we go to process it and find that B is not part of
opt->priv->paths, we hit the assertion error
  process_renames: Assertion `newinfo && ~newinfo->merged.clean` failed.
I think we could fix this at the beginning of detect_regular_renames() by
pruning from cached_pairs any entry whose destination isn't in
opt->priv->paths, but it's suboptimal in that we'd kind of like the
cached_pair to be restored afterwards so that it can help the subsequent
commit, but more importantly since it sits at the intersection of
the caching renames optimization and the relevant renames optimization,
and the trivial directory resolution optimization, and I don't currently
have Documentation/technical/remembering-renames.txt fully paged in, I'm
not sure if that's a full solution or a bandaid for the current
testcase.  However, since the remembering renames optimization was the
weakest of the set, and the optimization is far less important when
directory rename detection is off (as that implies far fewer potential
renames), let's just use a bigger hammer to ensure this special case is
fixed: turn off the rename caching.  We do the same thing already when
we encounter rename/rename(1to1) cases (as per `git grep -3
disabling.the.optimization`, though it uses a slightly different
triggering mechanism since it's trying to affect the next time that
merge_check_renames_reusable() is called), and I think it makes sense
to do the same here.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c              | 31 +++++++++++++++++++++++++++++--
 t/t3650-replay-basics.sh |  2 +-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1d3b690224e..785e5c6f24a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3404,6 +3404,11 @@ static int collect_renames(struct merge_options *opt,
 			pool_diff_free_filepair(&opt->priv->pool, p);
 			continue;
 		}
+		if (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_NONE &&
+		    p->status == 'R' && 1) {
+			possibly_cache_new_pair(renames, p, side_index, NULL);
+			goto skip_directory_renames;
+		}
 
 		new_path = check_for_directory_rename(opt, p->two->path,
 						      side_index,
@@ -3421,6 +3426,7 @@ static int collect_renames(struct merge_options *opt,
 		if (new_path)
 			apply_directory_rename_modifications(opt, p, new_path);
 
+skip_directory_renames:
 		/*
 		 * p->score comes back from diffcore_rename_extended() with
 		 * the similarity of the renamed file.  The similarity is
@@ -5025,7 +5031,8 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	trace2_region_leave("merge", "allocate/init", opt->repo);
 }
 
-static void merge_check_renames_reusable(struct merge_result *result,
+static void merge_check_renames_reusable(struct merge_options *opt,
+					 struct merge_result *result,
 					 struct tree *merge_base,
 					 struct tree *side1,
 					 struct tree *side2)
@@ -5050,6 +5057,26 @@ static void merge_check_renames_reusable(struct merge_result *result,
 		return;
 	}
 
+	/*
+	 * Avoid using cached renames when directory rename detection is
+	 * turned off.  Cached renames are far less important in that case,
+	 * and they lead to testcases with an interesting intersection of
+	 * effects from relevant renames optimization, trivial directory
+	 * resolution optimization, and cached renames all converging when
+	 * the target of a cached rename is in a directory that
+	 * collect_merge_info() does not recurse into.  To avoid such
+	 * problems, simply disable cached renames for this case (similar
+	 * to the rename/rename(1to1) case; see the "disabling the
+	 * optimization" comment near that case).
+	 *
+	 * This could be revisited in the future; see the commit message
+	 * where this comment was added for some possible pointers.
+	 */
+	if (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_NONE) {
+		renames->cached_pairs_valid_side = 0; /* neither side valid */
+		return;
+	}
+
 	/*
 	 * Handle other cases; note that merge_trees[0..2] will only
 	 * be NULL if opti is, or if all three were manually set to
@@ -5258,7 +5285,7 @@ void merge_incore_nonrecursive(struct merge_options *opt,
 
 	trace2_region_enter("merge", "merge_start", opt->repo);
 	assert(opt->ancestor != NULL);
-	merge_check_renames_reusable(result, merge_base, side1, side2);
+	merge_check_renames_reusable(opt, result, merge_base, side1, side2);
 	merge_start(opt, result);
 	/*
 	 * Record the trees used in this merge, so if there's a next merge in
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index cade7930765..58b37599357 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -195,7 +195,7 @@ test_expect_success 'using replay on bare repo to rebase multiple divergent bran
 	done
 '
 
-test_expect_failure 'merge.directoryRenames=false' '
+test_expect_success 'merge.directoryRenames=false' '
 	# create a test case that stress-tests the rename caching
 	git switch -c rename-onto &&
 
-- 
gitgitgadget

