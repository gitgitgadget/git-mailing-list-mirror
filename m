Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7739B959
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423062; cv=none; b=j1AVjB5SDnb0vwgqR05Qntl1r8nmRjrcn8+8dnFBDy8x9UOwB1+mbGK51SDXvLWnLcrEu3FRBmSNxaI/FUSmBRO3AcGv0qBuAyio5FZ4LABb4tsRIQBCdT+Uu0KJj/YodAhaU5QIBG1uJguOQxz5g4uem9TakWfXtxAj3Baq5/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423062; c=relaxed/simple;
	bh=YXT7/poVCz51SQ52IQLErSmPA1zRE6DtveYVXQBFA0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0Te6+SB7t6TcAutRnG5DLoVTauiweiTJnBJFGpxsMPH9hme8lzMdHHk/38bdeRqHl29l09k4eqDYP4r6ryMlvj9HVwzOESMIGrJiSMfXubaycZEOMdaAAlrh3EoPc8lj/i+1QWcAEZW5INP3KjwzC+ZAiWyg3Vs1X9VfemP1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HU6id9g7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pR5YX7d4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HU6id9g7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pR5YX7d4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A785D140012F;
	Fri, 17 Apr 2026 06:51:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Apr 2026 06:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423060;
	 x=1776509460; bh=mMwjZrEM95Od0bQugABsmaEZIyZWB4R542aDuTUvirA=; b=
	HU6id9g7fCM6hLWS4KCahVgKOF5kr54OPBU2wnv9jo8Pj7nCbx7eULgLknbCX0SL
	pFimiY5V5mG06oDSCIEeL45QP7qk8d3PosL3tT5/t/YMQBgvNPI3aGXG6j06WFPn
	PYyfGkKrepmwXSx+I5rc2WNxcB4eKbKkPP+1H6osc9V24m5Y2bc7kaWjAipexWod
	5f0XLJSUiEeoqVx+32iiSMw70NIpha0kORYOn+MV5jJIXRADwfqFBOfvG4YjPC70
	JiSlXBHqnaCTwiK9jUl+1Mo+ybcAct4ah/rrlumATn3aYZpz8y6ACrleZyTylpDl
	6w0lioFZOqGjmj1TZ4p3tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423060; x=
	1776509460; bh=mMwjZrEM95Od0bQugABsmaEZIyZWB4R542aDuTUvirA=; b=p
	R5YX7d44tCOSsGSXwaY7nT83sF/hOTT5pAg6QNA9YZuaJu72camrzWSkR65iXKhI
	bWMwjA2vQ5DKU38oVqe2V3X1+LNozl4bACSpydcsvFBdQAwkcbXeiQ/VUtRlEMZa
	Bta67UuJShWyzxTU2AaKuDuLjSfaUffAnuHRLAfrjCBLhNW6YmCBs6+ON4t4B7Kh
	uGEWOvKmfw2r5BBwYVWs2i9gF5sA6LHY2P0DrIHYMg4QlHxV+w6og6xc9tADbSB2
	uwqh68V615uJxgvZdgncY/rXv/55wXUSuDrjUyy/YYex6lz+q0n/UBWRVZvAjxoN
	AdxmDKBYOAHW/l180W3ww==
X-ME-Sender: <xms:lBDiaU3gEiPDNbZ4Ky-PNAnV1Qd0HEB0IMYbP2BchiSqBMD_UOAxqg>
    <xme:lBDiaWFvudQQyf9zIlZ3GmJjUOkBDWGBPd3GTBb5iQC-HevLdRXqio4CFL0IyCfjT
    jVPjwNGsL5MIZh5ZNP9f88BLueqqlB88dIYwR2_jT1njRYf0USPWQ>
X-ME-Received: <xmr:lBDiaR6gW2Y5YThQAqMYEB9yUKpJ_4Z8zy3F_7n5c-WzVSijoyt9S0EfbGZ6fK-0axDgmnqN_oqZjuz9MFwdaQgPApHxq4_JRIZ1z4z2p0di>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:lBDiacsupl9LKEq2Z2o1PRWmtVSUB3rvC1vMjiu2UKyO7bt5TA7e2Q>
    <xmx:lBDiaS6EMeIBrBhP2kNaPR6Xza1DkvAv83alMLJllSTO1zrvn2pGUA>
    <xmx:lBDiaXXp1NjWkbJl_1OG2B5nRnAnEvNa5LX9Hr76tYkKRC5BKh1mhg>
    <xmx:lBDiaU-YLdJSe-XqcCPpxC1-lvtRMYHzrMBG8k6Bbi0Og0EnK_kPzA>
    <xmx:lBDiaZ0uFKIiWP4M66gEMDZm6HKZcWQuAzxULwFZNqWV626h_F0x2i4v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:50:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e09d63be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:50:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:47 +0200
Subject: [PATCH v4 01/12] t: prepare `test_match_signal ()` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-1-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

We have a couple of calls to `test_match_signal ()` where we execute a
Git command and expect it to die with a specific signal. These calls
will essentially execute the process in a subshell via `foo; echo $?`,
but as we expect `foo` to fail this will cause the overall subshell to
fail once we `set -e`.

Fix this issue by using `foo && echo 0 || echo $?` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0005-signals.sh | 4 ++--
 t/t3600-rm.sh      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index afba0fc3fc..84319cf169 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -42,12 +42,12 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 1f16e6b522..a371ea690e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -260,7 +260,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
 
 test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
 	choke_git_rm_setup &&
-	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '

-- 
2.54.0.rc2.529.gd9106f7525.dirty

