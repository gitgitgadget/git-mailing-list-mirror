Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5926A1CC
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763904; cv=none; b=GVKeyzm9iaXJ0D2OK76y6zqQ68LZEpHvBYFWWrQdxqNwSdjd+pwCLJoo4rJFG2rqxjn6QhrKbbwStm+p5iS1oNRtJRL7Q3bzTxRnfP5ZtJptW/Vsh+vSESIW1E9SvPepvQYtXvxzzWp6Vk2hVceYUf5eMzVUPisGMI4nDAF1Vwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763904; c=relaxed/simple;
	bh=+gw2TPf6iw6C2RzFQaKN07HOtFck+Txah/PpZ3vo17g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eoe2hc/J8yperfAeEMiZSOMCdHmD+mqYfUeliXc/ZWoJIPiM1Salgc9/VY6MbiHGNMQpVFtIwAxyl/rcqDA/u3H37P8RZ6LNPUcXMvf7v3zcCz0DhZHXnmd5SrUHkwHCameQfU+MOxAy3UbEQmnmFPienpJHIKXPpAolWtKKTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RX1fKlUn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SCW97Ltd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RX1fKlUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SCW97Ltd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F2B511400F2;
	Tue, 20 May 2025 13:58:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 May 2025 13:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747763901; x=
	1747850301; bh=mtmNmJ0yscILas2CM0M7A5UiwR8QDlEwlaYyFLgJOkw=; b=R
	X1fKlUn8GLILUxyK2IU6V0DFLGCgDMgkAtUTYozqwbn/lnDwRF7Q/GiOFKDCdqwm
	SrHs9J6o5zp/genUQAFEolW0SILnabZwFtsuOquuoRn9++Iy+BpOi1piLVWdPvfz
	HDE7f0fP4b4SzQKtTJiFxq++Dss8/zsoL+/qwgzO6N+yifr+NeFqQWPZsNF0Ktyd
	kO7Wh+NuDq7rS7LtvCX617JqlsQ1WEMo7ycgiJ6/kSKcfyalfmRIj9QCzFz05nmr
	xT2IeT2dMI9W1b5dMTGWgCyDsZFEIGy43C/bQ5jcFmDbfEBtFchq7W7J57rpnaTp
	+ZP1SJ8OfeyZasemf2Gyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747763901; x=1747850301; bh=m
	tmNmJ0yscILas2CM0M7A5UiwR8QDlEwlaYyFLgJOkw=; b=SCW97LtdCVPFfliEm
	7eXUYFhvWzCZ01+D2c+ReNlNQglyMX6ctIs13RW/KSiMpOsXx+dYGUqzbWY6qOhy
	KaLtFvpO5Dch9Qa1x8SNezz0hy2KqKrEfwYWAUyegQhnOUsD8sHg9TfNP9Oimso1
	DIFW7PjfdVsmgK/FcPgrL05lzDE5Pf8tt+7lv1l1lzMZeSEvkcBOj/8xCxBxRmZ8
	8Dv0FWSHOqYUKh+sxW7is0SdguFTJA1+cOCrSjNN95ZQg+3vLy9uWooTULs+HtGm
	a9Qos43h8BC4PAifRE11AwPGSKDAMbHUTvUoFgr1OqloFvM6WZaW3rBHp8Y41rWq
	j9hEQ==
X-ME-Sender: <xms:vcIsaCzeydC3xr3uEL54qPE_LnGlRs9aMCtR3iyOHkigNy8q6Zn98hA>
    <xme:vcIsaOQ8FYS-Nliir2Q6VAuo3eMc6dd-MnVf8RKJhKBfYlG1Ha51KWFyiEBrR8Jfd
    4SWnXRiSl4EHv-6-g>
X-ME-Received: <xmr:vcIsaEUdUCMaTy7UGSG4griV1JYLvnXYsQAflj72OKGQjNHvyMAWwoBfjd8TG0cQsIq686tUydS5T4iWQwY58gph4bAI15p2UU8>
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
X-ME-Proxy: <xmx:vcIsaIjg5xmtuwDji3Z1gSjkrlE-soxdHrDTjpv6lIMfzPKKI0kGyw>
    <xmx:vcIsaECOGIW7ZyVWOsW9FQkLIzi3MS0txquaQUtLXosEMIX2NfdPRA>
    <xmx:vcIsaJKtKN8P55fYeZwhDwkuBaby0nGE8JMsfzwgCPRBOvu3XczhNw>
    <xmx:vcIsaLCkeKGoFSClNVKnF5efHC6OrTYnKxJEnuF-nTIyvrUItxPFkA>
    <xmx:vcIsaC4zOO11arEsRITj_eGHevyteej7J1mI8JznRuqMq27OEzxT0M9l>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:58:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 5/6] doc: notes: point out copy --stdin use with argv
Date: Tue, 20 May 2025 19:57:23 +0200
Message-ID: <cbb177479cae24b85284d507beff4b7abe173dc8.1747763769.git.code@khaugsbakk.name>
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

Unlike `remove --stdin`, this option cannot be combined with object
names given via the command line.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-notes.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 1b714eb9e81..d2d7dac8d41 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -87,6 +87,9 @@ In `--stdin` mode, take lines in the format
 on standard input, and copy the notes from each _<from-object>_ to its
 corresponding _<to-object>_.  (The optional _<rest>_ is ignored so that
 the command can read the input given to the `post-rewrite` hook.)
++
+`--stdin` cannot be combined with object names given on the command
+line.
 
 `append`::
 	Append new message(s) given by `-m` or `-F` options to an
-- 
2.49.0.780.g892193c3f50

