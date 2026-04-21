Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAE382F04
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756879; cv=none; b=SWavuwvAn+ocRuLubrJaCxU0NISnBlg1p0W/nv7ha5FwINY45go90hB0MA0w/nVnvpmFZxFb4a5O56Ugq7O4Gds+uHXyXeoQ5/msZ248M2/XXYcxuct4vJ3TU0nNDt3zLRvzrZdu3bYwqtkQ2Z+hB3H8Gm54oJ4oBg0YE7PVjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756879; c=relaxed/simple;
	bh=SKyPBiJxpI7BapOy+U/LeomgU/4IzM/DajIFjVo1f/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haqH5f6wyk1xFGoZawS5KAXahYQyd5PPoFzoeCGt4uhIFB3JwbFQUa0oGu4KRHynNXdS0uN+mUN2pp5YG2jRRdtUrP4pYmTZDz8jv/OUFxcNdzz7ec3uMjppfRJgpsQRTK7TOitVsse5n53QTf1aAwWvkbJPtzkf+pScs3vuc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tFyYGyjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIgPaSER; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tFyYGyjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIgPaSER"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A3AA14000E4;
	Tue, 21 Apr 2026 03:34:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Apr 2026 03:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756877;
	 x=1776843277; bh=CynvkNj4ESr7M0VM/5ePwbZ+WoM5qb5msCpcWVB5euI=; b=
	tFyYGyjIDNixIicjHjdOu0X4eAsVyOEbyNr7rgfUYMSCRKdx8c3wStD0x/ZO64ct
	5d42MfmgNOrBIRg/o9xGCZToWYzWFuGiwaDid1XE8kCUW7cI0tLgG6L35puAQJ7w
	7Q7FwZv60NufVDts7gBprSQyiXlhIccmLiz3vsWxPr0YqZpByuN4aG8CwHqGU7q7
	ShE2k5Mr4v0kJqbn0tXwDD1zFJfNV979MR5UsueB3yG6Z7ky6+MoI6Bds5oexlL5
	WY18UbIbOMCWhcLcZLcc7XIgPfOYarU8nAiZSsjI/dEffpJz65QU1zdqqVHwZAJX
	aWr5rpaWJIWBC5BSyOZzGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756877; x=
	1776843277; bh=CynvkNj4ESr7M0VM/5ePwbZ+WoM5qb5msCpcWVB5euI=; b=E
	IgPaSEReEMsR6N0kJBWI9b72eR3fk2TJeBcBKyQGDZ8oCXyX/f83q416WyYgcEHR
	0UG8cvauQmS0gKDFbJWlr82dRiAVQulTyw8xqYarexFeyXlAWy0a+IJGQNEtnQWE
	9bAf0UeWqcB41QCxqP3btYG2CtWkaW+HgXgIwoClIxRO7emUgxXiCbCtHD/xyEht
	6AymfyMCWwn8ortPuQeFkTKfvxH8C/t7xVbCgcRfJjsSugWybq1CkQiwDH/9L/I0
	34fVc3qVS3L3T6L5Ag1e1iTXauQqcrg6F5oHQJQL6/ia3DskmhJ6Q8UHU/U33QqG
	JChFrHtiKaC1KU+pzVjiQ==
X-ME-Sender: <xms:jSjnaQzp9adlOO9CFR-wZhcsq9VOcPjNjqC4va58442bHU7aiNbeDg>
    <xme:jSjnabTCUxUN6gSf7jcy8AU9P0fIUgfXdLnKAiKmhKq3N4n-rG7MXV2wYjJoaC0jR
    2oUznvrVI6ZDFv2OyrdAM0LioxQ9Mn1cytrb43maGJiJOS5Nn7a>
X-ME-Received: <xmr:jSjnaXWscVl6breFBJkFlEEB9D67FdCf2o9dtYmqDSoX6lIlFuTt0FWB4CpsVEnjh0za71GDByvwJzNl-n1XYgOIAY2fX2jzyHCTVJOuZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:jSjnadaZU4EisSVMouzeyykwG182gcWE-8zQnGG30vWoqY9kdt1c0w>
    <xmx:jSjnad35Vz8i2SCCDX5DK3hvBZO3EjNGECnY9D5O8Wi3r1qfHn81fw>
    <xmx:jSjnafg-RE-6FbEizjuYCrJhdmYLta_rnWLacrbuS-AFzrtSvVKTzQ>
    <xmx:jSjnaRazLLUcAYpQPC8LeNfhpX0s_pE-GIOwaCuSk3g-iHnje1wr9A>
    <xmx:jSjnaZSZhxYYxQclMWszieFyj6oEFNDySO7NtlBJs55w-nu9MG-hgc0j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 970556eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:20 +0200
Subject: [PATCH v6 07/12] t: prepare `test_when_finished
 ()`/`test_atexit()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-7-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

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
2.54.0.545.g6539524ca2.dirty

