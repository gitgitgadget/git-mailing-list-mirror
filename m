Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944547DD50
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261001; cv=none; b=lsvQmHAN8DfSWfwS4443/ngBbb1Y3uN99J3frnf5X2J8xy5CChQ+jUAFcQy1Fiy7/8wb9eCnW7xjkjhxUZC110j6ySuw/ZXQ/7IHLDq3nMHnpNp8NCD44OHoHYU03FZyFErB+KhPflNeuSH0+t8NUctzmfvvNZDh2/F3mH3KWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261001; c=relaxed/simple;
	bh=3MU9hm5+lBPkXNKjZmYXVZhuF1mwmfFAxDPDWjVyMUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zx6/fC/KJN5LQScOjlipk9UHo/t9DvTA+yNcTmT9FadTsgajQPZEX1OWbH22rVVL2/wP+R7FK6RBpSMo5RCnznqQaCazI89/J+6USs2pg1jkXm7Vjg4QQG6Gx8zCShlAecaJ5ljlDjloFrXLs3xEm+H32+GICG4VL/gRSqzWNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UMDh/LL1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLVcddx7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UMDh/LL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLVcddx7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B95BCEC00EA
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 07:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260998;
	 x=1788347398; bh=3r53k2ssc5zA6pyrlb1SUGv7aDzsL3Ya7x6QsMYh6pk=; b=
	UMDh/LL1P16aaCFL0OzucvlWoY5IPUTc9eWh2l3d7/IN/nP+KO2xHnsuEwmYuNGZ
	DeKYLXiN/CfN6wp9ZUDKKUxG+RJHIDbhEzLq1u+8k6KNLF+X9CmrTUXM8fK2zXff
	caIvhBUxqggLmTTKy3bSoRdneG8s4TyRmst/LLAoQ+PpFUmpQvokCy0mADv3hR5C
	/AlascNCoAiamX0eF+3rP2pNPOYqEak9Of4Xl5yyTePR9XKDTAaFLY4gjPL6UaLo
	6+V1gK52+ym/QTN3C+tSuUr20/vD/RiYVPF4MSsRR3UHsa5d+vp2gq9O0kn+Yo/g
	yT4lw40Y3OFFgKN1lbSkoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260998; x=
	1788347398; bh=3r53k2ssc5zA6pyrlb1SUGv7aDzsL3Ya7x6QsMYh6pk=; b=F
	LVcddx7jlfo81NmEaykY+kdZewTtzh+GdP4i0r0mq4DRgeSFFELU5lW/c9wzuk84
	pii7165ngnDZ0swGQeFiBip0AjaXI+Up2YwZlWj/s5gWqqPKyz3PdU0X3ZDgfHn9
	kskmQqFNEyW6K4e3XeRzDP9aCwtDW0jR/f0e9ZS1Vsl6PvUq5yHLHv0EFY+UD1Ca
	XIOo698ECKg4zOxgPw4Zhsp0kcTFUHBFF5FobDcquw99wXHlQphcwFeBX1FKNycH
	U1qNPAHSJtJs4TWaOZqhr4pM8nWWaBtAZqm1B7vbrNqZ1aD1k3VUcyUO6Iw+1Cce
	xkRsv+eaLbSVLx5yiUbkQ==
X-ME-Sender: <xms:hrKWaru2haov9ILkP-S5_CuPTyt7sO1IhUNOnwTpAFK33VjYEbWzvw>
    <xme:hrKWajbkHgLsIgQeWr5IPfc78Yv1bO_CpZcpeHinwPK3Au2Rg39q4sJKXPJ2K09tD
    nuPRKuAYGIVewbZ5rHF8ozp3ekkX3SVax-gm2EVv636Q6SrmFhpnf4>
X-ME-Received: <xmr:hrKWakYaGloqs0MY4IehhvuA0oecXBly96LDdgeztwa7gR6FiHM4Gg>
X-ME-Proxy-Cause: dmFkZTEN9g1Fe0QNve9ECoP2TiUiX4EEH5POEiwmRiQIlHZ+xDbzHkU7NDd2M3NVK6/umO
    bXXkzUK3COWchLgt1/LK6gQ+MqeSaO5Oixh8RPOTrogDUVvdApPqyytnFYWyXEx31a/UW/
    VrRjQoyTePvVd8NFe+FYtwmzmG6MTjOdJtb92EaY7FcVv+MSIEhwv9SzJucvjBA0gTjUZ5
    irBlskFAJd/x0/Ql5UqM+PWol2xq0PhHqo6xS2QHAKohbPBqVxfe/t/HxXIdPstzFq1tQ2
    zZWYaDW+dfkh9KQoVCr2N9lwFiWtupwGIIOt/EhVGn/DGYrANZ/6T7aifXl4bC+/EDNatF
    2AIIm7361qqNdTpL+8nuMf9bfUNzt/hkOe1vjtE0/006f16sYL90T72N2MLYAu+J8ZnJdk
    qsmtSUFQrl+wTlzOQyLnAVZguBdYk5UmWAnSRz3FLariTNKe7lKHXHR+fuRy9qysuZi2Gw
    l8OAffUxYbciZa16rzEm2xPg5NZNTPL4PjCgfbBUCbBfKh9hB+tm9SlGFhGktVeCy3btb3
    odANHVavsySdXyl5FXrQFhRiOJuGhdNr/M7q15rMPiZRv60NHwEt/45ZWd95XhBJFVKdDh
    oKuYof9h+o0R/PERQM+7IXTkc6HYgAfy9F4nKaQRYJLjaLo1X7FaylBVEl2A
X-ME-Proxy: <xmx:hrKWavWUtSU_IaVUW2YXo9UUiyNSqC6xSFwC5O03vqbH1PuLQ1yaPA>
    <xmx:hrKWar1_JZvfrXv7Vttj3HWoCAEBUl0NfJfpTtJObLHP2bHdBV6kuw>
    <xmx:hrKWamYeoikIs7rCuIxdCdwQBGHC5ThG2ujiQnd0CZ12HPUboP62Hw>
    <xmx:hrKWauqeXeoLMPETgi9oYS8qH0b_xUAQIqHL5sYRw9H9zYoKsDs-Rw>
    <xmx:hrKWaqcLPb9y3sAlUv2RSE0aP-tYARzKXXkmR_4MPdYi5jEzvkUZeZDY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0861bc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:10:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:09 +0200
Subject: [PATCH 10/12] t/helper: adapt read-midx to not link ad-hoc source
 anymore
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-10-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.55.0.979.g7e5102b832.dirty

