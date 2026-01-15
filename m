Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016D374196
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475106; cv=none; b=ergzC9NZdTAzPULBZBMxCJw7L1BvkfXIut5ePYSuVVo7sMneaY3amvbE+o8lwXu5A2p3qbfx2S7Z3+6tAXjGlY/PWXNt7AKw6TqusbIBBJeof1iSYJkl7q+UZBdbQbc1WI1WfVokhslnIyfAM6su7hC3jOlxpp+w9tmaXvPAhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475106; c=relaxed/simple;
	bh=hwVaIOuc/gJ39tajReLsc66fOLZ2FHi2jIX2KTPDb1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9B8kdf3JNv60T0AaV0oSDuMz0b0FZmA/T/y8xPOfqoguEmm1FUaVwI/u04R0s/u+1Fz0QoQyG6JreU44VJ/JMKk37k4xUpOSFx/KMr5NwjfqdRama7JfUl/dpBwgdqAknLPaq9M/iZXOtYL3TSdL7yhokWDg2sbkWHG3uOUz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R+2t3tDy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=owTHSdm1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R+2t3tDy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owTHSdm1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 180451D000E0
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Jan 2026 06:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475103;
	 x=1768561503; bh=N3sVE7K2iZG2DySf5LAlNMmgPF5FweswKgkX7cjBimY=; b=
	R+2t3tDy6d2MAraGv0FueSn48i78GBNcTmoU8o1g4nQJedpzVfgJCoLpwl0cC2CU
	9uGDtOd2CZ19rCi6oMF8Y2qf/nS5Ul7m+Koukbt0LdMs6qeDN9WkbybwHEZ0l6K6
	LCj6CvI4VqH8Ey4pkhvnqN9i7nCEOfm7o6Deac7salO3TS3857rje7oemdYtfalr
	vHsiAIcMEixjtbXAD7V9I9HTYUR6t3enKYEu7bPy9snrum/wLnWSLuBVaOP6Lqh6
	sAM2DTxzAgHYx7rKfGYKLLY+8NdMUFOjORFhkG7PX94tZcISlC1qzEcuP4XQuN2s
	hUwlGqZ/gkXvkK8cV9NX7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475103; x=
	1768561503; bh=N3sVE7K2iZG2DySf5LAlNMmgPF5FweswKgkX7cjBimY=; b=o
	wTHSdm1XXpM4LebxYAwwnX7l1ffAgVJIJ2EYxWQxndd8PMC56RJR0aMGhU27Q0pi
	w0XJ03DRBV/Jkx04qBlQjGwlOkK6rK6zhJVMp8RqfaKwVqiB6YDdtkpyxtnZ/Gos
	X9EslTywu1GwhTi751N0FlHuriPypo6DtOi4xjZbXRbFEZ7Ba0v0owPcktRVtZxu
	bSYG0BXzB3D8LcTZNMVHyylZOza3jOLGNMa/IO0cZPLnlP/sDgtpldhOu4gJ1OWE
	p7442/NSt6aQLPlhqQtZrBF2xkYL0Mx2fQHwwDjZsjNoSq0bN4CncJrSPlL7uQw3
	+mKuyfDFkwb4yu9tucIew==
X-ME-Sender: <xms:38loaQ9a0g-rTv2M1yiT9TVVF5P_LhTK9TfczjDYxeYNt5OzcgEu9Q>
    <xme:38loafrm7Wdtest8jmSsI0ohNMcqdrLHmFLZWFD7PFK6I57Cp6-k_0ezhBEgTNBJ_
    fMXFv765gRcz89dj5ii9VPETdCWJUiR2KA3RmQtqHPtE_5Eg6HZmy0>
X-ME-Received: <xmr:38loabpfajRwEvcEDqT4PrpivWZV70dwYI0dznsKw1wiDetJouzDveJlSKQI0-a26XtZni0q8xF8sabDmuGj718QvQ3tycgioa4D_N_Ojs8vxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:38loaVlfOdd2E-3A-RtlzRYMyLt590dsOS1ha4TFkB1h53clq3ez4Q>
    <xmx:38loaVGESORqVffMfrQcpFXXB_oz652EcrdWmu3q3y2xeArGskNwcA>
    <xmx:38loaWoJGFTVKY-Z9j59an63aajoUaQsrqkipFpCXBjT7528Qt1rLg>
    <xmx:38loaZ5HaA-CxvYZQzC69d223iKcFwC1KqMvN4hzDgevCbP8BVAsIw>
    <xmx:38loaQs3mA74hcKLLcKOtMScc2aTQMOHE1c3saX0C3bmNSRfj1RTt2Oo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3466707f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:32 +0100
Subject: [PATCH 03/14] object-file: extract function to read object info
 from path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-3-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Extract a new function that allows us to read object info for a specific
loose object via a user-supplied path. This function will be used in a
subsequent commit.

Note that this also allows us to drop `stat_loose_object()`, which is
a simple wrapper around `odb_loose_path()` plus lstat(3p).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8fa461dd59..a651129426 100644
--- a/object-file.c
+++ b/object-file.c
@@ -165,30 +165,13 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 }
 
 /*
- * Find "oid" as a loose object in given source.
- * Returns 0 on success, negative on failure.
+ * Find "oid" as a loose object in given source, open the object and return its
+ * file descriptor. Returns the file descriptor on success, negative on failure.
  *
  * The "path" out-parameter will give the path of the object we found (if any).
  * Note that it may point to static storage and is only valid until another
  * call to stat_loose_object().
  */
-static int stat_loose_object(struct odb_source_loose *loose,
-			     const struct object_id *oid,
-			     struct stat *st, const char **path)
-{
-	static struct strbuf buf = STRBUF_INIT;
-
-	*path = odb_loose_path(loose->source, &buf, oid);
-	if (!lstat(*path, st))
-		return 0;
-
-	return -1;
-}
-
-/*
- * Like stat_loose_object(), but actually open the object and return the
- * descriptor. See the caveats on the "path" parameter above.
- */
 static int open_loose_object(struct odb_source_loose *loose,
 			     const struct object_id *oid, const char **path)
 {
@@ -412,7 +395,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-int odb_source_loose_read_object_info(struct odb_source *source,
+static int read_object_info_from_path(struct odb_source *source,
+				      const char *path,
 				      const struct object_id *oid,
 				      struct object_info *oi,
 				      unsigned flags)
@@ -420,7 +404,6 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	int ret;
 	int fd;
 	unsigned long mapsize;
-	const char *path;
 	void *map = NULL;
 	git_zstream stream, *stream_to_end = NULL;
 	char hdr[MAX_HEADER_LEN];
@@ -443,7 +426,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 			goto out;
 		}
 
-		if (stat_loose_object(source->loose, oid, &st, &path) < 0) {
+		if (lstat(path, &st) < 0) {
 			ret = -1;
 			goto out;
 		}
@@ -455,7 +438,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 		goto out;
 	}
 
-	fd = open_loose_object(source->loose, oid, &path);
+	fd = git_open(path);
 	if (fd < 0) {
 		if (errno != ENOENT)
 			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
@@ -534,6 +517,16 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	return ret;
 }
 
+int odb_source_loose_read_object_info(struct odb_source *source,
+				      const struct object_id *oid,
+				      struct object_info *oi,
+				      unsigned flags)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	odb_loose_path(source, &buf, oid);
+	return read_object_info_from_path(source, buf.buf, oid, oi, flags);
+}
+
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,

-- 
2.52.0.660.gd05f3a8ea5.dirty

