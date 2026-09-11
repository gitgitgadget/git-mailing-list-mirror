Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02028208D0
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105940; cv=none; b=BuHOP99XPJ0RAmSGQe+AJ9f3nVDyLF73IYSP3V/uUrSDnqbKeBlHH7YBsNUcM8veCXCO85lgwfM55FbCyHhj/OoJ5Ev3eVuGYm8Hbsiv6VkI5bglYyEllxXIt0sjIdMyc9zOhtwK3QAETsR+loDyIRXcbPc4y5GaL/EH8SLNhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105940; c=relaxed/simple;
	bh=pzOho0spI13U3bbS9GDr5+wdAIa343HluXhsi1O9/Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmnHEfi2P82r9H/ON7QyPVNnKqEtx2T0ixm5NRwcVkY+vLLgca2vfmTUFLktN/IjnCK58LTXt9GDDpTFMai7sdFumSA21DgDSWUt2wYC8G6E6HpVTt5Fj2WukuXvu520sXj7jeHEBdAi4T4kWcsHk9g9tr/hHbR+pdi4L6dM5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GWA+SQPr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZyotpLm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GWA+SQPr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZyotpLm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23BEB140015A;
	Fri, 11 Sep 2026 01:52:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 01:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105938;
	 x=1789192338; bh=u06zKyBrLwYZj0n0jP4gfI/woENtF58IK3dOHA+YhHI=; b=
	GWA+SQPrMwyzAQiTNQSOQGsQTlOLzJG7PK38AMe6QF7ekIkEafs5j5qBzgO62QSi
	yg4phMfTd5nvqKYxvmQio0p5jTO8JxBr32DsPs1EBwsl7lfJUltADAQyqHtukEj/
	BSAA/4X9IpgWNsf56aznvstSbRjwsBJI/ZNLu3rEN+uJ2QQ/5Ptmw0sWTeEsdEJJ
	v9aD190IMmmXbc2RCDV7VSKWS5ds79x5CBfXXNMz/lWk/TbhnWOP5EZe/JrpB9we
	4qQ4KOj2gsMsRbRx5IR4mUdwFmpDu95rIbbLdwBSc7i4nBb9eLHoG2AAAjxw4u0z
	XFxFkdwZPIFoiZNoNZSOpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105938; x=
	1789192338; bh=u06zKyBrLwYZj0n0jP4gfI/woENtF58IK3dOHA+YhHI=; b=W
	ZyotpLmgRX9SQTcUX8ri5ZOi2raGXRzssZjKE+cYYRYGiXJ4l4sxlfD9VBFNVjph
	BFmdnkgeP9ZUNhHNPq+IGdMSEi1ChHmn00kVDh12r0s/8Xd31a+Uwnn+XcXr9Vv6
	kcYOwEp0atvkBH1GR+5ax6PdiU2v+NDhE5zyPn30qHvTHya+A0FY38BftEDU7JG5
	JiH7PsbLQZV2yaDnia2tvJQOzky5jmDpo/R+WsxhdhRAXijdPvuuUfbU2DKZ9z4/
	oRAPM+pLiftu8j4G8S7meycgQlqjNVq5hwMBSZK8T3QbDqjp7s3DjVF/9cjb8nfx
	9JqHNedbzQ5gR3OV7zFkA==
X-ME-Sender: <xms:EpejagyBOkjq6xCCPIdKzDIM2CEyfErzwIPM7wsiCAKKqkYdbi2zxA>
    <xme:Epejaruxu2F6ncT_6O8_UUyowFBTp4q5EuVJ6Tl4vLcs3cw18Fm0KWzxN2rXFnKwh
    xSYFn0FSa7EdbPI3R5NcU-Ddrwa8bj6UbUA20MXpA6Rf0IpeHzmdho>
X-ME-Received: <xmr:Epejavu2enXb2IwCbPkEOSJ5SFC_gCem6X8KuoG-FPj6-yoEDGk6ldZmudB1jCgPYsFWeg>
X-ME-Proxy-Cause: dmFkZTFGbO1pN2j/YKZUiA7ShUnciKfqsx0U1XemiPYUN3t9jtwXeN7n9FEXGp0nq9F5co
    yrRnlzashnU3AB6vjyLklVtMN8PyHxxCyBxV1wxrw2dXZWa9j8HhKgSyuMN0jW0N6VMLaV
    bQpWRqmAKsGBt/vd8tNZcfaKWC8qBNZYYrjR8haOyHWjeCVBc7XOb0obTWGXzfGP30lmn0
    Wmr0c2uQ1qumWmEjlInI4Zd7OA6KJgxV/QifQ32PiW0li9y+4Y6A96LqGcCx9kSo/12ywj
    3o3qXj+Yo5m2TyIPaaOTEFHUAro7Ei/pB18kjso+RHyPuydzGSt/hPRtgBExMXyqdJy+A5
    cU61KGkyQXZLRCRN2+y8DOcvGgMuQt5CdGUBtegOOPhTG8lIu+9o82cfbFxZOQ7vO2ST2L
    yCvKI7wpjLBhMTxLB+42LYFUhAQTrv4oDY82XgURGnWtvKMd2w8o8ypkj9q5K+Rq1bGEhi
    E1/xTTZM+ehUShNWjAex9FnreRO61vAC+oQIxMVSroG0bYyXTncfMztUnZ4qNue4I7SPqB
    q7+/ZcyigdBoDMZGCDa9Y45SjJP9BvpesSoAe8pXhxr9ahb+ofiv1J8sB2+BIIlN37dK/W
    3TFSx3mx1vkXpwAZ6wauiIPBsD/iqaJB77gNxQa/843f3G8RGSAIIsDfur8A
X-ME-Proxy: <xmx:EpejaoPu04en8a3vwVM_0JaxVYfEXSoezM2xnwfhBWKbPdvf3PBFgA>
    <xmx:Epejal27qyJhXs9RwJMZsm4vuc_qyYD6yLWnUbz6RjlWVP7D4s9JYA>
    <xmx:EpejasPVwXfX_56AAWi9gnLpC5MQ0v0N40lXbiZ8DrIMQ-i1R9Di0A>
    <xmx:Epejat0_LLuWAGL_r5Oe7rlfKKLZNEJua1BH2EPJTrZYeAocXJthuQ>
    <xmx:EpejakWTQPzMe92oMsXOns8K7NUHhAu-LG19kabAB11j0JPfhIAD8WNu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10dbdaa9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:54 +0200
Subject: [PATCH v3 11/13] t/helper: adapt read-midx to not link ad-hoc
 source anymore
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-11-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Same as in the preceding commit, refactor the setup of ad-hoc object
database sources when accessing a multi-pack index in an arbitrary
location to not link the newly created source into the main object
database anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-midx.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 27a05da957..1f7a1927e4 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -5,34 +5,42 @@
 #include "midx.h"
 #include "repository.h"
 #include "odb.h"
+#include "odb/source-packed.h"
 #include "pack-bitmap.h"
 #include "packfile.h"
 #include "setup.h"
 #include "gettext.h"
 #include "pack-revindex.h"
 
-static struct multi_pack_index *setup_midx(const char *object_dir)
+static struct multi_pack_index *setup_midx(const char *object_dir,
+					   struct odb_source_packed **out)
 {
-	struct odb_source_files *files;
+	struct odb_source_packed *packed;
 	struct odb_source *source;
+
 	setup_git_directory(the_repository);
+
 	source = odb_find_source(the_repository->objects, object_dir);
-	if (!source)
-		source = odb_add_to_alternates_memory(the_repository->objects,
-						      object_dir);
-	files = odb_source_files_downcast(source);
+	if (source) {
+		packed = odb_source_files_downcast(source)->packed;
+	} else {
+		packed = odb_source_packed_new(the_repository->objects,
+					       object_dir, false);
+		*out = packed;
+	}
 
-	return load_multi_pack_index(files->packed);
+	return load_multi_pack_index(packed);
 }
 
 static int read_midx_file(const char *object_dir, const char *checksum,
 			  int show_objects)
 {
+	struct odb_source_packed *packed = NULL;
 	uint32_t i;
 	struct multi_pack_index *m, *tip;
 	int ret = 0;
 
-	m = tip = setup_midx(object_dir);
+	m = tip = setup_midx(object_dir, &packed);
 
 	if (!m)
 		return 1;
@@ -91,29 +99,35 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 
 out:
 	close_midx(tip);
+	if (packed)
+		odb_source_free(&packed->base);
 
 	return ret;
 }
 
 static int read_midx_checksum(const char *object_dir)
 {
+	struct odb_source_packed *packed = NULL;
 	struct multi_pack_index *m;
 
-	m = setup_midx(object_dir);
+	m = setup_midx(object_dir, &packed);
 	if (!m)
 		return 1;
 	printf("%s\n", midx_get_checksum_hex(m));
 
 	close_midx(m);
+	if (packed)
+		odb_source_free(&packed->base);
 	return 0;
 }
 
 static int read_midx_preferred_pack(const char *object_dir)
 {
+	struct odb_source_packed *packed = NULL;
 	struct multi_pack_index *midx = NULL;
 	uint32_t preferred_pack;
 
-	midx = setup_midx(object_dir);
+	midx = setup_midx(object_dir, &packed);
 	if (!midx)
 		return 1;
 
@@ -124,17 +138,21 @@ static int read_midx_preferred_pack(const char *object_dir)
 	}
 
 	printf("%s\n", midx->pack_names[preferred_pack]);
+
 	close_midx(midx);
+	if (packed)
+		odb_source_free(&packed->base);
 	return 0;
 }
 
 static int read_midx_bitmapped_packs(const char *object_dir)
 {
+	struct odb_source_packed *packed = NULL;
 	struct multi_pack_index *midx = NULL;
 	struct bitmapped_pack pack;
 	uint32_t i;
 
-	midx = setup_midx(object_dir);
+	midx = setup_midx(object_dir, &packed);
 	if (!midx)
 		return 1;
 
@@ -150,7 +168,8 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 	}
 
 	close_midx(midx);
-
+	if (packed)
+		odb_source_free(&packed->base);
 	return 0;
 }
 

-- 
2.55.0.1074.ge7621b4bad.dirty

