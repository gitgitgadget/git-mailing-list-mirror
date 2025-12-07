Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9A2D73A0
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765130160; cv=none; b=L6m+g440bwO+AJMy4jRIFbZG3gdjEPBgQrWmNN3HZbVEbC0135UpELzP2eQgmofKGB63/6cma3SHKTMjfAAVTDggS07nQ7HWd4KAieTA+SJTGDENR67YVbP2Q0kTBHhtQFe6pbTVYU3NN9XBUC6nU2D5S/e9DBlxc05r1ZMewuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765130160; c=relaxed/simple;
	bh=/HjVNM9+/trRiLV4x1WZoiGS9rru5vW/u5aNE/zuaMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMwphoWFOs7BQras1+rgQ16UlVICcuwjvFJ2jVH2pFuqJkaSnaGzEJsXAOlgW4p1qpwU68AW84VTevUaDq7L6dwr0G+qsbcVfnTW+fVtTGAEYew7Lsf+xFcot750ZirJT6kA6ZzLmtfUiuNqhsAo9AKniIc0JnCAos9LmB81E/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CWlxyzl0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPQfDC30; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CWlxyzl0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPQfDC30"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CDE014001E4;
	Sun,  7 Dec 2025 12:55:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 07 Dec 2025 12:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765130157; x=
	1765216557; bh=C21P/ZDDYiuprkRv18x0o9B5nCs5MRocL5QXv8UZOco=; b=C
	Wlxyzl0gBdvzR0jatjSMR/4aVM8HtPd6lCnIel0EnYODYAtXSSKijE9hop54RnRH
	ZdhCTEHXF/bDGCxsWSVkV/c/S66kqyi0pDc1qjmZZ8QdOmu+wVJbUMGHsbmRGtIv
	Ulyu10AJcJWcjrdKl0SpVCn8KJDQbEZxNvw9dRo5a1KtN4i6YvKinrsNGuqtb/S0
	X83EpY7bnZJOBAhR9nnJ3cyjFCbtmp65PTWd0IyB9kurFUVOq4duk2zbSKOQa3BD
	2/DgceFCE7s2JPy/6Ie4h1AiZI8ahH3EcXtSQtJ6BxbG6/dvqbzWtRWm1QfMjSze
	uG2zGEBaNcqih7+2ykQzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765130157; x=1765216557; bh=C
	21P/ZDDYiuprkRv18x0o9B5nCs5MRocL5QXv8UZOco=; b=FPQfDC30W8Gh/WvUM
	yCIkFMMZW7m0bKHIW2kNnvVz1hXkqhfKISA4KMZyP17M1qsOTkwZ08yIlu9fJLSH
	dUOwGIItc0MiSCadcVOdWAEhSGokhuybsiV24zyt30DRWpxQOjI+paIW73keJwnY
	RL7hT/TTdNjggZ5BZIlUgIfXUlsafV2rFzwQ6+SlfA5vWpwAIdwOYTd64+qVY+2c
	f+D/jfPmqhge44bF27yC/akMIHPOhum1hsv+VCqHQbx04vcz9t4mA+SviDjbCYTR
	FWmoqF9xSq2DbYHmc3/KcHsh3aioEFHOLkywNLAKGM6AL7WaTUFA49+2KjnTrqlf
	0wBFA==
X-ME-Sender: <xms:rb81aR6rDrgMNJzU0KlGsofV_4Ws24Yegpipu7CWTl4wnYEGRLXRNoc>
    <xme:rb81aVy20Gpu_ZQddBJzXs1NPWxcahm9-f-CJRJjuWv69mP7XLjqVvCW9iccZheKw
    uRdKMFzUK7DEjhKzBksMiobwXLuj7WRDxH836woNQvvSTAcNKfx8w>
X-ME-Received: <xmr:rb81aQzgloa77draNDUTvJjO4zgj0igxPyd2tUn8XCVmqPUxjATbnAn_NkAhY_vCTeBbiuiErkuu06irxd8AfqeAYc7ajk3In2Q-St-U3k_3ssefUMrcwv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdev
    hefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtg
    houhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:rb81aVxXOVQl-4TRXIgFDLtvpwqoT-8SpD0APmaxeN8BjD5EDu58Pw>
    <xmx:rb81aSaXzOY00llddBPdQMHtIEicGvz9gwU5tcHM5lwtod2X6UXdNA>
    <xmx:rb81aeXY7GORbGFldJEZ6IEMkSHHJkpriwhXZwZ9w7y3M0L5FkSvjw>
    <xmx:rb81aYhfCzYHm7Y9qmqxu6QOq8U8pgSLxNSw8RtWFoIUKm8wc1EDuw>
    <xmx:rb81aZAE0OqY3pxAUTN7wBu1uCONtAdUDv5qujoqDlTyxuICjNCT4Tv5>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Dec 2025 12:55:56 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 1/3] doc: replay: mention no output on conflicts
Date: Sun,  7 Dec 2025 18:55:09 +0100
Message-ID: <no_output_on_conflict.102@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <CV_replay_conflict.101@msgid.xyz>
References: <CV_replay_conflict.101@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Some commands will produce output on stderr if there are conflicts, but
git-replay(1) is completely silent. Explicitly spell that out.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-replay.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index dcb26e8a8e8..6fbb527b9d8 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -81,6 +81,10 @@ the shape of the history being replayed.  When using `--advance`, the
 number of refs updated is always one, but for `--onto`, it can be one
 or more (rebasing multiple branches simultaneously is supported).
 
+There is no stderr output on conflicts; see the <<exit-status,EXIT
+STATUS>> section below.
+
+[[exit-status]]
 EXIT STATUS
 -----------
 
-- 
2.52.0.10.g08704017180

