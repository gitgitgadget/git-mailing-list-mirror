Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668105339A
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777273; cv=none; b=dL61e23v7j1i2IdKDlvvZgpT4tjrN3b0O/BzpTSp2LalRXJBxCgr5xZiHM6rxyQ+5ZURR7tLJ6uIqAkcIo9XQ7D8gMtE9E6b/T4L1lejhZLUmnHkFM7g1As3Ft5SZMGogMrA7cXk+bUCZafhaV4j51MwLm6TqigRTz0V+HA3z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777273; c=relaxed/simple;
	bh=zDBC1O+GhHUKzkX7xS7NIiFPEKd1hH6MQdY1V/cUKkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h73YyvOl2gzgmQaoDIwSbCwTvpUHsjRWQICwPFKHrie1XE9kQ8PFQNbQCWDNxKB5BNWn4Gx9oGYDrkX4+C1WIPp20AwwIEg/Ze7tfaQz5qmDlc2fH6dHsKv47cl4G8XDYKt7D55Xclrb/3m3Pj1zzpwZgIZ6P8Tqvw9UpBufYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvTxXeRu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvTxXeRu"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4082583a12.0
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710777271; x=1711382071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gobrQGTh14bRBFGQihQN8cFPl8UJzNCKtlUxNI/f3g=;
        b=RvTxXeRuclFHjspoCtUOiPeYONxJ5h3+SRabkd8xxyCdVCUKHUKw8c9q1muGsFqw/t
         tnyMQm9lhVJP9Ota5z5aUOcb/3Tttt1GDMRpcM1/NdwVAaJXIQnSqVViwos7c4PPFiIu
         mJnd9gFzxbIoYoflP53j8Rqcp6ldhNuNMHO2hdwICVbhqwfnenQuzvTlrcHM6qjzQj3S
         PlgQ4BOPt3tJWCZlY/9y50+9Qc9z4p2/lc9njz1h1U/l64zdBQuA70efcvAHvtXK0/05
         Bw089lGE+eTnqI5go4fhb2nrWsvyF93jTS9sJTIXrlGiOiBjPAEDrDFvv6pAjK1K/rq8
         lhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777271; x=1711382071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gobrQGTh14bRBFGQihQN8cFPl8UJzNCKtlUxNI/f3g=;
        b=Ok8Sk6yep04rUxH9sCZBHrDejciA50cMRUOlKaZZad7LPpsy5ka52cDPfS2cIWg0P9
         ExkD5SdaTOUPQX8OqtPeGon1fwNTpq/2IoTrW85JzzTYEYJTB3NhYCe7U1xl20jAG4EL
         RT/Qxtwirv5X9R4xLJlY1B40SywzM1OLWg+ZtJ+2NQxJBAd3qfpMiwenk+q3WHfJhpKN
         ThyQF++cinR0OzdXdtxCwTl+Bt/5ClT5LxzaFZi0V779EpjIJ2kd0Gy1rprqpyBptEDk
         sQz3wSge5ImeikWJPa7ppJu1V90yAm70CsXhuEyZlQRI7BM84lTCoJaMKLlXRuZh0TTi
         EjvQ==
X-Gm-Message-State: AOJu0YzInrbh2Ocd3fiHulRY/x0pGowyajL5kRYSmFXLGH8gg+AFlDxP
	MxhcZnPzbu72wgkSsK3vUKp5nt6z9NzfiWHdOHeTaf3FXbJF4PbsZn9bF4rK
X-Google-Smtp-Source: AGHT+IHBKYxTlvR2CXln9LphV/B0r7Zuj8UosroAPLE4nEU5OjMsX1zxx5hR6tZKMeObAmpNPF16BQ==
X-Received: by 2002:a17:90b:34c:b0:29e:89b:9446 with SMTP id fh12-20020a17090b034c00b0029e089b9446mr47528pjb.1.1710777271288;
        Mon, 18 Mar 2024 08:54:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id gd1-20020a17090b0fc100b0029beec8e86csm7844922pjb.36.2024.03.18.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:54:30 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH 1/2] builtin/commit: error out when passing untracked path with -i
Date: Mon, 18 Mar 2024 21:21:59 +0530
Message-ID: <20240318155219.494206-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318155219.494206-2-shyamthakkar001@gmail.com>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when we provide a pathspec which does not match any tracked
path alongside --include, we do not error like without --include. If
there is something staged, it will commit the staged changes and ignore
the pathspec which does not match any tracked path. And if nothing is
staged, it will print the status. Exit code is 0 in both cases (unlike
without --include). This was also described in the TODO comment before
the relevant testcase.

Fix this by matching the pathspec against index and report error if
any. And amend the relevant testcase and remove the TODO comment.
As this matches the pathspec against index, we need to also make sure
that the sparse index is expanded before matching the pathspec. A
side-effect of this is removal of --include related lines from the
testcase which checks if the sparse-index is expanded or not in t1092.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
[RFC]: I am still unsure about the removal of --include related lines
from the testcase which checks whether the index is expanded or not from
t1092. Will separating it into a separate testcase of its own and
marking that to expect failure be better?

 builtin/commit.c                         | 15 +++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh |  4 ----
 t/t7501-commit-basic-functionality.sh    | 16 +---------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a91197245f..f8f5909673 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -441,6 +441,21 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
+		if (!all) {
+			int i, ret;
+			char *ps_matched = xcalloc(pathspec.nr, 1);
+
+			/* TODO: audit for interaction with sparse-index. */
+			ensure_full_index(&the_index);
+			for (i = 0; i < the_index.cache_nr; i++)
+				ce_path_match(&the_index, the_index.cache[i],
+					      &pathspec, ps_matched);
+
+			ret = report_path_error(ps_matched, &pathspec);
+			free(ps_matched);
+			if (ret)
+				exit(1);
+		}
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2f1ae5fd3b..b55c81d4f7 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1418,10 +1418,6 @@ test_expect_success 'sparse-index is not expanded' '
 	ensure_not_expanded commit --allow-empty -m empty &&
 	echo >>sparse-index/a &&
 	ensure_not_expanded commit -a -m a &&
-	echo >>sparse-index/a &&
-	ensure_not_expanded commit --include a -m a &&
-	echo >>sparse-index/deep/deeper1/a &&
-	ensure_not_expanded commit --include deep/deeper1/a -m deeper &&
 	ensure_not_expanded checkout rename-out-to-out &&
 	ensure_not_expanded checkout - &&
 	ensure_not_expanded switch rename-out-to-out &&
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

