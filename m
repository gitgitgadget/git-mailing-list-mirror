Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012623BAD9D
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423090; cv=none; b=OaK8s1/sV1pJA1iDGuBO/JbMqPUdmXAznbTro7z9vpLQtNWyKLKlyHGxYJyNs/+zX3Ch5BP9YjTY5C4d8MUpPG8a/IG9tXHdDMoHTR8rLtMApdmuvfz1ZubjFKYD2XwyOYEi1gajigKjwl4N5YD9ehxINiJGe7jl2zqlhj/R9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423090; c=relaxed/simple;
	bh=eLr5UW0gX3C9Z2uZ6dYS1I//vFk4Kr8GpJncaEvkm+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIpQhBv6clcT2Lm8pMPTZMo6a+FX9GTJZkNH+VicYG2l7y3SZPqQx7kcFoc2lwvNClcpi6vTwRsG7prIf1WXF2uIIM07SDpgQuG7dgjxV1rsevVq6psQXtPw0a33A060UU9WPfP4mGZRdBMebz6F1R2FG1rI+xpJ1CzsvZWuftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=06ybIROS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BKA+hXzh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="06ybIROS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BKA+hXzh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EF187EC0143;
	Fri, 17 Apr 2026 06:51:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 06:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423086;
	 x=1776509486; bh=9zkuz8c6r4lzMh63DBjI2y2k++4EFB1LDLqGzRN1y/Y=; b=
	06ybIROSt3kCkGUXAMGul2Dzlq56KHWOjz0Mcik22COOyjNVXGprFxEAmtwdFc0a
	e7A3XwIrxURaLmVt7l+PNrt6z7dJr80KAeQvzdrsLij6cbyi1PI+z6DtRoMOgxIn
	o9w8IohyShYIA8lBpmQyDQiNeD0ZB+P6fSMBVmVLfqLKN3l3yT+7+Fl9qrAcyBzp
	1P/BrXt3OIdZW6ho0b1x1haMtmRTN7NQH6dsaI+3AvTbOr5yP2cfMg0YXktdTH12
	8wv8dN/HFUWWSIkFfvHCo6P2Xc8AE7cIk0cwXbPGrYtwlth4EzWrvbJVQl/txaFO
	Od5MIpPmSpEtMMQol0j8jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423086; x=
	1776509486; bh=9zkuz8c6r4lzMh63DBjI2y2k++4EFB1LDLqGzRN1y/Y=; b=B
	KA+hXzhEdqHkJBhcEUAvJvtHkh7FNuaMTwgIZwv/yIbQHmXqQyDS+oWsHR8rtbCf
	fhR91in43uVQmKyYBO5nmRPH+D6SCS8LCXVMqB6ccFJkj+iToO+NSE1+clVlPLce
	20nWiACcRe9w4q2osa3M947Hd323KdiJqa8SbAqwhQcPmIGfj1WavuZerLzZJMoR
	3elxLEL8jKapsRgpNeuFEcRXqTAs2SFJiNlgbM8BY/A6FcfZCmQ7pr4ms6Iv5z5n
	KXooeGdbYhrNSDcEOkadNIMD540zySifDrHvh+IPz2y3GQLIPKSIygm2TJeIuBbt
	xVjtK+3zwmxwXiycK5pBg==
X-ME-Sender: <xms:rhDiadMGMmYcO3bwIk-4DmpKLBfeedLOFLlchrlAtVPZXK4cmMxMyg>
    <xme:rhDiaW86IR3Ni-5Ok0G7ntTSOzoay-4dzZ4uEbiLtw57n6ScL_I4k_X_SVdZ9SAwJ
    kWVf3Dpmb0mhn2ASq-ny9QHpsUealXU0rjhicEIpR2bzWvapTdX-A>
X-ME-Received: <xmr:rhDiaRSp48_72nShEyb7YPQBjY4BchbD0uf0563i5KqWAUY8kKprlEl8E4XS_vswUU4f61ocj4SDex0FilFXff0N1_Qph3FTLQXkiNcjOVaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:rhDiaYkDZx1B6B4Kudq705FARcqsQS44LfBuNJ7AapR9K0d10411XQ>
    <xmx:rhDiaRTNls-aXOtUuxFowlcHJzb31ME0qlHG_4VIkayEB_1eFNdxEA>
    <xmx:rhDiaWOXe5Qu0fUPU_zdNQ0dm4eh8rTkNRT_ocvY728f0JjbMi6HWw>
    <xmx:rhDiaaV60TMJTtX8_H_Bck5T2vv7_mIInSlJ_8uwD_0Pm4x883oc9Q>
    <xmx:rhDiadMfAcd_LMpn_zeJRiPnKtl-ZKRG7zQJrDsZ6PU9jrpl7PE5hi0C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4af2fe99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:57 +0200
Subject: [PATCH v4 11/12] t9902: fix use of `read` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-11-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

In t9902 we're using the `read` builtin to read some values into a
variable. This is done by using `-d ""`, which cause us to read until
the end of the heredoc. As the read is terminated by EOF, the command
will end up returning a non-zero error code. This hasn't been an issue
until now as we didn't run with `set -e`, but that'll change in a
subsequent commit.

Prepare for this change by not using read at all, as we can simply store
the multi-line value directly.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9902-completion.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..28f61f08fb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -590,12 +590,10 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
 
-read -r -d "" refs <<-\EOF
-main
+refs='main
 maint
 next
-seen
-EOF
+seen'
 
 test_expect_success '__gitcomp_nl - trailing space' '
 	test_gitcomp_nl "m" "$refs" <<-EOF

-- 
2.54.0.rc2.529.gd9106f7525.dirty

