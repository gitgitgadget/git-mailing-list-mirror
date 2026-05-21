Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8C39EF3F
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349368; cv=none; b=CS45fW6fN94WhJw429sA4ZScC+Q4ryPkCfJLT/roryfXlLQHHtSI9/9vpWFkUCLL+6wc59alzvCNxvXMW4NrNjrRSvM5yOuFEzV5Sq1TVKXiEUkRh16uK53wzbsGnjkP9zpWWcCxxG4Ro40/UVQKuYeh5N03JY76tN4FB0arc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349368; c=relaxed/simple;
	bh=/NeXZWIzqG8FnPn5Q1mantq3YcwPDfXcIeMrlVh1jc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZD+MMOzasxkmETywFW/zN8CKdKrxbIdcitWcqriYCFD8POC3xD56PssVWVF/u1VUlUMlcjiVtuJUjtlv6RU8IVDVVWBqSesqlst5jINbjLty761vi243NC7ENiJdauZAmujpUxymQSUE6vA9d/DYiIHNpmbY1KTRe3R256gRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=msvZIEp3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H7lFOXSg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="msvZIEp3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H7lFOXSg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1586140006C
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 03:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779349366;
	 x=1779435766; bh=M32/tjIJwnZ7nc/ktXPn72L8CzhKqStUq3+ID4k0Y+o=; b=
	msvZIEp3H1SO8EZg6eO+mGVIkK75TftJydRKeSp7DfR1zwsVEjgx5Am/fwr+t++Y
	mv0vo8UPKniUKLojS3K27jEpFfWG3IIQ7phqyx38ZqCVhgjz9CyhKG1NQL+Z5E1e
	ffEMSGvn3UNxXEXvklkNJ1C3qaALc6VN6RUqPINiUib4Kel9PhQUmqn/B9ST/Br7
	cCZYKciASQJ5xchCh2WAwXjxp9EHZxT3RLRA5ws1Y3GgLrwtKyH6Kt9U0dSH8Mvz
	Mg1TRqvM3ZoNPCpY663tvJYi/FO7y3dnm3unOBCdWiaqEy3z2V0vlB4YKcwhMV3Y
	evacj8JFVh8fxpHNBzPSIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779349366; x=
	1779435766; bh=M32/tjIJwnZ7nc/ktXPn72L8CzhKqStUq3+ID4k0Y+o=; b=H
	7lFOXSgH5SmdfiPdG2Wxq0S53lYi1lmYnkJrF2BB6QktosU1MfOAE6A2azZ4yK+o
	WqqoZGuklCbWZtugDsF+QND3JT7IwOM/eHwN2Sc0RfjaEvPyxawg8GxFeAUpCH+4
	+oUNav30V5mu5Wsr5FOYldV9N0FyFJ7moy8pe2kFiEXegbD6TOwcEZTxErTdeEZX
	uBOyTjGIlPL44tQjDCGhDOv2dY9aPfGtpDHbG7SvIz/1O4acapa2H+HUbMyZkPFy
	uQ2QB06i5aTxaHkVSh8Agd0aCWonM/7UOtKaW2Vdpi+GOmZTaBpVl66y8H4OBJwA
	6wMyW6pTTayzCx2bWp/tg==
X-ME-Sender: <xms:drcOamW9-kgVrxR6eoTIsXT4e0DMWSYE43ycEz61B1dSlXBz9PG0yg>
    <xme:drcOaph2py5eEoiKjCNEAXQJoobztGy7sgHXG9EPVa4ASAKt4aZT4YSLsVRb1vd0q
    MRnzwYpTv7OPtdwlpMkcoj61MzLA2qF1X1Xjqp7dwGoY1IWoKW_PA>
X-ME-Received: <xmr:drcOagB6HPJgqlauV7ARGGOnojYIljJZw57GZzbRBe__0ZkGOgu40Xf7ZGmsCzGoh2BUqjpGVa8NMp4rh2ugXKnHIyefbs-ta-PuVWHsgkY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:drcOaidzMYwSZppjqCubjNPCWXWP_0BipvqDZQzorKz8nfeUM3g0bg>
    <xmx:drcOagcHnLnxK5sSFm97MVqRq07Qwuos8i7Wv476evM7sP9ubLdnUA>
    <xmx:drcOaug03oP8AgAPeovRNmqmGTJZzaB2-jLYgO9XpTBebXIGfYJv-Q>
    <xmx:drcOakQABM68yQxU3XzpEvTFjOgUmM4OB4BiIYDmtNcFVLdoP4iutg>
    <xmx:drcOalnaFCsAwjX2sU8AqBdLpUzUmK9cMsiqQpjj1G6vyL3nAuYeJidV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c4d54ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 09:42:31 +0200
Subject: [PATCH 4/8] repository: stop initializing the object database in
 `repo_set_gitdir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-4-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `repo_set_gitdir()` obviously sets the Git directory for a
given repository. Less obviously though, the function also configures a
couple of auxiliary settings.

One such thing is that we create the object database in this function.
This logic only happens conditionally though, as `set_git_dir()` may be
called multiple times during repository setup, and we don't want to
create the object database multiple times. This is somewhat tangled and
hard to follow.

Remove the logic from `repo_set_gitdir()` and instead initialize the
object database outside of it. This leads to some duplication right now,
but that duplication will be removed in a subsequent step where we will
start initializing the object database as part of applying the repo's
format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 8 ++------
 repository.h | 3 ---
 setup.c      | 7 ++++---
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/repository.c b/repository.c
index 58a13f7c4f..2c2395105f 100644
--- a/repository.c
+++ b/repository.c
@@ -181,12 +181,6 @@ void repo_set_gitdir(struct repository *repo,
 	free(old_gitdir);
 
 	repo_set_commondir(repo, o->commondir);
-
-	if (!repo->objects)
-		repo->objects = odb_new(repo, o->object_dir, o->alternate_db);
-	else if (!o->skip_initializing_odb)
-		BUG("cannot reinitialize an already-initialized object directory");
-
 	repo->disable_ref_updates = o->disable_ref_updates;
 
 	expand_base_dir(&repo->graft_file, o->graft_file,
@@ -302,6 +296,8 @@ int repo_init(struct repository *repo,
 		goto error;
 	}
 
+	repo->objects = odb_new(repo, NULL, NULL);
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/repository.h b/repository.h
index c3ec0f4b79..36e2db2633 100644
--- a/repository.h
+++ b/repository.h
@@ -221,12 +221,9 @@ const char *repo_get_work_tree(struct repository *repo);
  */
 struct set_gitdir_args {
 	const char *commondir;
-	const char *object_dir;
 	const char *graft_file;
 	const char *index_file;
-	const char *alternate_db;
 	bool disable_ref_updates;
-	bool skip_initializing_odb;
 };
 
 void repo_set_gitdir(struct repository *repo, const char *root,
diff --git a/setup.c b/setup.c
index c5015923f1..3bd3f6c592 100644
--- a/setup.c
+++ b/setup.c
@@ -1045,17 +1045,18 @@ static void setup_git_env_internal(struct repository *repo,
 	struct strvec to_free = STRVEC_INIT;
 
 	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
-	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
-	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
 	if (getenv(GIT_QUARANTINE_ENVIRONMENT))
 		args.disable_ref_updates = true;
-	args.skip_initializing_odb = skip_initializing_odb;
 
 	repo_set_gitdir(repo, git_dir, &args);
 	strvec_clear(&to_free);
 
+	if (!skip_initializing_odb)
+		repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
+					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
+
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		disable_replace_refs();
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);

-- 
2.54.0.771.g3ed373ac14.dirty

