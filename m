Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942831B83B
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415209; cv=none; b=bsW3Nnm00Yz1W6pyt2TwDNDi/j+OjbwdXVQnUWz2efIhF7g6i/cR6bbgu5pKiFap6Ax8+/a4TJPWi7hbrvFMzUoxHfxl5AEmGVqpXTT4KAVBgHud50nkldfDH87A5udFbFH7tOO3NB2VNDMkWRxXu0WH6V7LtQCp7mvCppy3nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415209; c=relaxed/simple;
	bh=vSdKdgLF/kpwIQThsr/tX0GbbWG25qfbnmgA4Cp+ZZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB/toXJPO4tgiG5n/Z7dGYZJphQFFM/7A2ZF5MNcweieqXviCfTC1yAMQRWCcP4MXaxj7UQYxImadC3c1Nd1PyHjGRFaXCNILXcEaPxO9OuEqTD2Y80QcUeJOEqk6eciiKivmfqhMgrZWFAfufRw2dAq/HLmeFClr0e3WusfrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nscVd0xg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PGBxEscB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nscVd0xg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PGBxEscB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AD33E1D00071;
	Tue, 28 Apr 2026 18:26:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 28 Apr 2026 18:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1777415207; x=
	1777501607; bh=pY+H8NwtO+t1ql7YvawMFRtzssRl5Duf8w45sdQE8+g=; b=n
	scVd0xgTPfwV2NpcZxz7GlybxKu92WR7iPbXncIhMbedfoOxvpfjCMwqfiVB4Kxn
	YmcFAXVqPRr4EjAzxaGn0ykQc6CtWK6igrF1H01ypmNA3ET1tKmnizltMCd8HDqR
	J+d1XLxMCJo8mPCKWPorseFMjDmWV+EDZNB7kkfw9TxmZRCoWtsaIvEUFDf+TRjo
	Bm10z/o+fGpjwUJkGFKYcELjgTJdvn34bBi84ki1RDrOD56640BTr3d7oZnQTiCB
	QsbcBfv+x6vfjlfOgTWhml8PCOFZLfEY97oHikcv1A1CDR3p22exBZZ2QiyklM0U
	YMK/0ObzVtksRcCTrAu6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777415207; x=1777501607; bh=p
	Y+H8NwtO+t1ql7YvawMFRtzssRl5Duf8w45sdQE8+g=; b=PGBxEscBA3ZX/rY0I
	GcBsNq3FDI3AkMhU+Gd1plKOPdMy8t2HSOR8JaWQqFvivHbLBplzFYBAibvYHQA3
	6/yKGo/bCSV9JHGMrBOVwqifEKBUB2+TVqY+t6SUN0Y0PrNoGC4xQrU/97FpHNtE
	DHNwwuPwSBZJviuzhKkoIMy6/E6biMjOGKVUAUHfG1zxLG+oxTKITMkbI/3fbvqY
	Y1N1uMozQKNFPsEyavSFkVyCrd0lvceko1pCIiwwilXX9JaOAEH/9vi9kwwPW/44
	k+jaLlRJc2Ld498IzLDGs4Y7sqgjsRQh20vQz0jVp61k9doxjZvXPGTQ8sIGUw8D
	Lvdwg==
X-ME-Sender: <xms:JzTxaQ3jH8_5R2T-i_TswdD70O6Ynoos-TX7kS24WUnQJ09brI0vuSA>
    <xme:JzTxaShSXx5LUPgHhzO_baSGpA1HSr-o4l1h1ovdmP-EQTkSqHVGKHAI5X4SnIomi
    v9quOTrWSC9onMai8v2yPgx9xbBtbvHayyAOfLwtJUyK1wwCpCZ_Q>
X-ME-Received: <xmr:JzTxaWTzwzNiiMVEUWeY4Md63MVaMSFj1CcvoTY6MTX7E7Ixn69aIDXKn-cUAvEnh1qUtjnO9ogctArnFuZ_XemW4xLqcExBYMIwLdKqqyZraigZQ-OmeD67Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepfeehteekfe
    dtieffvdejteeutefhuefgtefgtdevhefhveffuefftdehiedtfedunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JzTxaTj9FBju9TCy0x32usP3xv-6h77WWkeIbS4BiONZut_X5KEcwQ>
    <xmx:JzTxaW6ccYYJNVWuQt_McEyeOC-ijyce5LBC0FqMvs_xx5Fr0f-cXw>
    <xmx:JzTxaQDw4_TmwkhL8ryrrxmhhscpxNw73h4SCRKiTgjQev_IM4v6Xw>
    <xmx:JzTxadY5gLyUV3DnUy62bBjJTBUmKW8F7GdzAnkY5yhxWN4ItNfYBg>
    <xmx:JzTxaWg-8ub55bK5Imtu0fpdmBcpxgVo82pl5pU-7irxnA6DGhIbfJrX>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 18:26:46 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com
Subject: [PATCH v3 1/5] name-rev: wrap both blocks in braces
Date: Wed, 29 Apr 2026 00:25:52 +0200
Message-ID: <V3_name-rev_braces.66b@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V3_CV_format-rev.66a@msgid.xyz>
References: <V2_CV_name-rev_--format.51b@msgid.xyz> <V3_CV_format-rev.66a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

See `CodingGuidelines`:

    - When there are multiple arms to a conditional and some of them
      require braces, enclose even a single line block in braces for
      consistency. [...]

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    Fix stray formatting of `(p+1)`

 builtin/name-rev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6188cf98ce0..171e7bd0e98 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -466,9 +466,9 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (!n)
 		return NULL;
 
-	if (!n->generation)
+	if (!n->generation) {
 		return n->tip_name;
-	else {
+	} else {
 		strbuf_reset(buf);
 		strbuf_addstr(buf, n->tip_name);
 		strbuf_strip_suffix(buf, "^0");
@@ -516,9 +516,9 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 
 	for (p_start = p; *p; p++) {
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
-		if (!ishex(*p))
+		if (!ishex(*p)) {
 			counter = 0;
-		else if (++counter == hexsz &&
+		} else if (++counter == hexsz &&
 			 !ishex(*(p+1))) {
 			struct object_id oid;
 			const char *name = NULL;
-- 
2.54.0.13.g9c7419e39f8

