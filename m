Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5A305E2E
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660836; cv=none; b=YrpUZq5PipdN9Wm8sywcZUKXTFS2XLs3b/OAJnO8sXXMdCwQwQ7P+fgZQOQR2bM5vhFiZLLdZCWBfEoWyIIMxOQvSDrT6NPzw3kn7LeartW5JGA3/HfAiL8nS8PGMHmVSQXl97uhsrxsVCeflVn9PN+O4oDOfJcHeLEm3fWU6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660836; c=relaxed/simple;
	bh=W9LtYSmmKWImOWJI5vn9cx25RxmBE7OUMC7GQtCWFRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Evuu0OcFkG/QIjq5XZ8LxBqGJTShxXclS1pEcC8lQ6tXs9Z3c2iEu9wUmUDHCSPi1orhi+T8+p+Qbo9mrRNZeSVZk9vSETpGlemmaWOjyIDSrysE+6zWHk+OSm1t37FRmqRwoJlNm8fJsNYoNYaT9xNgiO/VMpdOStp4BY4D1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=aLbxfS3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OIHBmxTb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="aLbxfS3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OIHBmxTb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C26A1400192;
	Mon,  9 Feb 2026 13:13:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 09 Feb 2026 13:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1770660835; x=1770747235; bh=L4
	d1xaENPgNiWuYbDtnLMLV8kS8G/A51rHdv6iXOqVc=; b=aLbxfS3n8pVqTu4+LK
	k+/R8JwQ7xN+cE7xMBt7Km9OtPKNEgdOqBoPHpDI3UmglxBsoK0MHMABJSH4+kMp
	hEnsYXZItWXWJ+j1YYTJyCAepeX2tus8pGjfhVLzXh1xAQG7I0drsdAy3l1F84CC
	Br7O7vW3+8wvu7nSznWhj5jR6xLx6fEqMXSyYbAzNDf9kk3z4GPiqHUaBtX5Ai8L
	3D+mPEZ6xpLP/GN+W1b51cH4OcpUAhkpJBAd9Vpbp/n4oUKGlGlyNpz9FtKt08KA
	PzE0CUB4WjgxylacR2AMj1d+lKJd9ZDEHm+SITDk0O1p878mLszIezfID3eIbqIB
	CYzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770660835; x=1770747235; bh=L4d1xaENPgNiWuYbDtnLMLV8kS8G
	/A51rHdv6iXOqVc=; b=OIHBmxTbVaJGh/ZOP5VGd6rniPl5+mBU6Ipo2WbfIG1w
	RzWiDmevxDe54DFYDunZFd42HQVA6AD0S9t9p+Cxji7t0WTtrSdDcYF99P2G+50C
	YFkzU3TLi+1xahapwVHGL88/BUwOAO7L4+9q9v23UZmpflmvlP3gCYzx8ZDlK4bG
	8X/EtPGdo1YG+prBMEsIqgbsZPr/1z+3dSZJEr6XMUjbkjQGjza+ElzmJYRPg2CI
	jrTyMHc1iYVbWob1+fA0TPloeTTNVBXvOU+ndDP8VoP8lzUHaQlh1SqMOVlTJNbD
	YSwJ1+j9DsumwIKme9RUzDayerb0EfW/H2XKxLqOJg==
X-ME-Sender: <xms:4yOKaZnbu8jD20bqLI2csaFq9cm0wANbIGLhgxAPA3tP-U5PvFXb-dY>
    <xme:4yOKaa2V5zY4_Oqd3COQ1rE6jzxwm_AnxckSOvJoBH651zHpeFQf585IE8U12vBZa
    uGeD0igK2Pz67M4CRyj6rtXPWBccyxnJtEvdzpHVo4LkA_omAuROA>
X-ME-Received: <xmr:4yOKadQe2aZkkpTeB_PWXUqLYXOpKSZ0gTiTiVeOYSUO9QzGe5zfziKCW_Eiy0DAnciVTFryz1CrQsZkCCA1ILUFsTy8OFCQix6hewM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejff
    dufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:4yOKaUvhbof_ZMEFYkhyPhpth1xyvLS5LfSDzCmuxk307_g0ePwjJw>
    <xmx:4yOKaabMie08j6gSDrAvdN_qFBGbbN8T3e3DCYdYhY6r64tsNjroMg>
    <xmx:4yOKaRsyKSypCQ7IU5DDmRAcSYNMKABedPITVxvjR0LiMUheL_aQ-w>
    <xmx:4yOKaUFKB0ephmrxJs4738ceGUNtl-md4LZOZSY2oAYF_5CePEYKjQ>
    <xmx:4yOKaU-qy4AFQX6OIFTyAeb5JsIta1uUgfkB9_hjdnUYqY-Jdx8tX7SO>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 13:13:54 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: rerere-options.adoc: link to git-rerere(1)
Date: Mon,  9 Feb 2026 19:13:35 +0100
Message-ID: <doc_link_rerere.328@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Five commands include these options. Let’s link to the command so that
the curious user can learn more about what “rerere” is about.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: kh/doc-link-rerere

 Documentation/rerere-options.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-options.adoc
index b0b920144a6..115882edab1 100644
--- a/Documentation/rerere-options.adoc
+++ b/Documentation/rerere-options.adoc
@@ -4,6 +4,6 @@
 	the current conflict to update the files in the working
 	tree, allow it to also update the index with the result of
 	resolution.  `--no-rerere-autoupdate` is a good way to
-	double-check what `rerere` did and catch potential
+	double-check what linkgit:git-rerere[1] did and catch potential
 	mismerges, before committing the result to the index with a
 	separate `git add`.

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.26.g2afa8602a26

