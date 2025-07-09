Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F328DB7B
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059889; cv=none; b=oss5Vo70wVd8ioRLVTk0Kor/Y6ynrf7VGay3r475HzP2c9joAVedJl7UsLEi2skjK42JIz0Xun7ime0aoZ2qLlf3pnpRuS9A51CHWiXd85xqUvltGoWQMMFnzPVwPvW0rXB4/bDHUjXtkeEL+VYo40a9pcwOHbMZYjOe44+lDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059889; c=relaxed/simple;
	bh=UuRtH5GSsTIexXMVUnAyfYcp0CqXHFWkozl/bcpawoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhbQaLvad4O/htDPrOBK+F0a6Z6u2FBOdWL4Q6Nratwkf9L3/72deHApTUWgE7zPv6l0iRunTNQFuRVu3mcMrPVBP1HBxfKQ30RiWcqlFeYtFGdg1hQuXI28SldUAQTLAkjdRwtY0UG1YDYXH+M7FfBwMgA/okCWc1lvmx3C97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FBr4Ypvd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0cLeJw4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FBr4Ypvd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0cLeJw4"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 344471400330
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:18:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 07:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059886;
	 x=1752146286; bh=SRLxdtymVsSDFTXzCHg7G631VkBMkKtpSrCuD7MAvnk=; b=
	FBr4YpvdKXUKrTGo3xA/jWv4Y9bU+n+KHfJlv+j/+UFjsS3MDRnpxHsoOvOi1xPT
	+vMBU5mZcmEvjL9br6G2Yr6qVcyrSeaBKHNuCBWpAHLqU5ZVstmhpiOnf0wPX4kj
	RrrI342/4sBv4wiZpd7l06KHnfrnKcGYdasGx7tGZErNxz2EcsN4Cdsx0on0yfUw
	0tkNoQeRIuezVSnkpALDHFllegKR0uouCNvCvDKHHBTuQGZLCK+tw+FNd6d7ICP2
	xJ8wr6ND1Y/cz0NtnG2QaO04NNR8lbbvf65dQ+3kGqhxA2uyey2eQWSWw+xPmBMU
	Q5dCKUhkP1ZmGwP0St2EVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059886; x=
	1752146286; bh=SRLxdtymVsSDFTXzCHg7G631VkBMkKtpSrCuD7MAvnk=; b=Z
	0cLeJw4aOWGf/8HrLhl5KgcbRk5Te/vRGIJmpwvrFfNFy+1GHTQrj/w4JCUmXKBQ
	qFHIR/AsRXjz0t+x2kTKlgkq0plIARGQRJY4RkY3zQi+ugcfIiD0I8rSMsF/mF8U
	TEU4SmRmb4lBR+eXmny9gPKP6NX2gaffEXeeWJM0g16Mgb8b4nATO943E1cEew4o
	1RaOaMcVPtyvPSKZcifhyDDzD8JAyDSahOERXVteYSwTAJCdUHyj/bJ4tZ8ch3Kr
	9+JeeM9x/lBTP3acLXeQ45VA7mbLupKhd0nCDjP4zY89K+6IX3Km2+SaT4nY1+sb
	lynjFgrFXepQM533edMfw==
X-ME-Sender: <xms:7k9uaC9bSjegj8Rz6xsNG-Y0Hv_mUEE0xju_CkQs5-uYad1VgPKqvg>
    <xme:7k9uaEt4C6afLSm64uH08VFRBYj6Qm2YqkMrmnXrY_jKNLQcM7_IohcfXv70DBa-1
    u_tNQlgpEog1C8KKA>
X-ME-Received: <xmr:7k9uaBYbj1g3tVK4u_p5H0dQDca9lhlQkca3yDD8XaXLIdMHS41kZeEM3gcHrKSqEsA5OyRHEsaFgD4SXNwjWit4BdVgpv_xRbazdNt9LuNwcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:7k9uaMpBsfSsiWHQIg8Z4u3XsnPXliriUaTLpE6FP8NI1C3o90COJQ>
    <xmx:7k9uaO9rdwQrXM1_V-x_FHMmJMuVMSpIFjLUztFBoj0-1dcPCYAFGw>
    <xmx:7k9uaD-4JAPeqJbKJx2R0qe_4Q-ts9WM_3zoAk8qdVw3Tgy03swc2w>
    <xmx:7k9uaFus0qiljLS--DFfTpmVzLOeW3IZYcYQ1WoL9sSCUQ6LUGFDBQ>
    <xmx:7k9uaDltOOUtzSMFvuM8GQM38GxPywK9F9wPVzIaYVEMaYXr6ySPLCat>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:18:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26afb222 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:18:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:25 +0200
Subject: [PATCH 15/19] object-file: get rid of `the_repository` in
 `force_object_loose()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-15-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The function `force_object_loose()` forces an object to become a loose
object in case it only exists in its packed form. To do so it implicitly
relies on `the_repository`.

Refactor the function by passing a `struct odb_source` as parameter.
While the check whether any such loose object exists already acts on the
whole object database, writing the loose object happens in one specific
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  3 ++-
 object-file.c          | 18 +++++++++---------
 object-file.h          |  3 ++-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9e85293730b..7ff79d6b376 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4411,7 +4411,8 @@ static void loosen_unused_packed_objects(void)
 			if (!packlist_find(&to_pack, &oid) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime)) {
-				if (force_object_loose(&oid, p->mtime))
+				if (force_object_loose(the_repository->objects->sources,
+						       &oid, p->mtime))
 					die(_("unable to force loose object"));
 				loosened_objects_nr++;
 			}
diff --git a/object-file.c b/object-file.c
index f7c07acadc9..e9152d9e04c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1077,10 +1077,10 @@ int write_object_file(struct odb_source *source,
 	return 0;
 }
 
-int force_object_loose(const struct object_id *oid, time_t mtime)
+int force_object_loose(struct odb_source *source,
+		       const struct object_id *oid, time_t mtime)
 {
-	struct repository *repo = the_repository;
-	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	void *buf;
 	unsigned long len;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1090,24 +1090,24 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	int hdrlen;
 	int ret;
 
-	for (struct odb_source *source = repo->objects->sources; source; source = source->next)
-		if (has_loose_object(source, oid))
+	for (struct odb_source *s = source->odb->sources; s; s = s->next)
+		if (has_loose_object(s, oid))
 			return 0;
 
 	oi.typep = &type;
 	oi.sizep = &len;
 	oi.contentp = &buf;
-	if (odb_read_object_info_extended(the_repository->objects, oid, &oi, 0))
+	if (odb_read_object_info_extended(source->odb, oid, &oi, 0))
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	if (compat) {
-		if (repo_oid_to_algop(repo, oid, compat, &compat_oid))
+		if (repo_oid_to_algop(source->odb->repo, oid, compat, &compat_oid))
 			return error(_("cannot map object %s to %s"),
 				     oid_to_hex(oid), compat->name);
 	}
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
-	ret = write_loose_object(repo->objects->sources, oid, hdr, hdrlen, buf, len, mtime, 0);
+	ret = write_loose_object(source, oid, hdr, hdrlen, buf, len, mtime, 0);
 	if (!ret && compat)
-		ret = repo_add_loose_object_map(the_repository->objects->sources, oid, &compat_oid);
+		ret = repo_add_loose_object_map(source, oid, &compat_oid);
 	free(buf);
 
 	return ret;
diff --git a/object-file.h b/object-file.h
index 52f7979267d..15d97630d3b 100644
--- a/object-file.h
+++ b/object-file.h
@@ -161,7 +161,8 @@ int stream_loose_object(struct odb_source *source,
 			struct input_stream *in_stream, size_t len,
 			struct object_id *oid);
 
-int force_object_loose(const struct object_id *oid, time_t mtime);
+int force_object_loose(struct odb_source *source,
+		       const struct object_id *oid, time_t mtime);
 
 /**
  * With in-core object data in "buf", rehash it to make sure the

-- 
2.50.1.327.g047016eb4a.dirty

