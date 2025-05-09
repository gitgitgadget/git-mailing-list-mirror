Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A129672D
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799948; cv=none; b=QmIiXVWb3OUI43LZiz1W+mlCrIHxC3AfwcCqDWXUjFS+g5b76PSo0dOBspO3eiaZzYuEEMkAHlKQ71Ohx+yk1HuGUFlGvOtK5EF8FeNoFMgw/xcKDd5ulJfRGBWZ32YEpyNCQ1zbxi0ngjtAdmhlydhXKqI6Z2izrsWR50EqUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799948; c=relaxed/simple;
	bh=wDfP1aE6N4gQEfMTXFk+NQUptQIcFcq4EpSQRRZlCqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAh6DwJvB6aWdJDc+KZ6V4RNUashklr++7x7SMczS0dOH4/qT7uGba7HEzXHAGMsnio9VnEP6JwCfTqerFIp/vwpjlMFI7yHfoD4Q2/YfMSdTXmrhICJ3NwWMMuWom0GuJYAazkxo8FmAOy6uLc4Lj2P77c1NSk3B5TyN3e6e1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S07KQXdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kYEhqeY4; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S07KQXdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kYEhqeY4"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E8E5D1140126;
	Fri,  9 May 2025 10:12:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 09 May 2025 10:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799945;
	 x=1746886345; bh=GoFlo0Ve5ixKGVM4AvAJV73QQ++dUzAvL/LqPf84GIw=; b=
	S07KQXdZhIvzc/DBoeg7s4G27C0J0+GDPEap8iEUiFCsX+DvSDVvDiEeuTaNO8zJ
	Ioz/BYpgYkT5pAR/5YRtIwFUpw38SJVDs0JWz9EzLnT0ddhrd0+8L8ApOI/xBipC
	ajKYItgUoXbCin7kVhkObAahpGY4hzvp1U/sV15ZPQFYGWwEp4HwQMJ3EwSoCU7v
	wUP2fmZ8qfvuCWEd5I3yq1S+ySQPw0uI6Lh0NfIrhJ+pQXNQMDKhCinaMopL82At
	4uvSHcHWYpWoYDEoqLvDyv62fN/JsOeHLnWj+c3lLWY0RmeL9UmFouKmjHlYpWJC
	BBBCJgwB6arQaBb/LhVTYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799945; x=
	1746886345; bh=GoFlo0Ve5ixKGVM4AvAJV73QQ++dUzAvL/LqPf84GIw=; b=k
	YEhqeY4Vqjbrh6cKC8raBicJuzqBsoFNBqj7g4iXFMpuyXcTmXBhKaYSrRDga472
	q0IyiCV3NUM2UMGD7vdF2L2cIapSMyAx6IcvHiStNjzMwO38Ev8VS1sXziA6f7Py
	i6u0YFWIE0Xh59W1/JKkvQrDQO+z9mZLipm8iMOdr5UYKGutni5UWiF8+FOYWmJt
	/lu7XoItk4XHnW6lZ6rZqKmOL3ZV7YuA2y2jNcCX+XiDow1SC1HDJ8ahdspfBbWK
	d65UPZ0AKMKCRCz2/oAvPhg72AfaZpy4RkptaImv0MXRnXEDNzXFSlLgGtLI8hCK
	+hJRAZ0aCjPBwWrgY3CMA==
X-ME-Sender: <xms:SQ0eaE7OBfdUp1jA0i_dc9QwtaWfmucs8FLlfKcG1mdNnMasSvpZww>
    <xme:SQ0eaF4HsYAPm5XrKp19Y9FM8qBHMeouFPjbEsLcalmw7chEP_V0K_i-Vf94r9UY0
    ebru6UkgupRiEk-8g>
X-ME-Received: <xmr:SQ0eaDfvBh7kWHmrx9qA1akkcauAfOyCBQECurtsfO-o2bCcc7xQ4mHEjChqQ3Ka9gd8fyZdw_ek2Jy3OmitH9SFqF7KGW6PKh7vNneLgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SQ0eaJKwdoHcHC3fv56MtUaLCHefK5y6Uf5KwoglS9UoGVwgRLh8DA>
    <xmx:SQ0eaIIeCGHEjqJuJ1qIh9M7gntExe6cSVU7XpYwCpdjA3_gtg2fPg>
    <xmx:SQ0eaKxlnPi3d_wbpidUMRVlc99ZMicgHI7RCRYpiFMRxf8jHYS-vA>
    <xmx:SQ0eaMJjHbNPICuaC64NPg_Tjwi3ujAevrI57lrytFijiHeZnpgVLg>
    <xmx:SQ0eaJkULsW6xIeu3o28GoG8LaOhmgKHxtZItrDN3Jlv-QvzCElxAmg9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4adddbc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:12 +0200
Subject: [PATCH v2 12/17] odb: trivial refactorings to get rid of
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-12-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.49.0.1077.gc0e912fd4c.dirty

