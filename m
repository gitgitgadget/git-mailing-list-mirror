Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1F1B6D14
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320817; cv=none; b=TYxrumOuyU93RA9WDD2YSPSZkqK2CD75Qks3X7PlHod2pW2prlrru6LN3Pg0ANj0zRmDnnwrGeiRjGjej6tAIfjJ0xJ+jTsvh9QG1bNGi8+LLHcSsOoTG3/aYw9GAg+qsEf97YNKor7t+qSxB4/LE45h1Po63Xqjbbb6d2wwcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320817; c=relaxed/simple;
	bh=HsbzcnVr2EotYJr4vC0edAZ/b9T/cJQISlKpapwIhCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uh8uLfP5R91VV2SlfvQu1B7vmgjWmdz2U35iWRbg5uIwSoclAJqnC9JCWu+bKD/83Ie1uzN51kY9enFQenGK3gJdMsgWYimju+xQmTMISb9MPrufK5wdxTwnGFRdB+oj6cuVOsRtccFf2chsGDvhCR1cqbWpoe0epd715nx8HgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Flla+B89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kNjWkiwE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Flla+B89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kNjWkiwE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2559111400FE;
	Fri, 31 Jan 2025 05:53:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jan 2025 05:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320813;
	 x=1738407213; bh=mUetU9aMVjFZsrehrCVeL7icGo49NoSwcHPwAYFsyAg=; b=
	Flla+B890ofeskCfb62QMQeLhmue3sr5zkthkChG0Z9l8v0WuP2929oO3cxwPCUG
	4FNBO8AQ5GFXdqciC0HjFoqJxzW52te9ofHziUPCCe/eWeyoP5920O47oTfshKcx
	jxqM0W50BmaiHz4Eaj55h0Lk3MwiIQ1m9up6AfguEV0D5pxtNX0v6U3MtIyegnya
	mk9+APZk03ljgYS5CMb3+ntcFadgpdGLOu4mMnCPpgEi9rw2hQ1p7kLcD2twGTyA
	k+hRGSS+il54AVXD8evp6rSJMEpx0MXrp2LItLfXmD0kQrGsBkSi/Pp3xzE+YHTl
	zxS0q2kVdCo8fYZXFLS1cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320813; x=
	1738407213; bh=mUetU9aMVjFZsrehrCVeL7icGo49NoSwcHPwAYFsyAg=; b=k
	NjWkiwEAWSbuBlXgs5LFrJsIM02BDEHtaJTH/T1ffbGKv25N/xgwpL5qkX9YF5QT
	BUNgu0Tr8LzetrEr7CL2ZvdmU+RC+S/TUbM1cy+b3OPQBdHfLQpBn5VibOXTSgHH
	Z2Pj2TJwlXoZNRg47CnRWlgxrl9lpTkP1FFUKAVLpBjQDF+B9S7qA0G8d3/cqAZr
	kwXag2W1EwTOOrBTAf82PXqPJOJyBHv29ydz6RXMN9IiDX6OqnWa38rDq+f/j3hC
	zm9F04DyHAi+7EuG8Gl9eb9qJqY1UpSnEq8bQZviy0DSkr5DqZ9kh9xUs71eztWz
	E/O8tJ+GHuzV/i8uhucOg==
X-ME-Sender: <xms:rKucZ8OYNknkFYwpgOncd7jgS7DgzVwhFpdag0TIcJrfWu0_rTCNaA>
    <xme:rKucZy9ZOG9sDCs0EP-vXNQPjOpaNHs4tiNJdqKFvh2cgRb9mcTqxFaxJDAlTdBpw
    OcTEK64uEIQPZSJ9g>
X-ME-Received: <xmr:rKucZzSL0uvgaueUcPF2uqwkf-7qdRwSA2knm8RKV_7pYIdoeq2J_tLoQSQE36Vz99lWyZTFLDu0euj_oDNt8e0fqhNdaqWKi7hTsEjddVTtxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqihhntgdr
    tghomh
X-ME-Proxy: <xmx:rKucZ0tpiUJLe1eI7Jee_d61wyL-mtE7GGwMVJA-9-7JX8O_oKTTwA>
    <xmx:rKucZ0f7giBQvr-abAMWGvrLj1YeB2_ZdhFNOStLQTdd7to71-rbLQ>
    <xmx:rKucZ41j4T0-ikPz3L5eupIi_tJ1FYtpRT8cV2KNkpkK_F3tRx-xrQ>
    <xmx:rKucZ4-iAVd0vW2dsAKVDTpe0Smnjrz5z0UbkrYtl4haONKHWDIGrA>
    <xmx:raucZ87N69IvUUjob14FO_uscGzAOnDr9siA2pKMTgb5Dv5R-lx_bJMF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd705b60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 11:53:25 +0100
Subject: [PATCH v4 1/8] t5504: modernize test by moving heredocs into test
 bodies
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-1-a8b41f01a676@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have several heredocs in t5504 located outside of any particular test
bodies. Move these into the test bodies to match our modern coding
style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5504-fetch-receive-strict.sh | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index e273ab29c7..29f18841c3 100755
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
+	cat >exp <<-EOF &&
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
+	cat >exp <<-EOF &&
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

