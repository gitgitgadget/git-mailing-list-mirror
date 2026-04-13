Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393D3B2FC9
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073773; cv=none; b=VcJCJJzP8hsS5nitN2fY8dPWEEEFIEbRJLAgnExL2I/VRIwuRD1VKwd/+I8M/Yaq8tXDL+NOwwulVs69AA0zwbrlIF6iyulVHGVeIkNCYH7xdtE80WxiQr1aVWO1o+rPhd2QSTFMJQgpaqNwJ1l9q2uQ64j5l6CXsNlvbCP/D00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073773; c=relaxed/simple;
	bh=vYAKkWMMwzTF7uFums3DPpUwnu6ta6umfIT9bxOGY2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0XvmzJux6lt4dkhvPemxG+nNYhYzUv5rQR/HKH7kbulg5yYCwo2pwBVaGUGG8uRX6tmhRBeh4OOOUUM088fvmfIwuSsHHOXrjI9nptueFYNdVdRs9x2iKiBfp6YFWn8zt0rl5m+ovbKkGJkkId0pGoIkdmeLojUqOkjS5F7l/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i6e0OmCL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIdrjA7j; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i6e0OmCL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIdrjA7j"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D16BC140018D;
	Mon, 13 Apr 2026 05:49:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 05:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073770;
	 x=1776160170; bh=C3d20W2TZsZKJrnhTdKvcAmzr7vqS/JTBc8wBretffs=; b=
	i6e0OmCLpYJA0112oeHDRLljpoZrYZXvSjDCmq9HLysR+aP9MQHePU3/ik0aDnB1
	pO+JceOLno4ODRb9R959EZ0JoNzurofRJMdt9SReuRojnMESAHR9+83FI+LMzK1N
	whniRMFV0X/4J3W4zDeiVzmKamzF5vych1w+sFT/C961if+XdIk9Gf7r42XOgbzx
	PKHfB+8vA/n1wT8EU34ADXnmg5C4TguUIcQCJVf/hwMHazXDcKFXc3kZcpSr9/Rt
	YOooVq72C5IYG22dRlCAtvt+WzwXsKc1Hy3NjzFdwAnFyToS39BE/BYlqLY6x/nY
	1WgIAOkR1LLyTp7DBJXW5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073770; x=
	1776160170; bh=C3d20W2TZsZKJrnhTdKvcAmzr7vqS/JTBc8wBretffs=; b=L
	IdrjA7jyBfvIINJ9Ezfv3ddPpCtUh/gKGMaYKb9Re5fobRv2sJ8YT72VwLpHhQ8q
	XbCZbXhlWQc8a1EHgIbsVxYUXfTTJJjU3FeBrsKvB+fKJ9xk6Ks8ovC6xypWCRRi
	Ci/zB1zo7JeVPo0c3F94+bPzYQhEF6wHAQk0Ki78gBawrXrC2rPoYN3yTN3G/87B
	VHOLO6X7MYNkV1l/UdPy9LJGFY2phR9mKhtoi0wvZ6UJj27TKIkOLe7nDwoWU32O
	+kEKcROfD5TvenofDEFhoyrwa+VZxpo75zhmTSAe4uL2TS/TJXJJ6Te8M//E294j
	qx5hEcXNWrKrVYwo2uaxA==
X-ME-Sender: <xms:KrzcaQJo3KgFA5Ny5kGT36Eb7no7Robu57a-MCL5GaVfzVbzVna1wQ>
    <xme:KrzcaWK0tWGs_g7NlfjXkzh0BaNISnq9Tx0RlH6zQvYnC9fWnI2VFPs8KlXAATzRV
    EW-ZlNxe2lVXhRdnKghwyclWxO9DMk0cLzlXOIEZlhj1Jjc8p0lOw>
X-ME-Received: <xmr:KrzcaeXPDlVxr7IbTo0UHes54MKWnPPhuBp_hfzLWLhPjURqYVnuI7G-Olo6dCU-ACKIsn0gqnIdAF3N9vU_oiUtn62c8EKuG8LOTQO6Ln0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KrzcaYiLDOt-GVidq2Sbc9nz1ECsDH3iblb8CBKofqI1R2pS6Y1ETA>
    <xmx:KrzcaZ8W2tTyqf4m2C_Vp0TSe6lTqz2g6bduQIaP-pqWXX4V01eCvw>
    <xmx:KrzcaSBnWuu18DoNYISaxN155A8Pxo-nlHD4nUhEkNMPRsUTOdZmyQ>
    <xmx:KrzcaWJbORsymjDS17ISJxrYG8s02iL8vc5YWZDfYhyf84zQTJ58Zg>
    <xmx:KrzcaTifX9OPoHdOp4FrIFp25Qb7HdXyewnj5Z4AnHxZjBABdzkg5TQQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ec659c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:22 +0200
Subject: [PATCH 01/12] t: prepare `test_match_signal ()` calls for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-1-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

We have a couple of calls to `test_match_signal ()` where we execute a
Git command and expect it to die with a specific signal. These calls
will essentially execute the process in a subshell via `foo; echo $?`,
but as we expect `foo` to fail this will cause the overall subshell to
fail once we `set -e`.

Fix this issue by using `foo || echo $?` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0005-signals.sh | 4 ++--
 t/t3600-rm.sh      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index afba0fc3fc..74c2a27972 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -42,12 +42,12 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && large_git || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 1f16e6b522..8e68a00dcb 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -260,7 +260,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
 
 test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
 	choke_git_rm_setup &&
-	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

