Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53418F2D1
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924354; cv=none; b=PsUzwYo41rswsd5KYMI6JRgna3UymdPOh/V5WXjJ3B9uE/uoDSLmf7IpeWvlUtX3yVBGIB1G5R8sBUK8vkxXQriEATmV+ZKdSFN19De0SWXpuOXMVrA51//beiyMKzy6zq5UCGi093AasdGCu4FuQ3+7scsfI/tT3Uz4aVITEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924354; c=relaxed/simple;
	bh=jVDhSaCroLryPc7BTjVD3V8dlBTv6lfvJP+J9TUmX8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmpbiAWJmW4DTaNzdPWLj8pq11oSIzvaPePZMnIoum7eIWrwja1TY6Pa6y3UXwVXq4Yr2/s+izP/b1voKmAJt067pFNNumk02rtnx5ocowUuXPjhVMGWmLXG3oJ7NlgogjHNDY4CrtDLIZpnd64QL88584Ir+CrRICoEh71nW/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nELchdf9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cnFBIjWv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nELchdf9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cnFBIjWv"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1428C1151CE6;
	Thu, 29 Aug 2024 05:39:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 29 Aug 2024 05:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924352; x=1725010752; bh=EqkRaVpezP
	5Gle8sx/YgIgo3+DjDvKZHMRTI7S95LHg=; b=nELchdf9pQiP3jQ2b3Cgno8AQY
	aVlsBeEY+F82V/2aZnF/aijAu4LvR55zyaDbc8dtDeOnKIWjmEede4bQwMi7m3Zl
	tnqwLq2tzKILa+H/HBotPsGOfWcQh8f3sYbrraK//wlUMMyHY3Cw69fjF1Z5P/CU
	t7tb9Jqrwy9F69mAA8K/Y0XI+UTwgDt4uXy/M4YPGdWGYL+7iKyWH7yQVWGO0Gk5
	udjkeH9N7Ti6A8Ve4av9/rxPNVrNtIXAwd4GvAnFs+aubKBz86wgQK9yJS2VekR8
	d5XEIagAtM/LqHvTuY+PjQ811abDAKPmXCZsNcwv5Rog8UFG0KsWwkiiznfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924352; x=1725010752; bh=EqkRaVpezP5Gle8sx/YgIgo3+DjD
	vKZHMRTI7S95LHg=; b=cnFBIjWv70uxvYLJmrP+e5M1AZhg+MdH+AzQxl+yDDgN
	oYZXHRYo645kVehuwmYUeC0gwr2IJBeBkRQxVIWyPIYXk6I3BV0JCK1nLYmgnXAe
	1yfTCUdKyS1i44z2Ixx4H15/As8NjHo3JGpfDq3uBLB9XRSZGMVdHOlzzRfZFXQR
	+LN4Iv3VxevecUVJR3U9AKfxFjB5/L+3fAZQrPVIB4/x6IZMIITtGcCnEHY+9ZRu
	hcqEqrJSuarqXV/7AZYUmBJ0EwGBheqGYVxwCyHMzcX+3aWqwYrKZYaxty88hBuV
	IqaB/FOfkoOJzCRsxaljSFPUQ3N7ac4z9DRgWu+wAQ==
X-ME-Sender: <xms:v0HQZifcXCmOmpQjw9aPd230IZYGg4A6XX3VK0KcIjqF6o6yHBpWtQ>
    <xme:v0HQZsPiPhgR1Ovc0soLTgnYCoCcp7gHx3gpq8Uvi_DpNsXlKcC3uXB5YQ-qubfvz
    RXz_YpOgOiQvvrUTw>
X-ME-Received: <xmr:v0HQZjgXpu_qP2Rt4iZBkL0S2CR6jNBkwV4Cly138irsHyhXIgzuQkEOrQKk1UIgngI2GHxeP8kLxKzjGHNr9gaGw0E0p4AOUzGxc-hRXq77wGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v0HQZv-eF39qKj-EAP25Yz0dzallO1Dmgq5cc-n65roT8-XUKmhbrQ>
    <xmx:wEHQZuuQP0eLI8khOvg-IlO6gpnUHiUg-0fUvEG3d1OAVBU-p3Yrgw>
    <xmx:wEHQZmFyzlWEocMTwXx5ysn-gwZtA907pcDQo3SXjXgCNVAkCCcecQ>
    <xmx:wEHQZtNqswV2opKmI1jL8KUWZQiSFQ4jXm2qpoGt65WPh6LLLbwCvg>
    <xmx:wEHQZn6w9U1Bvdb7Kzdz2LIF-W2BhHeiPKWHLJ52Zn1v9Cf2NAz6ly-v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eaf0917c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:39:03 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 14/21] repo-settings: split out declarations into a
 standalone header
Message-ID: <b2c11c8e3169da9ff254efd4ba3f7efd0df73b59.1724923648.git.ps@pks.im>
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

While we have "repo-settings.c", we do not have a corresponding
"repo-settings.h" file. Instead, this functionality is part of the
"repository.h" header, making it hard to discover.

Split the declarations out of "repository.h" and create a standalone
header file with them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repo-settings.c |  1 +
 repo-settings.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 repository.h    | 51 +-------------------------------------------
 3 files changed, 58 insertions(+), 50 deletions(-)
 create mode 100644 repo-settings.h

diff --git a/repo-settings.c b/repo-settings.c
index 2b4e68731be..6165546e80a 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "repo-settings.h"
 #include "repository.h"
 #include "midx.h"
 
diff --git a/repo-settings.h b/repo-settings.h
new file mode 100644
index 00000000000..ff20a965373
--- /dev/null
+++ b/repo-settings.h
@@ -0,0 +1,56 @@
+#ifndef REPO_SETTINGS_H
+#define REPO_SETTINGS_H
+
+struct fsmonitor_settings;
+struct repository;
+
+enum untracked_cache_setting {
+	UNTRACKED_CACHE_KEEP,
+	UNTRACKED_CACHE_REMOVE,
+	UNTRACKED_CACHE_WRITE,
+};
+
+enum fetch_negotiation_setting {
+	FETCH_NEGOTIATION_CONSECUTIVE,
+	FETCH_NEGOTIATION_SKIPPING,
+	FETCH_NEGOTIATION_NOOP,
+};
+
+struct repo_settings {
+	int initialized;
+
+	int core_commit_graph;
+	int commit_graph_generation_version;
+	int commit_graph_changed_paths_version;
+	int gc_write_commit_graph;
+	int fetch_write_commit_graph;
+	int command_requires_full_index;
+	int sparse_index;
+	int pack_read_reverse_index;
+	int pack_use_bitmap_boundary_traversal;
+	int pack_use_multi_pack_reuse;
+
+	/*
+	 * Does this repository have core.useReplaceRefs=true (on by
+	 * default)? This provides a repository-scoped version of this
+	 * config, though it could be disabled process-wide via some Git
+	 * builtins or the --no-replace-objects option. See
+	 * replace_refs_enabled() for more details.
+	 */
+	int read_replace_refs;
+
+	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
+
+	int index_version;
+	int index_skip_hash;
+	enum untracked_cache_setting core_untracked_cache;
+
+	int pack_use_sparse;
+	enum fetch_negotiation_setting fetch_negotiation_algorithm;
+
+	int core_multi_pack_index;
+};
+
+void prepare_repo_settings(struct repository *r);
+
+#endif /* REPO_SETTINGS_H */
diff --git a/repository.h b/repository.h
index c603e969ae7..24a66a496a6 100644
--- a/repository.h
+++ b/repository.h
@@ -2,9 +2,9 @@
 #define REPOSITORY_H
 
 #include "strmap.h"
+#include "repo-settings.h"
 
 struct config_set;
-struct fsmonitor_settings;
 struct git_hash_algo;
 struct index_state;
 struct lock_file;
@@ -14,59 +14,12 @@ struct submodule_cache;
 struct promisor_remote_config;
 struct remote_state;
 
-enum untracked_cache_setting {
-	UNTRACKED_CACHE_KEEP,
-	UNTRACKED_CACHE_REMOVE,
-	UNTRACKED_CACHE_WRITE,
-};
-
-enum fetch_negotiation_setting {
-	FETCH_NEGOTIATION_CONSECUTIVE,
-	FETCH_NEGOTIATION_SKIPPING,
-	FETCH_NEGOTIATION_NOOP,
-};
-
 enum ref_storage_format {
 	REF_STORAGE_FORMAT_UNKNOWN,
 	REF_STORAGE_FORMAT_FILES,
 	REF_STORAGE_FORMAT_REFTABLE,
 };
 
-struct repo_settings {
-	int initialized;
-
-	int core_commit_graph;
-	int commit_graph_generation_version;
-	int commit_graph_changed_paths_version;
-	int gc_write_commit_graph;
-	int fetch_write_commit_graph;
-	int command_requires_full_index;
-	int sparse_index;
-	int pack_read_reverse_index;
-	int pack_use_bitmap_boundary_traversal;
-	int pack_use_multi_pack_reuse;
-
-	/*
-	 * Does this repository have core.useReplaceRefs=true (on by
-	 * default)? This provides a repository-scoped version of this
-	 * config, though it could be disabled process-wide via some Git
-	 * builtins or the --no-replace-objects option. See
-	 * replace_refs_enabled() for more details.
-	 */
-	int read_replace_refs;
-
-	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
-
-	int index_version;
-	int index_skip_hash;
-	enum untracked_cache_setting core_untracked_cache;
-
-	int pack_use_sparse;
-	enum fetch_negotiation_setting fetch_negotiation_algorithm;
-
-	int core_multi_pack_index;
-};
-
 struct repo_path_cache {
 	char *squash_msg;
 	char *merge_msg;
@@ -273,8 +226,6 @@ int repo_read_index_unmerged(struct repository *);
  */
 void repo_update_index_if_able(struct repository *, struct lock_file *);
 
-void prepare_repo_settings(struct repository *r);
-
 /*
  * Return 1 if upgrade repository format to target_version succeeded,
  * 0 if no upgrade is necessary, and -1 when upgrade is not possible.
-- 
2.46.0.421.g159f2d50e7.dirty

