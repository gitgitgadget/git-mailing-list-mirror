Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E453603F7
	for <git@vger.kernel.org>; Thu, 21 May 2026 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386590; cv=none; b=aPuGQdaSoRXNs02m+HyFpI7wPpm29L3IXQgwoAb0Uj8Xq3KU7Msqj8ctU2a5f9Ha3Ed0kJUurewoKgEA3g07esHhy9jCWfMxgTaNKOJEZyZG/FeXTIabJwBEno52EiRjenTZcVxKyV6rxDroZi+hXUjJw8TnBhjPIkGDkXfTm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386590; c=relaxed/simple;
	bh=80c3qCAznjofzR230ueBE3sumJVNlGGlOQ0j5zAcB4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNgYo7tBFiWXSNJEvZP9udfKmyEaD/n//LlRxOEmXYafF+GrK1xTtwvfv4nh8h8ILw9vCCJBDFlQhIpJq5ls3RKHLPsjpKYY6zBIqwzIMaWTviTUhSYJGAxWZDoJ8TIGvY8k0hgpScs6QFFzNNlyrLVdcoFw3zT5k/tpq2fq7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=e5K/x86d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dDIZh/49; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="e5K/x86d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dDIZh/49"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B7481D00089;
	Thu, 21 May 2026 14:03:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 21 May 2026 14:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779386588;
	 x=1779472988; bh=2dve/nTJzDUrVpIuiqjdquZ/yiLBHWRJShiB9eqSlaA=; b=
	e5K/x86dm62j6WiWp2Bb+HZocn5oJXQf6iTTFMhFBEBPu54wLr+4+0RoJFVVvseS
	Ze5U2M/KD06X+Iw8tOm8Ii1EZSU+RSdXVyLR06su+AVR/6tGTrUdkFIH3gVxjAKC
	un+p1yfW602lMOsuEj3N7ZDWJ+ODeJ2+fjiudF64ePC3PhE3pLZb46kvLhC7GYXh
	f2ZT0cP2mbuY3/3p1p2d3kCv8FdWOhxiUdZ/WuYn4mdNdDnt/6GEuGcVt9WLI3Zb
	2GaY3A3uSGnDGy3niBSslqYZEmHsOIw6HmnbJbdvpDQDtVmssBBmKq9ekbrkNK3N
	qvYzRSC2iXv/kVvBnFmFAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779386588; x=
	1779472988; bh=2dve/nTJzDUrVpIuiqjdquZ/yiLBHWRJShiB9eqSlaA=; b=d
	DIZh/49dEJGE3E3U9+SgC2+9Zcy8zfASw799+7yemJ5Yzye03pGk434zEWnXff48
	OigNOPubJKBG3ivwqTeT6P2d1JUKLOy+H7qHZ6QqHVo0F7lNSFdiSNRruSv2bkwE
	c/lldQfUk5sRRyam/KhgcPh0/aNSevfagbHUn1XFSQuK70P8SqKT+i9ZnxihcRLt
	0dKqZ012DraxSfgg0RZmRpr874U1djv0sovXQrmVi5f28w32ScWD8HcWCVIbzz+R
	JUbfUHc9m7G0D2EXp/9elIZsSnsh+GbdLLRCBE5xgh1RsLEfN7mL0OMs8merGK/j
	en/NnEC6DS8v2IGdtgf5A==
X-ME-Sender: <xms:3EgPaha7cIGfbJW7ZEdGz43Egk6kpCcocnRyBXZLJZsFqOnc6KJUpqA>
    <xme:3EgPav1jL6Ps3kMnlrO_J_xD2Snqyutw0KfrhL2SxytA-ENREuaOwwb6vuaL2zMtw
    JISzwqvRnbSubHPrdBJqvSHLrMPd046fvOV1G6fIaJj8ct0TUTZ>
X-ME-Received: <xmr:3EgPahXpvNZW987SjhFd937JVOf2pn7YQXwYF597LIGWCfVbx0OqiZTI1fAs1zaW_Vp0V01qeGTjirDut6ZtuqkNmWJnWDmxxHeqOQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhiugguhhgrrhhthh
    grshhthhgrnhgrfedusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3EgPapWf_iXFvUoaluREKEon4nGpJegl1-MbZ6ScsA4YjWLieE_YEw>
    <xmx:3EgPagdMh64NnL5LWj3SqrHRtgpuLfau2tOtjkC9MQaj-gz8dIwbmA>
    <xmx:3EgPaiUq7xD-0cwvA_nCy8hRofBafOMMs1F88ZmML3nWwROPg55fuA>
    <xmx:3EgPapc5oXNWXvwpj74EdHD2paqLZZi92g5SGgBIHIpFJgKqzlGyAw>
    <xmx:3EgPan0M5sjksJGC3Hr7zA-dbahAreh45u1pYYLlPcCo0pj4ZX0oFpNm>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 14:03:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 3/4] doc: replay: use a nested definition list
Date: Thu, 21 May 2026 20:02:00 +0200
Message-ID: <--ref-action_definition_list.70c@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_replay_config.709@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This bullet list for `--ref-action` introduces a term with a colon.
This is exactly what a definition list is, structurally. Let’s be
sylistically consistent and use the definition list markup construct.

We can reuse the `::` delimiter since we use an open block.
But for consistency use the typical nested definition list
delimiter, namely `;;`.

Also drop the harmless but unneeded indentation.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-replay.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 4de85088d6c..b4fe43ec687 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -80,10 +80,10 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Control how references are updated. The mode can be:
 +
 --
-	* `update` (default): Update refs directly using an atomic transaction.
-	  All refs are updated or none are (all-or-nothing behavior).
-	* `print`: Output update-ref commands for pipeline use. This is the
-	  traditional behavior where output can be piped to `git update-ref --stdin`.
+`update` (default);; Update refs directly using an atomic transaction.
+	All refs are updated or none are (all-or-nothing behavior).
+`print`;; Output update-ref commands for pipeline use. This is the
+	traditional behavior where output can be piped to `git update-ref --stdin`.
 --
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
-- 
2.54.0.13.g9c7419e39f8

