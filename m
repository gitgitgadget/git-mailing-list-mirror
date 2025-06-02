Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585F20C489
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860053; cv=none; b=ufiUaZ3rFOHbb+cs+d35W7vhZCYRUuRlkKcTlK/YaxZtpbEqliNU9K4NUb42o8To0FI8MLCbau1EUVGXp0kLZUGTdhxCLCTK3DQjKFXLyXxpaOA0fd3LS8Veb6txIo3Y5LSb+cw+AFprPzjih7jG8hczI/dLAlHrfVN5U1rRUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860053; c=relaxed/simple;
	bh=mcXi0QyUBURiMLPnJ7Z5soTcE+htsbOpt6S7huXTiVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UolVoNE5hwPCHqufEkT59xngM5IUJOo6I3Bnyn+yGQmAe8rzB/fTMFddt5GXInKWfz0CcWJOK63dem8w/iiYxjCoeA48wS0tBEu2uRyB9hk4SMF7oigRsxf8tUSyDcxJNgu5bUnd2dWZA9h8eMBgU8XYV/nudEunEgHy5Avb5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZQNnxYwb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XoZAEWoM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZQNnxYwb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XoZAEWoM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B08C51140157;
	Mon,  2 Jun 2025 06:27:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 02 Jun 2025 06:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748860050;
	 x=1748946450; bh=cBhUK+AH+HwMn4l8dsF5clkVTjHttT2XlHVIntXsUro=; b=
	ZQNnxYwbzWiURwv6kk0IEK1xAvIaiFzyegfNMxOWxV11urO9BzpioyaIY/2PpDgz
	a+Kl8QJmf+jOV746LJq/7h1NSYuhzY4n355X3PYv89IinBsExwUSY3qZbrVXQc2Y
	Sy6oT+RIoKvqJZqDQDHtF4DbXOAXYe6Gnt9G+xWBl+Lf/pdbnmgayzLijfsyWkCZ
	vAb/tqtvOop/DKfIQtBeUWskcXesYsSzglP3Rt6jqjG4NFVjx45O4HMmfPadig+6
	o1VuZ2SncV6OUrS/s3revTLQpN2Vro7aNwB8snP9lMKdJV3Aandp6WRyoKaTeKL0
	Ehfm4pLivLl5lBF84o0rmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748860050; x=
	1748946450; bh=cBhUK+AH+HwMn4l8dsF5clkVTjHttT2XlHVIntXsUro=; b=X
	oZAEWoMVtBD/hWU7yZmMpI58ISYzbUgLtcjLsoHe0p4e4sO1y/XqcmoQdx+d+5cq
	nUR3iYLDib2RpN9sT9MgsBn87/JyRYq1TnQNd6h1Skzcc69cQPaRiWgmSXc3IXJ2
	PuaRwKfMHtK+NeNepwu2IIaWCWJ5fbhLqxdwDVaYDx6WVBw1gJweajd4OBTprpN6
	ji2bf4WB0l9Ud+hzCKyXZ0uKOCWAW0kUjL9AnB+Rzt0R08dM/3bQTVM2e2FOGBgx
	XbRB90ryvZMOvmcb/hJsU2LxfglOLkG1OdDClpS3/bYQkAt2p/CYgafOp2hN8NSb
	iT/in+AYqrG+vBpXmdZkA==
X-ME-Sender: <xms:knw9aPBp9wOSMeFbDUTLZCSSNmW1sY7sgjvw22uz8viYjQZxtNxFRQ>
    <xme:knw9aFjXuwqkG9NZssgDr3mYh3fE9rPmmf0tbi3a2Abv_BVogJ3E2nhMJmWB5f64l
    vEFwLdRHWMlf1m93Q>
X-ME-Received: <xmr:knw9aKkY9CF5vwwinurhJUsSE2RRC8ncy6BdwndIgz92YH5iORVhCyXw9wJodzImqHaiAZyZqYxAZJutQCAJbDsz6VTW0bgsFC88LVB_z7emRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:knw9aBzCxVEhcX8oso_TKWnTy503pgmxINVlHccM66Zcr-PMtn2wFA>
    <xmx:knw9aESSrPPMysIYeBDq3gZWMwZLPxrjZcpaOWMs-1s9dgmyAWUbtw>
    <xmx:knw9aEb7eRsr303DMj4FfFFZ5iBYn_eWrev0lrcSh1j-_D7vsl8zpw>
    <xmx:knw9aFRy1hXzdQ-b4Y6MwQnIGK3qiLfukE4PIaxDLeaLR2psvp4OfA>
    <xmx:knw9aOayQ60UPVPQ1b4AKj7LufLwLuqo-t32maTXneW1Y3BECFBu2xTd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:27:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c757c3aa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:27:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 12:27:13 +0200
Subject: [PATCH v4 12/17] odb: trivial refactorings to get rid of
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-object-store-wo-the-repository-v4-12-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
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
index 793903cb046..a13b9ecbbc9 100644
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
2.50.0.rc0.629.g846fc57c9e.dirty

