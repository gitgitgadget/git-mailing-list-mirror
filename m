Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBD145B3F
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853797; cv=none; b=QvEXba445zfEQFpl90YRLPG4Y5tsM1fhAaqo5tt3SsBMOdG5i6Jq7JNnCzA+1pCuR24+f+ngH+uIUmpQAZFd6cLIE/TmY/jMMzOsoRaLAXYEHZCvXaACkrOVANnrMYBKeflFO2gzsgejlZl/m11lCn0tMqbZu3gL9uUigBsoFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853797; c=relaxed/simple;
	bh=fd9U3eDWEmyZtZaGwwHTqCemeO1xQ9cyJKu+edegvbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nx7n29c0ziI86uzht74Dn0EZkLjE/BiFDpE1OyGxd4WG39UhZXdJc5kJQL1XTheqyrP/bxNQ2/DfFcODxaOkbYSzGKdb726HXLWLxPjAY8JkbRXFpaAhdW6LgVezYkm3KqfA/QWNdYwya4UU1xcuZvp5ScvOJZvl1KzGVTiechY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=uQG1vsEK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+SEmEyG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="uQG1vsEK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+SEmEyG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EE4161D000AF;
	Thu,  8 Jan 2026 01:29:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 01:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767853794; x=
	1767940194; bh=dt/ARekXTnt2F0c5zpLy/hm6XoDgGmHZIcweVLuKfus=; b=u
	QG1vsEK8uOQ1XtQBbmmZihE/pvpwbrEMLBr9V4doAEThv5F/ORdWeoPxYuEPwY8F
	D8NC4MNWBfLyhuQC2Yz+xk6Wf4nlfjEaCUM3S2tgYO4Nx0HYdIaTJM0JzRL7BPTh
	rv9ABqFf8G2yNyf/2pr4c999GkCbXrz/uD0243dMkhHzDQDpEeljwmwhoviUqLED
	wnkS1xUyicozLV8I8SVG11vEnEHEX5hvB9rjQfTX7bMBo4vW0q/7xlqS4PaaFOwL
	kvXcN1KGr/G9GsccYO0GTNXNT9hnsQM3qopIzMd0lV91Bgi2QieYvXXSLsrrg2rQ
	1Z1nVzQk4ZcuXXV6t1TXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767853794; x=1767940194; bh=d
	t/ARekXTnt2F0c5zpLy/hm6XoDgGmHZIcweVLuKfus=; b=d+SEmEyGj0YuImfFk
	hdjyTzVFL5S066+xY6bCNnaaZVhbBafgmcxk32Dig4AEwBUbiMn6bTr3Yd5Moja5
	OjePTligyrbYqko10T4VtdFNk8isg0xvGaZRuXlGqZAHgAj0LlO9ypHVSLXr8P3N
	48t8Wnco33oJMxZloDBBUOK6WsUdojNAWl6mxPSlUHFDquMjqdYXYXkOMhUBkbmd
	lFPhWhxS5df0B3gXrzi6FK8Degky0BqbQS8Un8nDyen+OPnnBxen5ofnw9AQDOrK
	cg16+384IJ761zCVhJ9uNiMKoCFc64u/xXPHKdKaJKGb3Iq7uq2oE+sahZmEpfki
	0N8jQ==
X-ME-Sender: <xms:4k5faelVTA2MmB6guZDD4KZDV5NncXlIrOrH56If_fel8gXtIb2tE0A>
    <xme:4k5fab2JD1ibQofdN-EHwP7XMxUx1sYUe0B4GcOojAgPqU64WaiONqvt1kSqQeWVY
    VinENXA7IzYdaI5M7ICotcIegm52n01yQXhoRsZSi0GZgYFk1vuhw>
X-ME-Received: <xmr:4k5faaRp4ohw_edy22RLBXLnYj7eSSQN2zGS0JzmyU3sDS0422HtHWlxsN8JenHPjlhNwmQbOksnsDdV9TEPN7mDMxiA-gc6tFo2sMZwpOWrwSY>
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
X-ME-Proxy: <xmx:4k5fadubWnaGFDmg5pJGW8AuZ5UKCNJWrzAWXggZMmtrPuLkJ--9rQ>
    <xmx:4k5fafabRU48lbUTaOC4x7FG2JeCtlZLxrh74-2A9HPKUFmqARXbNQ>
    <xmx:4k5faStXIpb2K99pJ5jk9EdzEV1vWw-6qqPVg7cXkTt9sT0g42B9Ig>
    <xmx:4k5faRFyKEi3na_pTyM52gh3tD491vjOW_ZEubIg56OFS-UhVMyM1Q>
    <xmx:4k5faZ-MN7N7ReJox0UlXoFKGDaZqnQ3_dfFAYQGSAhI9vf1SgSn1ffF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:29:53 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 4/6] doc: patch-id: use definite article for the result
Date: Thu,  8 Jan 2026 07:28:18 +0100
Message-ID: <the_result_c.f._1.9.1af@msgid.xyz>
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

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 9999f164b58..abd02fccdc0 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -47,7 +47,7 @@ This is the default if `patchid.verbatim` is `true`.
   as a key to index some meta-information about the change between
   the two trees.
 
-- Result is different from the value produced by Git 1.9 and older
+- The result is different from the value produced by Git 1.9 and older
   or produced when an "unstable" hash (see `--unstable` below) is
   configured - even when used on a diff output taken without any use
   of `-O<orderfile>`, thereby making existing databases storing such
-- 
2.52.0.421.gc32ead4fc78

