Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B21DDA0E
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417861; cv=none; b=YvbqhcmxOV7NNfE0tINlMX7GMss4OGAyDExyYvTJAVQ8EpJ5ATeqiKXsj+FeEqZgZl+yMM6v6nVsTnoVw9MDeAdhgkAz/RVO1f1i5QkJcX9xYwmZIUzbmVpDQ6fu70cnLTwGjpVp2wCI8MkF1zzw80c39hZso9+HkaX1b5/v4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417861; c=relaxed/simple;
	bh=ZIIsYwzS0kCr64PVcNtObQ3wmpPUIqfOBjr4XGzKb0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6p0WCXNCobmwnSttexGsdqXp1DTXxyX6OCLHukZqMYqR+b1EvWo4HpmSyIHEi/2s50hspE2aBzNkpzVzKT8nppvIvYST082svbvSNBCGyYZ85joShrSnbBGhKwBBFvSqX716u/u5EIx84re2fvNmIgW4A71/hX9wQpbed6+xmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h99cenEz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPWLz7ml; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h99cenEz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPWLz7ml"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1456213801D7
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 17 Dec 2024 01:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417859;
	 x=1734504259; bh=zKaaoGZNRdpfntIS9+sYcHuin6fsO3x1M/Ys0n9Z2gE=; b=
	h99cenEzU0Lu2/AIUBzPeUF0vtkitpDcGWDrWRnKaBZeSragFA7lm2eXVGtSok+V
	4R5dPhUrkdiIP0KqReIh/5msNGOAbL9ocRj1Q6+5xYGDw3mYfgkcNXg2LCUlG9gx
	vUDLpIxVSEGcvxMAELWwT2M5mWtCrqLdaAIxz/eKfI8C7OTqe/hTod6ISs+16Zvd
	rQUB3JLC6QlUS/+mJKtLRriA8z6V/ypcphJPATMklo5sOUkD3tRaHn27TNXz4GAQ
	X6tjgU2ymy4SxJdViF6H2XTvmr3ADVvrjGzkHVkvngA5a5gMMCQXjZKZ1butkYA+
	UORdb8yH0+WcCW5U5zoMSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417859; x=
	1734504259; bh=zKaaoGZNRdpfntIS9+sYcHuin6fsO3x1M/Ys0n9Z2gE=; b=U
	PWLz7mlE5gcBrM3KJ+BhsvWZEQkZVNfsRrxhTJWC0Ql/ZWg8BEtp/iJBjdSLN0sD
	1AcdQXDUvlbJy74dHkpwk8ksUunyg07jvhEesyRP9mtNYXrUCvCWl70x/ZUwHBPh
	JjLfFStF0xOr7ctoWylZXu7kCi20jzvto2QPn+HJcoUVYKXVNazgfkxQ20e59Y1y
	JPe9xdFpBwKbY15RG1x6OapF4cBUNa7YIv3vuLN5NzHppPyiyHUs6c/arHCZZLQf
	Tm7dMJLtc1Viz6DKYGqCMChH2IXWhbCrgAWIzjR3m/+uqewqkLjjvm+z8RxwuNZq
	14YDzsyPmXlg7/rYFms4w==
X-ME-Sender: <xms:wh1hZ9ln8G1l_Hmp4MSkZTYZsivfQj3DzE10onDhNTODRuH-LlRGiA>
    <xme:wh1hZ41Jq_6t_D1CMJnzcIcuS0zjro5fYxQK52gywXXuIglNFbEvqtY84EKodM3a8
    Pr39FUeFKhTSkItEw>
X-ME-Received: <xmr:wh1hZzpXX17k8-lPV8H8KSbCkYVRYuLy6lCtYk22Jw5jR-xeHGN6aGfOw3lUDUkAb5_GfyVdB-WSu8_z4eHGdWHOXDLy85ow4gtWag74JQaNLT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wh1hZ9mrUdHNYgCOOGCh6D25Zyaukh1ZPIn5vb1-faqSPz0JLBdDoQ>
    <xmx:wh1hZ73lelYRQp2HusR3VMx-NhF9Kiq-BcZtS1R1To_Jiotqyga9yQ>
    <xmx:wh1hZ8s73m2RsMqYa2mHKCE23aqgmH0vaqfzrdjBB2jsoBOcw9l-0A>
    <xmx:wh1hZ_VoGQ3oRJHNf6pVaHtlHSoBm8hjnGPhRCNgaWF-bfb9qQJm3g>
    <xmx:wx1hZ0_59m1SXp1T56aEZSuL51JXaHZ2HhGgxgdz8ciThgsxh8jP1q2x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 060afcab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:53 +0100
Subject: [PATCH 06/14] server-info: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-6-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "server-info" subsystem by passing in
a repository when updating server info and storing the repository in the
`update_info_ctx` structure to make it accessible to other functions.

Adjust callers accordingly by using `the_repository`. While there may be
some callers that have a repository available in their context, this
trivial conversion allows for easier verification and bubbles up the use
of `the_repository` by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c       |  2 +-
 builtin/repack.c             |  2 +-
 builtin/update-server-info.c |  2 +-
 server-info.c                | 40 ++++++++++++++++++++++------------------
 server-info.h                |  4 +++-
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c2e9103f112c1e37e9f030308633daf49eec1ecf..191b5eeb34e6791776f93a3a9509efa887e4e087 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2628,7 +2628,7 @@ int cmd_receive_pack(int argc,
 			}
 		}
 		if (auto_update_server_info)
-			update_server_info(0);
+			update_server_info(the_repository, 0);
 		clear_shallow_info(&si);
 	}
 	if (use_sideband)
diff --git a/builtin/repack.c b/builtin/repack.c
index 0c6dad7df47a1665026a348921c33b2067b59976..81d13630ea41f832bd0210971c13a82a3ddc0971 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1565,7 +1565,7 @@ int cmd_repack(int argc,
 	}
 
 	if (run_update_server_info)
-		update_server_info(0);
+		update_server_info(the_repository, 0);
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
 		unsigned flags = 0;
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 6769611a025d0d69bcd3dbbd06f5fed056262911..47a3f0bdd9c3498808b86c2e31f4489926226102 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -27,5 +27,5 @@ int cmd_update_server_info(int argc,
 	if (argc > 0)
 		usage_with_options(update_server_info_usage, options);
 
-	return !!update_server_info(force);
+	return !!update_server_info(the_repository, force);
 }
diff --git a/server-info.c b/server-info.c
index ef2f3f4b5c7b04c46520b2fd9d4352b806658f40..31c3fdc118447d42745362935e3483c59b7e0bc2 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -18,6 +17,7 @@
 #include "tempfile.h"
 
 struct update_info_ctx {
+	struct repository *repo;
 	FILE *cur_fp;
 	FILE *old_fp; /* becomes NULL if it differs from cur_fp */
 	struct strbuf cur_sb;
@@ -73,7 +73,7 @@ static int uic_printf(struct update_info_ctx *uic, const char *fmt, ...)
  * it into place. The contents of the file come from "generate", which
  * should return non-zero if it encounters an error.
  */
-static int update_info_file(char *path,
+static int update_info_file(struct repository *r, char *path,
 			int (*generate)(struct update_info_ctx *),
 			int force)
 {
@@ -81,6 +81,7 @@ static int update_info_file(char *path,
 	struct tempfile *f = NULL;
 	int ret = -1;
 	struct update_info_ctx uic = {
+		.repo = r,
 		.cur_fp = NULL,
 		.old_fp = NULL,
 		.cur_sb = STRBUF_INIT,
@@ -152,7 +153,7 @@ static int add_info_ref(const char *path, const char *referent UNUSED, const str
 			void *cb_data)
 {
 	struct update_info_ctx *uic = cb_data;
-	struct object *o = parse_object(the_repository, oid);
+	struct object *o = parse_object(uic->repo, oid);
 	if (!o)
 		return -1;
 
@@ -160,7 +161,7 @@ static int add_info_ref(const char *path, const char *referent UNUSED, const str
 		return -1;
 
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(the_repository, o, path, 0);
+		o = deref_tag(uic->repo, o, path, 0);
 		if (o)
 			if (uic_printf(uic, "%s	%s^{}\n",
 				oid_to_hex(&o->oid), path) < 0)
@@ -171,14 +172,14 @@ static int add_info_ref(const char *path, const char *referent UNUSED, const str
 
 static int generate_info_refs(struct update_info_ctx *uic)
 {
-	return refs_for_each_ref(get_main_ref_store(the_repository),
+	return refs_for_each_ref(get_main_ref_store(uic->repo),
 				 add_info_ref, uic);
 }
 
-static int update_info_refs(int force)
+static int update_info_refs(struct repository *r, int force)
 {
-	char *path = git_pathdup("info/refs");
-	int ret = update_info_file(path, generate_info_refs, force);
+	char *path = repo_git_path(r, "info/refs");
+	int ret = update_info_file(r, path, generate_info_refs, force);
 	free(path);
 	return ret;
 }
@@ -284,14 +285,14 @@ static int compare_info(const void *a_, const void *b_)
 		return 1;
 }
 
-static void init_pack_info(const char *infofile, int force)
+static void init_pack_info(struct repository *r, const char *infofile, int force)
 {
 	struct packed_git *p;
 	int stale;
 	int i;
 	size_t alloc = 0;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = get_all_packs(r); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
@@ -340,33 +341,36 @@ static int write_pack_info_file(struct update_info_ctx *uic)
 	return 0;
 }
 
-static int update_info_packs(int force)
+static int update_info_packs(struct repository *r, int force)
 {
 	char *infofile = mkpathdup("%s/info/packs",
-				   repo_get_object_directory(the_repository));
+				   repo_get_object_directory(r));
 	int ret;
 
-	init_pack_info(infofile, force);
-	ret = update_info_file(infofile, write_pack_info_file, force);
+	init_pack_info(r, infofile, force);
+	ret = update_info_file(r, infofile, write_pack_info_file, force);
 	free_pack_info();
 	free(infofile);
 	return ret;
 }
 
 /* public */
-int update_server_info(int force)
+int update_server_info(struct repository *r, int force)
 {
 	/* We would add more dumb-server support files later,
 	 * including index of available pack files and their
 	 * intended audiences.
 	 */
 	int errs = 0;
+	char *path;
 
-	errs = errs | update_info_refs(force);
-	errs = errs | update_info_packs(force);
+	errs = errs | update_info_refs(r, force);
+	errs = errs | update_info_packs(r, force);
 
 	/* remove leftover rev-cache file if there is any */
-	unlink_or_warn(git_path("info/rev-cache"));
+	path = repo_git_path(r, "info/rev-cache");
+	unlink_or_warn(path);
+	free(path);
 
 	return errs;
 }
diff --git a/server-info.h b/server-info.h
index 13bbde2c55fafe7bf07eb38377cec2f109de3164..e634d1722bdfaaa506777b4df370d908b05005e9 100644
--- a/server-info.h
+++ b/server-info.h
@@ -1,7 +1,9 @@
 #ifndef SERVER_INFO_H
 #define SERVER_INFO_H
 
+struct repository;
+
 /* Dumb servers support */
-int update_server_info(int);
+int update_server_info(struct repository *r, int force);
 
 #endif /* SERVER_INFO_H */

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

