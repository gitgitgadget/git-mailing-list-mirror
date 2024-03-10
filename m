Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20C3A1A8
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096422; cv=none; b=JSTjoD4qkRp7/jxBZnG4AyGxR7LIiT1UUFvkGz5JXbH4lEHIXPrPxNSjYuC/wb4/IJizbAoaiLQ3vgwEvVgMkc8LzQOwS8RUNgcP5IhJ8MWjs6ASUlpC2tyN8XVAVlrJSURxXdHFWbIn4YP7NAKUMeEq5qnt5TL4jpEsywr/n00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096422; c=relaxed/simple;
	bh=tRXzabMDk8NQftxTh819yZYzVC00Uduv2ICpc827F04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuOozxD3Ze6/gF6BNeOJ3en+1DXf6c8iUSinRg5KKMmTGx4RNTCjjLx9UTiEJQ9XseUMx01PMfKTLd3SI7aYS+bn8Y4sVwO8dcVT/HkyRFVydotUOdws8AJW6ji5w4/gmlVftQ4tupJGmyzzS93KB/MqWllQUahVpcPHFPII0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbOYsXzo; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbOYsXzo"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e4f8f140c1so1626268a34.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710096419; x=1710701219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uz4VRs1f0UH3OWDdEqhhhKJL8WUSTK/k2roHiE1nlrc=;
        b=SbOYsXzo7n2JeitmwK60LPr0nhOADulv18irZCVWqu3Vg5WkmBUlXcGosHlv+kbCu+
         uUXx425Am90ti21ixTY85jVjpXYlL/R8YSXxI4bvLLzSeg+Rwe/PAFPAkakNuS72Cqce
         QBjSOo6rAk4nHEtgEu+EzQSQOa8fTXy/IPffCk+wEZBsO2yQEsuB1PH4Sl9I4GzSHPSL
         5PKn3VkAA1qbqBroTZcsBlaczolgBy+CZsBnxWW3t95kwZ5QKRH/zQ7FoUCq6Dnt2CQ4
         wvuASjxQWh6lVYBfSd+ifekarF+D8GxCjiywetB8egYCbLD6rZD66Ikb7fjGiOtritNH
         1t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096419; x=1710701219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uz4VRs1f0UH3OWDdEqhhhKJL8WUSTK/k2roHiE1nlrc=;
        b=GZPA5aMdSIKCfQ37zF1+BYYbHpKRVLJfz5VNCh0rAblh8PBAwYaOzgSBe+7Y7LG4Ee
         jLpe+UzG8vjyWfRVwRFe0Fp0fCFeUfgS2IdOKIVZOWlFHsO6IpE+w6qawnF4MxvKcV0S
         Z7lSvj5HH0k+S+zX43aC9ev5Hisq0WYrDcOE7M6qe31xCO+h0n8lfT5yWNz0sOszKpSK
         hJLG1ndfWkoeYqg9ezzRUQVrkbPe0NpXS1fSS6qDwgBprO31OX7Kbc86QoO6qcBZ67FR
         T08qh7tKB1y6IyPz3UsiJUvET9LHMCongc02Mkh2LhPaS2M8MxRdVVoj0Ckn4yEPaC+i
         QB1Q==
X-Gm-Message-State: AOJu0YxaS48RDhi/ZAonb5pDcuJnqjjBwXiEmB17ob1u1iaqiXasQpr4
	Pvi8FZhYWXlSKNcNKTsi0Pdx63uCyByJZfvsLNwb8Lt6gC5LcUfOV0FCLg9vRcE=
X-Google-Smtp-Source: AGHT+IGpj+fCsFWZLs7ZcDxd8jJzwcl3zHCuGHbQGLGm3d7W0DOF0wt9wMKH/Rpx41Wn075efkm+ag==
X-Received: by 2002:a9d:65d1:0:b0:6e4:e71c:e60f with SMTP id z17-20020a9d65d1000000b006e4e71ce60fmr6418145oth.12.1710096419315;
        Sun, 10 Mar 2024 11:46:59 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a0568302b0800b006e4c97ec1f4sm742131otv.69.2024.03.10.11.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:46:58 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 4/7] sequencer: treat error reading HEAD as unborn branch
Date: Sun, 10 Mar 2024 13:42:03 -0500
Message-ID: <20240310184602.539656-5-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using git-cherry-pick(1) with `--allow-empty` while on an unborn
branch, an error is thrown. This is inconsistent with the same
cherry-pick when `--allow-empty` is not specified.

Treat a failure reading HEAD as an unborn branch in
`is_index_unchanged`. This is consistent with other sequencer logic such
as `do_pick_commit`. When on an unborn branch, use the `empty_tree` as
the tree to compare against.

Add a new test to cover this scenario. While modelled off of the
existing 'cherry-pick on unborn branch' test, some improvements can be
made:

- Use `git switch --orphan unborn` instead of `git checkout --orphan
  unborn` to avoid the need for a separate `rm -rf *` call
- Avoid using `--quiet` in the `git diff` call to make debugging easier
  in the event of a failure

Make these improvements to the existing test as well as the new test.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Differences from v2:

- Minor code and test cleanup per [1] and the other replies in that
  thread

[1]: https://lore.kernel.org/git/62247a1c-0249-4ce1-8626-fe97b89c23dc@gmail.com/

 sequencer.c                   | 35 +++++++++++++++++++++--------------
 t/t3501-revert-cherry-pick.sh | 14 +++++++++++---
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f49a871ac0..a62ce244c1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -770,29 +770,36 @@ static struct object_id *get_cache_tree_oid(struct index_state *istate)
 static int is_index_unchanged(struct repository *r)
 {
 	struct object_id head_oid, *cache_tree_oid;
+	const struct object_id *head_tree_oid;
 	struct commit *head_commit;
 	struct index_state *istate = r->index;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
-		return error(_("could not resolve HEAD commit"));
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
+		/*
+		 * Treat an error reading HEAD as an unborn branch.
+		 */
+		head_tree_oid = the_hash_algo->empty_tree;
+	} else {
+		head_commit = lookup_commit(r, &head_oid);
 
-	head_commit = lookup_commit(r, &head_oid);
+		/*
+		 * If head_commit is NULL, check_commit, called from
+		 * lookup_commit, would have indicated that head_commit is not
+		 * a commit object already.  repo_parse_commit() will return failure
+		 * without further complaints in such a case.  Otherwise, if
+		 * the commit is invalid, repo_parse_commit() will complain.  So
+		 * there is nothing for us to say here.  Just return failure.
+		 */
+		if (repo_parse_commit(r, head_commit))
+			return -1;
 
-	/*
-	 * If head_commit is NULL, check_commit, called from
-	 * lookup_commit, would have indicated that head_commit is not
-	 * a commit object already.  repo_parse_commit() will return failure
-	 * without further complaints in such a case.  Otherwise, if
-	 * the commit is invalid, repo_parse_commit() will complain.  So
-	 * there is nothing for us to say here.  Just return failure.
-	 */
-	if (repo_parse_commit(r, head_commit))
-		return -1;
+		head_tree_oid = get_commit_tree_oid(head_commit);
+	}
 
 	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
 		return -1;
 
-	return oideq(cache_tree_oid, get_commit_tree_oid(head_commit));
+	return oideq(cache_tree_oid, head_tree_oid);
 }
 
 static int write_author_script(const char *message)
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index aeab689a98..8a1d154ca6 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -104,11 +104,19 @@ test_expect_success 'revert forbidden on dirty working tree' '
 '
 
 test_expect_success 'cherry-pick on unborn branch' '
-	git checkout --orphan unborn &&
+	git switch --orphan unborn &&
 	git rm --cached -r . &&
-	rm -rf * &&
 	git cherry-pick initial &&
-	git diff --quiet initial &&
+	git diff initial &&
+	test_cmp_rev ! initial HEAD
+'
+
+test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
+	git checkout --detach &&
+	git branch -D unborn &&
+	git switch --orphan unborn &&
+	git cherry-pick initial --allow-empty &&
+	git diff initial &&
 	test_cmp_rev ! initial HEAD
 '
 
-- 
2.43.0

