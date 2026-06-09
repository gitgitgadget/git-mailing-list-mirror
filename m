Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70573EE1E4
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995084; cv=none; b=Xw3lNxBDOCcAbTXflB4gbQ5dpiO8x+wO4UTqhxAITeTZvmawNYYrs1MhUsJX9jaaxQKc5tF02PgtxayEZemzpRJ9GYwM61jeBy1R/nQ/8ffEk242oHi9mUeTWi4Zqc/cR+qJekZ7/FHGvGrIVFaKTboMMdbsf6Yyqy+16szoygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995084; c=relaxed/simple;
	bh=YWJVkJNlafq3HKWPcMtjsh8i3EUH+6zu9k0LGBLmmCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGKJsSoL6jdTAT2WpvNs7nn0QJu64NdMt/JBiAQqHZWhLiXFajHGQ+bEnPEzpzseCjDFITRXXI+UUWkYBK8ZXv2XRAw4W7Fxt+wzoI1e392vhtsHqzhIhukSsS5gCdedeZxvUBwRwumtLvKSr/3Rk7srW2RD6kqKiAN+vrfkCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sU+UshaD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWUxnU5S; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sU+UshaD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWUxnU5S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F409B1D00189;
	Tue,  9 Jun 2026 04:51:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Jun 2026 04:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995082;
	 x=1781081482; bh=/z5z90VJF1NzEXr7eQX/Pxk1LBMAtiEnpxoPikdvBbc=; b=
	sU+UshaDaagZQNA6yzNXWeU+9W64D+jPHleLUI68Y/0pDtdfLRn+XP49cBbu/uJx
	vU/t8vi3tiCSFZTu0erGyELpE1Cilm6o71DiC6YYg2Et8usM7ef33xiz/394aEdj
	WtXYDCyG6TcK7tEzMtJ1s5YsI7kGd/vNpuEBv8cgAgY3ZDy+ktYt5ozKKisPOx3i
	D0aqIXjE+9ZXwmPmR4L6R/tnBIp94v2HyEUFK1tm414flHjxpbK+B+fDX/ARnSXt
	N0OXJqNtmDUc4eCLO2Mm19uZe83xBipLAw/kbWVVI1OUP2diduPRAqvhxBMRYh5t
	G23WZ3n5rn6jgj38sgQW/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995082; x=
	1781081482; bh=/z5z90VJF1NzEXr7eQX/Pxk1LBMAtiEnpxoPikdvBbc=; b=a
	WUxnU5Sq0CKmfVQ3JwGKipDQQtwlaESoucUPhARZQ3kGZ/Gnw7EQoGOvrOdvJRT4
	ByBwotZK5tRbxSE4Dt3jN6CMWSfhcQRO4M1Ej5Pfrn+wqd6sOmRAqJLVagfoz1+O
	kddf45PiZ8ApDIUntsGCwE6YUNuHmSZ+9ARCkdDcfVIfCKszjFy+vGhsM86/L2bL
	n59ifXRMZW1OtI7cqqKOXunhrrl7KR0GkOMMKyIY+LZ0m/zBzaMxnwurrFWvVeYa
	zLOnuCcVWDuQw6GMj0FgQ1K4W5chz/y8Er8p3GegM6YPuHAViSV3qUP5hqx10/Nn
	T0gAHRN6xKspZ9x5suInA==
X-ME-Sender: <xms:CtQnanxwK6nDQUKtimEkNhzto3DJ8tkpHmtuoTvV7xAGn2DUZlXXzQ>
    <xme:CtQnalTscSHE2bCBWxZo0hEdz6ushtHbTvavT1Ih1vOZRtBclYCUWBtJIZjEaiaTM
    DMV8Z5Fb7ZJoG7W1OX-1wwfPM0V-5E-Pj7UdHDjeMMQ2cfdYWu0X5I>
X-ME-Received: <xmr:CtQnau8NjoGi9karqf2vHQUxd2zz8Rl7PxefmopszntJykyv1TLgHct0nb7MSmCQwfAYnp4H0rOQC9BhZZBD5CdULHYA9V1JZnEOQ5lMMvk>
X-ME-Proxy-Cause: dmFkZTFScmXmBNtXOl4rqVqM8DAc19fyHinqrfJGsNjV/CE2oHckwvnGyvDfLnNUuwKybL
    TXXNE7zDSLzm9sqK7QnFjZefXQ77hB0yUpUORZINqHtbw80x5HeASQHzHrphN1o87wLUDo
    o+b2Dx90Cc3HLmwbZsks1v5Qe3wgVjPUMwX4Epw71mRv/T8ItHrE8RkWZrv81HY9CRlc3Z
    /OiNXFOpQwrN765XqADbyILD80acXbo1GJdpcquKP94bmw57TBOmknCC1tOk25qwSfgaav
    egwmPIOD8ZPaE7+A6cnzDiyYUxaYdFHC73rr/JrclTuz03BNq0lnxnglgQ3GRx5+ugY1Vo
    sWlluQacoBJNLH7u9ju5vbeRdXSK4PR2bTWgdHtlhB/+PwYw85cS+XC4DiBN14DJ0/fiDv
    WzCNICXcjcpovKehGQ5mZHTW25Lqn9+TTrhscgyalNn3khGS/5Mhg6Z9a3P/MKs2SHZABq
    Tt/BKCv5Ln7r89Ki6v6YIm1XYS1UccU0+6ZrzP82XnCs1+Wh6DqL1k/CQ0JBTFiy55f/ji
    d+RvSVVRvdOWR0WY8ZKlkATP21qlIsmFNMsawjcbknNtSN2Ick4Wa+TKw8Dt6772t2Mv7w
    IgpJA3FbgMxNR6bMiv3aooRV5VfThzbt5LCcaz1Zzwjrj7jwGB7n9nsixCMw
X-ME-Proxy: <xmx:CtQnasrxLgxRb4AolnLAucZHtABp79HJFaHXTJg44UYb8GbGCB-R4w>
    <xmx:CtQnarnsNln9putBKbZ3-IPIdWIxjFS320jSnXvBPfiX1BQRmPJecg>
    <xmx:CtQnajLsNJtlVaAeLUovBcV3nsQg7YgCbQSJxaygG7P1KYfonl2Vjg>
    <xmx:CtQnagwwapevuw2WJM0LiZdHWfXcWV9qsnC5DSN7tf_qXffYeXgTMQ>
    <xmx:CtQnajgThPdpwx6Kt0Ns0Q6U67zGuauc1AgG8-1WPZTXJw1NrpMWGR0i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9c8f5f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:50:59 +0200
Subject: [PATCH v2 06/17] odb/source-packed: wire up `close()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-6-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Wire up a new `close()` callback for the packed source and call it from
the "files" source via the generic `odb_source_close()` interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 16 ++++++++++++++++
 packfile.c          | 12 ------------
 packfile.h          |  6 ------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 3608808e7c..9b0fa9ccdc 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -38,7 +38,7 @@ static void odb_source_files_close(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	odb_source_close(&files->loose->base);
-	packfile_store_close(files->packed);
+	odb_source_close(&files->packed->base);
 }
 
 static void odb_source_files_reprepare(struct odb_source *source)
diff --git a/odb/source-packed.c b/odb/source-packed.c
index f81a990cbd..74805be1dd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
+#include "midx.h"
 #include "odb/source-packed.h"
 #include "packfile.h"
 
@@ -16,6 +17,20 @@ static void odb_source_packed_reparent(const char *name UNUSED,
 	packed->base.path = path;
 }
 
+static void odb_source_packed_close(struct odb_source *source)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+
+	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next) {
+		if (e->pack->do_not_close)
+			BUG("want to close pack marked 'do-not-close'");
+		close_pack(e->pack);
+	}
+	if (packed->midx)
+		close_midx(packed->midx);
+	packed->midx = NULL;
+}
+
 static void odb_source_packed_free(struct odb_source *source)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
@@ -42,6 +57,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	strmap_init(&packed->packs_by_path);
 
 	packed->base.free = odb_source_packed_free;
+	packed->base.close = odb_source_packed_close;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index 6d492216de..e5386145a7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2749,18 +2749,6 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-void packfile_store_close(struct odb_source_packed *store)
-{
-	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
-		if (e->pack->do_not_close)
-			BUG("want to close pack marked 'do-not-close'");
-		close_pack(e->pack);
-	}
-	if (store->midx)
-		close_midx(store->midx);
-	store->midx = NULL;
-}
-
 struct odb_packed_read_stream {
 	struct odb_read_stream base;
 	struct packed_git *pack;
diff --git a/packfile.h b/packfile.h
index e8bc9349f8..9dc3a13112 100644
--- a/packfile.h
+++ b/packfile.h
@@ -55,12 +55,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-/*
- * Close all packfiles associated with this store. The packfiles won't be
- * free'd, so they can be re-opened at a later point in time.
- */
-void packfile_store_close(struct odb_source_packed *store);
-
 /*
  * Prepare the packfile store by loading packfiles and multi-pack indices for
  * all alternates. This becomes a no-op if the store is already prepared.

-- 
2.54.0.1136.gdb2ca164c4.dirty

