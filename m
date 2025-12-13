Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7E219A8E
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765633662; cv=none; b=ZqhV/9zfQCe+RHEa4T2TZL7KMxUal7+OdSwmc3IKDd4kyin2fhl73rz1B6F5D4nlc+Xke2+LgiZGsqS76IIzGXEHjtsWlYA3jHAzYq9Nr9O1nAM2lbQMYXt5gKtHc5KRNJjVGd15LEuFG78R8tNo81bGM9mkSXrtHCOb4hRNAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765633662; c=relaxed/simple;
	bh=/HjVNM9+/trRiLV4x1WZoiGS9rru5vW/u5aNE/zuaMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5b2kxfOh+q0IYxycfjxuG5HCS7itlyECF7TX1s1FnBvxO2WgavZL/8lQTf9zmDA5jNurwpsYunLmR9avFzgV3os7P8mAb7yp+XLZUc0fIahKV1U51NqXXHGqDijqj/5W1KFYVk7nXqsaM0VBZqzmIksqM44kGZDDVWRnUMo9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TCY0gEu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LU4TESIX; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TCY0gEu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LU4TESIX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AC481D0008B;
	Sat, 13 Dec 2025 08:47:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 13 Dec 2025 08:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765633660; x=
	1765720060; bh=C21P/ZDDYiuprkRv18x0o9B5nCs5MRocL5QXv8UZOco=; b=T
	CY0gEu7YfBljPkesPcjxbx2Euuh4F+03VY9AsWzipMxdwyZbPoDIjXGBdkoeelOv
	DI7m6BS1/QSHo9J7mAL3QQg6QlZHGZSSnBTx9zCzqBc00DD49QoNWzIGaNub4i4I
	yJlDJQQ9D51c+abuHjXuf5r8wSGhYKFAz4Jh8YeojXAZGl+xVJsMV4eXEl6UfEyu
	ZaNuYPwEogE+8xnT5l00QP4TO48/gy1yillEV2tUTbtZ3EzGBQp99iUxiOfrFhXh
	72MXv9wL9uuyt3qbm6IW5KdPR0jtPa99SCqCVkUD5QocuarQq4SR27iZrRVBUzgB
	s85H/9FF//abYvhoqtDmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765633660; x=1765720060; bh=C
	21P/ZDDYiuprkRv18x0o9B5nCs5MRocL5QXv8UZOco=; b=LU4TESIXxLZ9zaFK5
	DtxNe2mnY37OdfsusJkLU8deuesiEIXoUWjI5OkpsYyaUiSXC6Jdc3MNHa2oZ8EX
	sc9dpQEk4Yvsbn0P6qDI4CRQEYTnfVLyX8i9BJ6M3dqaTtt+jqePOQJFV2rNoeWO
	VRwwJUp0tVRsRhvjfhrvXCgNYSQ9DHFYf8mqrUN16OO8Vxsbdl4BZOoQgpygZOFP
	KD4n4nyWU4SCcOX8t8Rlf0JMcnJHKyL3rRSUEVytUxFrXmksdfF/KoXNTNrXdrU9
	fJEqPQ9O9mjkSEWeMxF88zHKuSWtOmKmb97vS2pYw+SJ/x+KjAhZAq+crIQS8RvL
	iK4jw==
X-ME-Sender: <xms:e249aRFZBqsfZaWRvXLeTRsK-j2Pkb4vmXanx-xH84qoJG8BLAjjbgQ>
    <xme:e249aXCgFO6a6lIppbWjiRSlTaRnatRYQBQ7gHE4QfRZZXUEW0PV93cuMAcEkURgy
    m7hgU7loXb6M7_3wj6vKMRMTKmn0Wg4hnjgD4HnYbwSNiHMF_ohTA>
X-ME-Received: <xmr:e249aRXE4TUZ38UkbFHQ5Vtd6uUYdbXOcWfR6LLXLwLxOFIJhaqqtDxZyUzD7LtK9LOu-qTr07QDPT78LO2G6RB-QoFVHMFicem6uW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdev
    hefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghouggvsehk
    hhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:e249abq69BJoZzMgTgtt3mfH-0Zv3ndB3aanFf0cGcpYERhgzS-tPg>
    <xmx:e249adT4SNXPihuNxeToK-WCJaYv92mM35ZlAsswbJoRQ2uH5MBvEg>
    <xmx:e249aV1leSkSAVd18wjDR3KznQ0hPNPufl5KIrMQMZi7_pG327brcQ>
    <xmx:e249aZB0CmVX9ghikmDetPpIIqvlyNxPxzHKs6ESpXw33A9EBG-HZw>
    <xmx:fG49aRQd9ULMZJPL9471FC8fxERScs_5aiXIfrWuUOAz6SsV0-gXJ2hM>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Dec 2025 08:47:38 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 1/3] doc: replay: mention no output on conflicts
Date: Sat, 13 Dec 2025 14:46:56 +0100
Message-ID: <V2_no_output_on_conflict.130@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <V2_CV_replay_conflict.12f@msgid.xyz>
References: <CV_replay_conflict.101@msgid.xyz> <V2_CV_replay_conflict.12f@msgid.xyz>
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

