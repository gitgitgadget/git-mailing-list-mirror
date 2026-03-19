Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD2379960
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903197; cv=none; b=q513oc5Z7mD5E0YlU0eU3l1iEJ1Oa2n1OSDvlgGIKDO1TpSiiS7ai6vA/5Sj70HB25yVNO/VSqjK/ldjSVqKQLklOsgE5tpt8C71YQFUYTy5NJdfpmvkQF5w8KYFM8XbvycqBSdEwUeAPqSqTcZNMfSqLWFpXmHdSm5G9NUUNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903197; c=relaxed/simple;
	bh=9+F56kvMUii5eq+aFiH463oLakMNyxu3JaOSLIPE+Ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8Q4CIIqWFZncYVUQ5wsTwUJel/0YvUat624fnCZgyDX5WYE9jqKbJk6WcE9ca6dlvsD6Os070zWvpWVjTzs/hRJ15Kwx4hfjYL9sv3EhFXvQ/AatqoDncTCedm26+beWK2EZ/2ZLEAuFh+5eetTj8piRNjnXkTVEApG6WjMmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T/vAamCm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lull1LSR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T/vAamCm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lull1LSR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D3D8EC0222
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 02:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903195;
	 x=1773989595; bh=NOq8VgXPoZAIpHx9arw/ru1GY1HKKsiQsMNyltMMTtk=; b=
	T/vAamCmqqhOfFoXpk+BRfUJz1WnELOijWxDrO6EvJ9g5HpsGG4dgapw5QzK2uD+
	AAYJx2noctyh6ghGvWSjmYD1OuLMxx0u+1rGzQNCo9cIQSmICI+ALhrYaejQZNuI
	VBoZmoTWeLvWHaVJOYPFCER/cT7J7QyDkrFkP0D3TfMHkNpUdBWwi13CoengI5qx
	vn/tCo6fOYOGUZg7HgbZKVVVK42iukdFKnD6IrYqRUOBFykR+YW2mtijLMayMXOg
	wR1DMRDrPERXG8SKSIxOxKWoAnSbnZ27AHg4PmW5D0wY6ff+3iXTngsNCkkgud0R
	YX3EXfbRE5yEIAz337ZHPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903195; x=
	1773989595; bh=NOq8VgXPoZAIpHx9arw/ru1GY1HKKsiQsMNyltMMTtk=; b=L
	ull1LSRJq/AJxe6VcCNQL/q0VXVLoUc9M0q1SQaq91nzgTEB/zsaU1ahMaqQQJP3
	C/Ps2KhaDFD64tSWPaQ2I4QRVfzbYU+N74UUlJ9wCiWp4yMJo42sXH9cWwR23EJ8
	Rw/PAtaGMO1fXHy2m8l2FLsEo6KLI2MYi5QOvUBMHyxPLi4JDZ7SVQhaac8SRTTf
	qntjDUHC0iYcaKA6U+bkTfFUWfso0b6ehHRHEmBCjf7rJpR54pjcG13dFejCNIIh
	0TjAVnXVb8qZazYbBCW5WujIg86v5lf1tDdCwS3L+fNKzc2+GXRH3HnkJD0vs1gs
	+5uaQP4ETC/Ty5Bl451zQ==
X-ME-Sender: <xms:W527aSvHfOnK8hRbZ3_dG3EaiEAT2uHRDxrVzzNCtMr5AEljvW-gKw>
    <xme:W527aeaDVRHDsjEmHFbj-2Xw_Xip0L4EXdZ5Cy9B892l52NMmeg4iFTVYSsKz1qK_
    FzcpuL_JmAMBYnOrsTmpmPCMLhCvO8TzucWt2IoIXKpF910VVEE6A>
X-ME-Received: <xmr:W527aTY4FL76_Fp86Vqhb6-vB8dQRycbdWyBGVz8Y3LQz_kq6mN3yzOtKl8nZwLHaorGQ49DtZ9mZ3OkfaWAWcmAnipuqfvpHDUjxlAjIwns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:W527aSX0WSe6MVV8HIUATDcYSJJyW89-ohzLueV3wfPbyRwF9j4oIw>
    <xmx:W527aS0n51sPUzXPiLOBiSnntW1dw_rdcMrn8ygUFQkdXTi2nIYTCA>
    <xmx:W527aRYJxbN4Lm3b-rEG5SuUIVZYmg2G9jj8QKzPBsAKD5SBEo5AMg>
    <xmx:W527adqrVRS0RiSmfVmUYSNlhtS0QU7_0mfchAbABoNpQDD5aMkmbg>
    <xmx:W527adeWd5Te4WnmF14BHK3IXaEiSE-3bMBIf2z7UjL1xPLvS8qgmSBp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d016d6c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:02 +0100
Subject: [PATCH 04/14] object-name: move logic to iterate through loose
 prefixed objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-4-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The logic to iterate through loose objects that have a certain prefix is
currently hosted in "object-name.c". This logic reaches into specifics
of the loose object source, so it breaks once a different backend is
used for the object storage.

Move the logic to iterate through loose objects with a prefix into
"object-file.c". This is done by extending the for-each-object options
to support an optional prefix that is then honored by the loose source.
Naturally, we'll also have this support in the packfile store. This is
done in the next commit.

Furthermore, there are no users of the loose cache outside of
"object-file.c" anymore. As such, convert `odb_source_loose_cache()` to
have file scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 29 +++++++++++++++++++++++++++--
 object-file.h |  7 -------
 object-name.c | 10 ++++++----
 odb.h         |  7 +++++++
 4 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/object-file.c b/object-file.c
index ddcc8e81b4..8a9e68a768 100644
--- a/object-file.c
+++ b/object-file.c
@@ -33,6 +33,9 @@
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
 
+static struct oidtree *odb_source_loose_cache(struct odb_source *source,
+					      const struct object_id *oid);
+
 static int get_conv_flags(unsigned flags)
 {
 	if (flags & INDEX_RENORMALIZE)
@@ -1845,6 +1848,23 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 	}
 }
 
+static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
+					       void *cb_data)
+{
+	struct for_each_object_wrapper_data *data = cb_data;
+	if (data->request) {
+		struct object_info oi = *data->request;
+
+		if (odb_source_loose_read_object_info(data->source,
+						      oid, &oi, 0) < 0)
+			return -1;
+
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
+}
+
 int odb_source_loose_for_each_object(struct odb_source *source,
 				     const struct object_info *request,
 				     odb_for_each_object_cb cb,
@@ -1864,6 +1884,11 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 	if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
 		return 0;
 
+	if (opts->prefix)
+		return oidtree_each(odb_source_loose_cache(source, opts->prefix),
+				    opts->prefix, opts->prefix_hex_len,
+				    for_each_prefixed_object_wrapper_cb, &data);
+
 	return for_each_loose_file_in_source(source, for_each_object_wrapper_cb,
 					     NULL, NULL, &data);
 }
@@ -1934,8 +1959,8 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-struct oidtree *odb_source_loose_cache(struct odb_source *source,
-				       const struct object_id *oid)
+static struct oidtree *odb_source_loose_cache(struct odb_source *source,
+					      const struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	int subdir_nr = oid->hash[0];
diff --git a/object-file.h b/object-file.h
index 46dfa7b632..f11ad58f6c 100644
--- a/object-file.h
+++ b/object-file.h
@@ -74,13 +74,6 @@ int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *stream, size_t len,
 				  struct object_id *oid);
 
-/*
- * Populate and return the loose object cache array corresponding to the
- * given object ID.
- */
-struct oidtree *odb_source_loose_cache(struct odb_source *source,
-				       const struct object_id *oid);
-
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
diff --git a/object-name.c b/object-name.c
index a24a1b48e1..929a68dbd0 100644
--- a/object-name.c
+++ b/object-name.c
@@ -16,7 +16,6 @@
 #include "remote.h"
 #include "dir.h"
 #include "oid-array.h"
-#include "oidtree.h"
 #include "packfile.h"
 #include "pretty.h"
 #include "object-file.h"
@@ -103,7 +102,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 
 static int match_hash(unsigned, const unsigned char *, const unsigned char *);
 
-static int match_prefix(const struct object_id *oid, void *arg)
+static int match_prefix(const struct object_id *oid, struct object_info *oi UNUSED, void *arg)
 {
 	struct disambiguate_state *ds = arg;
 	/* no need to call match_hash, oidtree_each did prefix match */
@@ -113,11 +112,14 @@ static int match_prefix(const struct object_id *oid, void *arg)
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
+	struct odb_for_each_object_options opts = {
+		.prefix = &ds->bin_pfx,
+		.prefix_hex_len = ds->len,
+	};
 	struct odb_source *source;
 
 	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
-				&ds->bin_pfx, ds->len, match_prefix, ds);
+		odb_source_loose_for_each_object(source, NULL, match_prefix, ds, &opts);
 }
 
 static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
diff --git a/odb.h b/odb.h
index a19a8bb50d..e80fd8f7ab 100644
--- a/odb.h
+++ b/odb.h
@@ -488,6 +488,13 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
 struct odb_for_each_object_options {
 	/* A bitfield of `odb_for_each_object_flags`. */
 	enum odb_for_each_object_flags flags;
+
+	/*
+	 * If set, only iterate through objects whose first `prefix_hex_len`
+	 * hex characters matches the given prefix.
+	 */
+	const struct object_id *prefix;
+	size_t prefix_hex_len;
 };
 
 /*

-- 
2.53.0.1055.ga2ffed1127.dirty

