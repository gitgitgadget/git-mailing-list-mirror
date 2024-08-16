Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7491127B57
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799177; cv=none; b=iV5hMVWQ/fX0Q+Q6xAqGZf2wBIzFZ0/yesVmZ6DUDxReBH/DWgiwSkeMJTMoyOSE0uNpi/KIpEkC26l8d8oqHCtFQakCHKDwZAXl/yfc6p9bSyVlayVdPOnT7d61gzoMJJ0YqUX4SY3/X1yz5IVaxCwij8HQ00pFX6JBxHeYvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799177; c=relaxed/simple;
	bh=DcY3cO/+xoHUqbbmKeCHKyLKH+vzXpg9AH0JEB0nNoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLeNq2PMBbh5hqwqYpHQ8ZMTJkdEf+jcT25bUMqTdy7ec5XCynD9G7/ajff5PbAjJu8ls01zYVkNxyLOzZFu+vubGoAz8ZhN59lnPQaxizYm6byViVVcz3ADhDQfVHGcbQpd8wBEPdSJxT/ECYPsBBluz4UqUjC0kf1QPi9cSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y9yfzK6n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KbC+fHKx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y9yfzK6n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KbC+fHKx"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id EC03D138FCD4;
	Fri, 16 Aug 2024 04:57:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 16 Aug 2024 04:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798630; x=1723885030; bh=87Knv1FmB0
	TrSoctDO/DybJ6vkkAy8aEIJMTZrp8lNk=; b=Y9yfzK6naatqsx8Zto8Uf0wAsc
	T4c63eA9+4LpKodGHYPQAavvWqSDkUVNY8nlrsaz5Sn/5Lvajp1xFij1rlJ9+GSj
	6XngdO4zmxeqePMaY0DPV7iS6gYoPZaOiygPVDtRSQqzIWus694Ov2m+ieW8D6Pa
	OQhCgjkJIMazrrIIGLKs+jKjbX2IbgKHfOxPYEf38cIDyjsjs8a3g4TNcKLWSNDp
	Gp4t0r/TZD7qssA/gOObhWvKeTBwQTMo8nskPolnSUW8at6cR3TKSKiq2Qo1LBBR
	7OWJRDEC23g+j26UIv3WzP1jL6nf62ZdUQHUqAhiIGNzVSmkJHGxWiFEHYrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798630; x=1723885030; bh=87Knv1FmB0TrSoctDO/DybJ6vkkA
	y8aEIJMTZrp8lNk=; b=KbC+fHKxb0tND1/AM4V7r9gqAdjnyfFl+GxmXKqzFf3T
	6j8Owlbwc/Btct/40me5zHCUUzXTIR9NXbe3Jd469semE5jFqoRgrxqWYIw3OxfK
	x1KITncVS2z4myDFCWRbneSsq1NOpo3q2BY1MyTLRGJExeIUFBpB4WXZmcKcqrGD
	k8XfKthBgPeRutP+RWUYSDcmYD4Ptdtj9rJ/1ibBmMRh5XlaDug5tEAREB/Y82kE
	JwWlqTnnDpRtywpRV9epbYGj0TdyJf/1Fx0ZTBMLvRw9akymCqihIMknxT8wlRsr
	MABxTWRs/C3QTwUSG1idoGhgjc9huV6ZtPbuvYY6gQ==
X-ME-Sender: <xms:ZhS_ZmVATC3VI95CqWh59D4c9Y4EMfdR4GJ34jjlPOFEtU5yfmxPcA>
    <xme:ZhS_ZilFZAaPDtQCrFyzkbMvuqsrBr3QCIFrnHW1eJwDGHt2_nWLMhH-0ESDpYwwI
    -P4_-fJcqzXCFI8Iw>
X-ME-Received: <xmr:ZhS_ZqagABa3RXZpKw1Hnjp9fmkGToql8YK0awP-4GH9FAkWS1MbKBAunQ35grhLDP2CF6GMiIixgf98cZKrdNBJS6pvyjTO7A9jBnAD7NzNeZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhstghhuhgsvghrthhhsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZhS_ZtX2hEA5Ua-JbgLjAA7iyx1ZayfxvJE1Zjk2aHuCaGKCkHtOCg>
    <xmx:ZhS_Zgk7AG3C6SbRNyhGzFOMAYCGFKOmcqYd3hbVYfY0yRb93D8XDg>
    <xmx:ZhS_ZifVVVn3Ns2w-4nSjvcFvEzRgqrIwblulhoMD9wlQWJ5gREC8g>
    <xmx:ZhS_ZiFdnuuNSk8mhWgOMQe1BxEfLtCyz0H8q_6eMenblaFeSkdB0Q>
    <xmx:ZhS_Zvu_L_LmfyFcWyzMLKVZmLMDTb8QgpZkcvC1Kr1MwKn5JRSjFtvo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:57:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 826feaf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:56:46 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:57:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] setup: make object format configurable via config
Message-ID: <85086620628b1fa136ebf7a1c9e2f64ebdbc7b92.1723798388.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
 <cover.1723798388.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723798388.git.ps@pks.im>

The object format for repositories can either be configured explicitly
by passing the `--object-format=` option to git-init(1) or git-clone(1),
or globally by setting the `GIT_DEFAULT_HASH` environment variable.
While the former makes sense, setting random environment variables is
not really a good user experience in case someone decides to only use
SHA256 repositories.

It is only natural to expect for a user that things like this can also
be configured via their config. As such, introduce a new config
"init.defaultObjectFormat", similar to "init.defaultBranch", that allows
the user to configure the default object format when creating new repos.

The precedence order now is the following, where the first one wins:

  1. The `--object-format=` switch.

  2. The `GIT_DEFAULT_HASH` environment variable.

  3. The `init.defaultObjectFormat` config variable.

This matches the typical precedence order we use in Git. We typically
let the environment override the config such that the latter can easily
be overridden on an ephemeral basis, for example by scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.txt |  5 ++++
 setup.c                       | 40 ++++++++++++++++++++++++++++
 t/t0001-init.sh               | 50 +++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index af03acdbcb..d6f8b6e61b 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -8,3 +8,8 @@ endif::[]
 `init.defaultBranch`::
 	Allows overriding the default branch name e.g. when initializing
 	a new repository.
+`init.defaultObjectFormat`::
+	Allows overriding the default object format for new repositories. See
+	`--object-format=` in linkgit:git-init[1]. Both the command line option
+	and the `GIT_DEFAULT_HASH` environment variable take precedence over
+	this config.
diff --git a/setup.c b/setup.c
index 5dfcdc99dd..770ad1393f 100644
--- a/setup.c
+++ b/setup.c
@@ -2284,11 +2284,49 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 	write_file(git_link, "gitdir: %s", git_dir);
 }
 
+struct default_format_config {
+	int hash;
+};
+
+static int read_default_format_config(const char *key, const char *value,
+				      const struct config_context *ctx UNUSED,
+				      void *payload)
+{
+	struct default_format_config *cfg = payload;
+	char *str = NULL;
+	int ret;
+
+	if (!strcmp(key, "init.defaultobjectformat")) {
+		ret = git_config_string(&str, key, value);
+		if (ret)
+			goto out;
+		cfg->hash = hash_algo_by_name(str);
+		if (cfg->hash == GIT_HASH_UNKNOWN)
+			warning(_("unknown hash algorithm '%s'"), str);
+		goto out;
+	}
+
+	ret = 0;
+out:
+	free(str);
+	return ret;
+}
+
 static void repository_format_configure(struct repository_format *repo_fmt,
 					int hash, enum ref_storage_format ref_format)
 {
+	struct default_format_config cfg = {
+		.hash = GIT_HASH_UNKNOWN,
+	};
+	struct config_options opts = {
+		.respect_includes = 1,
+		.ignore_repo = 1,
+		.ignore_worktree = 1,
+	};
 	const char *env;
 
+	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
+
 	/*
 	 * If we already have an initialized repo, don't allow the user to
 	 * specify a different algorithm, as that could cause corruption.
@@ -2304,6 +2342,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		if (env_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown hash algorithm '%s'"), env);
 		repo_fmt->hash_algo = env_algo;
+	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
+		repo_fmt->hash_algo = cfg.hash;
 	}
 	repo_set_hash_algo(the_repository, repo_fmt->hash_algo);
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 795408e16c..cd34710f32 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -523,6 +523,56 @@ test_expect_success 'init honors --object-format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'init honors init.defaultObjectFormat' '
+	test_when_finished "rm -rf sha1 sha256" &&
+
+	test_config_global init.defaultObjectFormat sha1 &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		git init sha1 &&
+		git -C sha1 rev-parse --show-object-format >actual &&
+		echo sha1 >expected &&
+		test_cmp expected actual
+	) &&
+
+	test_config_global init.defaultObjectFormat sha256 &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		git init sha256 &&
+		git -C sha256 rev-parse --show-object-format >actual &&
+		echo sha256 >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'init warns about invalid init.defaultObjectFormat' '
+	test_when_finished "rm -rf repo" &&
+	test_config_global init.defaultObjectFormat garbage &&
+
+	echo "warning: unknown hash algorithm ${SQ}garbage${SQ}" >expect &&
+	git init repo 2>err &&
+	test_cmp expect err &&
+
+	git -C repo rev-parse --show-object-format >actual &&
+	echo $GIT_DEFAULT_HASH >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success '--object-format overrides GIT_DEFAULT_HASH' '
+	test_when_finished "rm -rf repo" &&
+	GIT_DEFAULT_HASH=sha1 git init --object-format=sha256 repo &&
+	git -C repo rev-parse --show-object-format >actual &&
+	echo sha256 >expected
+'
+
+test_expect_success 'GIT_DEFAULT_HASH overrides init.defaultObjectFormat' '
+	test_when_finished "rm -rf repo" &&
+	test_config_global init.defaultObjectFormat sha1 &&
+	GIT_DEFAULT_HASH=sha256 git init repo &&
+	git -C repo rev-parse --show-object-format >actual &&
+	echo sha256 >expected
+'
+
 test_expect_success 'extensions.objectFormat is not allowed with repo version 0' '
 	test_when_finished "rm -rf explicit-v0" &&
 	git init --object-format=sha256 explicit-v0 &&
-- 
2.46.0.46.g406f326d27.dirty

