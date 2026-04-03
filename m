Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB6296BDA
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196162; cv=none; b=W9/hZaMpy6X3QlZ8HYRcx3K7udKUlxAz8yuxdE++vPD0/YQ6+wj+Qu4DbTgEKN+yVuSjibv+jQzqPBCwWQxjuh99AKhMnI4YEBumooe6mo/e3Mab6fDz8i9BK5qhZaFdA43jn0mFJps/Odr7gCE8y21SzzeO8t5n6da9rPGuaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196162; c=relaxed/simple;
	bh=RbrAiOCBdHw6bI3rIh0QZXvpCwyMKHhc4OFgaqHmIn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlCDEpJpjjowa2APDdLNkeZ+z3ErlkUDJ06y6gMef1r2wYEykQqwJyRZ768U0j6n7sYmUNdBbrXmi+PSmcHoehTTK3GKZ0QSP7q7zdZNDL8zoPjLqxSF91paG5u0l2ILhCBAqEvulQth/f3r/A6R36Ly15/nseQsuEGK3PFtSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TF87OJnL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DaoLVXtn; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TF87OJnL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DaoLVXtn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B674F1D00165
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 03 Apr 2026 02:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196151;
	 x=1775282551; bh=ZxbOGCo3A/etyjbUspti3yJMQyURJkk1P9amobCdJUs=; b=
	TF87OJnLnq8wZ3sxQZ/0aI31xqMeOemz216rMCE0OoQWJ7XGrdNcMn1uuhz7jltM
	k7NGrYyUsO33cSNhPyx6A9JCSeT9Uva4xrnHqLLGxcUUqwxMTvCqF7a/xbvr30Y4
	Qw4jvU32E+/ovnYzyWE4j4l3T/01rLCc8FngLtRTlLCsTBIy8svdrSucoL5GzYaN
	mdccJPnWIbc38RD9Twlc7ggdAXGDcaM4Zn6p3b8Z15FFVJew7d44IXx1gBsNlWdK
	ZjMlP+Y5L/yLYN3pUwKf/nGnxtwSY4V/CZjOZYhxKtBJ1YJ/ANra5Jj33cdwsA/8
	58e81s0AbvyZKvCFys6lzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196151; x=
	1775282551; bh=ZxbOGCo3A/etyjbUspti3yJMQyURJkk1P9amobCdJUs=; b=D
	aoLVXtnlzCuVc8KI3X1bPmydMs0G5MuwQKymbn4YPKkSwlhwra9xwSkdnML4X8uP
	0Sd0YoyZC4044Pb8X+qNoKEozTkh23vI3Vs8YunmPrELd7W+9PX33Tx1zvuvoUm3
	fmBLq0vfyaPqO1enGDPKzyJCIG5u7AzPUv1MB3wU3VivQtdABssHrLmyXnV1UXyT
	yKeQCf56dc81HAKs/I61CWwe76BiDX1WgO+FSz3oDvOB3pcxqZALSsdIdbE8c/2n
	QQPeor3W4VgGMKnBT0FBUJ8qCZt5zWJsTMTfkZIH13cg6g8JiaDX4l0pwhLSuKsS
	T66ZsfIGnTUvd8JaMP9CA==
X-ME-Sender: <xms:91fPaSsvctGQvt-q3CS2VCLWTAllyhf6TpLtrULSfhkLEfPI0k2dUQ>
    <xme:91fPaebLQjCju-vH7bLw-ib5afgvTMjn5rRuEDYwTV8BgjEVhCTyEAaNx90wK23eo
    BHq9cUSDTWCoX_h2hqL-cQkFPOZGMy1UeE7Dt979JYoLc_8IpVi>
X-ME-Received: <xmr:91fPaTbgy3c2-Lb2B4ScL60wqlCrPwwLJ0feE8pZwjPKJyPCPjqoczcdjqd8CXzO_uRKfYPhanktd6SfBsFYNNzFUS-px8uBcvVFMNb0UEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:91fPaSV8fBta5_ngYXxlEq7eZz6flkoKS90i_RMDsoyfep8-O3yZwA>
    <xmx:91fPaS0Py7QiZnGOy4c5os_SBMx-opAB-SpWzE0tvSi0aGHHO99i0g>
    <xmx:91fPaRbRPi8PY5JmzaYOn7LyoE6Ev1p2ybUxjgqsEN_5SzPwF8f-7A>
    <xmx:91fPadrT33B6tcEvpwFsrYvWGd1HiQF8TDfjkcIc2YUSAGnn3Ra2MA>
    <xmx:91fPadceTHbeb-ky4m8v08-zSgFDS3qy-6PCggYDhSUM9-w-jbOMI8ny>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dba57c1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:53 +0200
Subject: [PATCH 06/16] odb/source-inmemory: implement `write_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-6-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `write_object()` callback function for the inmemory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 16 ++--------------
 odb/source-inmemory.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/odb.c b/odb.c
index b8e7356951..34228c0cd5 100644
--- a/odb.c
+++ b/odb.c
@@ -733,24 +733,12 @@ int odb_pretend_object(struct object_database *odb,
 		       void *buf, unsigned long len, enum object_type type,
 		       struct object_id *oid)
 {
-	struct cached_object_entry *co;
-	char *co_buf;
-
 	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
 	if (odb_has_object(odb, oid, 0))
 		return 0;
 
-	ALLOC_GROW(odb->inmemory_objects->objects,
-		   odb->inmemory_objects->objects_nr + 1,
-		   odb->inmemory_objects->objects_alloc);
-	co = &odb->inmemory_objects->objects[odb->inmemory_objects->objects_nr++];
-	co->value.size = len;
-	co->value.type = type;
-	co_buf = xmalloc(len);
-	memcpy(co_buf, buf, len);
-	co->value.buf = co_buf;
-	oidcpy(&co->oid, oid);
-	return 0;
+	return odb_source_write_object(&odb->inmemory_objects->base,
+				       buf, len, type, oid, NULL, 0);
 }
 
 void *odb_read_object(struct object_database *odb,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 4a68169430..d2fc4c4054 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -102,6 +102,27 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
 	return 0;
 }
 
+static int odb_source_inmemory_write_object(struct odb_source *source,
+					    const void *buf, unsigned long len,
+					    enum object_type type,
+					    struct object_id *oid,
+					    struct object_id *compat_oid UNUSED,
+					    enum odb_write_object_flags flags UNUSED)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	struct cached_object_entry *object;
+
+	ALLOC_GROW(inmemory->objects, inmemory->objects_nr + 1,
+		   inmemory->objects_alloc);
+	object = &inmemory->objects[inmemory->objects_nr++];
+	object->value.size = len;
+	object->value.type = type;
+	object->value.buf = xmemdupz(buf, len);
+	oidcpy(&object->oid, oid);
+
+	return 0;
+}
+
 static void odb_source_inmemory_free(struct odb_source *source)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
@@ -122,6 +143,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.free = odb_source_inmemory_free;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
+	source->base.write_object = odb_source_inmemory_write_object;
 
 	return source;
 }

-- 
2.53.0.1323.g189a785ab5.dirty

