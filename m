Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1732F170854
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008953; cv=none; b=lYo6bEBFddHJIA7vEaUAO9RwrqBruarRxqTFJN11Y12i2u7HTiMj+81Z1XmFuIeHQ9v6C93vojXL0zi1UJeFMY7Hx520huhFv4qydl+8T1sT4LdZE/muPgauSu5g5YvOTSFT1abcBttkgsP3DLT9i7azmaZILyLBRYUyny/N6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008953; c=relaxed/simple;
	bh=5X+j8eyuOqAQEYFSOsriBQk4lo0I4Mf0c4J1JiolNQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCtTRbK0/3GcirY8B8n6fwR0Fn8jovYraA3YCwxU8lgx62H4QHcJw+ILThhNhH2DfYqVYoC7vmSzaCgAvS45YOfjC2NoCpR4csMkaub+B8t0h1FMW1c8kUXuATwFt7wcrrboQB0EcGYZ9vNdamCXuS2tdPbfkPUkehkvg/VoCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ib5dIjG2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJ5el9Nt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ib5dIjG2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJ5el9Nt"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 40A281380277;
	Fri, 30 Aug 2024 05:09:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 30 Aug 2024 05:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008951; x=1725095351; bh=LPGrX3oUDl
	m6APvwDZROzJz9tu2SOxRkhVo649AlV7o=; b=Ib5dIjG25ne1r3MsR/wZv31pb/
	aansLYMt8P3K71sK1BBs6hriCazr/nhJVm3nn4MibcIrsmO8hdV6bIqpNXM7o4aJ
	851YCq7yb6XcTjcfbb1ZnINU18yck2zcZ2AaR3/pmMM+T9hEeDmtZSE5UvUxyET6
	SvsasKddYDFpMMUTQXLE4Y50rhCMPZ7y56uoeGD7LZ5sNcx5dtthIGpcnyHL8VmW
	G8DBJSK+C+1ZB+qKa9upAUhQaG7bIWcAxg2YU7yDu31Z93lNBB/kAqqVWVr1anDh
	SXJGy0Wb0jWoZ36rhZae+9HvOx60U0t68IZ7Xmtz0+CjFAjL0IX4QUVn7yqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008951; x=1725095351; bh=LPGrX3oUDlm6APvwDZROzJz9tu2S
	OxRkhVo649AlV7o=; b=AJ5el9NtelJSgxnVQheZyI2vyGbppvFgKBfCUE8d1YDJ
	QsBtc4SABRyxeRxKgmFf6TDIIe1H1HbNSdYE0WnoP6QUKIYkRX/pUZHChl27DFnw
	mzB1WVHUx++khCc1Pv0mjD9F8RbfeGYTPUpg4RKS+VglPreEs78ARkCV+ruAoGR3
	N5I+BIbJAO23F8n64HKaRHuJG+o7s/8uOswdCl2dQAUA9oa/Ug3derJQF4Na4WdZ
	zYsoik+wBDVomq1uIyhOvk74EeqQ5yyZ5U61cofeG5jxW+x0HiNsjtnSHK9maOLh
	Qb9VEBkJcHpg0Jk1KTS+Ro08yEnevNtW5AQ5BFnRCQ==
X-ME-Sender: <xms:N4zRZqh_8t1qkSqHMGjJtuWWjSQIwCigMXrqScbA2IEZdMeZl8Turg>
    <xme:N4zRZrBmxwVOmM9J88K5asbc7LNUCe9BipKioWHGG4AnP11rxg99Vk00XKGpdUaPB
    GkRp_FLGGRoFmiOrQ>
X-ME-Received: <xmr:N4zRZiExyd05epT8vSheDiNv-4rR2woguPy_6qEU1WuY-wvhDiiArJWAZCwejzwhjy9zSRc-wM0F2IACzsJizCNBcfNnh2H8yvOSW-IKmb_6Q0VIVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:N4zRZjT9HF7ioZ5arSpO4-gvjG1eKdTWxQgRlTUP1IiCU_x-818FTg>
    <xmx:N4zRZnxLCN4YIUXSULbt2HMBCFugNSNGTfXHS9DvNjr_Wjhd7UF-gw>
    <xmx:N4zRZh4okJyHYmLvsoIRqZeT_aA3hnSB0X8X693b6aacJV0TIe_90w>
    <xmx:N4zRZkyasZ88frIf-Mn9kqlC9Xmk5nPKbvWXitqYUOHQ5UEM8uirWA>
    <xmx:N4zRZpump7ohIkvShZiV3d6o69_24qi2ktyi8foR8Ps5z3G89_D906RY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49ec0036 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:08:59 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/21] environment: make `get_graft_file()` accept a
 repository
Message-ID: <1cc727e4763e7989a3a0474faae5fa730539737c.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

The `get_graft_file()` function retrieves the path to the graft file of
`the_repository`. Make it accept a `struct repository` such that it can
work on arbitrary repositories and make it part of the repository
subsystem. This reduces our reliance on `the_repository` and clarifies
scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/replace.c | 3 +--
 commit.c          | 4 ++--
 environment.c     | 7 -------
 environment.h     | 2 --
 repository.c      | 7 +++++++
 repository.h      | 1 +
 6 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 34cc4672bc1..01161350b1f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -11,7 +11,6 @@
 #include "builtin.h"
 #include "config.h"
 #include "editor.h"
-#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
@@ -514,7 +513,7 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 
 static int convert_graft_file(int force)
 {
-	const char *graft_file = get_graft_file(the_repository);
+	const char *graft_file = repo_get_graft_file(the_repository);
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT, err = STRBUF_INIT;
 	struct strvec args = STRVEC_INIT;
diff --git a/commit.c b/commit.c
index 3238772f521..1f710a92a17 100644
--- a/commit.c
+++ b/commit.c
@@ -292,14 +292,14 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 
 void prepare_commit_graft(struct repository *r)
 {
-	char *graft_file;
+	const char *graft_file;
 
 	if (r->parsed_objects->commit_graft_prepared)
 		return;
 	if (!startup_info->have_repository)
 		return;
 
-	graft_file = get_graft_file(r);
+	graft_file = repo_get_graft_file(r);
 	read_graft_file(r, graft_file);
 	/* make sure shallows are read */
 	is_repository_shallow(r);
diff --git a/environment.c b/environment.c
index 10ef77576c3..371f01a705d 100644
--- a/environment.c
+++ b/environment.c
@@ -306,13 +306,6 @@ int odb_pack_keep(const char *name)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
-char *get_graft_file(struct repository *r)
-{
-	if (!r->graft_file)
-		BUG("git environment hasn't been setup");
-	return r->graft_file;
-}
-
 static void set_git_dir_1(const char *path)
 {
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
diff --git a/environment.h b/environment.h
index ff590cfff73..d12c48481b6 100644
--- a/environment.h
+++ b/environment.h
@@ -1,7 +1,6 @@
 #ifndef ENVIRONMENT_H
 #define ENVIRONMENT_H
 
-struct repository;
 struct strvec;
 
 /*
@@ -106,7 +105,6 @@ int have_git_dir(void);
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-char *get_graft_file(struct repository *r);
 void set_git_dir(const char *path, int make_realpath);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
diff --git a/repository.c b/repository.c
index a9bbde80b5d..cdefcb4002d 100644
--- a/repository.c
+++ b/repository.c
@@ -119,6 +119,13 @@ const char *repo_get_index_file(struct repository *repo)
 	return repo->index_file;
 }
 
+const char *repo_get_graft_file(struct repository *repo)
+{
+	if (!repo->graft_file)
+		BUG("git environment hasn't been setup");
+	return repo->graft_file;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index 15660ac2f19..ad0f984b444 100644
--- a/repository.h
+++ b/repository.h
@@ -210,6 +210,7 @@ const char *repo_get_git_dir(struct repository *repo);
 const char *repo_get_common_dir(struct repository *repo);
 const char *repo_get_object_directory(struct repository *repo);
 const char *repo_get_index_file(struct repository *repo);
+const char *repo_get_graft_file(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
-- 
2.46.0.421.g159f2d50e7.dirty

