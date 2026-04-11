Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C040DFC5
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775938563; cv=none; b=DPzz9pbUWZU/j5SftQNoNTf/LqEcULQV1YeQ90yobqakXMpPngnbOXZ5hGqZp8F8dmF60ZjdLdLYnw2H6/1/kUK1oOki+knEwPJZqHXOv95dhD7g/sjFiu+QkB32GU57GgAmRDakKjZOT+rvVjMRbuJonpyeMEWc26ELE63Q+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775938563; c=relaxed/simple;
	bh=67XrlGDxI9P3zT1puG7ATKYsMYq4Az4tnoXbjmJHj+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7AqP7kW6RTKf5paC8UD20/la5QTxOjFWN+I0nw1r5QwThI/5IvMhXBW3vkjKRbdGm+NMmFzlrUytNe5JlnwwaRiZnfne3rA/pjqIRyXYnGsWfymyNARpW2nBhoCgHCW0Fgz+mbxOROb3CBl2G6EtNYmjSOicDj6J2OKy4qtxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GmOxOS7u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sNvjQGez; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GmOxOS7u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sNvjQGez"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EE13140006E;
	Sat, 11 Apr 2026 16:16:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 11 Apr 2026 16:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1775938560; x=1776024960; bh=3k
	tbqpX0wcgOydABCs83Y3ux04F1463geca+TY7gqPo=; b=GmOxOS7utECibjSd7V
	phFJ/Qj2K6xo1UH3/Pn1EYfhMvuUONAgr7tOQnTIL4bp0wYA8/DxKCQ61BmrzxT8
	Y4pI75pe3HN01ectumG6AXvoiCUdziqK2IR4/5sjynOX54bW7CKDw+2l3x0cCDSn
	Ji/KksPGxJlQ+MTelppba3Ny5yTjXXvAF0QPcVAWc1cQ+z9N4TKFwBIt0vNtB5m+
	zLiny71NhB0lHpF/uMMb2i71mzV77fe5qFmH+iUkLapn9qeoermj2948wGhHqzyP
	GkvWnHSMO1z7akMbFpjgj3IRl8pPLlKV0WOKvtplTvG4kCLVgcuiCR4BVpAQf2I2
	DyiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775938560; x=1776024960; bh=3ktbqpX0wcgOydABCs83Y3ux04F1
	463geca+TY7gqPo=; b=sNvjQGezBqOlRAlR1YXtKI+Y2W8e3nTllipo0m4H3DRh
	KJib+hJk2KtViizLBpmsC4degxlFXa+akC96eSeLNf8LqY13yi+cMfFBA/wpNcaL
	vget7rXAz5jhXKRx/Jcn+DyNFDM+Rzd/HgFgIFpOy965yo1uYkDcZpqzd6Sb6HZR
	PCd5iGZKtH9HCBbjjDmy2l6tB3nUgTN6MVirFMEzfqDKb9hZQ1pPmE/P+aTc1ind
	vueqYEgpeZj8XP/IZt6/EalQQqDYs5wkcYfercDIvS5NMbC1dSsY+rkSyoXjhLK4
	6ojbCRkRc1BXZ8XgT+tcCVUAcxxaO9KOg/JsukLa/w==
X-ME-Sender: <xms:_6vaaaTS79KhhBmQIPAPzTGC4Q6kh7IMyY4-c26l5iFYE5R-86vwJ5I>
    <xme:_6vaaVynH4eEdV57QvqsEHDAgUtby68ClqZKDZDraB5AX3g7vbp6KAmAboiJVL-q0
    h_J3CSLPZV9_XgHD_xlKDlYgg-FFoDEz6nABLHRhiE-zJ6jBkQ5YQ>
X-ME-Received: <xmr:_6vaaVfg7z2WN3gm9OmsDAMOiDL-04p1QNfLQ680CDLxfip-Fc7PEfkHQP3a73JULV2XcHxRcnZWVp-BWuIxVfdgF-A5iK1IJTbGzMj1i_eH0RjfhWrqdVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeetgfekjeffud
    effeffgeekvefgvedvgeffueejjeelgeduhfdtffeikeelfefhgfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:_6vaaRL4vkzX38XpZe0RzXpkKJ8krTuoch0dk3Rhx7KnNlpgQEw9EQ>
    <xmx:_6vaaWFJjnb9N5p_tDQwb6ZQXbbKl9AloFXTw6xaCZyDOQPlay0liQ>
    <xmx:_6vaabpPhrFS9qI90YV59824TDJGgX4oQkClZDcSLgdId2BIouPTAA>
    <xmx:_6vaafTA3ejmHwD1BRVPyzGYuhklxH7x38J7DXbMbovDN_nhPhm2jQ>
    <xmx:AKzaadoCdxd3ZxKq-GF_Gn1SJB2r-nESj-QzLEOBex7Dp3KuLFC2Iy0F>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 16:15:58 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: am: revert Message-ID trailer claim
Date: Sat, 11 Apr 2026 22:15:50 +0200
Message-ID: <msg-id_is_not_trailer.570@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I claimed in 3c18135b (doc: am: say that --message-id adds a trailer,
2026-02-09) that `git am --message-id` adds a Git trailer. But that
isn’t the case; for the case of a commit message with a subject, body,
and no trailer block:

    <subject>

    <paragrah>

It just appends the line right after `paragraph`:

    <subject>

    <paragraph>
    Message-ID: <message-id_trailer.323@msgid.xyz>

It does work for two other cases though, namely subject-only and with an
existing trailer block.

This is at best an inconsistency and arguably a bug, but we’re at the
trailing end of the release cycle now. So reverting the doc is safer
than making msg-id act as a trailer, for now.

Revert this hunk from commit 3c18135b except the only useful
change (“Also use inline-verbatim for `Message-ID`”).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: kh/doc-am-message-id-not-trailer
    
    Topic summary: Revert claim that `git am --message-id` adds the msg-id
    header as a trailer.
    
    This is based on topic kh/doc-am-xref which was merged to `master` in
    05c4af5c (Merge branch 'kh/doc-am-xref', 2026-03-02).

 Documentation/git-am.adoc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 403181baa9f..14f83a8920a 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -84,11 +84,10 @@ OPTIONS
 
 -m::
 --message-id::
-	Pass the `-m` flag to linkgit:git-mailinfo[1], so that the
-	`Message-ID` header is added as a trailer (see
-	linkgit:git-interpret-trailers[1]).  The `am.messageid`
-	configuration variable can be used to specify the default
-	behaviour.
+	Pass the `-m` flag to linkgit:git-mailinfo[1],
+	so that the `Message-ID` header is added to the commit message.
+	The `am.messageid` configuration variable can be used to specify
+	the default behaviour.
 
 --no-message-id::
 	Do not add the Message-ID header to the commit message.

base-commit: b10e0cb1f391a4466f8d7c4b2550a8b89fda3573
-- 
2.53.0.32.gf6228eaf9cc

