Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840018C3E
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264789; cv=none; b=r9jmAFyorcodLXOMYVaxqf85+dZXlMHRjrbA3IJvcck4q4gj5bY1U69CfNBOalhbn725E+VxTdtjqyiIaCFwMmXAd3SAHtJ3Ge3k6vxAMFbJ4F+AT6NacFOSN+D2yNQy+oCq88kk5NjEhYQ+s57A23aGr2WYmV+Mf4wnu6B+InM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264789; c=relaxed/simple;
	bh=wPpaas8UTNsW4f5FIPP4tiW9/5dIB+DyB21I/NWAn2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OlZHtxYnBMvvFsBe//c8JtDoqFYaMgtVMGWIADEOhxRouwrODwKUQO4vbib/aM+GDBw2D/7ZHz/FDeTmf5swiyVxtVq8TbS9pkcJ8pHWX+RgZkEWrQhFw6uP6oZYr0NJae7jOv6ai7Ezzizgljva3/Y41BUhItvDaWEtUoe6EI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GKsCP3e1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VTeZWT2m; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GKsCP3e1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VTeZWT2m"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D251511402D9;
	Mon,  2 Sep 2024 04:13:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Sep 2024 04:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1725264784; x=1725351184; bh=gadIsm6ISawqFKqXGqRbgLAuCIsgyQId
	jeePwJSI+3Q=; b=GKsCP3e1z7fOMa3NQ1IhzDY9jS8JvQb9G4ecXiQ2gP6PAPUZ
	wrZCw8lxJwkf3OpO81NNF+kHU0GH+FWcnVpa/3XCcsJnt3MHYhK3bxgl5XBOcH03
	ICgRLl23X+oHT6hpQ12kYKd8j+UXqD42UR4Be8KJpDAhZMevumWnFi4Wj6g0KANh
	qfITOmMYBStHjyPmPdCSahirzLgyZqfRFe4RcnOqzvDIgYs62fLGIK9xuBkT2eo2
	0BJN25ZUDpr27cUEof7rhrIGGKF6Agd5htBuLiN1xUp45fIaKEhkJWkxgobBdR2z
	SF7I8Bpj8LdcUVrVC+p6iSY3Fiir0qMRkPX3kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1725264784; x=1725351184; bh=gadIsm6ISawqFKqXGqRbgLAuCIsgyQIdjee
	PwJSI+3Q=; b=VTeZWT2mcDcGGwo9FQ+LcqTpguxO8qcN1xbSD9e7RtbPf1poaeC
	spXwnC8saqrlwiPR3PIDTNl7Y58h2H4fgeTzGTAQ5JpLaIsEuJdKjSeKTRtYNYJk
	yt6yaISz+wjnI6fJazxymaJDuZb5FVr5PBzn1Ndr0dbU7SE7iUMGYMFX9DmaFFQA
	2sq9sS8kSo5JRwxwyVqq4EKF5bsHLgfaDg9OIBRQBY+GJ9LIvzHvtBNmRpjWM4GJ
	fkSaOcq6K74uXa4KYdfU/vBM4/49d4bo1Pu3e62WMEFofzpl6IR1Icsc4h91UYcG
	rV63OMxFUaGeIM3bk8NcyhwolIURduUR9TQ==
X-ME-Sender: <xms:kHPVZgmA-xdyHn_mHxOGwxNyUyiTtx4xnYXz9BE--aDlTFYQxgOAqw>
    <xme:kHPVZv21X0nM4PKmgYamBnDdXMhLryJpF3IFc1sYgf-rhNqVkqVXZ7Xv1GE4OyGB-
    AUxf2Lu7ebRGwA0qQ>
X-ME-Received: <xmr:kHPVZuoi3l3EN34Vj9h0033pDG3c5gGyTlS76GosHKoLsgtPjTBH_Z_gLgYkIFoL_VouokHZbgqhvTIpPn2CUK8_PwEDq48UYQjTEWEmfp3styM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiuedvhfetteelgf
    fhhedtvdehlefhtdffhffhgfeljeefvdetfeevledtueeivdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:kHPVZsmFjuv7oB0E0pn3_ZmPcrROs8i9Vq16RMyN-Vp95_aO0XCqSA>
    <xmx:kHPVZu1QcTdhf_koCbsRzEb2vadTpB4dyns-D15fomAwrhQu4Rzu_g>
    <xmx:kHPVZjv_VgtYebFI3AmWOTF4GYa8RavtQqLbm6sCYa-Ton50jGl5cA>
    <xmx:kHPVZqU_W-RbtkACp6D3Nhm7Qb3TRXBwMKrKxlla8b9vZDof2y_fVw>
    <xmx:kHPVZhQ-FR-UCmqm9emV3XK7GHUAxg9pTUHE8Tj_cDfN9nhdweYUYJkE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 04:13:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92730742 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 08:12:57 +0000 (UTC)
Date: Mon, 2 Sep 2024 10:13:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] Documentation/BreakingChanges: announce removal of
 git-pack-redundant(1)
Message-ID: <a6be9f5e9eb1f426b1a17b89e3db1bc7532758b5.1725264748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The git-pack-redundant(1) command is already in the process of being
phased out and dies unless the user passes the `--i-still-use-this` flag
since 4406522b76 (pack-redundant: escalate deprecation warning to an
error, 2023-03-23). We haven't heard any complaints, so let's announce
the removal of this command in Git 3.0 in our breaking changes document.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
index 0532bfcf7f9..2b64665694f 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -115,6 +115,26 @@ info/grafts as outdated, 2014-03-05) and will be removed.
 +
 Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
 
+* The git-pack-redundant(1) command can be used to remove redundant pack files.
+  The subcommand is unusably slow and the reason why nobody reports it as a
+  performance bug is suspected to be the absense of users. We have nominated
+  the command for removal and have started to emit a user-visible warning in
+  c3b58472be (pack-redundant: gauge the usage before proposing its removal,
+  2020-08-25) whenever the command is executed.
++
+So far there was a single complaint about somebody still using the command, but
+that complaint did not cause us to reverse course. On the contrary, we have
+doubled down on the deprecation and starting with 4406522b76 (pack-redundant:
+escalate deprecation warning to an error, 2023-03-23), the command dies unless
+the user passes the `--i-still-use-this` option.
++
+There have not been any subsequent complaints, so this command will finally be
+removed.
++
+Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>,
+    <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>,
+    <20230323204047.GA9290@coredump.intra.peff.net>,
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
-- 
2.46.0.421.g159f2d50e7.dirty

