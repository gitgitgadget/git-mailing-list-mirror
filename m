Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FF391500
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338394; cv=none; b=tgyXH+bFo0DLF/6LvbA025WX+t81dSbyarQyh1xpGgMQLWIkoDuKDlapaDVOtgkpkzYT/DlR//2IyiIaaGU2oYPIUmGC10iBNQBp8esMyeTJbFilX8m1u0EeeT3Ggz8U1w89e/6aIZZFQV1OAoHIZj4PaAsH2rzslzATsarxbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338394; c=relaxed/simple;
	bh=9bm5OzCbCThHItfjsh9Ju8Q1xEp1Fieu9zrbFfhYiD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjMVerktTmd/4jJXCI9AdRbAmo70JLY1C1T8f7dedPPYRTmZLrSeo/PtYmT6R50vb0metDIgun98Ro3We+8Lk/Ci7hCJxtvLpMMDqt//NiTa5Ld3U4Xy0BtLXFtOFQ0At5mY+jLGrzhaFyg05EEH7SCsHb06r8dFSVXtxZ5Lh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qz68N7sf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PclYKqJp; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qz68N7sf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PclYKqJp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B1BE1D00255;
	Thu, 16 Apr 2026 07:19:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 07:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338392;
	 x=1776424792; bh=hHMKujJ3Ed2bVzrTNKFS3GFMelLY+M0Pp/ZgLkCppNY=; b=
	qz68N7sflRvJoep5voKj+mxnsmFBSmLf40sfCgQX/VfluTyEq3Rnur0iIb3eMRPf
	kpAPMmIt6aogC5y7SGU3Q7uUNILdYxmkAy9sMbF1wMH3D5T7t7ZYMPdafLm3Jwno
	h8INT0NAli8N38h8yHD+gwjJyT8gWCH9PH9RakiWD1UyS0JNKnE4tEKwJTF5IEZi
	Ins3VBvn8vhyLdV6bpYim8tGo58X85PNNdqtiT3gSw3jXHyROcaJ8cROaNde4VJg
	qHkR7mNARxhcB8oVj7IFNs7cBNuo2TpSbhqlV82RZc4EDPxZ4fgaozygkCY5AuLq
	D0Ke1JZ36xhHXWizODBvgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338392; x=
	1776424792; bh=hHMKujJ3Ed2bVzrTNKFS3GFMelLY+M0Pp/ZgLkCppNY=; b=P
	clYKqJpZxfS/42pI+Tl7+002bYaknMcKlwEROogE8jiyq1dtTf1gljACkn9ru7Vb
	wK7zF/X0yvLsohzH3B9dRAwTIxeADM51QpmrrRvatEOD0ekUgqWypJtIOwXq4JSQ
	UT+twonQUm2DQkrp8gIhUFE4E/llJ2c2as6tXqXCgTOiJka83C/xJIlc0IlLUDyL
	VQDVUrWgAOa7Km3Anlzy2U+lqqaaDw+C1JlpKW78hROLjjwgtuc+/v6/gc2f4EzX
	LjOyYaMrkswDIOAwumnng9n3KV1EH5dviFAUqBOnGK3U0Ka22QNk3rNUscX9Xouu
	jXjSdhDMH0LeEQJ1VVAWw==
X-ME-Sender: <xms:2MXgadM63pjwDmZGht0cBaIAVtlVyRxs3knfwkb_OaB17vorJwAXKw>
    <xme:2MXgaXaVzqXWTYdw_Is3WBVzq-g6q9vAVng1Ghj4gXWiI7PFlscyMICPjBB8gjLP_
    POgQ7dqqRfnpCzI8pACWFcYV8y69ebq1moq5ihJoFJtKTDkLl7VLFo>
X-ME-Received: <xmr:2MXgaZqvg4R94EZG5lo6YAq8kkRusnKiWJbLE1GNM7CtgZYB2Vw4vqAEG7vCZLcd5Gr5yNBZD0gkIbnGVpoOICVt0pNb9J4g_b9vmJNZeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2MXgaTakmBLLFw2bPiq_Tjg3qy00P1B4CwYHMRaEcfO_Rp1wOmRmJA>
    <xmx:2MXgaZTqr66xM6Zi5kro43iCCKqTvtf73wC6Ua9L3rN-J6twRofWMA>
    <xmx:2MXgaS5aqRACyGs3ml69SjEbQPn1SzkXkNXZCyj0mvzVRCU3RVTPEw>
    <xmx:2MXgaWzDW7NjldzmbyhjagwHTObZxISHDtgrXGxdPLyW71CvLvm44Q>
    <xmx:2MXgaYKhW79RC1Ux0ebdeZEeX6NBQTFr8RzQHKZD9Gmy-vdZ2Mm0w-gV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8aee8fa9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:24 +0200
Subject: [PATCH v3 07/12] t: prepare `test_when_finished
 ()`/`test_atexit()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-7-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

Both `test_when_finished ()` and `test_atexit ()` build up a chain of
cleanup commands by prepending each new command to the existing cleanup
string. To preserve the exit code of the test body across cleanup
execution, we append the following logic:

    } && (exit "$eval_ret"); eval_ret=$?; ...

The intent of this is to run the cleanup block and then unconditionally
restore `eval_ret`. The original behaviour of this is is:

   +------------------+---------+------------------------------------+
   |test body         │ cleanup │ old behaviour                      │
   +------------------+---------+------------------------------------+
   │pass (eval_ret=0) | pass    │ && taken -> (exit 0) -> eval_ret=0 |
   +------------------+---------+------------------------------------+
   │pass (eval_ret=0) | fail    │ && not taken -> eval_ret=$?        |
   +------------------+---------+------------------------------------+
   │fail (eval_ret=1) | pass    │ && taken -> (exit 1) -> eval_ret=1 |
   +------------------+---------+------------------------------------+
   │fail (eval_ret=1) | fail    | && not taken -> eval_ret=$?        |
   +------------------+---------+------------------------------------+

This logic will start to fail once we enable `set -e`. When `$eval_ret`
is non-zero, the subshell we create will fail, and with `set -e` we'll
thus bail out without evaluating the logic after the semicolon.

Fix this issue by instead using `|| eval_ret=\$?; ...`. Besides being
a bit simpler, it also retains the original behaviour:

   +------------------+---------+------------------------------------+
   |test body         │ cleanup │ old behaviour                      │
   +------------------+---------+------------------------------------+
   │pass (eval_ret=0) | pass    │ || not taken -> eval_ret unchanged |
   +------------------+---------+------------------------------------+
   │pass (eval_ret=0) | fail    │ || taken -> eval_ret=$?            |
   +------------------+---------+------------------------------------+
   │fail (eval_ret=1) | pass    │ || not taken -> eval_ret unchanged |
   +------------------+---------+------------------------------------+
   │fail (eval_ret=1) | fail    | || taken -> eval_ret=$?            |
   +------------------+---------+------------------------------------+

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 879ee1ee59..502bb0ddcb 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1512,7 +1512,7 @@ test_when_finished () {
 	test "${BASH_SUBSHELL-0}" = 0 ||
 	BUG "test_when_finished does nothing in a subshell"
 	test_cleanup="{ $*
-		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
+		} || eval_ret=\$?; $test_cleanup"
 }
 
 # This function can be used to schedule some commands to be run
@@ -1540,7 +1540,7 @@ test_atexit () {
 	test "${BASH_SUBSHELL-0}" = 0 ||
 	BUG "test_atexit does nothing in a subshell"
 	test_atexit_cleanup="{ $*
-		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
+		} || eval_ret=\$?; $test_atexit_cleanup"
 }
 
 # Deprecated wrapper for "git init", use "git init" directly instead

-- 
2.54.0.rc2.529.gd9106f7525.dirty

