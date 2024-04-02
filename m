Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F415E5C1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093922; cv=none; b=elhXLQITwdopGFukAbHrQLGPsLlT/AX+yafqAC/QK6y70ORkA+2s56fv/FeIy1g4PPm67R6wO2TbPf/dzqEYlEDTmw8/iPk9wAwiXsKT+ILHmprhDfp4MmWpBWvHYQsuKHLjzoRU4Gd/AfoZ3eKiRrkVyfP4eCqCjh5DlGmIklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093922; c=relaxed/simple;
	bh=4kC97e1D5DKd8KzOln1Hh4gKgTGEHsN4NlMCyhiII+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqWm4s8U7LQCU3vTt4YRfK5pDkmb6YEwExpF6pfzNKCCcN4fBu3lE4tzbKEC7UalwFMA2JKmwlSVWzMJUoCTfk7UwgUhvPwYpWyKKPxAl9hV6AZ0HMj7QPpF4i7oQnD0LpN4HGcxJoQFAeXAw7DPqIq1ypr9m8Abe6he88Nz2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+6hOgVa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+6hOgVa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e28856ed7aso5448015ad.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712093920; x=1712698720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR03lPse7n5usgVfhKK1f03MPPQOlsvWOtXz4DccMyg=;
        b=D+6hOgVa2oNGmb3b5ev0v0MQahuE1ztrIfAnCwnS/xxLuh/Q4OHkDy0NcqmHhRuKMO
         1HRRM94JJKfIAJ2CAusWnzKZYAAk9k/V3bMHYMUxnhrXMLFNtcDBISJw35uQWYYvuHqa
         mi5nWExXTC68ZpoNeNP7Sk28NhwqDmQx2nLeKvXQxHZN59QHiTnzuADntcKV1DXnmGbe
         Ihg6DmI6pOoiktkNIr9tc3iBxt5Z3RU8MyCFf2hYhu206bmD5wTH0f5IfKumtLLF3Cw0
         7H3Ty0tx9HvyADTCAUzz/oevMk++Pnsloi6nH/LWbbXZX6kCNuCrqoxhV4DtEu+bHyPH
         LA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093920; x=1712698720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR03lPse7n5usgVfhKK1f03MPPQOlsvWOtXz4DccMyg=;
        b=XK32TrSZ01eRa8t6ad9nlgLbVzanUyjCcN5hUugeeGspd+Witj7zYOiG/3Qx3si6nw
         MMM2VZkBItif406SJxXf6vjaRamyheemu3dR9JPdiFeRdiVy66XKtMS2ZPxApFPDjVdW
         WB75HBeSayJ79CmEwG/I1tI4gBrGMw0R//OPuKTASS5jiYwM/KgJU57SA+2lBiiSokqy
         pNoMN/n8bbdjVHz/iIxBbgV8NMJt63FZkdu/Ux3dLaAD7C/xTb/ejNG4yFzKFq2J/47U
         nnVSvJXNLl4Y+hkMBwNUQKDJWhqlXrqpFa7+1o22Rb8adMNi4EutCeKlq/c1G9oAwzy6
         4k4Q==
X-Gm-Message-State: AOJu0Yw+QS0/o/5Osrv3bjq2zzZ7IJQ6Nk5ih2+rW+GYgwo0rCdAYFyz
	AZVeuSXAm6rpqRmOP3yGJPrE/hSRvoAZNm1uodsNX7V/iKGVAiXZRUDFjqjK
X-Google-Smtp-Source: AGHT+IFBs1seF33nMB8W5bgsZ/YpkjCPzk0+OYX4uOvIQQ3dukKVJjPRJFb57+ycT/0wIwbD9gorsA==
X-Received: by 2002:a17:902:f7c9:b0:1e0:7bbf:bef4 with SMTP id h9-20020a170902f7c900b001e07bbfbef4mr733853plw.41.1712093919912;
        Tue, 02 Apr 2024 14:38:39 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id az3-20020a170902a58300b001e1071cf0bbsm11641513plb.302.2024.04.02.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:38:39 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 2/3] builtin/commit: error out when passing untracked path with -i
Date: Wed,  3 Apr 2024 03:06:24 +0530
Message-ID: <20240402213640.139682-5-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
References: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
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
 builtin/commit.c                      |  9 ++++++++-
 t/t7501-commit-basic-functionality.sh | 16 +---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8f31decc6b..09c48a835a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -441,10 +441,17 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
+		char *ps_matched = xcalloc(pathspec.nr, 1);
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, NULL, 0, 0);
+				   &pathspec, ps_matched, 0, 0);
+		if (!all && report_path_error(ps_matched, &pathspec)) {
+			free(ps_matched);
+			exit(1);
+		}
+		free(ps_matched);
+
 		refresh_cache_or_die(refresh_flags);
 		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
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

