Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED302DFA2B
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845409; cv=none; b=pP+GpaFqXx33mADxY/M7KQXVkvjWxixIo4S1ewQmFZa4ywIW/Qy4uoxCRzo30WiaMKhFBzWKX83ggruIjJDHt8+//Z/nFPtA/bdjgV2CqiqE8Km24kAEjHGAFQGLAfcSm0HCg+2TsNSdCBkSMbiwC+HqbUNdnNKOg3JSNmqNROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845409; c=relaxed/simple;
	bh=2igM7x+xRDqJIKw/Ra51cPMI8GSNFeOA+/Mm4WcOHrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF4ZHyViQHJTe4692pP5WLTVJjuW2ZllUqJOakRSi8Gb213ZN8j4JL107ao20jf76GJoB4n9/GPui463d8V8smErG2FGN34hpKJ6buL6dg/e09EcrG3xEQaPXCOGkYXkjPFHXV41aFbCwOBErikBJvwS6784W3LkYUsKLs5gT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XB0kPBE/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKxReusY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XB0kPBE/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKxReusY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 640691D004AC;
	Tue,  2 Sep 2025 16:36:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 02 Sep 2025 16:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756845406; x=
	1756931806; bh=1oXyg4P/hk+CHba/hIuNMyKofIKLV00gtQxoGUFjJQ4=; b=X
	B0kPBE/g5d9b+WTl19KiH1ovc2271IY1Mw8CIwCSnYkfUlxI2Llw3ewG6qsXF14k
	wpEy0azcX+iCT8I76L+Vab9P2GjwqWPxm8KflwnAJzBAJ/sL9dqKAkO3haW8KVrS
	LHHP/9+XsR0qJ3Wqc95z7quvhRoEhoLCDWMMNKldqvglWcvCp1Q3vASaISST1//P
	2xYbgd5Yakup9gobc9cQrUL7TH9GsLjcsSy3NQ40MLEUZ2GUikWklaAdtxA0nyCU
	nlk+dM4eo8D6yqkt+WByDfAo2JF4qIpfNwmtZI8txTqTB4uq3Ty5TgY441Puv+2J
	5uYrsk5vxko3Se9Zvvi7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756845406; x=1756931806; bh=1
	oXyg4P/hk+CHba/hIuNMyKofIKLV00gtQxoGUFjJQ4=; b=fKxReusYtDrrtDa0Z
	Ga7/gWQeZgWqxt48Mr9Sm3CQHy54fhwYVoBmlE3eh14hvGlw7Y/LlCIEnAiIP+fs
	DDbhrCBnXWBypeRzxDgXHj0XEsLFRfI4V8zYh2OjS9lhmsPXPY8k0H4dvPEEYOMR
	N7r2kM08rm3SF5zG2ApovbOi5jrxlH0tfL8ZzLVHMndVlaZbPZr/DO2imJfq+nG3
	zcm6nKfEqDrB2+PMSPbJfpOgqSUmdsQa6mI7Q6/aA1+FfDxy36vPolqg6JkDlmtV
	Fi4362rdmLk2AIg4GgPeyNjWK86Z0xq1f6m+z2SQyS2Z2+h3neruXfppSYG9cCm+
	AdH7A==
X-ME-Sender: <xms:XlW3aOYOa9bSagmNCH-ZyH2Xaj-xbQ3ap5vyFflv6TQ2LM1eRjz2HsY>
    <xme:XlW3aBnySN-c03eU3UjBEZhYe8S4nPt6n2rMovXB_mIMidxCh_YG67qe4jQs48fZn
    E-dOjAa9XR8j0vNDw>
X-ME-Received: <xmr:XlW3aKzTd6ApW-Nooem9jnmS1cv7PhSYq9rBUDWZQ1zRjemQTgOE3lzZDjBcx_mrlip4-Yga_hxnWw-_5upFzqboNNJldXAxrZ3zpZgVw8clgkN8ynvvc9Y3QA>
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
X-ME-Proxy: <xmx:XlW3aPMliC9rPu9seNe0vdODGmpBgKGlq2fdrNQZ4xleONwa1i4IZQ>
    <xmx:XlW3aORlrOLgfBrckdo3U5iBpaVdkKeq_S9aiuEJkdL9Be4iN7KlfA>
    <xmx:XlW3aNbstui-58wqUy53WmNZdbVpBpsaUTaG95zV0KACQDzJYsh99A>
    <xmx:XlW3aL0SxQk68j9TverdZAc3c2rrfibeZXEl-Gra2cSrqtpurox95g>
    <xmx:XlW3aI91u73EWOijqCUebvz8QNgDEVEg6oJU7qGwb7SyJfQxbffQi9SV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 16:36:44 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/2] doc: remove extra backtick for inline-verbatim
Date: Tue,  2 Sep 2025 22:35:47 +0200
Message-ID: <7ee982e22450c4ef4ff3c89de2ce83e6e5cf10e7.1756845314.git.code@khaugsbakk.name>
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
 Documentation/git-fast-import.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 3144ffcdb68..e7d1214d2d1 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -647,7 +647,7 @@ External data format::
 +
 Here usually `<dataref>` must be either a mark reference (`:<idnum>`)
 set by a prior `blob` command, or a full 40-byte SHA-1 of an
-existing Git blob object.  If `<mode>` is `040000`` then
+existing Git blob object.  If `<mode>` is `040000` then
 `<dataref>` must be the full 40-byte SHA-1 of an existing
 Git tree object or a mark reference set with `--import-marks`.
 
-- 
2.51.0.16.gcd94ab5bf81

