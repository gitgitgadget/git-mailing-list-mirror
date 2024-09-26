Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3517AE05
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351175; cv=none; b=O8ZEIy6/csseXBCf7YTfBLneVLGdnA5zLwQPW8/6h1zl1mNKHEpCmQqnyKDAWyPK7QwZSU3dA9+PxSbHZYfEcZ2XYkWDj4tfQn1aricQarrMl9nwPRtX0sIaivV2/xETzgJxzIN+HQPx9F4m7U5qbry/XGryajBXv891mcYb/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351175; c=relaxed/simple;
	bh=5H2PcYOus7yTdW7d9ENh/+m/SRXz7dqfPokhfYQxcEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNEimmD+yRGNNaed0S8aMgFVqJqMjhy2RNlxfHaO1jNJUgeRnSrmlDIoZdsBYvh6BUYfith5NblGfn1BsIkPembyRjroGIplbcdljXkoP/aDysue+28UYySIqVF8VSvg1rQt1i5cvnuTkBk6EwmNYn3PAqshSz/XoHBlD3BZ1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=px54YGYr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m9T4Ep7M; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="px54YGYr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m9T4Ep7M"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D2DD11401B1;
	Thu, 26 Sep 2024 07:46:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 26 Sep 2024 07:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351173; x=1727437573; bh=FrZTdVLJ+c
	NH2aXeAlKtxeLk5aa3PbgXMvoewntfgWs=; b=px54YGYrKcunXZWxO6G7ijiV34
	PxTyvQUC4LY1Lczb0bzbj1ZvdqD8aXP+hlOFJkVAf0aDt+Abw0hKqJoHQ663I8CE
	XbHB/cU+D23kmV0MtJoiHOoXaKl6kAYc/6ARQV20t3q8YRRD0cUH30hft3C2bh2g
	qvDfWw/0w3vd0UJGpcAEJjbW/Tp8SKAzOsG+YXxgzvVuhGUab15CJ1mzuKTGdNa9
	OgktfV9MauGqtW8LOGYxgw1n4YrUmvJd8wrXHXLWoAjIDnBf8rr8cjhpGtb8bWa6
	/T3JcotG2/ELy+BXGFedWyvqNoMeLsbIxnBtl5xPGn93m52BIF8oQM5YIIHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351173; x=1727437573; bh=FrZTdVLJ+cNH2aXeAlKtxeLk5aa3
	PbgXMvoewntfgWs=; b=m9T4Ep7MtjXbUGtd9yHB/Ier5JsAU0/y7luZ1ctWJR4X
	HKFvcxWdO6QV/A3vfsYHWRO3zcFeXN/3HJJ6y0qM6svX0M2a2bNdFGBCHzXiWtc7
	seNv0xQRdqkPGKInm26eApON7Iuf3LEJHL/d2VHQtmNFdeTHLsOo6Vk4u4auITRu
	wStf2/B4fjQlbLRUzm5syu2z7J7jXs44hlUVR1GjdPQ+lqTO5RpcdNnGD+DlgiV8
	8OJJCBw8u4E7kir1hra4+Ir7UIZyc1qjyUlDuaTEx3sgglp8z26MRCXJrpKqIze6
	ZBa/N+5zKlsvfql2o14HR4LGJKRPAvkQBu5gAAMoSg==
X-ME-Sender: <xms:hEn1ZjZ2ufvXX169kw-OhYPz_5hTneWtwO_Sfb83kDGRKEssqu_ylw>
    <xme:hEn1Zib16eOJk5bQFj1rARDjihG_Mn4ulryix7sA7nN3dF2y1QZ0VuGQHLsdJVIcX
    f57VEJ0KRjh7amS1w>
X-ME-Received: <xmr:hEn1Zl_dRSfNWZLRGjU2EPoYLuzoQLqwM18c4RvUFBgZEunqCNNAnuX9e3tOFoclkSSABJi8rxYE9ZU6eheUVPCvHntMcjbv7-QAdUtuqEH1Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hEn1ZpoHGjhMhQWd2i_-FzMY2yJRg8400xDjTn4d5iCm6xJiHyMdQw>
    <xmx:hUn1ZupcJRDBMawIsDMmMr0jtlF3mDD8ZKYCE_7B4f74Flhc-dUkUg>
    <xmx:hUn1ZvRnAYY06LPKPHUkWUT9jZnqj7fzrLEKD-iWkl2bQdEF9kmwvA>
    <xmx:hUn1ZmoMjDFucTgr47qabjM4SNHhrnr_SdaWs1mf6MdkbNDp3LLgGg>
    <xmx:hUn1ZhVYq50JFh6FYeVtKyRSsNDuwQKGGz4aX1v-XbuKYNCYc_Kl8mZv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e579ae4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:34 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/23] submodule: fix leaking update strategy
Message-ID: <7cdd2691b77d328447855f898540f7efb2a415c3.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

We're not freeing the submodule update strategy command. Provide a
helper function that does this for us and call it in
`update_data_release()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c | 1 +
 submodule-config.c          | 2 +-
 submodule.c                 | 5 +++++
 submodule.h                 | 6 ++++--
 t/t7406-submodule-update.sh | 1 +
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bf8f9a4012..ed05dc5134 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2021,6 +2021,7 @@ struct update_data {
 static void update_data_release(struct update_data *ud)
 {
 	free(ud->displaypath);
+	submodule_update_strategy_release(&ud->update_strategy);
 	module_list_release(&ud->list);
 }
 
diff --git a/submodule-config.c b/submodule-config.c
index c8f2bb2bdd..471637a725 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -95,7 +95,7 @@ static void free_one_config(struct submodule_entry *entry)
 	free((void *) entry->config->branch);
 	free((void *) entry->config->url);
 	free((void *) entry->config->ignore);
-	free((void *) entry->config->update_strategy.command);
+	submodule_update_strategy_release(&entry->config->update_strategy);
 	free(entry->config);
 }
 
diff --git a/submodule.c b/submodule.c
index 97d0d47b56..0e67984d77 100644
--- a/submodule.c
+++ b/submodule.c
@@ -424,6 +424,11 @@ int parse_submodule_update_strategy(const char *value,
 	return 0;
 }
 
+void submodule_update_strategy_release(struct submodule_update_strategy *strategy)
+{
+	free((char *) strategy->command);
+}
+
 const char *submodule_update_type_to_string(enum submodule_update_type type)
 {
 	switch (type) {
diff --git a/submodule.h b/submodule.h
index b50d29eba4..4deb1b5f84 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,10 @@ struct submodule_update_strategy {
 	.type = SM_UPDATE_UNSPECIFIED, \
 }
 
+int parse_submodule_update_strategy(const char *value,
+				    struct submodule_update_strategy *dst);
+void submodule_update_strategy_release(struct submodule_update_strategy *strategy);
+
 int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
@@ -70,8 +74,6 @@ void die_in_unpopulated_submodule(struct index_state *istate,
 void die_path_inside_submodule(struct index_state *istate,
 			       const struct pathspec *ps);
 enum submodule_update_type parse_submodule_update_type(const char *value);
-int parse_submodule_update_strategy(const char *value,
-				    struct submodule_update_strategy *dst);
 const char *submodule_update_type_to_string(enum submodule_update_type type);
 void handle_ignore_submodules_arg(struct diff_options *, const char *);
 void show_submodule_diff_summary(struct diff_options *o, const char *path,
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 297c6c3b5c..0f0c86f9cb 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -12,6 +12,7 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
-- 
2.46.2.852.g229c0bf0e5.dirty

