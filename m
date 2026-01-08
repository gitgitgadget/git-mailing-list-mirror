Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA227CB35
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853757; cv=none; b=XsS9MHQ8aB96umbEnVK47kWYdTtU9yEOsJICx8J76mxV8V4RfeQnuRiyKaV57k7xnIKAvUmHKrY9IAUw72YMzqMidIcuGcY0EXHOg2uPnpsx0Z56Ign6f/S3bE5+0sduP+ig/B8o9TwIdKKxfxlgusKYKYvELwojvPrlo4cBW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853757; c=relaxed/simple;
	bh=P8AwBeDGypgkh2jVyPZUmT2PrdjuokEDhAM76wzlDDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7QULZ+1mvL9XnAHnFIK0kdIngkRt6+CqglE57f96vESjGNbKN33h2qs/UEwACg4R/SjHBrbIdh6js15gVD4lV1zh7E0zv4cFUa5ren1hotcoiJE35jO2e5Gw5Aip6+goGHwA9kUN8K2jCAfXU0f7jngfTPirNzS7ShkyIuTfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iISBuHj1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFCMA0Cr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iISBuHj1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFCMA0Cr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 768577A00F4;
	Thu,  8 Jan 2026 01:29:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 08 Jan 2026 01:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767853755; x=
	1767940155; bh=v4kzGNON7kPX83bOGRDCHGecxfmlUzKSad+JxI2wRWg=; b=i
	ISBuHj1uafL1/gY7+dSlmWC0XTYkX8mIPBCRixkz5QEgxyNQxhiQN/lpFnoSwXaJ
	ypB1kTl8iMr3lZsLCzAIeaZ8EPnTcJ+sax6p/pWCDEdwzpaSSHLJHL7QNw5Q1LhY
	fBd9eCB1dibrAgkoBNJ/rioLPutpiT2jP33I2GpgXXFFtEaxQ0W76myL1HGJdFZm
	uwb7kY8Ze2biapgyErIDaZD4+T1yA2OG7BY2IjtcVMf9ZMi+l22ZMJ7t9jgyrf24
	qzsq7whyIodmvWNWTHXpVQcbAAIav/zyEyJO6rkdhAJdNmKTmRMD7Z4U2BfIogiW
	qWEUNf/bI9relZ31pIVIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767853755; x=1767940155; bh=v
	4kzGNON7kPX83bOGRDCHGecxfmlUzKSad+JxI2wRWg=; b=IFCMA0CrQPQ7jI4KB
	uAbTTB4vIUDXAEQG8zce6IFe6TTSMHVb9dNSRMShrYM2XHleZ4vZk5oWzaYl/RSW
	8lmnPtAvHq8+KLFRfK+iSUR0UBoS70x8mp8omZ5RyTmh78DT8a9DORlJ+wVdfZJJ
	IlRPJET5U7A/dxkFdn+UOoktce/aY3oCLMG2huiucZcIK0chL3WTkzCPlzeD2qNS
	0JTzS2NZEnO8UlGmxEh8iWQesAhT5Jo5wr3o4h4PDkvzydNsHK8Ac5Mck5Egw5kj
	+WpeU+LkW0lc0M2NB6n1NIikYpaiOSM+Mm54xlKhUCe1E+6IMc3tGK8DPSnOmlgq
	yxRwg==
X-ME-Sender: <xms:u05faa66eH_3pKdtfUbxoUbB6FcoaUrrTKoQwVXEFvEEv70vOawYKOY>
    <xme:u05faZ5vG5OF2LZM4Df8PrSgJKXn4LWs2vtkdk76ktTw-m3G1m-TVVg0j1N4otby6
    2QxxjYacgaVsWERUEqV3eEWtkPbck30AR-0QZzOwoqxAY4fCSVQ8A>
X-ME-Received: <xmr:u05faXFw52YVGLps8pQbL5og2glbXD1_S1DrOoKnhdwy6a5tgGHwuKCTG4g3ZY1ESlCmhBUV0GGaBBk8sIq29frsSs_Zmq4TOA_Nft6ILtV7AYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetke
    eftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:u05faSSvlo0ISL_afjj9tRhXY4i9gyaGFeADKDdzoVq99xV_B2r_Yw>
    <xmx:u05faQtoeUEj1rbhqBfoUOuwXrqm2oGNaXo2fEmuLToQtzXCeUuGew>
    <xmx:u05faRwa5wWK10ZH5muDb1QsByDrNCPLq1Lsq3zEdCGrYmwexStujQ>
    <xmx:u05faa74P1pjKDNNWSejq8arFMBUXNyL2qYzqXVqTuudCOatiePVuA>
    <xmx:u05faeS31m8KgtFknPXboQ5IREMyuADGBoSv_PbT5N46CuMeSxXOl7Ld>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:29:14 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/6] doc: patch-id: capitalize Git version
Date: Thu,  8 Jan 2026 07:28:16 +0100
Message-ID: <capitalize_Git.1ad@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <CV_doc_patch-id_3.1ab@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Git versions are always capitalized.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index bac37db09d4..82992e35fc1 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -47,7 +47,7 @@ This is the default if `patchid.verbatim` is `true`.
   as a key to index some meta-information about the change between
   the two trees.
 
-- Result is different from the value produced by git 1.9 and older
+- Result is different from the value produced by Git 1.9 and older
   or produced when an "unstable" hash (see `--unstable` below) is
   configured - even when used on a diff output taken without any use
   of `-O<orderfile>`, thereby making existing databases storing such
@@ -61,8 +61,8 @@ This is the default if `patchid.stable` is set to `true`.
 `--unstable`::
 	Use an "unstable" hash as the patch ID. With this option,
 	the result produced is compatible with the patch-id value produced
-	by git 1.9 and older and whitespace is ignored.  Users with pre-existing
-	databases storing patch-ids produced by git 1.9 and older (who do not deal
+	by Git 1.9 and older and whitespace is ignored.  Users with pre-existing
+	databases storing patch-ids produced by Git 1.9 and older (who do not deal
 	with reordered patches) may want to use this option.
 +
 This is the default.
-- 
2.52.0.421.gc32ead4fc78

