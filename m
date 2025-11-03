Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2352C21CA
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155770; cv=none; b=XZgF4VsVoPxHk+ZCSByKRTYjaU4z5l6aBKPEaCvSCGVUXi1UCPPZe0YJCQGilxS79Gqmt/S5yH8ohX1cnt84YYiTOrWGuD4ubLzZYjWDW53OOwjrLZilk1/SY+FVyS+AP4odb6A9cGi+WDAmcZEFglGSz2ZaYrlHZxLcrPTEU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155770; c=relaxed/simple;
	bh=mNxRarOF6BnW8L94yWUhLlUmvMc5duRS0HV/VDy+R74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoesJURzVf6RhlkOqkoPQBY7lobZNeX2Kyji31ryiBP3pOODjWP7d7WPsB75TyFf6TToKY74BQmnyU6ggRmoBBw6Q6XMK6FXbiXNVgc+UJXMCYH8/sCXO/NrhvDunR6vPR1bbH4yV5VKUG6aMd26lo1RGcqVpTXdL5OyBaY/gxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N6u0kd4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uOcOBv4h; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N6u0kd4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uOcOBv4h"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 042141D00112;
	Mon,  3 Nov 2025 02:42:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 02:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155767;
	 x=1762242167; bh=2f3eZk3iT5beFjd6fV1un3VL+Yp6DwDvXz6T8V1ggvU=; b=
	N6u0kd4LWhL/80RAGJaMNPYBMMpd0hDjNVSs++gr4yNlZ1Ra4ByyXUJl4DICUzv3
	MxTCI8FIaXc7aYn84foUB3WLeMHxMOgQikrXkw1kzZ+BecjTUQuKtFQ0rC0DCgTL
	Mm4xum7F91UUnARTGhlayr2TcX3FxC+4jRI7pGmD6OnapLwa9tFaxvoz3EoIaUxw
	Q7iG2SO8xfpnnvetDX+KIiW920VF8SYSHG7xf0fsu1jV+mj9O3iuvZXehJUFaWC8
	ZgvveSvrxMEovTRdtqEajtwP/08+rRBXB/1EbjY3Pf5toNZv+hS73mimScsLXRnA
	BfokK1h9wg3p9GiEf5+5yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155767; x=
	1762242167; bh=2f3eZk3iT5beFjd6fV1un3VL+Yp6DwDvXz6T8V1ggvU=; b=u
	OcOBv4hqN89hJPGsvX5iVr7MqpbboIhcEIs9ApXeJiuRmKlYSCywnadVn0fNmzWR
	YG+OyKKF6cM5asXQGmNTmhF5wpHji41RNjEEHr53VKEmpva1qUAKHddiRoBTCWRd
	gO083UPjAVFfFHakcv+0rngWQca3Dxbpq7pcBkr+QQ44FZxfKzvRowpM8jbjV3yS
	9glnFHIXI7LXKJ1lg4FcVDPbo79gM4V1GRzZuKBwdfVh2aPH+0Jud0rAhcZK4vvT
	oE5GmBKEK1mBxMlsDPfXDMKTOTp9w49Y6C1J4jrThWidxvJFrdd4dNse5Oqcvjhs
	4SWI5JMkUWo4HyYoDQWTg==
X-ME-Sender: <xms:91wIaTP3mT2onlBLfu7WDd6OxLuSADgQYl0bfyS4fvniWwYlkb74Eg>
    <xme:91wIaVYKfF1u4Wu2CdAu5H7j-wtMJ9zF27aSGQ1vnyu7WwTnYIb4uHkuFosIhu3u7
    Yfi-lAv2ya44-vQ8zDG_0SCt0bL5XE0pxCT3iAihLQ4jGRKIrB8>
X-ME-Received: <xmr:91wIafqy3449l0u67WZA_T9unAh_1I56XbSufe8AkeTa3UfRNAvX06JP869JeSV4nQwAR-K1B_FmgxWoy9itLGJVkCXkeKR05sCu0CUo4lPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:91wIaRZUToN0tCNLeAnNCkeFEpd4fSTpt96YP4e0xRU_OOol01bOYw>
    <xmx:91wIafQMj0qIbzwZuEIUq-1yfB4DgBQIkl9uUVYkzjdT5NNmLOeHAA>
    <xmx:91wIaQ49DdiINewUpQIyrDQdJtqUhjAJGmyULcji31V_nk4D7QTB7g>
    <xmx:91wIacycOL1z_rhZLKcLS-kJDU80wO1otkVOYz5nxlY_jHoAfqPOsw>
    <xmx:91wIaRa8J_PTLFpjiqz8D1JxgShTr0-XEx6H82-I61Xqsk5cJ-Ai1e03>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8b62990 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:07 +0100
Subject: [PATCH v3 12/13] object-file: rename `write_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-12-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Rename `write_object_file()` to `odb_source_loose_write_object()` so
that it becomes clear that this is tied to a specific loose object
source. This matches our modern naming schema for functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c |  8 ++++----
 object-file.h | 10 +++++-----
 odb.c         |  3 ++-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 893c32adcd..fdc644a427 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1084,10 +1084,10 @@ int stream_loose_object(struct odb_source *source,
 	return err;
 }
 
-int write_object_file(struct odb_source *source,
-		      const void *buf, unsigned long len,
-		      enum object_type type, struct object_id *oid,
-		      struct object_id *compat_oid_in, unsigned flags)
+int odb_source_loose_write_object(struct odb_source *source,
+				  const void *buf, unsigned long len,
+				  enum object_type type, struct object_id *oid,
+				  struct object_id *compat_oid_in, unsigned flags)
 {
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
diff --git a/object-file.h b/object-file.h
index ee5b24cec6..36a60e15c4 100644
--- a/object-file.h
+++ b/object-file.h
@@ -62,6 +62,11 @@ int odb_source_loose_has_object(struct odb_source *source,
 int odb_source_loose_freshen_object(struct odb_source *source,
 				    const struct object_id *oid);
 
+int odb_source_loose_write_object(struct odb_source *source,
+				  const void *buf, unsigned long len,
+				  enum object_type type, struct object_id *oid,
+				  struct object_id *compat_oid_in, unsigned flags);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -168,11 +173,6 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
-int write_object_file(struct odb_source *source,
-		      const void *buf, unsigned long len,
-		      enum object_type type, struct object_id *oid,
-		      struct object_id *compat_oid_in, unsigned flags);
-
 struct input_stream {
 	const void *(*read)(struct input_stream *, unsigned long *len);
 	void *data;
diff --git a/odb.c b/odb.c
index 17734bdaff..da44f1d63b 100644
--- a/odb.c
+++ b/odb.c
@@ -1021,7 +1021,8 @@ int odb_write_object_ext(struct object_database *odb,
 			 struct object_id *compat_oid,
 			 unsigned flags)
 {
-	return write_object_file(odb->sources, buf, len, type, oid, compat_oid, flags);
+	return odb_source_loose_write_object(odb->sources, buf, len, type,
+					     oid, compat_oid, flags);
 }
 
 struct object_database *odb_new(struct repository *repo)

-- 
2.51.2.1041.gc1ab5b90ca.dirty

