Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5150388E7A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302043; cv=none; b=g3fE3Q6DeeCm663NeG0Z71W0uteqnWHE4/AzCYipZKweXxhJUWhQYf+Kamf4E5rZ+YKLMgXxqAKdw3Yk5D1+m4x4CV8vL53S9yAXVWDj4iV+Gaf4QXgaoTD+iYNLN1tdfIXRj8xtXB+39dmqgROsHEUuLdqSISgSMkhw80IhHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302043; c=relaxed/simple;
	bh=Ehk2mT0lvIcxqZZDS/q7m88YuaQirpRCHKqUL3I+vj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpncIOOWDLvcm5nbP3vkuNh8GS6bhMzUm6t4+sRGkrIqo2r1+SyLV777C5ILMwsg/JHSFOY93WpHJ6UR/qSb06sToMb1hLQ8dUPai2w+ltrxm3awQV3LTnFq2C3BDV/VaaBmViAmf5S8wIQ0pepLk5UIIHTaBfO7Q9RI5c/RJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S1F072Qe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UtOiAudk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S1F072Qe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtOiAudk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D17BBEC0090;
	Mon,  1 Jun 2026 04:20:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 04:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302039;
	 x=1780388439; bh=cq+lRk/UzG9S6vBIJA38q7NnaBi5A5rUbUbP0uPJWwM=; b=
	S1F072QeNCGUZmEGeYhFij7RYyp1WKv8bQNBp36lHqTc/qd/ZcfEdkgYcX7XF3hv
	r8krzzSU3KwlIwmgDxLQa0Tu7gf+bPns7jlxBKWvH7Xh8e1uNBZNsOQCd6qmJRn6
	+2+88zEwe4bfyUHGnHG7D9Bjw9FtULvUkWYSZD37Q0xWUOZ2DZSSgie0jukwWKnZ
	nYp0lD/uW8HIqru8MG00n49zCVvAC9tZd8OtoxujufXVC79+leK3gS/86XdhmBFe
	RDFe+vHbXgYjuSc2FhqrxW97/IJWGuS1vd22SNZb07+738mwX764+2h/O3BXDZfQ
	ukFjSw9e0xcw8wnTecZZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302039; x=
	1780388439; bh=cq+lRk/UzG9S6vBIJA38q7NnaBi5A5rUbUbP0uPJWwM=; b=U
	tOiAudk18kjwgDmygjIcgVRy3kCfKw+tl0kBNUdfKM+p2XS/wV0ePdCJDJFT9xZo
	g9g9hSquMzPNt7BD/6BB1DqFjakD09IbrSuXi+M8RKtkJVPMV2Tq1VD6fBJBn182
	Z397+lZzlV7mETnSIey77pgoaxfI8hOeJq0gIkenlAcJIy+UoQP6sGOKA1x6jy3N
	KCl6XKWImuA9O6r0bDCdOSmVErTBM+ly/BtHe/MGpdvCsEdvHQKnSAT9sfczMGVa
	WGupqVyd0m7gNYIjzCvaaxisAJ6qIVU+S+rQIMRGVmkrGq/hyxzn/PwGoL2Rvz/b
	kU9y0+/29D8jD+jV0Hytg==
X-ME-Sender: <xms:10AdanmiC0aFEeQgboR3xJwjIhtqBhTGBvT-NwqvXWT2ome_rqDisA>
    <xme:10Adag2DDNWdSihFksaSN6ZlZEVKNN3vJzwqa5n6PK9_U-_LJ82sf2v3HMi9N5Pr4
    scswKYb93XyEHE8CSPdMzFeQsW1seqZHafKXorn9ZDKUWSlSeWUrA>
X-ME-Received: <xmr:10AdarRwVj52TizvcSOg4V8hqEDecB-QmrDeglDaugJLlvgPIB6j9g-kQeuNglIvZOdDAXAeXUlMfrL0AAc-JpYHr9rzg2Z0G6i7iTV0Zwb4>
X-ME-Proxy-Cause: dmFkZTGoVC3PWkC/M98GLpgwKSp8+X2EEbK9QrLPRCVzfq6z8mGb2cg1WSKI0P1YF6K99Q
    xKY18KC2TzQ71gWxrLtHBcpqPwInMMILQwQmN+IaQps5jv2t4yhm/OcWnxr3PAuKdie/5H
    xdZiEXHfq3CyGlKpLwv2vL5myW19uyY8AtAnQMD9jV84wJQFe0QGymylYpZQO++m8ND1Hj
    j7fjS2tB+vIBobG7JpZXtzobTDeXEGy6yi7zeMBs162gs+xcsIodAA21pY4HTX/IAVCIU8
    kOLzJFDG9r9Lr/xlbzdlHVCtb2SlM1MPmdQV95SWFIB7kaTFV8arUy82aX0eqGVCnq+Esa
    D3Nd4brignQn1L6F9SffKgcTii0r3ex4kkXgJgxr7nX5Cv6nVHINrY9b7vo4iYCiG3pGPO
    EYoz+si3QgF2iq6pbS8PWenC+sFCTyvvpKWQ4ynC4epfVzv9kXpLI9m0nvKgUt8pZ3y1NX
    dpvXq46cXsslwapU4yx7h+6VjfcxWE4EGFrENuIq75ZFRA08iMEJXZFg7VIVEp21NTYcKg
    yDcLF5Xm5K410Z5Zla2gkXIFJzOlrr7wofUipE5nnMu8F9S9zKD0fnIz4a5HB0g1Cv5ZtX
    /4IdOM9Rt1321z1db6b3cj+5r1V7xgJkJf2iuzNuUI8foyRUH9YG5ZtXUO/Q
X-ME-Proxy: <xmx:10Adaqv92VkUpIrDHd19Gz9Ov-UizFA_4Hlt-gOkb9xsBWXVOs1G7g>
    <xmx:10AdaoYhIynzE0Mvr87yrmhpSY-J6a5j4ltkA5iQ9HWG-RlL9Hed8w>
    <xmx:10AdanuVM805YC5TPCUIvV1tyxLGkxfl5keg0-p6hHENRl8GvPZrxw>
    <xmx:10AdaiHaOwp99loTf7bzn6JejSq_N5TPoboGzoA6vD5pZ4Uf7_Z0Cw>
    <xmx:10Adai9h6L51P1WB3EIJqm1kvXL9BSZJDw8sKg-vHZjcFhfXfpCh-zNr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id baf55a6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:27 +0200
Subject: [PATCH v2 04/18] odb/source-loose: wire up `reprepare()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-4-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Move `odb_source_loose_reprepare()` from "object-file.c" into
"odb/source-loose.c" and wire it up as the `reprepare()` callback of the
loose source.

While at it, make `odb_source_loose_clear_cache()` static, as it is no
longer needed outside of its file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 6 ------
 object-file.h      | 3 ---
 odb/source-files.c | 2 +-
 odb/source-loose.c | 9 ++++++++-
 odb/source-loose.h | 2 --
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/object-file.c b/object-file.c
index 977d959d33..0f4f1e7bdc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2041,12 +2041,6 @@ static struct oidtree *odb_source_loose_cache(struct odb_source *source,
 	return files->loose->cache;
 }
 
-void odb_source_loose_reprepare(struct odb_source *source)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_loose_clear_cache(files->loose);
-}
-
 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
 			    unsigned long size,
diff --git a/object-file.h b/object-file.h
index 02c9680980..420a0fff2e 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,9 +21,6 @@ struct object_info;
 struct odb_read_stream;
 struct odb_source;
 
-/* Reprepare the loose source by emptying the loose object cache. */
-void odb_source_loose_reprepare(struct odb_source *source);
-
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
 				      struct object_info *oi,
diff --git a/odb/source-files.c b/odb/source-files.c
index ccc637311b..10832e81e4 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -42,7 +42,7 @@ static void odb_source_files_close(struct odb_source *source)
 static void odb_source_files_reprepare(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_loose_reprepare(&files->base);
+	odb_source_reprepare(&files->loose->base);
 	packfile_store_reprepare(files->packed);
 }
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 92e18f5adb..e0fe0d513d 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -7,7 +7,7 @@
 #include "odb/source-loose.h"
 #include "oidtree.h"
 
-void odb_source_loose_clear_cache(struct odb_source_loose *loose)
+static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
 	FREE_AND_NULL(loose->cache);
@@ -15,6 +15,12 @@ void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 	       sizeof(loose->subdir_seen));
 }
 
+static void odb_source_loose_reprepare(struct odb_source *source)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	odb_source_loose_clear_cache(loose);
+}
+
 static void odb_source_loose_reparent(const char *name UNUSED,
 				      const char *old_cwd,
 				      const char *new_cwd,
@@ -47,6 +53,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->files = files;
 
 	loose->base.free = odb_source_loose_free;
+	loose->base.reprepare = odb_source_loose_reprepare;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
diff --git a/odb/source-loose.h b/odb/source-loose.h
index bd989f0728..4dd4fd6ce3 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -44,6 +44,4 @@ static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_sour
 	return container_of(source, struct odb_source_loose, base);
 }
 
-void odb_source_loose_clear_cache(struct odb_source_loose *loose);
-
 #endif

-- 
2.54.0.926.g75ba10bac6.dirty

