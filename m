Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA508537E5
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768971; cv=none; b=dcLc/fQCizSkAEnboDQFFpyrxi6ArUkoRggo2iyDiIMt5x8ZXVAXdTVE6fPvYGgRSVbQi/47hnzLd/ozpMplCrB+1QLAlcEFgD/stuoIPc/mNB/020G4uQmGuOSPKeyzKlXNx0O++Rz59fKaneCSmYLFj201gKXjNgNxAnnhoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768971; c=relaxed/simple;
	bh=UmBOFlUojmkMS+uOsAFEnfbqjPODljRLoVFw3YQMCmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB5w7/BGf3Wkl6vY1TGqQtZxwYOPh7sQmqYuy6QIm1UD0oS/pOaxlrIq5HmVU643bz+UaiC94MRZ+mKyIuK6JvO/wnZGZEw8PmKJl3Ngb9Z/6CRCCJfPDJ8nXvtoyxqibqSRQb0ZXbMe5swZLVPye6ydxOx1ccqtlB7f0hHkc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GEAZto+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G8Ulw7rL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GEAZto+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G8Ulw7rL"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD94E11400F6;
	Sat, 16 Nov 2024 09:56:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sat, 16 Nov 2024 09:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731768968;
	 x=1731855368; bh=mWNaLnbiHS96eYBp95mYmqG0s2vQ1ikE9azuMU1YbFg=; b=
	GEAZto+MRLJZ3eqbmk4ZxbT8HijL+IYN7qbY5Kyn+AL9MuOQSkBB2fCnwbrKz+es
	ciQS2+c/IYUZ4J00CuBcTbK1nKF3Dpvloy/ovGWnwy7QzItnFV0N/5cCwVjwZioZ
	58yTzJGoX9OlhJnDR0qKka71/5llwK/bs9pdCnmCXgjBD/wzfwe2Os5U5AfeeVwF
	kcDCGwuTs8PXjiqB9QiIO1iCEIQJCIX65yD3PaBhr77mh7gl2c+SZ58MDxvm49zN
	WH2305b4ehsOkEAOWO/84kmRjTgldjiPjSQ1qoHj5Edi4HVEvqPmOs33s4NgiiUc
	KIEPWtVAg2cJT5b6OjZW4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731768968; x=
	1731855368; bh=mWNaLnbiHS96eYBp95mYmqG0s2vQ1ikE9azuMU1YbFg=; b=G
	8Ulw7rL+iLuBQsc5DvLey0QtV4OGMO4QmRPeo4diNPaZHVmocJHef96LpGC2RQm3
	Y5L5DzskF/NtgodjCyEPfNP4RA3aCxCUHyXGroqk/IRfLZXY+/62kTj1Mb0O0cuf
	AJZSBDZEyTMG0dF1Nb5SzGurpq7O20iP7ocLCE3FsS4CFHMBpnNsCllr9grTL2Cl
	JZhrJBQ5RbDgNFS/PPxWriG7k4s+kfRRFq6VxL1M44ReqTJaYPuodM8AUzspEd9d
	LEYz3AXdqaboJs35oNLLg9pEdqbdZKckMyLqJJ41ExB6bYAUHCy/7xdcPrQFr+fW
	snvOEdvXR73b0lIBEbAVQ==
X-ME-Sender: <xms:iLI4Z_dqEvztFTIfi6fo6LiXzPuAQ6V0zKE1Y1jFkG0qTX1uaElWV88>
    <xme:iLI4Z1ORm_VWz5rUjBJk9pjMcojofo8rqbXqppHX6pAoKu4hr3H2oKTigsX8H0pMy
    -pviRtU_UFtz_UB6w>
X-ME-Received: <xmr:iLI4Z4jKsUHWkHXWXej3XYE7sk_bsvqkxgWWlEBbqkCEw_gE4rShwfVTAEUtDxbuMgc7naezBZ7IyUaIyFx-INci0kRx7f58pckWv8FHscgdSBpXJwjek4hYMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgue
    eiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprghvrghrrggssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iLI4Zw_Y7J4A5IPWIp2KW_GEQ5StSKQUt0hOIHkQm8C8U9dXv4rr1g>
    <xmx:iLI4Z7s8DeGYu-A_wreZUWXdfjeIM99iamfK1fvIU6WEOjkx4-k-pw>
    <xmx:iLI4Z_F5fV7l0G8t837XnMEDqAEBRHIK3mOLV9dQSZHvuEOwzM6N3Q>
    <xmx:iLI4ZyMDxdE1otHxEsWujvQjuMxlZc-Ka5stwCvHky9WxVa7A4nB0A>
    <xmx:iLI4ZxX8wF_Xu5O2J0KBG6EbYcJ-wPi51ZYdYaf8dfWx7nSL0gN3861j>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 09:56:07 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v4 4/4] =?UTF-8?q?Documentation/git-bundle.txt:=20discuss?= =?UTF-8?q?=20na=C3=AFve=20backups?=
Date: Sat, 16 Nov 2024 15:54:54 +0100
Message-ID: <c8d5e3ee5040fbc5eaf89b6d22a8402613aac660.1731768344.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0.317.g7d2562b9734
In-Reply-To: <cover.1731768344.git.code@khaugsbakk.name>
References: <cover.1730979849.git.code@khaugsbakk.name> <cover.1731768344.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

It might be naïve to think that those who need this education would end
up here in the first place.  But I think it’s good to mention this
high-level concept here on a command which provides a backup strategy.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Mention the stash (knock-on effect from patch 1/4)
    v3:
    • Use `cp -r` instead of `cp -a` since the former is more widely
      supported (even though it is just an example)
    • Mention what this “full backup” does not cover here as well (see first
      patch)
    v2:
    • Fix gitfaq(7) link
    
      Link: https://lore.kernel.org/git/ZxfhAAgNlbEq60VB@nand.local/#t
    v1:
    Correct mention of the section?  All-caps seems to be the convention.

 Documentation/git-bundle.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index eaa16fc4b83..504b8a8143a 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -344,6 +344,24 @@ You can also see what references it offers:
 $ git ls-remote mybundle
 ----------------
 
+DISCUSSION
+----------
+
+A naive way to make a full backup of a repository is to use something to
+the effect of `cp -r <repo> <destination>`.  This is discouraged since
+the repository could be written to during the copy operation.  In turn
+some files at `<destination>` could be corrupted.
+
+This is why it is recommended to use Git tooling for making repository
+backups, either with this command or with e.g. linkgit:git-clone[1].
+But keep in mind that these tools will not help you backup state other
+than refs and commits.  In other words they will not help you backup
+contents of the index, working tree, the stash, per-repository
+configuration, hooks, etc.
+
+See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
+problems associated with file syncing across systems.
+
 FILE FORMAT
 -----------
 
-- 
2.47.0

