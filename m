Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1B1F80BE
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019125; cv=none; b=GH3Eht0NvGiEl5t/kX7R0KwV+WglsYh0JWaZU+wL5d5XGduNwXass/+oDzuq6n8oNO+mWKV/YxJVfR6tnyjHDI0K6j/OmXBLWLUNjGga+mIPX5RsQZvIeBx9kLC8MOGeXqLxzhhELTiNuqyD7CEQM8ivLNYMXMArgUCv3422Jds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019125; c=relaxed/simple;
	bh=UcnBd3KrRvc+4zn86MnnS8dzfmZrfLy9i+7Mv9nonXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb9nRZ4lcqTeCOkaKYmMBRIRu6UU9kthEDFlzuhaHK8pQibau8knCYcjXeiuwnnrCbbUkyuM2dVuB8/owWdLDq/tOHLZCi4NjjKvmNN1USJEre2tjnKt3y9Fq1oci69j/ud7az0r2WH8cw6H7zr3XG9ALQwyRCaYa4iJdvhnqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QxehqqnI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JvU0W7kP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QxehqqnI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JvU0W7kP"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF3911140171;
	Tue, 15 Oct 2024 15:05:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Oct 2024 15:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729019122; x=
	1729105522; bh=euVLyTwTqc6KsprarD+LHCM2P4KxVfrVcpGVKfJu6gI=; b=Q
	xehqqnIuz3OgG+1ijJsu35t3KHnGN6lOkHEovQeERwdslmXfrh+GwPfDNQfZSFOP
	+MXDd3xyqqU9PkXICezHhCsRkp1KIAFgSPvEqguwT4RWsLUZNKpjqV0ORjuatPM5
	01xksUmDDx/DHqG2elfu2wRSDUWfojg/JP2Ho2w/ntyye8SjeAuByX2GMZsq4Kat
	lUyWoUeWplu/OJexQzDkWAK/Dn/QgBvYe97dEcY0qerVr5AddRRy6vj4xaGZSPZZ
	GzotXbVcEP0cVLDkyhnnHlBGheWpHj2xLOJQSYa28zJz4NndvB4exBCsTju9VIdx
	qCJO5J6y+SreYuiUhCaNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729019122; x=
	1729105522; bh=euVLyTwTqc6KsprarD+LHCM2P4KxVfrVcpGVKfJu6gI=; b=J
	vU0W7kPMRn/BIVyV3/mlWioVHNHX+MDWZwe2aq0KdFCcx5tOzu4gjUCwuiEHxc7p
	JDr8M4z1Q3IY2woAisOmLQDLMeIhRr9eBGGMgS5IGUGgD0QQBm9BfSjB71H8QiaG
	yyEkcmWJhDXu+7zaK5zGO1s7tcYrkBFszS/GX+AYWOCvgVzhn7Sm7IPwfol0pbBw
	pdbApdUJkfEQ81+RkPr4jHZyGQisDJLjkUEKeLa49SSsfY3T8BWT/trJjzJ8FGHv
	DzZF8wl1UuemRHexq3PJrfjTeCV5U9jkJUGJWhdMecjbOg0ZW7BWuRX6X0J+nLBB
	YQo3vYjvvVO7QwW0FZo/Q==
X-ME-Sender: <xms:8rwOZz1MtRAhlcWDDtL2Pe38_2PmaDS1m0s7rV57PSSjBktze9pVMUY>
    <xme:8rwOZyFg4nXtVawj28orD4qvN3gJ2HQitl0SWh9j1WExSz9Zl8AMeX2XUD6FXG0oc
    _yJa6jAX1lucj9aow>
X-ME-Received: <xmr:8rwOZz7sjMcaKqt6QkF94yDTnN8TnfcewnePKmDkCxY1mublAd1EIaXrlnduYSsMSeufTa0vjN48WlDfJcjCSY7N2eIppKxGwOxqgHRWqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepfeehte
    ekfedtieffvdejteeutefhuefgtefgtdevhefhveffuefftdehiedtfedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghntggv
    sehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8rwOZ422S2VEEPYSl3CnL7z4CpgV6cHFTxDMXY4Rkf2dzzpZOqjtOw>
    <xmx:8rwOZ2Esf_Me6P-4U9POg0WM-S9HBrgWaciYbKsoljt7ggCJ8TvgWQ>
    <xmx:8rwOZ5-nV3dAcjmohfEoOe56mtoSkofmbp5uVg8Cz1RH2n5mxKtm_g>
    <xmx:8rwOZznKHGwP4RTxS6gmPeqthwZMAopqbPu-ZuALCVlmFyVHx-rzQA>
    <xmx:8rwOZ500mJRS6ROeNdoSNF59C--XSMPNzs_n2IVt3jSRNNQYQyk6YoYp>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 15:05:21 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: [PATCH 6/6] doc: mutually link update-ref and symbolic-ref
Date: Tue, 15 Oct 2024 21:03:15 +0200
Message-ID: <9e775a65eb3ff49ded231aeeeddd59ccdce3c8a8.1729017728.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729017728.git.code@khaugsbakk.name>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com> <cover.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 9e775a65eb3ff49ded231aeeeddd59ccdce3c8a8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These two commands are similar enough to acknowledge each other on their
documentation pages.

See the previous commit where we discussed that option-less update-ref
does not support updating symbolic refs but symbolic-ref does.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-symbolic-ref.txt | 4 ++++
 Documentation/git-update-ref.txt   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 761b154bcbb..33ca381fde0 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -73,6 +73,10 @@ default.
 symbolic ref were printed correctly, with status 1 if the requested
 name is not a symbolic ref, or 128 if another error occurs.
 
+SEE ALSO
+--------
+linkgit:git-update-ref[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 623c4d860eb..fada3f670eb 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -190,6 +190,10 @@ otherwise it will just try to read them and update them as a regular
 file (i.e. it will allow the filesystem to follow them, but will
 overwrite such a symlink to somewhere else with a regular filename).
 
+SEE ALSO
+--------
+linkgit:git-symbolic-ref[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.46.1.641.g54e7913fcb6

