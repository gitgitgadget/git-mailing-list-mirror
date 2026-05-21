Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08B3A3808
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351784; cv=none; b=Zy0dPsyG3wNFPrXZ7IABGjEan/yZOnEzrjvCmzZY74QPy0aJZs1n4x9voRAypqV7qi1x/WwldnqFOU3iKH+hczvXy4qDIz9MV3QsBdBgltbCV/WXwyOiLrvZ7JNtxW/KKI3/wg8t3nhFbBe3TsMXTdCxQ7OrV1IOlKghkqFvzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351784; c=relaxed/simple;
	bh=bEjv4CA3J1B/mMIt+kFR9T8amx88qeLFiWPwyHin66g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDucpSsjVALkkKJrZsTPqGdkBQdj7QWAM97XDDD5X3ThPQ+xxbgA9DYHidHhAgZdHZUhHPf3YU6oyj2fY6Ydi5xdmurstQWl3Zb1CohXCLEBw0IlKVwMyqKv0phrzsenBoG83W99ZsRtKjzFwMCRsGnFE0KqEIKC9v4EixMfjno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LHqhIDCW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UJPLasKC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LHqhIDCW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UJPLasKC"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 07FB1EC009E
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:23:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 21 May 2026 04:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351782;
	 x=1779438182; bh=YeWzIfr37DXNdSGiNjLBgUFbhj5SMaq0EwQFANS13Rw=; b=
	LHqhIDCWBcMKVKaKanR/Txef11xOEwPFpLxECNdN6zdNfl/Gj30Zr8ObTImAVhNU
	P7fBNyf6SgDgSWwruKGGkOMhsOtHBwp3AfrImu+EB1oGc2CrB/So5P1h+KBEXYWW
	d/RvFl4bcQQxSnHeYVT/giMO7mGc2+7KaYypbQcf040KwBjRHRvkDsnpmh26EPmp
	HXJ73sTiw643z8IG6cUd5o5juZtjHkvPW4808GXRaD62a7EyrsVn5yrDDYl7t2QO
	tcGtvUJT2lbk0Fb0wd8yr99Yglctemfnpemn9Vl9SkoT8WhXfTe/fk0G/gm2KM4u
	YK2yL/Ly5ji08qUu/JHilA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351782; x=
	1779438182; bh=YeWzIfr37DXNdSGiNjLBgUFbhj5SMaq0EwQFANS13Rw=; b=U
	JPLasKCnBSnyhrc2WulRi/rZuwtX2UGA0Vxr7qsN3NP7sKRy0EW6oijSPCK+P8da
	855d/PB4nr8p1AsVAmiOCY0JJMzezh/KXTHZ2qYzg15ZnDagIMGiqNVDeQmzAhfe
	ZwAt0te7mmw6Je1cn6s0xsbCWwsBHh45WXFFZoSovTGZOosgZdJasMzeHW+dFs4E
	2TNSkiFBwb/GivAe23oA0twisakMBH+xkfqi86x4phSLZKce6kPAZyPLH8b6X29a
	mGeAs4BWtvpkqyMi/MXTvRrF/+nMorFv90selXEs+enFeo0j+y2ZpPQNrODPU7qw
	lOd7YQpPhKewn670FqoOA==
X-ME-Sender: <xms:5cAOauGOI0o-lzSeBdNLEzMauWnvPiMihVGv7vHDnwkdZOsOprGSaQ>
    <xme:5cAOamQQjv_ZjG3ckHLq-LIfB4eCKcA-eA9JROCyUOBz5nphM4Y0OVHBacqvvUZHj
    AV_sNRrFO4Ke1701-T-O7PRzRVcnQM4Kp-W9I-CwPGHp3Q5FCj7>
X-ME-Received: <xmr:5cAOatw9icKmXFkh_-YmFJIKZLXsoLRBsP8Kllcad2dcJWEDFSVVUsTFlu-u8rZKc6v5ux6JHIi_rUBmL6rNRn5TDNfjVut45vuNmASpKrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:5cAOatN_SFktpokDXmyetr5AvATaQFTQNyziojZmk3BiVTdYURsPNw>
    <xmx:5cAOakP0XphQ94EJ6WPiSwtDL91JpfdOHKosSDRQCrMRnLXyP3gzFA>
    <xmx:5cAOanQfUTnMjU_30vridQd8BzeeV9IgciS8xoKymadkC1D9WHa4PA>
    <xmx:5cAOauClu--KWUeYanJXC9nuu2r_5na-IUSWFH-DLtcBgjPM82XFLg>
    <xmx:5sAOagVq-KkJ_C4BH-n7IQ5NoB04dySAVPpWPrpL5eIjk1UOQSY5EJpl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:23:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be3f4dbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:23:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:32 +0200
Subject: [PATCH 12/18] odb/source-loose: wire up `freshen_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-12-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `odb_source_loose_freshen_object()` from "object-file.c" into
"odb/source-loose.c" and wire it up as the `freshen_object()` callback
of the loose source.

As part of the move, `check_and_freshen_source()` is inlined into the
callback function, as it has no other callers anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 15 ---------------
 object-file.h      |  3 ---
 odb/source-files.c |  2 +-
 odb/source-loose.c |  9 +++++++++
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/object-file.c b/object-file.c
index c83136cf70..0689a4e67b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -87,15 +87,6 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_source(struct odb_source *source,
-				    const struct object_id *oid,
-				    int freshen)
-{
-	static struct strbuf path = STRBUF_INIT;
-	odb_loose_path(source, &path, oid);
-	return check_and_freshen_file(path.buf, freshen);
-}
-
 int format_object_header(char *str, size_t size, enum object_type type,
 			 size_t objsize)
 {
@@ -815,12 +806,6 @@ static int write_loose_object(struct odb_source *source,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
-int odb_source_loose_freshen_object(struct odb_source *source,
-				    const struct object_id *oid)
-{
-	return !!check_and_freshen_source(source, oid, 1);
-}
-
 int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *in_stream, size_t len,
 				  struct object_id *oid)
diff --git a/object-file.h b/object-file.h
index 506ca6be40..1d90df9d98 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,9 +23,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-int odb_source_loose_freshen_object(struct odb_source *source,
-				    const struct object_id *oid);
-
 int odb_source_loose_write_object(struct odb_source *source,
 				  const void *buf, unsigned long len,
 				  enum object_type type, struct object_id *oid,
diff --git a/odb/source-files.c b/odb/source-files.c
index d5454e170d..ef548e6fe6 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -152,7 +152,7 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	if (packfile_store_freshen_object(files->packed, oid) ||
-	    odb_source_loose_freshen_object(source, oid))
+	    odb_source_freshen_object(&files->loose->base, oid))
 		return 1;
 	return 0;
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 27be066327..e519365d23 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -580,6 +580,14 @@ static int odb_source_loose_count_objects(struct odb_source *source,
 	return ret;
 }
 
+static int odb_source_loose_freshen_object(struct odb_source *source,
+					   const struct object_id *oid)
+{
+	static struct strbuf path = STRBUF_INIT;
+	odb_loose_path(source, &path, oid);
+	return !!check_and_freshen_file(path.buf, 1);
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -638,6 +646,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.for_each_object = odb_source_loose_for_each_object;
 	loose->base.find_abbrev_len = odb_source_loose_find_abbrev_len;
 	loose->base.count_objects = odb_source_loose_count_objects;
+	loose->base.freshen_object = odb_source_loose_freshen_object;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

