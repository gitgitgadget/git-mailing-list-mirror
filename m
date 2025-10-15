Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB631AF21
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521781; cv=none; b=dYeWdICA1eh+Mrfoeze38xE9DSX2A9FW8+YgQSh0u3kcBUy/Bd+ht9wz/1GxHBi6ga+n0HTclzoCCUCkPfppfk6kmSlrXdP7xyuDv5QLE0Fsf3xeDci65yfzuMuDf7sJtm1q3fVZ3fLWiEq0JsYp0cKvtyrSVCRkTyE2f0SZFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521781; c=relaxed/simple;
	bh=txM5O4tv1t7o5cJKKeypBTrQV6DlJw2aJWNy9yH+f2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YyTD6tavABN5BWLVxcrFHrh4XZET4mutCMNpwS1jHapzt7nTe7Rz6G2kV2CyoA8wJsnwEBZESj/FN77HAzY0ScuOWn/XSD6c9Pktjgy6INQNhwVga/q94pVYNJ2/B0IOj6/F1S50nffmsQrvy6Dlvo+PFPmpSEhN6tGn3fJT550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dDsOfTlt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSL+3kUc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dDsOfTlt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSL+3kUc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5BCF01400165;
	Wed, 15 Oct 2025 05:49:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 05:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1760521778; x=1760608178; bh=Mb
	QI6nY0zCbfvTIMzLgLoVDjpolf3+CTzaSgPTOlpmM=; b=dDsOfTltFOCt24xs64
	ulfptD1wD6OnJDpnPZWqVIKOyGWpkKkksvM3nwW7JG4T6/Vm8VZI0HegZ2xDcHFt
	RzkQLvcgvGh7mbvHdk5EBMGqlm4BAxc8QiVkjhSlwyYpDWmZUcxMq2RuS6xRHHqp
	kVz5HoG25Xbd/Q3t/VzfuCppi8oYWqtunn4x1vno9w7lEEh/hTXN3IrwThMV4ozD
	DOfX3D9KjopnrFiIQug/5e3Z/xcGVzAWKzwo+l9kgXlGN39wJRYfziu3ePU8sFst
	TkQUpAXs+ZV6cX2dINgXfJazRcbSewSFhrWvnr4J5nkCPZbO/SXY6BTjWUcY+eHf
	jWDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760521778; x=1760608178; bh=MbQI6nY0zCbfvTIMzLgLoVDjpolf
	3+CTzaSgPTOlpmM=; b=aSL+3kUcT8n7PdQV7VZkJ7Gy9ZVMEu09kh+C8WCz7W5/
	W2YFzX11/G58dRgq0KgDMwPIH86goAQVG65nxdlIjLOw7SRRCeyNmBQMiK0cXqa8
	RauhEmowH9ft1ikHutuvQmlNF1AHRD2MjMxrdWWVTh+AVVrFygN9JbOnzrgFpSnz
	xE7dvrwt5GiigGx4uJWxq4rY/4OxZcy285tWKNQt79FeGd625EXbc0vIhi1hSoZG
	1wwIaOsMhtyKhl9KCW8PRbwUQLDsG8qyx9uIo16IBcB2Q2u8t1PE1yQzbiirXYaZ
	s+ytWsLL9moV/G+eRquQ3R7W7rfWYBb3L13K3+MRJg==
X-ME-Sender: <xms:Mm7vaMlXYF0L5ZSKBF3vO-7K9bZGv5LBZitPWK_5IGvYPQpUhfJKmHo>
    <xme:Mm7vaDTuAT4fg8fnfR5jt2_OELTT5pbz7NXQndqj1bnFuFUPxUCaA2dV8nExk-a4t
    cxdJqXuJHtuAvl7krLrK9TdcErLbu98Rpq8_HBOBWOomYg76Wo>
X-ME-Received: <xmr:Mm7vaIAsQwdP6Bg85P2nlkes8WBp52y5CHX2RnjpbHG-ZNddlL_JIKuNVFPzc44rrjvBLChQGXxhwEaGh6fmv5Gggy09QDdw77-H9fo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegff
    eujeejleegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:Mm7vaCR2X2BBBDLDf0AlCNA3LsO_HFuzjecO_SwSseTo83MQzc1XEA>
    <xmx:Mm7vaOogW1jxJGxFu0jAuWY9rVT1NQ2nobm-sWrk_CFNJiCCbebiRw>
    <xmx:Mm7vaMzAqMxwUFV5cu9yD4hPXH8i91z9mKlESCFOkpIFHtl77Lq4OA>
    <xmx:Mm7vaLJo9NKPvRLO8QkKRYYgRifi3oZafNPrN7lvNK72_aC2TxP8KQ>
    <xmx:Mm7vaDaG9JdyxnUIKtELigzCItCAvWOLl_bae-YvD0zQzXJ1cFPO3OCj>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 05:49:37 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	gitster@pobox.com
Subject: [PATCH] RelNotes: minor fixups before 2.51.1
Date: Wed, 15 Oct 2025 11:48:57 +0200
Message-ID: <3d36523a1abf82dcb0414fbcdc477db01c399c9d.1760521594.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.352.g356bc2d8d49
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Grammar and typo fixes. Also change “work it around” to “work around”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I will send a separate patch to fix the same entries in 2.52.0 if
    this is accepted.

 Documentation/RelNotes/2.51.1.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/RelNotes/2.51.1.adoc b/Documentation/RelNotes/2.51.1.adoc
index 6a6049810dc..114288925d1 100644
--- a/Documentation/RelNotes/2.51.1.adoc
+++ b/Documentation/RelNotes/2.51.1.adoc
@@ -3,7 +3,7 @@ Git 2.51.1 Release Notes
 
 There shouldn't be anything exciting to see here.  This is primarily
 to flush the "do you still use it?" improvements that has landed on
-the master front, together with a handful of low-hanging low-impact
+the master front, together with a handful of low-hanging, low-impact
 fixes that should be safe.
 
 
@@ -22,15 +22,15 @@ Fixes since Git 2.51.0
  * Manual page for "gitk" is updated with the current maintainer's
    name.
 
- * Update the instruction to use of GGG in the MyFirstContribution
+ * Update the instructions for using GGG in the MyFirstContribution
    document to say that a GitHub PR could be made against `git/git`
    instead of `gitgitgadget/git`.
 
- * Clang-format update to let our control macros formatted the way we
+ * Clang-format update to let our control macros be formatted the way we
    had them traditionally, e.g., "for_each_string_list_item()" without
    space before the parentheses.
 
- * A few places where an size_t value was cast to curl_off_t without
+ * A few places where a size_t value was cast to curl_off_t without
    checking has been updated to use the existing helper function.
 
  * The start_delayed_progress() function in the progress eye-candy API
@@ -38,9 +38,9 @@ Fixes since Git 2.51.0
    larger than 1 second ineffective, which has been corrected.
 
  * Makefile tried to run multiple "cargo build" which would not work
-   very well; serialize their execution to work it around.
+   very well; serialize their execution to work around this problem.
 
- * Adjust to the way newer versions of cURL selectivel enables tracing
+ * Adjust to the way newer versions of cURL selectively enable tracing
    options, so that our tests can continue to work.
 
-Also contains various documentation updates, code clean-ups and minor fixups.
+Also contains various documentation updates, code cleanups and minor fixups.

base-commit: dba6e578b68488823490130637c6f4755938c518
-- 
2.51.0

