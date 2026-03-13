Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB643B8931
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417886; cv=none; b=f0x4I+oDjXWlFGuTe3hbPtHVKZ2Q4ipUIlscorlzBcITEp7yvymYkBBbrBAHLqkuXj6LruMXknLFwTLKsm5p36T/Y/tAEogkbiJ2ruQdjrh9idBUXHhFW/zOraKEzO2FTFovD3dx+8sL1IXdDYxZhZicRyqB3I67iLCQQRHXi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417886; c=relaxed/simple;
	bh=hP8DKrxQ2Wl43pXxp72lsqZojm5bCNcwONJsyUrNUM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEWcSI+00VzMAwjHirDNfIw+uc9euylbXbVuCOLetQTjs53BLsrOP/2YJYzEIXH/NrUUaTAU+ZUXYyje+Y6NbT8LAREUxWFfwCinFApLXSmKhxibajFDf2YvBj4sG/2oxjKzFaXcR1Y6tQ2exafy8azJlpdqvjK8Az8FpvXzvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oKxJk+Nt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q+2HFfNb; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oKxJk+Nt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q+2HFfNb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A88741D001A4;
	Fri, 13 Mar 2026 12:04:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 12:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1773417884; x=
	1773504284; bh=OSymcmi0e6zIdbnWZOWNjr2JGPADaEt1E535zF1bjEA=; b=o
	KxJk+Ntrv15587KlnUzIFAaM8/pmwVHB/PSOAzg52KdtmqoicbEvLa2QwQLmXUGq
	S4BRiXBTS9GhLB2fc7WpGITolLeXCp/8SrrUbRYjAwO1LdQpwE92q77WLRnsgmLd
	zh1TPaHys5+nP+wkvG1rgDitH/lcAFTFNqoQreLwcMMOqst2YWmj9TjVlUSh+6ml
	4sxkPbxzx3xfMLs5JLbx/cyjr9O7pTDWkUlr031a8/0GW9I5mfhMLdc+OuiWcibz
	DIeI3YshYbSO1R7zf0GR7UA/jCmp9wRysusmXr8avcq7FNx09cGizih3GUuS0s2t
	7y48RZI2Pvsr62FTKErGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773417884; x=1773504284; bh=O
	Symcmi0e6zIdbnWZOWNjr2JGPADaEt1E535zF1bjEA=; b=q+2HFfNbjJ1Vsljd+
	BSPtUl234V/SFvmtGIAJLJcifwe78Huz9Pbe0/FsdWldWSJSAUOgQYxvtGDKb532
	nc9FFLExGJG+CM4QjfHhmQ/+TtO6LkvAIUSDlD/8EN7s/9cuRTsKzjSzaTgAC62m
	s9CHmuydI1YvnbHdMieycuIMqucCLVzAf62e6lKfOFpcNAQD9WW440fCW2vNSPN6
	vYqhSpF2ndAWB2u3TUEd6pevDdINmGqyYD36cbLf5eehEg8y2ALkylZiGmYsXJtV
	2Zbw2+m39ZGMqHy6W1DDIeHzxUUeoyfcRXKR985SB+a4Mz1z4cfNjNRP0Mpw6LCn
	WBHfA==
X-ME-Sender: <xms:nDW0aa3Mdy8T8Gc1Zq9pPWHsOJzcG-Aidqq-CQdYjesVlGc2po2cjv0>
    <xme:nDW0aTEz9WXIk8YPQ7YDwc7N4w_K3WnEefeTGpOmW6CYKf9KNn-ngzVwsLNOAXwnZ
    rCtnuqWdk9BW_bFZAqrIqzL79zY3-7SuH2-ghOIZNyE75QkkBFZfQ>
X-ME-Received: <xmr:nDW0aQjI2Zgg-AVBRAGCEpGcj-DROthkdltZ_96bU6o7JrZyBETgvj29MSNRpTB2SF9wPhdDezHo5pgOeO8pxN7SyQqQLbA4shAFJ0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetke
    eftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:nDW0aW-kqz0BSdbdt5OxL2n5IP3qqJrVm-VRsYCFFn6FWYPfz5lBZg>
    <xmx:nDW0afo66znWD5Qh4CN-ggD9UiMiL4TZlmG5Z_RS0MIBR8lrPidaQg>
    <xmx:nDW0ad-jNMjQAWpvrZw4JKfIuwTETloGciU-D6VgjzG-SSe_xMogkA>
    <xmx:nDW0abXSzNhPgTKaG5N3GncfttWweR9JGIH68oJbzHx3JvT4xnA2ag>
    <xmx:nDW0aWO12eskpb9dNKoVALRy3vw6R4wZgLnVbny6_qxFNGro289JVRgd>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 12:04:43 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/2] name-rev: wrap both blocks in braces
Date: Fri, 13 Mar 2026 17:03:37 +0100
Message-ID: <name-rev_braces.4ae@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_name-rev_--format.4ad@msgid.xyz>
References: <CV_name-rev_--format.4ad@msgid.xyz>
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
 builtin/name-rev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6188cf98ce0..9d2774f3723 100644
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
@@ -516,10 +516,10 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 
 	for (p_start = p; *p; p++) {
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
-		if (!ishex(*p))
+		if (!ishex(*p)) {
 			counter = 0;
-		else if (++counter == hexsz &&
-			 !ishex(*(p+1))) {
+		} else if (++counter == hexsz &&
+			   !ishex(*(p + 1))) {
 			struct object_id oid;
 			const char *name = NULL;
 			char c = *(p+1);
-- 
2.53.0.32.gf6228eaf9cc

