Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406F26A1CC
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763898; cv=none; b=L1rvVyYq8QBYThqzsNvp911a+W820K39iuzkmvvP6tTrTZqttTsLPqhnI05lYbxEVr9qAzcI7NWUTP6dyfU4qgpurOKqyZDp/Sj0UvKFLGFJ+V2fBnzDpNOcZ8PUWhDvYnTq9iUJ/E/mGR9qRwkF7zi04Ms7GSsPPO5IPRG9WKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763898; c=relaxed/simple;
	bh=+UL1uhwyKF1ItQ2U72FLEEKrIv7xafd6TPBnlM8fSHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0mm5izS5CYwiy6hlMsQHBQg+bQAd+CDfP24vh8K7JpLzYEltpscHFlsgXA29t9usJWTObb+PyUKL0uWYldmowuw6ajNoKBVgU+xO6AvCQHFbZXYBsTUGrG8lPhI6HHl3AanTgvyklaY4+YfepJTlmbYYZ7mytkdnj78X2fu81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=yTbe4gBC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPMNfxwL; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="yTbe4gBC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPMNfxwL"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 09D181380421;
	Tue, 20 May 2025 13:58:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 20 May 2025 13:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747763895; x=
	1747850295; bh=7+i9KOzG9ReeocCrAmxvqpIMMztQFjPV3kk5Nj6E9wY=; b=y
	Tbe4gBCt6OA6WpcoFEUn/hDMopX4MJlC9/CIyXrtUQhzCv5rR3UoB0vg3NdRdHBF
	J52MF8ri0/RySB48dqhZaRLROLIg0QA0T5Yb8to6UG0UayPyoNr35kxrgYGVFbwb
	dWKDF8MJAXni92g84XRZvYya621pDppsahe4CN0l7WHJAUGdmd2RmCsF8nz628c9
	FwYRdDptxjuzWaGDZeHPRx2DtOZapHSy7JugftSkHo4R99uzawHdQ2eCBD2SM/aI
	dJoJbLcQM9eTm6l8Go+AZhVFBEZKkQxEe2z1Vrujh3DltbOPvzKiH4fGwrXq2+ow
	upLeDa1pnF/BmRtFy8kMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747763895; x=1747850295; bh=7
	+i9KOzG9ReeocCrAmxvqpIMMztQFjPV3kk5Nj6E9wY=; b=UPMNfxwLhgeG9/3JN
	dhUelmrwzBR06ieG2gRNyEP2EkROSrcLtll26oGCO+uUJ4fEkY8jmaSNdWIsP0S3
	AV0Unx566eD0/ib/BI1EZ9G+jIq4IxHbGS7rH57oLl98p9vwqhh3UXcLVKQEJr7T
	TEwMzFxNWuLXCbv7UIgvT11MVwMSrtq89pz3fHoMiGZl0ZgZdUHH0TP9aQSWIdMF
	DFUKY5SEzIdwIWQs3A93L3V4qqD0xoJY93gGw5NLpmcLh663H6wf2Qfag/EdH7tS
	b8eSGG4Ye4Clbq/Bh8cZYzI3G/4Dv3BCq8KOOuvIRWNcY0PCY5/u4xV/OyMItegW
	enN2g==
X-ME-Sender: <xms:tsIsaGDEojXNIj1Tcmhw4e2ksZKFFUjcEcrMVhx9577vNKKcFR3hWWM>
    <xme:tsIsaAj5MaMcYo_eHdRnySi8UJQy3PfL19G9Opzo09X5YOS_vgFp8MKgiOavA625s
    7QliabSRRwWFc8sMg>
X-ME-Received: <xmr:tsIsaJmQxNzq5qekmNoUS09plvFGk7ip69064ZmHCOn0axJT4xWPFBH31xlYnBENAtFgM8p55m3Ppv5vMEtWsLxAqvmxU0gqCU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekjeculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrf
    grthhtvghrnhepvdfgteeiffefjefgiefgudekjeeluedttdegieelgeeileegvdekteej
    heejkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepugihrhhonhgvthgvnhhgsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:tsIsaExzitkuPoFjCmCsccRFVqj-U-eyzzUD6j_lAKhoRqzSUSFsJg>
    <xmx:tsIsaLQj3XG0KqAehDN501GsXs_Zl0ZUCBqGuerXjor7kh9P38A3Ew>
    <xmx:tsIsaPaHEqzu39_mOuJMaAH6Hmy9lOBWWVdClWnkct6WHZMEjq8OCQ>
    <xmx:tsIsaER5cAd89gIG3vESCj9MDXxidlRZWFGl080XrbtUlIappOhySA>
    <xmx:t8IsaAJOa_D5xsOYjNn9jH4WkMgeO5qD6AP1zxzNZXfiNsszFnMAqzyc>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:58:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 3/6] doc: notes: split out options with negations
Date: Tue, 20 May 2025 19:57:21 +0200
Message-ID: <d2b6864b7072faa2c804c98ce7758b666e11f00b.1747763769.git.code@khaugsbakk.name>
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

Split these out so that they are easier to search for.[1]

[1]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-notes.adoc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index bcfe3dacd3f..8706b33f2ee 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -174,14 +174,16 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
-`--[no-]separator`::
 `--separator=<paragraph-break>`::
+`--separator`::
+`--no-separator`::
 	Specify a string used as a custom inter-paragraph separator
 	(a newline is added at the end as needed). If `--no-separator`, no
 	separators will be added between paragraphs.  Defaults to a blank
 	line.
 
-`--[no-]stripspace`::
+`--stripspace`::
+`--no-stripspace`::
 	Strip leading and trailing whitespace from the note message.
 	Also strip out empty lines other than a single line between
 	paragraphs. Lines starting with `#` will be stripped out
-- 
2.49.0.780.g892193c3f50

