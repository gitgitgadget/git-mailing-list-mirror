Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BC27CB2C
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763902; cv=none; b=idGBvPWD2cNQyMGLKQ5uy+tJG1aKyHywwXzH3qIXReZiT17y5m5THf346dzDwtPUywcXdjmo09GFmtUvSAZFpU2bi4s6ntwBwsA4qylqzEVHooaiO3SULNrR9F8ZG++sHq8HzILebX8g4hA6c4S3wQA3rwnPTpBO290APlLQ08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763902; c=relaxed/simple;
	bh=2udQ4TGi+t7V14IAE6+Yk+sZ/EykrMfirfjlDrZE3Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efco3hI7fYRARoTh62saHbkpssudyD9T7CSI7jU6vX139WmcTyHEeTLEgtI79ekwPyDceJDUTQDmShQVyLebZSh2D4pN4+DIdrLHbiXXS0Yifn6SqDrRZhOv9OKR+SCEGeGuwOdy/12gFtwFilWksNCoV+zDT0ciZy2fQ+NGpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=S8FY1L9U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F/9g0fEl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="S8FY1L9U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F/9g0fEl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EA081140148;
	Tue, 20 May 2025 13:58:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 May 2025 13:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747763898; x=
	1747850298; bh=IrQroOxjKeZ2Il8iVqfBgG+exxNewfmtJKDiwzLPzIs=; b=S
	8FY1L9UxNz9SvFLaqnT3w+rVWyzDJn2ZZPc69v2Y9aa2Br/Fyks1gXVPPJeoRepW
	s3/bVtBVmgc/omXbtHjKjGFcywFcskilbeqc83Gwjh9b8wJRxm4vALpY2PKaLadh
	FBmgLZmuGtgniof29H18EVkJHvS6tkEpcDNuYPCHfpXQYu4LZQG89vN7mv86c/WJ
	Anot0qLanMjLI82DxuQxrA2YCRrNRROs4mF9loMDjeZ7ahV+ybHL8qJVXikHJofd
	rmsKOZJliWI8Z/Qh2kPgngKUgFU1KF9Y34f2RR+TR/vwKnOZVhzZR08w6/CwrHWX
	D482b9gZTabLxM91Kc+tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747763898; x=1747850298; bh=I
	rQroOxjKeZ2Il8iVqfBgG+exxNewfmtJKDiwzLPzIs=; b=F/9g0fElmvPa/vLsW
	eTDFVmIh/irAv2aJWjcacsFA7Nd841GkouWgvaI9l9ueLIETRsoam0pYtr/mYZbG
	cnqOYZ2211ojSaktqHLaz3Kej6W5uJU8C3LkqKFsTUO9+fCfQ+3h3CZ5pDfaLiGd
	+OY/0B2ldHPGxbZlaLXxOY1lLbuEslgP1RQ5F4HDKMoGOhfhOBiLRUhYG9QIbpNV
	kjrLXpNVVLo7kgzN+R9dZfZZV3Wqaz6Je4BehDnDG9RZ94VqchGiZHCa3/L/yBqo
	p3IX/WmWxNsBgzFLE/f6i3KHODxu5SYaqW5xT/VCuK8NX9rKPjN3waPWt46cZa/0
	k8L6A==
X-ME-Sender: <xms:usIsaEi4f09QFKhBVjnnf6kKgI1S6XZsOELRmsMwJQGQXIgxnOmRD9k>
    <xme:usIsaNBCSDOnUVDFaLTwqZnINYmlcTyZmevhASmPWrGrrjEAARJ2TAUEKe0LB_cqk
    bDzObAE_CpJz8Nt-g>
X-ME-Received: <xmr:usIsaMGq67A6k2v6wtjAI5pgndvarx84XFuPWPhjwO1LAXep8og5WKn-N_3eSfASLLBHHWCcl1zadGMv-33o0mvNT_rnDfkkjZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekjeculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrf
    grthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdevhefhveffuefftdeh
    iedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgs
    rghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopeguhihrohhnvghtvghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:usIsaFSGkBzavlKqo_wkcjq6pQUDhH-ZI9XbRnFJBCMwwZoAzktqLg>
    <xmx:usIsaBxu7Ou8p-aX7ESPkU4WDrDe3y16OSiCE7BlPHoaQAMg-j8SyQ>
    <xmx:usIsaD6mTil9pP4z_FaUbD6s5JD1ndZCv-3Xb_a_BGJ2qEvqh-FDiA>
    <xmx:usIsaOwNnrd7zoxlPgXOY5Pe_WY1pJBXAiPMVtxs-p_yaqpFtu6Wkw>
    <xmx:usIsaCoHUv8vUrZZnXNK7cG66qYjygJDrPaexvS85Xjbm05LrH2BOfRt>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:58:16 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 4/6] doc: notes: mention comment character configuration
Date: Tue, 20 May 2025 19:57:22 +0200
Message-ID: <f3f54a3537f71d8d4e3755d93ce58cf6472a2b7a.1747763769.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1747763769.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name>
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
 Documentation/git-notes.adoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 8706b33f2ee..1b714eb9e81 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -186,9 +186,12 @@ OPTIONS
 `--no-stripspace`::
 	Strip leading and trailing whitespace from the note message.
 	Also strip out empty lines other than a single line between
-	paragraphs. Lines starting with `#` will be stripped out
+	paragraphs. Lines starting with the comment character
+	(default `#`) will be stripped out
 	in non-editor cases like `-m`, `-F` and `-C`, but not in
 	editor case like `git notes edit`, `-c`, etc.
++
+See `core.commentChar` in linkgit:git-config[1].
 
 `--ref <ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
-- 
2.49.0.780.g892193c3f50

