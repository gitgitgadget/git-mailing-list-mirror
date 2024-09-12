Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E81A42D3
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140609; cv=none; b=uOBSI4u/SyatDfdFCXGNdhU18aqO2Z36fmtgzZXMjOrr9O36K+qGZ2GnscspGQKgT2fSsnCxeojySgJYXSzL4OB1UsGkNF37oiHVvEByXKbn0IS7CiNhi4JJi8ikgFDCcF8YGbOPG2SKpmTz23rhSfF7KnjC5EqE+i+kCnne9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140609; c=relaxed/simple;
	bh=LO+zotbZUd05gVv8/HiZ4GvIhpRNdm/bs7lYGXz3bl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQMPz3gm1ULZXkQbvbS5DyqQkJ2fKm7ed2lbrdrv0wqhOijF+/KaNdN37baLecgQLwZ7SZFtm8IuWWc6qLv5XOdqnCiH5E+etC7QbxSTZyiNaCipva56oRayUuNOndifLyJJQl9uD8+8eMo5lqPjSpXEVhVhKfGmO+ZlhWMM0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kvS6FOPR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psticSmU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kvS6FOPR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psticSmU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F45E11405B2;
	Thu, 12 Sep 2024 07:30:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140606; x=1726227006; bh=WNhDvg3Xn2
	L5Gxaf0O2TfCsRu8l24hNy7LNPtqbnRpU=; b=kvS6FOPRTnjKj6dmMGpT8pUQ+E
	gz9eLszRZokJO8qU0YBpixDvxjSNsFVtE3PLLXNEjUWRG5HvQdRsASZQemtsLh8I
	6zpRfqstkEtR9IBGT2VyHGYtxAERTV4wb14hnQIcaqEiMsv9QpkbQo8DCmBlv9AN
	xzKRupgWXwR68XBI4O01C7bqAvR6YSkYUoogQXj1PWaa1v8uo6UgAoNSOH+KkKK8
	ZvNEnBmSoLVE/Natl8yeESxIMdhWh3/uWyf8bYLJ4nXWKHKzlQ2Ok7rUJDb3VTWK
	iKJWRyH1Wl5L1Rl78BNFL7UqzMQAU0jCFSbk8TFC4O1F715gaXQCD6XrKe/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140606; x=1726227006; bh=WNhDvg3Xn2L5Gxaf0O2TfCsRu8l2
	4hNy7LNPtqbnRpU=; b=psticSmUUWo2bi+GzYIfgnYoaFqIBC9DKQ+gwfWLIK+N
	Rju2p/8Ovqip/6LU2Ap2FjknF4oeMeSWrOfde13HCLt+ohokfhBHe2sUQWI133o0
	wbPVqGgAK1Q0n+dPHnMbGWhC5+YpQpc1Y+ocvR5IZFQ7kh18T8ccWj0yQ1TjozbF
	bsUGyDHCeL+Rsk6lxqWRCf760QTIqmRoPisWrQf7HjRcNdB5SaLKcVqbo/wGLhsb
	eJZOhKfNjEebsmoqty3S1cd1thveqrG6Y01/qLi0uHk8mXn32HQE2lcp8o05zMEM
	C/bWXI4nONsTnSQsBNVBovEoeFX5hv+pp4LQ7TwMaA==
X-ME-Sender: <xms:vdDiZlWUTAjHdxMXbTSaQW4AL2PPCrHKq-kD0GCZ0vVVnxunKY82nw>
    <xme:vdDiZlmiMRL3gX7VQLvCb65vQsYlJfxBlzi--FlqPgvH99PFi0Ph4ENbnCg4sWpsx
    Bw7mJCpUerwZsSmJQ>
X-ME-Received: <xmr:vdDiZhZuaiZexlwEKk_JohhieDj9eW7VxovLPmntgn5pmlVIanFZqluxMuQ86PYLSSqvt8S88wHGoI1yh56SiG340TjeG-o_j9aDiIWyU_vT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:vdDiZoUPZM97GDtFwI-gMwU8S3DxmWg8KKmTjNnpv_aDPqvoQ0fz0Q>
    <xmx:vdDiZvndaxSwZUdPuI5x6grrUf54yfBd2oPy5NXCg9K8bpQ0jr5PUA>
    <xmx:vdDiZlfVzas8RS8bHqRCr1ZKliuMQeSitnPXQbN3A37VciieeOfszg>
    <xmx:vdDiZpGRIaXf2zVgGokrTpXTaZ2gUWtY5qcXnDAArDBq-AQtMYm9dQ>
    <xmx:vtDiZqt5cnWVc4XAe1mRZ7uKnbsfac0u-D69vcRsgMwJ2qZJOaVKJeWm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:30:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b328ee6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:56 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:30:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 14/21] repo-settings: split out declarations into a
 standalone header
Message-ID: <a9d032b3ec7cb4cc99198c66ac8d003fea3f6883.1726139990.git.ps@pks.im>
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
2.46.0.551.gc5ee8f2d1c.dirty

