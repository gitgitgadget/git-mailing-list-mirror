Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE5C1A38C1
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140581; cv=none; b=CGax/hZAP03+qJ24i/uz+R/g2LvZsfd6LWtUtov9PRseocFDlT8RNXckMbggKk/4+yF3+cv3SXjax44lG6dYRWm5528g6FSztNuCqX/jvOMlkvpHO55IE1ygca75XYy1SE96e4zRgHG0zrcqf3Xlj70j1ryStVwHpNfOWCy4jk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140581; c=relaxed/simple;
	bh=f6BRkeTpZimyjiDuJXPzbGUGoUxtlnGK1GAAYC1whDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON2YA4ZcEV6E1MOWOVnUrix3EkEbGhMjfuGE7ot+228b1kZP/anU3QQNpkF93LAP/Jqdfu7DY8RqcjOvXQUPs20xzVpLTFSNkYNLJ4MgiNu2g28ho5eAzpczqQQ9l4DNpeNZjLBmzzzcl3CgpqdJnLcURv5XPqVPa6rNeJR5vMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L0PL2U3b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OmO2NWu+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L0PL2U3b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OmO2NWu+"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 66C63138061F;
	Thu, 12 Sep 2024 07:29:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Sep 2024 07:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140579; x=1726226979; bh=QVR71ChemU
	FytTnZNjFPkKU01RzVjIDtce8esukklHk=; b=L0PL2U3bQThos8jZsTN3AeLo+m
	+qF0tFKmtyB4aEkgej+hvpp0lli2VlMAw4YQ1jPRPmY04QZ69qvfK1Bnjl2mxKKz
	Cv288LaaqdThYqtgoZRoEI214vrk65PUI7jQvnZiBzgivmdvQ4PWwH4ge4WATlW1
	/wcl7WOJZ/UjRnUMB3LulGpJUZTNAaSFRK2LLuNNbuBjNeRtfZM/l9TGfSjC5H/Q
	HBElL+3zD5yJouUfUvtSNlQPnYyIRJBFu98q76tTNFngqBcmPPPIVM8Qn9/f7HI8
	4Ad+uhN3HPE+ZxPPirA67BeeaQwAUB2ynXKKTUGGDvvMcFH4CwInorm66C2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140579; x=1726226979; bh=QVR71ChemUFytTnZNjFPkKU01RzV
	jIDtce8esukklHk=; b=OmO2NWu+MY4ac7IVjZa4e7b7uW8lebQcbAs7kO7RMAmw
	yAltUUdl7qc/1kGYjJpwCNO+FNewXQjIOaSy/VnupnWTUayJcsfcuWVr6qMqM4S+
	4Qx3W8Em73vJ6K1sjOxaNN0Dv9BSuiylHqKQoCW7N2dSKZFfqIxcw6GPDYAtKGww
	dHOOrrxgfsgzSTTD8cvXxVyN+WH36PCoxwZRWphSx5KusSlIslftFv0JK8xTQTWa
	wbYFbFzUOrTxuhg+6QHXFzwTT+MQE8QcLDmf+tQxRKNmkRxe2nkMd/p70ETjM3dT
	+OdKgB99UhZX7MqzIDvZcSH0B/Gw0uzBTDgXHO8ldg==
X-ME-Sender: <xms:o9DiZp_p9pP8PZqf57_ZUKOUJ0FqqCISOU124dX3-MJIFwQt_uFQ2A>
    <xme:o9DiZttukF5vL3lVgtyXmP0q-gkYS_YkGzZJWGUgf2QcYxi5QUX3xFuVJXV-Z66_6
    YMJfpJLEWVPFU--kg>
X-ME-Received: <xmr:o9DiZnBNXBpMCf_gr5u7sEeVjKjkiIE1kt5Csqw1RCnCabkBP09cIEMJeo2MrqokBO8_uUGBPKvGPyLvtEnPYKzuS2l6fvVVMBKmxpDTNnE6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:o9DiZtcEA-93HWbSODPmO2F097Li0qeNuLhmfTHoMo5W8XFacqSn2A>
    <xmx:o9DiZuP9GZ-UvEugzEGGCATyl_adkc2jWU7FohseftdHEjhTYP7G0Q>
    <xmx:o9DiZvmnVYAyGdgeLNl8F37J2d0TcB-avpv8L81fuN8rKPFgTG2nNQ>
    <xmx:o9DiZovMi9OZieRuJk8mAK0EZ-Nx088ftihmq_Rt0XmgVMeOuLUNtQ>
    <xmx:o9DiZl0OIkRXUu0ClUlg615drx6wjF7nESpKgBeA_BX-qNobh1mxTEvf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7583b0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:29 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 05/21] environment: make `get_graft_file()` accept a
 repository
Message-ID: <e3f3f6391da3c81a0c6333ef450270c359772622.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

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
index 849a912b031..c2c231a7fd8 100644
--- a/repository.c
+++ b/repository.c
@@ -119,6 +119,13 @@ const char *repo_get_index_file(struct repository *repo)
 	return repo->index_file;
 }
 
+const char *repo_get_graft_file(struct repository *repo)
+{
+	if (!repo->graft_file)
+		BUG("repository hasn't been set up");
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
2.46.0.551.gc5ee8f2d1c.dirty

