Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF02BDC1B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863516; cv=none; b=VMLojfatOgsHeBniF160SnHA3DMzdkXWf4r3t2T6YtpEYiJIRSSqobGStSn4i2RbGBgJR13EZ6qvH5ZzPaZq9+xY40K1r/bMmAcQx/1OroswF3Ax8jXTXftGf0w6KPXaGG5wZJR1XJhSa9ADP5MW2GcQMMRsSGIHOLhlH+jCJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863516; c=relaxed/simple;
	bh=vU7B6w+sQqdtCmILm8r6MdGJ/0dnvr/ejAi7T7KNZI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROJt7DUv4G/OpKk6EMsCJ/O+go2DtEDqH9QfFD5nJrJHhE9K7JRdkbJxxbMGl8gGoAXA39M+m+Hf+IsOdDrpUU9kAEbyv/dupwHGZSS4In5tgTsiKz9OV7hXoxZkXPYL87F7BjafdgIx927YCe3Hc74OVKWPxxEta3aSfmHM2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YkYOmaAR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xt1IC9pi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YkYOmaAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xt1IC9pi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC5D114001BB
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 11:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863514;
	 x=1771949914; bh=Mswwb9Ze1L0slwDyXgs3Gh2ICqp3RRY1MXG3q0Cxuz8=; b=
	YkYOmaARMlIihAljoEYj0a39qpwsCfZEj1xdmfoy5c8XMwwuSfL0oR1ppu5Duq4w
	nsvNiHAlg/tQ61slW7VvrDS9qGF4jtV5sXsnH0L5kIdQO2z/zH9ZBkv6qIY5Xly2
	s9dU4DnJ2XoaGccgMEjPkowYoKDWxfBvn17MJzGG7pNoORXM/GR+QoAuSByxBFaf
	OVFTFJsC5Y3hsw7oLljC1iBuxHSISzy3GPfYXAsJkhpGAliJHiiy5mEzDlAupuc1
	EjgmU8dVnxidRZ63YZjF5Cp0RfVP2p3D9aOswczV/1OJ0DoOQQ/qjvMoN4AJg/3l
	lddBp10WHvthY7rJe1tgoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863514; x=
	1771949914; bh=Mswwb9Ze1L0slwDyXgs3Gh2ICqp3RRY1MXG3q0Cxuz8=; b=X
	t1IC9pixa6nEfz3tmpiw0P1mbfvtwnmHfSYVCXLWaWT/ziPORJ8ruv8ob7PiBryL
	mz8QFMeeVs3qTCoAYRQlSCM6GQF4dCWLrhumcVXONqHMYAJoncmqF3PY3wnJyMp3
	LU+lswpP1VQd3plXfWSCNFp8pVGJIgK2ywTPnhLPQtRLhI63JOeUvk+3UCFgfGHc
	xLugj4X9reLsr5MGfWdqEIyqtbqqYZiWzUy8RXuGQ5qH4Al6KBtSjS6zQ+5dPKKE
	nB1hEbfRkpOJxoGaOQdMEawmbKb3IW2L/EGAYJNwX8+rAypFWrzwHeHKWn0lFLOm
	fycqEpGZogDY5mRfCdrgQ==
X-ME-Sender: <xms:2n2caaG9w0OYBQol9ivy2IkZX4s6r3C689XSicMs1ysJQwWMe_XR4w>
    <xme:2n2caSR4wstoYALk6ZWQKfjOhIpKq08rz5EsAfWA6uq0xdI2JEy0mjtOWtz9ONFQ5
    E18eLAR4VumZq_TPXL8oULs9-bpNIxHwytEgglI6FyHPqJqOVV7>
X-ME-Received: <xmr:2n2caZzqD-8iclraUjgGEDMM4BoUf8XXsxnV_UoVJRSY58kFUFHaWQlXfZyW9LDeLmDs2304bl9DC-lGdvFnHvCTMg6n1HwR8ZE0nvhYnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:2n2caZON1A5TKFME6w9qH_nM4PdxIUMslF-2_ytAVMqmRfXQn-jzRw>
    <xmx:2n2caQNPW-YbV6pGQXD66EzGDDsGKvy3QoazCQ_y4t69Qap8WrArFw>
    <xmx:2n2caTRDTFAP2ebeneIlUMBIFzp4VNKHY1uiEmGqLb9pFKDxw9UNGQ>
    <xmx:2n2caaBeyM-lSy-4l97id0BSjXrVTCu2VkS6fCxWVI9MN6eLtt6fMg>
    <xmx:2n2cacVnoxUA8m9wyzPxK7s9msKrkRdrQY7t48bjRuEmbb6H-IyYkPTf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5f37a57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:01 +0100
Subject: [PATCH 10/17] odb/source: make `read_object_stream()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-10-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 12 ++++++++++++
 odb/source.h       | 23 +++++++++++++++++++++++
 odb/streaming.c    |  9 ++-------
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index f2969a1214..b50a1f5492 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -55,6 +55,17 @@ static int odb_source_files_read_object_info(struct odb_source *source,
 	return -1;
 }
 
+static int odb_source_files_read_object_stream(struct odb_read_stream **out,
+					       struct odb_source *source,
+					       const struct object_id *oid)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	if (!packfile_store_read_object_stream(out, files->packed, oid) ||
+	    !odb_source_loose_read_object_stream(out, source, oid))
+		return 0;
+	return -1;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -70,6 +81,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.close = odb_source_files_close;
 	files->base.reprepare = odb_source_files_reprepare;
 	files->base.read_object_info = odb_source_files_read_object_info;
+	files->base.read_object_stream = odb_source_files_read_object_stream;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 45563de61e..edb425fdef 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -51,6 +51,7 @@ enum object_info_flags {
 
 struct object_id;
 struct object_info;
+struct odb_read_stream;
 
 /*
  * The source is the part of the object database that stores the actual
@@ -139,6 +140,17 @@ struct odb_source {
 				const struct object_id *oid,
 				struct object_info *oi,
 				enum object_info_flags flags);
+
+	/*
+	 * This callback is expected to create a new read stream that can be
+	 * used to stream the object identified by the given ID.
+	 *
+	 * The callback is expected to return a negative error code in case
+	 * creating the object stream has failed, 0 otherwise.
+	 */
+	int (*read_object_stream)(struct odb_read_stream **out,
+				  struct odb_source *source,
+				  const struct object_id *oid);
 };
 
 /*
@@ -210,4 +222,15 @@ static inline int odb_source_read_object_info(struct odb_source *source,
 	return source->read_object_info(source, oid, oi, flags);
 }
 
+/*
+ * Create a new read stream for the given object ID. Returns 0 on success, a
+ * negative error code otherwise.
+ */
+static inline int odb_source_read_object_stream(struct odb_read_stream **out,
+						struct odb_source *source,
+						const struct object_id *oid)
+{
+	return source->read_object_stream(out, source, oid);
+}
+
 #endif
diff --git a/odb/streaming.c b/odb/streaming.c
index 19cda9407d..a4355cd245 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -6,11 +6,9 @@
 #include "convert.h"
 #include "environment.h"
 #include "repository.h"
-#include "object-file.h"
 #include "odb.h"
 #include "odb/streaming.h"
 #include "replace-object.h"
-#include "packfile.h"
 
 #define FILTER_BUFFER (1024*16)
 
@@ -186,12 +184,9 @@ static int istream_source(struct odb_read_stream **out,
 	struct odb_source *source;
 
 	odb_prepare_alternates(odb);
-	for (source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (!packfile_store_read_object_stream(out, files->packed, oid) ||
-		    !odb_source_loose_read_object_stream(out, source, oid))
+	for (source = odb->sources; source; source = source->next)
+		if (!odb_source_read_object_stream(out, source, oid))
 			return 0;
-	}
 
 	return open_istream_incore(out, odb, oid);
 }

-- 
2.53.0.536.g309c995771.dirty

