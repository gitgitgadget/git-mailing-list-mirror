Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498A2DEA89
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781233226; cv=none; b=UmwgPRXh4Lwsl1MH0YZqxTkLoRhgf1Inc4boBsmDdJDIGL7lY0uyNVcwdP2nqeLJz+eec43BKtGitB1qMMmC/f4z1LRI3lg6teeU7nM4yBtolWN8+DSRbbveKmeKM8XUmRLpXot6rngmGrJ5I6TqurO9kZ06NwL2dbBfcKJ7YW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781233226; c=relaxed/simple;
	bh=jusxLKE16e9M/h0CL8aDS3FQ1NGYxFfq5Q3gXe8WMwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtht93vaZw4OLn0ZafgWjaM3reXAiz/wkl6TcSo6P2Wog1NLO3LXZPQeuLBVQPphQKmx+OE6hlsVMGXD3vaROW1FmKoNMrdKMo5Yl24Axqj2vHZ8v9nOQaPUHf1PH9TanOUXO9tORe5Lp74deF9sOM/a96BATnkEkgusoFLBOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJGtWbpb; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJGtWbpb"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-48662d16d08so253692b6e.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781233224; x=1781838024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyCvFTHvEdJPbggs2ldh4ApHjhcsV5s30fXRxE0iVus=;
        b=SJGtWbpbMojrtGItN/pQ/01oyOEdVjgH2gOO7r6KVA8N9lHOpXXQT/a5FGPoMMYEdD
         Vf2nhdfSZiUpPIzW568GZLK1uogMyq3y704dupefOQ4UafS76G445N3H25/svYQGf9DX
         acfHyTdGKEwe05C3mqFYPPfgHwXY8AA9C0TTyUITFnWdtkTycXl5AYJcCF/Uxw/ZM+pO
         QXhdOgWsfkBp9G1ypQvR5+6T10+wyETOVbHhxbLdPJqCOpwZ2qv6SmowUEoMCPmXbgkz
         BC00ey4xpsXWffKxrg7Jlt7cLm4hvUoLYsXkmznJee0nsJTonuhHCFoeBJyVYpxgQtfI
         38fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781233224; x=1781838024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KyCvFTHvEdJPbggs2ldh4ApHjhcsV5s30fXRxE0iVus=;
        b=LUyoxTI0STdif4iKU0bH8OFnUDCwdsJth4pfpdTO20FqIflSf8R7XL6pk1r9CL5xpx
         FVvOWXrpS1QWvIjSVtC7UtOA4AxM7aBSrEikdYmyAr0xhLYxdLcON2YC4lM2B/CNlOeL
         HAc8NaQ/Ub4u2+iLwZYNIiMkU59OmY59K/zxU2vciYH+LYuhBHKYIu2c0bKR+DNnIuxz
         eyNndkwWv7YZq6OU3WnSG4RRqCJwhvKgfZj9cDOsTZwIQU/02+TJe43Mvp82Kwh32E/R
         XAmrQhbz3kWP0WZxazmi8hEEiSYHWEAdJ/hVFVugfl1CUqy1Pat2sem2Wg8ZPSydVdzO
         HWkQ==
X-Gm-Message-State: AOJu0Yz9DeYvw/1l+Hi1dnBCer+IrB89mJO36JUJpion7RAoYi75DUMl
	EP3+nExkYhw1v5RR5qLimKoj/mjXSvFDUDuNM32zDrNOLMJyUWTOY3bv
X-Gm-Gg: Acq92OFBVhuJIMSfvRhzq2K5QcUuWkA26SU3sveDV/2s3X6AFYxEMdSI7I3Ww61NbKR
	JGsLK3zirF0f7Z1hv31m8Acbr80OT+Yno6jsz1hRUljYqlAbauhhziiev+234/DhxTwI85FApe5
	O/IRQHBRscUgBj5sNKQaFBthWkp1uQE+4QWgzIXM6BEJi92PTTnIwvOdqKjt6q6cG+ixYQIkKoQ
	TM0Ln2PTsFWcd6Eypffw4lC2ZKqalGLGrqZhGyKT+6vWymQVWV/J62k0/K09h1zIeyjDOrZiqu/
	y3kx5JNR57826WvQomtDwmi5oxFrWBBJYOAspfTYUp/2kYVUoyUDUIFU2405qJHu2Q8suitZLqZ
	usxESJGrtwM4l3emCKa5fm1iW4VHEqMC64Jafe0d+awjQTu5KQnPQ02qVEkAMleHvS59gR/eimG
	2QY5seiDh4pzPZF/jFCux0Ef8KkaXEKFtBedl9M5TwIFkkkTq9iULvweTd75+eLEjvoq0mLX3YW
	aHRLpqgs/62qZLSKBEn7fkedN1hq89JqoJhh+wcIAN5ZORlP0+ewvjTqPHnyZ5TbuBddIquacsO
	h2cxoEzOTZFZPzvvmlZPuy9Fim+UmRWWHd8Phu1pizlxwtZylDI8
X-Received: by 2002:a05:6808:3a17:b0:486:4668:d7f6 with SMTP id 5614622812f47-4872f564549mr810747b6e.36.1781233224156;
        Thu, 11 Jun 2026 20:00:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([50.237.239.3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abe97c4sm702031fac.7.2026.06.11.20.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:00:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 11 Jun 2026 20:00:13 -0700
Subject: [PATCH v3 1/3] commit-reach: handle cycles in contains walk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ref-filter-memoized-contains-v3-1-b26af3dba285@gmail.com>
References: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
In-Reply-To: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Kristofer Karlsson <krka@spotify.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781233218; l=5130;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jusxLKE16e9M/h0CL8aDS3FQ1NGYxFfq5Q3gXe8WMwE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QL+gF2UDiZWv/yg36hsPTeby/sIJEsYb7+v+QEcQVkduX8QNkzMRkr6xH9iFH6EOHWKsOQavtgf
 M4E0RN/lBTws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The memoized contains traversal used by git tag assumes that commit
ancestry is acyclic. Replacement refs can violate that assumption,
causing it to keep pushing an already active commit until memory is
exhausted.

Mark commits while they are active. If the traversal encounters an
active commit, discard the cache and retry the candidate with the
cycle-safe reachability walk. Cache the candidate's result so a later
walk that reaches it can reuse the answer. Die if the fallback cannot
read ancestry.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 commit-reach.c | 29 +++++++++++++++++++++++++----
 commit-reach.h |  3 ++-
 t/t7004-tag.sh | 21 +++++++++++++++++++++
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9b3ea46d6f..1d34d66fe8 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -708,7 +708,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 
 /*
  * Test whether the candidate is contained in the list.
- * Do not recurse to find out, though, but return -1 if inconclusive.
+ * Do not recurse to find out, though, but return CONTAINS_UNKNOWN if
+ * inconclusive.
  */
 static enum contains_result contains_test(struct commit *candidate,
 					  const struct commit_list *want,
@@ -744,7 +745,7 @@ static void push_to_contains_stack(struct commit *candidate, struct contains_sta
 }
 
 static enum contains_result contains_tag_algo(struct commit *candidate,
-					      const struct commit_list *want,
+					      struct commit_list *want,
 					      struct contains_cache *cache)
 {
 	struct contains_stack contains_stack = { 0, 0, NULL };
@@ -765,6 +766,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	if (result != CONTAINS_UNKNOWN)
 		return result;
 
+	*contains_cache_at(cache, candidate) = CONTAINS_IN_PROGRESS;
 	push_to_contains_stack(candidate, &contains_stack);
 	while (contains_stack.nr) {
 		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
@@ -776,8 +778,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 			contains_stack.nr--;
 		}
 		/*
-		 * If we just popped the stack, parents->item has been marked,
-		 * therefore contains_test will return a meaningful yes/no.
+		 * A parent may have just been popped and marked, or may still
+		 * be active when replacement refs create a cycle.
 		 */
 		else switch (contains_test(parents->item, want, cache, cutoff)) {
 		case CONTAINS_YES:
@@ -787,13 +789,32 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		case CONTAINS_NO:
 			entry->parents = parents->next;
 			break;
+		case CONTAINS_IN_PROGRESS:
+			/*
+			 * Partial negative answers are not safe across a cycle.
+			 * Discard them and use the cycle-safe reachability walk.
+			 */
+			goto cycle;
 		case CONTAINS_UNKNOWN:
+			*contains_cache_at(cache, parents->item) =
+				CONTAINS_IN_PROGRESS;
 			push_to_contains_stack(parents->item, &contains_stack);
 			break;
 		}
 	}
 	free(contains_stack.contains_stack);
 	return contains_test(candidate, want, cache, cutoff);
+
+cycle:
+	free(contains_stack.contains_stack);
+	clear_contains_cache(cache);
+
+	result = repo_is_descendant_of(the_repository, candidate, want);
+	if (result < 0)
+		die(_("failed to check reachability after detecting a cycle"));
+	*contains_cache_at(cache, candidate) =
+		result ? CONTAINS_YES : CONTAINS_NO;
+	return result ? CONTAINS_YES : CONTAINS_NO;
 }
 
 int commit_contains(struct ref_filter *filter, struct commit *commit,
diff --git a/commit-reach.h b/commit-reach.h
index 3f3a563d8a..f908d305b1 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -73,7 +73,8 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
 enum contains_result {
 	CONTAINS_UNKNOWN = 0,
 	CONTAINS_NO,
-	CONTAINS_YES
+	CONTAINS_YES,
+	CONTAINS_IN_PROGRESS
 };
 
 define_commit_slab(contains_cache, enum contains_result);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d918005dd9..4044bab006 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1611,6 +1611,27 @@ test_expect_success 'checking that first commit is in all tags (hash)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'tag --contains handles cyclic replacement histories' '
+	first=$(git rev-parse HEAD~2) &&
+	second=$(git rev-parse HEAD~) &&
+	third=$(git rev-parse HEAD) &&
+	test_when_finished "
+		git replace -d $first &&
+		git replace -d $third &&
+		git tag -d cycle-a cycle-b
+	" &&
+	git tag cycle-a "$first" &&
+	git tag cycle-b "$third" &&
+	git replace --graft "$first" "$third" "$second" &&
+	git replace --graft "$third" "$first" &&
+	cat >expected <<-\EOF &&
+	cycle-a
+	cycle-b
+	EOF
+	git tag --contains="$second" --list "cycle-*" >actual &&
+	test_cmp expected actual
+'
+
 # other ways of specifying the commit
 test_expect_success 'checking that first commit is in all tags (tag)' '
 	cat >expected <<-\EOF &&

-- 
2.54.0.548.gbe7bb2469c

