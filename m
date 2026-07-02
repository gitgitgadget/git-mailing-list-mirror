Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4347D93C
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993682; cv=none; b=XA2At+GAsDGTTvUX2qhod4U43wtHKLsvMxJKarn/QQm+Lobq8pT5L7Eug/bItDveegSD4urqh+4Jf0QnSvpdQxCL/iJWxTfLwogPYPG+LtjSOCvKqFXkYbe8kbU1HvAzG+4zld+aOAO3pxHbyLcHMBsl/X7ntg2grTXweugI0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993682; c=relaxed/simple;
	bh=lXOgbVLGrNghm+plWZn+RYv+YZhfZLdYR9s1+LINbtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G35xY3xwvQGKeDXmnjLUf6aCeaAwmsrPZFdyQQY+4kM2pa0jYopKOSXKkcsww187jwbSXEPn3n5+HdzgpEA/sgAENCrRNa6wyC+8vvjrWVI5eHPE+P+ymN9IxBC8hb4u0SNcCpQZHiP8T2UlmCjsQGvbene07j4JIo+Ydc9y8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K5sYyjLr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHH/uWVX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K5sYyjLr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHH/uWVX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D58EF7A0031;
	Thu,  2 Jul 2026 08:01:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 08:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993680;
	 x=1783080080; bh=YID6bA5wfReLH+/U8xxD7GJ0Xwz6C/tuyqWLvDiJlrY=; b=
	K5sYyjLrL94ywB4QIY602O3+THqxRe3CydJ6NDfFqOj4+mNZ4C5EwfApj6STG061
	Xs2balxeWH+CeDbHJYtoGnprJOu8nKyNhzOfZZzNpzsnceogslZKihJJSszTXJ8U
	KyFy5aVTX+/mUYW6oSV1VVdWqiB3+LpiC4oDyy0oUTlg5ARIh2vocnfWlRO7ci7F
	N+mFPwvH7xx7qj3EBsxsf6SqTW4rtnNyrRfyBXe0yHVAHtuxankKnM6YV2ylhuRA
	mHtWrBAWEm2iufedtTrAJslF+MwAAMXZI89oGU82MWBUeZmZVHm2mSL6G6FnR8hD
	wb7fNpv8te2I9Y7qq+bIfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993680; x=
	1783080080; bh=YID6bA5wfReLH+/U8xxD7GJ0Xwz6C/tuyqWLvDiJlrY=; b=Y
	HH/uWVXi5+XMD7hqieLI6wgnVH30jEstUIwCFh/tHEEXV0mPcXJwyjOagBEZC2le
	AqBnV9QSp8f5jYPANTorTG30tCZMXV8mhLcUhB8vgCPJmNke3NTapKtN1qkympDu
	a6weNCbbb4yZo/cYilubRncdPbtNRHQACa/emFtFWWEO5X5d+I84G1Xh5Hum17tM
	8Lm3AhtjZq0uz+pMPDNYOpKGUKnZD2a3RWmkBINy3oMtSDGVXnmdUjN8kbWyBCv0
	+cycrn9zrPDF4n9L0rV9bJXHBFcwDQwNXPSg4J5ZeWHmTQ1tXLIcrJp/PWDobo1k
	VP8XOd/Z6ysh1HBPQQ8Yg==
X-ME-Sender: <xms:EFNGapgtQFTkGyBOFeVj3ZcJtkATg-OdJep6SCX0K04sbdflEiIXQA>
    <xme:EFNGalfxOxKMILkn-uUo4OtoFB5wKh1gzEGnBAgSYFVoISJzMowczrvCCVHgUMeSD
    k4oG38WmQ4O-LBuoBxCi0OTTN45qZibPudxwqCUQxoI9__4g9LPnQ>
X-ME-Received: <xmr:EFNGamf0C8FfolWvcYabsnrB8xi-wyyA4QbeCa4P5mdPkgV9mCSm83M8kCJfN7rA446WxFDn1iMhQRLwn8Aqqr1zrUpDcY39kMJPgUrMwJFo1g>
X-ME-Proxy-Cause: dmFkZTEa/pMqGTBJ2nMWyF/M4a8PLqbQYM8Nj2TBdCbtW/8Wl7krpf8gxnRGQTQoquOhdo
    6VgJXEj9fWg+vgkmD70bOAB/bFoSLAuqcan+dMt5rMioyaUEAeajHYfNi8S+goKEJa5mLz
    7k9FPiIbhwgzMYGXdRG+/bYtjak55xD22cGzf8Id2pD4S7oDrhXjEr3qh91H6PPG9SsHEF
    6UEnQGdoO6xon/2UFlM1EAZROd6jgP1h9Qa2dFAGvhB4bfjz+1W8ggIx72TWAkmcAGgitf
    nllKaA218pMDAKPeKT+Xf4UsjlCevhsTMHjAopmf4n4pQpUVY6CWxmRB98ksf+AqVdp2K+
    UzLgjJwwlx1M+luN6petn0dMcjULb68Wd27fN+6ZnRX6nMhD+bZQo1oMQi8TH/HunlgJK0
    bU7FvMF58hlLnzfyi7wxMN0hZGy8sdaAC3hdXSlO1ZU24Tg4CQv9wSq3SsSr5VqS0/24dz
    ycz//yCsCVYH1oPKo4IchpKgGXU2SA5VDvyxQWDnyLbog5FOQY/eypmWupLgVnMOYNVwFK
    ShoMtPE7dgs5iY1bXeTReJbcZu+PEsku9vpGHI+AkJEURoLutvbjJ36gGthd+k05U9PJdG
    eSGTb6VuT19dz+l+6eWSSp5NMxPdHZDqbHwrkJoyw23cw/vxLFIDDWzunrSw
X-ME-Proxy: <xmx:EFNGan8danmth9W_8wQuSoNdfOnUHrZ2NccPCywO0Ibi2LW15ijOqg>
    <xmx:EFNGaqkkJMb3NGQ8ENRv3qlFa9uvepG5eP7QKDobWTPIPUgKqVFNRw>
    <xmx:EFNGah_zsDohtbWRG31NL2-OAczdXzPurrws7xV0aMR4LTP3CcupnQ>
    <xmx:EFNGagloLGhm873aaDcMurgpFhEIybGgQnx-zgQfnk_9YM8ToEoP_w>
    <xmx:EFNGakB0h4OA-7cLP38wHGSFcmH4XagO0fOxcZhY8Gds9WTe4LY6h1qR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5c6c63b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:00:59 +0200
Subject: [PATCH 6/9] t7900: clean up large EXPENSIVE repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-6-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

One of the tests in t7900 is marked with EXPENSIVE because we create a
repository with 2GB of data that we end up repacking. We never clean up
that repository though, so we occupy the full 2GB of data until the end
of the test suite. Besides clogging our disk, it also means that all
subsequent tests may have to repack this data multiple times.

Adapt the test so that we create the data in a standalone repository
that we clean up at the end of the test. While at it, also disable
auto-maintenance so that it does not race with our manual maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..8a7e1306d0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -461,36 +461,42 @@ test_expect_success 'incremental-repack task' '
 '
 
 test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
-	test_config core.compression 0 &&
+	test_when_finished rm -rf expensive-repo &&
+	git init expensive-repo &&
+	(
+		cd expensive-repo &&
+		git config set core.compression 0 &&
+		git config set maintenance.auto false &&
 
-	for i in $(test_seq 1 5)
-	do
-		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
-		return 1
-	done &&
-	git add big &&
-	git commit -qm "Add big file (1)" &&
+		for i in $(test_seq 1 5)
+		do
+			test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
+			return 1
+		done &&
+		git add big &&
+		git commit -qm "Add big file (1)" &&
 
-	# ensure any possible loose objects are in a pack-file
-	git maintenance run --task=loose-objects &&
+		# ensure any possible loose objects are in a pack-file
+		git maintenance run --task=loose-objects &&
 
-	rm big &&
-	for i in $(test_seq 6 10)
-	do
-		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
-		return 1
-	done &&
-	git add big &&
-	git commit -qm "Add big file (2)" &&
+		rm big &&
+		for i in $(test_seq 6 10)
+		do
+			test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
+			return 1
+		done &&
+		git add big &&
+		git commit -qm "Add big file (2)" &&
 
-	# ensure any possible loose objects are in a pack-file
-	git maintenance run --task=loose-objects &&
+		# ensure any possible loose objects are in a pack-file
+		git maintenance run --task=loose-objects &&
 
-	# Now run the incremental-repack task and check the batch-size
-	GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
-		--task=incremental-repack 2>/dev/null &&
-	test_subcommand git multi-pack-index repack \
-		 --no-progress --batch-size=2147483647 <run-2g.txt
+		# Now run the incremental-repack task and check the batch-size
+		GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
+			--task=incremental-repack 2>/dev/null &&
+		test_subcommand git multi-pack-index repack \
+			--no-progress --batch-size=2147483647 <run-2g.txt
+	)
 '
 
 run_incremental_repack_and_verify () {

-- 
2.55.0.795.g602f6c329a.dirty

