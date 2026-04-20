Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B962D738A
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670081; cv=none; b=gko7Br2ltx/Ou/B1hF4kPyjNbxzr2U/uyzvFvPVllWYQLFoOhnoR8LqJqV/svGI+Gz2ptOEdhL/2Zem7ai4hnsMrQDdmB409xTrk/UUQhwNsWdJ6g2acCHyVcSGFCedNZFogmA+2ZvLnDWvnubiyLzwc2M64A2Q20ncMagRHskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670081; c=relaxed/simple;
	bh=eLr5UW0gX3C9Z2uZ6dYS1I//vFk4Kr8GpJncaEvkm+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJEbfgZnvnDgAZLm1w0zkkD9m39pR25NFuSlb2oKqSrDxAA+kI111i1Zj1kZ5bW7IaguQsMucvRmqd5pai0Vz3kaASBKbHg+cCZP0OGERdmFCJpWohJaeLM/vQ33nII5yTRzYeZ+Cu+gBLcFZgp4u7Og/cj0TblOMJYB8pPfdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ii8BSCL7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sp4AfSvI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ii8BSCL7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sp4AfSvI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE2AB14000A7;
	Mon, 20 Apr 2026 03:27:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 03:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670079;
	 x=1776756479; bh=9zkuz8c6r4lzMh63DBjI2y2k++4EFB1LDLqGzRN1y/Y=; b=
	ii8BSCL7gwPFqkFNwiasCSvt0e5lIJkwVwXlEnvojk06bL7hAxitNXm4fXeDnPOm
	cicCAi2CiUwhl/gMP+WD6oiFtfrMtW/+OH8Y0wocliAoA3vWSpy6fnFfyF/A4j3M
	IizxIcM1FvKcMcg1CprGsEwSlkX10//10XMi7lVLo46NFdNeBadFYfQqwl9EQASV
	pEKER9Z/fL6DERRCqb4QInHbMuIQojl4dpNBWicLAy+K+nl1H7n9Gonw8xhG6MMJ
	El2Da22y/Kvnz/VAL9MiIoVsyIhPuexwg1Q9bcgBvnpMFQdSTYDi+BS/A7MuEYSN
	sQUm9YduhoExDET3odBK0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670079; x=
	1776756479; bh=9zkuz8c6r4lzMh63DBjI2y2k++4EFB1LDLqGzRN1y/Y=; b=S
	p4AfSvIa8pgAzy2gtbPxXpsgZzB6DFH47GtV9YXoH1/SQFiVt8i4zpOQdVLDU6vF
	p2vYlhY7AsjY54X5NqtcYhL8qfAqUwxZoWoVBLUCB3+4WZRJaq1hHEemRy6MiazC
	AyIR+u6MOHBapSlM7Per2g3c9ukHhDp82YIbeT/Y6JWIrRXBSAjrnxgxwWOxkjS7
	cE3JL1WE34JplOULjvOoIglvr0CQlHcUmTdHooTXQjhIY/hYICz2AfZCok09d45z
	7LQV22VWABuX8yruCcYWEIl05Of8dVazT+1c5yZCFLPLKztgP69kAR7lTDjMqA3d
	r9Fl0cn+oQTSlkyAtueyg==
X-ME-Sender: <xms:f9XlaQ1utWhf0vy-phRuYGEf05bYL3omjhhbZt2soz_6UFDptA8vBg>
    <xme:f9XlaSFKSrOUtDgnDORe0nPingff64aCr1RU_xNISellCdMLj--4G4_vZIxVluvd3
    hXp4beLw4R7_W2AC-CYOge4nqaHSrmmBgNc56I1r3C4EvNyn81B>
X-ME-Received: <xmr:f9Xlad5DkXfmup8paoI-ADKacKFIkeJ6iCNP8lQ6Ktb4BFAgQKAtzhXxJ_9edaNYMoFFTalLtvvWOJey0rtGaXtPWZwgyl1Sdc1eJXjX4-pN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsiigvug
    gvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:f9XlaYtnm1nUiC14RoFAJEBMoJpGw8RtaRnKcIN6YPuX_O7AyNiXAg>
    <xmx:f9Xlae4tl3ElZxoZj1RyV2IzAoOZc1ZVj5GNwdywkANXjh6vgqERZg>
    <xmx:f9XlaTWwoDpyGmQuwQfARALTaGlCJYSu9a0Wuls1tZkfy7W9hlnfLg>
    <xmx:f9XlaQ-4gUMozSlhbHzZqKUw_ag5250-ZqJn2Npv1paflKgjzVCexw>
    <xmx:f9XlaV260mQ1WSEBQ2N-9RZLKEIpblmjiGQFwRJotjVz3YFhXV5e6c7r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2a6127e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:30 +0200
Subject: [PATCH v5 11/12] t9902: fix use of `read` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-11-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
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

