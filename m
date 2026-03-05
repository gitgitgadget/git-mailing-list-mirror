Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EB4F881
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720417; cv=none; b=OAMKlvf8zd4F5c2zqNaHpouLb+GOm4jF/+HcOcQ3asCrOS6CBxxTSH0szPMyXYJeG/nYgs8Pdzu5cCmlr98MiRRzu7rq1yyMv1E/jlfwILmj/Wp4LjRnD71M7UaGnPUViDkPpm7gYS3to2m2hKd5XI+hRgYkLXYVeIyINN8PccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720417; c=relaxed/simple;
	bh=xt3gc3iTdU1se+ghBNKMacU5YBR5PlNPYe628Wq9+lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIrJjV2o/qUwttTRFy3HoTRMKoR8svQ2hkKmkCFDUk47c3F3tHIrCb9Q4YaR6ZIFb7oBZx41NMTd6zahzSUSHfhcKkXaprLWWCH6nnei3ZfQjBuzPHznREvrKYSRvxul1LcM/2QFFCx5b0zHt1au3rIYdpBM9v8olndVvO13s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FLB5CBFM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wSUhi6Eg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FLB5CBFM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wSUhi6Eg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 60DD11D00125;
	Thu,  5 Mar 2026 09:20:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 09:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720415;
	 x=1772806815; bh=mvB8WNDX+5T0xPu+O5keBPKfNvbRpcJSXD4LqfkxzkE=; b=
	FLB5CBFMDHHATVxevIWVf3Xzm1CsaHHZ8z754SmRdToTVfs2Wkhobg/QZ+Ol5E8x
	8Q0qCV71gdXVv1xl8QZAV25TKVl/JNPxKQcm6cr6qV6qN1d9z1Idt2cahrdcAFF9
	LFMCtXrbseq6DKzA0fdz54bl9Y6lE/Qb62RHQS324ZkBxj0fAGBGWr5F/L72dN9K
	TwCCnabSHPYGtnlHhGqFHc8Fta6s7GBdUUPreYDRh4YtlYtbMcmjk9ZYWScgyZRa
	vMWjiGPc2lFzLonNL5HdqzuiObHNq1rvNbQ5BVsjW9aURI0nGnmjE9VgJ2inAArQ
	0Mt+3U5PLxbzAAev2LXgzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720415; x=
	1772806815; bh=mvB8WNDX+5T0xPu+O5keBPKfNvbRpcJSXD4LqfkxzkE=; b=w
	SUhi6Eg1kBnh64W0EkuPd+5PHsmpd2DXCdzREWPGFeQ+7kUW33g8gpmfw43BjLj/
	Gs6016NfRfyECHQCSd3j/ypZ1jfC0f9d8A3nJW/eANOA6hPrBCwho+eF+vF0w6mL
	5f0+Q0fDhmZW2VpPUyPFS08kuzTc9j4KnBu9P8DItT8qp7A3lA3iYf5OsM/KbsBF
	7SRcBWSrGvqvsLd/XglFKm00NMqBK0RY9GfG3JFD1YST0idZ3BIzoF2a8UKQzkgo
	ivEM0Sih9zHd5IZTUczhiihnnPA0G+gpHpku4ocMhPfk158+vMoekFZ1RlhwmQnx
	1YArnlxmtGDwZp7FpGksg==
X-ME-Sender: <xms:H5GpaQNkwFr1xSfk3Y68mLP7rtIC8t43wCc0emZtf-IK2aEBWbKmmw>
    <xme:H5GpaRhVc7gNAa3eNrYzC6XhmrUJp13qovoz_FD2C8Wmo_8luGwTsIrUIT5Xzdf5i
    -QrkE88DjAVFAobF1RZpB4-Z7a1mBA-SSzn0H1g3E0--VRNjARQ9A>
X-ME-Received: <xmr:H5GpaT3ZzkLBLtJxAa2vvS8PLSedzTsPvR8yOp2nYi5SG0Cn7Q4SWwdxtcCBwY0Om0zSd_OsyBAFKjAovZkMeUO4R5e8tnWkMtCy0tb-VeDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:H5GpabiCvCDBko-VLp-NmOUPRekiVkVkkQqBzCjzTiBhLo8wGhV5mw>
    <xmx:H5GpaTdG663mhqa81n8TJnt5oW0DSdAi09DMIQlKcuYS9IA_Tf1M7w>
    <xmx:H5Gpaeli4WKxeDJHFtdQxk7VTHOAap_PG56buODUqNiAWuuYE5eoww>
    <xmx:H5GpactZzfAamXk8ZQXgAA62FrZNeKra9JSTOzxyXo7HjZXXwVE9zQ>
    <xmx:H5GpaUcVVsEOLUhcaJoOFXKXNlmEM1wO7KQ_joiJb6PKSNGBd9FHMpCh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed13f8ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:50 +0100
Subject: [PATCH v2 10/17] odb/source: make `read_object_stream()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-10-3290bfd1f444@pks.im>
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
 odb/source-files.c | 12 ++++++++++++
 odb/source.h       | 23 +++++++++++++++++++++++
 odb/streaming.c    |  9 ++-------
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index f2969a1214..b50a1f5492 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -55,6 +55,17 @@ static int odb_source_files_read_object_info(struct odb_source *source,
 	return -1;
 }
 
+static int odb_source_files_read_object_stream(struct odb_read_stream **out,
+					       struct odb_source *source,
+					       const struct object_id *oid)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	if (!packfile_store_read_object_stream(out, files->packed, oid) ||
+	    !odb_source_loose_read_object_stream(out, source, oid))
+		return 0;
+	return -1;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -70,6 +81,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.close = odb_source_files_close;
 	files->base.reprepare = odb_source_files_reprepare;
 	files->base.read_object_info = odb_source_files_read_object_info;
+	files->base.read_object_stream = odb_source_files_read_object_stream;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 150becafe6..4397cada27 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -50,6 +50,7 @@ enum object_info_flags {
 
 struct object_id;
 struct object_info;
+struct odb_read_stream;
 
 /*
  * The source is the part of the object database that stores the actual
@@ -138,6 +139,17 @@ struct odb_source {
 				const struct object_id *oid,
 				struct object_info *oi,
 				enum object_info_flags flags);
+
+	/*
+	 * This callback is expected to create a new read stream that can be
+	 * used to stream the object identified by the given ID.
+	 *
+	 * The callback is expected to return a negative error code in case
+	 * creating the object stream has failed, 0 otherwise.
+	 */
+	int (*read_object_stream)(struct odb_read_stream **out,
+				  struct odb_source *source,
+				  const struct object_id *oid);
 };
 
 /*
@@ -209,4 +221,15 @@ static inline int odb_source_read_object_info(struct odb_source *source,
 	return source->read_object_info(source, oid, oi, flags);
 }
 
+/*
+ * Create a new read stream for the given object ID. Returns 0 on success, a
+ * negative error code otherwise.
+ */
+static inline int odb_source_read_object_stream(struct odb_read_stream **out,
+						struct odb_source *source,
+						const struct object_id *oid)
+{
+	return source->read_object_stream(out, source, oid);
+}
+
 #endif
diff --git a/odb/streaming.c b/odb/streaming.c
index 19cda9407d..a4355cd245 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -6,11 +6,9 @@
 #include "convert.h"
 #include "environment.h"
 #include "repository.h"
-#include "object-file.h"
 #include "odb.h"
 #include "odb/streaming.h"
 #include "replace-object.h"
-#include "packfile.h"
 
 #define FILTER_BUFFER (1024*16)
 
@@ -186,12 +184,9 @@ static int istream_source(struct odb_read_stream **out,
 	struct odb_source *source;
 
 	odb_prepare_alternates(odb);
-	for (source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (!packfile_store_read_object_stream(out, files->packed, oid) ||
-		    !odb_source_loose_read_object_stream(out, source, oid))
+	for (source = odb->sources; source; source = source->next)
+		if (!odb_source_read_object_stream(out, source, oid))
 			return 0;
-	}
 
 	return open_istream_incore(out, odb, oid);
 }

-- 
2.53.0.797.g7842e34a66.dirty

