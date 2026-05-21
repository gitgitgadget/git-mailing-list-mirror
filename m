Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86613A6B6E
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351776; cv=none; b=Y249E13RcHCoE+U/J1mtZ4AJ2fzJ7WL5k83DDA1/PcHNotm089x1dxeIRwfqc7TK941dHoyAaue5XPaNCft7tZ7QyMAdt2jcDWWiqq0bQBe7cEh7Web04C/9B1PWCGsnccOx2br/b2cdrzqRsG1kx7JOoveC/GLrtqtpU+aeRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351776; c=relaxed/simple;
	bh=ngKK3c9LuRAFSYOf99HrzIqf9G7z/ag/AFZhHz7+7Q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qlOB46XWMFnTZjBAdFJqFWvsnBH1QbXKQDf5wcKZkUAbjVR5gdhtzfmer+6WtYDkySsn7kIloIg6xwYzNCnzyY1dNTSJOy5U+t6hBLZ4GpVkDTgtECRIGVpew1UqO62wYZn/cmvRs9UzOan6/Cjpzjv90aDtMeD7AebYKFBfGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eAFVlXeX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gdlVjQC6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eAFVlXeX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdlVjQC6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB3641400081
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 04:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351773;
	 x=1779438173; bh=LT2QO7iMdFlyvAnkyfANqLv9F441OUj+rKINvbIcWH4=; b=
	eAFVlXeXnwObDa3NpZ57elfwIcjvMNSqoho0UluuEEdqPybhTEKeW5cTKQ8CU8tP
	PmOKv2khk5oqIIF80DC8UDdBo/o84bg0UQ0zM+Q6lJjXk08I/Wo4sCc7dTcTII5F
	c22mYunoTtTi9PS+wSkmtPeJeQ264juEmfRu558lR4wfVi07d6tfqUwUce0X6TUk
	f7s8S/ysMgfoxzqQcvtocSMjV7HKh8sBDb9s1qAOG/Prs34nsWAR0z0gQDmRZ5Qq
	aXbTWYtl922RBwYq5DU/pjCDrd6weVQvROEsqx32IKwbazTJDn91bY9aNPWgPdW3
	ECCDfgGFMZP/5e8bHARzJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351773; x=
	1779438173; bh=LT2QO7iMdFlyvAnkyfANqLv9F441OUj+rKINvbIcWH4=; b=g
	dlVjQC6ggZmAk6kg+CBqHbaOxQYRIgmCRGqo2ztmTx0YjOVPqd4cu4qO8K3rD0OL
	RuYE76E13JqsVVHv1zv3fZCum3WqtjrBkYcpOersAvYWQUjbzqGt0yqH389Ih8mm
	dSDUT1i4oBtr93+oOV+3GIbhhgZQcYDmQxqZR+JQUyGoUGJO3hlJLZ2RDOTdXCrV
	TNt13FjTeenPnIo8EEzIUiLzgxsXxy+kmXKCa1vLXaSyMaBXQfUoGtxz5pmEpUJs
	VK3qdGIOWkjJj5pspqKCbY+VjGkau74ke9BPuaQ8YwE7clYu2YkNCZtGQ1YG+QVA
	zCdVtUu5sqvisIjevVI3A==
X-ME-Sender: <xms:3cAOajbjLrx6T97ExcwUko8SSzIcMXBeb_EAUnvjWQpJx0WQB281NA>
    <xme:3cAOapVWgTC4LBl2qc8h7vFWiGYhKXD0gRHDrNND5b6lvKV6fzW2JVypFTv1lE23R
    hJqBocpyCyoWAn5ujJ6EIu37tjvJqkM4Bf3oKErsNcuQ_BEZVi8xA>
X-ME-Received: <xmr:3cAOarkmWl52i61tTuJ5j2wmo0Io0BwNRwdsHjEAahCdyqMl4RMxuiXQHCDnkPwjU6PCH52_01WBwv-m_eLdJlmBNYdQ7R3asD0E_esNcQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:3cAOauwzLrR5locbfSeluB-QMW65nRbBiqMr2sbNE5X9uo89eZrsXQ>
    <xmx:3cAOaugYB2EzE2fgqFl_78l2aUCnetXirb192DAxPZ-Ir_mhVp7F6Q>
    <xmx:3cAOarX38JevT2SS_yVYEro3doAd6bhms6b-sZuQJZ3sSUk2NHSPrw>
    <xmx:3cAOao0fAZCQjGRYinZtAVPMN-qo61GQhwAIW1CDxTilDuLqNW_Dog>
    <xmx:3cAOal5WB4W5B0HdcDMuHS7KLrIEbhGUTm94KloXdVFZYHt35v6DrkUp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a318beb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:29 +0200
Subject: [PATCH 09/18] odb/source-loose: wire up `find_abbrev_len()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-9-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `odb_source_loose_find_abbrev_len()` and its associated helpers
from "object-file.c" into "odb/source-loose.c" and wire it up as the
`find_abbrev_len` callback of the loose source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 39 ---------------------------------------
 object-file.h      | 12 ------------
 odb/source-files.c |  2 +-
 odb/source-loose.c | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/object-file.c b/object-file.c
index 157ecad3ea..11957aa44f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1662,45 +1662,6 @@ int odb_source_loose_count_objects(struct odb_source *source,
 	return ret;
 }
 
-struct find_abbrev_len_data {
-	const struct object_id *oid;
-	unsigned len;
-};
-
-static int find_abbrev_len_cb(const struct object_id *oid,
-			      struct object_info *oi UNUSED,
-			      void *cb_data)
-{
-	struct find_abbrev_len_data *data = cb_data;
-	unsigned len = oid_common_prefix_hexlen(oid, data->oid);
-	if (len != hash_algos[oid->algo].hexsz && len >= data->len)
-		data->len = len + 1;
-	return 0;
-}
-
-int odb_source_loose_find_abbrev_len(struct odb_source *source,
-				     const struct object_id *oid,
-				     unsigned min_len,
-				     unsigned *out)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	struct odb_for_each_object_options opts = {
-		.prefix = oid,
-		.prefix_hex_len = min_len,
-	};
-	struct find_abbrev_len_data data = {
-		.oid = oid,
-		.len = min_len,
-	};
-	int ret;
-
-	ret = odb_source_for_each_object(&files->loose->base, NULL, find_abbrev_len_cb,
-					 &data, &opts);
-	*out = data.len;
-
-	return ret;
-}
-
 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
 			    unsigned long size,
diff --git a/object-file.h b/object-file.h
index 9ee5649220..96760db0e1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -110,18 +110,6 @@ int odb_source_loose_count_objects(struct odb_source *source,
 				   enum odb_count_objects_flags flags,
 				   unsigned long *out);
 
-/*
- * Find the shortest unique prefix for the given object ID, where `min_len` is
- * the minimum length that the prefix should have.
- *
- * Returns 0 on success, in which case the computed length will be written to
- * `out`. Otherwise, a negative error code is returned.
- */
-int odb_source_loose_find_abbrev_len(struct odb_source *source,
-				     const struct object_id *oid,
-				     unsigned min_len,
-				     unsigned *out);
-
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
  * writes the initial "<type> <obj-len>" part of the loose object
diff --git a/odb/source-files.c b/odb/source-files.c
index 676a641739..4a54b10e4a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -136,7 +136,7 @@ static int odb_source_files_find_abbrev_len(struct odb_source *source,
 	if (ret < 0)
 		goto out;
 
-	ret = odb_source_loose_find_abbrev_len(source, oid, len, &len);
+	ret = odb_source_find_abbrev_len(&files->loose->base, oid, len, &len);
 	if (ret < 0)
 		goto out;
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 4e8b923498..4b8d10bc87 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -481,6 +481,45 @@ static int odb_source_loose_for_each_object(struct odb_source *source,
 					     NULL, NULL, &data);
 }
 
+struct find_abbrev_len_data {
+	const struct object_id *oid;
+	unsigned len;
+};
+
+static int find_abbrev_len_cb(const struct object_id *oid,
+			      struct object_info *oi UNUSED,
+			      void *cb_data)
+{
+	struct find_abbrev_len_data *data = cb_data;
+	unsigned len = oid_common_prefix_hexlen(oid, data->oid);
+	if (len != hash_algos[oid->algo].hexsz && len >= data->len)
+		data->len = len + 1;
+	return 0;
+}
+
+static int odb_source_loose_find_abbrev_len(struct odb_source *source,
+					    const struct object_id *oid,
+					    unsigned min_len,
+					    unsigned *out)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	struct odb_for_each_object_options opts = {
+		.prefix = oid,
+		.prefix_hex_len = min_len,
+	};
+	struct find_abbrev_len_data data = {
+		.oid = oid,
+		.len = min_len,
+	};
+	int ret;
+
+	ret = odb_source_for_each_object(&loose->base, NULL, find_abbrev_len_cb,
+					 &data, &opts);
+	*out = data.len;
+
+	return ret;
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -537,6 +576,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.read_object_info = odb_source_loose_read_object_info;
 	loose->base.read_object_stream = odb_source_loose_read_object_stream;
 	loose->base.for_each_object = odb_source_loose_for_each_object;
+	loose->base.find_abbrev_len = odb_source_loose_find_abbrev_len;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

