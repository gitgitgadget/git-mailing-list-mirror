Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340CD4218B8
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572364; cv=none; b=q957hKqLf3Sixjb71bTC/8s5qB7a4bYi94gIAqFmervyvRJaZ7dCNLSW+kg2LBXznRrN/BubEDxGY9ioUFPPJif8CIh9CYX15pJqqkRAnjXh3d8aJ7RPbB5e5jV6kxUkBi3fHr+1fkH9IR/C1Jz99ifhjrX+vGc3/rOzDyw/jJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572364; c=relaxed/simple;
	bh=tyWsWFW4UB5zNZAzRKeEcCZMVw6avpe49dcwQTtAd9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VvMYvtRqAPEH1eLtYeUm6fqp+/aB0n5Tcehv3CXh+R87rvvfqXOlS5vwrCLZfRNEzacj4Syqm3R287/dVRyO5jIh1MNLlYSblkwqKtOA6V2g8M29nkBJiDqMZlcbn3y0IoGUSWuO6zLL2/f5HDE3vnDrWFc2LfJyVo/LHajgz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WAjsKvRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WSJkgNIQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WAjsKvRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WSJkgNIQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 653E1140012E
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:26:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 07:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572362;
	 x=1780658762; bh=b4wdO1BlCHuUPLHhTPxyjtTnEczGdhTozV76+1ISUuI=; b=
	WAjsKvRwVn2zyuOjaD7H1l65oRrAW4NJbSWDppmvMS4Ew+J0Ka/kqr0PZVp7Uiwx
	cQ6Iu9GkM0BXING6wpIrPqWLF43WWH1FhZV6SNDMM+m5HioggpBfrmM6EFFWz2Ms
	VB5TIzpe++xBsunCsuTvK0wXNxXjVvthXcOYpQ2eIR0OC/TYS9KJcUl0+xj99INk
	3PxFEz+6mAapltm/T9bL1668PaZ2rtHOqi3F3zz61CbGJ3xjRMFh48A5z3n13+Qq
	sTyV1xlXlTGxBEuHU7vaVYuagKc1ddZJg/Dp2Y+hD6HH43/fe3KspWhtX6XXoFZO
	eGg3pvlWGgzfczBiEfIYOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572362; x=
	1780658762; bh=b4wdO1BlCHuUPLHhTPxyjtTnEczGdhTozV76+1ISUuI=; b=W
	SJkgNIQ8QRchypwsGRBJ8A0a6eP8REjCvjK2Bw0EPBVCuNLGiC6Y9V7II9D+tKzi
	GjVe1NYvr5cYbu3sK/ZKEPeLNrdzWQ2Q08yDr7DnOTGDVKfLhrTCE1VZXUkZh/w7
	LpRiOcUU2WoBhhcV5kx10rb2grdfxigmdSNVtj9f0Z5x2sAlRHwFSQq1B0eDfRR+
	NOrV4UYJbRa5yPkDR8npYU4Wn8dh+X2+zuhYyF0L5mruicRFt9NkXB7RJGCbrobQ
	Dq7BoGvaa24UUyCQRF2rFYwSC072/pbp8RcIRpSJ95/Jm64/bu6eTmg9t/QyovvW
	gEIn+EA778C0e9iejFLhg==
X-ME-Sender: <xms:ymAhakx5DIrh1a32m5Ut16iYYu5V95u2GFJkrKUU6D62X2uJ2TQ5iQ>
    <xme:ymAhavMB-lwumSaYkUuRCcI_tu5hCIM2vLZ0sqVqU4MljHm9yjjQZvyGqo8EJN8X1
    GXPhLG_vjTTKsHqqcUjcZlou91yaFVLwxhYkPnuQ5nogDuTi41cZw>
X-ME-Received: <xmr:ymAhar-RWTbgStLZ8mwmVKqMgzUb7wDAlSu_dwP6x1pGP5WoyyHYGDOf68ijAY5IkQYKeG5WAmPLqfQwzeYHOIO9Iq5vW_gM3ToXQkiH1eo>
X-ME-Proxy-Cause: dmFkZTG1ZbTSTCt+QGOBx/ozxIEQhARBqr0/SlqS3JC3+zb5glHSVG1aoMYIj9aqeIu0zy
    sFSu/10DzZ9FxuAnUcFX6wAMbP9bcQrm5ozYikXKxnDFDplVWXkO3AcE+a89ybngC3lrIz
    /GVY5rm27PVrHphkJl/OHdHOPrCII5MKB9fWDnt3CbmEK2TBDSFR2xtzwFeqzHWM4uomo5
    7XY5VmmSTadEWmtllR1d1OawV3IdNUcjNTdgTRjA6Zegw5qOpq6fI/Dca+wbibUmVoNStb
    renMzkGmdPq7kqvux3p6g6SuTVtljNZSpQco4BML6yeKWNkQha+6iZyZlP37J3M3wlioZw
    hNlB6y1Tq7VogoqWMPzhsbfPxxG0wNMV7W2lOd6dowKXb1EkB+PR+c8Z7FwziBH9P+1mlG
    UIggIxtvs9IfdwCTK4p6gGdHNY58m09ZyE0k0K1FqA5ndlSqgjFYyux2fXkMWfm0MAggs+
    RdeEklOUK/aisoo5uHrF2bfUNDnKEj40wpkKe+DiGOg+YdawpUJDOTDwF36K++ni2RnTjR
    ECm5FXjVxpO4RYnLQtx6MlozXIQGzUWXCVGeZNtCu2rvuhmMDTSfdMXOpJjui+042jW/cU
    V3qPF5WLXqKKBvNU+5j3FsrOJtjpg6d0iHGP8ZXL4JXYzXQ74Url8PD3Bhnw
X-ME-Proxy: <xmx:ymAhanopngPz9QYRrzBX8UCx6oddzTb7NhDbwOkah-bpA0cRKJcCfg>
    <xmx:ymAhal46OE351EqM-XSMckmrgQ3wIdT83hUH-nz65IKX5DLmKlOvdg>
    <xmx:ymAhavM6tHkRHHeb8JKs-yy4Ldqk8AQlmEJqtT8NdNjHcZcLlrgG8A>
    <xmx:ymAhavN0tt_A0bO1XQkiNzeUlhZOmnjewdNcDw3LniX5QdaY_yyAXQ>
    <xmx:ymAhamzLtxTHrIDnTUzyusoiXhghM15GovLt5HEYvkQXD0mQNEJIIEEY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:26:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e209a24e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:26:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:36 +0200
Subject: [PATCH 09/16] odb/source-packed: wire up `read_object_stream()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-9-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Wire up the `read_object_stream()` callback for the packed source and
call it in the "files" source via the `odb_source_read_object_stream()`
interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 16 ++++++++++++++++
 packfile.c          | 12 ------------
 packfile.h          |  4 ----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 8cae35d25e..dff69d0e4e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -67,7 +67,7 @@ static int odb_source_files_read_object_stream(struct odb_read_stream **out,
 					       const struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (!packfile_store_read_object_stream(out, files->packed, oid) ||
+	if (!odb_source_read_object_stream(out, &files->packed->base, oid) ||
 	    !odb_source_read_object_stream(out, &files->loose->base, oid))
 		return 0;
 	return -1;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index f71a194739..23d7149fe3 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -2,9 +2,11 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "dir.h"
+#include "git-zlib.h"
 #include "mergesort.h"
 #include "midx.h"
 #include "odb/source-packed.h"
+#include "odb/streaming.h"
 #include "packfile.h"
 
 int find_pack_entry(struct odb_source_packed *store,
@@ -66,6 +68,19 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
+						struct odb_source *source,
+						const struct object_id *oid)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct pack_entry e;
+
+	if (!find_pack_entry(packed, oid, &e))
+		return -1;
+
+	return packfile_read_object_stream(out, oid, e.p, e.offset);
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -275,6 +290,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.close = odb_source_packed_close;
 	packed->base.reprepare = odb_source_packed_reprepare;
 	packed->base.read_object_info = odb_source_packed_read_object_info;
+	packed->base.read_object_stream = odb_source_packed_read_object_stream;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index 565186e9c7..bcb4b61608 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2741,15 +2741,3 @@ int packfile_read_object_stream(struct odb_read_stream **out,
 
 	return 0;
 }
-
-int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct odb_source_packed *store,
-				      const struct object_id *oid)
-{
-	struct pack_entry e;
-
-	if (!find_pack_entry(store, oid, &e))
-		return -1;
-
-	return packfile_read_object_stream(out, oid, e.p, e.offset);
-}
diff --git a/packfile.h b/packfile.h
index 2bb6656c3b..e5875e1215 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,10 +136,6 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 	     ((p) = (eack_pack_data.entry ? eack_pack_data.entry->pack : NULL)); \
 	     repo_for_each_pack_data_next(&eack_pack_data))
 
-int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct odb_source_packed *store,
-				      const struct object_id *oid);
-
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a

-- 
2.54.0.1064.gd145956f57.dirty

