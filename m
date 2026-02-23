Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68B30DEDE
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863527; cv=none; b=jyrDHZd6fNbhs7gdivl28T9NhknEK/sG/J5AHK+hczfFztC/eQ+EVbimeW3rzF4A4ZZkLA8gxvhulWEmUJFyOSM3lEBxTuq+PE/LceFGXtPKNt0YyIUDXpPr+GQIy+NXEfJOKBksq1Ri/g/rrygGbsACxptVpE42EfT9SsG/SFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863527; c=relaxed/simple;
	bh=lXHUwL4HVN1Ho02Ip1zUDapMdamB8xP5jMlbIE78lVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0J6lWJeve6QILcHgtCfQGkKJC3YDsLwrFlBQ2+c9uq5XScS8PQ9EPpXaeSwfSCxpmOBLYjUQZcQPaH6mhZnAWJhbqkgd+cUHf1vKRsrZ8OpsEwcEdh6ZygzAMn9kBndCSIWrymj8VdoOd6qpdC5v6VL6w9ZHsK0CY7nF4JvRq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ngw05wTX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dYuPUt3s; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ngw05wTX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dYuPUt3s"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3296F14001EA
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 23 Feb 2026 11:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863521;
	 x=1771949921; bh=CMBn3nhWuPSV/gwVSHv6Efj2r6IzQe9LJEZgW6Z34L4=; b=
	Ngw05wTX7zWTKUvLG7335JCAOL5f6/rYnqdi29WD8n5ZeCuIVhj0CP7B8Ph3vA9h
	zzXqIBKUAkQskdYVq81+TrirGW8zxYh98JMCIiHWtI1YW5ZRUcdoXqbBP/3n9jyk
	DKme3xOKKOVJJXKxc9WhZvtNDMIEB7thW8g4kxvV8Jen+dwyieQsRQ0qlKH/TzIC
	4DefOsdmQTIC2c6JA+TWSZ5hYmJ0kSIoY0cojm8uMN8MYO+OxzpOaTaB6mgGoXon
	pbsEKzhW4KBg/OREaBqo/D/cqm8Eb0j0Pm7rmPvubuDcMDZiQgjzY5dMVMbA50mI
	v8wiFl5el3qdfURaNXyBNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863521; x=
	1771949921; bh=CMBn3nhWuPSV/gwVSHv6Efj2r6IzQe9LJEZgW6Z34L4=; b=d
	YuPUt3sNQH6tIGa54TVRTqLfM/zhULvhNDFbi3MWfDDs9eqAUmXl6qYvLaicHha4
	P66p8IlaJRX96F3Kji5sgifm0zik8Y5Sb5wqQYeGd8+IoHUApvmbipdXxM01oKRR
	XRgT88r19xRH6dEhs2qHC1dJhfI1LteGOCi2cdOfP7Dld8BTkFwFaCo2cGvnX2Xw
	Y9/5hlascRsxwtO0mCE3fmHvY+q1HaJZjUgL5lNQsYlYCkxNkUuz8a/1N3mWzzou
	sL4ZZzsghX5nE3EXFmRmLTIS9anO/OdJOxN82sa7XtH9ObB8Da8nfutDvNmN7BSw
	XvL90pbJ9wO815GgKxVZA==
X-ME-Sender: <xms:4X2caWxK8IXnWMgPAmXoAbQdOzV6sBXM28Tm960l8Mu716IK2GXwMw>
    <xme:4X2caZPMXNQkWgDXMrkmaVcbozpmm765PrwZSoCR_jdNGbJ7nAx16zm5Fri-9W0Qo
    BfVdMbqmW_3QEDdLqjvZt9aovJW1MUQ0PNlXaLkB5DAMuayE_ghEsU>
X-ME-Received: <xmr:4X2cad-X9VgksSBWh4HHf2F2W1wJ3J7Ha_GKNltYfDkvvRPLRsO0-z_6-fPzK9f6kqV2x8OZ_czbB6LJ92hFJNzM89eZ4Cc3ToHuF7HUSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:4X2caRqFDVPk77_lb50_qGH_XExB7FP3VaNxna-EhbT7M92rlVk1zw>
    <xmx:4X2caX79c2P5Takh9sU32ZtosFOFRDjj3OOVLHEGlzWrpiN2CS44hg>
    <xmx:4X2caZMP9UMtO0Aternmo_mNFBxw5--aoNnAzk2iyaFCzcAmThZAZQ>
    <xmx:4X2caRO92P_fHoiEfCpzI9OGiZa2Ra3cFUAO6pscr9kGv-QeW7Gg_A>
    <xmx:4X2caQxPNaMaDr746KzAeICFGcpovkx75__hlXnt5dO1zEZMD52aE_nW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf8a9d35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:03 +0100
Subject: [PATCH 12/17] odb/source: make `freshen_object()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-12-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 12 ++----------
 odb/source-files.c | 11 +++++++++++
 odb/source.h       | 23 +++++++++++++++++++++++
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/odb.c b/odb.c
index 494a3273cf..c9f42c5afd 100644
--- a/odb.c
+++ b/odb.c
@@ -959,18 +959,10 @@ int odb_freshen_object(struct object_database *odb,
 		       const struct object_id *oid)
 {
 	struct odb_source *source;
-
 	odb_prepare_alternates(odb);
-	for (source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		if (packfile_store_freshen_object(files->packed, oid))
+	for (source = odb->sources; source; source = source->next)
+		if (odb_source_freshen_object(source, oid))
 			return 1;
-
-		if (odb_source_loose_freshen_object(source, oid))
-			return 1;
-	}
-
 	return 0;
 }
 
diff --git a/odb/source-files.c b/odb/source-files.c
index d8ef1d8237..a6447909e0 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -88,6 +88,16 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_files_freshen_object(struct odb_source *source,
+					   const struct object_id *oid)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	if (packfile_store_freshen_object(files->packed, oid) ||
+	    odb_source_loose_freshen_object(source, oid))
+		return 1;
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -105,6 +115,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
+	files->base.freshen_object = odb_source_files_freshen_object;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 35aa78e140..9324fce2ba 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -184,6 +184,18 @@ struct odb_source {
 			       odb_for_each_object_cb cb,
 			       void *cb_data,
 			       unsigned flags);
+
+	/*
+	 * This callback is expected to freshen the given object so that its
+	 * last access time is set to the current time. This is used to ensure
+	 * that objects that are recent will not get garbage collected even if
+	 * they were unreachable.
+	 *
+	 * Returns 0 in case the object does not exist, 1 in case the object
+	 * has been freshened.
+	 */
+	int (*freshen_object)(struct odb_source *source,
+			      const struct object_id *oid);
 };
 
 /*
@@ -292,4 +304,15 @@ static inline int odb_source_for_each_object(struct odb_source *source,
 	return source->for_each_object(source, request, cb, cb_data, flags);
 }
 
+/*
+ * Freshen an object in the object database by updating its timestamp.
+ * Returns 1 in case the object has been freshened, 0 in case the object does
+ * not exist.
+ */
+static inline int odb_source_freshen_object(struct odb_source *source,
+					    const struct object_id *oid)
+{
+	return source->freshen_object(source, oid);
+}
+
 #endif

-- 
2.53.0.536.g309c995771.dirty

