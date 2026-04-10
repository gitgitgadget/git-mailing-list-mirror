Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC403BE155
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823188; cv=none; b=QifXc86lP8/4lK03dI/p16OFhYh9/9OEqk6ALFPCppALfMw79JxpuA0vlf8Oyux48HpFM9d+TdM1A2lcK9cyTdClOgSH8Cn8+LHTaC8SYC0FdCWUgEB2fDgS+SpIXw2c8fa25r/ON1hhqAm3jjd4/Q8i+/Sdh9dlF7VTZUMa+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823188; c=relaxed/simple;
	bh=8aAfy+aCcWHpiXnoQt/+dLb5Wm9wIiBsu3VePt3kZrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWay1DdMRA5SlXkry0UrgZIB4wm7rhi/LmD0H9yPM6f6gQeUu7nsjbhsOZ4GwXqBLD7oApBZ2jrilOtP5r3RyRnEoCDcS1tEuB1hR0Hrvk3Wo9hES7kSAMxXq8wgxXtUTDae33nzlrj3a5z8Q0Q6FkTXWuHd/wSc4tBfbKOLqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d7c/fIsw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MN8LE0PP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d7c/fIsw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MN8LE0PP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2D447A029B;
	Fri, 10 Apr 2026 08:13:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Apr 2026 08:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823186;
	 x=1775909586; bh=PKujhVGrW3adGu0XsyZOvEWHwis7FB770alaVAZiAjw=; b=
	d7c/fIswip2UY8Bn+YWaG8MrIWFFH4L4ay5euYM4tSOPzzZlEIz0P8RzP6vEqNRl
	H1n1+g7IaSp7b+n3qs9QB8gDnRDF8Ua7meWdv91HdJNvwKAuxQlfiWbp2UM4x8e9
	bG05q7V6lngQHKNLHu+QUzlWXboHGSkTjO9s8SvWMwuIIaRvpZGLSgmiu31Yk8uZ
	En1F7tz3rNHkISsCYo/O9X075vf+HOQIujyJjtBcR/YXuNUWQmo5YnLarkSN5vbj
	kczLWHpuAQ6cgwXPrgus9d1+ZfFGJw9XN/tAUkecHSgQSM8GeXiygSuyLfD43DpD
	mOb4dEwvo4f2RIBD1yImUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823186; x=
	1775909586; bh=PKujhVGrW3adGu0XsyZOvEWHwis7FB770alaVAZiAjw=; b=M
	N8LE0PPzwT34O0G0C27XoYaOveKmTzuiCt4sz4/tra0C7lQKr3RnTlZJx2aRzDIa
	H7Uow7cS3+OwWxihNyTrhNNWY9h0MCKLLG3GyJrRcvte1qTGlWc1cOzctzW95DwA
	n2xqOZl1kz83nt4Dl+yMpTRR7am/vKN5JV+v/l+e4q1/8ndsFmV3NVoLtb8UcrzO
	karmJFsSqAE73X14a0R14xFzyvhxcRqOyrDGR+bRIXfe1q8KUwIkC6SRu1lZ42xz
	6EwPkD3C4SDlk8mdH4Ln6w3daZ89UV0bKFmz2kbJbUF4HY45Rtx7lSvrl287fCJ5
	pxhloq6ldx4vRTcTtS80g==
X-ME-Sender: <xms:UunYadrMVH5FQYobWVVq4HY3XQ9anssoygLOkB0Nd61W1SrrV4e4fg>
    <xme:UunYaXEM8ZCtFUKEuQdpCCurQK4ub6RgP9cdVbENd0MD11SLBqr-QXrwWv-xDi39G
    mGtujrIzLQhPHOewOraxMEDrJXvpsfNsNDsss7sAbDOTAdQv_IwVA>
X-ME-Received: <xmr:UunYaXnaefJ0S9OMb_CwIP9iPrzKh3D13AY4MCw5I-q9v6lkxtYVGsHwA6aAphsFIbGnva6I-9pHzP6eIcCMdEDqTbJULeHCWqVC9Bt3NS1xmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:UunYaSk_gfZgL3DfRNku461JM9vYtFhBjk6yHcULV5aPAAB2mx7lWw>
    <xmx:UunYaQs29EXEfwyGfSJRH6wTit-ZNPVy5eX-r2ksgPe411CKm5jxdA>
    <xmx:UunYadllPpjXG8WZ8KqVqRlwMW2gvOCK9i5_JUnUeE-taEV0Qt4HVQ>
    <xmx:UunYaTtd8WEY3UN3XpEzwfjw31nFvWnBPacx8a9FEnZd6UOC8EcgHg>
    <xmx:UunYafFNL4E5CI8RVjn-Bwh4GY0SGRjSxG6ypz_2uW4AnIUqETx9Tk_->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d2ff1b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:37 +0200
Subject: [PATCH v3 07/17] odb/source-inmemory: implement
 `write_object_stream()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-7-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `write_object_stream()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 4848011df5..d05a13df45 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -128,6 +128,45 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_inmemory_write_object_stream(struct odb_source *source,
+						   struct odb_write_stream *stream,
+						   size_t len,
+						   struct object_id *oid)
+{
+	char buf[16384];
+	size_t total_read = 0;
+	char *data;
+	int ret;
+
+	CALLOC_ARRAY(data, len);
+	while (!stream->is_finished) {
+		ssize_t bytes_read;
+
+		bytes_read = odb_write_stream_read(stream, buf, sizeof(buf));
+		if (total_read + bytes_read > len) {
+			ret = error("object stream yielded more bytes than expected");
+			goto out;
+		}
+
+		memcpy(data + total_read, buf, bytes_read);
+		total_read += bytes_read;
+	}
+
+	if (total_read != len) {
+		ret = error("object stream yielded less bytes than expected");
+		goto out;
+	}
+
+	ret = odb_source_inmemory_write_object(source, data, len, OBJ_BLOB, oid,
+					       NULL, 0);
+	if (ret < 0)
+		goto out;
+
+out:
+	free(data);
+	return ret;
+}
+
 static void odb_source_inmemory_free(struct odb_source *source)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
@@ -149,6 +188,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.write_object = odb_source_inmemory_write_object;
+	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 
 	return source;
 }

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

