Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44C175A66
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423078; cv=none; b=SC1FBKGLwSXCGxakvxZB+peqroQBng7iolZczdYH5RYPZ8IuSKu4yPMfllhLYel+0G6oI+Rl2KJORSJLFQPTOYcvzJuWjcmd9dGJFMiUdj4KD+Wlsx39icPfQeFmSHP4k1x1lOZQ0Koj222WK1aKO8Hv4m11D5pACN7SA0fT4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423078; c=relaxed/simple;
	bh=9bm5OzCbCThHItfjsh9Ju8Q1xEp1Fieu9zrbFfhYiD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDMB9NGfq5nAFKQ6mjznW11pJN39vwl3qOlOGXgR2bEjoshaddEOfSciROB1MlR1zUTjXJzh6s1x3AcYycqZ3UtKC4L3xe3yoW1Itxa7El/tPvvAZMk0gtFiHRMnC8hK6qFj4vszrVaV4KETLCGIbpxClrYcxjcueMqFBpwkKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=taIw7GAz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TecdEolv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="taIw7GAz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TecdEolv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9461BEC00AE;
	Fri, 17 Apr 2026 06:51:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 06:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423076;
	 x=1776509476; bh=hHMKujJ3Ed2bVzrTNKFS3GFMelLY+M0Pp/ZgLkCppNY=; b=
	taIw7GAz74CZ0qBSOOwWHFWXPlqfQxXngA4qljhABvuruZMjhumpZQQ520aZE1/k
	1sGhC7haiNpYYPLd/x5eDkusaBZav/wPWPrLlEWVaDzzswZqHTp588ExSa+Wpunf
	+b5MVALGzfLFIRmkUj2e44p5tMP5e9O5aoKbK7MmiL85TgaK9zvguwPhRMRSSCN+
	uGo10Tep73SfGMcBPUdKlbIHAFUnLRMCQbeNsjBHQJCUUxcOxlhWg9yW4Sod2OEm
	+urz0F35p+pdpxwGkO2hwW7GIEHqd6M9InuKPlgqWWFqoqY3G5I0IyXbCdLspgua
	v75S67PstwAInFlEHfuN6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423076; x=
	1776509476; bh=hHMKujJ3Ed2bVzrTNKFS3GFMelLY+M0Pp/ZgLkCppNY=; b=T
	ecdEolvayEs7G3HZLE6RgvLpOKjT5LREVZLSCMBFOF9r5nyeQHYg903jXeetg0vC
	Nsci9RDL57/qx4AGyfWVzkvIaGPgQ1yPOx6pHRmymngyiR4RIvY6ioB8hK5et/3p
	oK0DJrZYcbFBzcx5u7HiPFvy3+SE1yit4khbNDcRLsUCtbSSIs1+wX1PWBbs6RMd
	/L7d/SW1qHaneoyDsznASKZYVAH8KHyQy7A3oVAf1Fv2rVmKlnNol0GWY8wlo6iq
	8y+P/enHsV1Y84a9xpRyP6HvlVAmjFmklHvUu7bosZsT+2IeaWwPZznNO9jXHtcy
	nvmqs6skofdc/4UsmEkXg==
X-ME-Sender: <xms:pBDiaSmq1o_1n2Po95MJFrhba-lXE_147mYkhBBRDNAYFLBNzqJrrw>
    <xme:pBDiaQ0KQup0rgMNcre-tnMq2d1Vqy3dlAs5jJmZueZtmg5MoNMLEZLPmBsmah3uP
    SEh5HAckzdqla0i13i8zI9UtlXQ8acLYrLQHa-ykdQKgKUaHoaJCQ>
X-ME-Received: <xmr:pBDiaVoDDAtMxn6vaCzeYaEqiXd-x0E3DnpVFg-FpLqhBKaEQmBFkordx3LL-Sil8SBWq0U8P85bZIYyf1s8NORudFCsxy23sB26i7QFl-_4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:pBDiaVdXOHv_HtUOGqRsPLK5NjEWweMhYJEQYUYZL7MIfb2kgGvAkg>
    <xmx:pBDiacqP6rh6487Ok8FPBIwHK8W6TZ_LDMFz7zEwqqE1boqhFAImkw>
    <xmx:pBDiaeEC3YH7X39aLI1p8iyxgL0MVmxvvuz6FEPg_pG7xUqhAsACGA>
    <xmx:pBDiaUtzBynN4eJmIlz6kqCXQriQ7M1T-y9DP8fIrtrwZsjWqcbhkg>
    <xmx:pBDiaVmAwiB3FZfzPfk5gC1t52Hh68mUAH11CHYaAW-wWXP7fetSoYuB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48ae816b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:53 +0200
Subject: [PATCH v4 07/12] t: prepare `test_when_finished
 ()`/`test_atexit()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-7-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

