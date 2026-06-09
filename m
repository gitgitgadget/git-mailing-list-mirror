Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4813F076C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995095; cv=none; b=n3DGMrp0YDZSSq3FNemP2x9AOmCLVkmL4d8oqxR3Bzy3bp7vYBe0dKnxzp2eXjdNanGosPjeKv2d2FlTvT09hhKPSD1t1MoScip40yS+eVVRs+jKeUWMeu1DGJMW0aVREXHz97tsC5BEP/NLybi9/R6nIfNDD6RfjrPbUUVYUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995095; c=relaxed/simple;
	bh=uj1bUgrMrM6Xy66rxRtw5fTNNUb89fNT0MRv2KFOw9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L00z/Tmq3DlUHYS50gDPx2CPhTSu6soM+NGpfthx6x7jgsg0AEbPr/2aYG9ELZK0qkyMLWBR4nHx0Z3swSGOOCKDeDRWHC0MaUHPkVvn4iJZmmiu9X1LQ+nK1ugf4nyLyKSz95slJ22SEUaORm+2i7dcj0qBUNVCMsLN+dBtVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LiSFnVH3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D6Mcg6wh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LiSFnVH3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D6Mcg6wh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 646837A0072;
	Tue,  9 Jun 2026 04:51:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 04:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995093;
	 x=1781081493; bh=FOMpMzqly6rP0DN5C9kmOpF0h99NeynaK+EvF7cijhk=; b=
	LiSFnVH3RFIyRY80qChEfYsXH0nuU32+iH5rvXKbJVLL7/PREzqefU9Qro4hJ5so
	LaUkukUeK179gpVpB6+Os7W+1z93AT8Kfkww6KMVTdmrlvtwRM1nHjVUufjuS2I8
	2GSzZ1ANnO8GENjvhlqfWr0UHbVBi95msxa2Baias6DoMDh9kth0iykLFMZ4mfO7
	3xxKPvYoo5e8+c27cJIwHs1GYygjzo1ZLPsAccQCcCWYYtm6jiM984D1+3UMfIO0
	S4AqJ0C/80uo3DLtVymO8T8Qx2+nQZuENs/roSoH9N7RAgeoeDWUEtjTpuPQ4qUV
	drIki1GFnEut+Tfcxb7mTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995093; x=
	1781081493; bh=FOMpMzqly6rP0DN5C9kmOpF0h99NeynaK+EvF7cijhk=; b=D
	6Mcg6whSqsnXqIStmivyENs5iWMHBvJQQkNDiSK5esb8ir1UdxU3ENtIvvjnoH60
	5ercueuZUotRYT35cfObJMaUqQe6XgiauNWlTibqXkoxkWkDrdKYp4mtmXQN3lmP
	lLzHKIfvfzmHTcq3Rz70o/XlrpowEGs7QDFs3A3V+dJbfw/YvXsIzqT9bwp60Tlx
	P3ww9Aa7LuZkOzcgMvq1P+mP60DxnXLfp/TKcca/zosO2QAvpaV7INyCMjkuOtEq
	b0p+fDL8n5/RoXUQ6dRgVVJuXSm+j0KUaJwLk5KT3WteMzo0mCKsCc0GhVL0OGoZ
	K/o6BEcmzsKpjObsaMTRw==
X-ME-Sender: <xms:FdQnanq0lk1xws_QAUtQDTRYquFd7cSLgp8_0wHbHzkhyfSdwZf1sw>
    <xme:FdQnanoTXHRBvazzhxBUYjvCeb3UzHrIz8cYQ4Zfzw6XRbDESsFFaHTXJmSNtP7sO
    UnRXlKs59ag6tdpLAqFabCOas4BpHLNNDSfT2ZjUcQ7sd99CNYJqw>
X-ME-Received: <xmr:FdQnah3ddDnXIgl1QCIJGEvVJ1dCKDc06GBpNaA6O6oPqHMCBS6kbfq_KTkqeuQ-FcZ2JL9hwVK6qBk94ELd4rghNIUMdD9J0d_XyA8kdhw>
X-ME-Proxy-Cause: dmFkZTFScmXmBNtXOl4rqVqM8DAc19fyHinqrfJGsNjV/CE2oHckwvnGyvDfLnNUuwKybL
    TXXNE7zDSLzm9sqK7QnFjZefXQ77hB0yUpUORZINqHtbw80x5HeASQHzHrphN1o87wLUDo
    o+b2Dx90Cc3HLmwbZsks1v5Qe3wgVjPUMwX4Epw71mRv/T8ItHrE8RkWZrv81HY9CRlc3Z
    /OiNXFOpQwrN765XqADbyILD80acXbo1GJdpcquKP94bmw57TBOmknCC1tOk25qwSfgaav
    egwmPIOD8ZPaE7+A6cnzDiyYUxaYdFHC73rr/JrclTuz03BNq0lnxnglgQ3GRx5+ugY1jR
    sgIXwhpSTljPbhzCS78DywhV1X6CNhuA7/c71Ibxq7FcMBU9Dwz0yfAU9BVAnMZ23IIQbb
    iP1QbybVKQqYUgKy7sCr5A7YRzn+xtH82nNQQukklbIK3zJ+oO4/tvUYC8KSO84EovGne9
    zmzjoGb7uzvix//6PaIdW5CdW5jjm+sSxgt8IhYh36WSsXF7d+9/rg9Zdwf/79skMIFBmZ
    5bB8QkffqnuGmmwDGOCC8MoskKcdNPqQ1ndK5M4W++VJDWTnhgsUtR/Pb1ds8wa7X21W5o
    waZ44tyxdCilv67iorMbR251z2OKWlMmLtWxmRF1IsA81Jfze6bJjEJTMiVQ
X-ME-Proxy: <xmx:FdQnamB8AJqlawotOvfw14AWCuiazDGBgP9ALJ0g3D4xzMTNxNZ19A>
    <xmx:FdQnapeyOdS0QCWco6LA8BWFMg2HE6V7Mj-zMC_pIk-hXtiU4vxn5A>
    <xmx:FdQnarif0GUjV_Fe_wSd3X9WOSFKaV5cKKuz0KyVFuC2UkSWtSsFiQ>
    <xmx:FdQnahoEiHKW_4QTGPtMYdEFSA8GcLtzxoimCY7MMXNS6VVO8Mdtxg>
    <xmx:FdQnahbn8mDsPKttBp5lTW5O7aRPLdGdSOEd3OgbwznPYXAyC9rc4eH_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 386ebb74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:03 +0200
Subject: [PATCH v2 10/17] odb/source-packed: wire up `read_object_stream()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-10-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
index 29530532ba..42c84397eb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2658,15 +2658,3 @@ int packfile_read_object_stream(struct odb_read_stream **out,
 
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
index 25d458beb0..dd97684e70 100644
--- a/packfile.h
+++ b/packfile.h
@@ -124,10 +124,6 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
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
2.54.0.1136.gdb2ca164c4.dirty

