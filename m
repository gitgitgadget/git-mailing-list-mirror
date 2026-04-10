Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6D18A93F
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823183; cv=none; b=kdpyyRv6DuRD0gGnLBbFaSTr+RbP3B7uFW7vLrqIbvmKafIYa5oRR+dmlIok4ITcrG89k6F7itvH6/Eg/ezH0PyJbqIBpM+Nt1V6efdHXd0Y6bdrB+/AktuY2OiPcdv2myddj/ET3+rqsjz97jIcKrv348n6p55z54wM7D0mclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823183; c=relaxed/simple;
	bh=kb7aav2ZLaUzHF/u78cDBU7OM61FfqRfLcBwwaxE63E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lqgphrz5JnOI0DUfzBgh6DpBU8S0Vb18QqoXTAN0Q+7QUY3T4RhEaNN4F/axvlXw8mJn1eIKpWl1cy6IMw/SHdymXoHimIawcFkZD68gUAUcuW8gZiz2ibykZK1/nLbd/45ybTH8dz8KiehNLllxt4dz+VBvrZ7IFhmQJxLGkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gvyg/cOJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hw3lwGf3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gvyg/cOJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hw3lwGf3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60CA77A00E8;
	Fri, 10 Apr 2026 08:13:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 08:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823181;
	 x=1775909581; bh=Y7QF5eP3Hd+13BB/159bJ4OkMywtxO2/RqE7aqtE9Xs=; b=
	Gvyg/cOJIkFPb/FxpSu8Rv/SkOIPRJ7hzMBI92GijPltLgS6DrR84imd1azHCPUk
	yAsqSn3Dn3aofFENhh1U0TPO/cZc6XkePt3Jcj4cpFio07+e88QK6jwNduCWdIkH
	MfnMK1xzWzwxNPDGWwKXhy8mdO7WJBm8k/w1B2jGMRP+TWWIJkIO0RaBSYENsiAl
	7po5AX06yK7tROtuqySYc2M1HPn/SCaqFwLA68cdSH7hXI7WplaL2FuPy5F+xPBR
	xeUgrCoZ7WtbIz22NYtegK9kLj1KCUhr4XEIUQrv7DPjeSweiwML0g47+rOZwJx3
	XjRNG39DU1/WZpnNRm1FyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823181; x=
	1775909581; bh=Y7QF5eP3Hd+13BB/159bJ4OkMywtxO2/RqE7aqtE9Xs=; b=H
	w3lwGf37crhaYvPEYGMt97xXzTBO3kjM41my/w7HzPYqOkXn5TPJHoZW1YxDwUed
	pKtsNRe3qqcOPtDncVceujlr4A4JENQX6ohrOFzmat+4MpemACVa0GZMWewjOJYT
	VKmxmR4NOPDtVbi5FZFdOKiCudkkjuIuehqH6gfPQ0E6Sg1bPDdbYK7NSlSDz8d/
	GiXNkmCBPIABph/ixYY/oMAEPuvfUjjJQdVSz6bR0Q+UqYLB5P+xNXC5nep2TzFS
	r/nLA7JMzmN/VQ4sZ9w3vMX3NDwJalbY04kI77rPKobguOR4yepbSSPq7vGF0zDz
	DJFZUAMC5/Mcen3yI/j6g==
X-ME-Sender: <xms:TenYaUPFk3XXCftFTihwkSbwvlNzdxnMuyQrolpzAgK7eoo3fEGcQQ>
    <xme:TenYaSYnu3hk0sSjVnO2Llq9-x5lj4SpDsuAuqhWdkqFDsP__aLpzx4Rzr2qnwBCg
    MWRuhNbH3Q3ueU34MJo2czCFuzXpO5lN4iRarIYjK_vEtN60cmT>
X-ME-Received: <xmr:TenYaYrXYczz-4efVVuaEe2wa293sE-MhAx3UgNulgvzLRSg7XyEea5Rnhv2KNhsly62Y6ibTPwnHtmEtiPyIsWI9Ab02CRlxohL4EGBaRW0CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:TenYaWZFUTX-6Q6zcy0yH9qTZFqEfvjkYpPQFTrsh9fgzBWU0bPzkQ>
    <xmx:TenYaQSsXZB5ON2tSWiqm76sje3tafKe6p9Jn0raJIswzp3gcwwgyA>
    <xmx:TenYad5Wr7ZYw5uAI3CDnwkdOELHwA_D5XcHFHzHihUc21hQ4j9Q4A>
    <xmx:TenYaVx6LlcW48PTqxwpu3qRW1i3nJ-jjiqIE5OP0vYPjkf5LfxUfg>
    <xmx:TenYaeb8zCozM36YKq_ri5ZBhEDxj8SjCJo4eY5_LXP2Y1OgQW-wRFDJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d0f4a16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:12:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:35 +0200
Subject: [PATCH v3 05/17] odb/source-inmemory: implement
 `read_object_stream()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-5-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `read_object_stream()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 12c80f9b34..39f0e799c7 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "odb.h"
 #include "odb/source-inmemory.h"
+#include "odb/streaming.h"
 #include "repository.h"
 
 static const struct cached_object *find_cached_object(struct odb_source_inmemory *source,
@@ -53,6 +54,56 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
 	return 0;
 }
 
+struct odb_read_stream_inmemory {
+	struct odb_read_stream base;
+	const unsigned char *buf;
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
+
+	memcpy(buf, inmemory->buf + inmemory->offset, bytes);
+	inmemory->offset += bytes;
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
@@ -72,6 +123,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 
 	source->base.free = odb_source_inmemory_free;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
+	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 
 	return source;
 }

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

