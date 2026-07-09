Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB63F0AA4
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586174; cv=none; b=mQ/jAR9yAQ/7QesiC5IQQk1DybPopEQOpHblRCCHJ74MuxWiw3z7lZQekriieAVJkTDnUDT/OyV4fu/uyh2F4ARZmFI7iGYz2QKKbRRTA7R6lFvArRAp1TqWa9jpXG+2uVMqzAtfydmYcxYuHDPrfamfgEvZMECS9vjUG/6qnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586174; c=relaxed/simple;
	bh=GwC9xrNPnl1IWWY8W8uHdZSXGSUsYr2Rsz2m7ra5hI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kh2vFjKuAxX5Tu7YZPsW4WjhvXIN1nKQjlbT4YkwgThqij/MwJfPllfmZ6GEF9n7Yo4OtFaf4z60ROxkvNyFDrQ9S1wfdNcuak9i4Un5BVXV+E6/KNh3cWfwDE9g4XBHmYJZOpprSpXoqm8gILZKUWPKlaRUE7hld1PrJWOF2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YTmBPkJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcIDGJHr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YTmBPkJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcIDGJHr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE3FA7A0097
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:36:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 04:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783586172;
	 x=1783672572; bh=qJXFeu3MYKxKs6NaCjEgyy7O1XAeBUSqM919xv0EYkw=; b=
	YTmBPkJwfejOoIkQz3FDxGrRNxd92thPAglI9gyojqQZ1WiU9vWHHFjBMZqDV/SB
	QmINf7YInqO+2PfBLqIAwmIHycfdKbxlTiPq8trkqIGLvmVjVodcdLlIWvhuI6th
	Bgz9rMIGl2JvTwQWsafcZObCMmIL3Gi8/BzoqPlSHg0Kh9OlpCZfQb8NGvAGR4a8
	6PBjvEZF8YEt9DCE9s95Nl8pZ9AH2J0JcaGNDxTvr9ExLS1I068iLiQzObiRSqYT
	MFgkritlQsKWmX5qMAR1krbSg2JUMkbfCT+roHCCFjvv8JSbR/eyrSDijipvhaNz
	nG3T4mv+i68kDkmU2lKHOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783586172; x=
	1783672572; bh=qJXFeu3MYKxKs6NaCjEgyy7O1XAeBUSqM919xv0EYkw=; b=U
	cIDGJHrhj2mFvL3t1UmoMmy4oY6SpIiSSDCyvJdNTqyPpoYS6Lu/K1b0WJkFjBF+
	6gMyVBmffwUrfZYl7AnjctRSmRUvY+E4lK2+FxQBf8Hi2hco4YGslomTa5ZYm/u+
	SayNAwlFSWVWE+PWRp3RYrL5bDyTs8H2srEbt3XIwXuXmTMaeWduMrReFxMA4t4P
	ZUq0f0YExzfd1HyUAGWN1tmHUE7Ps7Th6QC7zZOkRTzFwMd8UUacRFZGI4rhNKoW
	MjBc5CM9Ov1NziCg051aNU/8Aiicg6VaHYe8G69+u9r996s9js+OjcEi0LTGQjpb
	P1lWPYWUoN2l6od7ggrbg==
X-ME-Sender: <xms:fF1Paizl2eMLjR_-RCpC29JYe469XdJxBM8-JrvhVVsuDbwiTaAuSw>
    <xme:fF1PalMw3NouP69oVq9ewo3sWPqVdnoYI4fcTq3ZofckhGoaj9bXWPJODK5n62G22
    ApFy8JqhIdvLr2WICzvt86ewGT2Zd-kpfKTtwbJUWX8T6Uxa2RYHg>
X-ME-Received: <xmr:fF1Pap-Q0QVF9T3zxb90zGaMLiAQzhdh96JRhVrR8pArAOEcLtcrzcEPQ9OI9VMsQ43j8p8YlN_FIx7ZLUCZoIGlUP337nS5RcrYpGp3Gg>
X-ME-Proxy-Cause: dmFkZTFJZsxlobujWJB//0c8jFk+g9m5YwHaKid7RhhsWsrb3qr5adtFPEPRJlCzgkUGfR
    JG6CIiAno2pOBhH7DklbqZu9xUQIigXIPJkGHVUTwsze8tc+lkQZfZAkaCBYX/oqRJ86J7
    +uU4XN10b7A8ePywNenvyvXtXe723ViToHyDgx8pO+ZtBQLFfkvp7tAk/ALSOx6F3Y0nzU
    0lEIwtDidzHjGzG002urpytlGc/3tZmFw+4do2Qjzd2XwrXCQedrz7EvHCoUTJqUI2OwHf
    QZQqGzTqeQWfrIDHk7fUorddTS8sPNygHDPsvsHQTJxEp1OVZSb2U0cuyATcJ2BHowFBGI
    LdkmhU6utMCpdidDiwQjVD/qHnLyT3xTFzxx0q6ziS4NFTUqD+SfzTjIgClI6ZsBAtddkL
    dhDv/LqprCVad+R0UBPLcMb4rJNWv4XKAdUQwT9LLiQaJUCODsjW6271H0Cjli5T7N0cTq
    3vHOQjfFVXAmEixexThvaRSPYCLAzUJVnnYi+txQBSfhVLj0poVLp3mjD3HMQbhoT08aes
    n4uLrYUgJDtQn0rEwA8BrXtO+4Cfwhv+RhsySuon0W5QXPVDfIv5wwX/akcSwXqObuY2J2
    CE0OHJAU1TtssDkRsx+p57stis/kkiLWYGbA/O21hcKzo1XlTjEvDef7QFAA
X-ME-Proxy: <xmx:fF1PatruMl8pd7W9tmK1ejrFciMC51jAB5GOrHmSOGz_qSICP1sWcg>
    <xmx:fF1Paj6EZCkZKrur131-H_THIdwscZmFnfAE-OknWz_yHR44LQo_jA>
    <xmx:fF1PalPvbl2ajWVhTtL2LfekrgsG8NrY6iqwLzIDFJCLo5ij8cTP7Q>
    <xmx:fF1PatOBwxwtdJu214HFiT4qx89WP9nBSaQqjXb9LWtzqBBJfN-ixg>
    <xmx:fF1Paq000Uk3DNaHMDqeYGsTElJn36TqQ1t5d61qDmxguN-po5Z1DVpU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:36:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c61b069 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:36:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:35:23 +0200
Subject: [PATCH 3/7] pack-bitmap: allow aborting iteration of bitmapped
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-odb-for-each-object-filter-v1-3-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In a subsequent commit we'll lift iteration of bitmapped objects into
the "packed" backend and make it accessible via `odb_for_each_object()`.
The calling convention for that function is that the callback may return
a non-zero exit code, and if so we'll abort iteration. This is currently
impossible to realize though, as `for_each_bitmapped_object()` will
ignore any return value and just churn through all objects completely.

This doesn't matter to the callers of `for_each_bitmapped_object()`, as
there's only one of them in git-cat-file(1), and the callbacks we pass
always return zero. But once we move the logic into the generic
infrastructure it becomes a latent bug waiting to happen.

Refactor the code so that the return value of the `show_reach` callback
is not ignored anymore. Instead, returning a non-zero value will cause
us to abort iteration in both `show_objects_for_type()` and in
`for_each_bitmapped_object()`.

Note though that there's a second user of `show_objects_for_type()` with
`traverse_bitmap_commit_list()`, and that function does indeed invoke
callbacks that may return non-zero. This non-zero return value never had
any effect at all though, and the callbacks that return non-zero values
are only ever invoked via `traverse_bitmap_commit_list()`. Consequently,
we adapt them to always return 0.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  2 +-
 builtin/rev-list.c     |  2 +-
 pack-bitmap.c          | 31 +++++++++++++++++++++----------
 pack-bitmap.h          |  3 ++-
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ea5eab4cf8..8ff92c5272 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1909,7 +1909,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
-	return 1;
+	return 0;
 }
 
 struct pbase_tree_cache {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 8f63003709..02818b81c6 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -486,7 +486,7 @@ static int show_object_fast(
 	void *payload UNUSED)
 {
 	fprintf(stdout, "%s\n", oid_to_hex(oid));
-	return 1;
+	return 0;
 }
 
 static void print_disk_usage(off_t size)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index a47c231632..eda38a5433 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1695,7 +1695,7 @@ static void init_type_iterator(struct ewah_or_iterator *it,
 	}
 }
 
-static void show_objects_for_type(
+static int show_objects_for_type(
 	struct bitmap_index *bitmap_git,
 	struct bitmap *objects,
 	enum object_type object_type,
@@ -1704,6 +1704,7 @@ static void show_objects_for_type(
 {
 	size_t i = 0;
 	uint32_t offset;
+	int ret;
 
 	struct ewah_or_iterator it;
 	eword_t filter;
@@ -1749,11 +1750,17 @@ static void show_objects_for_type(
 
 			hash = bitmap_name_hash(bitmap_git, index_pos);
 
-			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
+			ret = show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
+			if (ret)
+				goto out;
 		}
 	}
 
+	ret = 0;
+
+out:
 	ewah_or_iterator_release(&it);
+	return ret;
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -2062,6 +2069,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 			      show_reachable_fn show_reach,
 			      void *payload)
 {
+	const enum object_type types[] = {
+		OBJ_COMMIT,
+		OBJ_TREE,
+		OBJ_BLOB,
+		OBJ_TAG,
+	};
 	struct bitmap *filtered_bitmap = NULL;
 	uint32_t objects_nr;
 	size_t full_word_count;
@@ -2086,14 +2099,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 		goto out;
 	}
 
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_COMMIT, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_TREE, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_BLOB, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_TAG, show_reach, payload);
+	for (size_t i = 0; i < ARRAY_SIZE(types); i++) {
+		ret = show_objects_for_type(bitmap_git, filtered_bitmap,
+					    types[i], show_reach, payload);
+		if (ret)
+			goto out;
+	}
 
 	ret = 0;
 out:
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 47935eb24e..ae8dc491ac 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -93,7 +93,8 @@ struct list_objects_filter_options;
 /*
  * Filter bitmapped objects and iterate through all resulting objects,
  * executing `show_reach` for each of them. Returns `-1` in case the filter is
- * not supported, `0` otherwise.
+ * not supported, `0` otherwise. Aborts iteration and bubbles up the return
+ * value in case `show_reach()` returns non-zero.
  */
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 			      const struct list_objects_filter_options *filter,

-- 
2.55.0.175.ge4962bd3d5.dirty

