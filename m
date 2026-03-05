Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC523A99E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720427; cv=none; b=u+oOmYJQDFQbb2Ax3p6z2OT/mLIUi8vo89TtZt+x8FDINjr/3BmysTethjo219YHp3lBJNNKnWFunZtFb7Fil8taFa1MO5tkFhvVn+D772M0Ye9q2vM3mkPxceaoGCGX9DgQppo0eNOT+SiUJZytJYTvI16TsGs+sms7R+Pr0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720427; c=relaxed/simple;
	bh=XcCJfKM/yywGqs5Iwn4rxKVk7Ag6gyaB+1R79DAeNGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GE8mCl922Jn/l/BfUXUKAVyB0zzjt8ngv2P97NAFwsU5STjBREs+NZ2mX8GHdfB+Dg8jP7ChqSNPuwAOCk3HEF5wQX87um4InCURSd5RKG2K+iJpMaekNLxjg+dVsYqYzLzLnq+1CarabiQ2jPjPvXKj8NWUhtsPc6DYMfIXMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YWOfBQrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b8ftsohN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YWOfBQrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b8ftsohN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 101C77A00FC;
	Thu,  5 Mar 2026 09:20:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 09:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720425;
	 x=1772806825; bh=Kk5p2ygltQLdJ3eU3Sc4xWr7UV4JU2S7ckw30i6xFls=; b=
	YWOfBQrb+yplutFQowVisrEuIjRRGZCCyANvoi1LOz6iexh3Lyb8I4R6Xm3H5/8H
	BqO6i77b5WbsSXcub0Tjj406L3xpmK1XfxNJla5LyS6W3H72C21GPKdRtn/04igh
	jC+lto7oLgmxZhSAK34Imnp4FuZC9NDmxktRjM7qiQ9S/LgiRZXnTe7RVFdAcP6C
	9Oxa+hmyeR8SoXVUDb/b72Qgeb0pAzLqw07Y/2PcRC9tglPjsagls3IvIhhx8C52
	GvoiLvieT10UBjXYVJzjqP4nqM07HnZRLnlEnz1n0y1WBWspRYKHZ2B9xo3S32Ga
	lsMWfdis2VdWGajNluZhxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720425; x=
	1772806825; bh=Kk5p2ygltQLdJ3eU3Sc4xWr7UV4JU2S7ckw30i6xFls=; b=b
	8ftsohNM6bmhrSuw3vIhTLn44ciBT237d11vZBI46cclZm4fN6nUxA84mEw7kD0n
	e2+eee9r3nMtGjmGc/6+JM6BCPJoPFdvZk66u0cHpQbOxVGBMGAXAT83Hqw58oEb
	YDA2xiRBykzQWgWHKBFytpcJAFkThAJENE7M16lhXQquRfdie80X04Ef3gqHpWoX
	oww+b2zec08FAl/jNUBUupr0mMf5gCkZuMq6lwVAVftEr+hmL1TaY5AR/2ZpPxc/
	esBlgcvmT78NIdl+3tg2yg2iUNK1YN+Z2QYICbS0DCnPUlJtDVIeHQpIX0M2WFBk
	OwqcHjrT+AuB6ZRnr/tlg==
X-ME-Sender: <xms:KZGpaf1L0edurbqueXfM-2lVV2NYFlBlLQ7rbagiJf6v0dYK_6Tk8A>
    <xme:KZGpaVFpzZQrUHeggTdPvY5Mw4ARkzxeIb3Gcd7xRud9HM_PNGHmizsLvhU4kU-W-
    S0MqDl0Ruv7yoj4_kssjJDkP9o3PzysAUhNgKzyEU5QUvPUK4ErmQ>
X-ME-Received: <xmr:KZGpaU6rqqrKAmK-9DvH4GUXOrC5XLULf5ZkXTPy0mGDruPyB2-I1X4gWlYd8G7_umgZUD9VXUpA7A8A2gotfcDF5rOohuablx_byCdimjj9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KZGpaTsSm2mDAsrJhyKAEMYNvVOi87AeCREIK3wS3HyjefiXJ3k_xQ>
    <xmx:KZGpad76DO9Qjb6Z5M_EndANFRFAX3lpKyPRVehuYDU1Hh6or9Qt7A>
    <xmx:KZGpaWWSKIlrVMAtRcnlX18q7dKXMor3KDrAYsWwQSEf6OIxcanMiA>
    <xmx:KZGpaX8m1OzqAimHhqRw5D4Opgqyvg9IutlZNgRLDID5D5a5mwJ9Hw>
    <xmx:KZGpaQa_CW3GAfOxQmjyepT-0Qlx4phsC3UsQ3q1S5YjqYtXymXD_hCX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dea833c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:54 +0100
Subject: [PATCH v2 14/17] odb/source: make `write_object_stream()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-14-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              |  2 +-
 odb/source-files.c |  9 +++++++++
 odb/source.h       | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index 5eb60063dc..f439de9db2 100644
--- a/odb.c
+++ b/odb.c
@@ -1013,7 +1013,7 @@ int odb_write_object_stream(struct object_database *odb,
 			    struct odb_write_stream *stream, size_t len,
 			    struct object_id *oid)
 {
-	return odb_source_loose_write_stream(odb->sources, stream, len, oid);
+	return odb_source_write_object_stream(odb->sources, stream, len, oid);
 }
 
 struct object_database *odb_new(struct repository *repo,
diff --git a/odb/source-files.c b/odb/source-files.c
index 67c2aff659..b8844f11b7 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -109,6 +109,14 @@ static int odb_source_files_write_object(struct odb_source *source,
 					     oid, compat_oid, flags);
 }
 
+static int odb_source_files_write_object_stream(struct odb_source *source,
+						struct odb_write_stream *stream,
+						size_t len,
+						struct object_id *oid)
+{
+	return odb_source_loose_write_stream(source, stream, len, oid);
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -128,6 +136,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.for_each_object = odb_source_files_for_each_object;
 	files->base.freshen_object = odb_source_files_freshen_object;
 	files->base.write_object = odb_source_files_write_object;
+	files->base.write_object_stream = odb_source_files_write_object_stream;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index c959e962f6..6c8bec1912 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -53,6 +53,7 @@ enum object_info_flags {
 struct object_id;
 struct object_info;
 struct odb_read_stream;
+struct odb_write_stream;
 
 /*
  * A callback function that can be used to iterate through objects. If given,
@@ -218,6 +219,18 @@ struct odb_source {
 			    struct object_id *oid,
 			    struct object_id *compat_oid,
 			    unsigned flags);
+
+	/*
+	 * This callback is expected to persist the given object stream into
+	 * the object source.
+	 *
+	 * The resulting object ID shall be written into the out pointer. The
+	 * callback is expected to return 0 on success, a negative error code
+	 * otherwise.
+	 */
+	int (*write_object_stream)(struct odb_source *source,
+				   struct odb_write_stream *stream, size_t len,
+				   struct object_id *oid);
 };
 
 /*
@@ -356,4 +369,19 @@ static inline int odb_source_write_object(struct odb_source *source,
 				    compat_oid, flags);
 }
 
+/*
+ * Write an object into the object database source via a stream. The overall
+ * length of the object must be known in advance.
+ *
+ * Return 0 on success, a negative error code otherwise. Populates the given
+ * out pointer for the object ID.
+ */
+static inline int odb_source_write_object_stream(struct odb_source *source,
+						 struct odb_write_stream *stream,
+						 size_t len,
+						 struct object_id *oid)
+{
+	return source->write_object_stream(source, stream, len, oid);
+}
+
 #endif

-- 
2.53.0.797.g7842e34a66.dirty

