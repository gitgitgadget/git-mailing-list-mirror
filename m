Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B72DAFB9
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578982; cv=none; b=ru6TIXvkP3Qqa8+RrlO/kxm6KAumqx5+N2WiMiKtrAmBUcbzIydmpGbtCjO2qctOnT2QTqO4sTa0n4lwnZSc1KfcWdh9v5ukba6fOMNfoa4h48iBRGgxG5ElrcYEuUlz7w/Poq4e+5J8Ffk7D5/ha3dLtFy8d7KcDr715Chb10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578982; c=relaxed/simple;
	bh=v7vW/0L8pz66UKiFa0L5qNBIbLmV4H53eg/kEXBhbeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDHej2PZyMlWhykrM0gVMYJbvEeNI+vBeWd+aFyelsBursCY00Pt6QfUfIwbyWtysIsrkihEg7q0C2WBZk7k7alRMOMzI+qmH60JTG6n0CbRLYXRkMR2JmQLfqNJCLl1wRIBwss5GL8GyfVMOpYlIIfMJNnQAfFCoK5K9p7YBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MzwehRpG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gzoB9Gl/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MzwehRpG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gzoB9Gl/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 477FC14002D9;
	Tue, 15 Jul 2025 07:29:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Jul 2025 07:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752578979;
	 x=1752665379; bh=nzZMqhTRDXIICbx/IWi5/wddF23SzI2S5en43ul/NHE=; b=
	MzwehRpG1w+RKgqyFLB1I/CL8FOmQ02jdgZ5C3qxqkL/w6IqplunXhniryZLHENV
	LMrVsdjeQpQJ/htlERBn863e8ggftuu4y7k8CkXyHw6+0W+OSxfrGDUgAVRWDjP8
	Z+qedQz3Gm/STLSXmoxtRIfmenU3i64Lqedbzl+dmdXil4NekguVHYpty+S+QCOU
	yDXq6MTXG78tG33KkJxS/CfhwIVIwSCVYfvsa8qU3rytET6QHiTrFPY6J5gM36wZ
	Qhrm8ODB8a0L74jJNuyOQIMIm6yYtDrtne7u5HTjLqOdxc56zS6ZJFe3RFJzDbvd
	L2UK+EST6Us/sdFKF7n1Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752578979; x=
	1752665379; bh=nzZMqhTRDXIICbx/IWi5/wddF23SzI2S5en43ul/NHE=; b=g
	zoB9Gl/sEXnLgs6Ia9tyZ3GEDqZm/b/3jN3EL6bHSUbaA1iwmssBR+Oq/El7ZFzF
	Kq62QKkX/lBdWpm/RVn/AGDQVIw+CSAJ9bTzw2HegmQscqOUZsW9H3ExC1Xa5d1F
	UR/ZJsWsTSaXJeHwfnuqS6X1xKTvIpfby8tJ66Osk4coEiYzss09MApctAA7EAZl
	r/SmSls3pPshZ8VFlSEU2GBADSnzzIeXHT8JqxAjXofmHG7sTypKPZ9fpyEWmEld
	pOC4SJx51uMjeGYt2d907knXDaS2C1a/536yNWmpl5QXnbJ49VLFQK97Z4TKZn+B
	X/J8nHuoZNP54vHoqRIxA==
X-ME-Sender: <xms:ozt2aDhPgnsdp9hDAX2uGIep9XaETH1Mg5-JbQIYS53nyAKmqD3nDA>
    <xme:ozt2aKkYMq-Tm6ZAV1hwAXpHKN4G9Nce0gXOas5d50_mzamsSQUyy0yIEV50Vtk67
    rEx4qbDf9dKv1gHkw>
X-ME-Received: <xmr:ozt2aPpjaL0Bx95VkcH9Rpl479sEKAG44xlyhQz3rykJZkEvqOOXhGX_Dd_npu7RUKGNiortQ3Nqf1icJLlPtWD2_Uv4Dol7XEOxLVgDzIjFVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:ozt2aDFj_hL_i3PM1E0vxpKhpXxNN6d3KDvJHf5mjDDQd-NaH4lQOw>
    <xmx:ozt2aLyPMOFPS7uY2WXWoj4hNGaGyTgxvcH-7IktxS-xmh4qmTUWFA>
    <xmx:ozt2aIouC5S9UMAOLm1u8yyHCFsck64oECM7iJxzfeNqOqHC-FdFbg>
    <xmx:ozt2aFiz98LO6INRGet_erNSV1D3z16lzZCj59pxc22QhnB1s9106g>
    <xmx:ozt2aAmDIFL3xCya-JxqfCkMmJ59z10p1aNF8B5vNCgTA495MjZHdOAO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:29:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 889ac2c6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:29:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Jul 2025 13:29:20 +0200
Subject: [PATCH v2 3/7] midx: stop using linked list when closing MIDX
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-b4-pks-midx-via-odb-alternate-v2-3-b0ca0b4b516e@pks.im>
References: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When calling `close_midx()` we not only close the multi-pack index for
one object source, but instead we iterate through the whole linked list
of MIDXs to close all of them. This linked list is about to go away in
favor of using the new per-source pointer to its respective MIDX.

Refactor the function to iterate through sources instead.

Note that after this patch, there's a couple of callsites left that
continue to use `close_midx()` without iterating through all sources.
These are all cases where we don't care about the MIDX from other
sources though, so it's fine to keep them as-is.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 13 ++++++++-----
 packfile.c | 11 ++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 2f64c26058f..472d6bf17ab 100644
--- a/midx.c
+++ b/midx.c
@@ -401,7 +401,6 @@ void close_midx(struct multi_pack_index *m)
 	if (!m)
 		return;
 
-	close_midx(m->next);
 	close_midx(m->base_midx);
 
 	munmap((unsigned char *)m->data, m->data_len);
@@ -835,11 +834,15 @@ void clear_midx_file(struct repository *r)
 
 	get_midx_filename(r->hash_algo, &midx, r->objects->sources->path);
 
-	if (r->objects && r->objects->multi_pack_index) {
-		close_midx(r->objects->multi_pack_index);
-		r->objects->multi_pack_index = NULL;
-		for (struct odb_source *source = r->objects->sources; source; source = source->next)
+	if (r->objects) {
+		struct odb_source *source;
+
+		for (source = r->objects->sources; source; source = source->next) {
+			if (source->midx)
+				close_midx(source->midx);
 			source->midx = NULL;
+		}
+		r->objects->multi_pack_index = NULL;
 	}
 
 	if (remove_path(midx.buf))
diff --git a/packfile.c b/packfile.c
index 0b3142973b6..7b350f018ca 100644
--- a/packfile.c
+++ b/packfile.c
@@ -361,6 +361,7 @@ void close_pack(struct packed_git *p)
 
 void close_object_store(struct object_database *o)
 {
+	struct odb_source *source;
 	struct packed_git *p;
 
 	for (p = o->packed_git; p; p = p->next)
@@ -369,12 +370,12 @@ void close_object_store(struct object_database *o)
 		else
 			close_pack(p);
 
-	if (o->multi_pack_index) {
-		close_midx(o->multi_pack_index);
-		o->multi_pack_index = NULL;
-		for (struct odb_source *source = o->sources; source; source = source->next)
-			source->midx = NULL;
+	for (source = o->sources; source; source = source->next) {
+		if (source->midx)
+			close_midx(source->midx);
+		source->midx = NULL;
 	}
+	o->multi_pack_index = NULL;
 
 	close_commit_graph(o);
 }

-- 
2.50.1.404.ge9779f6434.dirty

