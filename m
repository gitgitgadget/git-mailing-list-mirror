Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2817740855
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719488; cv=none; b=a+NPFsKn7655rQKyTO7AFHhl1fDc0KZklgLULJhpQCQ463OJfcpn+iINCssUpRyPb0TGhyDCFD5+JT/gU+/Xml0jhu3J4ghTDoJVqv5v8dfZ/dOguNoYvC7bUqyZNBuxw2GNG/kcWjKi96XerO1dGjNH2j/uNQxwmDIFyjGXimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719488; c=relaxed/simple;
	bh=NF7U9NI02s71X7I4H2Ewa/oRnmw8UZbIp7aj2eMigA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJ2P2SO6lsGayx5H7XEYPMzxkY3T4eqbPWI/oibGjiVx82acKnnN3Ic8uMiWocSG5gyc/WTY3rL7omwXpCvTRyvoRGwhSetEbTxrIA+3A96qkvhXADQMEzzLWpwC8nZUvrN8SUWokEAifEkZMQii2lLfWqrUkCJ24R4lOv/9j64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Urk6kLDG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G3nxMx4J; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Urk6kLDG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G3nxMx4J"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 216DF1400272;
	Thu,  9 Apr 2026 03:24:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 03:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719486;
	 x=1775805886; bh=O77EqKKM6hvktlg+uC153PgMsKcvmgIaKv4HDzIXPUE=; b=
	Urk6kLDGOE8rBcKUk6aSTw+DHj4FwgLiOWyTFD1NlrbCVVO4dByYDQvCoS7ok5Ow
	ZoPvXxd1LLxwQ8mTiOZqrsM0QwonGLajKonsERedYhf1RC5ogg0lJ1E+cfrdjAPu
	QsTY19AebhgjgBDOgcD+VeYBQpxLMtvoiayCQG4WCAmlBL5BOki6A+VEuCHd4B8w
	SLpBV86FKeWH6uXFJ3P0D7F6l1DV7x/UEZhzpoRJAhqOIaETObdDjRvLMRb56erH
	tiPO2G3bCXNMveIu8ZoWIoKB1965+2XUDm9gXZxR8vWFTT+CT5J0qWXXJc2dhwIW
	7Bw/eEpg1pTGslv92/8V2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719486; x=
	1775805886; bh=O77EqKKM6hvktlg+uC153PgMsKcvmgIaKv4HDzIXPUE=; b=G
	3nxMx4Jwkw8x4Zc0kwCrAx+ilwKX0zdGJJ0O8jRBrB9htGcgA9dMT+EUhmFHjKX2
	t+EU+kmN6JPF9mW79t4ZHWAh/oW1CUOr67bYUUYKns6Tg4aoxtVX5AeWstIqOgFk
	Owzxfu+FkFuB6gMnMj5ch3qJOpBlUeQE8K68v5/yM9+77CYxGWDEe75L2LQysJ1g
	I32faEcakynzobuB1av0J6P+FyeuDC2fmpiHzlRJR9fiEUEW+pOrZArW3hQonziB
	Vbi7L4aKJpgP5j7tHVf3ObKUe/7FZkw+ZeW57/HlcWaDl5Rl0IMNrQXaYsJ6O1XA
	RLPBPWiJE3ulivMYKd+rw==
X-ME-Sender: <xms:PVTXad5tJu-0jgUfPI1WaW-k8briWP_rl_w67BjYGWRH9E6Zv0SlGA>
    <xme:PVTXaSUzjNhzmp0kK20kkncNlhi2U50qRNT8QfPBH6HTiBEqMztHbVc3_rzrHZViQ
    4dgZRa6xEUwLAlpSf_E3BzjgQHbsvnENcTkjMF9FK0V9uIXtq_cjw>
X-ME-Received: <xmr:PVTXaR0NP5pYABx-cRyiIRfqClzdZNuFLrM8cWl_529E3CX1Hg54xJEoYKDyp9P8ZCj4YmjZg2SnIMqbikqQs3b4MwmjVI5WqzNOLJ8DNgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:PVTXaf0mJ3hOoZmUq1T-mN3m5777bMNG5V6ulPoBpl5Bmxp2y7IX5A>
    <xmx:PVTXaU9jUBfUmoVZHE8Dr46VtUrrK8otPRBXz2_oagiO7e4JzpXxgQ>
    <xmx:PVTXac3D2D_i4rsSSXRiIJreFUsmoyNePJC_X4stx1r1VczvogUSNA>
    <xmx:PVTXaR-WBKTz8GfC9a7OrZx_3w2zrEngK0uPydKlDD8xgwdPvcon6g>
    <xmx:PlTXaVOtJTYNenS0kgI64xLTINtvTr__OfmZi2HXfK1QU3MvImdkEOOD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e0dafca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:26 +0200
Subject: [PATCH v2 05/17] odb/source-inmemory: implement
 `read_object_stream()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-5-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `read_object_stream()` callback function for the in-memory
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
2.54.0.rc0.680.geaeac8ef83.dirty

