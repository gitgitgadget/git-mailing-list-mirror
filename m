Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0F146A71
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823108; cv=none; b=JWBe6YxR34V5S+P66vlZxpUSvuuVBaXDYEnwhRsmgB+dIIxZsW04s9v0SzTJ5Pbi4rSI+Xbvftq+sNcj9lVbTxMmqnnH9AN+v41qwmpv61AdH0mA+4B0EsjYOtYLGWV2wEm9mZa0BRZfOUSUJ7vVdxPIjyMo7/WXry/XOdzra9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823108; c=relaxed/simple;
	bh=s3gxn7npOPubf8/4dwDHI0bG3+kbAsYTJ+xW5b2gGhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7R8D4UmBkNJV3Y39gr2FIqXG+e+hmhfpWxDvkNS7nd+5eW2jamqtKvBoKAN10lsnGuBX3SipE5+Mt9oKUfg2iWTCVOV91s/SJk7SxLHOQZuyU1y+PKOBLpxzeHNq22WmXd/ZLodxQElbF5INHupUif9R4cEsxL9Rwhewk6FEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Dz8xFPiC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kNAWJg3G; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Dz8xFPiC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kNAWJg3G"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B8CBE1380971;
	Thu, 28 Nov 2024 14:45:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 28 Nov 2024 14:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1732823104; x=1732909504; bh=BD/d/1WQU2uQT9C7vHJBU
	2DD4eE1HSprudcRL94j3ts=; b=Dz8xFPiCdrdsO+nbUkVIdEb8sawSCKiEP/2nD
	MlLMGaG2qnXGzmhyJJRMHGKGf9wCSEsKw1WYn3Xu3zWfjZQb4irx7rAD/vCvtjEH
	/ltazZiwkdcsiIwNLifZFDHK8Prb3bP3MiviP2fxv2MGg4HvH9uTuFoajKzYUscp
	2ORVDzachk6KblE4Eez1vA0upUjEXlH5vEBIi6SRtl+fAEyuCYvlLYPN1Ykt2HuG
	ERjjhzTS2b3a/RRfNpVDNUHyXVBlx0xcGOzH11FqhMPGDcSB8W+aUNLfTwribFnS
	k0HM/E0T6mSfssAysy5CxCoLwJGrgY1ZBQSYmaYNhxa/qXsqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732823104; x=1732909504; bh=BD/d/1WQU2uQT9C7vHJBU2DD4eE1HSprudc
	RL94j3ts=; b=kNAWJg3G8oy2IL+KfEuKhQgiT81qLut1vAmBiQNe4gLAIAIxksQ
	Mt/Tct5KqXAuJUBzC7p5MP5Ry6gigDJGhpJHPIJgxsFCV+8aJufVylK+71Bfl3g+
	OmdFjD2a3tGugZWYeWzuex4riQw3a78aYDmrOtCt1ukJBG9i+7cjzOczZjWLG6ol
	TbT0Qqy3HGAmPXGDsKfpLHrO85KPSSqjnPdp2dhKUJLZxx50gjZe3N4aeGE+n7pS
	PRH06x+nCJuqRZSD5I8dZtqIrjSISxqG9yG5g73huDKB5WScrzQJaekJ9jVsWCsg
	K/5U5ntHRFjK8xsnM8DhsxsjQwMzh5WyiYQ==
X-ME-Sender: <xms:QMhIZwZYezQ0m51O7aMwVo-zNbIstE8FmLVumKMCuVcWYPLNN1X-VZQ>
    <xme:QMhIZ7b6F8vTCj6bmD_k8Nu70priyk7PKuKdbTvcf0JJ-VXn-uL-sJK6BtPWMzJM0
    RpHQN9d15Jow_XeTw>
X-ME-Received: <xmr:QMhIZ6-bne-6FNQR1D3C1XYGTK3Q7QDvwEAjnbsvEPnmq5Kp9JnLiws_tTUqx9QhD2jQ-xuWKuGYFXOkitv8OIYnvjinX7QOl3cMvuUJp_VnNHmIJK-o1Wh8cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedvheelvdejhe
    ejjeehveettdejkefhhfffveettdffgfekuddvvdetfeejhfdutdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:QMhIZ6rvMSxATjtWcsm3zbcD-wYkI0N_-ZXYLQltrSz3P32m1jPShg>
    <xmx:QMhIZ7qLkUegPF8GpE4KGplsRtmrs5l3KKG346qU0WyeESsUGt11kw>
    <xmx:QMhIZ4Q24NgaQLTpkLpAQ4Ud4ocU0LTMV-z-OeAZBCPT0BfZtmHJnw>
    <xmx:QMhIZ7pfv_SwhauTBw7OALhVdM7BmV02Qw_S1rqUaBY-uS98KLIing>
    <xmx:QMhIZy2WOBT7ggWwaNRxhXZE70KghyVONf7iQM3Fi5qBqko1cgCLa_Ru>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 14:45:03 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] Documentation/git-bundle.txt: fix word join typo
Date: Thu, 28 Nov 2024 20:44:51 +0100
Message-ID: <164b94bab9214f6030909df8f1e7c476b7f79e55.1732822997.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
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
 Documentation/git-bundle.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 504b8a8143a..03cd36fe8d2 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -32,7 +32,7 @@ Git commands that fetch or otherwise "read" via protocols such as
 possible linkgit:git-clone[1] a new repository from a bundle, to use
 linkgit:git-fetch[1] to fetch from one, and to list the references
 contained within it with linkgit:git-ls-remote[1]. There's no
-corresponding "write" support, i.e.a 'git push' into a bundle is not
+corresponding "write" support, i.e. a 'git push' into a bundle is not
 supported.
 
 BUNDLE FORMAT

base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
-- 
2.47.0

