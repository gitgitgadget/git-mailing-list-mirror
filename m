Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD0442397
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241593; cv=none; b=n6lKpt+JZn8a3hNDQICG5o1uRyphrnNlbQHlMLq/EHuUZjNm3NhZm6TzJtlnQDi33GIAeE1pm1DiIihQ2I6OjdgIvJCh8x1D4YynNZWLh8hWqTHclPgLMFPsi12siqXvZt00HYb6elPgYFCEd8IcvNu2iP4rzA+Rh8DdZeadG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241593; c=relaxed/simple;
	bh=4umDP7veNM5FcrBpHeeUHJOzt+UZupn20SFQIJNpQjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ch9DzZ3q4qfF3GuuXz1JlcFwy9c7skbn6nHi7SUC5gFlDd0nFLkrnOFGcFYILl9spkfhCmgFRllM7Iy4pj1cRbO+DE5Xf9LuokHsazezq/gPGJCjnSH4iOGH2yI3ZZAGEqb4CzXlXcZgEfmbNFG+Q8Xj1AhzgYl7EDygGBqj4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fmDt6BLL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qhhfXx9z; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fmDt6BLL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qhhfXx9z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AEC40EC00CE
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 24 Sep 2026 05:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790241589;
	 x=1790327989; bh=PNu6uFlNqL9qXfmWR/aGk0uIiBG1UMR+Xzmp/UXV5c0=; b=
	fmDt6BLLD0kfn839aah0l2xW2zD/8/DlzpGl376vewhtS+QguoGlPekr4s4kCvgL
	QjuRXJBeAp8T9WQItuWWp8hM3Sxj2G75mOCmNJotGEfNgCwurNiLaQHgUoemAHiu
	HwND6sc7Xj8ZIr+lpK9zW3rvLMuZOZz526vtHMf15UFvWZGwNBOhkNgfGWtJIKZ9
	SVcFQ+Fsh83H8L38ykvSF1jmBuG0/Powzj17VOYCDAn9h0fJXpNIARXkqEkNW9tc
	sWabS8xsmEtFUgAoY9ivShPw87cPmPRcbNdF8Hu/oy3I2sIaUwcievok0Zh6udeG
	Wj5HkAFc48EC/W1bJr1zsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790241589; x=
	1790327989; bh=PNu6uFlNqL9qXfmWR/aGk0uIiBG1UMR+Xzmp/UXV5c0=; b=q
	hhfXx9zdQBnjAQu23rbQngczEQ6TTRK3gwGXL2kKV7rQKVIQw2bwk6ta/q3jX0GQ
	4x/NKhxiYEjEoikYQkGbtVu8o3S+oavsMX27GsN0CwMW4a/uE5B5zjO63QSVd77b
	pTgP4eL6llu3590Ag8kFrQDfBQECf3i1qeTGDpRHJxSAb0zuJDp2GCWSKovn19ho
	sQhFtJPlKCxUSM+nmysPl6M8vwPK95SdwPLA/lWtVlHU2KLmcp5oMKCjVevKO1hd
	hQZSZJudKxd8DbhpmLeitHWiWtcjbQH8zsCTmhkW6tVGBA4SYpgY4GTLBakpzDVZ
	bvwJ5i+UzK0whZYewn44Q==
X-ME-Sender: <xms:Neu0asKRvzaRYBApitPnENHe4FIjro7sYdCjJDlrG5mUDwtLZlzELQ>
    <xme:Neu0ajFw_a0a1H1fSpj3dDt4lh5LRtOdphHwxrKNFbQHWNmCIInYXRKOMiWgoXYrt
    J-ywxF40e6sKLyM88-_e_OzXqXc1GR3YWQMc8StpfFCxqpQz4Ime3E>
X-ME-Received: <xmr:Neu0aiU2Ay91b_TLD5mNU4ZC_Pun9HQtpSOmhjUNoqC3Q3mngbe9asNDry9C-bnVTubumnU>
X-ME-Proxy-Cause: dmFkZTFPodOiLWcdqf6sGstU46dIiqXidIFd9cR4fooPG2VzhuQs4sgHwSSL0mI+zYrJki
    puKwTM6PzOLvhrOnHha7/ZqJXKFWeUZ7pL3PmhkuvlpM0SAOkWbZk3xZQvHRMhKdNhwt4b
    RD3a0i1KaVTQhiwtqarc8pf3XfoXA6W5MTyTZacFoe6F2umLNsXJ1ouYl3pIUvkblQZagq
    My5ETPa7FIKiTyNS2see97qCZqfu7GXNWEANEz90j9Xl651gCUX4FzvDgltnokz25gMaTM
    HthS5xNHFJNXlc52D+rP6WxTTQ+lRC0R4uRCl7fXgiak8N0bh0v8/Rl7rSKJ4fouMiwlpn
    nJKga1YIq/HHrO+fV4sq64s0OGShtvD/caiul5tzBbbmYS0riB9GYr87hsolD9Xu/iZsFD
    ENC4CX/8WENYRPqsU+lvOkIPiZSJy8kCcDuJiTZZnEWfSVJ3EACCk+ZMQLgZT2mLpssPPP
    wcO+90nCO7sWvNnt2HVa+2k9+9+elpLVoEb0KssKvnlMdDxBep+c9tJ/lJ298SH+jKhEgn
    zzmSaU9yBBKvoXkL8ZeGFwatGyi+60o+K6ggmL6Uta1Xcs7oiYOzacZYqSu5dyuqU/CKKa
    ZFMOj2rUM7ptCQCL5U4nBo01btz668w3XKoXPrtgyVRQZuQDoF4kJHoXdIgQ
X-ME-Proxy: <xmx:Neu0aujMlE-CgKsQAjLkZQhv-5DA-jX5W0RHZnCtd2_3GY2oUAKxtA>
    <xmx:Neu0ajSkeElo8-3LtJv_8tRiyG1BNMXodJE_g5WCKFXrqIfykA_gTA>
    <xmx:Neu0ahGPf-UJE9aeysQm0rOqX7eZeNaFJmNGEgJHrCgK7qc56TlMYA>
    <xmx:Neu0ark5hAIiIEPyragnWBuxQEfq1742W0hZ8lI1YAmTQ_nJ42dWvA>
    <xmx:Neu0alomdpkpbgVBTt1cvIahKXclAX63y1oVHpZVyyOUd1DE1g0s7NdZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d51adb54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Sep 2026 09:19:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 11:19:24 +0200
Subject: [PATCH 6/7] repository: adapt `repo_clear()` to fully reset the
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-create-repository-stateless-v1-6-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `repo_clear()` can be used to clear a repository's state.
The way it's written though it's quite easy for it to accidentally leak
some state because we don't make sure to clear the whole structure.

Refactor the function to set the whole repository to all-zeroes to avoid
any kind of leaking state. While at it, make it a bit more robust when
called on an already-blank repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 37 ++++++++++++++++++-------------------
 repository.h |  2 +-
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/repository.c b/repository.c
index b857e1c580..e67ff00550 100644
--- a/repository.c
+++ b/repository.c
@@ -374,60 +374,57 @@ void repo_clear(struct repository *repo)
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 
-	FREE_AND_NULL(repo->gitdir);
-	FREE_AND_NULL(repo->commondir);
-	FREE_AND_NULL(repo->prefix);
-	FREE_AND_NULL(repo->graft_file);
-	FREE_AND_NULL(repo->index_file);
-	FREE_AND_NULL(repo->worktree);
-	FREE_AND_NULL(repo->submodule_prefix);
-	FREE_AND_NULL(repo->ref_storage_payload);
+	free(repo->gitdir);
+	free(repo->commondir);
+	free(repo->prefix);
+	free(repo->graft_file);
+	free(repo->index_file);
+	free(repo->worktree);
+	free(repo->submodule_prefix);
+	free(repo->ref_storage_payload);
 
 	odb_free(repo->objects);
-	repo->objects = NULL;
 
 	if (repo->parsed_objects)
 		parsed_object_pool_clear(repo->parsed_objects);
-	FREE_AND_NULL(repo->parsed_objects);
+	free(repo->parsed_objects);
 
 	repo_settings_clear(repo);
 	repo_config_values_clear(&repo->config_values_private_);
 
 	if (repo->config) {
 		git_configset_clear(repo->config);
-		FREE_AND_NULL(repo->config);
+		free(repo->config);
 	}
 
-	if (repo->submodule_cache) {
+	if (repo->submodule_cache)
 		submodule_cache_free(repo->submodule_cache);
-		repo->submodule_cache = NULL;
-	}
 
 	if (repo->index) {
 		discard_index(repo->index);
-		FREE_AND_NULL(repo->index);
+		free(repo->index);
 	}
 
 	if (repo->hook_config_cache) {
 		hook_cache_clear(repo->hook_config_cache);
-		FREE_AND_NULL(repo->hook_config_cache);
+		free(repo->hook_config_cache);
 	}
 	strmap_clear(&repo->event_jobs, 0); /* values are uintptr_t, not heap ptrs */
 	string_list_clear(&repo->disabled_events, 0);
 
 	if (repo->promisor_remote_config) {
 		promisor_remote_clear(repo->promisor_remote_config);
-		FREE_AND_NULL(repo->promisor_remote_config);
+		free(repo->promisor_remote_config);
 	}
 
 	if (repo->remote_state) {
 		remote_state_clear(repo->remote_state);
-		FREE_AND_NULL(repo->remote_state);
+		free(repo->remote_state);
 	}
 
 	if (repo->refs_private) {
 		ref_store_release(repo->refs_private);
-		FREE_AND_NULL(repo->refs_private);
+		free(repo->refs_private);
 	}
 
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
@@ -439,6 +436,8 @@ void repo_clear(struct repository *repo)
 	strmap_clear(&repo->worktree_ref_stores, 1);
 
 	repo_clear_path_cache(&repo->cached_paths);
+
+	memset(repo, 0, sizeof(*repo));
 }
 
 int repo_read_index(struct repository *repo)
diff --git a/repository.h b/repository.h
index 11f5c2ed10..2a348012e8 100644
--- a/repository.h
+++ b/repository.h
@@ -258,6 +258,7 @@ void repo_set_ref_storage_format(struct repository *repo,
 void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
+void repo_clear(struct repository *repo);
 
 /*
  * Initialize the repository 'subrepo' as the submodule at the given path. If
@@ -273,7 +274,6 @@ int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
 			const char *path,
 			const struct object_id *treeish_name);
-void repo_clear(struct repository *repo);
 
 /*
  * Populates the repository's index from its index_file, an index struct will

-- 
2.56.0.rc2.329.gd58861e689.dirty

