Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F927585B
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372584; cv=none; b=Ahgrgnw/dfBLzSGZgWB20nGOSgJMkun02kW5t0zq6Qj28enp5oKx1FwntWIvFxlO4TtnFh6rRGqWq9udJG3T69RkexzhRR0tj/ciPafdth7OH2qrNXa6EXQVtKbpeSVgO0IFDmm882DLvH9iMEhLvPqVuBNoTFRSEZ8XH9uDCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372584; c=relaxed/simple;
	bh=DKvDgva28w9Zy3qji6lRC7QabXAdTnOwLxdrA/l+JFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hpsp2+spnTu+3v9/NXMjGUGtR8cT6pMJ0gTScIppIrfqVmD09/K8OaJYlaHr3ggxX4MRTSiclIznt897IGYoCClwjyOHP5tHsvK6eEDWdF7lROm9Jy8Nkz51CFzbklhhe5Uqbkcv7dQnuwCq5kLG1BnE7QBwIOVdRzsrqMwhub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oFmOBseY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZbeaXzz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oFmOBseY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZbeaXzz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 46A00EC04E8;
	Tue,  1 Jul 2025 08:23:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 01 Jul 2025 08:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372582;
	 x=1751458982; bh=HsV4zMfGBOjCW4a127kCrbs2cAROR+aV2H2NaDDSCSg=; b=
	oFmOBseY1RPb7fAnqGsZc+pPYYR1AI24xMybtIac0kHK34WKuYyMbgeC+5FC0Nbr
	8qxtGkshmO9dc5udK05ur/hWblaLbp5HQ9pIMlwYHZpDQ2jfAmOFGxqb/zaJXPZc
	ths4dDezb+EIDvd3N1BTsdVJIiU1JCTg/F9dJO0Nx/DB+v+YJ7Q4YNpj0k87UtwQ
	xeENEpjdNa/iGePlxILTYudLGVpneDDV1n+yCOpm9mE80GEyTfvddNSTtJc/YtvX
	QBUXjBot/lx9svr9FH+GSFNRyfedEQLzHaHR4i0N7z4AlinLbTEEvcIihJod92aU
	gf492wbfpVEpOxCUrkyqfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372582; x=
	1751458982; bh=HsV4zMfGBOjCW4a127kCrbs2cAROR+aV2H2NaDDSCSg=; b=m
	ZbeaXzzHgY/1wholmj7PU+qhmEzZqCgKp/jJj19KTPfMiIn0o+xUx17EB9ozdBHN
	hWvcI2th8W17SZ7GNKQkB0vNTkTIqHr23NPyVflnMNKvl7AOKViGxmBX+84czuTI
	G88/2h/DVNv2uaittm/9J7GNEUKDKe5N6KhLshcTuyNOr/GJcm3kdZhliT/gz3d4
	pLByHMKGPgPGcuknY25B/pb2OAc7J/iX2s7A5h59t5Iq9yRzWJvwhZQh0csfi/SC
	q0itCI46ci90QqAzBvZ3jV08MKdYuV+QIPZV4988ePTuFR/3U8+5Fona0EqLwlsR
	xkp3XRiHqMrIgZu3Ismng==
X-ME-Sender: <xms:JtNjaEo8eIaKuOc5T5hCEUTWTId57JaIgxVRHlTjTp0d_qAEsDhhMA>
    <xme:JtNjaKpDik9ZLzugXKoB6Eh_QzRWeaIoHVeCKBtOpKcUJOOBkKP51Cxi2Z8doOD61
    wlPjF8g1Osk5pSzmg>
X-ME-Received: <xmr:JtNjaJPjwdo1AVJd2L_3HHPmPzECdLCRh5kkAM5CLE6BPxii83_wVbt7d_tmSPoY94dAw_0vakuqpmgXMDcVf9k6ZuNLahellspsCDYuKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JtNjaL5ja-Ffglxam8gEpqOLczYLMOVkuXJ5wWIaL-CDkuv04WBB2A>
    <xmx:JtNjaD7wwWmMhijn1EanJmkUF4uLs1BtQ12RcHjxMoFB2FoEFwNp_Q>
    <xmx:JtNjaLiaeQMtdQEepPQBcRUxLfU7AC5_4VT2QkPxFIsDItYNFeEonw>
    <xmx:JtNjaN7BBWAAvmfIWEq-u0KRZCNx3Pbk6lsvIASP0YmAW6i3ztRwag>
    <xmx:JtNjaGiZjOCwIybYYpknRtClon1iQJBv3d9Qq-i8XO-uD3holEcY0ykb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:23:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58d58989 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:23:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:24 +0200
Subject: [PATCH v6 12/17] odb: trivial refactorings to get rid of
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-12-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
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
index f0b27bd936b..5a88701550e 100644
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
2.50.0.195.g74e6fc65d0.dirty

