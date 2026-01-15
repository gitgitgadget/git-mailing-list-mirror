Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA237416C
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475132; cv=none; b=rOdJ1Exyi72lOG/UyXAOs7d0TkiJoCiyyNr1WyoMNpGtpqGGjxcxlyHn74IIRCJrZJ27Prtzvsf2+/PllvzSyGGpSgnZ+djySd6/wjdwGsoJzV4HyIjlc5N9RLCYMalB4bWFaTeGFQ1LKBIdhI4xCmReMzw3615L5kZbUWNKi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475132; c=relaxed/simple;
	bh=7UCOJ7ZWqNGwstRJEylwm/Z06D5iRgLf7gGhiR2BQQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHWskTMTEe9ppccLHzZiDfYTPzpMthlg6AsDLT5M8ZuQ/o2wCOyUxM1EWnbL60hwhc9+YfNSyncSBoGJLnBA8oIQ1e15FzLstQaL65eHQHh0CInw2a77EjwqvJ2fz4omOot/MJW083Uhv8fZmEHm5q8u6lZCWJ/dB5g32BsC6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DozeN+fb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eQBCaDww; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DozeN+fb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eQBCaDww"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A857B1D000E1
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 06:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475127;
	 x=1768561527; bh=iaknMgvVSPozrJsNoFAFT+Qq7a1F0v63s6F1Qp21KoY=; b=
	DozeN+fbV5XkBulnPKGHEjkm+g+MLiVn+tW6nlG7Q3R3du23fRy607kcy/Qto4e/
	6nTjfHWPJukAEzrG7tFbr788D9iO2zF/S3ZXAxuXKuleUbuMArUWpHpOl6m7A29r
	U27GNWOCrdV6BZLt8myfYX8oh9ftVA4JJqI2VanOpots3I0Jdvzge9GdadW70Cdx
	lsZl2qTeV4l08DhCzYd9zDh/ZSdegi8ciNiQ2OMwjGlW52Pdxqxw7NCifyJRgOR1
	lR1FqPlOdcnluo1OGDNsb/O+NESB/hqrnG3F5hoIv9qE0y5C3UXkXk2jYuwdffhB
	f0N/T3w9v5sNAhpBWxjPeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475127; x=
	1768561527; bh=iaknMgvVSPozrJsNoFAFT+Qq7a1F0v63s6F1Qp21KoY=; b=e
	QBCaDww+cy2fJQ9VK9NCHbaAIq02dP5i/xSqHOXohxN9vlGnBrRA0hr0XNPg6/SP
	X0LfcPgZGj8+NDrepe6WCpJVqI/dj8fk7u4cxtziEisExkKdoPLYchve8NHknP+p
	2fOqeauDS9cL+XMY5QN7+vQUXS1jere1fRDyNY9zDqB5vsGs58RbATdMXQNYVArd
	i7BOtKQsxPnnjisYWN3v3VbDPV/3N6s1OVGRh9KE/Jt6vAyu36j+t/qpiH5Z9mB4
	03YLevVKo1Lkllq4N3469OrYkO9zDrwQaVKJGyySfwI0RLWGiCEGk1hdy7FKUpxv
	zG7e1AiS7gh/2eAi1d3KQ==
X-ME-Sender: <xms:98loaVvWtgXVvrl-p4DgDqN3xDlOabQbypyaxXqzV6JWuitMfosDUw>
    <xme:98loaVYb89-KKFAKVZ9z9Ix0oSP9xej2NqNLhKvSQ4DxjNV7mPrMSCT-W18ldLlcY
    KC6ejmP1w0eqhie9_bgM_h1K97jkQKDLg2RfqWCqHEtjhsAWVL4og>
X-ME-Received: <xmr:98loaeZSfAgd7FSNDru61tBiH2c-roPMA7k-A4VLSO4cR1aS5at41zrB1WyI8Q1xzW2vfeVFZ-uj4ZeWY6Zgbl0UFmQZOYdVAUAdMD9liWas2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:98loaRVx55d2O_KzL2j4h0FoT0E7qgxXnCNSECNLQ8htj7V7UAWC6g>
    <xmx:98loaV35pLNA2XJCbh4Fe5e0VWJ7CJc5SvR5d7wbKjtf7odAFRT55w>
    <xmx:98loaYanrv61QRZv7BgVZ1qCG5t-veYohupA6-3DO8hkwUgu6g7i-A>
    <xmx:98loaYrBZg0fkzrbFAqAkBxUdplxviqDOqJFor8Uq-iotTuPShCvbw>
    <xmx:98loaccvHuBtGv0SmRg73_HXtoQqI3zxVYaOY4yvVzvS8ghLuFhQQYAp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ad3ebbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:41 +0100
Subject: [PATCH 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-12-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When enumerating objects that are supposed to be stored in a new cruft
pack we use `for_each_packed_object()` and then derive each object's
mtime individually. Refactor this logic to instead use the new
`packfile_store_for_each_object()` function with an object info request
that asks for the respective mtimes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 74317051fd..223ec3b49e 100644
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
@@ -4341,14 +4328,24 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 
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
+						   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
+						   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
+			die(_("cannot open pack index"));
+	}
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,

-- 
2.52.0.660.gd05f3a8ea5.dirty

