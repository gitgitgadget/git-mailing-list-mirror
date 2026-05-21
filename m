Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE93A6B6E
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351769; cv=none; b=aIFVx2FkGAptRMD62KmQMyqYwpd78fVD+iCQLk6flM3xXWdn6WMMGq6ZPgiUYVmvhfey9hoVq8cu8T7ZoSC5BEF0+0ayYqNX9cocDVHhdfGBbKHMOIXHLtE3k7mUQOyAYg59ELJ0tBd/+QCAQP3OE1mUFSIeAsXsZOgMzUUt2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351769; c=relaxed/simple;
	bh=FTdGjxdCuN8Zmr1K/9AVkl/OqX1kh+7E2KB7B2VGOBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMtXNKwCTOavNi/WSVF2amoOks6WomI/0mOhFblrG74N76mKIYt3Plh5b12qFkxPejRSDv2IIjxCNPzCNoK9lXgS7pxHhU0Ppmxh3Pzu65jMWCc3ZwsF4uKN2ovgV3Na4r2LiOC6klYPmHtm9AojQrBLzouVsM6PUs+ZzqkGFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L4WYtvVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzRUH96V; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L4WYtvVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzRUH96V"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B92B2EC0067
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 04:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351766;
	 x=1779438166; bh=oavfLmKvRjYj9iyuNRYPbLL+moQWYNpO7uN0bupeCNg=; b=
	L4WYtvVOUK+MKkYhp6JAucIMpbdz2NKjIg8zx6YSLpJdX1FrRdxTHEUWZTtNDTf8
	VAhmTakgCEzM0BD+yrpgp6lqzy4X6f7rVjq8gVamnub+CqIVEbAYs8UgC5pibsEZ
	TQ1ltHsIZM7GLkNHAcCXbZbp5WknfyPQ4OyxUuCJEqZqu1/uXsqPC8gANYfim2JL
	BSH56+CW1gDJmYnf8Jr0tPwIJC+78QxctFBi2qREbsY7PQy7IXASK1OymtVSWwV5
	SG5+zYH6sCz+3yuLai5HUgyuO1vvujFlj08Lu4RIF/RG4jEH0tFq3X9GimaNeIyB
	CmSfu0lrKfmTLvoaBChtqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351766; x=
	1779438166; bh=oavfLmKvRjYj9iyuNRYPbLL+moQWYNpO7uN0bupeCNg=; b=D
	zRUH96V4+G56PUbPT6X4BSEkoAfKJRVaZ+bw9XoJAerqnsOGZ4+Hqy+jWlNNL9jg
	7MIukLQ9qEAtMDOb754t13wPWcCDMH+OZq4uOundWPYMkVNoDZqQETfkuX2yhgMO
	o9qls8rt0F9N9Jeytr+skrUcieHUVCjbZp4pwiKhUz3v3QL9QKl6rhgLVAipxdgQ
	dszkNI/xpM9/rRwjKOryCXu22f2z6GX9t+ITACTtWby0ldxP5qjE3GB58qMQs5fT
	VmZHEDl3V74FFOT160iVCkPBTkVYf0g4BsoLZY+0Riqr5caTVfGWH3yLPszc+0us
	n5mJ0mVJMXLLDW7BGnQUA==
X-ME-Sender: <xms:1sAOavH0IOKl8dKjMGiSiqY1Amj8TMdYh-33Xk4zbZ5lBJu4d2q73Q>
    <xme:1sAOajTl5Fb5O2n3fL9p36WcU3fUpG2mpnu9e9wKChA_GV38DdD4XRNwIt3lEEfJg
    NvJLaN0_qn4OWAa2t97BCQlWfLE3bzXwhymn_XsuWMXP_g63LAYAw>
X-ME-Received: <xmr:1sAOamy6dIWJtyER6ns7o4V7qBD_6fb5YcJ4xufxG4Zql_DaPZec8DzoMFRT1IgeDhDzOulGrKauhKjUkvN7Y2LOzlDdIm0sP2OOXzChCh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:1sAOaiPpNZ5mTDc_YvKcgzK9DphQNhkSXk21ivj9TWejzGjpO5Sa7g>
    <xmx:1sAOalOr0rPfoObyDjgNGrBe_-p2XEoswlG1lS5qxWej0Bi5jnHnlg>
    <xmx:1sAOakRxzoJFlQo3h-IHbtMAzUJi0A6QfJ62BPhEQ4-QABiGBxm0bg>
    <xmx:1sAOanBbWJ2jdDRY9dEG89o_D4G2yaNoXbJKE1lKdBQ22iCkQ_NYoQ>
    <xmx:1sAOalXHUr2ILbmzxn2RZIS305VLkoN3t1JrFpsxTrGHGivwMIg6L6YL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26a1c5a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:26 +0200
Subject: [PATCH 06/18] odb/source-loose: wire up `read_object_info()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-6-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `odb_source_loose_read_object_info()` from "object-file.c" into
"odb/source-loose.c" and wire it up as the `read_object_info()` callback
of the loose source. Callers that previously invoked it directly now go
through the generic `odb_source_read_object_info()` interface instead.

The function `read_object_info_from_path()` cannot be moved along with
it because it is still called by `for_each_object_wrapper_cb()`. It is
therefore kept in place, but adjusted to take a loose source to clarify
that it's always operating on this structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 46 +++++++++++++---------------------------------
 object-file.h      | 11 ++++++-----
 odb/source-files.c |  2 +-
 odb/source-loose.c | 24 ++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/object-file.c b/object-file.c
index 0f4f1e7bdc..fa174512a4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -396,13 +396,12 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-static int read_object_info_from_path(struct odb_source *source,
-				      const char *path,
-				      const struct object_id *oid,
-				      struct object_info *oi,
-				      enum object_info_flags flags)
+int read_object_info_from_path(struct odb_source_loose *loose,
+			       const char *path,
+			       const struct object_id *oid,
+			       struct object_info *oi,
+			       enum object_info_flags flags)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
 	int ret;
 	int fd;
 	unsigned long mapsize;
@@ -425,7 +424,7 @@ static int read_object_info_from_path(struct odb_source *source,
 		struct stat st;
 
 		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
-			ret = quick_has_loose(files->loose, oid) ? 0 : -1;
+			ret = quick_has_loose(loose, oid) ? 0 : -1;
 			goto out;
 		}
 
@@ -532,7 +531,7 @@ static int read_object_info_from_path(struct odb_source *source,
 		if (oi->typep == &type_scratch)
 			oi->typep = NULL;
 		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
+			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
 		if (!ret)
 			oi->whence = OI_LOOSE;
 	}
@@ -540,26 +539,6 @@ static int read_object_info_from_path(struct odb_source *source,
 	return ret;
 }
 
-int odb_source_loose_read_object_info(struct odb_source *source,
-				      const struct object_id *oid,
-				      struct object_info *oi,
-				      enum object_info_flags flags)
-{
-	static struct strbuf buf = STRBUF_INIT;
-
-	/*
-	 * The second read shouldn't cause new loose objects to show up, unless
-	 * there was a race condition with a secondary process. We don't care
-	 * about this case though, so we simply skip reading loose objects a
-	 * second time.
-	 */
-	if (flags & OBJECT_INFO_SECOND_READ)
-		return -1;
-
-	odb_loose_path(source, &buf, oid);
-	return read_object_info_from_path(source, buf.buf, oid, oi, flags);
-}
-
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,
@@ -1833,7 +1812,7 @@ int for_each_loose_file_in_source(struct odb_source *source,
 }
 
 struct for_each_object_wrapper_data {
-	struct odb_source *source;
+	struct odb_source_loose *loose;
 	const struct object_info *request;
 	odb_for_each_object_cb cb;
 	void *cb_data;
@@ -1848,7 +1827,7 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 	if (data->request) {
 		struct object_info oi = *data->request;
 
-		if (read_object_info_from_path(data->source, path, oid, &oi, 0) < 0)
+		if (read_object_info_from_path(data->loose, path, oid, &oi, 0) < 0)
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
@@ -1865,8 +1844,8 @@ static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
 	if (data->request) {
 		struct object_info oi = *data->request;
 
-		if (odb_source_loose_read_object_info(data->source,
-						      oid, &oi, 0) < 0)
+		if (odb_source_read_object_info(&data->loose->base,
+						oid, &oi, 0) < 0)
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
@@ -1881,8 +1860,9 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 				     void *cb_data,
 				     const struct odb_for_each_object_options *opts)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	struct for_each_object_wrapper_data data = {
-		.source = source,
+		.loose = files->loose,
 		.request = request,
 		.cb = cb,
 		.cb_data = cb_data,
diff --git a/object-file.h b/object-file.h
index 420a0fff2e..8ac2832dac 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,11 +21,6 @@ struct object_info;
 struct odb_read_stream;
 struct odb_source;
 
-int odb_source_loose_read_object_info(struct odb_source *source,
-				      const struct object_id *oid,
-				      struct object_info *oi,
-				      enum object_info_flags flags);
-
 int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 					struct odb_source *source,
 					const struct object_id *oid);
@@ -198,6 +193,12 @@ int read_loose_object(struct repository *repo,
 		      void **contents,
 		      struct object_info *oi);
 
+int read_object_info_from_path(struct odb_source_loose *loose,
+			       const char *path,
+			       const struct object_id *oid,
+			       struct object_info *oi,
+			       enum object_info_flags flags);
+
 struct odb_transaction;
 
 /*
diff --git a/odb/source-files.c b/odb/source-files.c
index 59e3a70d80..8d6924755f 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -55,7 +55,7 @@ static int odb_source_files_read_object_info(struct odb_source *source,
 	struct odb_source_files *files = odb_source_files_downcast(source);
 
 	if (!packfile_store_read_object_info(files->packed, oid, oi, flags) ||
-	    !odb_source_loose_read_object_info(source, oid, oi, flags))
+	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
 		return 0;
 
 	return -1;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 65c1076659..50f387ecf3 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -2,10 +2,33 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "loose.h"
+#include "object-file.h"
 #include "odb.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
 #include "oidtree.h"
+#include "strbuf.h"
+
+static int odb_source_loose_read_object_info(struct odb_source *source,
+					     const struct object_id *oid,
+					     struct object_info *oi,
+					     enum object_info_flags flags)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	static struct strbuf buf = STRBUF_INIT;
+
+	/*
+	 * The second read shouldn't cause new loose objects to show up, unless
+	 * there was a race condition with a secondary process. We don't care
+	 * about this case though, so we simply skip reading loose objects a
+	 * second time.
+	 */
+	if (flags & OBJECT_INFO_SECOND_READ)
+		return -1;
+
+	odb_loose_path(source, &buf, oid);
+	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
+}
 
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
@@ -60,6 +83,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.free = odb_source_loose_free;
 	loose->base.close = odb_source_loose_close;
 	loose->base.reprepare = odb_source_loose_reprepare;
+	loose->base.read_object_info = odb_source_loose_read_object_info;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

