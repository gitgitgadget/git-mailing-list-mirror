Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986C296BCF
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670064; cv=none; b=AVcuFLqd2xRIs7Wo4MhKQz9tPzGq4tb7NPn/2pnHxADajBhgIE5OeFBX2NdgXaVqe88NvgOMKPEFpXyuHo87nOjw+iZpOFiFpHgiaLvGd6Ve2eKwJSAvuGT/cjERt4GnxSZdrnhnYs73bin+rAusYlVO33JpPqtRz4x98iEYyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670064; c=relaxed/simple;
	bh=qV6eEGupNGMd6U2yofUnR2s3tmdDSx9rBLB+S7CCkOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHGzHCtDJbCscD4VwUHwIVBfO5q1yc0D7zbYxYr4XjwHM4jNnvMAfDfBWecqGLHtBMesNjNLP6nfHl7JqcPzRS52EOoSwUOL3PqM2amZQm98Zo0xycoa373aLGlYyLqI5+UzZ1BDt87osRbKMUvFbp6vfyUMlJ051q7+rw8ASmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uXZpwzPD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sYQWiS4W; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uXZpwzPD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sYQWiS4W"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37CD514000A7;
	Mon, 20 Apr 2026 03:27:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 03:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670062;
	 x=1776756462; bh=udKANwLh2mEDENOzM7ntj3nLyIThxAX53mSdIku/7ds=; b=
	uXZpwzPDHe48WfnHySkgrZA3lVgRL5Q6+Zt7Wfu6qWn9ZsYHolk0siJ93bK/MOzB
	mTBW3ZCoBQ01k2ggnr9xADLAlFTnSAY5DyqVvBefOor+utlkqPI19BRe5WqqQXEk
	sDbllpgd8YJTADrnBJJs/H2gxlUHIt1bac1AqWv6A/314ylh9rtrwJGvJNJcnzos
	FJ5oYsobnEhG3a2AZv+UeZG4wmRun9qtW6r4a7Q5q0aZ2UF3rLu3WiWUIAkUzRu4
	Q938j2mIhd0PsZeTIbcc2DoLYICR6OrY8E4hZs/8s4Aga2rp9pAJKGltyBrC/GFn
	rzeiD5bVJgBVbhhrj2gcMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670062; x=
	1776756462; bh=udKANwLh2mEDENOzM7ntj3nLyIThxAX53mSdIku/7ds=; b=s
	YQWiS4WPgyQyH+YPQABlXXp9QRVI1QyBHa6qhZiHrTHtdwM8QjkGUkGtkqncC7ns
	h2dD/0K88jkQ9C7eQPZ/wr9uAzpsDg93c3iN1UmOO9aLDbcQDSD0u27kwRWu8JVC
	UnJIraC56W8yxZYbf4Ed8IoH3DxjGN0r6UzAwHVUOOKaYaUSzTEaaCygt8CUUpo+
	r+tpoXp9Zky8uVxrzbj2co3izIWRcokEtEGpd04XzMT1sUjKyGB/2vfq5/8JxVHC
	TWJ/nCnBQfBr2LufkGeqQc44xoMNqT0Zkwi5qX9LVO7wKIXxV5P+ROlhCQ159SG+
	yVapL8SUdP/mQb3AhdnIQ==
X-ME-Sender: <xms:btXlaZoPO8FbuaZLh8ZGSTvHiP8k5mFHXEAPuFjZruMUpaSapt3uNA>
    <xme:btXlaSrBUKcfstm2nK6PFEiJxqRaOJsDU5Bwa7KBdkXbGPSrSFQ_4sRcAH_ee_eL5
    LQa_pKDaCzMEnONKO556-bTkXNBlF6HbEQF9AzGQxqnN23LvfoPMCM>
X-ME-Received: <xmr:btXlabMIkLe9XIymIaid6socKuEYR-uDoErSJqkwb9Ol_L9-yIJodkVDAwkBY5e4vDtuZYvgpph_ub5M-GrRaBbZ8GK8sXCO64f6UaDjXlWV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:btXlaTyUSKhXmpWayjghhAgv-53OFvOrUaheBd11h-UaEfeSDxc6ww>
    <xmx:btXlaUs7pjjFdGS5HwMKHm72hqABmH41yezMSIgFusBDWoWLFA9_GA>
    <xmx:btXlac7uxnlsHNUquTwX2ddbsOyd_qJ4W4-8ko4d1zyYuxhkUZlaJw>
    <xmx:btXlaTTVE-byBdKaaXwHXxXpRkYkUtyJz55W0XcfbBZeNjeSWZxQmw>
    <xmx:btXlaRIpsIC2dopT1mzJKvOSXDF0j5__6ITonOTbWdmsLEL4yUC_btjA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e644dc00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:24 +0200
Subject: [PATCH v5 05/12] t: prepare conditional test execution for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-5-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

We have some test in our test suite where we use the pattern of
`test ... && test_expect_succeess` to conditionally execute a test. The
problem is that when we decide to not execute the test, we'll indeed
skip the test, but the overall statement will also be unsuccessful. This
will become a problem once we enable `set -e`.

Prepare for this future by turning this into a proper conditional, which
is also a bit easier to read overall.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4032-diff-inter-hunk-context.sh | 12 +++++++-----
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index c98eb6abb2..2d216fb70f 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -40,11 +40,13 @@ t() {
 		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
 	"
 
-	test -f $expected &&
-	test_expect_success "$label: check output" "
-		git $cmd $file | grep -v '^index ' >actual &&
-		test_cmp $expected actual
-	"
+	if test -f $expected
+	then
+		test_expect_success "$label: check output" "
+			git $cmd $file | grep -v '^index ' >actual &&
+			test_cmp $expected actual
+		"
+	fi
 }
 
 cat <<EOF >expected.f1.0.1 || exit 1
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index f512eed278..8cc86522b2 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -220,17 +220,19 @@ check_dotx_symlink () {
 		)
 	'
 
-	test -n "$refuse_index" &&
-	test_expect_success "refuse to load symlinked $name into index ($type)" '
-		test_must_fail \
-			git -C $dir \
-			    -c core.protectntfs \
-			    -c core.protecthfs \
-			    read-tree $tree 2>err &&
-		grep "invalid path.*$name" err &&
-		git -C $dir ls-files -s >out &&
-		test_must_be_empty out
-	'
+	if test -n "$refuse_index"
+	then
+		test_expect_success "refuse to load symlinked $name into index ($type)" '
+			test_must_fail \
+				git -C $dir \
+				    -c core.protectntfs \
+				    -c core.protecthfs \
+				    read-tree $tree 2>err &&
+			grep "invalid path.*$name" err &&
+			git -C $dir ls-files -s >out &&
+			test_must_be_empty out
+		'
+	fi
 }
 
 check_dotx_symlink gitmodules vanilla .gitmodules

-- 
2.54.0.rc2.529.gd9106f7525.dirty

