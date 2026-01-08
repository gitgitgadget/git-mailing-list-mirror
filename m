Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603D318EC3
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853717; cv=none; b=sGP1oQCEcovWkxNwf/dHfqeh3bskBT4nHQsWL5lBZtVO+JlIQg4Toj6r6pIfNcvMRA90/KDFt2d7+htW/SaPC/+HIsiQ3esxrkZIHVA4A9O8nBAIma9B3Wke8qilIOHA05sMn1kbVGYx7ANeptVSPBeh/egDyyWyIc2G2UsT0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853717; c=relaxed/simple;
	bh=nudy++2RPyUyiqqjaigv35AoI3k1a6jEQfl7uNNZLVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GcUkW95lrJfqoxtlvX9KcSy/s88bGgcRmOPQ6Zr/8uKL9iuffLDNul4HRxa4Haq+r5OLprPVTaybc3JHOkroa0azdECpjM3pY2gCrh+xwsU2u69M+ekK4acVkemfysREKcscs+1SK2kUu+Ub/4ajZcNY5+rwaoSL3w6HO9U36I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=uiX5Va5Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l0RHUjJa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="uiX5Va5Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l0RHUjJa"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E7E11D0008D;
	Thu,  8 Jan 2026 01:28:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 08 Jan 2026 01:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1767853714; x=1767940114; bh=Zs
	WqJfa1BZ5FXCxb4ZSzZfvTwsL+RKsgdluzNh4r6Wc=; b=uiX5Va5YnElAZxCvcx
	fVsoRFQFk8OmyI5cjzVY16f136kpI31UrB61T3bnP1dHmn5TK8r1xTdd0U7e6BuD
	hWFTDdWNcIWkS7v145mTtaX2ldXPAlTbSL05pB0zETAegXJbw4VQF1YIKDZyRDxl
	VlThFp5zo0yDon0KAYeJfZjLPWYumLc6SqoN+MNkj6XgqYD2AxSj8kbZtcw3+w5N
	Gz0aelmDywn3TkT6Zd1xsg3IspDxlS+iItYxVpf3FNTd6kDFXu5I54hKv5XnJGEk
	RpqN4gXj2X9a+6XgYHDFXAaYe003lGz8O4oHU9A6oR7hyiy2vNVzHF3FNrty2q9d
	gMsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767853714; x=1767940114; bh=ZsWqJfa1BZ5FXCxb4ZSzZfvTwsL+
	RKsgdluzNh4r6Wc=; b=l0RHUjJamP35hOKg5T/0rV1JHLQjJDqbY75v/8AVandB
	sNy72RlM/nwu+KzTm8hUMADeU5nLM+ycILuHxQa/p1qKd6WMcqxUm1eiVQwfYdoA
	xmBn97wzL6fr9BUQyVDVqieMp8Ds6xkX8Tb4UdtM9Zg0/2SaFaUQaC/kWCPcOeA9
	QiYKauPJG8fjWzYsTQk5wkeUyXIIrYiwiRIcG8SGz/4+zb+wjm2rcRG4lve6e0nF
	hyNMs6TWZqQKOb47luMIym5yNcjqJ4oCYmKmdsXVt+FJniGV6r4i+oJeSMjjUct1
	gKiCybjv0GTUi1/eyER3o1O2uuv4hBvlgUaiaOM3+Q==
X-ME-Sender: <xms:kU5facPsTkk30t2eAtTJanVMXYp5lH2Nqy15vhLXFOmtRtztDFL2kJ0>
    <xme:kU5faY-gqVUGchOWiHoNMhLk0DgH_-MTKf8iSWSKLhss5wffxMvuw4DdsM16dajSm
    _L6PEeKV6SSfhho58REzyrNxptl5ye7hJFszEvHpxNt8HoXxzOfzIc>
X-ME-Received: <xmr:kU5faQ7NlhkShRyhf-O2zt7UDaNzhpw7dByynUZgn3e0kcclIqKGP231pZ7IGS9iu_gXK1ZCh1NibqWUHQU96cbEVG9x8_OkvRbVhQYIiHxlFF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepheelhefhie
    euheejveeftdfgiedtueevhfdugedvheekvedvuedtueeffeeigeevnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:kU5faf0rMrZDZfTu4AcrjPxRH_Uea4eih2j7HlQiGy3DPJr4u-WTUw>
    <xmx:kU5faXCG5INBIfGFV7V_gSebsLnsvbkQRfe-d3cJCAQa0MUBCtxNuA>
    <xmx:kU5faR3J7SVbfSloUNLQ65_kX6wijmstHg7Ml4mRnQdVstao4kG6nQ>
    <xmx:kU5faRtiPzHyq4l4bPCIIRYeI8WWD4uHrCpa3QzEYWNNb3xxRAWqpA>
    <xmx:kk5faXmYINCtAQQkUzW9vqBNo5Ra7-uqVmmXH0mXHegEB45G-nnWlBkp>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:28:32 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/6] doc: patch-id: six small improvements
Date: Thu,  8 Jan 2026 07:28:14 +0100
Message-ID: <CV_doc_patch-id_3.1ab@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-patch-id-3

Topic summary: Improvements to git-patch-id(1).  Fix git-diff-tree(1)
mention, Fix '--verbatim' documentation, and four other small
improvements.

This is the third patch series for git-patch-id(1). This one only has
small improvements.

• Patch series 1:
  • Topic: kh/doc-patch-id-markup-fix
  • https://lore.kernel.org/git/v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name/
• Patch series 2:
  • Topic: kh/doc-patch-id-1
  • https://lore.kernel.org/git/v2-38645ea253c.1760369708.git.code@khaugsbakk.name/

Kristoffer Haugsbakk (6):
  doc: patch-id: don’t use semicolon between bullet points
  doc: patch-id: capitalize Git version
  patch-id: use “patch ID” throughout
  doc: patch-id: use definite article for the result
  doc: patch-id: spell out the git-diff-tree(1) form
  doc: patch-id: --verbatim locks in --stable

 Documentation/git-patch-id.adoc | 20 ++++++++++----------
 builtin/patch-id.c              |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.421.gc32ead4fc78

