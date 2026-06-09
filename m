Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509530EF8F
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972605; cv=none; b=ZlXDEg9vGSfANINwXYT3QH4oLwNkAQ13+y1wsyWqGf4UfB5XZaRCd5/ppaNfJ5HGlfLNb6KQOX9kbUYQCRwluzVMPoMOwNuleIcGGzbRTSScyo1t8t+6CDs2g7kh2Q/xhN4UBHUHcck3PanN66oassT+KUmfTKD38erB/4zNYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972605; c=relaxed/simple;
	bh=AXRhtuAnJWRAP7uHqPRUKZgMnUX3Mn2WHnQ/Rhi/6yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqtgdenVzsgr+5Xw21BbS8c/Qh4wKC2ganyt0GBXyAwuvx1eB4/r+7+gaU1tJyuzJOntMLrbZLcxpfIQEOZ8feTw6Gsn5Kv1cuO55PluIuq0JDpJR0tesSuxYNK5q/lQgGNjJVHWFQpYeiAIXN8Xo1lB2IhDo8ut0gNLwRV8ocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOTd5lYG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOTd5lYG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5175cb5946dso32483041cf.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780972603; x=1781577403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSeKilAH8SBjQ0Nr6FDN7q7IB5bMWPhIa/nX/EGaGiI=;
        b=AOTd5lYGVE/jQC7wv4V3NfTAbm7d7WNbv22XVDyHPKzpQyupizkwtNjNHfbs6ZT6D8
         3gI4n2cXV0NfvGHEBMGadg6jbYkdIZAXCd3DqBOTohd0ygXS+DBNA4GSwDwIG6chkKqW
         oj6e5zfZyx98/ziGDP2oqVSov7Azkg/ey0bfT2cQ+0DKEe+9Xnu41H3a6gKSTKoAm7ZL
         82Yo2uoqVub/gnWVtMK2GJ95BOpaP3vNl+Ra8eBIREBIccdoHOCmvhZXwWDCSmTqkofI
         6mj6TQFmVeja4YH1pt7LlOD4apoQIobf+IuIg4TQSxqXby20VWSXtiGIHi9aTNyiCRY3
         4QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780972603; x=1781577403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qSeKilAH8SBjQ0Nr6FDN7q7IB5bMWPhIa/nX/EGaGiI=;
        b=BZa4JbNahjN/sdclzg24IJ2hzC5ovZStsSDvQKNHlQPx7q6qUz4dJT74PNLsKo9HeS
         hshz3MVHP91PqJgTM3RmfLJtNEswVdDqWf8fvbYJvO7C7TCixu2jXiH9M42XiRCbLqm+
         pHU6trYSICxxKoZay2pfHQgif2Z5DrHDXH692NCzxk1JZvKbtNY1EIKda8CErnMefHkJ
         LC5D+srkm7zgxOceFf42hqWJTkB+Zi7+7JuJBw5maKNuDpFKfvcYjyFuLT+V8ve432dA
         mN/rG2OvKQat/ooEjiqz+C1K6U5z/0vnGb2JYxuggEG2lXf56OA5ajN72FnVnCZ3GCIW
         U8rg==
X-Gm-Message-State: AOJu0YwYJYslqJL01yx91iz1Tapn5fJcteynCm6AH8bXUct5Pj4e7ppj
	i97+flVYZuzwdrDpqgzpEHgrkIe0RdRXq2iqZQptmVB9yty4U4cUBiG2
X-Gm-Gg: Acq92OExTGdtk2lZIhvYCO7fgw7i/c0Mgmhwrfux/FEAUM5fp0ZRFZUBMTO+o8bW0CO
	x+3bk/cDZQlgDmcXP8G5s7TAS93R+/RcjYZVMzxWB75OZPbFhSlaUIOJwlRS0BVkM3gRF8AT8wF
	BVLhmJpjr5wBc+FkpUpSs0NRaUGeBWR8fagptHLAEz8QiYedyI6Et/4F5/undPhl1xukj9LZDX0
	9ET4mE6q1/9R2mFAtFFnavKPpJAdyKlTZ4jLDQFI8nMyMdVCa8ZpLfhh8Ndv87ihBP1TcgZ3qK4
	v9pBKxuDU10pIP4odu2t6agB9hEw1m4OPZy456CaVO1HWvCrq580C1hJ3umpJGQDiedbneUYzzD
	2QwzTTcH0thWvwDBJo9YR3BGzWY7nT4T7A8ojx5Q4uGsP2Vo0JfukBVPm8N04QCKy7rJ+jAnwWa
	PdADOtvLG4G7T3D8Q8pxyoyAVdbJvavwliPgAFxYtJ0VtBQ1EcoZ4qgdpP4ffSCUAmQsYt6LcTp
	xNxPVNiXlpb4V+lCJpqkmAuT7UEo7iFWhCqUImDNDhh7LB+spUbsPCEZt1wm1GdZUXSG2X7tEY4
	kHBN7vl8J/7hokn94epBSaZIiAWTR+5WIztl0I3sPYQ/owOz775uaFcZOqOii+OSZK06RKbS33q
	8
X-Received: by 2002:a05:622a:4d09:b0:50d:65ec:a071 with SMTP id d75a77b69052e-51795a8da05mr290766701cf.5.1780972603286;
        Mon, 08 Jun 2026 19:36:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c08234sm172718611cf.6.2026.06.08.19.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:36:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 08 Jun 2026 19:36:34 -0700
Subject: [PATCH v2 1/2] commit-reach: handle cycles in contains walk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ref-filter-memoized-contains-v2-1-e72720344a7c@gmail.com>
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
In-Reply-To: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780972599; l=5052;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=AXRhtuAnJWRAP7uHqPRUKZgMnUX3Mn2WHnQ/Rhi/6yY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAF1ejuK5DXKkq6Gxi/HzBcZEZAgV7c8WgIZ9UCvtd6pDkl+UuwHQ4ll8vzayPNZjt8LSoe1DUK
 JbTRBWvjrngM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

git tag --contains uses a memoized traversal that assumes commit
ancestry is acyclic. Replacement refs can violate that assumption,
causing the traversal to revisit a commit already on its stack
indefinitely.

Mark commits while they are active. If the traversal encounters an
active commit, discard the cache because it cannot distinguish answers
produced by the interrupted walk. Then fall back to the cycle-safe
reachability walk for that candidate.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 commit-reach.c | 30 ++++++++++++++++++++++++++----
 commit-reach.h |  3 ++-
 t/t7004-tag.sh | 21 +++++++++++++++++++++
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9b3ea46d6f..65b618959b 100644
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
@@ -787,13 +789,33 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
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
+	init_contains_cache(cache);
+
+	result = repo_is_descendant_of(the_repository, candidate, want);
+	if (result < 0)
+		exit(128);
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
index d918005dd9..1ed91bb66e 100755
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
+		git replace -d $first
+		git replace -d $third
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
2.54.0.501.g0fb508de08

