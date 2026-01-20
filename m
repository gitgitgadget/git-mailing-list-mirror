Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D83D2FE2
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903183; cv=none; b=GDghVDoxs0ghRwf902ZjOaHBDoX0A7TRTyXECx9KEbjQcgbxD1Lt4XxRvT2epfRWR8seJbp7MJZGCdeNdibK5SyK8CE+cv8tjigX8w+KwR34LrnWMPwzj9z1wLXuaOOrLrzIyssSITWJKLUHiECWozYdrBQGdr5+vYIWqvK4ahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903183; c=relaxed/simple;
	bh=Sq6ag5QaxiAVuTARYrz/+Enwb/oJXCb3avWF8hgb7CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dl1elN0cqW5IM74fbz2s1oV9qS844xdh5fz8uX+dGKQbS5EmMGjKbLhINnRLxrId9r0r/ZmKahAYVzsworTmj0mOsgoHA7ZGMtaftwpl6tBb0UTLFww37lW9PQbf9+3ypwkWtnAiv+JtsOMtgpVz1IGLASFEUihB+PEr2VQkMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC0/li8h; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC0/li8h"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so37053255e9.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903180; x=1769507980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfET2ei3uSjbRfsYKpOR8iw452K5YJr/kE8h+6XRwxA=;
        b=kC0/li8hPqoWW9NY0Mg2TexdUz5n/nOU3DwSgMH1Ogdj/BFcArMT9xZWDcP+2qyxJP
         0L61MD2D3dBzq0meDKW9tt2VHX1GWLET4SPhtLs/xQ73jytRM86l71i1jlMMtuI9AGoy
         z4hTQF5MwoK2v4eBPdLDkQnojaA1D9NqJVYSIRTk8AH6LrTdQOnhYEXK0urFGHBMd/k5
         mmRKzPjRGxhLEoY2zPfHtYS2XTrPnf4vm8bTHa3WS6585gVeAaLIUu5P+Ici+CvbdJph
         GWhjTZc1LqyA+oXrlM9MI+6I//x592qA9UMJGAPhDAyzTpdxTOSp9Cxvvw2JLiLq6NEV
         I3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903180; x=1769507980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DfET2ei3uSjbRfsYKpOR8iw452K5YJr/kE8h+6XRwxA=;
        b=sTCs//daRDxNiD49MJUnFoT/D3RrXf6I5Q1X2hdFmkoeGIAZHbiU+EmBn9E343iunS
         dNV2Hga7DGKSJaDmQA8LD7v0inagVPcpRtV9Xs2pQLd1tlPqTp0AmdWgnfeRRr4vKmWv
         RtPsOItasOJ3C2cE2Mdcf7t7JyCbyLZkGMoSuFM8bgszCPL0DG0YNOI2KtRHPnY1PQWR
         p3vlcNUcsfl4eZcclq24fDxf1F8Te+jufBP4r5EM6eRqB3WlQ2/ChjPgIiE2c7hgcFMB
         eApRcV+8TepNZOBTqFWgZ2H9dyU2y4Dnc6WZC2gZH/o22HDPcbEB6Fxk+6lyo9v4BtKS
         Vz2w==
X-Gm-Message-State: AOJu0Yz3wgAbU8Si5zU9UWJaetPJPimXkjgbpepxCUtjXYuciPptJoNR
	55HJ0C/iFb37jsZZIwgLUK6ONqAE6OSCQTcwRsSVH0U75TiVtjTS9aavy+NiAg==
X-Gm-Gg: AY/fxX6b9mr8CRb/NN0VnQ7AnSkGX6JKhqKxgTLCvDhk+iqFyUrH0Y/ZfthVjfvnSZW
	pqSxgSraq0AawcOOyRmpcJMo2vbXOuSuJksXrhJ2yMmnEKWhZ+9vJ48I1B2J8Xgjr11lkzrKmVM
	UgQQfpnanNxdZNppC0ONZHXbob7ANkfMLaRW+XZyfBkIwhQcl4VFawQE4D3KORMFqUwxqfZABS5
	XvUdOKvyxIcoNF51rIZiUzrxRfF2+qRjYy8th4RsOjcnkxbvIAjUOL44ZRX2ri7HbonKZ1MFh6s
	X5AmYjecrDoRVyQQm0O2PScWJB2+v4/ZKOn1k64SHHl7Sdonn40Nw6wSEAKHQvw+gZPOmkwq4vP
	3yGjs03e4QOOzWNOK6M6MYJdZKG5ow62BUDj6IheDsqeWj7RUKMQxGkYUWB1vt4nPzPyooky75I
	UAg5aQAL+sSxZk48t2PQ==
X-Received: by 2002:a05:600c:314f:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4801e67c8ecmr172634775e9.15.1768903179647;
        Tue, 20 Jan 2026 01:59:39 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9d17:c155:e8f0:9505])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm27879778f8f.4.2026.01.20.01.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:59:39 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 20 Jan 2026 10:59:22 +0100
Subject: [PATCH v3 4/6] fetch: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-4-e0edb29acbef@gmail.com>
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
In-Reply-To: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 newren@gmail.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Sq6ag5QaxiAVuTARYrz/+Enwb/oJXCb3avWF8hgb7CE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlvUgZqQFSf14gXeLWnlweM8t0dQ9Et3zB0h
 r9J2mfVvflddIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpb1IGAAoJED7VnySO
 Rox/t4gL/05aMNAaz/3HYDCtmrHXT3NsbKi6D5MC6HJhkj9osRb/qsD7D+sWDt/fBT2Yhj04pmG
 Ras4QUF7qQ5XID1uZvFRiMmlEJH+vk5gpEtw1NwoQ9ll4ed8eaRTdJdT9ADYtL2SwdPwmSm43LD
 y5cZxGyLmxuRSrBpyBmO2ax5SwIbanDYQW8ESPwp3YVhPKVV0VbCM3xjMRLZxwTBLwUd9uV9fxI
 SGmHMUJizps+7Ya4RvZ+1UBWsuvcWcLYXdam1lWNpo2ScwD0yqjo9/Ez9xX9gpI4K+VTT6c9CnO
 q1D0BMEfdg6cYDH39hBysu3G5Jn465WP4TnGnJOH4cEZADyI3fwbrGjjQulIYc4Ibd9pXUsPfwc
 xp/72CEQ/3B3kvAtgTdvCioQXSgL1d6fHKhoLsxw8pF+YD592nDcSAVNNEmc7ZY9Ua/acGEtemT
 xw+D71PudHU9R7eUM1cKzmcxJjFRzgC9bUp2HRNCxiQC1/Ze+LAIhjKOAGA48U1fDhnBxxyFGI3
 oc=
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
2.51.2

