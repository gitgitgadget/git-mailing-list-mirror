Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A450296BCF
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670070; cv=none; b=iQrwUNTG3GCoio+UCU8k3X4C/395z7E8vGi0nWw/sBZ++704/p97y58TMPyi363b2DGAp0V4+59sOdoDqzZ/o8FdF7rB816TWikTgg633seTzVhOYJw38j5eluBz+M4MlEBtZSJZ6lQ5+QeP+KGOaI//px1I7teqmNr2QBnhH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670070; c=relaxed/simple;
	bh=9bm5OzCbCThHItfjsh9Ju8Q1xEp1Fieu9zrbFfhYiD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1m3h0I3ogIGvgXqHVjNhE4jICMojH9vmLYSwPRZDfM2d6mv1vbPT+L5wramYn6KtOKI5yj6+cG9QLk7MgSiMhSuaynpgh+SH8WKmMBvLb4SBd3XtU8A4Ppi/ZTjd7HkU8N3maiWujxuy+BsXEhDORMSyC3L66VDX6XSECHE7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DND0MqNB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QR2Xdht4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DND0MqNB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QR2Xdht4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6631EEC00C0;
	Mon, 20 Apr 2026 03:27:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 03:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670068;
	 x=1776756468; bh=hHMKujJ3Ed2bVzrTNKFS3GFMelLY+M0Pp/ZgLkCppNY=; b=
	DND0MqNBLbMBdxOnEJFb7qhR5kPxXu1F34lsuknMPuopzcpFk0mSLXTCBnXKu4xy
	/y6h8IBMHPeIgViy78+OLKnWBALx/TbaPwWY2Stpc/AkToNJYxrwyvZN62e+3NIe
	6lKhfTZj7UO9zoNMFaqIvbgjVC/D8q3g3XjWbc2RpJ2ayGR07WalHi6R3lhz3XL2
	v3byNAaXboynk+7OfPQiiDKqf7ZTEB/smBEuE+K0Vxijtp+qurcVFjURbpWjNeD1
	HKorArdbiDoJLa95B5GAS82Udp2vkMKDrOdC0D2VrrrOj3onWPnHj+jjzL4M3Ca5
	GllfPsVsMNNC05MlCEqBkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670068; x=
	1776756468; bh=hHMKujJ3Ed2bVzrTNKFS3GFMelLY+M0Pp/ZgLkCppNY=; b=Q
	R2Xdht4AZzV7j+rAUfULMn+aTxvnVF0GJTSSUFBrCrwgBtaaYCMvTwOD0UB2NkAi
	brQXlKkYnoJVRJ/1O0e3YJzPFal5DC25fDMlsSzw5ndx+xKZEaZM5+aanjo90USY
	So4XyHeejXoy7NKyA4SmMWOMjnpcncxDKZ7kIz5U5Ida8TQPs1jIdVPUF8l9/cBg
	n062BYo13p/pl5GjgfvzrERv/QahvaaGzyar2mPsVjTiJUL9z2MsZ4cj4+jJxez2
	V5sJcQR9L5sq3VCSciqBlh/oAF31KxJnfvwRhWqTAd/jYXcATOhWC4L2MWZRAabS
	axV5fMsvylaoAL59nyGTg==
X-ME-Sender: <xms:dNXlaVpJ2aX74E4NEFMuFbsIHeDlMwLDCevEmXond83bNHmT_5qq4Q>
    <xme:dNXlaerXkeNTbo-FHevs1D3a-N-NLu8GqEX-D-cLefKbv-9Hi62cLekAeMrdxzovv
    TZS5M2N-6LuEQIcCoL7K1BZG_1tA5Ch9-ixrMpyJA1fQmwthaV9ng>
X-ME-Received: <xmr:dNXlaXM4t1LNoX-2omou5NzHltDnxl05VU7d0DiVI9IV-glwo1i183xrgOtbfq0jtVcEavMK2K8t3GM-1DvLF-mrtu-QmugmGwwNKCslwD37>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:dNXlafxo3nGrGTBBR1JYe-1DV2ljaKTreZktVYoGHXyKr6w2PmnN4A>
    <xmx:dNXlaQtRlkvG2Bfvbk-Y3CFHv5oZVwn8aIyLe_5lhVhDWF0TOYAL5A>
    <xmx:dNXlaY6xispCnyVejREl9S8uxHBnXYA9-QKEgmXabCxiZo-AhQGbzg>
    <xmx:dNXlafRAZjPULNQWW-PJjZ49_GzyzKuWP0HqW--nzMGQEPwmav1jJA>
    <xmx:dNXlaR5hq7BJQrg1By3rM_T4nX7wEatuDGs9spKTm7D7uf1TjkpMK1AU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a0ee919 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:26 +0200
Subject: [PATCH v5 07/12] t: prepare `test_when_finished
 ()`/`test_atexit()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-7-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
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

