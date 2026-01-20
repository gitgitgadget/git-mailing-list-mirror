Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682B30214D
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923519; cv=none; b=U6tNbohh8WUJaTtYPYrquKGpaHm9+8RxAm53cW1mr5Hk9PpwCZciqPIuO3vzF2flnQGoRJYxdtyUdzQ/FKCovMVnR7v0rEptTZloxjk1hQaD3vaaxCakCcrc0OV0w9n3x/nY4NA5477nsB3d32AmOPvSINfiHaIr+AShh979mKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923519; c=relaxed/simple;
	bh=oskOGCQwWcS38dCEGcnQbUzmqFX4ps6fpuo/NuyrRHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3A/7g0maxclqeKEC02U1nIh5EZUnOguc0V54miFVAd4Gz3YofM83bz6A1SqpDmDtnbjmBECSus4I+3AaxNKJsQBmk77MXk2IKKEN/n8nK3YCssElLKCMLnVbodXlBQ8ikX2gB4i+vf1nq8GY/+vTjH/1B/jnKz1pT4wqhsCNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTG3OiKG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTG3OiKG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34b75fba315so2744505a91.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768923517; x=1769528317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLxc0XqU4NJk5RBVeeLBBygNh6UaEVcg9GJFqwML5x4=;
        b=BTG3OiKGtppEUG5TwdoXWuoaSKHGtihdHKJkBQ2JtBTVT7cd/mSjkBGBsMOpDTVU5j
         j3M5aQNKPMyWL2QK5KqQvvhAlRW6SG1VeFK4ITNI3k3Ce4ZhyF3I+Xc/azXDpiMTuD/r
         F5++orZlZBhSVehu81xIkoS3/EKhsa4foX+7rHoieHwZkqoFdmm6npK4ECQcRrlYE64g
         hWF4pQiTZcjNXRYvVfLhsgV+kXLu9iac0CkczJJtY63oW3u1UsTOVqn5aeubtKwNV2iV
         fzH6PnboWHvJcE0OT4dYhzHy5Rvy5+7Kocs6gKoOCYMHnlVSaMPb+HZhYsyAagvkVFYE
         8ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923517; x=1769528317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PLxc0XqU4NJk5RBVeeLBBygNh6UaEVcg9GJFqwML5x4=;
        b=wpWS+/w7CkqeNI3QxDtvNT4HXR//dA4DdsAtNtAMAbGC6hI3K9MvvUZy+cxq+/6cgs
         LXl/qBessEIdvQO25CcNPkdcpxJAFos7q7yMy6QZ9256cj1azknf+xloLKBSHO07hQ2F
         An6wSI3g8irKRi93bXs5CaxbVfWGK+oHRi8SFfXCUS2vV1QdP7JXZfWarjAgK3+D367f
         PzML+W7PNACbKcswcqYN+rSaBQIqQjSLidyZH/zbwE1seMy1YMFqSO0DOcVAR6vDWnfD
         7F3PT/bEihYREAjtx1UdVAoVGAaCzZ/nWXNhUVWLSiU5mhmtYZinpTDB9NPxt3WR/pBm
         +eUw==
X-Gm-Message-State: AOJu0YwJG+Lo4+gax8s9LJZhUmAZld2PVraGEhKy/Pg5XtZps9F+oVRL
	zVhYeIAOWvQauzFcb4jANWK9fYzWOImE8S6LMl7cURuvJoo0BZ3VSzr9rWynUa4a
X-Gm-Gg: AZuq6aIa861bExXCH0d2QQKSFtgyMGY3/9Lk4Hmklc6Jhfhpu9dx+S3AvdmsVhSz77t
	cSTYwYP+nRuP8QvDsB6UE5JDLOK7R/vrHxzZPtsDK67o3THrFqk4Hkcab/uu2wvilIINLk3cnNB
	m1tSgPxEJGvNkRNMq5QwouZTMUzVO1IDkLOEtdCE3iv8fne8pMyx+jnalnO96C2ebzUpESz576y
	Na5SU16Bsd25Qmqx43QAMlLfjoSt9drcyBmzJLNmjdAHwf7AW50Xl3Er47pTZvEUBZBqrhnHQKx
	8BO99PSGSVxFExKieZvTfKHb1hFBqCdO3CwVCQ66xc3xtcygJjxE+88OrBgvcB2wC3MwirZBqlA
	JfQq35nFUPvVzdyz+LzjyqWj7tVaeV+OBH3gGF/J7b4ssplO3V5wjhTs2ECdSINr76OpWLgYFdF
	05Hl0Vrzsdu2ZmNIPgjl28jCOF3tUbUb8HLIJwXDY/sQkejJZAkJsL2wQTdFtlQS1U1Zd9MLN4u
	BYs9w==
X-Received: by 2002:a17:90b:1e44:b0:352:cdda:7aa7 with SMTP id 98e67ed59e1d1-352cdda7f6amr1596424a91.24.1768923516705;
        Tue, 20 Jan 2026 07:38:36 -0800 (PST)
Received: from localhost.localdomain ([115.98.233.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527306e6a6sm12491070a91.8.2026.01.20.07.38.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jan 2026 07:38:36 -0800 (PST)
From: amisha <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	amisha <amishhhaaaa@gmail.com>
Subject: [PATCH v6] sparse-checkout: optimize string_list construction and add tests to verify deduplication.
Date: Tue, 20 Jan 2026 21:08:29 +0530
Message-ID: <20260120153829.48044-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114192803.4852-1-amishhhaaaa@gmail.com>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <amishhhaaaa@gmail.com>

Improve O(n^2) complexity to O(n log n) while building a sorted
'string_list' by constructing it unsorted then sorting it
followed by removing duplicates.

sparse-checkout deduplicates repeated cone-mode patterns,
but this behaviour was previously untested, add tests that
verify that sparse-checkout file contain each cone
pattern only once and sparse-checkout list reports each pattern
only once.

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/sparse-checkout.c          |  7 +++--
 t/t1091-sparse-checkout-builtin.sh | 48 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..7dfb276bf0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -91,10 +91,11 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
 			/* pe->pattern starts with "/", skip it */
-			string_list_insert(&sl, pe->pattern + 1);
+			string_list_append(&sl, pe->pattern + 1);
 		}
 
 		string_list_sort(&sl);
+		string_list_remove_duplicates(&sl, 0);
 
 		for (i = 0; i < sl.nr; i++) {
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
@@ -289,7 +290,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	string_list_sort(&sl);
@@ -311,7 +312,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	strbuf_release(&parent_pattern);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b2da4feaef..ede5c6b3f3 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -817,6 +817,54 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	test_cmp expect out
 '
 
+test_expect_success 'sparse-checkout deduplicates repeated cone patterns' '
+    rm -f repo/.git/info/sparse-checkout &&
+    git -C repo sparse-checkout init --cone &&
+    git -C repo sparse-checkout add --stdin <<-\EOF &&
+	foo/bar/baz
+	a/b/c
+	foo/bar/baz
+	a/b
+	EOF
+    cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/a/
+	!/a/*/
+	/foo/
+	!/foo/*/
+	/foo/bar/
+	!/foo/bar/*/
+	/a/b/
+	/foo/bar/baz/
+	EOF
+    test_cmp expect repo/.git/info/sparse-checkout
+'
+
+test_expect_success 'sparse-checkout list deduplicates repeated cone patterns' '
+    rm -f repo/.git/info/sparse-checkout &&
+    git -C repo sparse-checkout init --cone &&
+    cat <<-\EOF >repo/.git/info/sparse-checkout &&
+	/*
+	!/*/
+	/a/
+	!/a/*/
+	/foo/
+	!/foo/*/
+	/foo/bar/
+	!/foo/bar/*/
+	/a/b/
+	/foo/bar/baz/
+	/foo/bar/baz/
+	EOF
+    git -C repo sparse-checkout list >actual &&
+    cat <<-\EOF >expect &&
+	a/b
+	foo/bar/baz
+	EOF
+    test_cmp expect actual
+'
+
 test_expect_success 'malformed cone-mode patterns' '
 	git -C repo sparse-checkout init --cone &&
 	mkdir -p repo/foo/bar &&
-- 
2.51.0

