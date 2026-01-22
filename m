Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA042E002
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083531; cv=none; b=s/8bvfloQ+f7R5FqLFD2I+V/m+JfwKsZ5KPfzZFaKdl7SCe/2tMDYOhOJ4CqdC7ujAfacr1l5rVSKmxc+JmsDrcZ2mBYCiMLTW6Vg8BaPPP72HoYXU7zR2Xmx7Ivpf3yJkmsMt2rLDLnq+f280ccwASH55ytV13BniO3fP3bPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083531; c=relaxed/simple;
	bh=QVCgPcu+8n0+pnvjlqciULn2iHaIdeO5AswVSSYpI5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNE9QXRhUlYY5OzPvY5HFAhVGNuJCNd+Yd/5c6xYWgTWkKWsKoyAEs+w7bWLtwGLyMaK70e63kIAR2q2UnLkCsanaD/iL/D4nTltNLQpY3MsYDICHP9gP9g8jciJgeZj2SpG8sMXuvwCnnAQZ+0oR3/OyW4RNwy4HsW0jZAeaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4YnDmap; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4YnDmap"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so627426f8f.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 04:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083527; x=1769688327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFdsjCLG22zeH25oN8mzD8T+Bx6rOvqESIF5/naLAgw=;
        b=L4YnDmapolKLx5wPh2wuMr4lrJJzj8jV2wPKwzUfJ1lY0Q+IP3nwogKfA5mOQi9C2E
         /byZVpx3jI8ZZ4ZuEKugZXdH4frmP7aLSor809WgnR3bzHLoMO013Lw/lnv3VxuSbgoW
         mmmMGkVbur6Bo/zvpE+S8OqHwAM4ZOHYsXnKCr8u51nIfNVu5nqjNogKS8Gmld5TQVYi
         v4u7ie6tCl5pRlMGDPdKjY8kludqokPEdh7tYJVaAvrbGCiZPn99Fa8mZH9B/dDA+VOE
         /Qm+nsufHcfSq+qiOXRqhwY/9M05QjMY2ZhCdcTcCa2d03B+cotfcijTAJUNlAc4HybO
         YyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083527; x=1769688327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFdsjCLG22zeH25oN8mzD8T+Bx6rOvqESIF5/naLAgw=;
        b=aatjZPWQyjPdaUcHu+nt0OY2MaDFjn+llhMloguiWxPuOqdyKMWR0iB7tPubRP4bTb
         8EW25cBmcC7JCFzNBE7moPcdT2EYU9YYLh7O8ChI1+9xsS75aJRDS4Kh2LLkMiploSOu
         /2ZJxthX/oTw7NRo/q93mv2YwHEUmYB+JqK2J8u05dnEh1l4kdu+EPaD0aeigVqExqX8
         SXW77faPa5KnuyBaCOnkbWOAVDAcjPOziPmW8iU0pZH54Xi7ICr0eZWkrkl0x6UvzUrU
         dpleVVgyD+tD277itB7AGqQk94Mg4uRBGA1zQmxnxyXIh5lJcwhPhAXNFrNwA+xjNkMd
         eLcA==
X-Gm-Message-State: AOJu0YwlJdTGN4bFRYQLrWdMiTz1IHXr7+aCVbaJ540QYA4D5QewIDB3
	YXo+7XIyuZMTkIn7AlO2+X+Q+5TAI8V4cLi2YjH2/r8EtMYv5uqqZ3/5
X-Gm-Gg: AZuq6aLp/TeE2jf3d0w7kBM+hofB8Ae0Nd/+wtCpX0D+TJ1ceMWblK2VbOTuUxmuPPz
	Ld/8dKWtEPCWXcV2xSIlLmTtFfUp4g4RXOd8nj+syGCldiQJ/QmkVEdtIS+9fshO8Oq8dzitSef
	4PI+o34AeDbGPzaY46T/OJ+/DCZOPw1lAUrCRURWJGLFTJKWzV0NoQSyWJwviIZuDzEBHmSUDUI
	aHXOwX+r8hrDJlofai+i8zAXxn5rGS1bWzIqHYS6FFC9gqWLeIJ63zPvLBvX2/YMau75ub87TnW
	PGOcyyYi2KoS1wPDW5XOvoYiAv1ADasEYXnnIkiyy6DpZfcMXVXTQOXzTvyKSpvKul86d+AiwI9
	23aFns2FuFYGErlXbRB2pmGhu0WcfUyGiX1nkCxMcgcQT+uYvZdUL9s8knVug2q1zJ/T8Tx7I5N
	KCr+9Zkk/q8PqvlI5vIA==
X-Received: by 2002:a05:600c:4e43:b0:47e:e71a:e13a with SMTP id 5b1f17b1804b1-4801eb0f5a5mr280192725e9.32.1769083526860;
        Thu, 22 Jan 2026 04:05:26 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ef49:411:ff92:1c50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470403d3sm64926445e9.5.2026.01.22.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:05:26 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 22 Jan 2026 13:04:58 +0100
Subject: [PATCH v4 4/6] fetch: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-4-2ddba0832440@gmail.com>
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
In-Reply-To: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QVCgPcu+8n0+pnvjlqciULn2iHaIdeO5AswVSSYpI5k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlyEoFLiDkeclFOo+Y73r0k0gRQ5BHUeH1Du
 58l4y0WH3jTaIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpchKBAAoJED7VnySO
 Rox/QooMAIyBPLXELWpZkCFbGl1VhRnwze4aEOCyT940MPriftMbzxXPAzl4J/OioggGg9UZdL4
 zTRNnE6ZOfKo6tLxd9aFBENh6j28heY7bhcdlcNa4lPJNJJPVGLCyOlqELoEKVo+NvoIyC0Y6hA
 4D6gMO21Zs7d0UukUcN0cRqgWfFaPYCLGO114YF0ib/3ZFENm7RTFofYGa+vcL5PcVEkbZDY/FL
 j18orbnUQ5S5Bhkm/ZMAOREtwCsnCIL1QMutYji+wm4S+8EwxIfshLRNxYd0budw58H37rzkQVc
 0TEdy1U5P6j2jFENk/F9agwR+7K8JWIrv8EV2KxlMBUFMskR6JIbv+u8JzBOjoTwHlkNvC3kJYm
 sJ5EZB4DHNF0mVyAvW7xNj4UsmPUBJIPJNF0ECvOpyySowD2UHtDSQOEMK8HBa1C7AvBrFAod41
 0SFZEkO4e7Rp0d+KdV5ghihpYDohLY4TtHLbEcIrDFvSFZKYVsWICuCP5yFH62t59vIYGvsvtH0
 1M=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19),
git-fetch(1) switched to using batched reference updates. This also
introduced a regression wherein instead of providing detailed error
messages for failed referenced updates, the users were provided generic
error messages based on the error type.

Similar to the previous commit, switch to using detailed error messages
if present for failed reference updates to fix this regression.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  | 10 ++++++----
 t/t5510-fetch.sh |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d427adea61..49495be0b6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1649,7 +1649,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
-					      const char *details UNUSED,
+					      const char *details,
 					      void *cb_data)
 {
 	struct ref_rejection_data *data = cb_data;
@@ -1674,9 +1674,11 @@ static void ref_transaction_rejection_handler(const char *refname,
 			"branches"), data->remote_name);
 		data->conflict_msg_shown = true;
 	} else {
-		const char *reason = ref_transaction_error_msg(err);
-
-		error(_("fetching ref %s failed: %s"), refname, reason);
+		if (details)
+			error("%s", details);
+		else
+			error(_("fetching ref %s failed: %s"),
+			      refname, ref_transaction_error_msg(err));
 	}
 
 	*data->retcode = 1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ce1c23684e..c69afb5a60 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1516,7 +1516,7 @@ test_expect_success REFFILES 'existing reference lock in repo' '
 		git remote add origin ../base &&
 		touch refs/heads/foo.lock &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/branch >actual &&
 		test_cmp expect actual
@@ -1530,7 +1530,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_fd &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "failed: refname conflict" err &&
+		test_grep "cannot process ${SQ}refs/remotes/origin/foo${SQ} and ${SQ}refs/remotes/origin/foo/bar${SQ} at the same time" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/foo/bar >actual &&
 		test_cmp expect actual
@@ -1544,7 +1544,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_df &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "failed: refname conflict" err &&
+		test_grep "cannot lock ref ${SQ}refs/remotes/origin/foo${SQ}: there is a non-empty directory ${SQ}./refs/remotes/origin/foo${SQ} blocking reference ${SQ}refs/remotes/origin/foo${SQ}" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/Foo/bar >actual &&
 		test_cmp expect actual
@@ -1658,7 +1658,7 @@ test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 		git remote add origin ../base &&
 		>refs/heads/foo.lock &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
 		test_grep "branch ${SQ}branch${SQ} of ../base" FETCH_HEAD &&
 		test_grep "branch ${SQ}foo${SQ} of ../base" FETCH_HEAD
 	)

-- 
2.52.0

