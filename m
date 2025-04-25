Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53C2367A6
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564950; cv=none; b=Xrs9L8zvrrHMPhAzCETuaQwcQS9MaSphUuknhf8PDScMv2qCa5e/k+Cw6dZ/PSpE8TJps0y9AHSr/U9jlgfrErab3WwE/WzDZ3bThhwBlCdzCH1i1kgdaHDLuSR2Qr7qHbK9ox8JDHWAHarVTQk0pDcCgTLwdnsnZBDLlMAjSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564950; c=relaxed/simple;
	bh=keDuK97SRhEic+zKTv6QoePDwaQQtHvco6WA4JrSNGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpsH7dANyuC6rIG4oWekZ2FFgQ9w8mFKarsoYUZo5RGSlziB6eliZjVM7VN3wjKFMwj+7T/TtX013agIJdLhwN3C5JZAPtPQkTHsj3RPB4oz1tmM8xDLJAi1mEdvfkPIJgn09OTL33+3hEeSxvo47cCHk+DyzRk5eXrdywyYo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xDSYFxtT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mqnZRvJg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xDSYFxtT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqnZRvJg"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EC8F1380209;
	Fri, 25 Apr 2025 03:09:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 25 Apr 2025 03:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564947;
	 x=1745651347; bh=Crq5DH38ypZT/G5Mt4rKKuFkxtJfv9Ti1JXXqsoiDLc=; b=
	xDSYFxtTD0lE7icpEXkFYv0p3ySHtF5CQG/QbDk+8LO8Yb7OCyA/bK1VbAJZEpAv
	oIA7MZ21AVjiT4SGQ5ie7Z86jLcel8VWGkCAHOuqutMbjxNnk0rog5McmyWp/hV5
	HdMLORvDQ76LVluq+UIkU+pTPZatzxu4Vs2b+m/Awoh+U4FFTkADG/zymiOucR0p
	u8Q7B14Jv+jBYKjCxmWVriBSb5uAEf/OA0gMAUj4d5KoT20LOhaz11ehom78Hsk+
	r9jh+s02CZlQag3MeA2232yMUDebjxWPpzV5ASM1CWG1uy9iou9QX7CBr4FmYCdS
	WfZb39ijMg0+yOTGBqbFZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564947; x=
	1745651347; bh=Crq5DH38ypZT/G5Mt4rKKuFkxtJfv9Ti1JXXqsoiDLc=; b=m
	qnZRvJgKZVJNd53w+zVuhc26rsYnxN8Bf2J45PHXsx642GD79IN1I9UJMf1KONtW
	RZxPJz8tymOFpw+OTG0PXssrxy1TmJOjg2OYcnGlA+xa2VVL8jFkjHv0ONmFvJbh
	2zvG2/2KT3zY2RfwtwTlrkKdbtFd0ZVWlDvBiIj7U2F+MiIL+P64cmYGXgfWWhSh
	Bkqm3I+XHXKNLumVwBnik/KOtW5JMUHUqb5Mef5F0iQcgLKlqH+W/sV8wdFtp1oi
	A0YMZQPESRaHCudNVvWwoh1wA0Bbbw5DJ71ZvyO1oqWGn3xBgspjNIcUhJZe20EM
	FabPNECzu1BaioTlSOSiA==
X-ME-Sender: <xms:EzULaB_njRS0RYSgo7xXAhpT6Yua-WZVFBZl8VeVpJBfOrp9MJ9K5A>
    <xme:EzULaFtem3iIVsXwufT0bpcIdCXB5J0tdlHOXRYdtSLEsUf8qcr9QjYRK-ZY7qO1u
    lmKnUFgSQqCZdDl0g>
X-ME-Received: <xmr:EzULaPBGMc597xIvHTXwvOngd3BtGcvTpioOcqCPCo5P_w0KaVnChGZL7bjDuPCpV-nA5neh1CiHH4QtLSwV62y56Yz7xVxc7ZvPzGlF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpefftdeigfegteffledtkefftdfghfekkeekteel
    leekhffhgfduheehleevgfetieenucffohhmrghinhephhhtthhpphhrohhtohgtohhlrd
    htohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EzULaFdA2tpK8evQ0NQg7x5QRzH7z1gFojRquW4hhUzI9fK91Ukz9w>
    <xmx:EzULaGNTM0O5qct0ICJZkI163cS6JaHWMU1F_zOYomk_6zXvuq-dzQ>
    <xmx:EzULaHkP8PPHXkH5DtZQCNFrbZj3ssqaFj65DN3Azc6YZKnjTQ0W1Q>
    <xmx:EzULaAveRi83g40bFolIeDZa90foxanPgBE_Eh1lPj6w0bbu3mP9Cg>
    <xmx:EzULaNrWeOyM6rQ08RCaY7oZdbXDRHe9lbTxUMs2a7uiREIU9wSa7Gkt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65afe270 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:09:01 +0200
Subject: [PATCH v2 10/13] http-walker: don't fetch objects via promisor
 remotes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-10-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The HTTP walker is responsible for fetching objects via the dumb HTTP
protocol. To avoid re-fetching objects that we already have locally we
first check whether the object already exists in the local repository
before issuing the requests.

This existence check is done by calling `repo_has_object_file()`, which
will fetch the object via a promisor remote in case it is in a promisor
pack. This fetch does not make any sense for us though: we're already in
the process of fetching the object anyway, so fetching it via a separate
connection is wasteful, but should otherwise be harmless.

Fix the issue by converting to `has_object()`, which knows to not fetch
objects via promisor remotes by default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-walker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 95458e2f638..5ad2eae9a11 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -138,7 +138,7 @@ static int fill_active_slot(void *data UNUSED)
 	list_for_each_safe(pos, tmp, head) {
 		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
-			if (repo_has_object_file(the_repository, &obj_req->oid))
+			if (has_object(the_repository, &obj_req->oid, HAS_OBJECT_RECHECK_PACKED))
 				obj_req->state = COMPLETE;
 			else {
 				start_object_request(obj_req);
@@ -496,7 +496,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 	if (!obj_req)
 		return error("Couldn't find request for %s in the queue", hex);
 
-	if (repo_has_object_file(the_repository, &obj_req->oid)) {
+	if (has_object(the_repository, &obj_req->oid, HAS_OBJECT_RECHECK_PACKED)) {
 		if (obj_req->req)
 			abort_http_object_request(&obj_req->req);
 		abort_object_request(obj_req);

-- 
2.49.0.901.g37484f566f.dirty

