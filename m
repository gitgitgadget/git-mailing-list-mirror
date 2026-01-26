Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92C32E72B
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421118; cv=none; b=NcxzEM9kUiWOVLJcnYWkck5BlOG/vou6XnHpm+/EF2qzW9u0PoH/Q9Df+zP0JgfbSeM+sZPF0dv93MYtmOaJBbnpkp8mUtJXZce1V/uNWMCfOTXv/0qMOeWY8aJOy297hmbqoaCQnwuGdYoLu8iDnAsWEcJ9/mxjuOKkPtPJOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421118; c=relaxed/simple;
	bh=PD1cyK063QjyR9z4K9qLjGQzE8orSk6tLPcc8Kq7W4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZleXVr2ds/gSFeqnX0DmEmow1ZlG4b9c2DFnVbw6YQ18JhGuN3hPRrvRaUu9fGuWY9IfUiu0S7lU5aAaz8dBj7QJ/rbCRGWGnZ7XEW++PVmREEo/TNwJoDGLnKdTEZ+SDwLL/n30UdJ7tYpN+j2MZxWCzgfkYCbIwA+bm59onf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K0CJKeLv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A0+/y1NU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K0CJKeLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A0+/y1NU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E2CB7A003E;
	Mon, 26 Jan 2026 04:51:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 Jan 2026 04:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421116;
	 x=1769507516; bh=x9zhIJjThYc3uY719cAm3iHkiTbNf5wBpPxTIZPt6AQ=; b=
	K0CJKeLvyZJbO1xosrqPAfd3I2tevNjmjNmy9R55UqFQ0B3SghecQRVYR+wbCm0a
	r4dJmBWodXgEh2egRMsLsa6mP+j6MwB2kWQ6aV+uBB/1fTlI8L2D+aEHED3XcAYl
	ObhpolrjKB7vzCKSjLFkTkQQuufXm1pexsOWoTmVdjXf3dARPhuPXsdUnGUDIjgZ
	II7pYSQ6FYj12oGAySx+eWFNM1cTmmP2ix3FxBy/lksq0AzQZAEqIiPNpkqJ0q1+
	SnxVTUwRzlUusKJmWOB+KK5+O6zJtXkSZTI43hkWWlg7SrX++a3ZcxkwWO43UpXJ
	kVLVtH3wob3XakZM3siTFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421116; x=
	1769507516; bh=x9zhIJjThYc3uY719cAm3iHkiTbNf5wBpPxTIZPt6AQ=; b=A
	0+/y1NUoc967KAZfbb7hvJ34v7z1hnd5yeHUVLTDRWB9zBVFHqPBiTNhYgpOAqvL
	aF9sWZ1+yJwttp2LmDZEj8epkacHdWM1N5b2UMigzn3x3Y3MrkkMpwZqtEgVwHkS
	6mD/Cok9uY4quDKcqV62piPyZuHsCNPt0P8LuMdxhdQwAkSLCkO+07wtBwPVVYdB
	M0JgnSI5jqitIrUgNcCwJcDjhU99eaX060KDK2hnhaHyPFc8GavlR6VtZfQ5NfqR
	hspE01GW6P89ft+ssO9xjRt/a8qwJ334OenyGeb+b5rzp6BEUkiZhKPtl4ta/x5/
	45wpL5kcOWlGTEPYS5ZBA==
X-ME-Sender: <xms:PDl3aYwIpeCfC63OFEWHg3NGcShBmJC133d6rYAfApoDbby03jMPHg>
    <xme:PDl3aTQsMZgyrnMcvcWbB5AAycF37RlzcBOLECGLTEf-XPPA85x0eXR46VrcJ2aUe
    st3PnNPeAXAUPIxXgzfiGb7GEglPAPPnm_Hp2KV1_xGWrJQqCdmeg>
X-ME-Received: <xmr:PDl3afWXgEDKHSAckjy1ow4WlqTonPRSSJZ0klRAlsKjyUAyRTSa-UEI7er6n-zHwDSNv65fljnnTFOYeOl4cmlEiziGYCzgG603Ghos_LRutA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PDl3aVbfQmQKa8cl_tNlkoVi4w2rTog-HWZtgsoPIx_4i_ehnyEvzQ>
    <xmx:PDl3aV2RqemBUXDaL1BE5OdkI1rkZFDpUz2v8E7EHPFN6kvJCZa5bA>
    <xmx:PDl3aXjAHswLuzylyj25KYs2NZfxZddI69k2y7peyDbAh8mxfFqsIg>
    <xmx:PDl3aZbWjpDnwESiIzkFHWDh8h_zw2RR6zP3fZrv0myc4_Q1qN6kAg>
    <xmx:PDl3aW1iwK27cj2zIFCksXZADdwGHyz-N95JX-8QOorIdztMrf4O_Zpb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5897c293 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:28 +0100
Subject: [PATCH v4 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-12-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

When enumerating objects that are supposed to be stored in a new cruft
pack we use `for_each_packed_object()` and then derive each object's
mtime individually. Refactor this logic to instead use the new
`packfile_store_for_each_object()` function with an object info request
that asks for the respective mtimes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 74317051fd..a6d37366ff 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4314,25 +4314,12 @@ static void show_edge(struct commit *commit)
 }
 
 static int add_object_in_unpacked_pack(const struct object_id *oid,
-				       struct packed_git *pack,
-				       uint32_t pos,
+				       struct object_info *oi,
 				       void *data UNUSED)
 {
 	if (cruft) {
-		off_t offset;
-		time_t mtime;
-
-		if (pack->is_cruft) {
-			if (load_pack_mtimes(pack) < 0)
-				die(_("could not load cruft pack .mtimes"));
-			mtime = nth_packed_mtime(pack, pos);
-		} else {
-			mtime = pack->mtime;
-		}
-		offset = nth_packed_object_offset(pack, pos);
-
-		add_cruft_object_entry(oid, OBJ_NONE, pack, offset,
-				       NULL, mtime);
+		add_cruft_object_entry(oid, OBJ_NONE, oi->u.packed.pack,
+				       oi->u.packed.offset, NULL, *oi->mtimep);
 	} else {
 		add_object_entry(oid, OBJ_NONE, "", 0);
 	}
@@ -4341,14 +4328,25 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 
 static void add_objects_in_unpacked_packs(void)
 {
-	if (for_each_packed_object(to_pack.repo,
-				   add_object_in_unpacked_pack,
-				   NULL,
-				   ODB_FOR_EACH_OBJECT_PACK_ORDER |
-				   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
-				   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
-				   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
-		die(_("cannot open pack index"));
+	struct odb_source *source;
+	time_t mtime;
+	struct object_info oi = {
+		.mtimep = &mtime,
+	};
+
+	odb_prepare_alternates(to_pack.repo->objects);
+	for (source = to_pack.repo->objects->sources; source; source = source->next) {
+		if (!source->local)
+			continue;
+
+		if (packfile_store_for_each_object(source->packfiles, &oi,
+						   add_object_in_unpacked_pack, NULL,
+						   ODB_FOR_EACH_OBJECT_PACK_ORDER |
+						   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
+						   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
+						   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
+			die(_("cannot open pack index"));
+	}
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

