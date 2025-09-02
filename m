Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F42DFA2B
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845390; cv=none; b=WAjSaZkkk3m+ru+ugNlcRZMNpCW+s7ORLc5e2hvdXlf2euAWKYracCp1Y7FONxzAQeYSk0iX4XyXTJV1MWeAW9SOe2y255HJ2kXixH4vNLygpXihxWHvsGDyjSaB36fAZ+4EJM4r//GEDx4cczM02BSF/ilFf3YyN6rPkPmJaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845390; c=relaxed/simple;
	bh=25pyQAWKH6+9xyKpg0/iJgU8EfMLYAXp2hhnLKAhCjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2ZY1wNRrLq7vPVv9zek9CRVg3qNW3Tj0S60as/L1WKjWX1pEEoesLvlU5//phM2d3ud7w4DdbUjJzYMAFUoFED54wLrGU7zMgDKNJgslxwAA0w2a5DZvT1x9Qm6X3tMCKMfQALuVuB7/bQJ4Sb/4K5smfoOr/PHVZC/RaPpXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KRao2+s6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HFFckhpX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KRao2+s6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HFFckhpX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FBE61D004A2;
	Tue,  2 Sep 2025 16:36:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 16:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756845387; x=
	1756931787; bh=HDu24zyi2iMBOH7KkOWlSrjdZf8PrrwwPxU6VfgLaA0=; b=K
	Rao2+s6gDoU9IM8oLpZYPT7ODD7BHH41D6cV2KrRsBxA0r2MhCCZz7ph1BCmj87F
	UL53rSZE4D5ZASs8cLtg0gBtSl4B08mydoecC+wNZWHszlCSF6DkIxbwKzD/O7Qk
	Zh4PvSTbj/NVaH3oGfAj9kz4pHw6L+KRUJif8yTw38Hq1HJYGgHZfhwlt7fzcQFB
	TrlgE1LsGknkCUPzyddMa9c41qXIM+fnQEhm+OKCY+Gw2QyawwHOvmyTEwoPD6r7
	Wq4rv6csC82dvGwW3RzVnGVMElEUrn+2C3NRwskiebMvak8oOww2ZTie0eiKro9c
	vtb8PMl+iG+RfSvp34aww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756845387; x=1756931787; bh=H
	Du24zyi2iMBOH7KkOWlSrjdZf8PrrwwPxU6VfgLaA0=; b=HFFckhpX143GstntP
	ibB1QZ6f9nMfnjdHafbwTskl6YoWa09/SCraikFuxj9fflzKgxCjfiUAdE2StKDS
	/Ymzs4Ec62JtTXSB/w3RnNZoMRCdWrzOPUJ9zCva98aMUNx9OGvbB+fDnjIFZXRu
	7Z5MKpB7UvdnX3PDpVjlEvuAWNEP5W1p9KMtuohUsGld57W644FtZCzm8+oWYHO9
	qFfBzrvpmuSPOcjSS1G2d6PKMMryFTlvcgSzL3RuARCNKsUWdCXD2eciqO9xJVbt
	9bP6TJLqSsOdgDm4Mu4AtmYH29dTq2wk2xPhpfVR+3f2ueIUg64BgkRrLs50VnY2
	WoFDA==
X-ME-Sender: <xms:S1W3aCbHrMouKCYU00i3uTdMKPxICT95OPfjjBOx66YR1UZJJifnV3k>
    <xme:S1W3aFnlzUV7YO-5DF43pFLqEuWhWT9_fZe-JDnd94siAZSmwXu_MvL19-aF1Sgb0
    Es4eE2_ct0q2UxScQ>
X-ME-Received: <xmr:S1W3aOzlnnhBBrzSw6ONKvxRyokmK6HnN1U0efdbqYwUHISoFG7BcD02zdsxDbmkuLS--U1xZUU-b5b9sMEFGnWhbtslw6-EfMF2f7v9_DSfU7VCSbM_LagOeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertd
    dtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgf
    dtveehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtoh
    guvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:S1W3aDNrkKVi9K2ACynqyHqAhrIkQkGey96zh8OMd0l9YXcMgHb31Q>
    <xmx:S1W3aCRiaenDM5g6zk4_Tlp_QNLlo60LQq0uEymO3dIfQ2WuuneL7g>
    <xmx:S1W3aBbUz5yGBhnWcJ0gGEwXZygC9ItlhjMrSfOz0Wp295WP7SAAxQ>
    <xmx:S1W3aP0II8eN7V_wfiRZsjJh0_xn1QaalWXS1GSYllLn8wV2o83-MA>
    <xmx:S1W3aM9Nfgi6RXgbuYh_grs1rXeDuVuR65PCFVxduIuqLZPQlEi7akey>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 16:36:26 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/2] doc: add missing backtick for inline-verbatim
Date: Tue,  2 Sep 2025 22:35:46 +0200
Message-ID: <143e419a1438b087d60e40425c221567aa114d00.1756845314.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1756845314.git.code@khaugsbakk.name>
References: <cover.1756845314.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/fetch-options.adoc        | 2 +-
 Documentation/git-multi-pack-index.adoc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index d3ac31f4e2a..ad1e1f49be1 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -2,7 +2,7 @@
 --no-all::
 	Fetch all remotes, except for the ones that has the
 	`remote.<name>.skipFetchAll` configuration variable set.
-	This overrides the configuration variable fetch.all`.
+	This overrides the configuration variable `fetch.all`.
 
 -a::
 --append::
diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index e8073bc2723..2f642697e9e 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -29,7 +29,7 @@ OPTIONS
 --no-progress::
 	Turn progress on/off explicitly. If neither is specified, progress is
 	shown if standard error is connected to a terminal. Supported by
-	sub-commands `write`, `verify`, `expire`, and `repack.
+	sub-commands `write`, `verify`, `expire`, and `repack`.
 
 The following subcommands are available:
 
-- 
2.51.0.16.gcd94ab5bf81

