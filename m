Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1323A99E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862424; cv=none; b=Z8H0APmjL0dbiMeZE5eDNmv78ilqzfzOpQ5a3zmbDIl77fYZB5LCaoNzk58SiOSM5L/TMtSnNPCDU1JDDNIim5HxB9UfWi+JQmf6jeL2t87SuSKMbjxAAMEdSzRDnZh+1JTpV9T109Uxcv+4WRboiVB1USsi4noFiguHpHiC580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862424; c=relaxed/simple;
	bh=pWTYL0N7mhuarebcfw4U0xS6f2BO/foCZUe5rotQqZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o0HNSE3RirveUDO/fSmq1B5FNS0Nyb/Ja3ObKiYyM60sFJq1bN498S1GYBcER26tvmWNFysO72oGnmeA+IlYF8jzH5ZZ6YG4I0w+ZP1+hQyopa9Cx4K0awnMJiypTHwZBQYl39GKD/gJ8+MOLP8DAPAY1iKX9afBnz3BBgjcfcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ky1hEYio; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sQlbM+tL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ky1hEYio";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQlbM+tL"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 334BC1400012;
	Mon, 23 Feb 2026 11:00:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 23 Feb 2026 11:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771862422;
	 x=1771948822; bh=3V+GH2m1f0qxj7BmRnmVu/8zShpkpMyMYKDqynjHOeA=; b=
	Ky1hEYio+KaAaNKDgeM2B8wCixG2kkLIiW6CVAGGoSjTBO0SKMLKYEzI6dPqfUpQ
	f/zMsdIM+bkHVZLrSdtDoDuet36smNE+muQJDwx0C3Bxue3LdNqh8r2GFEwRakTd
	KZuP3hiR3wzLSISYiifEKmOrDWhskSMoN3MhiAmaGMUT8s4BumkduCeJbwjy2PaN
	Xx072iQPCq0KQDmHQSholOqS2gky6tPmPePy8TdMH/BsesKTaldL07J/SCCQRVZw
	Kcs5u4dTpNvGY2AstStjB2m2ijvP0kDP4svQAdmhYy9F2SaEH6/+eSoMLD/LIV7Y
	iVMUr/ZMsoj3nGW4IbbmQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771862422; x=
	1771948822; bh=3V+GH2m1f0qxj7BmRnmVu/8zShpkpMyMYKDqynjHOeA=; b=s
	QlbM+tL+Prp+l62ohlHH6OypgnNFeRMgvqtwcPyiHK+z45hPSAAcWK17CjsSO8wU
	ExMl1i/M4m3EP+ewPZw39Nj98FAN2IhXWVpeLWd4rQoY8vzZUYxqbGFbNNngdqkd
	J0ZKEgbi6BicoefCG3hOKSQmZ1D8O9l0AR1qtUQ6OauO5OIsT9gp742yG6fe67Gu
	l7sLsh+Y5ga1UmQA5kbs5Q7cvwuqau/AJEQW4fUXNz6bWt7AHs61MKeuATmRIUS4
	wpJphfyzJazHjiQlf9MasF/FH2NegdTMCLIyMtBpdb1lAKjnjctKwbm1NqwENwCU
	VAk02TkvKp8++qP/oHFUw==
X-ME-Sender: <xms:lnmcaX-RtMZKXAaP21eYU3bTE4NG44J4Bq5i-Gzw0v53XMQGVerdog>
    <xme:lnmcaanz2jPsGLsimlDBQo9YPFnGPkJcxFE_iPz_TLv8dzInsaaITzXBBHMvnvpSP
    TBkoF7-tT5r-EKRzMUacd2HDe_gcvGugdyd9NHdrCb1qA0bTrPx8Q>
X-ME-Received: <xmr:lnmcadUnApwpYaeSBfM7L2H6Z1ziGM7cMd1BGdpOOOOe4aMJA7Ig1Sn3EuVkUd02HOwERmjw6JZvtGlAqVNZ9bxtmgQyONBLeBA6aIuRsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:lnmcafF9sVDvcaVG6Ktd5a0X8QM79hfi4cO0NeW44jQY8rJf8NMDhw>
    <xmx:lnmcaZfi-h9msSfDXBO7AW2v40rP_HsW8eTpIG8DPFUloSZDlApVBg>
    <xmx:lnmcaQJ-lt6nfH7pV7luLoPV-GItVonmNB3O2dCyXsfHFiQjI65PBg>
    <xmx:lnmcaeG6WjfdedrXHpaY8GzZRwZQnl1P2D8Dukb22N2LtiLN-P_e0Q>
    <xmx:lnmcabMrH3PI6AijTl4LS67-c6t_7BQhulZkt8Wm47nENvrUhdz7CWkP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:00:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bc4c5aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 16:00:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:00:07 +0100
Subject: [PATCH v2 2/4] object-file: adapt `stream_object_signature()` to
 take a stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-fsck-fix-v2-2-99a0714ea3bd@pks.im>
References: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.3

The function `stream_object_signature()` is responsible for verifying
whether the given object ID matches the actual hash of the object's
contents. In contrast to `check_object_signature()` it does so in a
streaming fashion so that we don't have to load the full object into
memory.

In a subsequent commit we'll want to adapt one of its callsites to pass
a preconstructed stream. Prepare for this by accepting a stream as input
that the caller needs to assemble.

While at it, improve the error reporting in `parse_object_with_flags()`
to tell apart the two failure modes.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 10 +++-------
 object-file.h |  4 +++-
 object.c      | 19 ++++++++++++++++---
 pack-check.c  | 12 +++++++++---
 4 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1b62996ef0..ca2c4dddf3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -129,18 +129,15 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
-int stream_object_signature(struct repository *r, const struct object_id *oid)
+int stream_object_signature(struct repository *r,
+			    struct odb_read_stream *st,
+			    const struct object_id *oid)
 {
 	struct object_id real_oid;
-	struct odb_read_stream *st;
 	struct git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	st = odb_read_stream_open(r->objects, oid, NULL);
-	if (!st)
-		return -1;
-
 	/* Generate the header */
 	hdrlen = format_object_header(hdr, sizeof(hdr), st->type, st->size);
 
@@ -160,7 +157,6 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 		git_hash_update(&c, buf, readlen);
 	}
 	git_hash_final_oid(&real_oid, &c);
-	odb_read_stream_close(st);
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
diff --git a/object-file.h b/object-file.h
index a62d0de394..733d232309 100644
--- a/object-file.h
+++ b/object-file.h
@@ -164,7 +164,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
  * Try reading the object named with "oid" using
  * the streaming interface and rehash it to do the same.
  */
-int stream_object_signature(struct repository *r, const struct object_id *oid);
+int stream_object_signature(struct repository *r,
+			    struct odb_read_stream *stream,
+			    const struct object_id *oid);
 
 enum finalize_object_file_flags {
 	FOF_SKIP_COLLISION_CHECK = 1,
diff --git a/object.c b/object.c
index 4669b8d65e..9d2c676b16 100644
--- a/object.c
+++ b/object.c
@@ -6,6 +6,7 @@
 #include "object.h"
 #include "replace-object.h"
 #include "object-file.h"
+#include "odb/streaming.h"
 #include "blob.h"
 #include "statinfo.h"
 #include "tree.h"
@@ -330,9 +331,21 @@ struct object *parse_object_with_flags(struct repository *r,
 
 	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
-		if (!skip_hash && stream_object_signature(r, repl) < 0) {
-			error(_("hash mismatch %s"), oid_to_hex(oid));
-			return NULL;
+		if (!skip_hash) {
+			struct odb_read_stream *stream = odb_read_stream_open(r->objects, oid, NULL);
+
+			if (!stream) {
+				error(_("unable to open object stream for %s"), oid_to_hex(oid));
+				return NULL;
+			}
+
+			if (stream_object_signature(r, stream, repl) < 0) {
+				error(_("hash mismatch %s"), oid_to_hex(oid));
+				odb_read_stream_close(stream);
+				return NULL;
+			}
+
+			odb_read_stream_close(stream);
 		}
 		parse_blob_buffer(lookup_blob(r, oid));
 		return lookup_object(r, oid);
diff --git a/pack-check.c b/pack-check.c
index 67cb2cf72f..46782a29d5 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -9,6 +9,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/streaming.h"
 
 struct idx_entry {
 	off_t                offset;
@@ -104,6 +105,7 @@ static int verify_packfile(struct repository *r,
 	QSORT(entries, nr_objects, compare_entries);
 
 	for (i = 0; i < nr_objects; i++) {
+		struct odb_read_stream *stream = NULL;
 		void *data;
 		struct object_id oid;
 		enum object_type type;
@@ -152,7 +154,9 @@ static int verify_packfile(struct repository *r,
 							type) < 0)
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
-		else if (!data && stream_object_signature(r, &oid) < 0)
+		else if (!data &&
+			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
+			  stream_object_signature(r, stream, &oid) < 0))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
@@ -163,12 +167,14 @@ static int verify_packfile(struct repository *r,
 		}
 		if (((base_count + i) & 1023) == 0)
 			display_progress(progress, base_count + i);
-		free(data);
 
+		if (stream)
+			odb_read_stream_close(stream);
+		free(data);
 	}
+
 	display_progress(progress, base_count + i);
 	free(entries);
-
 	return err;
 }
 

-- 
2.53.0.536.g309c995771.dirty

