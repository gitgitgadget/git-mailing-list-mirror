Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562452045B6
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106030; cv=none; b=KXXb0rZGxLAyvapY4ZK1QooqNRqxeYqfvznJDAFtWV6AZXTlSA5zYNkHYX2MAhx3YPNfu2kWJ6Cc/oxLgmFlax/ZdNC7tkrX0J0UH9aQ7STRGewQOF1YZv406xYPZfwDRtU5hwUPEDZ/JJU/DUZ6SRXO252Wa398P1EUL+mBMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106030; c=relaxed/simple;
	bh=RS0QO6ggIq/UK07v4nzXFCeawAZApH7DYVJSiDRYPGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlslaFyCvYSaMPcZ0JvnIQ4Wp18+Iy9ib805GxnLZ2V6LEYtshNSdazVGkqYZdtc1JBpprjOHTbYun6rn4aWW5dhYWALIucI5Qs9F2Y+thxJtlWmi82NxC/G6YGOhqtGQACUxAlcj/CervneuZOQvgm6hpB+6B6bsERJxYef7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X3hWmen0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFb9Pj3H; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X3hWmen0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFb9Pj3H"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DB9E11400DF;
	Thu,  5 Jun 2025 02:47:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Jun 2025 02:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106028;
	 x=1749192428; bh=Bl8K/NoGysWQ6UHzqJNTs69aFC+7N7OhfuZYRBf2LWE=; b=
	X3hWmen0ZMn3gUR32diBmX/eIIi7MnkS6ayz8dCwTra+DDwGjow2RxqV5/dDNRYd
	AfrH3rGQHnXMOJInT5eZ82CS3bHrCTw8ptG4TFtkOLaPJEo2ueu1Dok4yZ7rvFTY
	hXJVqOW33467m0gc6U6oKeVjG6TTQ+vEmG5ZvFGHcUHSQ/YJuhEGSXTYozdWZmdU
	mDQrnJcUVDBM66CVYScTwZxuCsTO4AJ/eO2FpVMl1xtmLbbgcLND2ycHHttEqvvW
	J7voK9Y77LAyaQm/CpWLh2kkRhAJkvOnYOZygDbA6HItXr9uWsvasdtAeDtoBWNg
	jA87W0te9JkvmNKWs1Pl4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106028; x=
	1749192428; bh=Bl8K/NoGysWQ6UHzqJNTs69aFC+7N7OhfuZYRBf2LWE=; b=Z
	Fb9Pj3H+ZAQJYTMshJaF886NJMffXnIEmb2AdFz7xrVquVzre6uaQYm6h5wbU2Hx
	XvfZu9M57e77NArAvQYQVqqbONny48fZLEo2E1Ssh274jhiR5Y1DuD8XifXBYNFn
	QEzaRuK2d9OiqsFsCuGAWq27HozAc75fhZlkU8yfvBvaWe6FSF20P8+uUrVnlvf+
	CfRMlUfGw3pWcJ5Oa2H83h9+miP70UH1/9XEAA9vRx9dhoaUGrkqjT+uS5TvE/wy
	pxuC8P4+GQJM82yLaP+Oe+BneAROnSw+BdMGWLQckDCG7qWMMDW3qTKUoril7qD5
	TzV1hYWwZt3ONjidb7XgQ==
X-ME-Sender: <xms:bD1BaFk1PpP1_8YImsil8221C_pR-asVYOEyEgnQNPkYsjkN3PzoIQ>
    <xme:bD1BaA3JbDlvtFq7DGfY3LvvNDkBJqIr63ULNOz6DoZYBf9f9Qh-9asuojQ4xM795
    jCxXRyfgtp5JtomEw>
X-ME-Received: <xmr:bD1BaLqgT8Vash1sfKFyks9cylH2b2uPKuK879GejhOt1Xb_MkPo22wXiXa9T_VBes4lN9Hsbgt6LCtrmYwegXrIMl9hZc3m7NQ-5RbTSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bD1BaFn3qUngDMYB6FdiQrAtkWhHO_2iNswZ-T5xkxI98N12yFzbPw>
    <xmx:bD1BaD0L6IGv3m5kvt19YhHtWsoYd_AUZtHK1z4piqyLpofrCxF1mA>
    <xmx:bD1BaEszCI3AXX_O6skRVvFLYYCehnzMfxjjdqV2il-Q4Y-b2DxnuQ>
    <xmx:bD1BaHXKVDBi36r_C-rV_KyYNFiH3MjmvigiTvCjT8K404K-uP_Owg>
    <xmx:bD1BaNMttSAWKC2j5m-cOpEYYnzm1TSA-2IfhMF056tkFu0DGAOm7aJN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb99438b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:47:02 +0200
Subject: [PATCH v5 12/17] odb: trivial refactorings to get rid of
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-12-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

All of the external functions provided by the object database subsystem
don't depend on `the_repository` anymore, but some internal functions
still do. Refactor those cases by plumbing through the repository that
owns the object database.

This change allows us to get rid of the `USE_THE_REPOSITORY_VARIABLE`
preprocessor define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/odb.c b/odb.c
index decf261dec6..d6ca5b92ab8 100644
--- a/odb.c
+++ b/odb.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "commit-graph.h"
@@ -476,12 +474,13 @@ void odb_add_submodule_source_by_path(struct object_database *odb,
 	string_list_insert(&odb->submodule_source_paths, path);
 }
 
-static void fill_alternate_refs_command(struct child_process *cmd,
+static void fill_alternate_refs_command(struct repository *repo,
+					struct child_process *cmd,
 					const char *repo_path)
 {
 	const char *value;
 
-	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
+	if (!repo_config_get_value(repo, "core.alternateRefsCommand", &value)) {
 		cmd->use_shell = 1;
 
 		strvec_push(&cmd->args, value);
@@ -493,7 +492,7 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 		strvec_push(&cmd->args, "for-each-ref");
 		strvec_push(&cmd->args, "--format=%(objectname)");
 
-		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
+		if (!repo_config_get_value(repo, "core.alternateRefsPrefixes", &value)) {
 			strvec_push(&cmd->args, "--");
 			strvec_split(&cmd->args, value);
 		}
@@ -503,7 +502,8 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 	cmd->out = -1;
 }
 
-static void read_alternate_refs(const char *path,
+static void read_alternate_refs(struct repository *repo,
+				const char *path,
 				odb_for_each_alternate_ref_fn *cb,
 				void *payload)
 {
@@ -511,7 +511,7 @@ static void read_alternate_refs(const char *path,
 	struct strbuf line = STRBUF_INIT;
 	FILE *fh;
 
-	fill_alternate_refs_command(&cmd, path);
+	fill_alternate_refs_command(repo, &cmd, path);
 
 	if (start_command(&cmd))
 		return;
@@ -521,7 +521,7 @@ static void read_alternate_refs(const char *path,
 		struct object_id oid;
 		const char *p;
 
-		if (parse_oid_hex(line.buf, &oid, &p) || *p) {
+		if (parse_oid_hex_algop(line.buf, &oid, &p, repo->hash_algo) || *p) {
 			warning(_("invalid line while parsing alternate refs: %s"),
 				line.buf);
 			break;
@@ -559,7 +559,7 @@ static int refs_from_alternate_cb(struct odb_source *alternate,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
-	read_alternate_refs(path.buf, cb->fn, cb->payload);
+	read_alternate_refs(alternate->odb->repo, path.buf, cb->fn, cb->payload);
 
 out:
 	strbuf_release(&path);
@@ -677,7 +677,7 @@ static int do_oid_object_info_extended(struct repository *r,
 		if (oi->disk_sizep)
 			*(oi->disk_sizep) = 0;
 		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, the_repository->hash_algo);
+			oidclr(oi->delta_base_oid, r->hash_algo);
 		if (oi->contentp)
 			*oi->contentp = xmemdupz(co->buf, co->size);
 		oi->whence = OI_CACHED;
@@ -763,10 +763,10 @@ static int oid_object_info_convert(struct repository *r,
 	void *content;
 	int ret;
 
-	if (repo_oid_to_algop(r, input_oid, the_hash_algo, &oid)) {
+	if (repo_oid_to_algop(r, input_oid, r->hash_algo, &oid)) {
 		if (do_die)
 			die(_("missing mapping of %s to %s"),
-			    oid_to_hex(input_oid), the_hash_algo->name);
+			    oid_to_hex(input_oid), r->hash_algo->name);
 		return -1;
 	}
 
@@ -797,8 +797,8 @@ static int oid_object_info_convert(struct repository *r,
 		struct strbuf outbuf = STRBUF_INIT;
 
 		if (type != OBJ_BLOB) {
-			ret = convert_object_file(the_repository, &outbuf,
-						  the_hash_algo, input_algo,
+			ret = convert_object_file(r, &outbuf,
+						  r->hash_algo, input_algo,
 						  content, size, type, !do_die);
 			free(content);
 			if (ret == -1)
@@ -944,9 +944,9 @@ void *read_object_with_reference(struct repository *r,
 		}
 		ref_length = strlen(ref_type);
 
-		if (ref_length + the_hash_algo->hexsz > isize ||
+		if (ref_length + r->hash_algo->hexsz > isize ||
 		    memcmp(buffer, ref_type, ref_length) ||
-		    get_oid_hex((char *) buffer + ref_length, &actual_oid)) {
+		    get_oid_hex_algop((char *) buffer + ref_length, &actual_oid, r->hash_algo)) {
 			free(buffer);
 			return NULL;
 		}

-- 
2.50.0.rc1.591.g9c95f17f64.dirty

