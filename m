Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314262EDD62
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863522; cv=none; b=lSdtYQHV/wCs9LrqMZbYi0LNSKSx+bc0Ds7pFCFBL+ynGq7Ph5bcocTIdzNkSA7LDIabQ71erpmD8mhP3F8e5BObcmL+TZ4ZTTB15oU3EYd8+Gy6ij8PIWA/W6ubiVQ1o3uGt/003gKe6EawkNCer/rpECmkCRaBIjI/m6CqONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863522; c=relaxed/simple;
	bh=T0G7xJdBfX4db2+j7BpZJiDCxjEzSQhHWafWvXhHAAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfms1Iepkr81sArAq0btHLzB6T2Ej00efgNHAxEv2dK0RXf+grPAeJOAy0FUbr6fM38y8xwLHYJXOp5j8KIPIJ9JnUEFw/0r+HxxnB91Qriva/4KtTG1EBhd+qS6Lj7kyH3r6pB5uRUl/hzr1E/BRCQIuiI0KbzXcZV2lNcxDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l7Dxay3t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEB5hyFX; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l7Dxay3t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEB5hyFX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A53B14001D8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 11:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863518;
	 x=1771949918; bh=RimGT31NvjXLd5OeGHv48JNyqK+EHkSK+4YaOMH0v6Q=; b=
	l7Dxay3tOP5nk3i43FFyHTZqYxZ61WKQPhPxdLAJFtFZabGERGzeNxLZuwsUgViK
	u2aqO9xVqgEsfvcThF0VeKUSs/umvu2bO8HqLZ/8KpAje0KVFNaIt1EK8AtAzz23
	GcNixdCVmsJHvwb09iqsQTf8t5IbOWOkOwlcPDP1U3LgLgLQ2hLDbsXJHyIk7ip9
	DjJDDsu738vVJC2cQthpgvvwQ/qJlVjCmzW/wx/+M5riaJUJaoT/xL51iBpwTlW+
	oFj6q6pzF40QUM5xuZ60HiQgYXzQv5AmeFo3R8jfMi4S5l8rV1peEg2KQxoxeuNR
	OorrGZ6NN6t2jYhXhaDxng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863518; x=
	1771949918; bh=RimGT31NvjXLd5OeGHv48JNyqK+EHkSK+4YaOMH0v6Q=; b=h
	EB5hyFXXTJReyu5ExERtZ1SiTHE5NGAc7fhx7feNdMCPtFwZW+zlhimwl6xXesGz
	CNFowz7d3MSTh68X0ONx9I+ODyTbPjVVqtHPzEumJ/5Ov/LwvkkzJ8QFD9Zjbutx
	pRPqZ/YzFtBs3jLYZKjrAsXzL3JchqUjgaBdXamJ+fJuG8Gxm+weFgH6FM0QdFdV
	+A0GM+PcbeCSc0ttYm9SM4eMq1Yjlfw4Q0ILS1DFkD18qsuJ0MQMc8P3lf2FCDUo
	f26PHgaZ+t5fM6Wb+7woEaPz3TJqd4Tk3dsgckxKtCbXeXFuB/6wdbH+a7HxW3nL
	2I4P8i9w3rlKHR8+RW5yw==
X-ME-Sender: <xms:3n2caQozvParvrnjK8mLuAwEs-jISMjt_UytLGEaGg9AjKgwAg8jxA>
    <xme:3n2cadnL1INOX09h7TfsjOeYv7PuVOz7qOzT34HaMg8hutUdidbIHfuOU33j2QED4
    EH7pQtPEbl0CLusHrmlt1ap2Ykvl2RpIhCPpgPddf3SnNf4wteOvA>
X-ME-Received: <xmr:3n2caa0s7uabbfcQ3qqaXbMaMF2dIEjHYcF4CixPeYF7k-3Br3uMRlMG7iE3-g56SueLD6wR3OlEENrtzpm0BBAl9NnmTJutdlTl9kpbYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:3n2cadD0fe0k8o4YhhbaTGMN0r3F3fmMlHDWPYOLR-OyzCwKu2ynpQ>
    <xmx:3n2cafwRefmf0t6SKZx9K7KeKYKD0g6XKOQkSMQYGVWglR3WYlZ-rg>
    <xmx:3n2caTn9r9xyDGKvJ3sI1ptowkNzaAWQ0jwuqcRe2GJAni2pbDELAw>
    <xmx:3n2cacEQ-wGCPk7KqLVIvti0VWdiNVZYsnb94nukGO6VFirOQjIDfw>
    <xmx:3n2caUIYGZm-4yx3OEH7VUDwbHjIf5PycNl2_L5lS2-Qy5UC9ivS3irb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 832e07c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:02 +0100
Subject: [PATCH 11/17] odb/source: make `for_each_object()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-11-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 12 +----------
 odb.h              | 12 -----------
 odb/source-files.c | 23 +++++++++++++++++++++
 odb/source.h       | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 23 deletions(-)

diff --git a/odb.c b/odb.c
index c0b8cd062b..494a3273cf 100644
--- a/odb.c
+++ b/odb.c
@@ -984,20 +984,10 @@ int odb_for_each_object(struct object_database *odb,
 
 	odb_prepare_alternates(odb);
 	for (struct odb_source *source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
 		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
 			continue;
 
-		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
-			ret = odb_source_loose_for_each_object(source, request,
-							       cb, cb_data, flags);
-			if (ret)
-				return ret;
-		}
-
-		ret = packfile_store_for_each_object(files->packed, request,
-						     cb, cb_data, flags);
+		ret = odb_source_for_each_object(source, request, cb, cb_data, flags);
 		if (ret)
 			return ret;
 	}
diff --git a/odb.h b/odb.h
index 70ffb033f9..692d9029ef 100644
--- a/odb.h
+++ b/odb.h
@@ -432,18 +432,6 @@ enum odb_for_each_object_flags {
 	ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
-/*
- * A callback function that can be used to iterate through objects. If given,
- * the optional `oi` parameter will be populated the same as if you would call
- * `odb_read_object_info()`.
- *
- * Returning a non-zero error code will cause iteration to abort. The error
- * code will be propagated.
- */
-typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
-				      struct object_info *oi,
-				      void *cb_data);
-
 /*
  * Iterate through all objects contained in the object database. Note that
  * objects may be iterated over multiple times in case they are either stored
diff --git a/odb/source-files.c b/odb/source-files.c
index b50a1f5492..d8ef1d8237 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -66,6 +66,28 @@ static int odb_source_files_read_object_stream(struct odb_read_stream **out,
 	return -1;
 }
 
+static int odb_source_files_for_each_object(struct odb_source *source,
+					    const struct object_info *request,
+					    odb_for_each_object_cb cb,
+					    void *cb_data,
+					    unsigned flags)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	int ret;
+
+	if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
+		ret = odb_source_loose_for_each_object(source, request, cb, cb_data, flags);
+		if (ret)
+			return ret;
+	}
+
+	ret = packfile_store_for_each_object(files->packed, request, cb, cb_data, flags);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -82,6 +104,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.reprepare = odb_source_files_reprepare;
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
+	files->base.for_each_object = odb_source_files_for_each_object;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index edb425fdef..35aa78e140 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -53,6 +53,18 @@ struct object_id;
 struct object_info;
 struct odb_read_stream;
 
+/*
+ * A callback function that can be used to iterate through objects. If given,
+ * the optional `oi` parameter will be populated the same as if you would call
+ * `odb_read_object_info()`.
+ *
+ * Returning a non-zero error code will cause iteration to abort. The error
+ * code will be propagated.
+ */
+typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
+				      struct object_info *oi,
+				      void *cb_data);
+
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -151,6 +163,27 @@ struct odb_source {
 	int (*read_object_stream)(struct odb_read_stream **out,
 				  struct odb_source *source,
 				  const struct object_id *oid);
+
+	/*
+	 * This callback is expected to iterate over all objects stored in this
+	 * source and invoke the callback function for each of them. It is
+	 * valid to yield the same object multiple time. A non-zero exit code
+	 * from the object callback shall abort iteration.
+	 *
+	 * The optional `oi` structure shall be populated similar to how an individual
+	 * call to `odb_source_read_object_info()` would have behaved. If the caller
+	 * passes a `NULL` pointer then the object itself shall not be read.
+	 *
+	 * The callback is expected to return a negative error code in case the
+	 * iteration has failed to read all objects, 0 otherwise. When the
+	 * callback function returns a non-zero error code then that error code
+	 * should be returned.
+	 */
+	int (*for_each_object)(struct odb_source *source,
+			       const struct object_info *request,
+			       odb_for_each_object_cb cb,
+			       void *cb_data,
+			       unsigned flags);
 };
 
 /*
@@ -233,4 +266,30 @@ static inline int odb_source_read_object_stream(struct odb_read_stream **out,
 	return source->read_object_stream(out, source, oid);
 }
 
+/*
+ * Iterate through all objects contained in the given source and invoke the
+ * callback function for each of them. Returning a non-zero code from the
+ * callback function aborts iteration. There is no guarantee that objects
+ * are only iterated over once.
+ *
+ * The optional `oi` structure shall be populated similar to how an individual
+ * call to `odb_source_read_object_info()` would have behaved. If the caller
+ * passes a `NULL` pointer then the object itself shall not be read.
+ *
+ * The flags is a bitfield of `ODB_FOR_EACH_OBJECT_*` flags. Not all flags may
+ * apply to a specific backend, so whether or not they are honored is defined
+ * by the implementation.
+ *
+ * Returns 0 when all objects have been iterated over, a negative error code in
+ * case iteration has failed, or a non-zero value returned from the callback.
+ */
+static inline int odb_source_for_each_object(struct odb_source *source,
+					     const struct object_info *request,
+					     odb_for_each_object_cb cb,
+					     void *cb_data,
+					     unsigned flags)
+{
+	return source->for_each_object(source, request, cb, cb_data, flags);
+}
+
 #endif

-- 
2.53.0.536.g309c995771.dirty

