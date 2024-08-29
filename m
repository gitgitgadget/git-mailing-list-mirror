Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361119049E
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924370; cv=none; b=keVoFtTYYSNlD1lGKUYSZas2Y7+0TR9FJhqp85+8pPLrF4xbniqkQJwK4TP7xEbWffGeGPSmbedHY/aXbqoVDUECrtbqwkoIfxYV3Q2IhQ5cyXbFpnknhLsuuIuZgdKROYV9f2cEWQAnChUsZt/pmaPYMNqJWp7jlhmQsh6zxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924370; c=relaxed/simple;
	bh=y1oewqVxCKNDiUZjtNoeQa66fZCYFAQJxV6DKpu0Dps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qsy6Yps4Bb4kFBfZiUFRCxeXe8AlrkklI4WCCbW2wxXVYCiBxOwFbY23C6y/V1cT2gkcjcYMdyIevaeikB2OzhBF8NmuaesXrLZnxFUK7yatL2I2jr04s2u80Zx0oQvB2YEBsJQKWaBW0Wg+Y91tLmQuJaeRL2BdEW7zgF5Do4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VBSG5uwM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMOSQyk0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VBSG5uwM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMOSQyk0"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 34B061390119;
	Thu, 29 Aug 2024 05:39:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 29 Aug 2024 05:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924368; x=1725010768; bh=naIkpSGSXB
	0K+OQko4obu3+kcDOEmpUyhNpXDgFl3D0=; b=VBSG5uwMl+YfTONdMSrjlKzWBx
	IKU/b9xOEIGSMJyzhuQ2SX5/1X4Eh9EhUF/uPrx78Z6ASxRyAFLWWH0/MUGBnRph
	2E2CePu+Uw9BtiVMHQEo4svdGwAjMX5LR1nvYNFw+eh5RH9ItWkUsGTx8eEFfpxT
	36SqtbiL42Ny8bXULAlxf5qNswZrZX/JqzURySCCUYNbbYrr0OJ9kzgxbgQ3ii1q
	1s45TRr7yeaQOxINR6kGMrdVlOklkG4kXVQATY/YY6yBGxH/Cy0HoGORINiepNjW
	uEQtc8iTDeDSDyFt0pcV1dTeML/SZI4h7872q6gP30jTgvPCfQ749qi4SrNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924368; x=1725010768; bh=naIkpSGSXB0K+OQko4obu3+kcDOE
	mpUyhNpXDgFl3D0=; b=HMOSQyk0Q2Ml9oGDIN+UT7tGrv1eXxa1JIUzQv4E0BJK
	zKC3a8PSWuJL7GGTAKIfc0JE1jHQc9ZGFYhJYJL1FMGP4Xa8mkk5CBm/l/m3xG2g
	kZDTZxV4HSnsV6ZnPjCxvXWPVD0CgTaFLkzru+i2TH9rey3jSMb5fLw4LFNaGStJ
	Fz6n5Dh+qD6d8vxYr1w98IpmxLI7Xvhd1hWO7g/eSGOg0//SZCrHixiaekOuO1ny
	19rAwp9ZnmMaTxlW507B62bHR9Azh94Q4Dc4OWUKVao7zC513NQG+iFhKXD3igQY
	dSGZC+Y26DV1QLt73fYHSRqJtyo2YiqtnJwMjCcITw==
X-ME-Sender: <xms:0EHQZm9IdMIN1-O3lLo_D0VhrRsDmF8p2ku8MdoAMc_OfociBS7jJw>
    <xme:0EHQZmut4JRbbZ1MPF_g53CN2fWwBagbE90mq2tiGa-8BAV2310GICBLLNOsA0oC_
    BmXkqgoNAhndAti-A>
X-ME-Received: <xmr:0EHQZsBQfN8rdqZiZRvpw3YnJIaR14SfY63b3CZ_zQdHNrfcyXqM0YzVP-TbO93E7DryFQAT6nXQqg8OVM1oJOgeYxF3jBGRrsJYsRYb-DPZt2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:0EHQZudNXg5f3wPWWJgC7Ub-6XHHuvdso_69LWUmi5M2Twej6PKoxQ>
    <xmx:0EHQZrN5XDcDz0_tIWqk7wBRmXjlBN5m5q64wGn5QpSE3oD6Bb7p2A>
    <xmx:0EHQZok_oZPoyE7StZrXgKZ51poZOVjqt-yaZv_OubLWbtGJFwJtOQ>
    <xmx:0EHQZtu0po0L_uvsXp3pQfCMdP_z30rHsd79WYaS6_yex6-HvaYfoQ>
    <xmx:0EHQZkbqKxNXsLvgAqSY1uAr52w1PEkXEpiq3tE1XeOwacv_R3fjk4yP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c9ed07c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:39:18 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 19/21] environment: stop storing "core.preferSymlinkRefs"
 globally
Message-ID: <ef312f67f76f2563f3fc662cd551930c4b2ea1bd.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

Same as the preceding commit, storing the "core.preferSymlinkRefs" value
globally is misdesigned as this setting may be set per repository.

There is only a single user of this value anyway, namely the "files"
backend. So let's just remove the global variable and read the value of
this setting when initializing the backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c             | 5 -----
 environment.c        | 1 -
 environment.h        | 1 -
 refs/files-backend.c | 5 ++++-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 47101c3e977..a59890180a3 100644
--- a/config.c
+++ b/config.c
@@ -1447,11 +1447,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.prefersymlinkrefs")) {
-		prefer_symlink_refs = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.warnambiguousrefs")) {
 		warn_ambiguous_refs = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 992d87e0d60..6805c7b01df 100644
--- a/environment.c
+++ b/environment.c
@@ -34,7 +34,6 @@ int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
-int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
diff --git a/environment.h b/environment.h
index 315fd319951..0cab644e2d3 100644
--- a/environment.h
+++ b/environment.h
@@ -156,7 +156,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6ad495744b0..b8a0b27d24e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "../git-compat-util.h"
+#include "../config.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -75,6 +76,7 @@ struct files_ref_store {
 
 	char *gitcommondir;
 	enum log_refs_config log_all_ref_updates;
+	int prefer_symlink_refs;
 
 	struct ref_cache *loose;
 
@@ -108,6 +110,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, refs->gitcommondir, flags);
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
@@ -2941,7 +2944,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		 * We try creating a symlink, if that succeeds we continue to the
 		 * next update. If not, we try and create a regular symref.
 		 */
-		if (update->new_target && prefer_symlink_refs)
+		if (update->new_target && refs->prefer_symlink_refs)
 			if (!create_ref_symlink(lock, update->new_target))
 				continue;
 
-- 
2.46.0.421.g159f2d50e7.dirty

