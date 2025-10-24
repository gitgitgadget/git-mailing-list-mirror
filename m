Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B03101B7
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299802; cv=none; b=nCTNZOzF8xssGgwSxfUefxhFtnbYYwJHa/8bvKt0s+e874cDFsEKj9h0gYo+gpdP6DTF0vvGIe2IvO8bruqW6cbIQsHrSEv0ulEucLKZZWSN9UfwaVBESGi9R+1gq/RF4GkEHmu6KrKoSl7q9usCK66PTgYlQztGNLHvnP5iYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299802; c=relaxed/simple;
	bh=lzSSp/jgmPjQ7SyrtJahf1GWfCR+TwGZlKf2IN5JOzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q27Zr9oRcvHAZPiyeQbL41l4nTAZ/b9+5CBw7IcLbMUxPm8OYqsn3yRvZiYjTc3NLXj2OPL4462VXS/SEfRdFqhWe1O+sfa/PD+IL9OyZXOjhVhrUf5xItWSkm4qU2FnvgwOgk9f4/QmIpQmfnzy3C44pa6YBCR7Eiv4v3uxhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BWkDPrl5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xX1Q+Wta; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BWkDPrl5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xX1Q+Wta"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2A4D140016D
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 24 Oct 2025 05:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299799;
	 x=1761386199; bh=7icxYjUCJ5zE5aPAN1xZJUhcjYyEmOUFx0JQuLJTWmw=; b=
	BWkDPrl5wIdLQi8hGblZZE55oXDeErKjzuwuYvFrSGeCaVROd7moAdzzKXjkpW5M
	0ZieVqSb98OL269ILReXLdjeimLVEDuRD7TZVMp1OBL29maZS46evgStOSxUCjsr
	gJknJApI/JSMCKHDdJKp8nwCuUVmJ2RfEbkr3lnPaZOhFZZWanW40qbCuMSCcj5r
	aXKgJ7PjqC12lh20nS1YXcx7D9CNPICQ0eSh/avLvseWVUTF7nfva1iDxay3MMsC
	4xpw0PQaHwLoeJpXPilURxf4gYQr0U5qtkfZspUqMW1TE3N/NUhfQAMP8W8sgyTY
	QPPb4qzME1dtDXrYZneeuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299799; x=
	1761386199; bh=7icxYjUCJ5zE5aPAN1xZJUhcjYyEmOUFx0JQuLJTWmw=; b=x
	X1Q+WtaM96prjoe7uGCW+K32FCPvmk7+tI2LOMb2VGyrk12w7arro7aJsdDvzcCA
	a1rtsdX9Yy8KQ81FHgs/15Nhcuq7tx/lWzH9Cp0UXnP+1GCAEdFkQd9fpctSsrqc
	9a29ObnMTNw+xVzxg2FJoIwo5rnUGbdASTkuaNW1csDFj9nmAB3fNEEL4+/DBHHn
	7jrTkvtES2Gm3isSlNseLo1+j3chGEVY5UGVobfJiOHt8S3TXd1Vzzct9xAyUDPw
	s5h38MwGQg4sBeC7QIZmM/RGrodi+uMjZwpPrXbnF0L41uXiIFW9Iz8C5/Dcds+4
	0zFjS5M7DHHapLF1MIMqQ==
X-ME-Sender: <xms:V037aLq6EXwWqOyk3iXxNUCtmFnLJ6v6Tu9eoxt4n3PXlv1auU1kqQ>
    <xme:V037aMmxZ9deA7e59T7-jfGdPhX3Sz8r15-F-zpm37XC237QkrPzYYkIsnspOrJbJ
    9L9G3JD2ewPs1kFLIVSE3SBUuieG7-NCaTtZub8C-jpwDJJeaVRFg>
X-ME-Received: <xmr:V037aN2zT5AVAmo7XBCuJ9TDAZfdCUFmgXO7VheDAZJJfdjBGwJguryEi_rDpd-4Q5XOOIp8zXKMdYNHHO_y3LCqHMBkoR8w6fAjhpN2ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:V037aECkuesmczFaIWl9mSGJK7vIJsW9sGamQ63JcGkMkgIwi4bb8w>
    <xmx:V037aKxkwbOtfegbJbNfDPSkRe3TWNY-xQj9tHNOkR668XMcY2jqTw>
    <xmx:V037aClSBQJDasziy_8mh7Gb6Gmdt1_e9U6LHIVaAyxP4ABebAHjBA>
    <xmx:V037aPHa3_7rKEZhBHHRBTa-rE1KP6zmVpxTQrL-MhTFwHOdjz5HnA>
    <xmx:V037aLKDXxwdAJRSrKee4mRVzpuSdFCwXJ-9VjNxoZ6NdxlJrlGVZHl6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9884bac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:10 +0200
Subject: [PATCH 11/13] object-file: refactor freshening of objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-11-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When writing an object that already exists in our object database we
skip the write and instead only update mtimes of the object, either in
its packed or loose object format. This logic is wholly contained in
"object-file.c", but that file is really only concerned with loose
objects. So it does not really make sense that it also contains the
logic to freshen a packed object.

Introduce a new `odb_freshen_object()` function that sits on the object
database level and two functions `packfile_store_freshen_object()` and
`odb_loose_source_freshen_object()`. Like this, the format-specific
functions can be part of their respective subsystems, while the backend
agnostic function to freshen an object sits at the object database
layer.

Note that this change also moves the logic that iterates through object
sources from the object source layer into the object database layer.
This change is intentional: object sources should ideally only have to
worry about themselves, and coordination of different sources should be
handled on the object database level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 33 +++++----------------------------
 object-file.h |  3 +++
 odb.c         | 16 ++++++++++++++++
 odb.h         |  3 +++
 packfile.c    | 16 ++++++++++++++++
 packfile.h    |  3 +++
 6 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index 979aee32de0..2ca90adc2c7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -968,30 +968,10 @@ static int write_loose_object(struct odb_source *source,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
-static int freshen_loose_object(struct object_database *odb,
-				const struct object_id *oid)
+int odb_loose_source_freshen_object(struct odb_source *source,
+				    const struct object_id *oid)
 {
-	odb_prepare_alternates(odb);
-	for (struct odb_source *source = odb->sources; source; source = source->next)
-		if (check_and_freshen_source(source, oid, 1))
-			return 1;
-	return 0;
-}
-
-static int freshen_packed_object(struct object_database *odb,
-				 const struct object_id *oid)
-{
-	struct pack_entry e;
-	if (!find_pack_entry(odb->repo, oid, &e))
-		return 0;
-	if (e.p->is_cruft)
-		return 0;
-	if (e.p->freshened)
-		return 1;
-	if (!freshen_file(e.p->pack_name))
-		return 0;
-	e.p->freshened = 1;
-	return 1;
+	return !!check_and_freshen_source(source, oid, 1);
 }
 
 int stream_loose_object(struct odb_source *source,
@@ -1073,12 +1053,10 @@ int stream_loose_object(struct odb_source *source,
 		die(_("deflateEnd on stream object failed (%d)"), ret);
 	close_loose_object(source, fd, tmp_file.buf);
 
-	if (freshen_packed_object(source->odb, oid) ||
-	    freshen_loose_object(source->odb, oid)) {
+	if (odb_freshen_object(source->odb, oid)) {
 		unlink_or_warn(tmp_file.buf);
 		goto cleanup;
 	}
-
 	odb_loose_path(source, &filename, oid);
 
 	/* We finally know the object path, and create the missing dir. */
@@ -1137,8 +1115,7 @@ int write_object_file(struct odb_source *source,
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
-	if (freshen_packed_object(source->odb, oid) ||
-	    freshen_loose_object(source->odb, oid))
+	if (odb_freshen_object(source->odb, oid))
 		return 0;
 	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
diff --git a/object-file.h b/object-file.h
index 8e0f38d413f..b27c08380d8 100644
--- a/object-file.h
+++ b/object-file.h
@@ -59,6 +59,9 @@ void *odb_loose_source_map_object(struct odb_source *source,
 int odb_loose_source_has_object(struct odb_source *source,
 				const struct object_id *oid);
 
+int odb_loose_source_freshen_object(struct odb_source *source,
+				    const struct object_id *oid);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
diff --git a/odb.c b/odb.c
index 5dc1e2c7eb0..6f8f665351b 100644
--- a/odb.c
+++ b/odb.c
@@ -987,6 +987,22 @@ int odb_has_object(struct object_database *odb, const struct object_id *oid,
 	return odb_read_object_info_extended(odb, oid, NULL, object_info_flags) >= 0;
 }
 
+int odb_freshen_object(struct object_database *odb,
+		       const struct object_id *oid)
+{
+	struct odb_source *source;
+
+	if (packfile_store_freshen_object(odb->packfiles, oid))
+		return 1;
+
+	odb_prepare_alternates(odb);
+	for (source = odb->sources; source; source = source->next)
+		if (odb_loose_source_freshen_object(source, oid))
+			return 1;
+
+	return 0;
+}
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
diff --git a/odb.h b/odb.h
index 25fbcd7d951..8681b7782b4 100644
--- a/odb.h
+++ b/odb.h
@@ -396,6 +396,9 @@ int odb_has_object(struct object_database *odb,
 		   const struct object_id *oid,
 		   unsigned flags);
 
+int odb_freshen_object(struct object_database *odb,
+		       const struct object_id *oid);
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect);
 
diff --git a/packfile.c b/packfile.c
index 5a7caec2925..2ab49a0beb1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -819,6 +819,22 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 	return p;
 }
 
+int packfile_store_freshen_object(struct packfile_store *store,
+				  const struct object_id *oid)
+{
+	struct pack_entry e;
+	if (!find_pack_entry(store->odb->repo, oid, &e))
+		return 0;
+	if (e.p->is_cruft)
+		return 0;
+	if (e.p->freshened)
+		return 1;
+	if (utime(e.p->pack_name, NULL))
+		return 0;
+	e.p->freshened = 1;
+	return 1;
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
diff --git a/packfile.h b/packfile.h
index e7a5792b6cf..0ad080046f1 100644
--- a/packfile.h
+++ b/packfile.h
@@ -161,6 +161,9 @@ struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
 struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 					    const char *idx_path, int local);
 
+int packfile_store_freshen_object(struct packfile_store *store,
+				  const struct object_id *oid);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;

-- 
2.51.1.930.gacf6e81ea2.dirty

