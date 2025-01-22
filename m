Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B3211290
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540212; cv=none; b=uYhXDwVLhEfYsbQhJoolnwCTrdVyt8otZEmS++Dnq6a6eo5zuKyeD0ik58qjgUGVCzgScDHkFsiSGUANz5MulnkhifvwIQ2M+dplwzunio1CiCuCH0PnJbM4lNXJA+9dbvUqoTHCnGlJe/B/8xOSe1a+OboZfNvb+4P6sbrgAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540212; c=relaxed/simple;
	bh=OurbPe6n3ILQwBFwe7RNgeg4adgGOIok4TQ3w7CWi7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek3/bK+jJt9DrVZyNvK5XzqyujDPPxSyW1wVJlis9bMuRiYdEV7mHZuWzYZm3/I0d3yA88uAjmhXW6yIRdcTpqX7otYjOexFQ1h80trJuk4rB9RUfjRaiLzeBpnNKt4Z/sGmZmc3HEYp+xJR4my/o+uyM2iBH0Ndb1eIq8Of+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv8DZVC9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv8DZVC9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f441791e40so8783156a91.3
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737540210; x=1738145010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C3w2GUTtJXjUuPVI76B430uK48nqdFDv9vkfNg1Wm8=;
        b=hv8DZVC9bPjPrloaW0TunNr97JAUyXJTJNd28SlARbNMDPxy/pIVBtMqdiUgAaIDpd
         pBKRLmI5QPY/1PcqrPYXk3rpZ23RnLhDn7MLPXTXmOSX7xrkC2MK8OaAL6aDqa9aaiJF
         bz/VxMX0vWemvYIuHxEWhPZu4ehoXxOFlio/x8KOaG6JpzZp/cI/SlyiINVLeHhSYLry
         jTHDz9ZNokNTX50yeN0MWqU9UxdXPT+pJ4LpuRFbNVe28Xxdnek5/ON7+zioVYu/G28j
         tYNpAtfpNcAm1JuHM1HfDc7zXiS/S7lekTd4j7XfG6FlIi0+iPDo+GYRqjHlr/e3vQcy
         F4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737540210; x=1738145010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C3w2GUTtJXjUuPVI76B430uK48nqdFDv9vkfNg1Wm8=;
        b=l0aZS2r+wD6S382/xKjw8SGvHHodkxy8VDaY3P3TYhATK6OOwyzwqQ6trMP3kkech8
         fwNkUwBRWwKMohU7p1dTZHfiWiBrcs19RNuCZlZDW5CUlmsRaeLYBvR6ahyrcCG1amT1
         97fywBGw1ag+rWfsFAeqQRpcFwVpsihKeCmUOKHzQGFY5ucFEu3H7ggdSqTvzxG+Xz/1
         UF6/OiT3I+Pb76vJN8GoWRDfFUP8PUvoLqgBYoPOckRzV5EUD/rkvteLGDoOWeVkBwGm
         Vy2cmUAE4v+XDzJyKHSRUw03YtTHgsfKXS/XOkmOx3+kJzNbAAlUfINIFlyngYI21NGH
         r2Uw==
X-Gm-Message-State: AOJu0Yy7KiTivtUJzjO2PqBhb3nwf/sbSGpA6XUE3wcDv5AVa5gWiona
	FtcMEOyXwt0wDp2i//Mxy9dILsHFPTnhhWG1Bs1oAY5nrnq4Ad9pbiLOlWeI
X-Gm-Gg: ASbGncsRT2rFnHwZv5p2lps0MC6ZDZ59TVkll1Uo8EsrnJ1Y9iE85biiy24R2IvzEfq
	7k90WPFGKlJsZyo7UMV11KORN0EaeiBVCSi5LbliLOb/Sv27c/SAVG45vAmUPZp12ukWl9rtwK5
	gH9eJzXXvebls7JnmoQlqr2DN892LSZdHlVi8RDf9NYJ8BqhbZbjApY3xS3a9wPgddwiJfqQRbb
	8Wnbq4wfYMRhmUIoD/QJ7ZfQxoI3BgXwgiBG7Fn9HzEryp2hikWVmvH0kDRgXGEpFuJSAZOEknQ
	h5Xm1y44sw==
X-Google-Smtp-Source: AGHT+IFTLaMA0Jk4zXVddkdGzErmIWnYQiMjk3d6pXvoifh4QZSO9SW2fZSriVXHoU3Kzko1w1nxnA==
X-Received: by 2002:a05:6a00:428d:b0:725:ae5f:7f06 with SMTP id d2e1a72fcca58-72dafadbc37mr29540892b3a.23.1737540210392;
        Wed, 22 Jan 2025 02:03:30 -0800 (PST)
Received: from localhost.localdomain ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabad00dcsm10978061b3a.174.2025.01.22.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 02:03:30 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	nika@thelayzells.com,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH] refs: fix creation of corrupted reflogs for symrefs
Date: Wed, 22 Jan 2025 11:03:19 +0100
Message-ID: <20250122100319.2280647-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121215235.GA2753621@coredump.intra.peff.net>
References: <20250121215235.GA2753621@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 297c09eabb (refs: allow multiple reflog entries for the same
refname, 2024-12-16) added logic for reflogs to exit early in
`lock_ref_for_update()` after obtaining the required lock. This was
added as a performance optimization as it was assumed that no further
processing was required for reflog only updates. However this was
incorrect since for a symref's reflog entry, the update needs to be
populated with the old_oid value. This is done right after the early
exit.

This caused a bug in Git 2.48 where target references of symrefs being
updated would create a corrupted reflog entry for the symref since the
old_oid is not populated. Undo the skip in logic to fix this issue and
also add a test to ensure that such an issue doesn't arise in the
future.

The early exit was added as a performance optimization for reflog-only
updates, but this accidentally broke symref reflog handling. Remove the
optimization since it wasn't essential to the original changes.

Reported-by: Nika Layzell <nika@thelayzells.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Hello,

This patch is based on top of 'maint' so that it can be easily backported.
Sorry for the inconvenience here. This was a premature optimization which
wasn't needed, and unfortunately this wasn't captured by any test.

Karthik

---
 refs/files-backend.c  |  3 ---
 t/t1400-update-ref.sh | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5cfb8b7ca8..29f08dced4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2615,9 +2615,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	update->backend_data = lock;
 
-	if (update->flags & REF_LOG_ONLY)
-		goto out;
-
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NO_DEREF) {
 			/*
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e2316f1dd4..59493dd73f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='Test git update-ref and basic ref logging'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
@@ -2068,4 +2070,18 @@ do
 
 done
 
+test_expect_success 'update-ref should also create reflog for HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit B &&
+		git rev-parse HEAD >>expect &&
+		git update-ref --create-reflog refs/heads/main HEAD~ &&
+		git rev-parse HEAD@{1} >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.47.0

