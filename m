Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14B193436
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440794; cv=none; b=EZ1cbV9EnbbYQ27g7Q6Oi/j7F04CzsPmvysWuwFPtOLhLVakNIt+7y7ccvB7tWhg+UExME8EybWgdfkViiH0yNmb846uSVoa9QRPz/WBPTyTEv2TX0JAWoTMhcCwZDXFLPiybtV2ZWQmtTKKycPwctGUnpdfK83kZ4PO6htu2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440794; c=relaxed/simple;
	bh=Iuk7rEniYZnHNOjoyH0jXMNbdQbKVu7dMC/tPBzJkc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EjXIPhLUGZ1kFpUcxSXARDeCxz34FqfbX67eUaNFCvHUXRSJiTSfrKNKjpDMRIk0ELfJU0SIOQgdu2XFChXrYlkYXdA8dYbmFDCuzQpdWfiQWloq6rMlr8m6EoIGFBhre6chMazZ2bCajHgWmJ6TLvv/vUI65PFVznD4TxnEzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Qkbch2Z9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lnp/7y/R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Qkbch2Z9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lnp/7y/R"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED0F111400EB;
	Sun, 20 Oct 2024 12:13:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 20 Oct 2024 12:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1729440790; x=1729527190; bh=TF
	WuL+knptseB+TKLkaN4oEuqvxxeXp38NMnMraNHkg=; b=Qkbch2Z9X1rHvIbvJk
	WFnAxwFZop3d3VicLLXsnSVMnuL4ZSPG9HXS3dYk6oIVc/5vryJuCcxWM4iRGV53
	FWNqgOXN+OSFxzkUmgaNmGkWcWTlCcN4SZeazMrWbhhTBzdoVk0JqN4eNp99trg6
	WkZegbzv43kej4ydcRsk+rTMIljoNj2i8a138sEAxyHjYRGqHMdg8kkXDjnSMMVM
	Kp3uv4djHLg2suczs1w8sG4MwQ2Y7bmjyP35FJ6XEskWEbaBHBb2RKZTAAGTCpyx
	SiBdYaBcibPg/HTb54O24Wbg6Dv7RnHe4ieoqRo4DFlX+zFczAMXA/Mhmb6ESkxq
	TTFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1729440790; x=1729527190; bh=TFWuL+knptseB
	+TKLkaN4oEuqvxxeXp38NMnMraNHkg=; b=Lnp/7y/RNPKSL3gcgu3oMp9LK1R4f
	+3PswTjrisnyf4KhpLRo9lnn1i8qN0nOLTK2gwuXIbIHVG1TbDmMHN2UbOOLGJeO
	ZEnLB5Uie5FO6bjZpNM1IpHilGR9d+BYpytuFcHVOxFVdEIvPSiEyBHzb3JUQxUB
	53Ma5/KjAiU83F6Sr/TRkqpRF8m7uTT0a2X1o1mS6xZoM3NcBYNkqAgVRdQGNjjP
	7AT+2M66nrWQINMlDdN6Ycyx/+7pgualC3364Vm62CNJYVYIIERqW2A05zCNwEMP
	vzDqL36jbuBMX6zcUn8NRjiaG7cBkBWKTg//v6DbkbDW5lrmd2kQBBK1w==
X-ME-Sender: <xms:FiwVZzmwNfJU-fMJlXy30IL3XxV5ajVmil9Y1JCpsES-UClDTpxa2ag>
    <xme:FiwVZ21asYeROIZnJLMS5uV0fLZncVBMXG-im8GOBQK4caAh-c2xXALznembwc2fw
    vBaN1TiKlz-7eNoYw>
X-ME-Received: <xmr:FiwVZ5rGnffuZ9uoTCAs-2wlnDLu_6Kx6PTH5hehP5Q3JfExaJfuxc17KlKImTnulAxS0iK-hpSWdDGh4V_WAmcS4XEGbRgTj0P5mwYrnF1DD1OyI938p7H02w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejff
    dufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:FiwVZ7lXdxVMdzMyzZYL0-4s1qG-UAT5mWuiwXBcEUqNEKDI3Ln0bw>
    <xmx:FiwVZx1UcOXI-7XzMNxWAGA49Fmfv8fD7vy737zxN9wh9gAKGXZijA>
    <xmx:FiwVZ6t6CM7C4Zkifm2YZGp20jTxdJM7AoPfMKoTqGgBLP44J-8UZw>
    <xmx:FiwVZ1VuEypyoBdaqPAH_672MBPA9EExpoRUrM65g_7mTSIUvD1fDw>
    <xmx:FiwVZ_DntD_cX5ngScbtBB3l_F_Rbe6wM4SUXFyPb7ILDkMjfAxuZ2rc>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 12:13:09 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] t1400: fix --no-create-reflog test and description
Date: Sun, 20 Oct 2024 18:12:03 +0200
Message-ID: <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: ab7d4c8d89c075de05bf04f1f9dc195145455964
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This test has had the wrong title since it was created.[1]  Use `always`
like the description says and negate the expected outcome.

The test works since `core.logAllRefUpdates` set to `true` does not
create a reflog for that ref namespace.  So the test is testing the
config variable, not the option.

The test itself is fine and does not hide a bug: `--no-create-reflog` is
not supposed to override `core.logAllRefUpdates`.

† 1: 341fb286212 (refs: add option core.logAllRefUpdates = always,
    2017-01-27)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    From the commit message:
    
      “ The test itself is fine and does not hide a bug:
        `--no-create-reflog` is not supposed to override
    
    A source for that: roundabout through git-branch(1):
    
      “ The negated form --no-create-reflog only overrides an earlier
        --create-reflog, but currently does not negate the setting of
        core.logAllRefUpdates.
    
    I *suppose* that the same applies to update-ref since (I suppose) they
    use the same underlying machinery.
    
    See also git-tag(1) which says the same thing.
    
    update-ref should document the same thing, then.  I have that marked as
    a todo item.  The changes there are a bit too involved to implicate in
    this submission.

 t/t1400-update-ref.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index eb1691860da..9bf87db4775 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -169,14 +169,14 @@ test_expect_success 'core.logAllRefUpdates=always creates reflog for ORIG_HEAD'
 	git reflog exists ORIG_HEAD
 '
 
-test_expect_success '--no-create-reflog overrides core.logAllRefUpdates=always' '
-	test_config core.logAllRefUpdates true &&
+test_expect_success '--no-create-reflog does not override core.logAllRefUpdates=always' '
+	test_config core.logAllRefUpdates always &&
 	test_when_finished "git update-ref -d $outside" &&
 	git update-ref --no-create-reflog $outside $A &&
 	git rev-parse $A >expect &&
 	git rev-parse $outside >actual &&
 	test_cmp expect actual &&
-	test_must_fail git reflog exists $outside
+	git reflog exists $outside
 '
 
 test_expect_success "create $m (by HEAD)" '

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.46.1.641.g54e7913fcb6

