Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0E1D63DD
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564188; cv=none; b=KQyX7wTYxRuGIZwwtpF5GUzdaqRdXhohtP3mfC/3+5olpMSzwnky5YDHFQJjO2zmGMMlwyH+PwAJOyY69lmyuGRQy3jSmH6ls8AidibPtfgzVeKvEJKk/fbxtxxDnUdDQsgLbgbnVDqjDk2OQ7p0Qy39gVAi0+StNec59JvbzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564188; c=relaxed/simple;
	bh=VGYVGVzADvFJi920HxjTNNlr/xldFe1DUy6hDcwHgfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f6bT+zhUw9UJGWTG59BhScJMRY2qPGyV9s12JgrSpiGSPU+vZ5ZRVuT5NR3tvmAFp/jdnA7HNxWo9NCyOUzmeQya6jmSaNjnSoW2sKKQtZmVAOTEPxglKmmW4+oMvLT0fdGZy2fcYU8cAtMTBx9aPH2tZ9+A+jYMi3CxraJFV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m3bSWMh2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0uTb4Yuj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m3bSWMh2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0uTb4Yuj"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C712B1140174;
	Mon,  3 Feb 2025 01:29:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 01:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564185;
	 x=1738650585; bh=2EM6yGfIcRKfHB0cAvM0gQt5x0ZGXVK55FzZP43vO/Y=; b=
	m3bSWMh2Xr02/yZ3eZuaQ9ZeIBLvZACg2LAlWbzUfQccXgUPeIATwUSNQ3j4fyQq
	3VcgvHAgqYXKozhJrs7xfIy4I9jmjV9wYBMg0Cm3oQP700v4xB5E6W73IodVW+BQ
	3pb7kGGFzxU2hvH5swIZOD1xMrkGwusK9kZVvl22PgYmGBsO1ZTitdv4vyX/jI8x
	6Fk8NY4bjrS6sBNqkDXWX7Zj+TNyB3TXTIhZFQ+wT7816kSLUjul5Nn9Bvs/SAtu
	V2aAV6jx0lX0V1j0m5cWjQTzgbML1Ra2tC2PdUDWTseG5E3kpxnhp7USK5BEzf9n
	prQMLW6yKGa9TtrUHpu32g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564185; x=
	1738650585; bh=2EM6yGfIcRKfHB0cAvM0gQt5x0ZGXVK55FzZP43vO/Y=; b=0
	uTb4Yuj4gpPXaCG/efUg6hAgIqBlaqQcaXyVTcm6J5xhTNWyaql1ulgSSDi6qEm2
	9oBQ0IcEzmGQcF2R9H3Tnn99q4t60+vzLj9soUhzIcCdOOjBg1aeyZRwPX4Co/4o
	h9uFDR4+61FT6rmFp3O2wz3DrzRcXRY6kopTaEUvFqaXMbdzZTnDD56kXa/51STW
	/gN/HwnnhbQkBTtkkC9FBug8qbtudtEbyIfz9bPidu4/QYQThZTrl03zDx+8uS+O
	YIFypACrO84jUsr/p7dRZ1SgkwGv6I0cHLVgqpi52/KDRPcytRc+fxVokfXYDH9w
	TeiDw+3zHArKl/llwGP6Q==
X-ME-Sender: <xms:WWKgZ2Hm9R8ojXcq1igYAtkvrfirK-TTaAqlYQ_9FoNE75HCBUOXng>
    <xme:WWKgZ3VZEFBpnFQokHS8iTfnJAWmUm4GFIgKy_moHCkxiNKHRax1hkxebYMelDWNM
    0ZPmQFQW4_-vFcXSA>
X-ME-Received: <xmr:WWKgZwKNkay3pJYJWMRB1dkYYghMApRqHVx6-l9e41zLoSr6eY0I-Y6tbaC0buIxg38WokfBRt_P42SVEUaFXZOB_nItfVQiEotK5m07zotm9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiihhhihihouh
    drjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:WWKgZwFCZD1HNhiJR65u1dpFz4Aa_1N3MNyJJr9fXy4ZS1LELl6iUA>
    <xmx:WWKgZ8XELCphkyiwOkc8PBbWha1L9CysXek6jtvxPyKjd1lXQ-DH_A>
    <xmx:WWKgZzNiW-ofC3BoXne5-U3mLf7O27ch4VW8OyfXAOOkBENvb5vNrg>
    <xmx:WWKgZz0zxBaqnvQcijKWxcsOe1HSU4hLXV6oPXhdExa4iT02NuormA>
    <xmx:WWKgZ6wM4GorPelPmi5rq8EO42O59QMqR3m6PcDd3Y_q4U5fVOMzYj7n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cee124e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 07:29:31 +0100
Subject: [PATCH v5 1/8] t5504: modernize test by moving heredocs into test
 bodies
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-1-d66481e36622@pks.im>
References: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

We have several heredocs in t5504 located outside of any particular test
bodies. Move these into the test bodies to match our modern coding
style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5504-fetch-receive-strict.sh | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index e273ab29c7..58074506c5 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -64,12 +64,6 @@ test_expect_success 'fetch with transfer.fsckobjects' '
 	)
 '
 
-cat >exp <<EOF
-To dst
-!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
-Done
-EOF
-
 test_expect_success 'push without strict' '
 	rm -rf dst &&
 	git init dst &&
@@ -78,6 +72,11 @@ test_expect_success 'push without strict' '
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false
 	) &&
+	cat >exp <<-\EOF &&
+	To dst
+	!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
+	Done
+	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
@@ -94,11 +93,6 @@ test_expect_success 'push with !receive.fsckobjects' '
 	test_cmp exp act
 '
 
-cat >exp <<EOF
-To dst
-!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
-EOF
-
 test_expect_success 'push with receive.fsckobjects' '
 	rm -rf dst &&
 	git init dst &&
@@ -107,6 +101,10 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config receive.fsckobjects true &&
 		git config transfer.fsckobjects false
 	) &&
+	cat >exp <<-\EOF &&
+	To dst
+	!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
+	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
@@ -129,15 +127,14 @@ test_expect_success 'repair the "corrupt or missing" object' '
 	git fsck
 '
 
-cat >bogus-commit <<EOF
-tree $EMPTY_TREE
-author Bugs Bunny 1234567890 +0000
-committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
-
-This commit object intentionally broken
-EOF
-
 test_expect_success 'setup bogus commit' '
+	cat >bogus-commit <<-EOF &&
+	tree $EMPTY_TREE
+	author Bugs Bunny 1234567890 +0000
+	committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+	This commit object intentionally broken
+	EOF
 	commit="$(git hash-object --literally -t commit -w --stdin <bogus-commit)"
 '
 

-- 
2.48.1.502.g6dc24dfdaf.dirty

