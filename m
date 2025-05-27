Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0A2139D8
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380805; cv=none; b=TFFbuuuR6J9ti10TbepC+MJppYtlrODkJ1Vhj8Zj0lJL/+wf0RZSHU3j0IOB71ylZmAGXv8+eNbbEyRjySruXWizOihdd3xhVIJ1dr2AQD0QBVGuaw1V1dnF9Hh+Z6EayB4JUOrh/o44K82mkQ2DApwu/438vyI82xTkLBojxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380805; c=relaxed/simple;
	bh=0OA3metDEtvIcw0CA8Vmv5buxw4sEHxrmvYKwEx3u/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HznW0/wv733qNZeRFkHG32kXaomCK4U+X6OYNDhY1wlDh1kf5a6h7Tx2JwaN0WyCxV0gpyaVFNTGz+D8+FRgzop/WO0AD0qiW1pxqj2wVeaHK6tFRWf4+tDZZf7rVvjLtIgsXrGBsn2hyViGUD5vO608RpTeWjZx+LIPEHzTSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QHBbHnBa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ivds9nkh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QHBbHnBa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ivds9nkh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 453451140112;
	Tue, 27 May 2025 17:20:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 17:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380802;
	 x=1748467202; bh=VpVdpoVTy2XWWkiZJB5OWfDUGbcSZhb3cboz/l0lJqI=; b=
	QHBbHnBasOoJGl7CouifIYHmsKzC4w7ndY9unIMns/Aw6HIbWTV/DhKDShWtxQKe
	L0FgUGoKYi8WlS9PAwJygqNuYghmi7PlCr1OlFjxWl4JsJo2PXTEHzj+k2h22qtP
	9wuKNa5WYBD50y0rxhVSQS7oI7s0VvzQSVyvDo+k1VzaN++7zBxD9of1JkLKh6q9
	E6i9d8n5AB6z9ZL78JoezSHEBvPx/vl3KwTzMslfIbvHNTl2jFgZF5RJhItfTTfB
	MHekmpuUwdJQr+qCMmhx4cMlbVYBJNdHOxYNEbjL2ZAZ6fxtk67YTrrs5ZumX00l
	QhRxrgh2DR6sWfe+bXpUhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380802; x=
	1748467202; bh=VpVdpoVTy2XWWkiZJB5OWfDUGbcSZhb3cboz/l0lJqI=; b=i
	vds9nkhFRyAqdOG+S+R34fX5CguSvSnCHhqnDEsXDFjGOQisfF0pUjixuWMeYus+
	wf8YjsROD7C+w5yEfOGYBYdSuLiKM7eb3/FRCYfDDwhPTONHitG4J8mt0wd4TBMk
	7d6wdF+HEqvbu7WBd/erqWPiyhN77ceJtO4orOxRi6ieJyJUGfVghjiCb/oBid9m
	cp1aTMPIcSZg4sMYB+vnh+R/ofhjUgvXQ+Wei96u5LhBP3rSHnzxOtJ3lxnQ+Ll9
	DsCckxKpdx5ry+EwbcHl7d4rfnjYTIDdUlQ3PSBJ1TsP6Ib5YCi6NFYpMhtaMwPu
	Sv/NMYYyaQDBoEb/RNlcg==
X-ME-Sender: <xms:gSw2aBgBxrMzmLhPKPq3Y43qKfydAIxfMKeZCrbEkXPwfKYe0lWHPBU>
    <xme:gSw2aGAjYIq01F-y8W8djvNwelHTWtgbyxJVatbXEFrjbHGQotlXFZaqrW8LM5vgp
    EdrLX2yhY8PMBXfxw>
X-ME-Received: <xmr:gSw2aBGolx7VAMtm1loDehbU7tNMxJYwB2ydWKPygZpcc0wV7T7dwOyUve5J_zmIVdECTRovNGt6rCtLoebvUaCBeE8ivGo-X4Gnp8na7wBiC98DL0_cMpgFqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfej
    kefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhnvghtvghnghes
    ghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:gSw2aGRBITrIPRxkLx22zOBzjbKlFnXTGrOUNlOYqKn26DnBbvOoLQ>
    <xmx:giw2aOxzXN1Ey4zDWJOcFuOUWa3E8tkvdEi53asixFwwvH3o-2_HJQ>
    <xmx:giw2aM7_-VZwuH5t_o3dJMBwWMI7m8xBRPdi2UMui34bOA7tHmzAtA>
    <xmx:giw2aDyQyox3n5WA9XqGxNcU76NvJPuWVxk_6vqvL_ey1mEKd3ZusQ>
    <xmx:giw2aBU1t_hLAHIIR3eh7PAxMS8V74JA4Tq68jTJZY01EZr2BlUlBPrR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:20:00 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 2/9] doc: config: mention core.commentChar on commit.cleanup
Date: Tue, 27 May 2025 23:19:31 +0200
Message-ID: <e9cf956a824c888b7313d6a2ff5c513374b3e40e.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name> <cover.1748380390.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Mention it in parentheses since we are in a configuration context.
Refer to the default as such, not as “the” character.

Also don’t mention `#` again; just say “comment character”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/commit.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/commit.adoc b/Documentation/config/commit.adoc
index d3f4624fd27..208ae76c816 100644
--- a/Documentation/config/commit.adoc
+++ b/Documentation/config/commit.adoc
@@ -8,10 +8,11 @@ endif::git-commit[]
 	This setting overrides the default of the `--cleanup` option in
 	`git commit`. {see-git-commit} Changing the default can be useful
 	when you always want to keep lines that begin
-	with the comment character `#` in your log message, in which case you
+	with the comment character (`core.commentChar`, default `#`)
+	in your log message, in which case you
 	would do `git config commit.cleanup whitespace` (note that you will
-	have to remove the help lines that begin with `#` in the commit log
-	template yourself, if you do this).
+	have to remove the help lines that begin with the comment character
+	in the commit log template yourself, if you do this).
 
 `commit.gpgSign`::
 	A boolean to specify whether all commits should be GPG signed.
-- 
2.49.0.780.g892193c3f50

