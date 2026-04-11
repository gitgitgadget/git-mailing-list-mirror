Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F72D7DEF
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775938820; cv=none; b=Ecueju6swU14qhDyRgWWl3RGEKB+Kw/d7Cy0il6AI49LN0QMPf6pYvsP+5YgWAFFsCCZlw/gFYuQvVOhI3pRqjcQ3JSlHHla+k7N9lcOsne4nSgbpNNLnm0Xpb7QPfDVDN9QaDPJAfBiMaYGWZBaEuddCkcMbHg9TQVZ3lPG+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775938820; c=relaxed/simple;
	bh=DpGCKyWDxwWLb2Mmv/CVAxqr9OpWScI46b7ZURD5oGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlzrSiX1rOJh0RI4qGRr/FZ0BCsp6XwWB26gQEoDkjwfmEx8GHRNO4vjsU/MYimf9jeWVzOMtTVuQNqbf4OxGR51rJtzAp2oRAoPC3LVnhoKy0kloEGo7qdDs/jIEsn5L2wuf2RQFPMzKcq8XazmXK0o/5u5c6ZajghIKhbN3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PMDbbza8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6dzGO4n; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PMDbbza8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6dzGO4n"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 541B6EC00AD;
	Sat, 11 Apr 2026 16:20:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 16:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1775938818; x=1776025218; bh=v+f46FSYg1seWIq6R+pxr
	M5VLsh1hz/Nvwlm5AOOX3g=; b=PMDbbza86LwZn6pezESKVrgaT6v6bU5XU10Y5
	n4esM3HIU50vE65tOof3d7F0o4b56vi0gK/gBHcv53a64AKZJDaqiF5v8Q9Vw87P
	DZuCnDsaQNPc6mnYZmUwmDkNl1fv7ccP88MEIrcFEf0pODf8wJWgeqgQ9ZJqcUqE
	Er1Lrm4NObkVUdycthqBo39SjrEnC/PLFPMoTRrZ5Yl9PA1+y+mOmNgFb3EeSQiv
	L/kK4hAU2xrv45mAJiuLmpmWvg40yNAZwicaogjACEyWV1tI6OsD0CAQStV2mb+J
	WcO1+v7EjXG0eAwWqQ9I7fgo3ITwOkgKpIhcY/mhYqvyYUFXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775938818; x=1776025218; bh=v+f46FSYg1seWIq6R+pxrM5VLsh1hz/Nvwl
	m5AOOX3g=; b=T6dzGO4nvmxijMs9RNvvg9i6VKZrTUa2YO3hF9clotIJicFHP6m
	kS765jiSW+0QI4T/GcX2rJOmFeoIpQFZspBe2jXjE4U/v6KWMuN8iDGGDmaqrNKy
	ORdpteyZX4EYHDGHZxUpKylSkbjtY3bPKMOGy8NwSIm/a6DPM8RMT+VzYK4jPXXe
	PqbG85mfKWdsPXgNc97FwH96qYTR3EC6XKVmD0p7xQFb82jZo90c2BBfogtHrKJ9
	msQBH95YqPbSP5zIz7wt2UdsJgb0ND9YLyAvVhYdHlpA6xDAwyhZ+8YMvwhdC5Of
	oFpwfhaNqgcYHXbskn7TkpepDO1QDMIlQWw==
X-ME-Sender: <xms:Aq3aabBzRUpS-FRitTI48LxTMxfTfhSSTfzLaMeA_TWwkItMfgqOJ5o>
    <xme:Aq3aaXgBViRmHfA_lCcKfRCy8WcD_VuWtG9VrvFC8GbLLWDfb7DGGIpel8JGs2q6w
    DBRB98bwEfniPrJyvQjBYwtbn5pSfB_hyQ0PTcwLQSZcLxQouCHhw>
X-ME-Received: <xmr:Aq3aaUNm2VxBKRgBCfsrCEAskwSnLpGYL6CGvJKAWPWc-hqR_RnGO5-d4UFJqYPkljlxmNndZnDDI6dK7ZB9_O3x0Q10P7xLdh4VyNraSI0VE6HIrwUay2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofgggfestdekredtredttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepveelleeitedtud
    dvvdeitedvhfelfeffvdehhefhfffhuddtvefftedtfeelgeevnecuffhomhgrihhnpehm
    vghsshgrghgvihgurddqqdhnohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Aq3aaY4FD2IbvZ6XgkicSHyAUxQW8gZC9YmEDHghJ0bjHw6eK__wTw>
    <xmx:Aq3aaS1vEWxK3Cz3j7r7SLqxQjLZdg0DlzNhqDgVgCNANksfSe6EMA>
    <xmx:Aq3aaZavYs7WPBhl5gH-JeKD0-zV4I0hzGO_IZiDnDQNcSHhfZaUww>
    <xmx:Aq3aaaA5ole87-kPxuNpZ-5f5L-kNL6TQ1bUstMLeR8obPonQRXiVA>
    <xmx:Aq3aaeYZTnrxXEL5li_KOG9tsjPstlLRw0pPbVfcGL7MEdGvBz9hmtgY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 16:20:17 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: am: correct to full --no-message-id
Date: Sat, 11 Apr 2026 22:20:10 +0200
Message-ID: <typo_--no-message-id.572@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
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

Notes (series):
    I should have spotted this while working on topic kh/doc-am-xref.

 Documentation/git-am.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 384e0cd7f9b..26c6670f6fc 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -92,7 +92,7 @@ OPTIONS
 
 --no-message-id::
 	Do not add the Message-ID header to the commit message.
-	`no-message-id` is useful to override `am.messageid`.
+	`--no-message-id` is useful to override `am.messageid`.
 
 -q::
 --quiet::

base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
-- 
2.53.0.32.gf6228eaf9cc

