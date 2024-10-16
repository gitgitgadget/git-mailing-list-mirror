Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE511B2193
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066377; cv=none; b=K8exBVLMoyHTinibkAsJHLJKmV1fQB8lukqUB27pckgkYP/LBzGjflTqU0XpAnk4uVG7uxargQ2IHlxpX7WiU/RFzx/tXfESkvNPpOMyf4Xp55c2XGVLsg/XeV1oOQgNCl7We2EQOdgQfMhroCfvX5L1LmH0NFxaDqOOYCi8oAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066377; c=relaxed/simple;
	bh=hLfCNLvMOBb89LEU+TtRPa8R3ybKDgxyUzmGaWU4zOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US6ALidVHchyineAkUuqpWvy8IBv/Hf+CKYbH9fVZs3NPgAzNT2GlP4WMlvRFTZLTeD4q7WS3GabOZ4uz/gKoHNKKVfCtwVC+k147LafUAPIxw8vWf8fFzJ6qGAY9Sg2jlOqaHHmEmeb1OzeKcOqmF1u1zBi0yRN+XYXFfcbXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N3Bv2Zx3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VahBhSEf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N3Bv2Zx3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VahBhSEf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EBFAF1140136;
	Wed, 16 Oct 2024 04:12:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 16 Oct 2024 04:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066374; x=1729152774; bh=hjj7S20kZJ
	rEZVr3DWHwGsMz2ZsAl66LRT0d7/enBGI=; b=N3Bv2Zx3vIqzu9oq2gKrZQQS/r
	t6wRGr5Fv1UvJ7uutR0o708M0fFcldYqyW7m+gbtdoSB986Gcc41p8w8mXMy/JVr
	7zfH/fdgAr9G26Cawvv1/K6O0KR8IsKt4dRPE/cmOwMi2zwWFiCZ4V2BoOzJrofm
	QXzz+CNH9jXOXsw9h6ffkzo6zwAHRZSigsd4yzg2/YyROBRcJ6nkzRq81J4CY43y
	DTTfpm5uY/BUh+6omNCKqg5Vai+KiwtXqTZypyJ0BRf79hpWel7UpifNAy64TNgN
	gkMEeIwj5vEI7mZcyo8t5PYqIYMQSpvXMburRWgINZGvGdGY1kqRpUnYfv/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066374; x=1729152774; bh=hjj7S20kZJrEZVr3DWHwGsMz2ZsA
	l66LRT0d7/enBGI=; b=VahBhSEfD8so7QenSpQCkc2Qc4klne2iGeooKktRKO7U
	iRww178Vc2hr4qy0tKFZoNUNGUuvIYlegFAPtkV2qllrnqDAq0BtfMHCJufRMRjJ
	AubroSWd3FXBwN6r6uh7DPgT+pheR8tBgjkQ3A+M7izYpGnpwWIN6SziBud3zjnZ
	nnpo0GqcHuoHCk6ah2+ycQNrcgEDi3vWjd+3wIs/lXUXyb0CUT1R1qovZ7XGio5A
	XkybSTVpiTgxstG7ARMgwvIfxA9ohXH9dDolmmVVWrwmmeRmoPsdi+DAUmBoVBL9
	0MjZSC6Z7XjJ52IApDmor1ASsm8IVi2YKRiJhm2vxg==
X-ME-Sender: <xms:hnUPZz4PrpNqno7HvXrXvtY6fYglmVzBx3VYXlBItOZM7TPvEyq1bQ>
    <xme:hnUPZ45N7FsoIFkCcvQq9bjzqoJJHFJDitovZH9ma3CBxJLCQd3f3tk7g_ZxaC0P_
    GVHeU93afqFvljTPg>
X-ME-Received: <xmr:hnUPZ6fxkgvGVCCO6-BPAuBqI3e3juxIUvrXhsP0xD9HXlf5A8V1vDyAM6Qqb6nTix2IrX3FdDLVirLMNEoosLwZLKW4h1YqCPK4lt3cPp43dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:hnUPZ0JahM_xmoiDTN0q5kuajZl8va1nLhkaVLb7g7grNgmE5g7oEA>
    <xmx:hnUPZ3J-jfHBb10Fp2NYT6qX4fd1iJhc-4sUc2VqOg-pbW8U5qPjeQ>
    <xmx:hnUPZ9ze1-avMf6c4w59kQDyKYXZQ_IJA7KjJIudDreLSt5ENOkclg>
    <xmx:hnUPZzIdken9nxu2VI-X9nfV9Lxf6N0llJOaaeiQvf20Xlnsl2skxw>
    <xmx:hnUPZ_3DspS3c08woXRrg4tqlTz6rFCG_k7Ag30800DoO__VN_R4hOzI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:12:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59b80e27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:11:35 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:12:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 01/10] t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
Message-ID: <a514f5d14a7263750f1fa4bcc04e3daf2901c3eb.1729060405.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729060405.git.ps@pks.im>

When assembling our LSAN_OPTIONS that configure the leak sanitizer we
end up prepending the string with various different colon-separated
options via calls to `prepend_var`. One of the settings we add is the
path where the sanitizer should store logs, which can be an arbitrary
filesystem path.

Naturally, filesystem paths may contain whitespace characters. And while
it does seem as if we were quoting the value, we use escaped quotes and
consequently split up the value if it does contain spaces. This leads to
the following error in t0000 when having a value with whitespaces:

    .../t/test-lib.sh: eval: line 64: unexpected EOF while looking for matching `"'
    ++ return 1
    error: last command exited with $?=1
    not ok 5 - subtest: 3 passing tests

The error itself is a bit puzzling at first. The basic problem is that
the code sees the leading escaped quote during eval, but because we
truncate everything after the space character it doesn't see the
trailing escaped quote and thus fails to parse the string.

Properly quote the value to fix the issue while using single-quotes to
quote the inner value passed to eval. The issue can be reproduced by
t0000 with such a path that contains spaces.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b1a8ee5c002..241198ba95f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1572,7 +1572,7 @@ then
 
 	prepend_var LSAN_OPTIONS : dedup_token_length=9999
 	prepend_var LSAN_OPTIONS : log_exe_name=1
-	prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
+	prepend_var LSAN_OPTIONS : log_path="'$TEST_RESULTS_SAN_FILE'"
 	export LSAN_OPTIONS
 
 elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
-- 
2.47.0.72.gef8ce8f3d4.dirty

