Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAA394493
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252190; cv=none; b=ZlZ8UyFwunnT5zRSq+lG6TeDI7EE8cLhMxoqMTZ2WaXJYtK1x64VmEnpTZHYnxAuF2Bl6/ZMyMgT4/9GnLjsHMi5auxrlEuV1OsQ82R67V8621aRGVSM8GaL/A7YG86t0HfAXdMEvaLhjFCR4enr+2UUYqrm1Mvi9OpkDS0hHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252190; c=relaxed/simple;
	bh=LkHqxe7aES2KjfjjCVZwhuiYAIqoT33smkQlQhuDJxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwiLlfeV4DhipVAr/HdDFkk6sz0XTsllpu/flAG5IUCGVn4NPFo5LrTlp/wvR78zSx0wx7MNE1O8XYz2QH+7Rc0lgq+b96HJ5hLJiLxIyHk7j/QCR31xBMD0QXZwqwZh6rc3Id5n1J4poYkvOnxszpehGYFa7zznTfZBNdSUt+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Fna6pkAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X6VKoEvw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Fna6pkAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6VKoEvw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 942CC7A003B;
	Thu, 20 Aug 2026 14:56:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 14:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787252187;
	 x=1787338587; bh=qa4gwkS1OH3QC54KJX3suxiuy5B1Naa381LPrP85Tgk=; b=
	Fna6pkAHG09T+I0N+WjQsjLBUAlaw3Xvh8TpC23yvTjwWSONuiPLN8sHqaX78Okx
	iEIZcgfY0xknl024OIgBPrsB/hs4Ddrv5gLC4Tp2KY4DWEYkNdyxeINdbZDcwey6
	xaVJGFb8CtjRrRycLR/P9lEx3yZIPegMdJ41cZODrp9YngQ3RFlqoiP5Xo0HFTLl
	oaaNzPY30lMtf+lXZB8aKcvXUn+RM7l+2668iEKF+QiNTY9jBc1ciDymzEG1Q6ZF
	0IGGtfgT7CfFADpZjroeRZNUNyPD6kmdxsKG8gjiVUTmUEPemySunQ7mpRVfl6cW
	Rd8fsFwny52yriZtqPCLPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787252187; x=
	1787338587; bh=qa4gwkS1OH3QC54KJX3suxiuy5B1Naa381LPrP85Tgk=; b=X
	6VKoEvw6jGd7k4ujfGR9StylGGJNR0MqDNykKiXsafmn2p4ZLaqZLLJWosXKgaJl
	896I6aX0QD2r+PdJqRicAT8mcVicxlqpvyyhN1zOuvzVtyc8HYqq952HmQNthnUi
	NKEAbH3SfuYSLfSkL37J8L9+Z2wzQ3Ib8QR8FAU5U4FMmctMP6oEIJQQB7iRdlvj
	/sa1arW9b17cTS48LL/734DdzRPyplP/ycdZPMWyOm5NGKuYF6dzdmBvr105wp5g
	qa9igQnkPbOFMRA2CxelAqBwoPkPSuGW3HfzvrGn3Si2xQijvlJFtsHYSUPGN1M0
	6QX9OsqRDALO+/WQ8KTEg==
X-ME-Sender: <xms:202HatdPWOY-fQT3gZVuoaC_fzjWpR8Qngc52gtqaXLMFfvxQU2P1yw>
    <xme:202HaiogWynaf-hubVAzK3_opxqxDrwlNmsE5uskaXEZCTEfd2zCBVUsglV3MA8BV
    s-MpFnTc8eoUR-AsUoCdR8YY-Z2ZCf6HvFDNeyPRru1uu3pUrZfdNg>
X-ME-Received: <xmr:202Haj526MHb04K2hl6wUVzUIDvc7qa5E2gPva8bhIpKGrFCjL9Q2DGYoMBaF2ZkEcZpP3YFiXFzO8zZtPP8vVn7HebMxabGKklkPUVNr2SG5oj5qE6wuRU>
X-ME-Proxy-Cause: dmFkZTERr8cIfkRsr96S1UyQ7fC7gyn3GxKGClH1sKbV0gTCC73LSxGS52pK+IKxFsCZeh
    r32lyaZRpSDSakipetnF8TYoOX1kSVFPU5Jy1ZnWk0tgVzGaG7cQ4oyAxtOIl4/SaVW9oR
    DtylNyLUEfPTPiNe3ebWX0FszgDtEBITDowCYzf47hq4CUbbzBLkMKRXSBjICSDqhXl2hR
    9l7NglNA+9pnVdqESXa8Hgfod0OwxScYk2J3ssbp6aO6/FPNuOBrIaBXQwGKUzlCcuQ2F1
    t6G6+RZdGQqWl7wWxRgM8BjJSwFLtDWamI7LsV8EwWGb3V03Z1WPV9Cfq74DArwHx7FWtT
    YZHeJh81zBJRKo4Fvv/vF4fqRMcuZXpIMDsL2MKNGudI0Azi5sQr2PpzYjWm2S8mrA2FvQ
    ZcC8MUkvbWoHgRSvUafeIk4pM+BFNb0WEzjBTcfY9JsbGlYuzA05+2UTrpfBa5/YTzv0Di
    ioZnGFMC7Koq+dTuZOfhAfh2lr3Bw6k9dnV3g8OTbQf484+MYQ7u9APGt4jbPBy0/54ebN
    TrJKR4vGCIUnFQF8Jr8yfrRIqZuy+MzyeUzsOALtLNPhXoRLzjj6py2oSb+caJnk2VmGRw
    rhxnqIfOCpA/j2rkzrfHkGWrdL7nDITVxCyeCgL0L8QNnL2aOj/YqwRJu8jA
X-ME-Proxy: <xmx:202HagqQKBgyRiJdvgyMtYkuutlvvW-pUymUXVpfp1j4MTKOgNdw3g>
    <xmx:202HatjLR5ovD0wp6_VRIrIFrjaORhij749bujqnKgLNPcDVmJDtgg>
    <xmx:202HaiJcZ3cDgBRPfPx7nUz2r2GYi2NW9FeoYWB91hdImZPK3L-piw>
    <xmx:202HalDQ84zk9s4OKNKr9wzJnnF-bVW1fWVb80nO7SQaTD1s0LZ-SQ>
    <xmx:202Haizri4QJbhri4DXUpFbprfRlBPG15ZyxjAcULfg60eXxIXOoH2ls>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 14:56:26 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 2/4] doc: git: link to the gitdatamodel(7) tutorial
Date: Thu, 20 Aug 2026 20:55:22 +0200
Message-ID: <git_to_datam.bec@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <CV_doc_datamodel_advertize.bea@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The previous commit added the first mention of gitdatamodel(1) on
another page, namely in git(1). But there are also other places where
a mention is relevant.

Let’s mention it:

• under Description, since it as useful as the other tutorials already
  mentioned there for those who are interested;
• under Terminology, since it complements gitglossary(7) as a
  pedagogical rather than reference source for the core terms;[1] and
• under See Also, since the other tutorials (plus the user manual) are
  mentioned there.

We don’t need to mention it under Further Documentation since we now
mention it under Description.

† 1: See dee80940 (doc: add an explanation of Git's data model,
     2025-11-12):

          `gitglossary`. This makes a good effort, but it's an
          alphabetically ordered dictionary and a dictionary is not a
          good way to learn concepts. You have to jump around too much
          and it's not possible to present the concepts in the order
          that they should be explained.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I have used double spacing for sentences since that seemed to what was
    already in use.

 Documentation/git.adoc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d2..6f0075f9188 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -25,7 +25,8 @@ and full access to internals.
 See linkgit:gittutorial[7] to get started, then see
 linkgit:giteveryday[7] for a useful minimum set of
 commands.  The link:user-manual.html[Git User's Manual] has a more
-in-depth introduction.
+in-depth introduction.  See linkgit:gitdatamodel[7] if you want to
+learn about the data model and important terminology.
 
 After you mastered the basic concepts, you can come back to this
 page to learn what commands Git offers.  You can learn more about
@@ -469,7 +470,9 @@ Higher level SCMs may provide and manage additional information in the
 
 Terminology
 -----------
-Please see linkgit:gitglossary[7].
+Please see linkgit:gitglossary[7].  See linkgit:gitdatamodel[7] for a
+discussion of the core data model, which includes important terminology
+used throughout the documentation.
 
 
 Environment Variables
@@ -1199,8 +1202,9 @@ SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
 linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
-linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
+linkgit:gitglossary[7], linkgit:gitdatamodel[7],
+linkgit:gitcore-tutorial[7], linkgit:gitcli[7],
+link:user-manual.html[The Git User's Manual],
 linkgit:gitworkflows[7]
 
 GIT
-- 
2.55.0.13.g85d2d65e389

