Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20EE16FF41
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008981; cv=none; b=V+glnzeg6F8OSHSYfslknX+z68Ksi8Tx38TwJAFHRqMm+nJ0T3ILhXlfgKK9WtsVTO/qjNw9wdHELJKzlN5BM7KKxKzmFMG/r6plvrlNfqFzLg0u/LSgJT4S1fuH+AYBNIazQ57SNjUPENEU45MWeEolJKQp0hhL3NOu1ewaV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008981; c=relaxed/simple;
	bh=jVDhSaCroLryPc7BTjVD3V8dlBTv6lfvJP+J9TUmX8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxKnTonnZoLSgVBKG8LEYjMFAN+4ZQbnw8pfAjfIuOJ7PB5KhXicid0rh+1tLqHIw1TLzJ3UXVr/bjRD5iNfSSASR5ualhzPOlAr92dK6GJKH44iyjfbkKaz2NWCym5k3RsGnACnAhJu7aJv3J5YVwvMCVkkNvL0N8Sg46Kcarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EpqavXms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4bJeZUY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EpqavXms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4bJeZUY"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0FB7F138024B;
	Fri, 30 Aug 2024 05:09:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 30 Aug 2024 05:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008979; x=1725095379; bh=EqkRaVpezP
	5Gle8sx/YgIgo3+DjDvKZHMRTI7S95LHg=; b=EpqavXmsj968z7ZMw+4u4UJfJJ
	msHisHIyOtDjKe9xMJbZHgUg9BfaCaXpZqwDVZ/a8b/Y5fOYvpNd4hGc6opVMJzr
	XgcEhoAkOQ8mcLWLr+KQ4AM+IxLmG4DOkuwx9wakGUgEoHQGGsuBZnpn3HayhrjI
	LsfiFctAIaURc0A0MEnABu+WTUDufZsz7xUWFVtZ6uccFjpkFACHyIxhfjjcDjZ8
	1bB0ex5FuwhxAT3/bvuFpHZMxjj3KhGDl11zkaF35TkWTVAvXd/0FNww+lntJkn9
	B7BoxufdrXQDZrlc+1Of08zWuC/ceRMeHHGXYHJ/GOhI0szo6kX78331zvlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008979; x=1725095379; bh=EqkRaVpezP5Gle8sx/YgIgo3+DjD
	vKZHMRTI7S95LHg=; b=R4bJeZUY7Oh0ghjrBwwUlksTXtxUz6i0JkC8Fe5QSdbD
	YZ+FS9o2bqyKF/xL92+edyMCWnJ+kefU4wMlvcjOP7n5b2eNo7+JdCjuBr/2SMUt
	1Z0ZY+B41kDApSQBYw+d2YUyR8AInhT4cuOuJGPmEg9nLqRUSjFwQHB5C3nDDrFU
	bwoOmBaJpi8OwjShKOpxY9ZtHrXwdTTCJHCavmOHGVjpWRzUeIoSmryDQyEX7Pyt
	6nnv6r4HG89bFVMpTEeD/i4E02ayeG/WO/sskDYSCi6DN8ao5R7BaGRpozRBD29P
	tendtDhgRuXmkbuyp4Ipl82DSrQrWL1HpZwfCosz3w==
X-ME-Sender: <xms:UozRZsQl5co0Ibls8i5e-HxExMB-H3QtLlqzlt7tLkbXDwyN671m8g>
    <xme:UozRZpxIJVSU7ap154Bu0EQSEr4VdQv4CIuYVP_Cx_mRc9v9ehjOhQTy7IhDD83eY
    h6ZFo7TKBH9a2D3kA>
X-ME-Received: <xmr:UozRZp1qTIIpoPRsiGWAjidI7pQiMosRU9KlWyQsF3SimiZRU_ZfE4VuB55o5CkC_thaupFmx9utqecaX6oedOv-paAn7RWlafbOd-rmc4Isp9mR7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:UozRZgDf8dXwyTpNOhkCB10nfGQrCiYNnxWDp4TN34Ql-DwsEV68qA>
    <xmx:UozRZli3mTbs5TTgBOa3k-IIEy1XDaoMAOPx7pNDtCNbpvR-F-kv3g>
    <xmx:UozRZsq8MjAcnfK_MUXxQLCIuhIMj91iNS88PW8M34tWT-7KTtBQag>
    <xmx:UozRZohvDcQlrB9F13JsPnAC3vy5k7iCca2gFe5rdSd3e-r-kYvY7w>
    <xmx:U4zRZldnmolo773haixaXIVPjbM-KVM0CCqNwX6zBE4jTHYClXiwdQld>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 564d0fcc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:27 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/21] repo-settings: split out declarations into a
 standalone header
Message-ID: <0d7365c5190aabdf33990e36154d1807f199ed91.1725008898.git.ps@pks.im>
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

