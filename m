Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692347CC62
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260981; cv=none; b=DSqTabLaKa18BV8epaYhB3bSO2wpIW5Bj1+cO28o1+pyT82CGj8UU4DLKxxKki1MHuBR1jIHs0RsfkqasyJRNK2WR4UJNe2+lE1hBO/E4vF1PQBLCM0b81dZZsct0n99diFzGppE37psIK5VZI5iLXhDiyQrTikEAhZ5sv2qv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260981; c=relaxed/simple;
	bh=IjknhUKwRZZSBpl60o7S7xOWow9+upNUhToeqthxGGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZULARlJbx0xs6vTkXI+RGvpkjIRIsSCaphSpa6/YoEVTdy6wk6sYMySktkjGvEqwnbUiMH2NeKQFTuUmCf4WV05moZs1xZjjgVfgxQ6Fc34k4rYw49vFRUybufy8wlWAxrWPTBIfv+wzOJxET+EKt7GNeuo11hVEGqnMIC/haLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aTGJ4b4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPYgTcVS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aTGJ4b4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPYgTcVS"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51B7514000B0
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 01 Sep 2026 07:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260978;
	 x=1788347378; bh=8H/5iuW99MN7RDRElWk0HsTClBP7eMapnlh4N1mnT/A=; b=
	aTGJ4b4UKH2I7iZOvYMOia1kfOYM+tX0IdYwAJomcOiARyDYLQxco+TxS2PvlVRt
	It+hMX7KUyaT1gNfMhOxuT6o2X/OUFDKAesjN613nZFSjTscskrUEKYsdRJzUCFB
	P11BCUXMk9KecDYaI0rc51u4C7x94/UdRQ5H1RDaT8eIFC5ZbzZVoFSzde5MuioT
	tYiZ75MH4BWkXce7J3y1+N7y+dcc9fJZ1nfhn2aqZeGn5PfdpauioiTOfKF7ou3G
	gsbY37QsF0lQw5tkZsTKeA4Snz3hymMLNnxg5VNBEmHqFCvATxmUPqBrzXohyJsa
	dmFRnV0bXtWhhN/GvRaj4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260978; x=
	1788347378; bh=8H/5iuW99MN7RDRElWk0HsTClBP7eMapnlh4N1mnT/A=; b=V
	PYgTcVSYAkIMgCEjqFZOpzsZD2wYHUkd7v97TUv7be2Zi3wVbgFJ2TABhI1tWDJB
	HEoY3J3VHLW+JOhvRmwakxxIGQCVtgzO2oLas4ikbCQYy2v37dDdNJvMkhniWHQe
	PJ6p9WWfbFYH9jrPYGaIPSU9M9KKglrm5E5bdzFQ3YfE/jUr4SIK918xld3NYaPM
	fu9VGPdGo+FqnNL2SKFiDmzEMHtA0DUH2C/cyCjBh5S5k+4HuZti05Hlm2lZT5tV
	Ehm3SL6NEHFGl6rYtEXEuaQe3NHW/V1eogUVDTh6aeavSIH1x6Q5n2vOHYQdv83V
	rGx6dkflENAjS3OxXDnMg==
X-ME-Sender: <xms:crKWakeKr7WHWKyJER3QnmDJRnnm7h5jN8Oab-f3MjChChDDsijTtg>
    <xme:crKWatK-DcQhXHRf2jvd64cYoyrY4BCUcCn5uRSmUzlkVLrNx3raJe8ceI1MW7T8_
    ztaoXb2smU54w-e-wI_To798lw49aG5LJgqT0RreTnubqEAHIHMt-I>
X-ME-Received: <xmr:crKWarJWBVU-IHE5jgxU-v7VxiaEDfh0RGOaWUP1zW76cY7woCHglA>
X-ME-Proxy-Cause: dmFkZTEN9g1Fe0QNve9ECoP2TiUiX4EEH5POEiwmRiQIlHZ+xDbzHkU7NDd2M3NVK6/umO
    bXXkzUK3COWchLgt1/LK6gQ+MqeSaO5Oixh8RPOTrogDUVvdApPqyytnFYWyXEx31a/UW/
    VrRjQoyTePvVd8NFe+FYtwmzmG6MTjOdJtb92EaY7FcVv+MSIEhwv9SzJucvjBA0gTjUZ5
    irBlskFAJd/x0/Ql5UqM+PWol2xq0PhHqo6xS2QHAKohbPBqVxfe/t/HxXIdPstzFq1tQ2
    zZWYaDW+dfkh9KQoVCr2N9lwFiWtupwGIIOt/EhVGn/DGYrANZ/6T7aifXl4bC+/EDNai7
    4dIivvle40uT8OBooIPHtWDhXOU4qJRv/FwypxuAP3A2q8AZ6LkcRZceifaCpu09HHZwjs
    lBxcoDqWBZRQQ8WTCFedI/Um04+kAq1by3S0zqHtJN+RrHyM2NkoUvEjVnD3gYctr02Z7A
    nyORPb7X5sEgPeJCYY1tCs1MMhk8Vn0pu6O/HuRr12ebFVePHnnCN/FC6HsEi+BEBeCGdY
    6RYL8/IMW1YM3stU/RwpuaXzA/RW+vXNVOh/1TE9QtTD/q9zSRtY6lLcKRTTE7fabDb2R5
    iiIpwf8fL70T1GRRpiBwefazKo1JROXROJyCnCLKHsOgssW7ma+egBU76fCw
X-ME-Proxy: <xmx:crKWavFWt69Jts21X79loCUiAuCh6n4u__K1tNCnlJPxcubd3_KU3A>
    <xmx:crKWagmAfU6HSsZP3q5SXUOSp2bFVRvyzIR6knl8ogis91GNlsumEA>
    <xmx:crKWasKGbsQ9fC5kqLo08KwS8sDJZuRzQutS00ua70RHCdHiYjFRDA>
    <xmx:crKWaha2-HVZipwYlz3FIuRm477Abz2LQPbu8eSHej5Gr0vdNKDBBA>
    <xmx:crKWaqNEYzMhRlbud45w-dNSTBz54SdjIOG2NYKtqczq1IpjuwL7JKZZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85df249b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:09:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:01 +0200
Subject: [PATCH 02/12] submodule-config: remove uses of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-2-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Several functions in the submodule-config subsystem implicitly depend
on `the_repository`. Refactor these to take a `struct repository` as
parameter and adapt callers accordingly.

Note that as usual with these refactorings, callers simply pass
`the_repository` even if they already have a different repository
available in the calling context. This simplifies the migration and
ensures that we don't have a change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c             |  2 +-
 builtin/grep.c              |  2 +-
 builtin/submodule--helper.c |  8 ++++----
 submodule-config.c          | 49 ++++++++++++++++++++++++++-------------------
 submodule-config.h          | 12 +++++++----
 submodule.c                 |  2 +-
 t/helper/test-submodule.c   |  4 ++--
 7 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab7db2be06..533fdfe7d8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2681,7 +2681,7 @@ int cmd_fetch(int argc,
 		int *rs = config.recurse_submodules == RECURSE_SUBMODULES_DEFAULT
 			  ? &config.recurse_submodules : NULL;
 
-		fetch_config_from_gitmodules(sfjc, rs);
+		fetch_config_from_gitmodules(the_repository, sfjc, rs);
 	}
 
 
diff --git a/builtin/grep.c b/builtin/grep.c
index d3d86abe01..073dfaaf45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -897,7 +897,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (recurse_submodules) {
 			submodule_free(opt->repo);
 			obj_read_lock();
-			gitmodules_config_oid(&real_obj->oid);
+			gitmodules_config_oid(the_repository, &real_obj->oid);
 			obj_read_unlock();
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e7cd3225fa..aaaa963fd8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3041,7 +3041,7 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		NULL
 	};
 
-	update_clone_config_from_gitmodules(&opt.max_jobs);
+	update_clone_config_from_gitmodules(the_repository, &opt.max_jobs);
 	repo_config(the_repository, git_update_clone_config, &opt.max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_options,
@@ -3255,7 +3255,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix,
 		    path);
 
 	config_name = xstrfmt("submodule.%s.url", sub->name);
-	ret = config_set_in_gitmodules_file_gently(config_name, newurl);
+	ret = config_set_in_gitmodules_file_gently(the_repository, config_name, newurl);
 
 	if (!ret) {
 		repo_read_gitmodules(the_repository, 0);
@@ -3311,7 +3311,7 @@ static int module_set_branch(int argc, const char **argv, const char *prefix,
 		    path);
 
 	config_name = xstrfmt("submodule.%s.branch", sub->name);
-	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);
+	ret = config_set_in_gitmodules_file_gently(the_repository, config_name, opt_branch);
 
 	free(config_name);
 	return !!ret;
@@ -3510,7 +3510,7 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 		die(_("please make sure that the .gitmodules file is in the working tree"));
 
 	key = xstrfmt("submodule.%s.%s", name, var);
-	ret = config_set_in_gitmodules_file_gently(key, value);
+	ret = config_set_in_gitmodules_file_gently(the_repository, key, value);
 	free(key);
 
 	return ret;
diff --git a/submodule-config.c b/submodule-config.c
index f75997402a..f8c2cf7a93 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -667,19 +667,20 @@ static int parse_config(const char *var, const char *value,
 	return ret;
 }
 
-static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
+static int gitmodule_oid_from_commit(struct repository *repo,
+				     const struct object_id *treeish_name,
 				     struct object_id *gitmodules_oid,
 				     struct strbuf *rev)
 {
 	int ret = 0;
 
 	if (is_null_oid(treeish_name)) {
-		oidclr(gitmodules_oid, the_repository->hash_algo);
+		oidclr(gitmodules_oid, repo->hash_algo);
 		return 1;
 	}
 
 	strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
-	if (repo_get_oid(the_repository, rev->buf, gitmodules_oid) >= 0)
+	if (repo_get_oid(repo, rev->buf, gitmodules_oid) >= 0)
 		ret = 1;
 
 	return ret;
@@ -689,9 +690,11 @@ static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
  * (key) with on-demand reading of the appropriate .gitmodules from
  * revisions.
  */
-static const struct submodule *config_from(struct submodule_cache *cache,
-		const struct object_id *treeish_name, const char *key,
-		enum lookup_type lookup_type)
+static const struct submodule *config_from(struct repository *repo,
+					   struct submodule_cache *cache,
+					   const struct object_id *treeish_name,
+					   const char *key,
+					   enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
 	size_t config_size;
@@ -718,7 +721,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (!gitmodule_oid_from_commit(treeish_name, &oid, &rev))
+	if (!gitmodule_oid_from_commit(repo, treeish_name, &oid, &rev))
 		goto out;
 
 	switch (lookup_type) {
@@ -732,7 +735,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	if (submodule)
 		goto out;
 
-	config = odb_read_object(the_repository->objects, &oid,
+	config = odb_read_object(repo->objects, &oid,
 				 &type, &config_size);
 	if (!config || type != OBJ_BLOB)
 		goto out;
@@ -843,21 +846,22 @@ void repo_read_gitmodules(struct repository *repo, int skip_if_read)
 	repo->submodule_cache->gitmodules_read = 1;
 }
 
-void gitmodules_config_oid(const struct object_id *commit_oid)
+void gitmodules_config_oid(struct repository *repo,
+			   const struct object_id *commit_oid)
 {
 	struct strbuf rev = STRBUF_INIT;
 	struct object_id oid;
 
-	submodule_cache_check_init(the_repository);
+	submodule_cache_check_init(repo);
 
-	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
+	if (gitmodule_oid_from_commit(repo, commit_oid, &oid, &rev)) {
 		git_config_from_blob_oid(gitmodules_cb, rev.buf,
-					 the_repository, &oid, the_repository,
+					 repo, &oid, repo,
 					 CONFIG_SCOPE_UNKNOWN);
 	}
 	strbuf_release(&rev);
 
-	the_repository->submodule_cache->gitmodules_read = 1;
+	repo->submodule_cache->gitmodules_read = 1;
 }
 
 const struct submodule *submodule_from_name(struct repository *r,
@@ -865,7 +869,7 @@ const struct submodule *submodule_from_name(struct repository *r,
 		const char *name)
 {
 	repo_read_gitmodules(r, 1);
-	return config_from(r->submodule_cache, treeish_name, name, lookup_name);
+	return config_from(r, r->submodule_cache, treeish_name, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(struct repository *r,
@@ -873,7 +877,7 @@ const struct submodule *submodule_from_path(struct repository *r,
 		const char *path)
 {
 	repo_read_gitmodules(r, 1);
-	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
+	return config_from(r, r->submodule_cache, treeish_name, path, lookup_path);
 }
 
 /**
@@ -980,11 +984,12 @@ int print_config_from_gitmodules(struct repository *repo, const char *key)
 	return 0;
 }
 
-int config_set_in_gitmodules_file_gently(const char *key, const char *value)
+int config_set_in_gitmodules_file_gently(struct repository *repo,
+					 const char *key, const char *value)
 {
 	int ret;
 
-	ret = repo_config_set_in_file_gently(the_repository, GITMODULES_FILE, key, NULL, value);
+	ret = repo_config_set_in_file_gently(repo, GITMODULES_FILE, key, NULL, value);
 	if (ret < 0)
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), key);
@@ -1017,13 +1022,15 @@ static int gitmodules_fetch_config(const char *var, const char *value,
 	return 0;
 }
 
-void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
+void fetch_config_from_gitmodules(struct repository *repo,
+				  int *max_children,
+				  int *recurse_submodules)
 {
 	struct fetch_config config = {
 		.max_children = max_children,
 		.recurse_submodules = recurse_submodules
 	};
-	config_from_gitmodules(gitmodules_fetch_config, the_repository, &config);
+	config_from_gitmodules(gitmodules_fetch_config, repo, &config);
 }
 
 static int gitmodules_update_clone_config(const char *var, const char *value,
@@ -1036,7 +1043,7 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
-void update_clone_config_from_gitmodules(int *max_jobs)
+void update_clone_config_from_gitmodules(struct repository *repo, int *max_jobs)
 {
-	config_from_gitmodules(gitmodules_update_clone_config, the_repository, max_jobs);
+	config_from_gitmodules(gitmodules_update_clone_config, repo, max_jobs);
 }
diff --git a/submodule-config.h b/submodule-config.h
index f55d4e3b61..755570d5d1 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -57,7 +57,8 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
 int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 void repo_read_gitmodules(struct repository *repo, int skip_if_read);
-void gitmodules_config_oid(const struct object_id *commit_oid);
+void gitmodules_config_oid(struct repository *repo,
+			   const struct object_id *commit_oid);
 
 /**
  * Same as submodule_from_path but lookup by name.
@@ -80,7 +81,8 @@ const struct submodule *submodule_from_path(struct repository *r,
 void submodule_free(struct repository *r);
 
 int print_config_from_gitmodules(struct repository *repo, const char *key);
-int config_set_in_gitmodules_file_gently(const char *key, const char *value);
+int config_set_in_gitmodules_file_gently(struct repository *repo,
+					 const char *key, const char *value);
 
 /*
  * Returns 0 if the name is syntactically acceptable as a submodule "name"
@@ -100,8 +102,10 @@ int check_submodule_url(const char *url);
  * New helpers to retrieve arbitrary configuration from the '.gitmodules' file
  * should NOT be added.
  */
-void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
-void update_clone_config_from_gitmodules(int *max_jobs);
+void fetch_config_from_gitmodules(struct repository *repo,
+				  int *max_children,
+				  int *recurse_submodules);
+void update_clone_config_from_gitmodules(struct repository *repo, int *max_jobs);
 
 /*
  * Submodule entry that contains relevant information about a
diff --git a/submodule.c b/submodule.c
index 5c92575888..6fcb606f7e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -133,7 +133,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	ret = config_set_in_gitmodules_file_gently(entry.buf, newpath);
+	ret = config_set_in_gitmodules_file_gently(the_repository, entry.buf, newpath);
 	strbuf_release(&entry);
 	return ret;
 }
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 3c5c4c4a09..ea9bef0904 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -168,7 +168,7 @@ static int cmd__submodule_config_set(int argc, const char **argv)
 		if (!is_writing_gitmodules_ok())
 			die("please make sure that the .gitmodules file is in the working tree");
 
-		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+		return config_set_in_gitmodules_file_gently(the_repository, argv[1], argv[2]);
 	}
 	usage_with_options(usage, options);
 }
@@ -188,7 +188,7 @@ static int cmd__submodule_config_unset(int argc, const char **argv)
 	if (argc == 2) {
 		if (!is_writing_gitmodules_ok())
 			die("please make sure that the .gitmodules file is in the working tree");
-		return config_set_in_gitmodules_file_gently(argv[1], NULL);
+		return config_set_in_gitmodules_file_gently(the_repository, argv[1], NULL);
 	}
 	usage_with_options(usage, options);
 }

-- 
2.55.0.979.g7e5102b832.dirty

