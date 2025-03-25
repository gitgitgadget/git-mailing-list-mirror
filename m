Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4D269D1B
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941458; cv=none; b=aWx8dp18e2oL+/MJYsVuIiGqBSIfK1fk2Y9iP+hDvOYax764e5jZIvUptz/QZoJECcYnROXBkuzPUr9bmXUufL0Thi5TZgMaJ6ScOJX0jNCY2xESgU/Ey7cufklzdRkBJU7+irYSLzNSknNwUdmkdaC1gJFqVl/CGg/OC97LJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941458; c=relaxed/simple;
	bh=qXYO7xYh3aCLT9d8C5n6nzCnsQmy6oRnWTqvnWU15q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxnUzxN6T+68qCk1kO/VqPSPwmGAkvDs/9IgbeEnGGh7oTgc2dL2eyneoyNell9PeZy3BNLADiLaUOP4EpaG+gAWO1dC8YvN8fGBsHKi+1JC0qFUt2tWzayq8DL0lvEXlEnuRxhHK14+q0ruvCi4cPjbXCIylJS9lI0qanVpLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=SJBVcnOK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5zt8zgE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="SJBVcnOK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5zt8zgE"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CB6E51383A12;
	Tue, 25 Mar 2025 18:24:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 25 Mar 2025 18:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742941455; x=
	1743027855; bh=0TmNpZ2twEK6A9KVkFPgJtAErZDP8gSK33pHA9wblS8=; b=S
	JBVcnOKk9JCRxSvkGT3oA3jvvEmO2/KcvUGSfEtX7Hcck0ZTgoeihTvp+ryAmHPd
	0vJr7235VJXu69inpjzkcsDQPVWYVO7R3CgnXCe33LBsCJxb7/qrEnbNeD69nbhG
	2x7ZydZjhORjLQLsKBtfqNSAXSa6hDTjwdFpgyGlwq6LPUa+vD1f35s7H3y+lNUW
	Pd5mDNQbUPa9NzoFJCt578cGZoqv7KJobOKh/8sQ3z4QFPIulkyJLxEz1ARIPYAe
	DQRWqRXgnZqWDWXOClS9cHbDt0QTBJrOX6oL9DEQzmRbaKawCHpkH4wP1xjFF3zB
	BiHvM/kwm0JuSTc8Ercxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1742941455; x=1743027855; bh=0
	TmNpZ2twEK6A9KVkFPgJtAErZDP8gSK33pHA9wblS8=; b=e5zt8zgErOYVbltm6
	pFgMNVlYOhBrfYjbhtcUABj3uemAt+q39Rv6yKVhUncSAv69Gh+r/9um9x1YtHQl
	izyqD8zIbxxtyM8H/beeEMXz3VfiLsjylVQb4jUQzjURXw8FBHTJp+Pp7NDMGejf
	22FXvErLw9ThAbgquXlesQNe4sropfjgHDsVOCCgsOarZkCHisV6SZ4Ham+mBXB5
	h0XvcHQxtzpMAcHdtxhIN06+m+50DBAAbVQnl3D2RN/2slfLcba2YjJFKRM0e9xm
	kSWFCw9RhFwrDlTczogunR0lM35CJsVe03fbtt4nkfsNVKwa/EtFJdFxokhLVfXP
	bjUFQ==
X-ME-Sender: <xms:Dy3jZ1q0YtYfcLq1Nh610Zs9JbiwOYgFsbjy3M4wSoWBs5D3JbnD-w>
    <xme:Dy3jZ3rC_YynL9w6aUsTqdx_keZ0-Fci0_VGfGS8jFnFKLCqA1l_jwW8ZXne4Kr5P
    zDqYi4i7q-Zehasxg>
X-ME-Received: <xmr:Dy3jZyPCnRBKsqlJrIu3PfVMpNXYtQeo4Q28o0FqknwnPx1p6RNOmAmRPopUr466zgZzUcIzR-yJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgr
    mhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeeiue
    dvgefgvdetteekveettdfghedutedtledvgedvffefgfffvefgueejheevueenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhooh
    esuhelvddrvghupdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgrhgv
    vghnfhhoohesuhelvddrvghupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehkrgifrghrihhmihguohhllhdoghhithesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:Dy3jZw6HvmY4aswT-UwPddxr9O3UlJiz0yuZFLt8MTyRWlorCN4Yrg>
    <xmx:Dy3jZ07Zoc3lfTAevpgjtL73ra2lOs06i5fwxgBMuafFy3Ms7wvEmA>
    <xmx:Dy3jZ4g29G-cHBkKIpW-_RM4gm75RE03RuINUKm_LdJDMAUmB6zAng>
    <xmx:Dy3jZ2759rtscI7YJ95hgpF9hDjQ9EbxCffgdzr6kIvCVdULnkXn8Q>
    <xmx:Dy3jZ-Sq2gy7e2Fgkq0yEPDmwWljONSZTf6DbFhRqr0Q21TaEHIOuri1>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 18:24:14 -0400 (EDT)
From: Fernando Ramos <greenfoo@u92.eu>
To: git@vger.kernel.org
Cc: "D . Ben Knoble" <ben.knoble+github@gmail.com>,
	Fernando Ramos <greenfoo@u92.eu>,
	Junio C Hamano <gitster@pobox.com>,
	kawarimidoll <kawarimidoll+git@gmail.com>
Subject: [PATCH 2/2] mergetools: vimdiff: add tests for layout with REMOTE as the target
Date: Tue, 25 Mar 2025 23:23:11 +0100
Message-ID: <20250325222311.400748-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325222311.400748-1-greenfoo@u92.eu>
References: <20250325222311.400748-1-greenfoo@u92.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some tests to make sure that now "REMOTE" can be used as a target
(ie. can be used together with the "@" marker) inside
"mergetool.vimdiff.layout"

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 0e3785d230..78710858e8 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -532,7 +532,7 @@ run_unit_tests () {
 	# Function to make sure that we don't break anything when modifying this
 	# script.
 
-	NUMBER_OF_TEST_CASES=16
+	NUMBER_OF_TEST_CASES=19
 
 	TEST_CASE_01="(LOCAL,BASE,REMOTE)/MERGED"   # default behaviour
 	TEST_CASE_02="@LOCAL,REMOTE"                # when using vimdiff1
@@ -550,6 +550,9 @@ run_unit_tests () {
 	TEST_CASE_14="BASE,REMOTE+BASE,LOCAL"
 	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
 	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
+	TEST_CASE_17="(LOCAL,@BASE,REMOTE)/MERGED"
+	TEST_CASE_18="LOCAL,@REMOTE"
+	TEST_CASE_19="@REMOTE"
 
 	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'tabdo windo diffthis' | tabfirst\""
 	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
@@ -567,6 +570,9 @@ run_unit_tests () {
 	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'tabdo windo diffthis' | tabfirst\""
 	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
 	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_17="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_18="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_19="-c \"set hidden diffopt-=hiddenoff | echo | silent execute 'bufdo diffthis' | 3b | execute 'tabdo windo diffthis' | tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -584,6 +590,9 @@ run_unit_tests () {
 	EXPECTED_TARGET_14="MERGED"
 	EXPECTED_TARGET_15="MERGED"
 	EXPECTED_TARGET_16="MERGED"
+	EXPECTED_TARGET_17="BASE"
+	EXPECTED_TARGET_18="REMOTE"
+	EXPECTED_TARGET_19="REMOTE"
 
 	at_least_one_ko="false"
 
-- 
2.49.0

