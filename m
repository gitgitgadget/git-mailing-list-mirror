Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649416F0F9
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193038; cv=none; b=qu0kks4Nbwaw15zK4INftlQGUoGatOG92DOxZVwEyYAaHi8kKUZihA1aplpyg33VtLVpIBNXjEfmmDSDuwyzlBJuXAbzpl2XhkCvMO3MPN12KqbTYN3VFNtHXxrOYfM4qwh1sz/bx3pkcO/CEV3KzbkN41YfbrsHLOA6r5CcRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193038; c=relaxed/simple;
	bh=gPS+ij9tj5OfUHbttdvy4yAMi9uHFA/TJDNHAhM4ldE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKVO5ZUPEXRm+G1p/O84ZrddhoZl9eRIsQ9ul1MddmpgnboGDtlODbDV6CcDe/OGrruTh6LHBFhRG1eqdh5xtAgd5okSy0imyi4GJ8FlMjdm0itfak6XONl1l3P5uRy6QlcMbqiu/2AAQm/0kBSf5rsPmRBdPaeBx6yfLkqH3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me; spf=pass smtp.mailfrom=dwim.me; dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b=W6JdtVxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCtGt3Hl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwim.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b="W6JdtVxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCtGt3Hl"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 91C5C114019A;
	Wed, 12 Jun 2024 07:50:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 07:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718193036;
	 x=1718279436; bh=k3nxCR1tO/W7AGlOjP14XNZQRr1pPGIKEJ1qHctKBhc=; b=
	W6JdtVxfLJ5Ix0r/KFaSiLSzIRRxMWq68lcLUCyWg1VkrEQwnbxkKa77u9W4TFM0
	7Cubdn0zDfyLK9l8wvDwehT9NCzU5CKQi4mWplasdhp0Jzrpoz9IeYBf8d0M/R7F
	38qJFvSaQxaPHheTobsh3hLvZapIeOdXMcjKhqg5PlYtrgBtFcMFZK9kKvzSFhgY
	jgLolS3st7GzZD7Ph6ccOrUc0R/9BYH00bIhvZs3ijN6Od6ugpYQ+1t81ACveqkP
	udjCOJ6aJozQ7HQJe6/8ZrYmn6LcYnJJDcoh8QA8M0uyd7RjcDyo195FRpJPlSuw
	PNbMgb7gDzEjDxMSmBEG9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718193036; x=
	1718279436; bh=k3nxCR1tO/W7AGlOjP14XNZQRr1pPGIKEJ1qHctKBhc=; b=c
	CtGt3Hl5YbUn1xhZ5lGRrsz/TA2KxT91CQ8r9cEnowj9wh1YUSFDqR0Bw4/YZV+n
	ItbvMPGCH6EHXmnJtQEaA+eXmkd8uRtF4OBQ6kG0uLdEk161ApCPheYPS9GVXU7v
	BERoqwjWjIOLnnOWdqRZDwAMCThJTGXkJsRZmsPxPH5aP6PXvpc9qSLB3d25v0SN
	dtn63oKWydA3u3grnzjCLU4rr8BxRSPLMz8mih119xEog5b3Y0kpr1rVValKZPfr
	t8EvnCh2XslFOm+vh1/B0wGKfHhLtuArb4PrlBT2A8EhMVSv1q4YbTwSIsRZz7iD
	uI4cjzK+Pre1r2KBZ72zQ==
X-ME-Sender: <xms:jItpZpQCUs1NEFTqWKJdKEPCzQ3UwB7IeRQPtQsiI-6N8sJU82GNBw>
    <xme:jItpZiwtohrkOLCAV_K5IMQb-WtSYeJ2R23lJ15oi0sJ1Nd2ZSQHbEwIuiKBMDNRU
    UveYYEk6GkIOGOW7g>
X-ME-Received: <xmr:jItpZu0bk89smXybK-nkH9WwQ5FYJH-QIkXteAqfLd6mruAqTN-P-OJ4YYh5gzFrCAt0YnOoAqBrdcvFH9pliklV99tEfb1_VPhq6LCqZLfjrlrzHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepvegrrhhlohhsucforghrthovnhcupfhivghtohcuoegt
    mhhnsegufihimhdrmhgvqeenucggtffrrghtthgvrhhnpedvueejheettddvveehtdffte
    elleejfedthfdufedvfeejvdelheeltedtudevtdenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegtmhhnsegufihimhdrmhgv
X-ME-Proxy: <xmx:jItpZhA-GRZZF2nwqBCzXfg1EPIvZNPICxtYkBtkVpGIgLoKmfU5UA>
    <xmx:jItpZiiRhWkxxRIT4yeymFDzDgdAMEMWROZFkFFZ99RRL66lF2c4uw>
    <xmx:jItpZlpaD_A7Nz8M6sx4nMgk-JLmENaNjaEzcG_eZoCnbHoLN4XGIw>
    <xmx:jItpZtjlS8t0OkmvBWIz-sWbYTripYI74-25_tLpRh4uhqX_yhBQrg>
    <xmx:jItpZlub8h4cFFbRU40TyydVeadWgyKRJvoUBLl3iLOIlG5XVfnw6MGX>
Feedback-ID: ifc4b4307:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 07:50:35 -0400 (EDT)
Received: (nullmailer pid 1169215 invoked by uid 1000);
	Wed, 12 Jun 2024 11:50:29 -0000
From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
Subject: [PATCH 4/4] remote-curl: read in the push report even if we fail to finish sending data
Date: Wed, 12 Jun 2024 13:50:28 +0200
Message-ID: <20240612115028.1169183-5-cmn@dwim.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612115028.1169183-1-cmn@dwim.me>
References: <20240612115028.1169183-1-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In these cases the remote might still send us an error even if we fail
to completely send the packfile. This can happen e.g. if the remote has
set a max upload size.

If we just consume send-pack's output and don't send anything to
remote-helper, it will not update any of its structures and will report
"Everything up-to-date" next to the error message.

Signed-off-by: Carlos Martín Nieto <cmn@dwim.me>
---
 remote-curl.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0b6d7815fdd..9e45e14afec 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1114,15 +1114,25 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 
 	close(client.in);
 	client.in = -1;
-	if (!err) {
-		strbuf_read(rpc_result, client.out, 0);
-	} else {
-		char buf[4096];
-		for (;;)
-			if (xread(client.out, buf, sizeof(buf)) <= 0)
-				break;
+
+	/*
+	 * If we encountered an error, we might still get a report. Consume the
+	 * rest of the packfile and an extra flush and then we can copy
+	 * over the report the same way as in the success case.
+	 */
+	if (err) {
+		int n;
+		do {
+			n = packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
+		} while (n > 0);
+
+		/* Read the final flush separating the payload from the report */
+		packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
 	}
 
+	/* Copy the report of successes/failures */
+	strbuf_read(rpc_result, client.out, 0);
+
 	close(client.out);
 	client.out = -1;
 
-- 
2.43.0

