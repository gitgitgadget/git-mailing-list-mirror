Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A015A843
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248846; cv=none; b=oCRXw3i2lP3Luujxl0mlcQxKCC58mMvmDjtUFhEQFnefEvfgOi+nm/Xe8OPTjMXumyfS6jTjtMM4FjEWipTuAcePfmKt+ruHNT/abX9Iw2yKonZJQEjsbRpBZWQ4OwoPuKl8pLXjbbHKAknzh0pMdZCzc2JLwOxA39hlkd1cnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248846; c=relaxed/simple;
	bh=Bnq430iX27FMEeO5qcoWMwcNhZZWfcot7Mo3CNlGUS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW2d5qGJLTJeqyxnDydMJk2e5nuaHtfAzLhbzdEPf9aHFr6etmlqbxf1RoXn+WI3MFee7L4Ex8zDAMRFmx92Z8t+7QwuuA2njggSWSfD2J635XTgfNvN7mhb7maDJTehzL8749o0Knzf6hSVqixigAom/IRdpyU+wREvcezru5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dmUesqCe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dmUesqCe"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718d606726cso4261764b3a.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727248843; x=1727853643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5TDgmeTuAo+C9igovuSouIzmONxO/yr3q7/axRP3IU=;
        b=dmUesqCeAPuO+Gwg2uQQXs8CYWmRevpKZ8oT5r2nHGILThPNHsG/OWD8Muv2qhiH5N
         HqgmMH8eBqLk+TYDb3hCBTzT09hQ4ubZs2DGuvjZipRjuppdHYHQPvJF6InULDyr8ygH
         enaoo2eiRImIz+X8wbn/17NVncrH+PdnyRxymdbOJGm6cVeSjV/cMMIPsRZYm02Ue718
         auew6q3ex90MAB5ueyU3wWlgYc82IJpmanJy72tPjTlBDmyudDD1vAIIFowuq1EbKdUR
         Jmq7oDGsRJd0hIrIES/z0N9Gct/1CZEbupNsSMS6k5fay8tUrc289kcWLI+S3wllAM5Y
         +oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727248843; x=1727853643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5TDgmeTuAo+C9igovuSouIzmONxO/yr3q7/axRP3IU=;
        b=khM6WrcEa7l9l5vxx+niySkNwDFcomQA51dG298fY4XE0bY0qKzhZz+F2RBJ/Fsu/q
         KnlIrHIp1Jo5uPWCUAPEXiXopn1Q1zCh5fREOJ8CYaHM7iusMt/Z1363YpZ1V0aeUXSv
         KnP8v30yT15YlrhVKNTFjiutWD8Yoz1/2Um7XwD7amO6NnwQql9ZXorq/fw85j5pE0R6
         pmTbs4RL725LgAkO6f3Ibgj5ItVVqC8dHcwQ3FvkNLCjkZ2KAChur6rKyWCrgvcGa1B4
         SzVun07jII0+T+YK7+Iy+pfea5OXYXgxD5hwVV5MUd0aqS4IYfLyVauwaaR4bOIOUbHL
         zbZA==
X-Gm-Message-State: AOJu0YyDmlS3ZHEgzDd7UvSRHSeygcTGVeC/o0R0N1G/UVcSTRxfGLsH
	OkQ8+/cnrTSH0J5/QuomXKGjp1sJHqtazGGhumTveJIuwB0IjiByOzPLq7XLwIMgPobRzHsel9m
	c
X-Google-Smtp-Source: AGHT+IHMJj368QJ49nhWA35osaJRGN7pNqtn+HQkQcHGqVhGlccKqFUJTYA2KNprseD09OZ08LKnrQ==
X-Received: by 2002:aa7:93ac:0:b0:718:e188:fdf1 with SMTP id d2e1a72fcca58-71b0ac5157bmr2151121b3a.20.1727248843235;
        Wed, 25 Sep 2024 00:20:43 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc938e25sm2185838b3a.131.2024.09.25.00.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:20:42 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 2/2] t0410: adapt tests to repack changes
Date: Wed, 25 Sep 2024 15:20:21 +0800
Message-ID: <20240925072021.77078-3-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925072021.77078-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240925072021.77078-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous commit, we changed how partial repo is cloned.
Adapt tests to these changes. Also check gc does not delete normal
objects too.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 t/t0410-partial-clone.sh | 68 +---------------------------------------
 1 file changed, 1 insertion(+), 67 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 34bdb3ab1f..c169b47160 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -499,46 +499,6 @@ test_expect_success 'single promisor remote can be re-initialized gracefully' '
 	git -C repo fetch --filter=blob:none foo
 '
 
-test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
-	rm -rf repo &&
-	test_create_repo repo &&
-	test_commit -C repo one &&
-	test_commit -C repo two &&
-
-	TREE_ONE=$(git -C repo rev-parse one^{tree}) &&
-	printf "$TREE_ONE\n" | pack_as_from_promisor &&
-	TREE_TWO=$(git -C repo rev-parse two^{tree}) &&
-	printf "$TREE_TWO\n" | pack_as_from_promisor &&
-
-	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo gc &&
-
-	# Ensure that exactly one promisor packfile exists, and that it
-	# contains the trees but not the commits
-	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
-	test_line_count = 1 promisorlist &&
-	PROMISOR_PACKFILE=$(sed "s/.promisor/.pack/" <promisorlist) &&
-	git verify-pack $PROMISOR_PACKFILE -v >out &&
-	grep "$TREE_ONE" out &&
-	grep "$TREE_TWO" out &&
-	! grep "$(git -C repo rev-parse one)" out &&
-	! grep "$(git -C repo rev-parse two)" out &&
-
-	# Remove the promisor packfile and associated files
-	rm $(sed "s/.promisor//" <promisorlist).* &&
-
-	# Ensure that the single other pack contains the commits, but not the
-	# trees
-	ls repo/.git/objects/pack/pack-*.pack >packlist &&
-	test_line_count = 1 packlist &&
-	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
-	grep "$(git -C repo rev-parse one)" out &&
-	grep "$(git -C repo rev-parse two)" out &&
-	! grep "$TREE_ONE" out &&
-	! grep "$TREE_TWO" out
-'
-
 test_expect_success 'gc does not repack promisor objects if there are none' '
 	rm -rf repo &&
 	test_create_repo repo &&
@@ -569,7 +529,7 @@ repack_and_check () {
 	git -C repo2 cat-file -e $3
 }
 
-test_expect_success 'repack -d does not irreversibly delete promisor objects' '
+test_expect_success 'repack -d does not irreversibly delete objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
 	git -C repo config core.repositoryformatversion 1 &&
@@ -583,40 +543,14 @@ test_expect_success 'repack -d does not irreversibly delete promisor objects' '
 	TWO=$(git -C repo rev-parse HEAD^^) &&
 	THREE=$(git -C repo rev-parse HEAD^) &&
 
-	printf "$TWO\n" | pack_as_from_promisor &&
 	printf "$THREE\n" | pack_as_from_promisor &&
 	delete_object repo "$ONE" &&
 
-	repack_and_check --must-fail -ab "$TWO" "$THREE" &&
 	repack_and_check -a "$TWO" "$THREE" &&
 	repack_and_check -A "$TWO" "$THREE" &&
 	repack_and_check -l "$TWO" "$THREE"
 '
 
-test_expect_success 'gc stops traversal when a missing but promised object is reached' '
-	rm -rf repo &&
-	test_create_repo repo &&
-	test_commit -C repo my_commit &&
-
-	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
-	HASH=$(promise_and_delete $TREE_HASH) &&
-
-	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo gc &&
-
-	# Ensure that the promisor packfile still exists, and remove it
-	test -e repo/.git/objects/pack/pack-$HASH.pack &&
-	rm repo/.git/objects/pack/pack-$HASH.* &&
-
-	# Ensure that the single other pack contains the commit, but not the tree
-	ls repo/.git/objects/pack/pack-*.pack >packlist &&
-	test_line_count = 1 packlist &&
-	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
-	grep "$(git -C repo rev-parse HEAD)" out &&
-	! grep "$TREE_HASH" out
-'
-
 test_expect_success 'do not fetch when checking existence of tree we construct ourselves' '
 	rm -rf repo &&
 	test_create_repo repo &&
-- 
2.46.0

