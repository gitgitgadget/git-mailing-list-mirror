Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60138A734
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302071; cv=none; b=ZrC/RgAkftmaxjm1GTdrnppr/bv5vj/Xbr4VygE7KEVjTwEdl/A7CvHRy4z3hi9/j4sj1MVnDyFkUtAuLkRcyh5DtbSyfc+I7AL9TSnZUlUnPTCQIA9EqSO6bYarkSXj20TsSJQTRff6rJUDZUBmub0bI/bNVFeY8pA+qduG6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302071; c=relaxed/simple;
	bh=0uJiXRD30/dR1z40GmNeONSiPM3bTPkf3B8zg4Xni5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o0ZS7WYdxPrp/kVWLAxc9ayXW6RBBujVZfGVW/TsHejxAiODtKRCTq1FGU3DNq2ay5YYkUljCIV1EJ59ReQywiK7cikuad6ZfqujcYZ5BCW+U0GqktX5ZLRDlD3RZCjCtaz01ggkopsfUKzef9aww1HOZS8ChK1l4F+yQrduLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eyPkNpP+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1LLjhWt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eyPkNpP+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1LLjhWt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A893140003E;
	Mon,  1 Jun 2026 04:21:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 04:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302070;
	 x=1780388470; bh=FY31G3X188HuQDddVLvVvAk6HUyqyW1r3UsJAb3Be3M=; b=
	eyPkNpP+F4tBoyvBSK03UISM0MkfqiKxC0uxnSauRO6aPw1oAifUlwcedyZIDyfS
	Xh60Ru7Zygkdbw9R0RRfC2tuWgiJRC+s58sdIbvHvuw+xQp3Za9rr4gl6aDiWwo/
	m3PwVqGjrLTZw8AIBPboucCm3gC6IqOAIoTGu+MWMjustJMzhBomu2iKl6Iv8etM
	0YmbnLgJribuaVoc5K5DToEb0tbHIgz42Ap6IXNXTPZ6rcduBOTryYeJdTtPRoJa
	L5G9HnqYNQIimXcdpjlHP1pZRUaFxy4see/XD+PWHApk3SQ/8BRSUD3nLu5ejIFD
	JruUPOq+IS+Qiz2o9DzHjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302070; x=
	1780388470; bh=FY31G3X188HuQDddVLvVvAk6HUyqyW1r3UsJAb3Be3M=; b=V
	1LLjhWtQjyNb4noG7NMi1+CGWJNa9lAbLSr2GRG/3fUeBsJCQBHimLR8MceqtgwK
	WUVmTLfxh5/JDT/B8OZYINGT6X5nIOGHHeCD3gQfvZz0sLvnAnVeDEZ6Vz4R7HvZ
	NuHQJsSBqyCpms0yWY39xdzzOGy3auiK5IMcTdImIzS89Cx54l3hdHDi+fvG+kmM
	ThpdCghmeuT6N/TRlUEgSHAj1c+yM7YCnvfKkZaMZ9qTJ/Z548YWk+3MYFosIaBW
	qhNBUgV90tN29rVcgV4+hJQ6rYqF65nSU+1aFzDE4++6YA5hzlt4ydzxnqK8hCXX
	tHat8Qde6okpg2X0/NEKA==
X-ME-Sender: <xms:9kAdalAYC108bxBksr6tEFMnXsvZ2eRoG9mGV-MsA1zfwNTI4fLU9Q>
    <xme:9kAdapjZ5DeQXXZNbXrt6qRxzr-SA7uxd0CA8EzVl2LjVHAHDpne5-LHNazAdatxI
    PdXG4q38Z6_NAoXDdpY_b2jaLR2Jl3LBsblFKvc0EykBNTl4ou0Hw>
X-ME-Received: <xmr:9kAdauMrWAQJu2L1oLk4bit3_fok8OD9AngHdZ9vj3PG1LZqUvLp6Zkl_Ql0mCrJTh4VcrE-toIJ-MHtvRgT2IZhGwxN7Vz8plJyt2K_vFZQ>
X-ME-Proxy-Cause: dmFkZTGMavhG2wq0jIIx4Z9fpJ7SWU4287r52kyZjBri7FU3ikyy1OWMGhoR5V3D51ljK9
    lhHzPs57OdYeulBavUlZ6jztEphzt0JLYZFwWnMYivsF+9rVBf0HTIlwrRN3/vvoI01lE+
    IIOALdfGOcWcRa6OceRP8/4VYaeW6MzCpodqhnwzlYhwWcVbQpJ6FF+7SHRnqqJBTXZCdk
    dqfxTu13i3Y1wM62VADlbIexbmbqm6iuWiaPpCIVKETdi0dzYk/Hv4Nh4Wy1U6pVGNEGx0
    xDgzFQwnNxX16CikY5ben40siPV8AY3IjEJyeSvTcYkeFIAPi2sqT+wec2c58Zs1YGKlnB
    chJJ9bJ7lswXguqXCdSZt8SGVGgs22Cflinrnbp4AGkoVBivbVFqLFaAFaYB8+2/YrFRDr
    IkRLX9FrF7+p1j61ty4+RWXr03xK392iTYQGBM/ZEfrDs0lQx7tDvbE8K28wvkq5nYerck
    x4/Qou+7A/1i6TeSbvEKoj44GM/U/fz7Ke1C14HggLBR35+D1wx/MZjvSeBUAXA9qi6Yr7
    BfJFMK0VzOHoje/n71rUdLeHkiREYApuEkRJMoj45fJxeLDeZrVsAPwsOstMA8FNbmbd+j
    8yUYANNyXWmrkd7JO6e3cyARa8CfIdnQb2PbwISCAc1ThLucN5pkXRCk4pQg
X-ME-Proxy: <xmx:9kAdaq7qFoieQw3IUQLgozt9E-3kmQl7OIIKqyDYaZ2lb3Of0t4-HA>
    <xmx:9kAdas29yK6SCGht_QwGca8zmnjhZ9IJCfhAgPRAfWipbGFRCxJyrA>
    <xmx:9kAdarbpkiKoo4VVWErmEpG1UrQasLgHvYXjgaPg6C59GDoXkxdGDQ>
    <xmx:9kAdakC549l4E6dQuDFswdZj89tg5IznxBe821wHAIHQcisJgiK05w>
    <xmx:9kAdaoaO4ghZlLI7d_xxJA0AvcsCO857o3lsBuwUjBRna0KJlSGaj1G2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:21:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 845575e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:21:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:39 +0200
Subject: [PATCH v2 16/18] odb/source-loose: wire up `write_object_stream()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-16-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Wire up the `write_object_stream()` callback.

Note that we don't move the implementation into "odb/source-loose.c".
This is because most of the logic to write loose objects is still
contained in "object-file.c", and detangling that requires us to do some
refactorings as explained in the preceding commit. So for now, the
implementation of writing an object stream is still located in
"object-file.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.h      | 12 +++++++++++-
 odb/source-files.c |  3 ++-
 odb/source-loose.c | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/object-file.h b/object-file.h
index d30f1b10b2..528c4e6e69 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,7 +23,17 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-int odb_source_loose_write_stream(struct odb_source_loose *loose,
+/*
+ * Write the given stream into the loose object source. The only difference
+ * from the generic implementation of this function is that we don't perform an
+ * object existence check here.
+ *
+ * TODO: We should stop exposing this function altogether and move it into
+ * "odb/source-loose.c". This requires a couple of refactorings though to make
+ * `force_object_loose()` generic and is thus postponed to a later point in
+ * time.
+ */
+int odb_source_loose_write_stream(struct odb_source_loose *source,
 				  struct odb_write_stream *stream, size_t len,
 				  struct object_id *oid);
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 2ba1def776..83f8066c67 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -7,6 +7,7 @@
 #include "odb.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
+#include "odb/source-loose.h"
 #include "packfile.h"
 #include "strbuf.h"
 #include "write-or-die.h"
@@ -175,7 +176,7 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 						struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	return odb_source_loose_write_stream(files->loose, stream, len, oid);
+	return odb_source_write_object_stream(&files->loose->base, stream, len, oid);
 }
 
 static int odb_source_files_begin_transaction(struct odb_source *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index da8a60dba1..e52fc289a2 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -632,6 +632,19 @@ static int odb_source_loose_write_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_loose_write_object_stream(struct odb_source *source,
+						struct odb_write_stream *in_stream,
+						size_t len,
+						struct object_id *oid)
+{
+	/*
+	 * TODO: the implementation should be moved here, see the comment on
+	 * the called function in "object-file.h".
+	 */
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	return odb_source_loose_write_stream(loose, in_stream, len, oid);
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -692,6 +705,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.count_objects = odb_source_loose_count_objects;
 	loose->base.freshen_object = odb_source_loose_freshen_object;
 	loose->base.write_object = odb_source_loose_write_object;
+	loose->base.write_object_stream = odb_source_loose_write_object_stream;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

