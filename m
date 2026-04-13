Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB83B3BF5
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073788; cv=none; b=O4fkNbUtp2LcIejCoaySrzx+WChbYWBkYitrs81Fq8Kh74rin0Afo+CuplR5N7m8dEC6/eafxf0nGqWYJs2KnCZEhH5PlVYzNmIgDHYNfaEYr9YuFYtltEDyFnheokDGrAgUqdW7wIAb+OUYPjAgjYU8yXA/Zt/z55IpTjQLvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073788; c=relaxed/simple;
	bh=wVDRgepiZYnvE5vWDS28KjMudBi0rtYu1mvjGnGT5eU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ik5UBwlL1goEA5DEq8AJAjpmagdB+O35VNmCnVQQ91OAZS/GoA/3sn3t8OazhTNdSMMF83ul3YTrtuyD5HUBZR9pULacsJWn8i5uNGbSd1xvvH8MwEZQPnArWXydZhcbPGl1QknOhRRP0O5FN11A8K1dYbD/EOyKhUzr/Qqalv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SieUMGb6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZl0xR5F; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SieUMGb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZl0xR5F"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F3F77EC0413;
	Mon, 13 Apr 2026 05:49:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 05:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073785;
	 x=1776160185; bh=SxDcFCViFR2NBB4xBZIvr/9buU4I6yEVaKtvQKg58FA=; b=
	SieUMGb6C3XMIx6XTS7PMvqxGoD5cuR2Wgf4ZC91Hx9LHI6xshtoDGRlsIjjCj9r
	Azd/HG6AfkvfbpbegMnEbUYhffZQlQTyS7rptq/nfhsJAdNghpjpg81wqzQwx/nB
	J0lE9hAE8oi/SVNUJEHBGFMoCs0EzeksCSw4Xzase2tqzQQVDLsDYibmNBcM3CV1
	tifsIxzJ3lMGak2qtmQcGBeog62fYbN1kdZNKjn7GtUGZKEFfSocWYic35Po/ezZ
	42wKCBA4lRA1hokMysFvhv59DbKYeg3xa+IVBr1VzVAjioMeJ8Ipk7ZAzIN6QFPw
	XzMFUCytvyvdxWzipgPJeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073785; x=
	1776160185; bh=SxDcFCViFR2NBB4xBZIvr/9buU4I6yEVaKtvQKg58FA=; b=Y
	Zl0xR5Fcgqh6QvOTNgB4S2IX3oYsUcb3+32G5V40/aii+zQwgiUWwrYVvyvTE0A0
	v0mLbsNqkDCU4omASvWpqqJqacJT8XO5UEZjRLsLgOkOE1N7PrM7kH9l/SSRRvrw
	EJ1c/hK51tyGBvCE3ZEQTNSZMP++knBBi48P8dgLNh8fU5DaHUfNMXyPvxS01ni9
	7tFBnLGAeIyvmP+jLaTZ1J1X4oDkNQ/wYeSXnYu6wI2wsqx/QltYZfbiJ3tsq3t3
	0KqnJ1IdBnUH9hKA/tuk+X1KzmTa7m7tU5b+QcyOgOxIspy19h/cB5Rs0BP5vl/j
	S8dngHvYwtS2K7GZqKXMw==
X-ME-Sender: <xms:ObzcafEwHuxNizhvyYqnqIbjOsr3kpI9weUBk0EF5avKne-wpe6jRQ>
    <xme:ObzcaSX8kp06DN6ddMJrFCnb6JC6RlgnSwPDRczajWa1h_SjCdtrAa4GNhAjiWpHU
    CQCV78O8lFo3-J0fIwlQnEhp0Bp7KkTYalTBqvT5YXIGdR_mP7v7w>
X-ME-Received: <xmr:ObzcaeyPg-KdTU-BEwePrT4UKvSoteptbOvZmv9q4Ij35aT5MRl7RvD216UromNsgF5OnYWiI6uKweFPKXPVp5pFYyLVryKk2ByXhoV29zU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ObzcaYOYvCIxy0d2YWeCeulWjdHg547qmQ1-Dn9ONGSD9-Ho_Es3Og>
    <xmx:ObzcaX4f3Vf3l0l4UGZuu_WJyD9d4V4C4wRT9wPrKqsIkK44Ib6Cbg>
    <xmx:ObzcaROIMf1uZCBmoSELgCQEGlPRKlnpbCa3y5mijHGd_NCJ60zSbA>
    <xmx:Obzcadm0cBVcAig-yHJ2ICgcrL4VaxrTgsY1FcFZlibIThsAfhPe_w>
    <xmx:ObzcaaeLe3Z9njsw69LfKBwnybWGsFdLb7j5ADq2VHk2-9X7ygaaaqw9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b0bd023 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:28 +0200
Subject: [PATCH 07/12] t: prepare `test_when_finished ()`/`test_atexit()`
 for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-7-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
index f8bc77619b..0eac676109 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1516,7 +1516,7 @@ test_when_finished () {
 	test "${BASH_SUBSHELL-0}" = 0 ||
 	BUG "test_when_finished does nothing in a subshell"
 	test_cleanup="{ $*
-		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
+		} || eval_ret=\$?; $test_cleanup"
 }
 
 # This function can be used to schedule some commands to be run
@@ -1544,7 +1544,7 @@ test_atexit () {
 	test "${BASH_SUBSHELL-0}" = 0 ||
 	BUG "test_atexit does nothing in a subshell"
 	test_atexit_cleanup="{ $*
-		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
+		} || eval_ret=\$?; $test_atexit_cleanup"
 }
 
 # Deprecated wrapper for "git init", use "git init" directly instead

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

