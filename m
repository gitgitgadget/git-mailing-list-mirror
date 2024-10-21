Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADB1E201E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543681; cv=none; b=eo9kGiXJC5kMAtyUcY7z6n72DEREkFPYIKSfG9rSTVvEeBLgeB5CPArpdGiSFDGGJ7BZJ4U3W4HckS8DpsFtef6upZbwiYtfLFkg6T8K6KOByyKToLK4EbMdadDnXadfJ9bbRHDREeCYyU/o8uWW4NUBQsHblVG5/uj8eNsy158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543681; c=relaxed/simple;
	bh=1ToSOPViCu+bjKM0RbIFixxq/GfQqKn46BXJz9INk+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IteyaHn0KBb6fWJkX/rdwxIPeZedHXj/J9tyPx/yzpfFTSrlo5kLSnP45eou41OH/4QuNWqKJiO64mdPhsqFk8yajaOy4q0JlT6Q5l5kqRxM9o7NKtoaLDf/XNkBFpX/hy5iNsdOor+VjQSBw1Y6P5eVAGd1RjdH2Nf2+02pWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HHynNuZI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N2NEOomr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HHynNuZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N2NEOomr"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 176701140136;
	Mon, 21 Oct 2024 16:47:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 21 Oct 2024 16:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729543679;
	 x=1729630079; bh=dD2F7mqCJDHjeF0fSJ848Mhiy36Vq7MoMw90rkah7YQ=; b=
	HHynNuZICLFUpTJDZoY0Jbg8tKb0hJU7+MAa9Gu3ryU6IMyv0/0OJGasQRrv9wi1
	VaINUkmhuTa43UbGYcwlbQEc48BI1gpXxLiqHdjMzCC08vcUNArHg7v5mW7ZR2DI
	QxwAJLzIvVOmB4h0xN2tyUFkqztR0t1/9sV/fX2GRMvJKz0r5JpPoz1DaYkQ8VvF
	nRPNkZoYzglH8mLbQsPQnSv83VOs0vG8WbPfkDlxsm71rKoRQpxs3jRxP9r94cB4
	+x0hJsXSEU36gDlWO8Wsw4+9b47RhYpmEl6pPO+lRzKHmkP8HFlUIMj1htMho02a
	ZMO6c+HlV3cwU4FtiMh2VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729543679; x=
	1729630079; bh=dD2F7mqCJDHjeF0fSJ848Mhiy36Vq7MoMw90rkah7YQ=; b=N
	2NEOomrKafhM3nymzdbCwHwg5Xj/T6lBcrHkrHdbTw8yDEHrBoVhnTW9bfgtcNie
	gEBMkrnznFGfSKpIvFPfMN2VgjZQK3pDAOs1Ufbk1z/0u4eOT03cLF1mZWJPVDbG
	YvQBVFSIM64jlMmEb5PI8Mx2t9rB35I7qT0Cpf79lyhTHkYWVEQoVoIBKm1hLn5f
	8EHOguKHOINKJ2PabB3GKvDLzbP/5rYaynwsepORfKEzjHT/RJrVM8ojywnnXU/L
	/8FNA96xZHNrij/nohvFxLbJDnb59SknHSbrC0RUE54GiXljahJhGw74fXANhqZJ
	7Ah5JT21tdXDWvUmLbbrg==
X-ME-Sender: <xms:_r0WZ9XCtAEDrbb05QeSJk8jAJMAd83K9Y6Kw9rOEL8JH_NfNeYPvvs>
    <xme:_r0WZ9luVLu4M_WToKNJrGYt9fdsEu3ZNNN7jg5tj9bbmSjG83Awoh0iEkT6kioS-
    2pp9LNT6LA_TT9cBA>
X-ME-Received: <xmr:_r0WZ5aA9vPyGO_yWCTO2bURLotaGWR4tJFGqdXea-ocwDvmOq6POo627ASIdJGkRn6-r2YlCcHP8W8RgFNNGurtxs4AzBUuWdBu4sOVivU91lsSL9jsCyBPxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:_r0WZwXwpjqSYOihavqwyBTDqjsmKgMjXC00cpT1IN33LlikAzH7HA>
    <xmx:_r0WZ3l0mMvLEWIpDdU3sMLWVWM0L2UQa0LTb0P62wIkqJsQ0pomxw>
    <xmx:_r0WZ9fpAHcFXU7ebiBQQ_LSl_fyXioT7es8z_Ny_H9SKB6QM-7eLg>
    <xmx:_r0WZxFMTPR7u_TRNeBeGLG_nBmM5_J-XIrqpmf6AvEejwWfviSrOQ>
    <xmx:_70WZ566PpoFwpNjTxwdAb8ges7Qn3fTRiLefXqhgIWBZ3B1r0Yoj4nj>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 16:47:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 2/6] Documentation/git-update-ref.txt: remove safety paragraphs
Date: Mon, 21 Oct 2024 22:47:25 +0200
Message-ID: <bb14c427f81bbbdf6d6bb80e1bfd39e80f1d1c40.1729543007.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729543007.git.code@khaugsbakk.name>
References: <cover.1729367469.git.code@khaugsbakk.name> <cover.1729543007.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: bb14c427f81bbbdf6d6bb80e1bfd39e80f1d1c40
X-Previous-Commits: 71d1e6364a21767a8d80c96a30282e6557fec426
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Remove paragraphs which explain that using this command is safer than
echoing the branch name into `HEAD`.

Evoking the echo strategy is wrong now under the reftable backend since
this file does not exist.  And the ref file backend majority user base
use porcelain commands to manage `HEAD` unless they are intentionally
poking at the implementation.

Maybe this warning was relevant for the usage patterns when it was
added[1] but now it just takes up space.

† 1: 129056370ab (Add missing documentation., 2005-10-04)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Change commit message: ref backends
    
      Link: https://lore.kernel.org/git/bcb0e2d8-ebee-4835-aa43-05107199ee62@app.fastmail.com/#t

 Documentation/git-update-ref.txt | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index a2bee2ea24a..1a0aec041ea 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -40,21 +40,6 @@ somewhere else with a regular filename).
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-In general, using
-
-	git update-ref HEAD "$head"
-
-should be a _lot_ safer than doing
-
-	echo "$head" > "$GIT_DIR/HEAD"
-
-both from a symlink following standpoint *and* an error checking
-standpoint.  The "refs/" rule for symlinks means that symlinks
-that point to "outside" the tree are safe: they'll be followed
-for reading but not for writing (so we'll never write through a
-ref symlink to some other tree, if you have copied a whole
-archive by creating a symlink tree).
-
 With `-d`, it deletes the named <ref> after verifying that it
 still contains <old-oid>.
 
-- 
2.46.1.641.g54e7913fcb6

