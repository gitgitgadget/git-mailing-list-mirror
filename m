Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC821D5160
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196180; cv=none; b=Blj0BmxgU96SL4mk8kAGPLthLQwy1vdt0SGMuupqj9JlSkoKN5XR5loAP5PprrEIl3unxTYBw0gvI7PuBGqkLBz11bHLbmIJUd+FA3i4aAgPgn0ZP1ZFdwq+/LJKAG9vm3WC4eeV2zfYVAHwcO0i4JIDwDCaApFNq1QF7dgBX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196180; c=relaxed/simple;
	bh=xSNNEPJLvvR/mTsLP+yL7AWYMaex/XeQEFjPko3tgjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjWOTCcQHF0hzAqlsdyYsjMcmPInF4ti5ojINXQulfH8+xxgKUX+dqXPvqTiaVaoOcNmjtl57F0oV20VtlSF5RJ8OB5ah2xwYhEhoyz3pNSyvEb+Q9n6PJsSa1/YkaLx1rAH56Rek3OlsXEyzhMOLQJ6mZynIHzrcE+tjI9xl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cBxK8nKN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ktmj/Hqm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cBxK8nKN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ktmj/Hqm"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D1787A00F1
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 03 Apr 2026 02:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196172;
	 x=1775282572; bh=27eGY9wgJl8EHqZIUMEz1hrqlPeEB9DfVJZbDirqD7o=; b=
	cBxK8nKNiK+E7B/eiJB3RRzNCuBfc8D/AzflJiX+tCYqbYbxPNQMlv53qcfqYfqW
	9q4I2A40mpbgz08J1wRa/kec+P2Mj4vhmXVhLsPbvrowj5p64Ybu5zNtHLi5nJHt
	zesTuC669/h7lAbMpQByzkXgTxIgbLQJgy9LjdMKIsV7Du2qCEj5YN9NxLcXOF60
	kgG4RnEjUa8XEwrItB9i14hILo0Gm5vt2Ytxy20ygZa6DdG85fFesCjInzch8twT
	38yfpVwcoqY1ZS0C8v3cFPhM6ex3IHrTiboMQDpj5XFGUXrCPjcGRvwOBwND+vpe
	lMuX4eM0ID/4CPviLt0KYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196172; x=
	1775282572; bh=27eGY9wgJl8EHqZIUMEz1hrqlPeEB9DfVJZbDirqD7o=; b=K
	tmj/HqmHgf03H9f4f/BWI1DIR88QPLUl4N1s2ebxr+LONk0bqCAPAOzuEUsCPzrU
	jut7A9Ha2r8tjZ6Jq0YtjRt8nlGCpCoXiENJSBxAnjtYOua4n6DhwOBkz70ZW1Bx
	BkC0/zGkd917eRLpthaZr/GhTMWkoIKHzlOKCpQunBaRYECVNlmM8UYOFDVO0Meh
	RXNpIBa9B0SivrsIDTHG095F6bZuYfiy1SRjhiH0pzjVvuUJy4sUBeqzkAr8wo8f
	jswU0W+dxelSpWyWKeXgHXWQ8BQTaidoOgMhfxu47P7DCJL+tsCdrLTmY8lkOEcm
	hheuPiT+jO3j/64nHbevQ==
X-ME-Sender: <xms:DFjPac8nktzPvb3f_RuJddmBUJysldvPiP-YCwz0WFCx9xoyl5BFCw>
    <xme:DFjPaboBcxU1PAqFuSN4N5aqSrsdSyfiW97rwqeqKPUmouDWW03BOw4i_vpWFDsUL
    gPLVDYOgEP-GM-QOuwLBWAfRPLJTxmKfY9Ehm4yjl7wvhk32sEEIQ>
X-ME-Received: <xmr:DFjPaXpDH9W0fvSgBB3JH9EPz_GyyLQG3FOcAro3j2bz95hWCITBXJFsziqSxAyCt3YmAgsYTXxNsqvLNZSeet4fq_pW2W_XGXQKVPtMwcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:DFjPaRnY3D1hE7iUd8YBdokN0CCNMzGgjt76AcXROTVhpgNfRaf31A>
    <xmx:DFjPaRFuX0eG81M6Jy4fS_pGASWP99CUbwc9LpjQZJrkcmmETtOSmg>
    <xmx:DFjPaSoQ3BfrTw5_8UqOYvC_hlfCYwD5KD5BM_I8gqeRBbPRK4D5OA>
    <xmx:DFjPaV6n70BFA789ywHx2tQQRPNgis4E954IJTvSw3vx7RqJ4Ge6Cw>
    <xmx:DFjPactfCxzNNi4ziPvsZIXyz5nlvt_JjqPWfHbkYIO1bTop_ttre72j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce974011 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:02:00 +0200
Subject: [PATCH 13/16] odb/source-inmemory: implement `count_objects()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-13-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `count_objects()` callback function for the inmemory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 16182bded3..bd89a7ef14 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -202,6 +202,25 @@ static int odb_source_inmemory_find_abbrev_len(struct odb_source *source,
 	return ret;
 }
 
+static int count_objects_cb(const struct object_id *oid UNUSED,
+			    struct object_info *oi UNUSED,
+			    void *cb_data)
+{
+	unsigned long *counter = cb_data;
+	(*counter)++;
+	return 0;
+}
+
+static int odb_source_inmemory_count_objects(struct odb_source *source,
+					     enum odb_count_objects_flags flags UNUSED,
+					     unsigned long *out)
+{
+	struct odb_for_each_object_options opts = { 0 };
+	*out = 0;
+	return odb_source_inmemory_for_each_object(source, NULL, count_objects_cb,
+						   out, &opts);
+}
+
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, unsigned long len,
 					    enum object_type type,
@@ -307,6 +326,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
 	source->base.find_abbrev_len = odb_source_inmemory_find_abbrev_len;
+	source->base.count_objects = odb_source_inmemory_count_objects;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.53.0.1323.g189a785ab5.dirty

