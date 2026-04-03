Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CE370D47
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196159; cv=none; b=V2Df5MO4mgsFJUIcDkBzHF8tng7ch3cciyH+t2ySPR4uKcrxJ3voSU6LjVKUcYcbOxdRBqI5vuvcbNuruoWMWaGYzBdczkRbkGf6b9HmqnHKBkpjmzTnpS+hQ1+J0gcmWxZ6zrywx3DWqmAQV0c539h84P6nNZKTkZGlsDMisc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196159; c=relaxed/simple;
	bh=IQKBuOnXuDwMT510pREyXdu6DyfHIl1kBG6PvMJaoVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPFMBgz0VUELExKfsOM2okVHUQLu6+nM4Pv5E5zIiGNR+3dzlwv+sl5h4MrnQnPjlO3njUYSsGVkiAA7sddF31/e+4SjkG8UcDJD31dxGQN+XoK73QmjWzrWhU+LwiOX+TpGMnonyMLFzIM116y/kDjIU0f8Crw1/EUpB7Vlkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=czAgkb6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jE5mNwhS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="czAgkb6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jE5mNwhS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C3D461D00064
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 03 Apr 2026 02:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196148;
	 x=1775282548; bh=PCPhcUq+XoyWImEluDwdGJpPzCY2rfYPq6i9dW9HPk0=; b=
	czAgkb6ctiO9qijrGJgEEMapK6Ly07AjLvMR39dstWOwYA6u9GCygMgs+ZYHYqSf
	dEcleUadN3xxrj4NOp/ptVnNPOdbYJLHbp9bgiz2lHbtlQBnaqjaaVjhCYjFNqp9
	lKVoBg0bvLfx/IXYWpdUt7cSZ0skE70izDSMUNtHbecexFXhSTS3lg58tOIkgfpP
	QCYLHzKfQ9m+8BVeY3iC9fecs0Kk6IUaNkZ20ld4l+mB0BfMgIyz8ri5r72ucFun
	ZDOjBayqkLX7huIuwuKumRY/HX+AU1N1vMaOPDTtN6eve0Jn7ujGO7Gu4H5oNpN+
	h1KFgjCpdVy4MaVSujW1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196148; x=
	1775282548; bh=PCPhcUq+XoyWImEluDwdGJpPzCY2rfYPq6i9dW9HPk0=; b=j
	E5mNwhSGqeVWmtQuQS5oJoqhMCTmJK99oBU49Pf1H9L+A5/PYjIbs40F6GZFZ71J
	d+HYa6Es5g1GGbEbFWB9HgTwhoYStzxH6HM9OvdV9J9NaVYEh/JjyooSG8vCqePM
	5IVt+a4HwnfLmpBw1ZNIDO9mGPjO1mkvOoqNnDJW6gTX5rklQHkoKlt+KxO8jSth
	awMOCfbp8wnDfMErGGE1JwRGQy+bU9D45XPJRmg3PU6iqEFbnZOBIoVQnzCTfLPC
	xZO5hsL4ifpHeWndfZdbPKb5T6qHWU99Dz4dp4MVJp29sTd/PtncZExX8hYqolz+
	tG+SgZtspYnBmgDww+BHw==
X-ME-Sender: <xms:9FfPacrG_2IJanIGrRe_UjnOGplBE0ir-ZAI_8CdkeG-gkHxwl1OSQ>
    <xme:9FfPaZk0WQh0ycnVRf--3_sIdu0NKW5711ju5KHZGFOnWDXLw1waiwm78KgNTLSRC
    c8Q3g5X8WYzu7d8qAdvhB5HdHboocbKfiTxkdipwhxTrxDIy0Js>
X-ME-Received: <xmr:9FfPaW1Ga1qBiTl7WQzVyXj7vHhW26vbdn0c1sq6MPg3JWtVLn-SIPv-X4m99ZG2sIPF1t5vs5-JA3znfEDwj75pQe5vqzp9CpI3EvuPCrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:9FfPaZBr5LtS14m2bt1fr4ehdND7pI5RDDXrX8jBSbZy33OHiiSI7A>
    <xmx:9FfPabwhyuKhkt8KqZqOrrA5325YtQFLlfWIMzGKPW4n7uGZgRo8zw>
    <xmx:9FfPafkxWg1Uxu_chgpT7fLsWxJj9q1AyVTWtGaKpZLvi9sJJK_lag>
    <xmx:9FfPaYEG2MarxMXbHCzPRyPzFLrVTuCJRJzxWqkdzCm-V3t0B7SpWw>
    <xmx:9FfPaQK_Cp2gQ6Fugl8RPpqhW3Ci4Gd4J7vrfW6AnaHLt9N5igRvi-Vo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89ba0b19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:52 +0200
Subject: [PATCH 05/16] odb/source-inmemory: implement
 `read_object_stream()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-5-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `read_object_stream()` callback function for the inmemory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 12c80f9b34..4a68169430 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "odb.h"
 #include "odb/source-inmemory.h"
+#include "odb/streaming.h"
 #include "repository.h"
 
 static const struct cached_object *find_cached_object(struct odb_source_inmemory *source,
@@ -53,6 +54,54 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
 	return 0;
 }
 
+struct odb_read_stream_inmemory {
+	struct odb_read_stream base;
+	const void *buf;
+	size_t offset;
+};
+
+static ssize_t odb_read_stream_inmemory_read(struct odb_read_stream *stream,
+					     char *buf, size_t buf_len)
+{
+	struct odb_read_stream_inmemory *inmemory =
+		container_of(stream, struct odb_read_stream_inmemory, base);
+	size_t bytes = buf_len;
+
+	if (buf_len > inmemory->base.size - inmemory->offset)
+		bytes = inmemory->base.size - inmemory->offset;
+	memcpy(buf, inmemory->buf, bytes);
+
+	return bytes;
+}
+
+static int odb_read_stream_inmemory_close(struct odb_read_stream *stream UNUSED)
+{
+	return 0;
+}
+
+static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
+						  struct odb_source *source,
+						  const struct object_id *oid)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	struct odb_read_stream_inmemory *stream;
+	const struct cached_object *object;
+
+	object = find_cached_object(inmemory, oid);
+	if (!object)
+		return -1;
+
+	CALLOC_ARRAY(stream, 1);
+	stream->base.read = odb_read_stream_inmemory_read;
+	stream->base.close = odb_read_stream_inmemory_close;
+	stream->base.size = object->size;
+	stream->base.type = object->type;
+	stream->buf = object->buf;
+
+	*out = &stream->base;
+	return 0;
+}
+
 static void odb_source_inmemory_free(struct odb_source *source)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
@@ -72,6 +121,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 
 	source->base.free = odb_source_inmemory_free;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
+	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 
 	return source;
 }

-- 
2.53.0.1323.g189a785ab5.dirty

