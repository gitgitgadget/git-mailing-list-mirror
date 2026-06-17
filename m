Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F763B6356
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678414; cv=none; b=EVV4r1+sAj2CVv+ECbBditNFl00L6DEJVbJCBclzix3R/V2s+k3nG75MGneBJ95GPndieBtasF4Nayus3FpnFBVtjOKBB67kfCcNRXqhnYbtLqfFfpdOYvYsdKUSs4XNo5sR1lbHONxUZ8+o2RJpueeL4PcD2IZCLFEL97zAax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678414; c=relaxed/simple;
	bh=t5QERsZ9Shw2ubtuYd4zGV8KBwWeR6IyALk4gtjngvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCIuEIeB7AZDWxbIUdBdNoIpKkmE6Ajx4ej3UcmTVqdxpPm9w5L6rBceM34A82uJgVRi5f6eItX1gZMWeYChQfNGyrTnb5plRhcs/SbmIs4QJzHQE4mlvYpgxlfUmOg6M0CSEa/dVZ73MBwl91ELfD6EgNzmxwovDHBu1lGyflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XSfdm5fO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yz1mAgTM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XSfdm5fO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yz1mAgTM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 132951D0013F;
	Wed, 17 Jun 2026 02:40:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 02:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678411;
	 x=1781764811; bh=LftKF7wtb6U8O/zyiKCqkXbH2NrYzhcdUeHZUDtvtYU=; b=
	XSfdm5fOSuqa+IphSZHZ+kvdH3wA7bRafYaZxFjc7JYxawA/tHjOFhsTIHcP4tm+
	PpsAH153k+8yfC1apvZzE0ALAkUfi5Dd8kdfq5tHZmLDW4904bmjjoBJoB2mHKzD
	qJmzP97SdDPvB4IoYYRAk+ypCFPA5G/TcNnH6WafcPdOa4xT3zM+G+yBHztczTrA
	/34nFk0ZKSlmnu+PbLE2GgNkUKBouJlGuakvawxn4YsZ6ER5ekOuzCAnNHO7+e89
	CG6nW088wA1PR+Pve844ItYu0nuAnLERd083D4lRxWSOmA7Net69KW3HcK4midlt
	qyu2B8/UGep1d1igISYzZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678411; x=
	1781764811; bh=LftKF7wtb6U8O/zyiKCqkXbH2NrYzhcdUeHZUDtvtYU=; b=Y
	z1mAgTMcNkZvy+fR/+UISqXqmC88BIzv+nXFHmVChNca41zqC6XdP8SinXDdYsLD
	ntyBYvDFE3ppsUOa1LDEYSOIwDmuOuVT7rZL9FtyBeEtspyMulOnmWkjTxNL4NgD
	ghtUeSLXXu2RFsfJyWfNIcgOasRDSwK9HI+DIqijbMTJbQfIuNFFlQtWuOwuAz5a
	V6yAXgtBwk/GrHyH2/FGNIJlIreozktETcI58yR2RybkYoVsk3fvIwsx/P8xxryl
	DPhTu7nAgjvR9eJbcfIBntxDwznUQ4NuF1FaJWZbVyvPk5PrsyQGznQ4pyGzStg8
	tLUWwlSjnny10CxRKA+uQ==
X-ME-Sender: <xms:S0EyavdE0bAp3HjfpR1Y9sZwcd4bJ_0iA9WIkCCKIvPmBZ3DF7fg1w>
    <xme:S0Eyaso-lsQIlilleswtnCRz0s_BDfh7NGRevjYXnmIg_c8KNUmTwPVHGE9DrShTy
    GnF6MELR5ASI9yd84Vmg_76GS1XTd6VMuTMofCmASijlx0IAFs62A>
X-ME-Received: <xmr:S0Eyal5AGPPCLiJAG1W3gwTC2SXDp8KYmFBbuQD6qas6d-vM3QPLb6nZdRByCZRHM2d08nOFfjnwJCtbvAdBGPnHbmT95wodW3uuPD8>
X-ME-Proxy-Cause: dmFkZTFl07ipAIi9xJGEFtFdeXJ32YlTxjlf2nx1N6xtGXKrOC1bLbDlVvbrzzA5+wU1Co
    Syg+K8Q1ZQCASKzRK2+jUlv03fQMlni6m1uSDG9ZfsMez+CExN6BaOaB4dWww+dwFVrBWc
    MDEQgterYVrJX0duTt2YYH5sPQ0va9XcOu2v8cjr9lrtGWO3H/PAeE6gOAmLvw2VMk7fmQ
    bS0Z8M1QPaN6dBkHxm/qp0BwBioAlyPsS5cJKvA0SEp9LqrehZotcHKdpFgJTmQDXUKsqa
    EmWuysjWltbEijcyaQ8KC9W9onfmQCiSXmKIDwQVCz3CkB3vqB4j2FCfjXy4ARgFAuRiCf
    lk6Q/r/iBAHyVINLlhu2uNdfODhXQfyNzSlid+AykmOal7w2PwTmdWMDP8C1gz/I2XbTLH
    V9QrjJbusVBNmSD47g5C1k/nJ6yXchKrpF8oKHpr/NLwhDD3+wRP1XAVbBmIrKaWRoSKKU
    KR/szRYPzkvwmcqXEgIi1Njkow5fE5K2Nt1R/ORX/I/QvwE0XQNKCSUamTRYVsO12Y0rkb
    q1BpvsOM6iGoekHE8aIPuZrnAflk1hji+wxXMdq4mtqxpCvXKGF1FFm/qEa8w2rsvtLR/+
    h8lFxSjr1scjub38/53vy6jtXYj4m5PontFgvFFz8JT24ifZgzQC1ofMklEw
X-ME-Proxy: <xmx:S0Eyaqpfmg7ASjxys8zuMcN7su2BQw7AmcJBOo5GpTLBCvcgi-j9dw>
    <xmx:S0EyavjyxvDmqkgvvOFLypNRdscnZNHw7_14XwwxvQ2GXrANghZyng>
    <xmx:S0EyasLEMVouKpKriQ5bn_-0_h5a2yQXz_ENKnnfiU6FMWUiPpbRgw>
    <xmx:S0EyanAcoirEJrPkvMByX0WUEJvty1Ou3Ufm83T6iV137mRDuUld-A>
    <xmx:S0EyarFz7_WqbTF88pHNESsYj6Vx_nx-xo1fAdnnGPC0rEwsLhVucDyx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c48e4339 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:49 +0200
Subject: [PATCH v3 06/17] odb/source-packed: wire up `close()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-6-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.55.0.rc0.786.g65d90a0328.dirty

