Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D64175A79
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720405; cv=none; b=dlar1lY7Fv0/GcZ+LzlCOWTw5vpp7KNLzGFm6P7qkfhOGW4PieNJduTgt5y1RPofqiQV/LAGPciBbllamJfQ3WXwDIcmw+qRfTzod+MARiFoUyoTmuSWWs5lOD31F3tl0CjLkFkxhmHLhJDZxH1R20llq8IerM8/WLlSv6DCxxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720405; c=relaxed/simple;
	bh=yzL1h3bu9xdirr3F7tZglkIv4intcUEEYaAGzo+9M4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcqol4wzvdzMxIhwmdBfKNK6ThRX3x3YKlAFZnlduCpQhPL9nLeuRrszF/Vn4xq/DcfGZJwnHRsBLByc6ZLouZ5squeZihbWC0FbZZ1GwEEYFyu4pBIGzmHXQgFhXd0PIL5NKeTwplyE0/I3NM1v7EVNOJNzWA6JUE2zlR6Fiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QlzuNZff; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tpCV5rlo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QlzuNZff";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tpCV5rlo"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 77E97EC054E;
	Thu,  5 Mar 2026 09:20:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 05 Mar 2026 09:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720402;
	 x=1772806802; bh=J98FAwB+mFZ0wvIMHAhYVWdyarfNkHxQLVPB0MU/8kE=; b=
	QlzuNZffSUdhNiS/jtprBGASTjykp2OStEIKDV6wOS8qP5gbfTkPCNNt88jYzs5/
	wFJgbpjsQnCTJCjpYsRO8VfRH6QjCuOvn74eft3WY/+oINAQsVI2S0sxBc9Hps2z
	76zzCtVg0WtTvm3TE0fiNF5v4LycYXQDqqDJbr4n9R/BBpfZxhsLBKJmFCN65quk
	GpE/Sk7SprLv1yi8cAR0Fz5z+1PBE51oAhPnvHe9XOOvqOtRtPeCAgDapx0DIA/U
	jwDDR+jVtIko4Ot4CND4f8H5STAQwNWtRjpSl7mKmcgZJIbyYl14ZyCqmGxPyN6e
	+5Z22Q0J9mcP5IFRZfbseg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720402; x=
	1772806802; bh=J98FAwB+mFZ0wvIMHAhYVWdyarfNkHxQLVPB0MU/8kE=; b=t
	pCV5rlo93stdB0/Bm3MT91qDP1e8c5gGle+6rVPovOQgAQz3ZyjqJsfoMbGpUSJx
	HJ1jxXS1vZjSzl24aWMVQjRWpEgh0os3ElziaLNajdRM+oBD/ffUWotAaNvcxvuz
	1Lru7wNtiEjyoIY7KE2j0GIjdURDP4UpXmLGAMP67xDrPD6bY1/HkWKaHLQ1dbuV
	VPRPFWkU5E0HJfZ2Dhmaf7/5BAKUuj36vZ5sbW1w3nKxVRKHRkIY67yC+wxIA33F
	qPqa1d7VgCl1x1j671Pt2hQMN92HZO9YFfX7s3vkgOaKhQIBovApdP48R0t1OT74
	Wz/8Jag+tPOVcpXMA38LQ==
X-ME-Sender: <xms:EZGpaTGTO_hfu9rV2vdd-mPbImn3QPoK4Is_pyEqu4MsXTwmptMk0w>
    <xme:EZGpaXVy9smvezF8rcObh4ulKW5T_KLGBrhMR9_DBCxDiJUOLii39BVsC2V9l-Lni
    7mT3l9SqTa_gLKTUdugHKRReC-TrSyBPN-ZTQVuGPGgdmFM_0MnJA>
X-ME-Received: <xmr:EZGpaaLnidD9X0fzV_Z-14saLoA6UrGnKBfvrmcEknxKJ12KGduqApLyGbQf0r_ema0DCg7L2kRs2kWbK2hoGm2_1vvK_-KNUbb7We6m73A8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EZGpaf85S48Wm5QlvId_GIAB2TGnVbNl7xlaaR1p4XyCw294mu5BWw>
    <xmx:EZGpaVIBeN_l8vn0Dn1MZVpydts6ke8pXYg6gxJ3DNpJwlrvCsuOzA>
    <xmx:EZGpacmJdpl4T0SUBGZs_Xy1Wo9UmGJK-UtVhx97Gg658_kFPTB4eA>
    <xmx:EZGpaRNUerK-t774xgwPeTRfkaB8KGe6QXznYUtMTfParAqMiGyyXQ>
    <xmx:EpGpaTOVnlF2OcwktroXxR0YUKzPn7q4vbnE9NGfy1ZYMsCiawQ0_jLY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d155088 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:19:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:45 +0100
Subject: [PATCH v2 05/17] odb/source: introduce source type for robustness
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-5-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When a caller holds a `struct odb_source`, they have no way of telling
what type the source is. This doesn't really cause any problems in the
current status quo as we only have a single type anyway, "files". But
going forward we expect to add more types, and if so it will become
necessary to tell the sources apart.

Introduce a new enum to cover this use case and assert that the given
source actually matches the target source when performing the downcast.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c |  2 +-
 odb/source-files.h |  5 ++++-
 odb/source.c       |  2 ++
 odb/source.h       | 15 +++++++++++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index df0ea9ee62..7496e1d9f8 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -36,7 +36,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	struct odb_source_files *files;
 
 	CALLOC_ARRAY(files, 1);
-	odb_source_init(&files->base, odb, path, local);
+	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
 	files->loose = odb_source_loose_new(&files->base);
 	files->packed = packfile_store_new(&files->base);
 
diff --git a/odb/source-files.h b/odb/source-files.h
index 859a8f518a..803fa995fb 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -25,10 +25,13 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 void odb_source_files_free(struct odb_source_files *files);
 
 /*
- * Cast the given object database source to the files backend.
+ * Cast the given object database source to the files backend. This will cause
+ * a BUG in case the source doesn't use this backend.
  */
 static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
 {
+	if (source->type != ODB_SOURCE_FILES)
+		BUG("trying to downcast source of type '%d' to files", source->type);
 	return container_of(source, struct odb_source_files, base);
 }
 
diff --git a/odb/source.c b/odb/source.c
index d8b2176a94..c7dcc528f6 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -13,10 +13,12 @@ struct odb_source *odb_source_new(struct object_database *odb,
 
 void odb_source_init(struct odb_source *source,
 		     struct object_database *odb,
+		     enum odb_source_type type,
 		     const char *path,
 		     bool local)
 {
 	source->odb = odb;
+	source->type = type;
 	source->local = local;
 	source->path = xstrdup(path);
 }
diff --git a/odb/source.h b/odb/source.h
index e6698b73a3..45b72b81a0 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,6 +1,17 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
+enum odb_source_type {
+	/*
+	 * The "unknown" type, which should never be in use. This type mostly
+	 * exists to catch cases where the type field remains zeroed out.
+	 */
+	ODB_SOURCE_UNKNOWN,
+
+	/* The "files" backend that uses loose objects and packfiles. */
+	ODB_SOURCE_FILES,
+};
+
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -19,6 +30,9 @@ struct odb_source {
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 
+	/* The type used by this source. */
+	enum odb_source_type type;
+
 	/*
 	 * Figure out whether this is the local source of the owning
 	 * repository, which would typically be its ".git/objects" directory.
@@ -58,6 +72,7 @@ struct odb_source *odb_source_new(struct object_database *odb,
  */
 void odb_source_init(struct odb_source *source,
 		     struct object_database *odb,
+		     enum odb_source_type type,
 		     const char *path,
 		     bool local);
 

-- 
2.53.0.797.g7842e34a66.dirty

