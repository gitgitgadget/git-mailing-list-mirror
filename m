Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653E35CBCD
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968910; cv=none; b=HsA5tPfiIdZALMR6pDvIB9pCfGmFcoJj8bPyYEEL7RL4h8N3MLvh5NvtnBY0Eo31iklPRWcLNfWq3BLXyoCkp0msupYCFFbw69SWJueSs0LAw9C391ztwvKJKfbUhBo+gkSzok8VGcoqzVtdK3YP/wrW0C0gdb6PJu7EkqyiHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968910; c=relaxed/simple;
	bh=3ZJcIFICPt6pI+5igVtbnbt44Mev0Zr5eirMyqTgb2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ik1/4skDEeVY6EFVdgUngqJbbLg73q3dL98B0IwzQGwtpMMq8yCT4LEkEvZwD9SgsuZoBmUqTf+/Df5MoHL5g6/+ZsmmJCJYGuJEOGqXZiTxnRbUQ998Wfo6jpoXcqHFDHY4RxtuI3zGiNG6BUS2We2y7X4YWlQmvKLKCxsTp/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RuatecpW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CxuHTWTj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RuatecpW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxuHTWTj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A77321D000BC;
	Fri,  9 Jan 2026 09:28:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 09 Jan 2026 09:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767968898; x=
	1768055298; bh=OjYNxvm60kOiDsb2qorK2bkK44bHJN1KupE1BfCbbLQ=; b=R
	uatecpWVrwWYmP+HMrpQVEjDerd4tuEs5CPYIYsqikd16Lr7pLA9MHlH53wHpE1l
	tLgApYDX132v0BZwUqetlPecHTZRwnVieseF7J5M1/GJPfhTysKnM0TJKDawQyn8
	1O5Ht4LGBqy6D2iOnYcrcWEVfdlwtl53yJJM7UK+OXg47b/Su9RqqKIeW97i5lor
	lCBWspY9RBwgx1srAfX/cKdtU7zzkaKgZLLChU82ileq7qWNK+5Ix+hYt2KtyZP8
	Tmbr9dvLcorDmOWafKgOPFq4rPqXxV9glF6O2omA+FS5/I63qBQuSlfCt33VXOGU
	yW+qQsBugi2qMu06B+UwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767968898; x=1768055298; bh=O
	jYNxvm60kOiDsb2qorK2bkK44bHJN1KupE1BfCbbLQ=; b=CxuHTWTjA8SdyI8hA
	g8jVNor0MTXvDUdZ+MyeTAG2/7CI5gr3yphKJzKPL8HoqeWUEw0ULQw2X6kjT/lX
	/1Kz4Fns5O6XBRu47V3ESCoOr6ePWD6VdIyKbf1LnrFok5chjlYyWA46pUhxfcdv
	yzL5/VLaGyMKfgbUqQIf1lobst095JCDG9XbtROc4y8Cs9+2NfblIrsQaJX/CiDJ
	fKqNexyURGwT3pVP3rpROcstMekTACcwP1kdlCaRozmfCQkYaJuA/kJm6RnAM2A2
	t/JEFPAQfSXQogwn/8hbzT+roDvvB9wpI22UupuF5GKOFMDRESDLiv6Y+aSRt5vS
	sIQBg==
X-ME-Sender: <xms:ghBhaSUMIPGPzDQvM_rgDfSb_dkgdW9Atn_oizQ8d9689yJ8QNScQhs>
    <xme:ghBhaVkq2SDo_KTXTuYnKKXoSXX32TiQyXS8APtPXig-XJ5xoxL15mywZWvOn4Zn3
    m4TFUa_I2Le_2fwrFUxd1FRMzPoFQ5xxxrWmY5CznJlRTRFD1L8>
X-ME-Received: <xmr:ghBhabYLeb586IaEsEM3iL9pQD7p05riM9H5w1B1HwGOM5qy364mI0dYEDm_TY0owYic_59WLJfu5GY13dE8qClLebYtR7czZosfvyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgfdt
    veehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpuhhshhhkrghrkhhumh
    grrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:ghBhaYOO91LIxBAPdD5JZpNhqxHZcQ4fzFoicihC_nlFR2G-GIUICg>
    <xmx:ghBhaYaVdmWcERUhqPi6otuAM1yBvlzBZznyvNqw6vtWhDaj2Vz1cw>
    <xmx:ghBhae1b8hcY0A4DTjNPGH3FEuD38Sr5RpFqxbRVaawAg4wcmKZRCg>
    <xmx:ghBhaWclL701tyNNZPx_l1Eitagy-CHeTkLGxEalca8SVBTGnPfdsg>
    <xmx:ghBhaW6xBX3fZVe9ZAsL0w2RcqayNxkD-efBQwt-0hUbRwhtZNwtqYwx>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:28:16 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/6] doc: patch-id: spell out the git-diff-tree(1) form
Date: Fri,  9 Jan 2026 15:26:01 +0100
Message-ID: <V2_git_diff-tree_--patch.1b7@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz> <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
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

