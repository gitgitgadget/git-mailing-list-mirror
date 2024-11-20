Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4491BFDE7
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110016; cv=none; b=JHGN/2iFLTCel5Id7SH1/j5gIMJPkn9irfPcELjI9n8riSWBNRC/t5k9uYW5GJJXjWmjsq4RW1ciHG9cKKkpMJsdd+HBYlcG++iNu4g1wZuAV7DXspRzLX7d71eEJFJLva6HnUuhUZQwu9dlJdi1OpI3USZZX4qph1SpGJ9vnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110016; c=relaxed/simple;
	bh=zFGgDMcGJSPtGEo+cfJk5+gpfcEnMoQlbVAbSVKqpVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8nlrKgt0MvjsLnalxtILB399dbSZo/PPB3Lvn73j6Yn6prdgvMozFuwmnCBY7QjixFSmSTKrnT/2EFsTqSa8qNZbJSA+Xbhsx1XdyZOZaG8qblExhd30irgdfmcdsCzWbUBJT5JE/8fNt9XNwfWleciSCnw/9ClwbkxLxivb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iOKAD277; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5tI3vmMN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iOKAD277";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5tI3vmMN"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E4E81380368;
	Wed, 20 Nov 2024 08:40:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 20 Nov 2024 08:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110013;
	 x=1732196413; bh=lOu66OP1KY+095iZRsap0d9HqfeS2nUH3OFJnapCzjE=; b=
	iOKAD277GBmrDKoP66cMru8Ciq+/quqYtdBbWgrQbET0h+rSWOjJ2a3rx0B5k15q
	RzvaiSngHqS/HjARTjh7IRSCMDjtrWUbRwxZt6Bxfh4UCUxqzwx40E7hx3EuDSIC
	6oCQyqydj9A09OSgVIR+JEZFh9RzrTRYcpaHZ1CGcAxVLxxRxK2JM8DN2yN4b+NM
	o9E42rtqKlGL2nbMrMexry5Kbftq5LeE6Uw5/C2JCGvuezykpoGNWZ5Hzm9CLtVI
	Ywo/AEtZYP0ZyZ1NbAm17yxEsVnKio5lultxl7NJNZFgaM2Dyg8VIxHHvUlNjpws
	nQylhT7NXcdtbptAPUhavw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110013; x=
	1732196413; bh=lOu66OP1KY+095iZRsap0d9HqfeS2nUH3OFJnapCzjE=; b=5
	tI3vmMNQlmjDLpkhldn3geXizvSLlJ2RMrxl+KmAA4fy4udizjPnX7+FanbDq0+3
	2/0ToSijhroyK74MmTtcO4dtyRRIiE/zsZfb7RIKBeGoklj1dZi6xBMytdJDUdum
	eJpsd+WlEkXpF9MC69yMLAcIPpxTB4tQD4CgDCuSSwym8yyrdz17QFrWwfUP7Wc2
	JFKmjjHwuhylUIOXGLSPeFGp9Cj+aKcuOTwKVbuSMzcE+8WOTl8dE/HrkEHF1uEF
	ou08KxBz3voRR37HEuSecAMV08P1s409Lxvr34DC2DAivtOr56h7iRYUHOpoDLL8
	Ive2Q4ErCDBEMmzHLIeXQ==
X-ME-Sender: <xms:veY9Z0dCkw8jFSCJsYGsW9meFUq4gTtT2Gj4tiMF3RYVYGTEkXsRpA>
    <xme:veY9Z2MeqeKto5fIJe5peRZzgZYLZyDY7Bky7-wnJwSt9dAK8hbDM5066jtbbID7V
    -NbntxLHpAAjPHZsA>
X-ME-Received: <xmr:veY9Z1g680cp4xK4Az9SUmn_-hC4uX2A15-nf5ce1tjAUUgcSsf_9gq6emKcBOcNDIcyn74TyKhHsRdHJmDVzI41MXJ2uBGOFmLRUFULnbIu2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    eprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:veY9Z59T_oYP2mq9bWic3QX2k0zq-mkDDlpw2Up68PnmmdacvQCwow>
    <xmx:veY9Zws5Qi5AhAtp6d94B5de8x4vSvzDjDWMETPHlYe19i1qq-ei4g>
    <xmx:veY9ZwHIfNI5K31KeuPKkxUqZNf99TPCScDNgAz1ozrlZNQL_SfdSg>
    <xmx:veY9Z_OfW2zuYFrfv5U1rKpttKNpZ5_gPzbwi11I_DJXbpSNi1DmBw>
    <xmx:veY9ZyIaOEBYbP0DKo-LiGAi2B9uIwIDkinJrntACozJyxai3fQeawof>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73691d26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:54 +0100
Subject: [PATCH v3 25/27] t: remove unneeded !SANITIZE_LEAK prerequisites
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-25-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We have a couple of !SANITIZE_LEAK prerequisites for tests that used to
fail due to memory leaks. These have all been fixed by now, so let's
drop the prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0095-bloom.sh          |  2 +-
 t/t2407-worktree-heads.sh | 16 ++++++++--------
 t/t4020-diff-external.sh  |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index c8d84ab6061a9de5fe26cd333fe8a7e504a5f963..08df74cacfc6910c51568705855dffa90b79d5be 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -77,7 +77,7 @@ test_expect_success 'compute bloom key for test string 2' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'get bloom filters for commit with no changes' '
+test_expect_success 'get bloom filters for commit with no changes' '
 	git init &&
 	git commit --allow-empty -m "c0" &&
 	cat >expect <<-\EOF &&
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index f6835c91dcc49cfeb23881fe0ef7a96629bfb2e6..7750dc9265a90bdd8b0e3781accb13f00a23bb09 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -49,7 +49,7 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	done
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
+test_expect_success 'refuse to overwrite: worktree in bisect' '
 	test_when_finished git -C wt-4 bisect reset &&
 
 	# Set up a bisect so HEAD no longer points to wt-4.
@@ -61,7 +61,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
 	grep "cannot force update the branch '\''wt-4'\'' used by worktree at.*wt-4" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (apply)' '
+test_expect_success 'refuse to overwrite: worktree in rebase (apply)' '
 	test_when_finished git -C wt-2 rebase --abort &&
 
 	# This will fail part-way through due to a conflict.
@@ -71,7 +71,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (app
 	grep "cannot force update the branch '\''wt-2'\'' used by worktree at.*wt-2" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (merge)' '
+test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
 	test_when_finished git -C wt-2 rebase --abort &&
 
 	# This will fail part-way through due to a conflict.
@@ -81,7 +81,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
 	grep "cannot force update the branch '\''wt-2'\'' used by worktree at.*wt-2" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with --update-refs' '
+test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs' '
 	test_when_finished git -C wt-3 rebase --abort &&
 
 	git branch -f can-be-updated wt-3 &&
@@ -95,7 +95,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with
 	done
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
+test_expect_success 'refuse to fetch over ref: checked out' '
 	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
 	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
 
@@ -105,7 +105,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
 	grep "refusing to fetch into branch" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in bisect' '
+test_expect_success 'refuse to fetch over ref: worktree in bisect' '
 	test_when_finished git -C wt-4 bisect reset &&
 
 	# Set up a bisect so HEAD no longer points to wt-4.
@@ -117,7 +117,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in bisect
 	grep "refusing to fetch into branch" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in rebase' '
+test_expect_success 'refuse to fetch over ref: worktree in rebase' '
 	test_when_finished git -C wt-3 rebase --abort &&
 
 	# This will fail part-way through due to a conflict.
@@ -157,7 +157,7 @@ test_expect_success 'refuse to overwrite when in error states' '
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite during rebase with --update-refs' '
+test_expect_success 'refuse to overwrite during rebase with --update-refs' '
 	git commit --fixup HEAD~2 --allow-empty &&
 	(
 		set_cat_todo_editor &&
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 3baa52a9bf653da9e45df720435cb23d0713e1db..0e5a05894fd1a1be1098b6895283452ca877137c 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -102,7 +102,7 @@ test_expect_success 'diff attribute' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
+test_expect_success 'diff attribute should apply only to diff' '
 	git log -p -1 HEAD >out &&
 	grep "^diff --git a/file b/file" out
 
@@ -129,7 +129,7 @@ test_expect_success 'diff attribute' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
+test_expect_success 'diff attribute should apply only to diff' '
 	git log -p -1 HEAD >out &&
 	grep "^diff --git a/file b/file" out
 

-- 
2.47.0.274.g962d0b743d.dirty

