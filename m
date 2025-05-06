Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7327990C
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529772; cv=none; b=T1gfmkGLyTUbJNLsp/gyhaF3FlSjdtjOqd19YTxDN/YYbCzDV+dYjmkUAUApnkD4MPAGtMJqHKDi8J8G8qUFSXpcyyFCqTuoVDsGkp0JeyaEn+k/Uz6tYpmmbYeen+WsCvHjgG8cot/7qbUfD815ayyl7I1oBtxoDXY9tattAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529772; c=relaxed/simple;
	bh=ObLU/lXGoTC0HXfrexpg+BD/MiCbILn4SchNLFZyy6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8VGETBnSARIuPZ4v2xyAEwONC2aONRng5/x6Sf3aeOWgepcwtoaozmTESMLjh7Zd+b320F5ZlMucVVIdbuOgt+4AjgA8mqwI13x5/x1T9JNX9dOIAjx73jjm5aI+b05UJNGskjf7yHYQxC2HFGhLgT3idbLo+cBsvbWaQXgKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i0qnyC0B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qHSbivP0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i0qnyC0B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHSbivP0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D5C61140268
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 07:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529770;
	 x=1746616170; bh=+GQbaAZvBZ9YsivvAxYLDf5p5vexk9HViLKpYYvAvkU=; b=
	i0qnyC0BbBVCoFuoNYMEagEjqCFys8IX8eXhQN0stoZFtMC8ldm3bc9iZJAIcKYl
	t9jONDetjpstmUJ7RENh+U1j8H2n4bwQR59w/pzrdCy0e9T//Jh8HkpEWhO2RC8Z
	5YDxSbEW6gg69ilYOtB//ijEj1YJ22yhLJIpFYxzkOmEsxDmtOBMy4SiQlDA8F9Y
	2FRBTqbxJAzlLM1QRrBKW8tIThQfuK43RIjIdvWwRxh6snmqU4T6CuaBCwg3V+e/
	G2iafYHuh9pT6vnmAEeAqkJ2HcfC2/EKX6kwi+Vfum0yliSyC+OnEPE6zygHMgp5
	Tct6FUdj4A/XvbX1UsmWrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529770; x=
	1746616170; bh=+GQbaAZvBZ9YsivvAxYLDf5p5vexk9HViLKpYYvAvkU=; b=q
	HSbivP0rSSTCBh/k98mjpnglUdShBw84T7gOxjI7UI9vQlByHfs7q+QXCfz/YGEN
	O1XUpCf8eRxB2UgKjyhhvkigzQRSkktWGcDkXxHzkTNhbaMM8BDBS0KfeA+EO8Lh
	owkRAiLgoISEEEMV+URjPqukaNAZKALr9CRN3s1/oiIojRLCX2sajxYp8fxo1wUP
	LDFEcAdgAqDlGDGpUEQfjFlMbZJH5xaRw35+OsLj8yBM5S5k5duXM0dlfK9l4CZe
	0tbT6+xXeM3AzyrzV/uAUrT4W1bzDogkrNWrEZ6FPBEDOdaGQ7+wWSagLedR2gUh
	zJabBX9cVfLWsosXr+9DA==
X-ME-Sender: <xms:6e0ZaGYvli7cUBq5p41k9wwKEx3WNpcOmSCWbzyOVN2HhATL11-rBQ>
    <xme:6e0ZaJbuhTLqxwsAQC3xrbUWkxgLll4YgG2KMm_Jx2p4VxsfDnXzNU5gipasJfF0u
    S_yu5vk1VWAOAxwTw>
X-ME-Received: <xmr:6e0ZaA-yCdUDoRFJT09-imseAJcUgmeANJV9JX9stiMxmf1RMV4l2EanOffPCa8LjRUx74zqL_v7Stz7waCyPdlnynWGTKH0tl5kEoZq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6e0ZaIq20deKje0lFAa8hN3MH8P3piy6TTIPl-3aqULZKwQDjKwlEg>
    <xmx:6e0ZaBp5xn1niFvFLv2xhuZ6CwmmrNaRu7Y1mUfeY71IQ--rHhoLSw>
    <xmx:6e0ZaGSILY8LhevHGVEu2w5lJQNI-lKsEmOIu5yC19gLeUtoF6ksPA>
    <xmx:6e0ZaBp8usU9gSId2i1NZQGwVY1mQm8Vq2JAWkcIug65iJbCDmhefw>
    <xmx:6u0ZaM2NSQPvxqcd_PnTzaIpn2qjIVBeidEwPWh17m_FRbxVmYLQ4wem>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97f9e2b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:25 +0200
Subject: [PATCH 12/17] odb: trivial refactorings to get rid of
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-12-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
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
index bfdf36751e0..8901e3f43a3 100644
--- a/odb.c
+++ b/odb.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "commit-graph.h"
@@ -476,12 +474,13 @@ void odb_add_submodule_backend_by_path(struct object_database *odb,
 	string_list_insert(&odb->submodule_backend_paths, path);
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
@@ -559,7 +559,7 @@ static int refs_from_alternate_cb(struct odb_backend *e,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
-	read_alternate_refs(path.buf, cb->fn, cb->payload);
+	read_alternate_refs(e->odb->repo, path.buf, cb->fn, cb->payload);
 
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
2.49.0.1045.g170613ef41.dirty

