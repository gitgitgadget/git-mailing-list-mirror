Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74762F60A7
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810147; cv=none; b=V3VCysvJUf+jxaUI0DmrGELTCGI5LsW/qE8gogrul8K+56S0G/qsjCLGK8Q0d3BcxjlGNSmpTndhTwdrGpp7pLWRTSRhVoefKszgBuzetYXQO/bh39JOQmS34LMtdCT9n2/ngcyAR8VLvk081uB2ui6eChF0h5WEqhgxXdXrp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810147; c=relaxed/simple;
	bh=PRdlT4jpL7h10qS0MlchhBBTM0niRZ5NJ6K+9k3F4Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZSJIl5Jkn8xmThUvkGhfj0/LNIKSWIQ1Ej6qaEot2MJYAltcDfSmwWR4DDXEDHrfxN2IR26ltwzDWpXRaontqS3FDXsTR39jKP1B7NQSKJhssbyKjMgoTC4whKGKyIFfxZqfMwhrFnkYBy1SJafZQRs0og3O+P0U2LWuwD3PIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fFXTQs/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ic/A0Mib; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fFXTQs/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ic/A0Mib"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D26591400237;
	Tue,  2 Sep 2025 06:49:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 06:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810144;
	 x=1756896544; bh=j8qNCr8Bsm+VoAwkENtBpcZYiFjZPLGUH6Jb3XFHSTs=; b=
	fFXTQs/J4k/8jJsMQKF1MlBIjXNhakEFUq13CIrxyY5mvB6kYmUDQlfv2Y2GLGLg
	u4qr/nFpIN0rfqhKJ368p/Jy0QuHqThzPdG5IqOpysyX2p4p0IZ11UaVGCwimEhK
	gY+lQCHOA8c8e4ac603EQWD7Rhpv2ERIo7+7Exdvi+p2eMnQLiN6Nn2lXsVQobRH
	TfUWrr6my1hgWDg+DliEymKauMUBAjVnSuH1Om+g9uGgtRgOLMjQsXf/OG+A27wQ
	LAqMfazG9GuN16v4Ccr6P4ExNCbBRVY/y/Tph87ztNfpBCF8ULq5UP5CA+fxTecA
	hetDvZHxuE0HZf8apuT9rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810144; x=
	1756896544; bh=j8qNCr8Bsm+VoAwkENtBpcZYiFjZPLGUH6Jb3XFHSTs=; b=i
	c/A0MibwULbyBjAHim9ScX0AQW6qo2OSDPhvk0HX18ZAdqLWYKiU2Ou4UBWUP0eS
	WxGmzxMBFSx+zkaDfFT6NrfnLRcOXsJXQHnsrcX6Qsa0FWoj6fiQAh3H/tEYJ7Ew
	LcXo4k6Xm2yBgT9n/E0loY4RhS+1tWO6dCNmBYncfiXvk+5LpPOijUP8KazSJGB/
	kcCjdQyF3RCtPZ1pftR7KXFK63NNDV7I4NGIrFH7WLw+BXbOV4qBjMTj8E+lsWRu
	Y4Aaa1MKNLtqLUG9WFHGc/gltx4G9+TXFmDPqGVUtcuocnYXjlOKPAoIuYEbeC9o
	dkMF8aLYQOhlJdYJ0Wrjg==
X-ME-Sender: <xms:oMu2aMVGZ7nkny8dL9XxKBvkLe5bDH_eSfsAD28Ninw9t0KFLwUocQ>
    <xme:oMu2aMGyPHEZrorjriNOh73X8yhpJT2zHAOcXOkhbxv26jWuYG1yQ09ywEMs_O25z
    R-dS6xU_dlnI-03Rg>
X-ME-Received: <xmr:oMu2aG2s_myv3fWlzF4NqFSk_7ajSXR4WtdADZholfRaqg9AId0fbnAtuqMbU0DsaFkYpbw8SuAt_XG_ngHuDLgvx8sVQOjVQyVLq0znsFZpFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:oMu2aGMV6-ZVXWAdaJkcxVhULwu-OjifWxR3w-vXppD83oK7uSAp9Q>
    <xmx:oMu2aN5mjxxcyEejVnw8bUUfvJm0Vi3iizj3eiZFg1NQnD8k-B4ygA>
    <xmx:oMu2aI2IW64170b9UvzdCB0GB7Uv9gZe9_HmNdmHENqMso9ZPuLQRA>
    <xmx:oMu2aGwTFZl5iR6vAXrmshLjKZwRvmWSdMxBEUj25iI2o2qGmaaktw>
    <xmx:oMu2aJYN65-L2ZPlt7Ly8vmWU8g_cwMidYfkeju2piCNcNySpKuPXgSD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1f7fb40 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:32 +0200
Subject: [PATCH v3 07/15] packfile: reorder functions to avoid function
 declaration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-7-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Reorder functions so that we can avoid a forward declaration of
`prepare_packed_git()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 67 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6ae7f22d65..771b58df8b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -946,40 +946,6 @@ static void prepare_packed_git_one(struct odb_source *source)
 	string_list_clear(data.garbage, 0);
 }
 
-static void prepare_packed_git(struct repository *r);
-/*
- * Give a fast, rough count of the number of objects in the repository. This
- * ignores loose objects completely. If you have a lot of them, then either
- * you should repack because your performance will be awful, or they are
- * all unreachable objects about to be pruned, in which case they're not really
- * interesting as a measure of repo size in the first place.
- */
-unsigned long repo_approximate_object_count(struct repository *r)
-{
-	if (!r->objects->approximate_object_count_valid) {
-		struct odb_source *source;
-		unsigned long count = 0;
-		struct packed_git *p;
-
-		prepare_packed_git(r);
-
-		for (source = r->objects->sources; source; source = source->next) {
-			struct multi_pack_index *m = get_multi_pack_index(source);
-			if (m)
-				count += m->num_objects;
-		}
-
-		for (p = r->objects->packfiles->packs; p; p = p->next) {
-			if (open_pack_index(p))
-				continue;
-			count += p->num_objects;
-		}
-		r->objects->approximate_object_count = count;
-		r->objects->approximate_object_count_valid = 1;
-	}
-	return r->objects->approximate_object_count;
-}
-
 DEFINE_LIST_SORT(static, sort_packs, struct packed_git, next);
 
 static int sort_pack(const struct packed_git *a, const struct packed_git *b)
@@ -1098,6 +1064,39 @@ struct list_head *get_packed_git_mru(struct repository *r)
 	return &r->objects->packfiles->mru;
 }
 
+/*
+ * Give a fast, rough count of the number of objects in the repository. This
+ * ignores loose objects completely. If you have a lot of them, then either
+ * you should repack because your performance will be awful, or they are
+ * all unreachable objects about to be pruned, in which case they're not really
+ * interesting as a measure of repo size in the first place.
+ */
+unsigned long repo_approximate_object_count(struct repository *r)
+{
+	if (!r->objects->approximate_object_count_valid) {
+		struct odb_source *source;
+		unsigned long count = 0;
+		struct packed_git *p;
+
+		prepare_packed_git(r);
+
+		for (source = r->objects->sources; source; source = source->next) {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				count += m->num_objects;
+		}
+
+		for (p = r->objects->packfiles->packs; p; p = p->next) {
+			if (open_pack_index(p))
+				continue;
+			count += p->num_objects;
+		}
+		r->objects->approximate_object_count = count;
+		r->objects->approximate_object_count_valid = 1;
+	}
+	return r->objects->approximate_object_count;
+}
+
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {

-- 
2.51.0.384.g4c02a37b29.dirty

