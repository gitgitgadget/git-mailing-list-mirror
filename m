Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA9224AED
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463350; cv=none; b=YUlD4GXFObSShKRLUaYQ5ZrGCvjqwZ3lJZ8k/gtgDjnnHnVCkRkhwEzww+A8FqBg0c3d0QPbeWIHWB5VFBEpp7UWJArhNKDOFZe2ccmZkiPbZ+bBhpVrJONNDjofQQBfiLR+MA1TXa6FIwZqK46uoA9nq5VTGrXpIemDrhXv8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463350; c=relaxed/simple;
	bh=x6zEzZpx+bxNQ0VKz0w/3WuCDnWSaMjafPKN/NUggOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mn/h/bf03e3Iw1Vd46zSUu9EpaM9QKggbmw3QZaXcMOZGEOlKBPuovZk5d44nWAZ1w7f2Gk/IkAykNc42mtePuor05KQSvsXmpzrqsdYa5J0b0VE59xqW90QoAD0SgLhoVPzG4Drr7PZOLj0fRNvQx7OvySXJGZZulxIj6eJJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cmoCPSAy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kf7RxhDD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cmoCPSAy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kf7RxhDD"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B73E11401B6;
	Thu, 20 Mar 2025 05:35:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 05:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463348;
	 x=1742549748; bh=RC+oEWj5k77m12uZbDBQ4gke2gQt2GP40yqO8tSB834=; b=
	cmoCPSAy5/7GhRTYHv2mWXI5opfkAIIVMfj9k17eGGcuOG7aSB+wIGddwOrPBRKG
	1JYW0YsNNvpCtlBia1m4jMKvBvBFREnsUWksI7x+VeC1vijBrEq/QStSrXyweIZm
	7icnRjco02JW243v+cCEYwnvN0kvN/w3ZMLPeTiDp0HHFu3JiJ5aaRWwZHU6c8os
	61+QEJ/sR0ufoxOKPq5p4RwrcJzc06uZc/oE7KFCWKMn9aSql0B7Pps8RxtCQiuG
	MNyYwYue2bHSmYZbEWd+b2hmQN3LmmYy7ClBDblZGZ3yxJVtT9XNWFEuu2wegwud
	FZ0PAQIGOe0G2/ZO09EmJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463348; x=
	1742549748; bh=RC+oEWj5k77m12uZbDBQ4gke2gQt2GP40yqO8tSB834=; b=k
	f7RxhDDIoiR+rSJuTZYlD+FjT+m/gq3WmGrqlu9w+OKEiYtpAg6RlmWmHSMl1ROJ
	YiOFoMB67eNhg9MztsvcaB4yX/caYWKaoRye3zCJ0tgvhJlZa60DufORB0vN6SRl
	wh3ef0PCRz1FNtMzWDQFOu1kof08j69RWlwsL9ia9Ww+alJC87Rb2BjWYokrJ9l7
	TuoCr7qBOs9s/jcMCWIcjh53+ii5Jv6fo2HlOywwOpGtr31WrqF8MILce8NPkkn2
	vaNb51JDlmEZSmsp1+YuLN6Chi9lykb+6ra54Nrn4o/y2bu6hblo5xEXwcWMMxjd
	lqulqkJjZlUnPsP6+qDsA==
X-ME-Sender: <xms:dOHbZ-nx_fO8S2d7QOOr8jcC3n2w2RFBmjlNd7E8QoNRiROFYU1uIw>
    <xme:dOHbZ11yOWO3QkqLl7L9JTA6m7egyYjU039rqrdl38Ibowp5x5cq-XHEuwNgB3Pkz
    4dpdXf39IpdHgoiFw>
X-ME-Received: <xmr:dOHbZ8qXUecQX4XkfvWAyB07rj3oCb5PXZ45PVglK2YcWdy9d5ppHbxVYd-VcRol5YC8uOb_BkzQTt_X79vwBu5vjXqe1GUj-aTgKkmnNDZPc30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dOHbZymJOCsTcAKFcWOlOdx2-cweWNXHnHy21jLLxQK1_8KuSBQTIQ>
    <xmx:dOHbZ80AXW5P8jcLF6rwC_A5lxEDC-SKWkmt_1snIbN606t0rO994A>
    <xmx:dOHbZ5shNJBW4vOCbSHHBWVjCwyYtlXQ3f1yCUFZFIgBVrsum4KooA>
    <xmx:dOHbZ4Ui5RNTm6YIRM7eRsVVq061dtp-Fnr4PoWLWkUwcGm6txg6Pw>
    <xmx:dOHbZ6B66Cp5oMCk6YkxM4bOjyQpvVI9tOSupxD0APWiEqTWfwutxvkg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c0e8a7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:44 +0100
Subject: [PATCH 17/20] t0021: refactor `generate_random_characters()` to
 not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-17-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The `generate_random_characters()` helper function generates N
random characters in the range 'a-z' and writes them into a file. The
logic currently uses Perl, but it can be adapted rather easily by:

  - Making `test-tool genrandom` generate an infinite stream.

  - Using `tr -dc` to strip all characters which aren't in the range of
    'a-z'.

  - Using `test_copy_bytes()` to copy the first N bytes.

This allows us to drop the PERL_TEST_HELPERS prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0021-conversion.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4a892a91780..bf10d253ec4 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -20,8 +20,7 @@ EOF
 generate_random_characters () {
 	LEN=$1
 	NAME=$2
-	test-tool genrandom some-seed $LEN |
-		perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" >"$TEST_ROOT/$NAME"
+	test-tool genrandom some-seed | tr -dc 'a-z' | test_copy_bytes "$LEN" >"$TEST_ROOT/$NAME"
 }
 
 filter_git () {
@@ -619,7 +618,7 @@ test_expect_success 'required process filter should be used only for "clean" ope
 	)
 '
 
-test_expect_success PERL_TEST_HELPERS 'required process filter should process multiple packets' '
+test_expect_success 'required process filter should process multiple packets' '
 	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 
@@ -684,7 +683,7 @@ test_expect_success PERL_TEST_HELPERS 'required process filter should process mu
 	)
 '
 
-test_expect_success PERL_TEST_HELPERS 'required process filter with clean error should fail' '
+test_expect_success 'required process filter with clean error should fail' '
 	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&

-- 
2.49.0.472.ge94155a9ec.dirty

