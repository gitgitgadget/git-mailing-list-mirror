Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A94839EF
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409161; cv=none; b=iZO0JNvyhzuMqI6hb+VZ7D5P/igob0tyBUi8lkXP8p2F8PjkKxR2dCwjLcrMEh5634/o8RhsmzSLNs1g0g6mpLBXFRnXjhZKh8vIMongBkY0cmG2AKoQUPGGuGKzIMgh9YYaj2+vO9JVXQvE77MHWZtft1tB0uJuAwTKt7ngPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409161; c=relaxed/simple;
	bh=GL9BgVDFmb76mgSuqC8c+GT5wzTCz6IlPJW3bZGn+H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqRRKfEgHBQ1plo0tCCN8zKmvKEy3APZEXsP3H61w2AqOXVJeDo0LAZ/Zx3jGXIGc+yU89ufaI3j0K79ZYbufJnzlx6c9QGBe4jzkd6IXSTlb7zbUlYcjbsB9G6V1W+i1+VPdwAxTxfSW8YnjQCvyQ/SWUX7pCpe0F5Dwz8eJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+OrmSrH; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+OrmSrH"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-222ba2a19bdso3145851fac.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409158; x=1712013958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJb8/Ayj8/e4RQyxmhoS1I5gBTm8FWTfv6n8IcU6NAs=;
        b=c+OrmSrHRpOGYx6bO99WAJbN083K02jETG8ARy2PSYKmLRnUHCzjCIT8Zf0n5Ot9Lo
         7IfykJDRJgdn0X2SSSx6+9Kq9l4ztS1jy5cB4WbkOkiixm5suXQiWgRxSdqBqyBYGIvE
         B7vDWAytJRiRxONTGb/Jw1EKvSZQSppzCwxy758Wo5MEzhU5x4tgBYJoj1gVOV6sQtef
         yJCBpO3lscph78e1T4n3mvM3NwmCtXxRtInA09Id79CzUZO7ZsAfy9sbKO0GVXbyNL/h
         lh5CU6vmpc2ucl3qEzH79hCM66NsmW0AXUfFLv/L35AZA1VhydINXTnzXx/K1nwQvaPs
         77dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409158; x=1712013958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJb8/Ayj8/e4RQyxmhoS1I5gBTm8FWTfv6n8IcU6NAs=;
        b=MXbOD7fzE8a3cVrj86ebDQtBn4cpoMzOWvxe2J0kv233XEzkS8AO4H2rrBBqn65Pzw
         1xEJJuILjwz12C7sUMn/s9e/Fc90RROH2q/M+UcC+7mTfvQEvjgciBNZtuoP8/F51saR
         YE+Qcx7msbfRqD5UMC6q9ewsdR/kAXMI4/I3bXCPPxYdoupAbOe556Xxh4du34+/sGZj
         FCzTtsgNvxmwy+Kz4mjjUsYJjgoYClmkyW2uz0IYZcam8NCh9HrijdXAxurH8rRMmAcP
         Q8TC3+RmRRVglJDnuj30b3Pad4N3znBP0FiD68/F5yX9cCUUbDe2cR5GecVahPfNx6FX
         U23A==
X-Gm-Message-State: AOJu0YxxEiur94CN4qmKIi4EUf77PtzPmRkk9uwL5as7MorPG+zVIXW5
	1853Q3skkI6+23h/vQlcUb9kGtakChpR8IjVwOpyHqvXYCfhikmXGuW6ARc8EEw=
X-Google-Smtp-Source: AGHT+IFXYrAUAkTk5au2cUnwhlCeg8BHmhgPmWWuDgDVAO/jp4rG4SiSYjjzK/PfszuOosOjmuhCiQ==
X-Received: by 2002:a05:6870:658b:b0:222:7217:f919 with SMTP id fp11-20020a056870658b00b002227217f919mr10277634oab.8.1711409158302;
        Mon, 25 Mar 2024 16:25:58 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id vp8-20020a056871a00800b0022a1d794bb8sm1454868oab.22.2024.03.25.16.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:25:57 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 4/7] sequencer: handle unborn branch with `--allow-empty`
Date: Mon, 25 Mar 2024 18:16:51 -0500
Message-ID: <20240325232451.963946-5-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
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

Detect unborn branches in `is_index_unchanged`. When on an unborn
branch, use the `empty_tree` as the tree to compare against.

Add a new test to cover this scenario. While modelled off of the
existing 'cherry-pick on unborn branch' test, some improvements can be
made:

- Use `git switch --orphan unborn` instead of `git checkout --orphan
  unborn` to avoid the need for a separate `rm -rf *` call
- Avoid using `--quiet` in the `git diff` call to make debugging easier
  in the event of a failure. Use simply `--exit-code` instead.

Make these improvements to the existing test as well as the new test.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Changes from v4:

- Use single-line block comment style since the comment is a single line
  of text.
- Wrap two longer lines of code.

 sequencer.c                   | 43 +++++++++++++++++++++++------------
 t/t3501-revert-cherry-pick.sh | 14 +++++++++---
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f49a871ac0..e3f0a52f72 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -770,29 +770,42 @@ static struct object_id *get_cache_tree_oid(struct index_state *istate)
 static int is_index_unchanged(struct repository *r)
 {
 	struct object_id head_oid, *cache_tree_oid;
+	const struct object_id *head_tree_oid;
 	struct commit *head_commit;
 	struct index_state *istate = r->index;
+	const char *head_name;
+
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
+		/* Check to see if this is an unborn branch */
+		head_name = resolve_ref_unsafe("HEAD",
+			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			&head_oid, NULL);
+		if (!head_name ||
+			!starts_with(head_name, "refs/heads/") ||
+			!is_null_oid(&head_oid))
+			return error(_("could not resolve HEAD commit"));
+		head_tree_oid = the_hash_algo->empty_tree;
+	} else {
+		head_commit = lookup_commit(r, &head_oid);
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
-		return error(_("could not resolve HEAD commit"));
-
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
index aeab689a98..af73227512 100755
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
+	git diff --exit-code initial &&
+	test_cmp_rev ! initial HEAD
+'
+
+test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
+	git checkout --detach &&
+	git branch -D unborn &&
+	git switch --orphan unborn &&
+	git cherry-pick initial --allow-empty &&
+	git diff --exit-code initial &&
 	test_cmp_rev ! initial HEAD
 '
 
-- 
2.43.2

