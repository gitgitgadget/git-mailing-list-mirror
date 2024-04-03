Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02C152DF0
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168347; cv=none; b=QbzQrOpiTQPJFtxpDWQkO/061n6jDP1n3OB31baH01bNcT2ELd40dLPfD0s33T1eBLvH9+pUc4dwz/qJ0GNFsFajoWiSKNm4urYA7z4wZPxyrEs1gFg/d+jDqFrc5Jjb9/ZPwQCRx+oNhysthAZUFDP4eXPDxBww5dfNsbpmito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168347; c=relaxed/simple;
	bh=gr9QWxCte1tLHz3Stm6mczayQPwVjcdBg+SR4GA/Rsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6YiKCI8L9868JLaBMUFzfe4ysC7enWu6hCBcTeI2xiR94rso/UflYlIaT8VsUAaSjnMgyUdJu+hOIQ69In7nP1oFpsAngtZx+1EAqYaS8/QMW/ADUcmvXQnE91eThFK/Zp0TeYj7YuLUHuNrFt1ITOJEEObDxMe4IT8kISj0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQIHb7+o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQIHb7+o"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e28efd8335so862635ad.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712168345; x=1712773145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWVxlPCGVjpM8PfAvFf2opQtbv+EPZKrOkPVqQnIlv8=;
        b=iQIHb7+o04QG99kGrT6mmPyj4IDfhccgCeMpb3zj3O0Kksv7hLBHHmGpxOYxuk4gOm
         fCu1rpVaA/WB/cMUAHH27zTW3G2UEiz8KZx+iCgypr3FqumYKAppbmV/soPtD3mxSfTC
         ZRbbPjde7nPBTnEQ6M2c9sn8Se1x+3fWR4AShgz4QlnTQClqfKxsSNKun1O92Hn9jaw1
         VV5rtE6q46L8P6qR6LeFzA3nAOguXcKeCpa1CXZgw/mE2rEI7UhaCUNyJCUdjVuBdcHq
         nM71110A7JM0v7C/fbAmzoDmC06rJlFEwD7qC6LT0iKTwePc4p6hTIcE5e3qYcaYkT8a
         MJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168345; x=1712773145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWVxlPCGVjpM8PfAvFf2opQtbv+EPZKrOkPVqQnIlv8=;
        b=bd7Bpgibb6bIw2L+w6i478f+AF2TnUJJOc/T761/q0ljyVibkR3RK+ho0OOGJ9Rkyg
         ys6VjiIEFAL33cUUa7E43m6RMyS8R1yX12kMkzFKte18eQW3RRsWNQsicDa6YGpK0kbG
         +a9z7FvnSXyqNSHmTiKkuL46cm1d/fFCwejtFSp26Sn5TOgnLkruFh/LG67+fTC2wnlf
         oi47d/ptKZs0CVS8Y2UBt++402W9QmpsV8UlWa0XcVJrs/XjQTcS59akyJPCJetd38i3
         B8E6rft98GEw32tKTodgfWTnosieL+sRebQxydyiKqXqGwLJ6TQUuLs/lP0j7/eRPRps
         7WFQ==
X-Gm-Message-State: AOJu0YxFKl6H/I4JwOD/oa3kPE0RKwZYOhKywlZi56hS5P8P0VzBZ6Ip
	44moW1yYwZaNLTCu5C7vvUgJFjS4i6WeNdCZFksgeCZJGn9qXxYbIqZxQotB
X-Google-Smtp-Source: AGHT+IHb9DEN3eElhwpC7cY7IROt+upL2srcMqzSbkAWL+s+YDdbm6y4alMXjDR3QTP5EZNeUmluXA==
X-Received: by 2002:a17:903:234b:b0:1e2:5932:dc8 with SMTP id c11-20020a170903234b00b001e259320dc8mr21057plh.60.1712168344215;
        Wed, 03 Apr 2024 11:19:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903120b00b001dddaa7d046sm13661758plh.29.2024.04.03.11.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:19:03 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 2/3] builtin/commit: error out when passing untracked path with -i
Date: Wed,  3 Apr 2024 23:44:50 +0530
Message-ID: <20240403181531.59505-6-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402213640.139682-2-shyamthakkar001@gmail.com>
References: <20240402213640.139682-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we provide a pathspec which does not match any tracked path
alongside --include, we do not error like without --include. If there
is something staged, it will commit the staged changes and ignore the
pathspec which does not match any tracked path. And if nothing is
staged, it will print the status. Exit code is 0 in both cases (unlike
without --include). This is also described in the TODO comment before
the relevant testcase.

Fix this by passing a character array to add_files_to_cache() to
collect the pathspec matching information and error out if the given
path is untracked. Also, amend the testcase to check for the error
message and remove the TODO comment.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/commit.c                      |  7 ++++++-
 t/t7501-commit-basic-functionality.sh | 16 +---------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8f31decc6b..84caf65603 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -441,16 +441,21 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
+		char *ps_matched = xcalloc(pathspec.nr, 1);
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, NULL, 0, 0);
+				   &pathspec, ps_matched, 0, 0);
+		if (!all && report_path_error(ps_matched, &pathspec))
+			exit(128);
+
 		refresh_cache_or_die(refresh_flags);
 		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to write new index file"));
 		commit_style = COMMIT_NORMAL;
 		ret = get_lock_file_path(&index_lock);
+		free(ps_matched);
 		goto out;
 	}
 
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index bced44a0fc..cc12f99f11 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -101,22 +101,8 @@ test_expect_success 'fail to commit untracked file (even with --include/--only)'
 	test_must_fail git commit --only -m "baz" baz 2>err &&
 	test_grep -e "$error" err &&
 
-	# TODO: as for --include, the below command will fail because
-	# nothing is staged. If something was staged, it would not fail
-	# even though the provided pathspec does not match any tracked
-	# path. (However, the untracked paths that match the pathspec are
-	# not committed and only the staged changes get committed.)
-	# In either cases, no error is returned to stderr like in (--only
-	# and without --only/--include) cases. In a similar manner,
-	# "git add -u baz" also does not error out.
-	#
-	# Therefore, the below test is just to document the current behavior
-	# and is not an endorsement to the current behavior, and we may
-	# want to fix this. And when that happens, this test should be
-	# updated accordingly.
-
 	test_must_fail git commit --include -m "baz" baz 2>err &&
-	test_must_be_empty err
+	test_grep -e "$error" err
 '
 
 test_expect_success 'setup: non-initial commit' '
-- 
2.44.0

