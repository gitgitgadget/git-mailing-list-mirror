Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D437E315
	for <git@vger.kernel.org>; Thu, 21 May 2026 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380839; cv=none; b=ekRacEMhO2Hm8rb6qY0vW+GGj+ZYv/VX+8EfZlk7NMRLsYuxwLV0GpHHq64qXBb08uhraPcBAo5Ck1aeYvJDTthaWI0n5XeBVzPVWGte/MkSbHIeeOVdkaVbSF5qy5mZ7TA3btS+GV8o72dVE8zEEo/NnhW8zYIOCRpW9NcGieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380839; c=relaxed/simple;
	bh=YaEayGiQnI5pEsb6CTMOV/tP3kv65ZpNU6R0XnzlYCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjn26wCyAixZRtGtbUI1X2KeAbUDT4HSIekDlk9tKPuPTzT4h0cYzzYsc7/XYsQY3pKET9MkPod36FQUZOND+x3m41ZkufACoSZ651o2ZlKgBS9K5kOtZ5KsBm3kGbCYxMwh0JmxAKv8SNUBsmImSbeNDO/xFc/D7rj3S15zx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Y+M2Uoxh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ia1KQWHE; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Y+M2Uoxh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ia1KQWHE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F0497A00A6;
	Thu, 21 May 2026 12:27:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 21 May 2026 12:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779380837; x=
	1779467237; bh=y/KqXPWXLvU8Q2i2lNyt59xfi2lIt7gcNPk+X/4DsYs=; b=Y
	+M2UoxhWAvb2vlkopfQUbaaFcvLUk/vdk4YPq11f1O8t60MnggX2VPckCUUVWdPi
	6YVTN3uVuIjrd9Qj4Cnt7WRh91Zsh+BlqwmaaUaruJlb4ZFlaJKex6UCQTo27+YZ
	ttDyYnl7Z+5MUMAipwXPf+IY06OuWr4vgDRrFWaqb9cW+ooHSl67ZMT688nryfa1
	PLuDAlVKTkhlObapHPAFsgRCBy75nsMXsPT4+KRlsMUyxWneYYrjwx7sP4OF7VBi
	oapSjNd5p1vmCkmE7/wEXQmVXnxhzdulDNcPvbYF4PaL6DUccZ6c215wUVtIGwTq
	hiD5RyE2tU9U9y1YYXDPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779380837; x=1779467237; bh=y
	/KqXPWXLvU8Q2i2lNyt59xfi2lIt7gcNPk+X/4DsYs=; b=ia1KQWHE6AF8oSlNr
	mTrnLrgXpWOu+jazGbmnawBCh5/WlP3ZJgN86iUTCOR3LjSXtRXstjTYbIZlt2jD
	J4PppwUzTBuEx4VTG67M3EQDGXCd8uylJifHNEjR4oe9hnQI5lcrjTt0cUmTPldf
	M5iPMr15rAHU0P14ZByoqEGr+7uRMmVa59RIQ9fGjD1Q40ElRtyOHCwDE7M9bOPh
	HxyXjXYtLI1Y2uD5/dPeKBVF5C4rk/YDf5W57rQQ2KYHeIIvVgR+RKiwKJSIJ+G3
	5NK7W8FTY3QtE4tLFijj94JtE/K+PsPi6Tz23mj/hobDEqsGS0YvugvSLFmI3KQz
	h1GlQ==
X-ME-Sender: <xms:ZDIPajz-9yKj8Gab_Kh5jj2GzF2ru8Z6dIJG3gzX4PnvHcQeHwUEBno>
    <xme:ZDIPaiTof3zFav0ASQ4E41hZq5N899L2uLF9KXUk8-RaVnCbYoUy--Sux8HMnKVOh
    5aUoVDymqTvCewZ0E-9q2HcpUgAoF9I8zC4Pdg4p4U5d0C0cigW>
X-ME-Received: <xmr:ZDIPaiU9IJT0qpSAl_PeXdllg4Ouh86faCaNM5Rku9yXArehbazniZPiS_iv50KMnn8wTRx0C6aXl3xHxzJ-lOlPY5S1xTXLgwCVoU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetke
    eftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegrughrihgrnh
    drrhgrthhiuhestgholhhlrggsohhrrgdrtghomh
X-ME-Proxy: <xmx:ZDIPasZU5VX0OWPfdygzwDqhf-pM9-VclKsWqphpoGQE_ys0EAeRgQ>
    <xmx:ZDIPag0ymCR9k2TbG2KZGPe-RnzJHbR5OsogumdTSMnXie068iGgeg>
    <xmx:ZDIPamhLVwrgcelrxF0XBVvXhv-5O--XCd3UhewpQN5SSoe110b0lw>
    <xmx:ZDIPasaetRCmDifruPif8dx49-1ZsUprs-Q5Xv3lFPSYqed8g6BoHQ>
    <xmx:ZTIPajle1gF8GBDyFRvaxLzWkNcm4qXSNfeBy_VYAAlvLHqF_QqT3RBT>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 12:27:15 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	jn.avila@free.fr,
	adrian.ratiu@collabora.com
Subject: [PATCH 1/4] doc: hook: remove stray backtick
Date: Thu, 21 May 2026 18:25:55 +0200
Message-ID: <doc_hook_stray_backtick.6f1@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_hook.6f0@msgid.xyz>
References: <CV_doc_hook.6f0@msgid.xyz>
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
 Documentation/git-hook.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 46ea52db55f..96c5c9c3c23 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -41,7 +41,7 @@ spell-checker for your commit messages, you would write a configuration like so:
 
 With this config, when you run 'git commit', first `~/bin/linter --cpp20` will
 have a chance to check your files to be committed (during the `pre-commit` hook
-event`), and then `~/bin/spellchecker` will have a chance to check your commit
+event), and then `~/bin/spellchecker` will have a chance to check your commit
 message (during the `commit-msg` hook event).
 
 Commands are run in the order Git encounters their associated
-- 
2.54.0.13.g9c7419e39f8

