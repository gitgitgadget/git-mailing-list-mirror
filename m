Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128111FF603
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728210; cv=none; b=VXC9WLuIrqL77JfA5KcphWrdSELR8t1VvOBt0HmJ5wEyhL5CvOkV11/Hqu0Yyc0pVA75r2rrFhNlM6aIIwK/vz9p+VwVYwXn7mpuiaipibzzj2nvXukmbYNN6mDF5KWdOMj0QUVvOxOnChlkl2gZB5uxa726mp/ql6/Whc56/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728210; c=relaxed/simple;
	bh=dnfvaPb9tQsXeLtJqWhg1q4AjiuoIdup7W3IzNDMIFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2PUPP9jLQ1/RmpOJWRtTaMRnKSFgSATumR+tNweTOHBSgGNJ46W0qAkduM0GEV5/qV7prbaE7sVa5aLRxWGjejUCodSXmItfwwtwFaF33AOL1dIdvBkpWrq7V73y5C7fHePjpetKlxqTrXaPVLlxyj2rpZOzMF9M451EcBniZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pyd8P4D6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6uqcta9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pyd8P4D6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6uqcta9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DB4A7A017F;
	Thu, 17 Jul 2025 00:56:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 17 Jul 2025 00:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728207;
	 x=1752814607; bh=fLIvRVCN7ubfVmI+0jFaeWtnDeUVGrX8B2QK4cuvEbQ=; b=
	pyd8P4D6h7n/uqtDp9qTJCGhC6le7vxzXFsXv/Vtn2iH/o/07U5wQ/LqnwnvHp91
	ux9P9BZCVHpc6A6fJmb+swWxUa4B6UFjJVcGWgGxrSn0780jijwnaCjnJ/kUURfL
	duFIJgmCdqQNgxeFYq0vpO23x4L5frEK5ke6c3jReh/peKJ85rpdnk+dAzEmuSfL
	TKdFoMT+tvM0QMcH9Pyy2BxabbEXFGNWX24bqT8w8Nm11YJ9pusi5NjrzFV2BFYV
	bo5kL+LDx+RH1Syajpe25QXvt1MKqssbS6m3ADAG0iITw9UrpKfvM2xp++cI1jtL
	c8KwIHLj0pjxzj1zK42T7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728207; x=
	1752814607; bh=fLIvRVCN7ubfVmI+0jFaeWtnDeUVGrX8B2QK4cuvEbQ=; b=N
	6uqcta9UJbAL77v1QH+mg8tNrMkFUmCRjCR7sI4tI+j9TUtiZgNVTsM1IemQK5Ro
	X+UnlG4n5pRCQhdZFuGo6wS37ZdqET7OFk5hEp5PUEe0DBHFqPpdGsXe+A8ACCnV
	UNHllWAiT2pYCqGhUoxmvTJv3be0QGNb1lyooNzH8KI7hREQwLtCmbxCd7tvXUiy
	KgtRabl2ZLMosOpLycouADLcSlbMreoIQG6dmyz1gAZhZmGcGfqzNk4coCFIYjND
	TzeFH1YCHLXbfdqdbtAg1PiZI8jBFqbmxOR1eVe13FNB7ktusqjx15nWkg33y7e6
	6YRH86gL5xHYmfAPiUbfA==
X-ME-Sender: <xms:j4J4aMRhlcevRXubCxtenPGmEbm6ZhjAFG_EfkNeQ0mzBAqvVPuyqA>
    <xme:j4J4aFRLM-yl6EvYnJwaFIuZiC1YdZcqTS6kcUK9oatMorPWhY0zs3QtYczSLyVgJ
    Nk9icYXuWy3kWY3iw>
X-ME-Received: <xmr:j4J4aAS1lXaoGI7Aj08uIZj-fySjVo8zOnu_hhfw-jE_Vw5BVyixr9GdSRYHvTr7hIKBMBAZ0h8uRAI7P9BZyosKqQWBGR_Nrp9yef07YhjH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:j4J4aK5nJYvoMO5G9HTm8V84Mh4U_Re6YQnZOFDqq3QEORbFlgV7GA>
    <xmx:j4J4aM3Sd1YnVQuHpXTQknggstSjXdHxZ6XKRKcvpLW2yY4Uc24W9A>
    <xmx:j4J4aFA3numaR4iljuqnpV8DvxpWAY_ueQhyuKvK6uuN_y9nJBnZfQ>
    <xmx:j4J4aHOuQPOinHRwhefnEwWOyIIiDo1CtwveFujFuFSYacXtJtVYXA>
    <xmx:j4J4aM2vrsEIQ72tzEOsb1HmWGN3Dg7vK3f1hE2GpJMF8JjgCC-UcNvC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:56:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55ac95bb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:56:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:30 +0200
Subject: [PATCH v2 04/16] object-file: inline `check_and_freshen()`
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-4-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The `check_and_freshen()` functions are only used by a single caller
now. Inline them into `freshen_loose_object()`.

While at it, rename `check_and_freshen_odb()` to `_source()` to reflect
that it works on a single object source instead of on the whole database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7aecaa3d2a0..9e17e608f78 100644
--- a/object-file.c
+++ b/object-file.c
@@ -89,42 +89,19 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_odb(struct odb_source *source,
-				 const struct object_id *oid,
-				 int freshen)
+static int check_and_freshen_source(struct odb_source *source,
+				    const struct object_id *oid,
+				    int freshen)
 {
 	static struct strbuf path = STRBUF_INIT;
 	odb_loose_path(source, &path, oid);
 	return check_and_freshen_file(path.buf, freshen);
 }
 
-static int check_and_freshen_local(const struct object_id *oid, int freshen)
-{
-	return check_and_freshen_odb(the_repository->objects->sources, oid, freshen);
-}
-
-static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
-{
-	struct odb_source *source;
-
-	odb_prepare_alternates(the_repository->objects);
-	for (source = the_repository->objects->sources->next; source; source = source->next) {
-		if (check_and_freshen_odb(source, oid, freshen))
-			return 1;
-	}
-	return 0;
-}
-
-static int check_and_freshen(const struct object_id *oid, int freshen)
-{
-	return check_and_freshen_local(oid, freshen) ||
-	       check_and_freshen_nonlocal(oid, freshen);
-}
-
 int has_loose_object(struct odb_source *source,
 		     const struct object_id *oid)
 {
-	return check_and_freshen_odb(source, oid, 0);
+	return check_and_freshen_source(source, oid, 0);
 }
 
 int format_object_header(char *str, size_t size, enum object_type type,
@@ -918,7 +895,15 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 static int freshen_loose_object(const struct object_id *oid)
 {
-	return check_and_freshen(oid, 1);
+	struct odb_source *source;
+
+	odb_prepare_alternates(the_repository->objects);
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		if (check_and_freshen_source(source, oid, 1))
+			return 1;
+	}
+
+	return 0;
 }
 
 static int freshen_packed_object(const struct object_id *oid)

-- 
2.50.1.465.gcb3da1c9e6.dirty

