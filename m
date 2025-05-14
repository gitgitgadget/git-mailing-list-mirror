Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67561FECAF
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199564; cv=none; b=SVEM1OcvstuH1NgZg0ji4+oNu6aHTBOAnpZ9SSPkPgthc1feUsKFgQs4hrqrgmxK0j11zovcrKNce5G0/VNR03AB5oiICsL5TzKMDWwzfPcqwLkeOl9z2mttsqQDttd4VGw+L6aFq3JehM5VieTOHDJgoZPo+8jCXydR64zK/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199564; c=relaxed/simple;
	bh=u5EHOCQx17OFqyYaArxcyUbgvXMVCMMlxPmRVg1YfOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgpII7G6V6CUi05/N/wT4D56wfCRIRL+mW/7CCw8VU6aItVHQ5K7Fo4XTaTo6Ks9v/CVte1dBvD4mUJ/NfyaSrLt2tDmviOg/GIrg7pe3rSfSgNVsDf77/0hMnR8+1cNO1oZ+Wb9MIjn9yadXa+S+MkDegRfnfOvW5DojC9VKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CRPVgbmy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5CbKAHu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CRPVgbmy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5CbKAHu"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9631114013A;
	Wed, 14 May 2025 01:12:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 14 May 2025 01:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199561;
	 x=1747285961; bh=TJhwW/S7yxvWaspReinSccKpMYnXqweyV9nCo6CXuBs=; b=
	CRPVgbmynFDl0gj9VSJ0EpM3G6LizK0wCZoCtpKBtq/xHkbDKFVkLCvxyxP4OsT9
	Gj7dMIrsQa9d3dI29+2KSXY5SBYD0yZ5gTB7Lj9JTeXJfIGtv63H2Mymb9qNcvYo
	HMybwqksfMOPOk2ZtXVLL2aN2DNsTzdSyvQ3vDkkPnPgTgXId4e2G4g/0PR29uVZ
	4yzCECqooT0rUptVHKeME6e0aISVjDWAwWijBUPMlO+9X+OzpwtkUWQHgLOqvpNC
	1qIKUI6mPq9bAWYgjiYeb9d9+GqjZFWs4W3Bq5GyliJbyE365uXXOcHabm6Zw57M
	YUSBvhnLdtETYgYWIlat1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199561; x=
	1747285961; bh=TJhwW/S7yxvWaspReinSccKpMYnXqweyV9nCo6CXuBs=; b=S
	5CbKAHuun4ONX3McC0INIkXKUaeeC5pV7DWzU6Sf0BlO54S2K464oda6Pbp9W/y/
	oKerFYtBdtGW+7XIEUSp4GCpkpWZr5gdHFaMz8/nJXhTilKf3Cj8YNYPixHKgKeT
	hitfMl9GvoPVYLRzPTZnFxwXHD6jDrDsJkPVMb7WMlYu7obBn8ALfy6XqkDPOAvo
	0UIApbdutGIRGnCCQn7YLF3T3rTn22LH5a2X7P2vnjyxpkL62zeX76MIOn84AB3h
	WPdDEF2dVRaq2xiUVSN8rDFafKpvkcXE9dw/Vm3QGFB3GBMFKdadAliiCw8eDcy4
	KURe7iLGHFbO8Wpr502eQ==
X-ME-Sender: <xms:SSYkaKhKJ1SYgi2tthICkZz2mTRwDr39DJYsKCf8yebfcCI8CkF9Rw>
    <xme:SSYkaLDVo-yay1HeKa-XjcbVe0Agj0LtIfbT1z4uCY5SRkCtFvC9JcwE9c5gzxJ9j
    bMyhMGXzWc5-zc8Nw>
X-ME-Received: <xmr:SSYkaCF0Xok__oK76IFxRTtxBJt9ghrUHnW5MAAIbX4uNvPJHj8ZEtSmJVBnPQOPVkqifRFlM7frATgattGgQXZB_VMQrhqRNRMBxu833xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthho
    ohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:SSYkaDSE3EpevDNXRRrIXHWKP7PBd57jo9bM5aM52IYT0u5EIRfziw>
    <xmx:SSYkaHzG3jIbviP3zF9fA-dpSRZpleSop2B9GDvmDW9c6sszgS6yTg>
    <xmx:SSYkaB6HZNKiNuUXYCIPklf5zumI0EuSaXp7uJBP_60Qy9LSDQp1NA>
    <xmx:SSYkaEwNeOzz1z0eQcIjJ7FhsUUyWq0J4RUJPBEHzzbtkG52152gUg>
    <xmx:SSYkaF26GnsmEcnNa8hOyzXniiDhQx4ClfAq_mEx9P_Jm5byTr4vMxzZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d464bbe (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:35 +0200
Subject: [PATCH v3 12/17] odb: trivial refactorings to get rid of
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-12-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
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
index 72ff1ab5a7d..c150c01db4a 100644
--- a/odb.c
+++ b/odb.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "commit-graph.h"
@@ -476,12 +474,13 @@ void odb_add_submodule_alternate_by_path(struct object_database *odb,
 	string_list_insert(&odb->submodule_alternate_paths, path);
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
@@ -559,7 +559,7 @@ static int refs_from_alternate_cb(struct odb_alternate *alternate,
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
 		if (oi->type_name)
 			strbuf_addstr(oi->type_name, type_name(co->type));
 		if (oi->contentp)
@@ -765,10 +765,10 @@ static int oid_object_info_convert(struct repository *r,
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
 
@@ -804,8 +804,8 @@ static int oid_object_info_convert(struct repository *r,
 		if (type == -1)
 			return -1;
 		if (type != OBJ_BLOB) {
-			ret = convert_object_file(the_repository, &outbuf,
-						  the_hash_algo, input_algo,
+			ret = convert_object_file(r, &outbuf,
+						  r->hash_algo, input_algo,
 						  content, size, type, !do_die);
 			free(content);
 			if (ret == -1)
@@ -953,9 +953,9 @@ void *read_object_with_reference(struct repository *r,
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
2.49.0.1141.g47af616452.dirty

