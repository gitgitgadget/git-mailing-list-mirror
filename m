Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B7392814
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903204; cv=none; b=kYZnYBaFGs8t6j5GFK9AFVIZnpBV3Sevu9Tofg8EKIrt0XVpcAV16itRCIrFjAbsadNNSvhN4FdwipweplF6h5038acFPiFpiPGho3Tspd+zbXSOPTPkJGUfhF7BytVoJ7x6KzVN/ieK9s167DJ57toG+p+EI8/bYX4WZfucj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903204; c=relaxed/simple;
	bh=Tg0ublXB+vYdmFHhUx/C0g8K4+f9nF0ofzam/X/uTfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzS1ZqIeMvAdr74TnXdTL7dtiTAik61Qp/Jo+eCeP7q37JpYPvriJcd776/FsNyrTL/XNLKYzKodkpsQEB3GQL4JxT8J53SFZCv9n0vQRZUnBddUsMj+N+olgpQhToMnZwKYiIwynP2tXYnQCZgGycmhFKV+nXwvfFFK+sCvvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IkJmAr0G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m9ON2vAl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IkJmAr0G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m9ON2vAl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A62B1400167
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 02:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903202;
	 x=1773989602; bh=NXZyK+pCh3nkQul9/4nYl0uwOpDD9BzmjDRZfgROBi4=; b=
	IkJmAr0GtyZ0sfurgO+nV9itkQAHfEfyhKJ77NAM4O3oQwqfkzOxwb+j/74mJ1I4
	hC/dfjJ98srxj3X0+q69AwaC3c+Pu0aKBzQ0u+FudEKsIaCRuWtvhxnthVI6JP+T
	lvbLUO42RFfozuR8bJNMir2fkWAgC3AjHBqyeoBU63wrc13l5Tgk1yz6SAmaTcZK
	RaFXNpIC+GKEElbHoL7JP76L2ohBJb26Mxzm/TActEj/Q6qVtLuLH0PRe09LOjuP
	tuHzMSQk47Sht647NeHHh5Ck0eFa3/AageiHbbjT3ARYDTIanqy/6IsCg9mDgCY3
	BBV7jW+eyYXanOw/pObA2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903202; x=
	1773989602; bh=NXZyK+pCh3nkQul9/4nYl0uwOpDD9BzmjDRZfgROBi4=; b=m
	9ON2vAlHovMS6yAZy2xx89k7Gy7qo8KpUzQoJM/PqwmxWk6/EnZx+gZRW8QBiPOG
	VByGc5mI6ea/pUvKQPbgh7YoQ7/rFJELq2mBjAdLLBdT4Vkc5QAoURsBZzfo1xL3
	3O14o+C+JPhjw9h9ye/87KIEagzEB9hXk3ylGLca/e1VBw3mHdM/zx0tHVM70Zxy
	myq86qYiOXhHx0agz8n+XcMr0iG0+WzYRuO8FShPhJMtPc9QMcUUi26QxTW9Hwep
	1Ukx2+3NLe5/kyf0dW01uFZDcnVapNOUNsQbY9mutoXUu7NC47O9bCg9O0RYsVH6
	b2w70U7Y+CO3uz3HpKBmA==
X-ME-Sender: <xms:Yp27aQkgl1pXO2Ymnw-1RHaevB4VL5W7AAvOaZs_v-4U1-6qwq_FsA>
    <xme:Yp27aWzODFYaq-X6kjjAlDFOp6_8wkbzya7xRniYzreDTMzirRKpSy_pVz7jqj3g5
    oCKli90iL22VBEBC3jhs_ii407Wy9RMLGEMkmidTJxavKra_MEmBg>
X-ME-Received: <xmr:Yp27aURXm5QTllwoJdUabs-S0A2TVpc_hkNShC4kcr0n-LW6e8kDYuPw6Rw1w_I-1CZnYxA-SRulZ2rKBR4vvsaDIHKn_ibQzEnau9i3e5Sp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Yp27aRvBsKlHV9hE3BOXfBqtbC_-DxHT2LSr7XSuTm22uTiauzknkA>
    <xmx:Yp27aetvyR3G7PhAeIvCwoerBt3tNrSxlm8j4F_LscasWn3ht0uD_Q>
    <xmx:Yp27afy1oGFKkUu6Cy1KWA-Hzfku-715_owJIl5L78OilEwVnF_Q0w>
    <xmx:Yp27acjtPFDmpH_eKI_q0f_hwVRScgddQGnVvTkgoX3zqnY0Le1TQw>
    <xmx:Yp27aU2Nk3mcgwQbOjiuF3dB36Toa5Dhkb8J4PixH5lW--5FtA6ZNZU6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 989117b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:05 +0100
Subject: [PATCH 07/14] object-name: backend-generic
 `repo_collect_ambiguous()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-7-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `repo_collect_ambiguous()` is responsible for collecting
objects whose IDs match a specific prefix. The information is then
used to inform the user about which objects they could have meant in
case a short object ID is ambiguous.

The logic to do this uses the object disambiguation infrastructure and
calls into backend-specific functions to iterate through loose and
packed objects. This isn't really required anymore though: all we want
to do is to enumerate objects that have such a prefix and then append
those objects to a `struct oid_array`. This can be trivially achieved
in a generic way now that `odb_for_each_object()` has learned to yield
only objects that much such a prefix.

Refactor the code to use the backend-generic infrastructure instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/object-name.c b/object-name.c
index fd1b010ab3..4c3ace150e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -448,8 +448,8 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
-static int repo_collect_ambiguous(struct repository *r UNUSED,
-				  const struct object_id *oid,
+static int repo_collect_ambiguous(const struct object_id *oid,
+				  struct object_info *oi UNUSED,
 				  void *data)
 {
 	return collect_ambiguous(oid, data);
@@ -586,18 +586,19 @@ int repo_for_each_abbrev(struct repository *r, const char *prefix,
 			 const struct git_hash_algo *algo,
 			 each_abbrev_fn fn, void *cb_data)
 {
+	struct object_id prefix_oid = { 0 };
+	struct odb_for_each_object_options opts = {
+		.prefix = &prefix_oid,
+		.prefix_hex_len = strlen(prefix),
+	};
 	struct oid_array collect = OID_ARRAY_INIT;
-	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(r, prefix, strlen(prefix), algo, &ds) < 0)
+	if (parse_oid_prefix(prefix, opts.prefix_hex_len, algo, NULL, &prefix_oid) < 0)
 		return -1;
 
-	ds.always_call_fn = 1;
-	ds.fn = repo_collect_ambiguous;
-	ds.cb_data = &collect;
-	find_short_object_filename(&ds);
-	find_short_packed_object(&ds);
+	if (odb_for_each_object_ext(r->objects, NULL, repo_collect_ambiguous, &collect, &opts) < 0)
+		return -1;
 
 	ret = oid_array_for_each_unique(&collect, fn, cb_data);
 	oid_array_clear(&collect);

-- 
2.53.0.1055.ga2ffed1127.dirty

