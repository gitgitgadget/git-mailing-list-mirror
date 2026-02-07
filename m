Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A55352C3C
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476782; cv=none; b=X63RdEealYl/PMCXz1h2QuQ8eGmL2rX+y/t6ZjMzsR0Hy2h8GFzSzwojNjK40GmQxDiwKjj6U3Bk74l+b9+2CsI4VYGCGaX21ekWWP25Il1IqitLo74rs0NZDv4a4HwiXUALrZ1kGzQhCJ023A63a+6DlhADcZhAeQq6RnamdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476782; c=relaxed/simple;
	bh=jB4hZ+i3fJJ7enku9FGTjY3PX8vel6saCY7vIO62oFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZCx78jqW1Dw0v3E9gbc/ecXtt+emZYnESSnkgNu1wFb+iGV3+IBAEM/sVaSk83x+eYmlJDyOCS26cJnkvxXRHoBNMYHuovQAl2DTk0PoAIh8gl9H5p1sLv5cgqWBMj2x7XkDpQfcMI5nlNScFTmeYYtJQnw4NHpLk+WelwoipoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cbByeBc3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LSoHdF4t; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cbByeBc3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LSoHdF4t"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F0751400162;
	Sat,  7 Feb 2026 10:06:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 07 Feb 2026 10:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1770476781; x=1770563181; bh=Wo
	pkhnt+Z7euobC+um3Yz9kqPtDU5JhnGVnn6JiK8Aw=; b=cbByeBc3lgKOFGEMdu
	0YzkyaX1nsbMQ7p8+yEjBaVNZrAtQWn4q+98gG3jwddNekjyDdEMIyy24lBzaEyX
	p2n1vwnOhQM1+LHleYt1Fibf56ft0NzcMXf4dLc6ia6fVGurIybINYJizkaQHFJR
	xxY75/29d0LnWG1++WKLsZPdbUVjIyBwAEkSdlFsXykQ+LpeySfvJrG/njYGmA/L
	pHA53eYQ0UGuRCxoy3xrBM3/fobEwNx62kPpyEx6G+ftD62tz7HX7pDQEgLiRTim
	vrhq5mkj0hKsdvcQUr6kIKYJRrJH+rl7xjEoMee1FwrrnA81aEZ0ao/e4VeOptUp
	RVQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770476781; x=1770563181; bh=Wopkhnt+Z7euobC+um3Yz9kqPtDU
	5JhnGVnn6JiK8Aw=; b=LSoHdF4tXFeOhofmBRZIsAvgwBFm4JnLhG2izhJ/d67v
	LrQc4o+DuL/uG2rFwePib3XUAJ+oF4JqyVGAdHJKbwyFsjxsce36PTxPzZxrSjLw
	F8r3XYMpeN1ZRQLApiyzQNk6U9HB9R2PFAO9wR5fCMr/66VXc1CLhbVSuMi4BggU
	ByJP7KYIbU+wIDdXWasLwn6OHC5QYX3FkGuegDP6/msxQcHBVZa/rIPzc8ZMICW/
	5L2hIdRQfxu+lfBIvVTJMiUht/4hvopDKhaFzav3q3cndKr4+cJfBZ39TE4jWS6Q
	ISWMUN7FFQ+ALmrTCEmyZnGJSIoNmSuWD5FNr9riew==
X-ME-Sender: <xms:7FSHaUxhevdhC8RbjLQPA9Nokt0959Ox99IuveaR5dcKffQsj4BkGeI>
    <xme:7FSHafusZ54Sc0ai4TgB-QLA8Qf1hLZbSH2gZjwi18dyZja_TEOimM9jMIrOSTr02
    taqO2PCSG8_ejpCBgvW0BIwQ5zqJQvZFwowUv5ZX_kVBA1nL6ZQYw>
X-ME-Received: <xmr:7FSHaTsxcO3JcbQxt4kMer-nDx9sIWTLVpEtE4meYExdTdwXra3euR92Fc1MvAS0_NN8j-rBRCBAfkOISKE40sVq0_HWBBR2ilLuZjvBuTaqe3Vx5xIqQXw-wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeen
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepheelhefhieeuheejveeftdfgiedtueevhfdugedv
    heekvedvuedtueeffeeigeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhg
X-ME-Proxy: <xmx:7VSHacN7LlreQwsy93Et3Ghe8aJqhWUMuPz5g5kPZjs7hrNkL9w12w>
    <xmx:7VSHaZ1fIcVmGIAmtPW7WnCOtEMKNEs1AEw4ZKJTiLWoW48OnMFSog>
    <xmx:7VSHaQNFakCzzqSFagBhWKa0AnTBzJ_rVnBlTqpgxvcS3sCxLSL3sw>
    <xmx:7VSHaR0e142M9-YpLa511T7vrPzIZCFJ6QFkWvMwF6AGgiV7CscIIw>
    <xmx:7VSHafs-Nr5Eh3dMiUewkSmwiQDXiwwKCAwNuQuH47XGqYb6rsI1DGIE>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 10:06:19 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] doc: patch-id: explain how to map efficiently
Date: Sat,  7 Feb 2026 16:05:25 +0100
Message-ID: <CV_doc_patch-id_4.275@msgid.xyz>
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

Topic name: kh/doc-patch-id-4

Topic summary: Explain and emphasize how to map commits efficiently and
add an example script.

This is the fourth patch series for git-patch-id(1). This one focuses on
emphasizing how the command is an efficient patch ID–commit mapper and
how to use the patch IDs to join commits in a script.

• Patch series 1:
  • Topic: kh/doc-patch-id-markup-fix
  • https://lore.kernel.org/git/v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name/
• Patch series 2:
  • Topic: kh/doc-patch-id-1
  • https://lore.kernel.org/git/v2-38645ea253c.1760369708.git.code@khaugsbakk.name/
• Patch series 3:
  • Topic: kh/doc-patch-id
  • https://lore.kernel.org/git/CV_doc_patch-id_3.1ab@msgid.xyz/

Kristoffer Haugsbakk (3):
  doc: patch-id: emphasize multi-patch processing
  doc: patch-id: add script example
  doc: patch-id: see also git-cherry(1)

 Documentation/git-patch-id.adoc | 49 +++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.26.g2afa8602a26

