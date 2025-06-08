Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29F15D1
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749364552; cv=none; b=tu+g7uB2DiJbF+R0u482vWR10lN39ggUf3+kST+Zcw7bL91cUMK9XPJcdbWYlWMezLJzyD6tmVqNRLcVKCd4wYpskbA0SiTUy7vZm6khNEFmBp+BXGQfzqSLMvY57htp5PZC98la/kMc+uJlss70oHyk964DFy0AxeNyliQFh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749364552; c=relaxed/simple;
	bh=0caWek2VITVrKBGGTOde75+Uuj2elLX+bVhlEPHc5fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLAPQi5CLnQaZhMZUEiZsWl7MLkMRECq5QvHtfVvc7VhEHiGFc2fqzqFCV1oTFFUye0EGpyW+m7u4/iT/j6fdhCVgP1tLYvrhgzxX9KsaytanJwOLD36MnIIQ98U0lwCQnh4PlGOKKpka0A4liLjwijiH9HosF0uI/MQsCU0Lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxTF5tFz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxTF5tFz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2345c60507bso23732825ad.0
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 23:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749364550; x=1749969350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVRv2OJGGxNZ7nC3pqtk5+gmDKzpDSPHe9ItjCZcQGQ=;
        b=DxTF5tFztihqph161jcQSplyRRvo1sbkCCCH48L1d+l82+bCv0jnBteVqikKwbfFna
         Ndg3Mq1A9FgBQyJWH1IyNDkMIARNUQs5LPAHK/q2QDOqHGRTQ8JykkSGeMgl8Hnf0Msw
         HISB0RA+et6lK6NQKXM9RR6W4KBuMCnDdhe0UeJuIlbo9j5GJeNTUgpfYOgolFcvJVzI
         hP1hGGXO5xYkSDthQewJBcA0muOCFVWvLay50AncVxB+Pe98pPhGVsQPlhRDruUH4WTT
         Vm2uPV8dcFcvdGHjuqa7NX5p4PUfXIGJl3U+N6TJlGZu2Nm3UDW6l+EqsUBAKz9Uupsc
         /lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749364550; x=1749969350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVRv2OJGGxNZ7nC3pqtk5+gmDKzpDSPHe9ItjCZcQGQ=;
        b=BoBptBJjIiLen0Wj5vb3uXBlr5Ky3v49tmtI2Zij5QQ03SJoeG7mVHrkC4nzE6AXvF
         UIW1ja8/ZxHpqVSBtKcwqwnXuhgsv9dx4hlxbLSHnaKl37GqcEk9VIvEg7zc/AAPYOVm
         9NAGCz6p1RBRwFiMWeZokbBpK3QaPlBJY4aE/oHB542Eo+yEJae3L0k/evy5VIVa/PC1
         svIdIqqYRR3nA0Gh3YP+6C60n9nWu0u47CjoETXpqopwHbzYcEu3exBvoKWlNCnISgVF
         M/vPtrKsMN7wZvpK6RNUZpBQUpfCG8uElXqGHH6uN3Xdo7ehoUuHNMGCtruK9CLVz4Av
         FFXw==
X-Gm-Message-State: AOJu0YwkIMrC5dtYSzDWbsaP6NdzARATa3338BZzbF6Bx8tRS/ohquDJ
	6klrv7ZcyDwUV8JoMGcN3LVkInf4DeGm3UQFtLmoY/2JlTH9+0rFwKHr
X-Gm-Gg: ASbGncvJSsjIdhq3XikLrlXskin9qybDVfoTGBvgsfbfppsAz+5WMqzBw5RgttD1QBE
	uOZA17jJa25bP/rsUnzlm6MDqiRT4n3niv1MhBMJsc2sZv4hOnYvnR4v2/2e9goC6wVZsXkYmsY
	H+6cLaBFdtxEaDG52jLlNk8rG/bT0fhp8gBsif6EMlY+Y16i6tls1sBaIwSL4+GijB+Op4PitNN
	PC+5sceoh4Fh+ycoQa3VS+z4MX6TNzHLszF9IPKAUbRebZ8ymsj5ZthdhW2nuQAHTGALQq4E69r
	tiOJ/f9NlQeNSRbC668EjOI/YICSVzAsvlzdHE7o2/q+YLz9f6sqbFd4Ngzr4gO3gTkb1MLttg4
	=
X-Google-Smtp-Source: AGHT+IFuMNS1FTZGpPavzk2hMPSgZBwRVGWZc8M2NQ7Ukc+y8h5qHjqsBsANiSyf5BVEC2FcmkZQjw==
X-Received: by 2002:a17:902:e74b:b0:235:779:edfa with SMTP id d9443c01a7336-23601d9782bmr127855725ad.32.1749364550534;
        Sat, 07 Jun 2025 23:35:50 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603507281sm35267245ad.240.2025.06.07.23.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 23:35:50 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	smacdonald@kaimaging.com,
	sunshine@sunshineco.com
Subject: [PATCH] stash: fix incorrect branch name in stash message
Date: Sun,  8 Jun 2025 12:05:37 +0530
Message-ID: <20250608063537.233243-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <xmqq7c2jcodj.fsf@gitster.g>
References: <xmqq7c2jcodj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a stash, Git uses the current branch name
of the superproject to construct the stash commit message.
However, in repositories with submodules,
the message may mistakenly display the submodule branch name instead.

This is because `refs_resolve_ref_unsafe()` returns a pointer to a static buffer.
Subsequent calls to the same function overwrite the buffer,
corrupting the originally fetched `branch_name` used for the stash message.

Use `xstrdup()` to duplicate the branch name immediately after resolving it,
so that later buffer overwrites do not affect the stash message.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
This this patch was long due, and submodules patchs had a design choices 
Refined this patch Added tests and freed the leak as intended.

 builtin/stash.c  | 19 +++++++++++++++----
 t/t3903-stash.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..13606efb12 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1372,6 +1372,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	const char *head_short_sha1 = NULL;
 	const char *branch_ref = NULL;
 	const char *branch_name = "(no branch)";
+	char *branch_name_buf = NULL;
 	struct commit *head_commit = NULL;
 	struct commit_list *parents = NULL;
 	struct strbuf msg = STRBUF_INIT;
@@ -1401,11 +1402,20 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		ret = 1;
 		goto done;
 	}
-
-	branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+	
+	branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository), 
 					     "HEAD", 0, NULL, &flags);
-	if (flags & REF_ISSYMREF)
-		skip_prefix(branch_ref, "refs/heads/", &branch_name);
+
+	if (flags & REF_ISSYMREF) {
+		const char *tmp = NULL;
+		if (skip_prefix(branch_ref, "refs/heads/", &tmp))
+			branch_name_buf = xstrdup(tmp); 
+	}
+	if (branch_name_buf)
+		branch_name = branch_name_buf;
+	else
+		branch_name = "(no branch)";
+					    
 	head_short_sha1 = repo_find_unique_abbrev(the_repository,
 						  &head_commit->object.oid,
 						  DEFAULT_ABBREV);
@@ -1495,6 +1505,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	strbuf_release(&msg);
 	strbuf_release(&untracked_files);
 	free_commit_list(parents);
+	free(branch_name_buf);
 	return ret;
 }
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4..5d5aac8b15 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1592,4 +1592,43 @@ test_expect_success 'stash apply reports a locked index' '
 	)
 '
 
+test_expect_success 'stash reflog message uses superproject branch, not submodule branch' '
+	git init main_project &&
+	(
+		cd main_project &&
+		echo "Initial content in main_project" > main_file.txt &&
+		git add main_file.txt &&
+		git commit -q -m "Initial commit in main_project"
+	) &&
+
+	git init sub_project &&
+	(
+		cd sub_project &&
+		echo "Initial content in sub_project" > sub_file.txt &&
+		git add sub_file.txt &&
+		git commit -q -m "Initial commit in sub_project"
+	) &&
+
+	(
+		cd main_project &&
+		git -c protocol.file.allow=always submodule add --quiet ../sub_project sub &&
+		git commit -q -m "Added submodule sub_project" &&
+
+		git checkout -q -b feature_main &&
+		(
+			cd sub &&
+			git checkout -q -b feature_sub
+		) &&
+
+		git checkout -q -b work_branch &&
+
+		echo "Important work to be stashed" > work_item.txt &&
+		git add work_item.txt &&
+		git stash push -q -m "custom stash for work_branch" &&
+
+		git stash list > ../actual_stash_list.txt &&
+		grep "On work_branch: custom stash for work_branch" ../actual_stash_list.txt
+	)
+'
+
 test_done
-- 
2.49.GIT

