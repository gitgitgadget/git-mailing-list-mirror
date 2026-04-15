Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285538CFF7
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258418; cv=none; b=pm31BGpUQ7AwRgFeHapqNXFqvgsNYNCxpxaimcTOBL9LpCTZR9zledpk+bdxOsDbcK9RHVF+1OLoGjE2O9Lavpb/N027Kyr5CNcBh3W74Ne1dkqhuiMvJ0fj3LhbDp4x8sYjgWu0BYGm1WRRHOjVx8cf1QGAo3K6+X0JxBuZFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258418; c=relaxed/simple;
	bh=9bm5OzCbCThHItfjsh9Ju8Q1xEp1Fieu9zrbFfhYiD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vciz8YxLZwiO/f1RlBFTM/wuYg4V69ZzfU9V+OXcb9z/dlDlJYIaqmcu8O8gUQRgBj8d7I68Xx5X86aNwk3VHRKSOvVI5uD8LPhpxNMbuZSaNYFjlpAKxuXg7DCJhs8I30utIufsWT/4D6+vKnaV5A0FHExerL8PgWKnkPB3W8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d1Dpln08; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rdQBLlMM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d1Dpln08";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rdQBLlMM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F29E1400037;
	Wed, 15 Apr 2026 09:06:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 09:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258416;
	 x=1776344816; bh=hHMKujJ3Ed2bVzrTNKFS3GFMelLY+M0Pp/ZgLkCppNY=; b=
	d1Dpln08X4RiDqQGydghsvOttpoJANGm8WDcKQonZoEm6nRU2QEK8mE4ueO+xTlC
	hRUnumR5j4TMlciu39mz+pkibcIhFT3JBLKH79U1Yv8TSZatKmubxTfD3V4SVx9/
	9H+klgkUVzyZ4wubSL285km79Ejrc+JT5ITMRLAFaMUzOUfEcdZJVWT33b6ECVGn
	iPx/qWBnTM2E5M+Ipf/3XWc37/fnpCHaqpnV/D3Ubhu6hM6GfoweJnyjcvuKTiHs
	xJ3Mov3Ee0ndzINWMQvo+s+FKfYJKNaR3njPkNHI9cuLxbMQ31EqDjhRHeRrfCEF
	7EVRV3qOrTV+H8nQI8gAeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258416; x=
	1776344816; bh=hHMKujJ3Ed2bVzrTNKFS3GFMelLY+M0Pp/ZgLkCppNY=; b=r
	dQBLlMMNe/Hv4wa3SUqqFYmnnhLkjzB6jNocJLiXeCjyo+QSX8JHjETApGPOzD9F
	iACcQWOdGZJW3L/R2QqGIx2GQPz98W8UkXwbtpGehHLQCWL9Pj2Q4EhNajISTE/o
	PyuLBn1HgaK/Z7AoV8CqmZ1wyFOo8c4UO4TyaETIzGgnKJbZDQDqZEAVDrJcKaQC
	5d+yqwsUzcV2OjUzFLCtcIojXTqb6yy3xLYwU321G4fvtMNW+k9NQoFHjo1f5hgq
	ngGnRXDF9UTgun4jP6tAMuNaYAFGjbjTPyCUQzn18tEmjXlCyO34tNvvikZmOYip
	KZCCmdwsJ+9KZYpIbwgiA==
X-ME-Sender: <xms:cI3faagd_zeEiMIbR3ddE7CwVM8pjLVVDYpLv8RQUOtPZDTkYEvTLg>
    <xme:cI3faSeI9sSHMdSqJsfEvvei5MWU14EyvToOyqd79A56W8VyVLQFtBi-yRpt_Ai-x
    N0y4pGuN0GLHrCFnjPBm8DGURtlDWWXJ4QMjCPySze3QIGTcrnIpw>
X-ME-Received: <xmr:cI3fafcKveWfezyaYux5Z6bUg_8TKFngzUvHa7uRVm9ME1YDxkr9KOOlTxqcmOrJzVFuQTnFTULeqOyQeNBG41lHGrGCXI88nGzF_9sDpN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cI3fac8Y1t-Uejkn-UZ1ngsyUwRTMGn2Vla-S0AbR0PlMYMYhmOZUA>
    <xmx:cI3fabkFqHMvRrH2uzAO3wTExg7Cjc2NWayWw5kyn3AeV5EynpS9Lw>
    <xmx:cI3fae8mzPLPPTLcRzjSI63HHUymX8MJEp7UzABFLoml2m1ljCtgug>
    <xmx:cI3faZlXDmAbXPCwysoSc6-MsmY9ZY2oQF6rl0cux0qQsORgeaIaIg>
    <xmx:cI3fadMVSLjE9KyqplsmGG0-dzHKLbeEf4YHvQZxS_ItbiHpdBPULKhZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:06:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82b4f3f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:06:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:40 +0200
Subject: [PATCH v2 07/12] t: prepare `test_when_finished
 ()`/`test_atexit()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-7-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
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

