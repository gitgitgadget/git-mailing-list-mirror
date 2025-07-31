Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9631E2858
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002490; cv=none; b=SHB197z15/kV6ueqNHPjFrggyGFNrmv6T6PO2etvLB6kKjL8t8n5S9n+UrSuvNGc/3Fn5KvJY85n4kOMnQJM22FGY20NuylLTuHusU563Z2SoTPSG1rO+UL9AQEI8GgwrV5OB1crdglDJGoi2BywoZ/zarssPlmoL4ZrcIYQ7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002490; c=relaxed/simple;
	bh=G/lf0jzvYr1BbLJAVpnP4jOM6d8C/o3KBuMt65klZxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhrQ6J2jZtEgtLS3ri4WORTQRAVxrgc5gmhl3JigFoEWIYU3JkPd39CUO7ijblFkbKSPEu/wP/nH0/woyci1PRBBLiF400hphS5sVVB0eMT9obw2u9lBM4Nmv7JhouFS1phlaO1K2nXL4sDMokbrN/bXYXL0qXS09+bfNoZ1MFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GWIUL92n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVAd4NLG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GWIUL92n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVAd4NLG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 333EB1400301;
	Thu, 31 Jul 2025 18:54:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 18:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002488; x=
	1754088888; bh=iVfmrqidp0w4OyCBCojjNjG8Xsl+fsGiTa6dgA7BjYk=; b=G
	WIUL92nQfG8M1WpCLVA+ghN8FvRsS+e/r/Klnnki7jTOCImiMii5yGYR3XYU0lQK
	/G6WK461oDV8Wj/MJ6c5M2jh+ltfD8km7b/0PP/I3HfnftMvp/cKpe/7rPCpJOJM
	LIstQP9cqCqBeonqk/kdLxyAT1upuaOqDArNSdvL9khSc4pSYeUXI8zeoBFX3w1P
	fjUuVuDN+8BdskJWcva+tHm5/MPvYuYROaWLL1kvBpLjuYGI0UZlqPv66T0Fri41
	LD5Nw4oMuS/z/EC4mUvw5einYJ35e8gmGhxspnek0x3S3fh0KsFgLPMhdK43kuC0
	HV9exM8T+Q9aCu0agLkKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002488; x=1754088888; bh=iVfmrqidp0w4OyCBCojjNjG8Xsl+
	fsGiTa6dgA7BjYk=; b=aVAd4NLG7qDGcI/UyS2Lve7tuTNEfbCC0siT0/CU74n9
	j6sPNn7oR8pRNRrGlj+mHY5TTRSFWIKC54rnJkaKyZjtPd7xwmgvbEb9yoCZ+LFQ
	NyJI28UlYLC3jDang674ssnwbN5dTzKLvloXbzkW+dAXT7wITYSzfxJze3jSB9Wy
	RHNWo1rhNB3fIZXgyfzdvJQHkwZn5nJgWwtn9qU365vjDbEjlUuZn9zZ4Gord/RG
	OJYOqFBPFgrRcUbyrzLsoBLGQzdFfajPGK5BxwqU4JrKG1OsQpCNeP8AYnv0oaXo
	lKgzmDFSrtMFN8ifZt0O1pDz0+NjaMnC/2CyDh9Fyg==
X-ME-Sender: <xms:OPSLaIuEfd-lxDUMk7p5WDwnJgIP-fmqrNKluOs1EIFIEwrZcMzDQQ>
    <xme:OPSLaFpH89uv9rpQLfIP3sqVCu5U1N1MrU4RXNzYoDIbbgT0kbPrjIb9yk-6Ir19o
    DqlNW7Yqd38rc0jtQ>
X-ME-Received: <xmr:OPSLaFmGgjPEPbXL6EESXBAatPwVQIzoW9vDnhIV1cmZnEcz6Op7CQR3PNY_OlZs0lp-uEAN9NMxqTOYCBJdKYr4Ty273wT0i82RcIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepieenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:OPSLaJynGSWXtx9dH5spn0YPC6ImRWlKsTWnFMSnxo5ykliklNbX7w>
    <xmx:OPSLaNlw6kHeD7BTx_IjyXBp9KjAQNQ0ukDdUMmiv9VJZF-AJNKasw>
    <xmx:OPSLaCe11cMyabSek7D4nxZJgFOl9kOLjFMQNo28hm1Kp1WzW4hK4w>
    <xmx:OPSLaDojheaa4ilRWhsRoYumlw9V1k4Qt1Drt-Q_xIgcU73gfOSHOQ>
    <xmx:OPSLaLSh-txh5rViUOXZASXUqT0b4aYNywCpOpTROS2cgSphbQI2TUV7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 09/11] sub-process: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 15:54:31 -0700
Message-ID: <20250731225433.4028872-10-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to read status from subprocess reads one packet line and
tries to find "status=<foo>".  It is way overkill to split the line
into an array of two strbufs to extract <foo>.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sub-process.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 1daf5a9752..83bf0a0e82 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -30,23 +30,20 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 
 int subprocess_read_status(int fd, struct strbuf *status)
 {
-	struct strbuf **pair;
-	char *line;
 	int len;
 
 	for (;;) {
+		char *line;
+		const char *value;
+
 		len = packet_read_line_gently(fd, NULL, &line);
 		if ((len < 0) || !line)
 			break;
-		pair = strbuf_split_str(line, '=', 2);
-		if (pair[0] && pair[0]->len && pair[1]) {
+		if (skip_prefix(line, "status=", &value)) {
 			/* the last "status=<foo>" line wins */
-			if (!strcmp(pair[0]->buf, "status=")) {
-				strbuf_reset(status);
-				strbuf_addbuf(status, pair[1]);
-			}
+			strbuf_reset(status);
+			strbuf_addstr(status, value);
 		}
-		strbuf_list_free(pair);
 	}
 
 	return (len < 0) ? len : 0;
-- 
2.50.1-618-g45d530d26b

