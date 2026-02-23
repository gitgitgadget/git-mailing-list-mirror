Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E130C366
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863528; cv=none; b=uPtSKoPyvCdyG5EaYZx2k1KluBNR+ydX7pJg0ZIhfzYRNEIjuvSB8zMTFkC2G9BCtclvqb6ejHswOD8wfmRIY00H55ZFqP7e82Xpk0HYxPi0hCpi1sW3VPK41LRm0RmP/WIVK9Ujqv9fTv5x3S+enSy425sSumBnU4cgLthNnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863528; c=relaxed/simple;
	bh=oWJIyJs8RqyrSdmwGIhR+7oXvsRp9eZRUBImZiySb28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5CfbynSjg1vtfzhjFxpdu2cX8OOztyPFHWLn6Gb/PrFD8h7LrRQmc/ZedYvii80Y+gI3uQa33/4VEurXWK/U34sqFG0Ux4ylyixLRkrIsWL32gpKre89A6/GdnfrUkI3s2gDnt/o2MHTOPtRsAzdcDBjIELivrP1sIpo8T75uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TL9FVZI/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A32lSNNW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TL9FVZI/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A32lSNNW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF20214001B9
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 11:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863523;
	 x=1771949923; bh=WS6oKoexjlmy0y+WH9HhjhQpy4ezLeejMIfYvvGWbyo=; b=
	TL9FVZI///Ne0YC0EN4J4vV4wNWSv/QuZLR8pmdAQKD4FpgO9kM2PbjOvfQHF71r
	GjiGNeSHeP2s+BTbg/41ZTRFTdzIZjqRYb4D4J6gTEY29vNga6nSFKS8Jq38Ad83
	1U8X544ttN0fHQUIDglYO7i04UPJwm041hsfBDH8H7vzUf+/3ePzFPKUXXG+DSjk
	jEYLTJ3mV7PUg75dxO37lX1O/3Ka0+54PFbu+AqejF6GR1/yyxWQHcMKxpGxPMfZ
	NHnrJ6KxDX1gZ+klRCL95vKNaUEVbm7s1F64qJSSDAXfV3e98NjHa+AcoR06DtgE
	aZvY7yF1zvG0UGL3OjYRZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863523; x=
	1771949923; bh=WS6oKoexjlmy0y+WH9HhjhQpy4ezLeejMIfYvvGWbyo=; b=A
	32lSNNWfIJJGjlUdZcMLGVv1Snw5IFdQtV3aZkjA5uOxGaUy4s36H5ozSA+SBMsR
	yktTMdUs4Gl7jAUPgo7EY2of7gC/sIIhlLWF+di22OFrqFltvg5KPX8VwAH6WVE5
	H2tSJc9dMFXWk4RDSZ6jeCtxeDJcLylVzof18kcqoInnSGTnXk8it3Thyqzwm6fY
	y8XFj5yic92uujVSkqHWb90MkodW9o2Qls2AnP0qWKTU2YVqQOYx0zmeVEoyU3l3
	SEa9HLyS0A6RtIU84FnPJzQ2KQgrtMmuBoxaEjc46eOAlHHU0M2Tfh7hKRsSgmOI
	i7fpZJSbpxxHljAo933AQ==
X-ME-Sender: <xms:432caWldrV9qnY8Vn6xQhb98raOUfcPtu3AdsWqQPGJ6JQzOz9OEHQ>
    <xme:432caUwwKVCWAuUEi3Dd6PINEBetLKPbALiC7Fwo-WWgXMeaG3shY25HwXqeyuuxq
    mbBKgVeA59oJ0XPL8UDLrfKOgZw4xY-_YuOeN1CuxOVQ1-BC-isrw>
X-ME-Received: <xmr:432caaRDIA3AfHBWg0gYyFW8gRtVsr3M09R_I2ZHLMDWhN0iCqXcPZmQln4UCNLgMJhcWVsgrk1i2V8yZk2hRq23FS17d36fi9nHGa9Jpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:432cafulJ4-vUiJBtvN1dNDQAxCk51gPKdvo6PGR3OJInLuZIpboCw>
    <xmx:432caUsjiuFiOXQ6LncSQOW6HfbGdg8plhctQixtKycr_PpjL7ovgA>
    <xmx:432cadxVVXi71j6lxoCY9u0Ds3ADPY0uEz5cf5PxTDVxdA0nYN7-UQ>
    <xmx:432caShASOU_fnRUDu5OYMfsEO0huFFLmL4AUqZsBJRS1OHMUHdQVg>
    <xmx:432caS1qDWCl8t7dAG1eJkzZAzWDFFeX3pvkcEOd5i2ataYS7c2NgSr5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d7b2266 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:04 +0100
Subject: [PATCH 13/17] odb/source: make `write_object()` function pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-13-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              |  4 ++--
 odb/source-files.c | 12 ++++++++++++
 odb/source.h       | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/odb.c b/odb.c
index c9f42c5afd..5eb60063dc 100644
--- a/odb.c
+++ b/odb.c
@@ -1005,8 +1005,8 @@ int odb_write_object_ext(struct object_database *odb,
 			 struct object_id *compat_oid,
 			 unsigned flags)
 {
-	return odb_source_loose_write_object(odb->sources, buf, len, type,
-					     oid, compat_oid, flags);
+	return odb_source_write_object(odb->sources, buf, len, type,
+				       oid, compat_oid, flags);
 }
 
 int odb_write_object_stream(struct object_database *odb,
diff --git a/odb/source-files.c b/odb/source-files.c
index a6447909e0..67c2aff659 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -98,6 +98,17 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_files_write_object(struct odb_source *source,
+					 const void *buf, unsigned long len,
+					 enum object_type type,
+					 struct object_id *oid,
+					 struct object_id *compat_oid,
+					 unsigned flags)
+{
+	return odb_source_loose_write_object(source, buf, len, type,
+					     oid, compat_oid, flags);
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -116,6 +127,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
 	files->base.freshen_object = odb_source_files_freshen_object;
+	files->base.write_object = odb_source_files_write_object;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 9324fce2ba..a6ef7f782c 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,6 +1,8 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
+#include "object.h"
+
 enum odb_source_type {
 	/*
 	 * The "unknown" type, which should never be in use. This is type
@@ -196,6 +198,24 @@ struct odb_source {
 	 */
 	int (*freshen_object)(struct odb_source *source,
 			      const struct object_id *oid);
+
+	/*
+	 * This callback is expected to persist the given object into the
+	 * object source. In case the object already exists it shall be
+	 * freshened.
+	 *
+	 * The flags field is a combination of `WRITE_OBJECT` flags.
+	 *
+	 * The resulting object ID (and optionally the compatibility object ID)
+	 * shall be written into the out pointers. The callback is expected to
+	 * return 0 on success, a negative error code otherwise.
+	 */
+	int (*write_object)(struct odb_source *source,
+			    const void *buf, unsigned long len,
+			    enum object_type type,
+			    struct object_id *oid,
+			    struct object_id *compat_oid,
+			    unsigned flags);
 };
 
 /*
@@ -315,4 +335,20 @@ static inline int odb_source_freshen_object(struct odb_source *source,
 	return source->freshen_object(source, oid);
 }
 
+/*
+ * Write an object into the object database source. Returns 0 on success, a
+ * negative error code otherwise. Populates the given out pointers for the
+ * object ID and the compatibility object ID, if non-NULL.
+ */
+static inline int odb_source_write_object(struct odb_source *source,
+					  const void *buf, unsigned long len,
+					  enum object_type type,
+					  struct object_id *oid,
+					  struct object_id *compat_oid,
+					  unsigned flags)
+{
+	return source->write_object(source, buf, len, type, oid,
+				    compat_oid, flags);
+}
+
 #endif

-- 
2.53.0.536.g309c995771.dirty

