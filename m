Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F10389111
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302054; cv=none; b=AX+a0uspebkrXdPe4cC5CyrpkydpOzPM2WO0jHWq3nJFUGXPR1lQinhz68jF3JYNqldCp1DqsJsigGnAsc3yYbe9WYOgBB4I3vgu3UG7DUtOOpNjIWLL+eRLQl/flye6sGkmMqmlNQmX2+KXpwB9JsdcY2LsneZZJHb5HfZ77DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302054; c=relaxed/simple;
	bh=ngKK3c9LuRAFSYOf99HrzIqf9G7z/ag/AFZhHz7+7Q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfXbpEkt7+RmwEO5NUvnd0I67/Z3WdGyNn/hYQJSiK76oIxFRTujTtGAe08FOspNLEeDlginYWczfAT2ZiNbzHR9pl6jTBJVE6KUz4vdxQhQ4NbP8RgvQXwjzNxQ+CLLYq0p3q/JKjCtKtGMKrpfn/ZhA3pAE0lSULnJHVs1G7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XNV4Uj69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M0AgOfcf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XNV4Uj69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M0AgOfcf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 494CEEC0090;
	Mon,  1 Jun 2026 04:20:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 04:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302052;
	 x=1780388452; bh=LT2QO7iMdFlyvAnkyfANqLv9F441OUj+rKINvbIcWH4=; b=
	XNV4Uj69rWeFvwKjDWiWh0C5A8l/yv1v3FkivsIe6Nm5TSgU28qiXJp1JnEw8DYF
	aGyXPQwMD+dg8ofgiBtqJkzMpcK3puOyXqmoxoP72lCGqJTfVmZn2XxZZNF6U0bL
	QZAMe4oD/B7vjCcb+BBmyIu3rbk0BRd/j5sOltaYYorRj7c3R1mvwoh3Nu7IRwGZ
	hfSNPhkYZUfwfGPI9tNTWMF+NRDUEYGjZk63m/mS4/TSoCEeacIfCdM7yyo/gSN2
	aF9M8QC+1iEhRpYHGJoQ4lUKJxqAM17VvegTgG9kuegbijMH3yiPhsbX/TPClO4C
	GtniTHmzPS1JjFCagAz7mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302052; x=
	1780388452; bh=LT2QO7iMdFlyvAnkyfANqLv9F441OUj+rKINvbIcWH4=; b=M
	0AgOfcfQ4+V9nlaozzbvszH61fmgRjBr3XKum7HUW9/55X8PgZVKXkPiZ/Yj1SaY
	HY3ApcP/eQhImkIogZ9oXWhexyPztVtMJYjMF69z8BI/zZ1xgu2UFMH8v1SBjIeh
	V6UdtAEyzgCIGICmdC8SdoWRh52musIqEa8r4snrpM68wN8hXSVJaczyPtwQOpyT
	sYWRZEkSUVs+821HPKTOA9AOSooM5ZLur1InZTD7zBbpfPXSldKko08F+OUejxI1
	L8U+ZF5et0VcJnObN/QrOpmUXEJE8FmwMUCkwQkSbo0Bz86skO1w9S0cVO2872Us
	e+MNaIMhVr+BYusBoZ38w==
X-ME-Sender: <xms:5EAdanR68lHm3aiw-ldlW_eAlc5QhbO3vnJTx_a1F1qBTVvVL_fiZQ>
    <xme:5EAdauz6xREIM3GzACnuPlJ_tvMgE5WhySrrvxVjicGjc66UpvwvAQMV5SZhJpihX
    Pm3tEOo12u6FfzpLkSqVTpJXO2aXANPHvln8_oGIwc_l67XOTxWvA>
X-ME-Received: <xmr:5EAdaqfUlJ76809fNBve14WmSzeKMofI6Zn7RttwTP_Skh9lzYLtorSWlblmzmjdDo8UjrQyEk4lnTf6epTR7Ape4655_h9UCkOtIY_Mf16A>
X-ME-Proxy-Cause: dmFkZTGoVC3PWkC/M98GLpgwKSp8+X2EEbK9QrLPRCVzfq6z8mGb2cg1WSKI0P1YF6K99Q
    xKY18KC2TzQ71gWxrLtHBcpqPwInMMILQwQmN+IaQps5jv2t4yhm/OcWnxr3PAuKdie/5H
    xdZiEXHfq3CyGlKpLwv2vL5myW19uyY8AtAnQMD9jV84wJQFe0QGymylYpZQO++m8ND1Hj
    j7fjS2tB+vIBobG7JpZXtzobTDeXEGy6yi7zeMBs162gs+xcsIodAA21pY4HTX/IAVCIU8
    kOLzJFDG9r9Lr/xlbzdlHVCtb2SlM1MPmdQV95SWFIB7kaTFV8arUy82aX0eqGVCnq+EgN
    MztmH5dv6W4ovJo/kEH21eWQcVdPkg32rT9qYcNeWUHiu69sS5MQQgH9jWay/UYD2JxNNz
    Ibbrn7IyAceiAUyYC8jRpyVaj+XFhevpg1sZFX0zYftHxGdihzzvWQQara7bmQBcc3RNaH
    qwEhDhAaaaJrnr8WR8baAfvlMBzAJbGW8+wPcCISZcICeSg0hDlhwWLazlTQRY7hphfr9B
    XBa4+SQoiKWrN9AIF66pswVp2q7otYbfS0rSbsNuK2qVNUraL/4Fs0yZtBcVLka0CNaKUL
    9Y3ulaCR5pyIOczyEi5bDlOnRyN27XOZFAqYDj5Xr9RK9eCyvG7jJbkAUM9Q
X-ME-Proxy: <xmx:5EAdaiLeOkADVt8gkMq73AVXQA4qLg8s2eRnXJI4oydET3dF_cHL2g>
    <xmx:5EAdajGewWnyzhVBqxg2SZsMV6Ee9wWCnHC4zIy4n2ovU7-6O98skQ>
    <xmx:5EAdakpMVOxRSgCw4M6dTHp8Ot8TxnbySpUbcaXvyNwA4bNLPlCDwg>
    <xmx:5EAdakSqO7j4_0pKIQZUISlGi8YZcZAksC7ZnWldFI7xW4880G_Ilg>
    <xmx:5EAdaqrSecivZxci4-5-8I8t_hGjfZ2eQIkRbK-rgv1kzvnnlpidyFU2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 873911a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:32 +0200
Subject: [PATCH v2 09/18] odb/source-loose: wire up `find_abbrev_len()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-9-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

