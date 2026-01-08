Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BE274FF5
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853816; cv=none; b=DA6bG9jJ06YiR/1XiVbjwRzsNnsU1UOuiFO2XmW7IBuQZjneuTsKrnql/AQrHAmEJnUNWK1yfX/wq0ViwLLIwhzZS3zaj67IjJILmrnw2unvnYNZROSF1aH4x+OqqB2r6vnBvZPINHyj3WCUnCn1bRsyY7BQNJN4x0pq24o9eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853816; c=relaxed/simple;
	bh=3ZJcIFICPt6pI+5igVtbnbt44Mev0Zr5eirMyqTgb2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lge6fjtZvAKbBOSKf7KVOKqdEnCXOBXHimKBqSAuTgl+7hsqShNrVo1QQnyZ4f2tfTE1qvQuUVpK/pHjhyWUwpLDSCzxom5Y5hemqsuwqHa6mPAJhqqe06H3lKZMjNX5hjuc3WXFmtEaxHb08ZtPaJdDXgPWboDQlbOZ9h+WTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DSd4ruI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnTZzhw6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DSd4ruI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnTZzhw6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A65B21D000AF;
	Thu,  8 Jan 2026 01:30:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 08 Jan 2026 01:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767853814; x=
	1767940214; bh=OjYNxvm60kOiDsb2qorK2bkK44bHJN1KupE1BfCbbLQ=; b=D
	Sd4ruI3VqKlqehF7udUEzuMH73ErNxBLNwR+gdGiVbk7aB9jJxUy4k1yVADtZabs
	vWuT8Zn0vem4grDdNrEC+WzPtaI8cKotIwuRRIHdx2a4S15tWJCD5WK+ZHfnmYjA
	sepP8SrDZXAt2cBeIry8+el2uGX9Kqwc78FtJffxv6j+Tpl5ni45mXxt0tnEdhli
	5BcZgLEr+10y0UHPwi91hvqgX+rkN0N1hhVA9+eHfSZUwJA73zjryVD6aGnam6VV
	PebQvR7O4BoDgvxper5Yyeg0NLXjxZv8/G5hoozv6TUvKJQfP+FCN5fQCQpGa5/L
	dqYBQMvutqi0HiB3SMUtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767853814; x=1767940214; bh=O
	jYNxvm60kOiDsb2qorK2bkK44bHJN1KupE1BfCbbLQ=; b=fnTZzhw6FHhIUoeyI
	Pa/BlzPXYcderC5idC/794Jow46uUQYGn++nbG+TQmuymXyMomwQPxQ6qh0nQd2C
	mpG3RNH0rKHJYHcgRO89Hzm05p1hwERrmPBZQMsG4ckNEtAltaC7Tq0rk21dxkqY
	HpfxANv+Ru+FPGwVgZBBihtDYnn6tG9mpIGBWey0+FFv/5S6OfvKqwZlVWqr/81a
	/sIFsIXoDnBFVOU6dj6jxPDFuUmzXktN18XCOHQXr0xIzzxRPLleum384hhNja+M
	qwNBUKBPhnaPaIoZD7TjL5z1AeqLsJyv+8f0Dky3bY8QjQ0yTIb+kwQhEzhCAEhe
	NlBgw==
X-ME-Sender: <xms:9k5fab84DP4fimiuzUjoPT0_tlqwbja0CPyI6C0KW0ym2qBzxLWAJxE>
    <xme:9k5fadti1_B5rBcdwA9Zgcls8Ke5xZclW3oBn3H2sTb01foVWWVyW2iAQKYnD6eB1
    LAGoq_tE51bt9qwe14MpLb0qJN91HEGK8OY8FrIP6biDViSKpfdiQ>
X-ME-Received: <xmr:9k5faWrPsk7CL1q9pMZYR4atR1RLH5zYtABy_VIbnc0mZgDp7wmKveKG1VlM7Cc_frVzJi1w1glgdGhlX9J6H16LESXqPIgNH144nGk2EkSggTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetke
    eftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:9k5faSnVDXIE2OuX1rpPzmV8nvQlBaTMvqErMgyOk1QyUG5XzPcoHw>
    <xmx:9k5faSwW-fYABb5XO2YudYS7EiT1u23KIkGkAhZhrCiQ-3yrXyqQhQ>
    <xmx:9k5faSnkISiyNzGpMWZkfD68samUNhSI0S9CegeXB9bjZxcnjgC4MQ>
    <xmx:9k5faTeuy0jo34I6OArTZ0v3fR_Fei9y35A4apYmBXZTDYEcf25oVg>
    <xmx:9k5faQTosZDyKS7fMxJl03DM5zdvJEiDgxqQaJJZwdfEu1HQv4_sCXCd>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:30:12 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 5/6] doc: patch-id: spell out the git-diff-tree(1) form
Date: Thu,  8 Jan 2026 07:28:19 +0100
Message-ID: <git_diff-tree_--patch.1b0@msgid.xyz>
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

You specifically need `--patch` since the default output is a raw diff.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index abd02fccdc0..61498def317 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -21,7 +21,7 @@ the same time also reasonably unique, i.e., two patches that have the same
 
 The main usecase for this command is to look for likely duplicate commits.
 
-When dealing with `git diff-tree` output, it takes advantage of
+When dealing with `git diff-tree --patch` output, it takes advantage of
 the fact that the patch is prefixed with the object name of the
 commit, and outputs two 40-byte hexadecimal strings.  The first
 string is the patch ID, and the second string is the commit ID.
-- 
2.52.0.421.gc32ead4fc78

