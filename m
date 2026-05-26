Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A93B6376
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775029; cv=none; b=C4V2/f1kjof2dyCyuCaUeYbv4uUGFi/OQs1LwmE3YhvBxH1fo/aR1NKABYo0dg6iLtImLteHV7gKz0YfgnqAyhfCkO2RNR0TLvYgsCTIioC86tONLJg0s4jhl/KIj6W5quFVPh4o327/VokN+xeIPl8xR/aIuXNDlNJOM8hrYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775029; c=relaxed/simple;
	bh=eTAJMCnAVcJfdfC1ynrLT84OXUARmeXVsMKqhLH+GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=feAAHdLbiY+Ksp+TgGyVQhY4+GrV56ZC3NSU8KBUQry9TgdkE12zc/mXNcMCBrV9OH/CwRONQPD26Dqok/t8vSpAIwX6BCKjNfoMC5VbTgZyXNSNvruFKiKkND6bosTb5a6nuJXoPbyiYkenUeSW88q3A0IoPw13h8/vk4sNUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kgHYCn9C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=izgpuPJ1; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kgHYCn9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="izgpuPJ1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 699EE7A0112;
	Tue, 26 May 2026 01:57:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 01:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775027;
	 x=1779861427; bh=Dm1jozvlI//vLgxGkuvIGU5Na6V015dmUpCbKAecWkY=; b=
	kgHYCn9ChEqv59Sf9R4B0Q/4DP5evLCvfLmoaosN/sdF97NrsV+3SnvE4MS7HaS+
	9CJgbBNXtB8Ia7CS5ZKENhSRAvZBr0bCTI3h1saPrJ+Ht/dRLi+FmziIQSpiVDta
	HYBa6MRti1wsR4PH1UuFMo58Ed7vsQqAofoSpmVrhyVkVqFeKyOiJj5axub1J13w
	RrX3M3spL6mG0y96GtIEcAiKTgvjasjy6dSlwv5smyWBFIkHiDEAXI8B+B0otSll
	5r+klyvFmDpSxVje4nmQJKq41p7yBN9AsZ82GqaKu7mm+QTGlNdNa5r02mwBGuvr
	9v7APnETu6UXtGVRIgGltg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775027; x=
	1779861427; bh=Dm1jozvlI//vLgxGkuvIGU5Na6V015dmUpCbKAecWkY=; b=i
	zgpuPJ1GCPRmnWIu8CBdnnYCLlDAcye3JgYpAUtput5GolWeWV8sM2AjMCcxVXnB
	3qS6PlW6ssE31TZVBkNb03/nuIyXFncYpSnn37ULn4Mcq66yW3un9rRhq4FppUu9
	TZAdxVRu/e/s/+o+3EQkcH1aD70L+B8QLeCRmVk79fbrzGlYH4ESKia8YFQfbi6O
	p1SBYQMPZsECA3asHSpvhAL3jztq/pE8XgrCy1ey/6ByBx2vAJID6Fx2jYtifrDN
	Q7PSfh6d45YiwOClbTclNiFubTNckOD/8HVVVuAIrsSvTsTus7Sx8e9ZCB9HrFiD
	UKcBgNhIQ4qW/jrmMDX5w==
X-ME-Sender: <xms:MzYValyoyP2Y97fP-yuZ2CpJToNdF7Woe_IiCLzHa3omeQ-yaIFRww>
    <xme:MzYVastOVAQme6vBZpmwqqV3drp31_X3ieBygKwLyGKeTByCQ2A8RWOrLhv4GmxIs
    fJx9WnGATe0tKiPd4o_XMVyrBVtgrilV8GJNX3a3W8WdN6BRCtwZBU>
X-ME-Received: <xmr:MzYVasv2UXgkNpx0adhbnXZa0r0s4mx1DdD40xXlVt-mHL8Ods5pO7NjRXGwfmS9-LlECFsFpMecEHZENDR_OXzDHYjDPXNHNn4j7gNL_Q>
X-ME-Proxy-Cause: dmFkZTENDWPlIMehrI0p5s3nwkhC94E3+Vziz2RDPzn8dE1M2zUbfRmFf4UZfcnyV6gcS+
    CxVZxxC3667h+nAhR6pqpNggMXlVeZYl4wzEaI+cHAj5vReVVsTehM35WU8cFIvMy7RAR2
    sq0fQV5df/lYICvHIopy1DHD/0D9dQZ+yGFyfl6DCWWUsVYBztrbDdiCcnBYzMAu7+IeCJ
    IjvSOmbtjdbu+S0zT14pNcqslKmSRNuzmYU57jfQ53GS85OjSTswjgKmMrEguMgZ2qBqI0
    mjGPmHfCy62a9sJdy7nxYZhhmNtd2tZhnvvTcAoLqkPtY+35gVYtxanNVk7O0FGv4PbDIY
    qadwxG7Gcv+7b+F7X7CrCNeWXSNHkkzXF2p8bHZF72SKLMyWPmhTUS7SLw/iZz/yglBenR
    LP6tacGNPKyTCGkh6P+k3u8JcLusVAHIwFqQGng51rKgDb2nCoi6tIcmvoc3GsW7qpHmgo
    g81C2QNCd9IezDYSn29mKeyAl508Fds2voUQVKFrd2EZEz+RQPLNRnsHw1Y51Gg7Vg/dS1
    lZJ0W0+NInp+FZ5y8DFw5HmmIVSoUH6jyRciGmQqAHzE/Cdh1YmzrHisMjcQ7/HQamVldy
    ecOYM5WAOBgnsopm7369nOWJHIlK8pkP0swkfmvum5Y+T2Q8P73e0xauTv9Q
X-ME-Proxy: <xmx:MzYVahP6jlQmLHNPRZx1aPXVMB5teaJi_phvazs6rtdQswp3ZtVSzg>
    <xmx:MzYVaq0Hc-OsbC_mlvASfIBtK4XkmBhiuXNNzMBeCfy7o4LGCA0Rlg>
    <xmx:MzYVatMz7VT16T_c4NW8_O_IuVVQoYMay6RxSoHvFS0xy5nL6qve2A>
    <xmx:MzYVaq2s5XOJTWVTsLFFve3vraP6Xju9CMnXGlWdOc9Z7z9l_YvBeA>
    <xmx:MzYVak3-zYggY3jT1e4eII3MsNac6eohMfwPr0WVttVxWTYDgPPqcHTV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55b9145b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 May 2026 07:56:56 +0200
Subject: [PATCH v2 1/8] t0001: plug test gaps for git-init(1) with
 GIT_OBJECT_DIRECTORY
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-1-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In subsequent commits we'll rework how we set up the repository. This is
a somewhat intricate and thus fragile sequence; there's many things that
can go subtly wrong, and there are lots of interesting interactions that
one can discover.

One such discovered edge case was the interaction between git-init(1)
and the "GIT_OBJECT_DIRECTORY" environment variable. When set, the
behaviour is that the object directory should be created at the path
that the variable points to. This behaviour is documented as such in
its man page:

  If the object storage directory is specified via the
  GIT_OBJECT_DIRECTORY environment variable then the sha1 directories
  are created underneath; otherwise, the default $GIT_DIR/objects
  directory is used.

Curiously enough though we don't seem to have any tests that exercise
this directly, and thus a subsequent commit inadvertently would have
broken this expectation.

Plug this test gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0001-init.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e4d32bb4d2..e89feca544 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -980,4 +980,14 @@ test_expect_success 're-init reads matching includeIf.onbranch' '
 	test_cmp expect err
 '
 
+test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
+	test_when_finished "rm -rf init-objdir custom-odb" &&
+	mkdir custom-odb &&
+	env GIT_OBJECT_DIRECTORY="$(pwd)/custom-odb" \
+		git init init-objdir &&
+	test_path_is_missing init-objdir/.git/objects/pack &&
+	test_path_is_dir custom-odb/pack &&
+	test_path_is_dir custom-odb/info
+'
+
 test_done

-- 
2.54.0.926.g75ba10bac6.dirty

