Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8E2E9EAA
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111817; cv=pass; b=ZyNdeQIX7XFRPPO6b0s4DP6MQrv54UIwuNi71bwaA2zyKMPFlqRnJn0xya10dDsg+OCTDn/sOGQRVEuCnYYI1yf8Zn6S2U6DLPGtgs7iORwTIxAcMftZcP3i/PQe+G5Z+Jo5ye+qMk/8FtnLNez6RNZggFSM6eEkvUwfbNKYPqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111817; c=relaxed/simple;
	bh=z10xxnWpPraCfxtbJzzbiBkZtMHQKdRHalVjPKYlQqc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyLUxJVlnz+deh1zwuiSH6tWcmhXEOOs2831iOXJZ8dQWtbTLPx0o6NgjwM0RNpz+JcIrGbWyi/FXrB5B/9Lf88gNim+J4bY6qsZ1xDr6r2K5kwLmCeNIapsWeMK5Zixmoqfe1Fje/+hrKFPXFc6P69Pvq7LNEj9MhkaMlfuhks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=OwnXZ5Bo; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="OwnXZ5Bo"
ARC-Seal: i=1; a=rsa-sha256; t=1761111637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HGyWl9MatQzDVMo3ikxlXi5In40It5K6FxTtewbSsLCKRsrwymEq5ICd2t//USETIexPiQIp9pZC+fcrOAJnueSf1c3UG+Iq3tQoBrUdw0KM0LN/kOlHQZ4KOkET8ezskz+sBXMEI0kA0+qnL2lNXlrsUT91b+TCtoH4A18Iw8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111637; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=JCeWRBvZ9ywy/1DmLQgwtV6SNDs6/wbYtUwFFMNi8Dw=; 
	b=FAL1NOcPaesq5Vvs877nfwjCVjwP8zqAQcFItMlkGoDkUxL0klGvZmlbcnm0WRlOyY8DUbxXMAsL9DVw3cHlxsipihxfWAy8dFZ4b5Jthm1+5ow/WeS8INrJjkz5AyTekqt3yNbJpkhS77KYRZj15A9XSm2DaWNZEX1yrH864hM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111637;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=JCeWRBvZ9ywy/1DmLQgwtV6SNDs6/wbYtUwFFMNi8Dw=;
	b=OwnXZ5Boo5kZWT0+oy6c0arBTSZn86VJCDh8d/tUzAQR5e3KbhTcauc0fxYtWu+8
	90k5IHO5ElGCzlJC83xSftpL/32PMZW1nEQyDcaGmzkI4Xy+butt++6uGkjg4OvrFxt
	iRkLUGdfLZJZ7cptKYd2HZpqSNSjRbrxosxioNU4=
Received: by mx.zohomail.com with SMTPS id 1761111634545240.5918773395524;
	Tue, 21 Oct 2025 22:40:34 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 19/29] t3440: use test_commit_message for trailer checks
Date: Wed, 22 Oct 2025 13:39:39 +0800
Message-ID: <20251022053951.602605-20-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Replaced the pipeline-based trailer assertions with
explicit expectations verified by test_commit_message,
ensuring the rebase trailer tests catch git command
failures reliably.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 6b1c93b4cb..1571dd2c97 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -52,18 +52,28 @@ test_expect_success 'reject trailer with missing key before separator' '
 
 test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
 	git reset --hard third &&
-	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 &&
-	git cat-file commit HEAD | grep "^Bug: 456" &&
-	git cat-file commit HEAD | grep -v "^Bug: 123"
+	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
+		rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 &&
+	cat >expect <<-\EOF &&
+	third
+
+	Bug: 456
+	EOF
+	test_commit_message HEAD expect
 '
 
 test_expect_success 'multiple Signed-off-by trailers all preserved' '
 	git reset --hard third &&
 	git rebase -m \
-		--trailer "Signed-off-by: Dev A <a@ex.com>" \
-		--trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&
-	git cat-file commit HEAD | grep -c "^Signed-off-by:" >count &&
-	test "$(cat count)" = 2   # two new commits
+			--trailer "Signed-off-by: Dev A <a@ex.com>" \
+			--trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&
+	cat >expect <<-\EOF &&
+	third
+
+	Signed-off-by: Dev A <a@ex.com>
+	Signed-off-by: Dev B <b@ex.com>
+	EOF
+	test_commit_message HEAD expect
 '
 
 test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
-- 
2.51.0

