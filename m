Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4033101C0
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155918; cv=none; b=urBQb7RWhSxxMmuEkh+0bOigkmxSqUdYE4X1yHK5hsfNjq+/tH74Yct7rS5KJTmPlhesJKw13oHC4FKqpiSa6VXAxDhBkjTUK94S33JN6UjBQso/ib1IPTA4oFrdajew32s5JehcCPz/HcqQDUJ/Z4v/YUskrQXU90vw9jLV/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155918; c=relaxed/simple;
	bh=RD6c2Zxtafap1tLqyDQnltNbPPuhHuzaAwIB9SDFD9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUPwwv8TQNanhU0sJ5EqQoZm27uswFyx3zSa93ptVZwIIyg5oZOOiBiRQxKDHFqxBKDA9byex5BpOWBPYSAdWeOcdqXRCeBzU2H22q4g8mGjSBFYNXKDYGumFdEmFbnwwBhU7ZeErwTSzlO3kDPfiYPE2sSfBi67H4zt41y+Yl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mm7fOxrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bc62KOHA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mm7fOxrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bc62KOHA"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5459140013E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 10 Mar 2026 11:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773155916;
	 x=1773242316; bh=5xK1ZQz1B7TZYLC69tsMXA/bWm8O4+fg9fe1xvBsvFc=; b=
	Mm7fOxrC+X98z6Bd+4kLqRPPzT0kfvP15WR4wp669UOR5iLbrELKuNnPfA+ftBz9
	fjFUBdCL/e6olMU51lyxZ8qtMhl3qtDXn7UJ54jIg/5IhNjA4NpYusPexBGtJP3u
	thJ6FAt1HdgJqXAaZKlZb8HQdUHX/t42P6ItCd4K/dinUzwWHD3Lm6o48XkRvz7M
	KV49EeQiSeq4EhLm45QurTuwgv2pwKfoJbhmEqKjEhGYe6V3G7wDYTI7tv8pBtOR
	eROcVBgIwp3Sg3Qnmsluajl+/1Pq4Tm71pwGj3othTEWeOLu62hxJJBfTm5kmNv9
	vJDixFZOUXctDxO2P9c+/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773155916; x=
	1773242316; bh=5xK1ZQz1B7TZYLC69tsMXA/bWm8O4+fg9fe1xvBsvFc=; b=B
	c62KOHAfZsSsjPmKLyr7TVQO7koT1kisFEQ05NRy0fYSibG70Fu9N9iR8xiUgDxh
	7TiCdy5TpZFRDllTAf/47Pr2u9h9esKs0rd1O1W8vIXKK06Rm+NOCTRqUTqXjhL5
	/oXFdsJUIoz58nV3LAqORi7TMlr/NyY2OEjGn+lnxqh8jw2g42vEuKY1LmCfwwBK
	CknDq4s3VRHL0UC/QtqMLtJs+Gx2MJYVyPcPPSOaRWw1pT3wNXEjShFFJmeCarC9
	y5KiSos5MHPc4j2CIJpNU6pTdbPdAQuTv0JrJq+wrfSz496KK46Rwt/3GsvqzpU3
	5djMFOMq0Nx0ZgbKTNFQA==
X-ME-Sender: <xms:TDawabWprk80HgdCtRFxeX0pLjtGf-fKLEx7Khis1MGXPSiD8tYUgw>
    <xme:TDawaaj0Uuk-7Iex5xCRSTIZHtkkLh68p_gn6_sowzsi7lE3uWqWYzf-BlPzt1qSn
    6LyNLCdF8CwsHyJrvcZqK9-w417SyHuNvnFTARJfCi8WmaLvpQ>
X-ME-Received: <xmr:TDawadCGI5dGf15GXr68aJxv9bE00VP2PddAb3PU7J1GbLxFY04rJOOIik70kj6gnrk4k47Zi4CcO_pkIeyHlCIZBflpAc9ZjBBIefeH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:TDawabfHdFW1NZa8UvKlH8iGQaMpHlxlrnTFQcgdbFECKoBkDcB1fw>
    <xmx:TDawaVdoAL4llZCrhMP52LlwLXEjxuCk8bsO4e5pFdHcvfFlkb5nHA>
    <xmx:TDawafiDyadg_hvK4aJu4aqsyuftQ-Vp_tpQlnfpWChrjV-lQfyA7Q>
    <xmx:TDawaRQK_US4LcHQlJHNigYtJo6O2JiAjkGBIKHeDwJ7tg8Zu_iaqg>
    <xmx:TDawaelyFh1NyWP6Jp8doIVE7ammJls1uNAZ0OaZs7F6hyiYGPvK8PG8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70cc4023 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 15:18:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 16:18:24 +0100
Subject: [PATCH 4/6] object-file: generalize counting objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-odb-source-count-objects-v1-4-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Generalize the function introduced in the preceding commit to not only
be able to approximate the number of loose objects, but to also provide
an accurate count. The behaviour can be toggled via a new flag.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c  |  5 +++--
 object-file.c | 58 +++++++++++++++++++++++++++++++++++++---------------------
 object-file.h |  5 +++--
 odb.h         |  9 +++++++++
 4 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a08c7554cb..3a64d28da8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -474,8 +474,9 @@ static int too_many_loose_objects(int limit)
 	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
 	unsigned long loose_count;
 
-	if (odb_source_loose_approximate_object_count(the_repository->objects->sources,
-						      &loose_count) < 0)
+	if (odb_source_loose_count_objects(the_repository->objects->sources,
+					   ODB_COUNT_OBJECTS_APPROXIMATE,
+					   &loose_count) < 0)
 		return 0;
 
 	return loose_count > auto_threshold;
diff --git a/object-file.c b/object-file.c
index da67e3c9ff..d35cec201f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1868,40 +1868,56 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 					     NULL, NULL, &data);
 }
 
-int odb_source_loose_approximate_object_count(struct odb_source *source,
-					      unsigned long *out)
+static int count_loose_object(const struct object_id *oid UNUSED,
+			      struct object_info *oi UNUSED,
+			      void *payload)
+{
+	unsigned long *count = payload;
+	(*count)++;
+	return 0;
+}
+
+int odb_source_loose_count_objects(struct odb_source *source,
+				   enum odb_count_objects_flags flags,
+				   unsigned long *out)
 {
 	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
-	unsigned long count = 0;
-	struct dirent *ent;
 	char *path = NULL;
 	DIR *dir = NULL;
 	int ret;
 
-	path = xstrfmt("%s/17", source->path);
+	if (flags & ODB_COUNT_OBJECTS_APPROXIMATE) {
+		unsigned long count = 0;
+		struct dirent *ent;
 
-	dir = opendir(path);
-	if (!dir) {
-		if (errno == ENOENT) {
-			*out = 0;
-			ret = 0;
+		path = xstrfmt("%s/17", source->path);
+
+		dir = opendir(path);
+		if (!dir) {
+			if (errno == ENOENT) {
+				*out = 0;
+				ret = 0;
+				goto out;
+			}
+
+			ret = error_errno("cannot open object shard '%s'", path);
 			goto out;
 		}
 
-		ret = error_errno("cannot open object shard '%s'", path);
-		goto out;
-	}
+		while ((ent = readdir(dir)) != NULL) {
+			if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
+			    ent->d_name[hexsz] != '\0')
+				continue;
+			count++;
+		}
 
-	while ((ent = readdir(dir)) != NULL) {
-		if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
-		    ent->d_name[hexsz] != '\0')
-			continue;
-		count++;
+		*out = count * 256;
+		ret = 0;
+	} else {
+		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
+						       out, 0);
 	}
 
-	*out = count * 256;
-	ret = 0;
-
 out:
 	if (dir)
 		closedir(dir);
diff --git a/object-file.h b/object-file.h
index b870ea9fa8..f8d8805a18 100644
--- a/object-file.h
+++ b/object-file.h
@@ -149,8 +149,9 @@ int odb_source_loose_for_each_object(struct odb_source *source,
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-int odb_source_loose_approximate_object_count(struct odb_source *source,
-					      unsigned long *out);
+int odb_source_loose_count_objects(struct odb_source *source,
+				   enum odb_count_objects_flags flags,
+				   unsigned long *out);
 
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
diff --git a/odb.h b/odb.h
index 7a583e3873..e6057477f6 100644
--- a/odb.h
+++ b/odb.h
@@ -500,6 +500,15 @@ int odb_for_each_object(struct object_database *odb,
 			void *cb_data,
 			unsigned flags);
 
+enum odb_count_objects_flags {
+	/*
+	 * Instead of providing an accurate count, allow the number of objects
+	 * to be approximated. Details of how this approximation works are
+	 * subject to the specific source's implementation.
+	 */
+	ODB_COUNT_OBJECTS_APPROXIMATE = (1 << 0),
+};
+
 enum {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything

-- 
2.53.0.880.g73c4285caa.dirty

