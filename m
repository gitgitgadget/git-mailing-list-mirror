Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196591917E8
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729368035; cv=none; b=a+oXZ0yQaDRt/dPtH5AeAgKY9qtZti1ZNteblgBfD138OzLGukxrikhOorYAWoIqcI76flg49micX9H8S1Um53f03NXxotjDfLF4/vANHN7RLt53/PnEMiEuhESJ5HTIOJ21lF041U5MBe0Soy991KIGin0Q1aaQ1ae3avEKhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729368035; c=relaxed/simple;
	bh=uBt/QdSebGuCEXMGFRSOx4oqk6Mj+tzyTT4GQ+dnfeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCAn3PJGyNh3cbdllE/T+JtUUy2NIPHKiKhUrymRmsUgt00uVCN8KRT+xyVP4TQdxc//gB6yQWiYhv0suV3FyAV87/Qmw+BugCiuiX+wJeAEFpDnMil1e4jpi89jnPleevWpb4zINyy+FdWvsk5d54ka0NglmckwM3TelcXLAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XmTt5mIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cSiClN0S; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XmTt5mIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cSiClN0S"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 299061140092;
	Sat, 19 Oct 2024 16:00:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 19 Oct 2024 16:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729368032;
	 x=1729454432; bh=Xei2KAtErhqQBZ8MQRHooWSLLxdUUUf2Z0PKPL3GZJg=; b=
	XmTt5mIyxMi1z5zAxXduHont4jsqa+cZwBG8qXa8tpWVG9D90MS7saY5PcKI31bm
	pAtSUhkCciv23T0FeBuyY1v6ZcRhP9lTlxmNCfglP2VcnUvO1IGShQYMGJXzum4T
	Yys400WQI6OKDGSv6hO9bueHTvJNWI9bH4f8NZ7GSu9dXWR5tKTjDGjbJAJ2qpiK
	f2Nh92Kpwtd0s4lKr41URv6oVj6Ga35zboxTX6lG6O1b6HzIIwBRVHaG1ZbxcC1m
	jZwlXFSpNU9wdCz9EHeY16Q6nKlmmdz2AUKU4GjdQrn/PoqqnTJrA8Ms4ExJRUBE
	qDT1QbZE+RqVCSlx7rGVPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729368032; x=
	1729454432; bh=Xei2KAtErhqQBZ8MQRHooWSLLxdUUUf2Z0PKPL3GZJg=; b=c
	SiClN0SdRzORQLkMsM3qun1l/KfqpTPzsI8RzRQNxf720QImkkY/sR295XFBSGzf
	qUN0OHyPKc/1RDT05kuco9YN1+EwJm+JccmiybUaE0539zmziUsphJIUvKjB25zL
	O9hdnoYwJAcaYXLozULdpMUE6ZjL76/hP6u6dA/UhnUcs4+WkHyZGtcB5VKyDczw
	QdzDbxpAQpwJVK+iYqOjpnokIyEsMtdCNBNcuMKumAeLTWeDCPKwGnTJoZk0ut8r
	+r0WZl9Y2spZRzBKCV+6QjJE3dtjPphzRmku58GL7U1nvvxXXpeh9vBov2AowPvA
	PQwK4LnRtm2lYpzz6cuQw==
X-ME-Sender: <xms:3w8UZ9M7nbA_3tsXOge5kknJQ3uf8y2hokvvcI0f776ryAEuuvQiWt0>
    <xme:3w8UZ_8mLN_kGJFPg9gP1M5qm7SqXlN_QIStr2lzZ_qMa-BIn1XTnTJI2i4gwcxrH
    qvlKanV9w5jGhfHvQ>
X-ME-Received: <xmr:3w8UZ8QMSr2jnztvBcRCI9GTlYjEApG7g0A2Fjn3lthEG6_8FwHlnLKvvGz0pr7HDQ_c3-XCBL6fBAzVn6_ZDCt9V-I4SHBtrp5pvdhQhrG_uNCL57DmPyBVgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedule
    fgueeiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:3w8UZ5vzkiHb6gkA5CDqUgJu04VanXrWrCKH9mLvDwHL4jkw5j7MOA>
    <xmx:3w8UZ1e_lovGvviMwzpJ2tOjvBGzqC3oVMmY8rb8ONxt7yKvBwUKwQ>
    <xmx:3w8UZ10-MjZoLiEceac_uBoYmH0NTLw44pXKeTgUmen3Pv8kBxORyw>
    <xmx:3w8UZx-txc1PNJ00BMrOPecW3Q738MRzeFufV64AL3eGpVeOtFnnpw>
    <xmx:3w8UZ0yuZSTRYTbhgQuiUg6tAUeRf2DGDu6rnbtweEupgAOhBoUYfvqg>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:00:29 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v2 5/6] Documentation/git-update-ref.txt: discuss symbolic refs
Date: Sat, 19 Oct 2024 21:59:22 +0200
Message-ID: <ca5ece5336c85a47339537577a4c9131f8938cdc.1729367469.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: ca5ece5336c85a47339537577a4c9131f8938cdc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Add a paragraph which just emphasizes that the command without any
options does not support refs in the final arguments.  This is clear
already from the names `<new-oid>` and `<old-oid>` but the right balance
of redundancy makes documentation robust against stray interpretation.

This is also a good place to mention why `--stdin` has those `symref-*`
commands.

Suggested-by: Bence Ferdinandy <bence@ferdinandy.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Message: grammar: “robust against”
    • Message: Apparently the first paragraph wasn’t wrapped properly
    • Fix “the the”
    • Credit Bence for this suggestion which I forgot to do in v1
    
      Link: https://lore.kernel.org/git/D4U30MD29CJT.3US5SBR598DVY@ferdinandy.com/
    • Message: “symbolic refs”, not links

 Documentation/git-update-ref.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 4bb3389cc7c..5866b6f2d37 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -25,6 +25,12 @@ value is <old-oid>.  You can specify 40 "0" or an empty string
 as <old-oid> to make sure that the ref you are creating does
 not exist.
 
+The final arguments are object names; this command without any options
+does not support updating a symbolic ref to point to another ref (see
+linkgit:git-symbolic-ref[1]).  But `git update-ref --stdin` does have
+the `symref-*` commands so that regular refs and symbolic refs can be
+committed in the same transaction.
+
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-- 
2.46.1.641.g54e7913fcb6

