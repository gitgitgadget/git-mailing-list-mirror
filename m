Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AD3B6C1E
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278217; cv=none; b=jUgJtoCaioEiiGwTclnDYzXoLdnWJBuAjtuGr2iQ7W5oyWv0I+7J9Ja7Wnksq3bi53G2Lo7/eNXaWtI4degerzTZtMdz5kZCKpM7BEGU6yr1MPUbUCiAFLtz/u5QMgMAtalvjTResG93+ekeFOycGXbYQ/vpgUyagaSwB99NM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278217; c=relaxed/simple;
	bh=9gWf/vPSGfXkCGISeIqOFjr1xIQcJ+OVjeuInfskqSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khAdKsLWBWEz8ks71SpvcEwJAac86B4Ngnre8glCS8GOfpM9S4vU7t121ihbl0doZWVcvENQGwxx4i1npH9qbNw/66csKCBp2EEmRZl9uNEG9Ov3hCPZf/Vgjd5+N11nhpalazpw0qZRl21jgL0SyvWfywTyQGQ73Mvnd4VG7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tz1XN1Q6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z5v5Qh0u; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tz1XN1Q6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z5v5Qh0u"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9EB447A010D;
	Mon, 23 Mar 2026 11:03:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 11:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278215;
	 x=1774364615; bh=Mqm2gs2PKMvJtfAXHx7Q/6vprGG/oOQm8CJCOByjnW0=; b=
	Tz1XN1Q6x0zkVT6hi4TjIvmkfGBWoMOd3JTKOVhs+/5fkFu3NipMPU9CxtdYa7o3
	Jo2PqDFPU4N8SXrnmdy6+K1di5hpeGjGOybt5pzQiacVzQsvzEImX/w/VGEI0idE
	8ZsGV2k4ROhRG91MM5dae3RKd4lZkvxMkiGr2AY3KmYRhwPZfoScbszLmx0LRqXf
	QId5SUkMlLXooJEt+l2EySAJ52qZdc8AXUGbxRSXNhZPVHHvWdrdscOmTYgf8rUa
	wcfPIAs/xM/z75M8PmLzpu6gUU8DT08XGgWKqKeOWf4vuLtV7X5+ZrR5gXxkQhTB
	lAMy1ESwmV/+I2oq1t9zeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278215; x=
	1774364615; bh=Mqm2gs2PKMvJtfAXHx7Q/6vprGG/oOQm8CJCOByjnW0=; b=z
	5v5Qh0uNGGmchARqsONQUBvsCZL4jB3o61hnykgzykJZ3ZdrcMe0+crnd3rrN/jK
	hGuNKoyXsVzt8W2SgrziprZTzus9OzsVQ/w8/ZcMrahagfGu1EplFwGAA2VgQtO+
	pXjkmd8iuklhhgN14O7wIZHgZCJekg9hY9kIuX3dUpDpQllxNJdXCl9DyiTPY1Jq
	LLmAtQg+AogohGzfs5y/M9kDiojjuKsWCy+sqsRlkcYn9DIN/1K1prZFFHvv65+p
	bsy41o+UPepz1d8DewKb3umDol4oohXX+OvQvHYIWsMLrlbQ6C5LOMim2ZdI8Ray
	ZF8toWIVAuiJCsRPDzEUQ==
X-ME-Sender: <xms:R1bBaaQpyLHQcbGyKEtDYR_FmxpHY5SGYkqKeRx7hBKNTpS06sV1vA>
    <xme:R1bBaVyyZvsNcNzY8h0Hi-FbIGgt8ePLnUi4F6aK6BTc4LWSi14WPe8Mt7gefI9pw
    EOAvZMgaxJ5MgoftLxupatpX57j6URXyAJnN4skEgFMjnPCRN0VzA>
X-ME-Received: <xmr:R1bBaVePEbiLmHv46muuqU2bh4Q_vhNDyKOGW3olX2A04QUzm3dsqqtN5ehjQC5yBNiXCTfWS6aM5si-dZi8483WOQhp9JeUbnvOtpbobA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R1bBaRJ7UOTCsnyyQOOlaD9_0kidClk3r6Jn7WRGnugcc3NHaqKM3w>
    <xmx:R1bBaWEQNX-t6Qd95x0k1d9TaYfata-P2V1JKxvwZ8pD6l7uiR1NVg>
    <xmx:R1bBaboKU6t1utSk6asQFeoDKsO1Ov3RvRi8YDlR2DtGBHX3CaFcDg>
    <xmx:R1bBafRfC5n81mo4o8HLqN64leqaKFn1QQ-1uReoRbo5XUzzkg5UAg>
    <xmx:R1bBadrZRtT5594nKQXghBMZmSy4545B1q-QVYKlYzJT9-4zxKnneiai>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4c31e606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:03:01 +0100
Subject: [PATCH v2 10/12] builtin/fsck: stop using `the_repository` when
 checking packed objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-10-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` when checking objects part of a
packfile. These objects are iterated over via `verify_pack()`, which is
provided by the packfile subsystem, and a callback function is then
invoked for each of the objects in that specific pack.

Unfortunately, it is not possible to provide a payload to the callback
function. Refactor `verify_pack()` to accept a payload that is passed
through to the callback so that we can inject the repository and get rid
of the use of `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 11 ++++++-----
 pack-check.c   |  7 ++++---
 pack.h         |  9 +++++++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index e8bdec7cd0..22ca1200a2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -447,15 +447,16 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 }
 
 static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten)
+			   unsigned long size, void *buffer, int *eaten, void *cb_data)
 {
+	struct repository *repo = cb_data;
+	struct object *obj;
+
 	/*
 	 * Note, buffer may be NULL if type is OBJ_BLOB. See
 	 * verify_packfile(), data_valid variable for details.
 	 */
-	struct object *obj;
-	obj = parse_object_buffer(the_repository, oid, type, size, buffer,
-				  eaten);
+	obj = parse_object_buffer(repo, oid, type, size, buffer, eaten);
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
 		return error(_("%s: object corrupt or missing"),
@@ -1089,7 +1090,7 @@ int cmd_fsck(int argc,
 			repo_for_each_pack(repo, p) {
 				/* verify gives error messages itself */
 				if (verify_pack(repo,
-						p, fsck_obj_buffer,
+						p, fsck_obj_buffer, repo,
 						progress, count))
 					errors_found |= ERROR_PACK;
 				count += p->num_objects;
diff --git a/pack-check.c b/pack-check.c
index 7378c80730..79992bb509 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -53,6 +53,7 @@ static int verify_packfile(struct repository *r,
 			   struct packed_git *p,
 			   struct pack_window **w_curs,
 			   verify_fn fn,
+			   void *fn_data,
 			   struct progress *progress, uint32_t base_count)
 
 {
@@ -161,7 +162,7 @@ static int verify_packfile(struct repository *r,
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
 			int eaten = 0;
-			err |= fn(&oid, type, size, data, &eaten);
+			err |= fn(&oid, type, size, data, &eaten, fn_data);
 			if (eaten)
 				data = NULL;
 		}
@@ -192,7 +193,7 @@ int verify_pack_index(struct packed_git *p)
 	return err;
 }
 
-int verify_pack(struct repository *r, struct packed_git *p, verify_fn fn,
+int verify_pack(struct repository *r, struct packed_git *p, verify_fn fn, void *fn_data,
 		struct progress *progress, uint32_t base_count)
 {
 	int err = 0;
@@ -202,7 +203,7 @@ int verify_pack(struct repository *r, struct packed_git *p, verify_fn fn,
 	if (!p->index_data)
 		return -1;
 
-	err |= verify_packfile(r, p, &w_curs, fn, progress, base_count);
+	err |= verify_packfile(r, p, &w_curs, fn, fn_data, progress, base_count);
 	unuse_pack(&w_curs);
 
 	return err;
diff --git a/pack.h b/pack.h
index ec76472e49..1cde92082b 100644
--- a/pack.h
+++ b/pack.h
@@ -85,7 +85,11 @@ struct pack_idx_entry {
 
 struct progress;
 /* Note, the data argument could be NULL if object type is blob */
-typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
+typedef int (*verify_fn)(const struct object_id *oid,
+			 enum object_type type,
+			 unsigned long size,
+			 void *buffer, int *eaten,
+			 void *fn_data);
 
 const char *write_idx_file(struct repository *repo,
 			   const char *index_name,
@@ -95,7 +99,8 @@ const char *write_idx_file(struct repository *repo,
 			   const unsigned char *sha1);
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 int verify_pack_index(struct packed_git *);
-int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
+int verify_pack(struct repository *, struct packed_git *, verify_fn fn, void *fn_data,
+		struct progress *, uint32_t);
 off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,

-- 
2.53.0.1118.gaef5881109.dirty

