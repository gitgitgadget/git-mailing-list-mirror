Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCB19DFA9
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708819; cv=none; b=d79SbzKCj55aParnpX2FiLI5JWXWGxbGUdBAKQN+CHGFBcs9ylSzVmXMlC6rv3Vc4lcNVDS3Bep+02vGNkPVmFk8zVFqrh0g6EuQNteUQUiuoCF2CAnVwwgdBbGlzvh5uScf82vlkveLhj2jIdxRnIQtrtedPdJJi4/67ADye6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708819; c=relaxed/simple;
	bh=GV8TZwlpPamBnFRlnAMmJWUgbkPHpKXWWYhNmnr/NdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ/rHTvCd8JDkJK4FWSox+m+CgIk1vSb/wwn6SOxz2Q873jlryj9b9tbZGZdM+NPp7puQAHAlOSDwLHyrVKUyPxqXHyyQ9veZKqAYEykL+i6S2fPbml7VYC0u81HPP71GTpDBGQlQ5iqL02cGs0Bc8xSOD3SgR1+sQ1xkilxC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=POilrCTr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFk/ogTY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="POilrCTr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFk/ogTY"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 502061151D1C;
	Thu, 15 Aug 2024 04:00:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 04:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723708809; x=1723795209; bh=QAHkKwx6uF
	DNyDabAsWzV+m3owbZBOH55F9xLP1j8Ig=; b=POilrCTr0zHhotbLBi5lUwBfl0
	q1pk904SYA9Odf31ZdFZ4mqsNNRsWsd1PUXofZwldhhBVSOgmDUNw//i7v1cjuq1
	A1CdmJIf21ifJOsoEwZRNlUtD1HG5g9NTSRY3WIGUvuy0IfZwl2Ck1JXiTwFYnUB
	2h9FOGA4TRW/RUxdl/PqDrmRJqTV6nMYPv4pc4EkJsP5s1oIjVwDCW/pYOzLF4/F
	Z13tvLg2kXbup9X5OP5UhE8y2gGCaVqHAjsRvF9rV7nIRC7oAb6jskPooz4hubUf
	Juq2ZkwQhf6Ej30nFLEkgBLS0auK5s7Jn4ELG78IxHxYYX/k94BqI9AQxqzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723708809; x=1723795209; bh=QAHkKwx6uFDNyDabAsWzV+m3owbZ
	BOH55F9xLP1j8Ig=; b=AFk/ogTYsA6bBk2e13oQJ87uqPyNO4ORQwc43ramSNQ6
	u3ttXRmuCyN13qgbabV7BWYs0cy1ENZEJAn6H5DixxLLFccP+Z5+Xu56Ac9glZsW
	CLS1Fv9dyvaz9Uqs78ZBMYPJzWsFezmWtq7H7qn8CLQW4plBKSKSNy+ZzildwFAS
	kzSXreQbb1JsWu9scZRF5w9trATPTYew9HLnGugmgOj885suq2jpkv1gY15xtJbm
	YQro4znz41jzkcU1EBLkGufxK0dC+toz/WL43zUY3K4ymiGJIqTbvsfIhGL31RHw
	A2/6xWhdr6Xog1n90GPSRjl2Xi2lJ1jwVXoyr1spcg==
X-ME-Sender: <xms:ibW9ZtzyQ5X-ZV_DxHb1gjK8UuvpmStSRD90ADM__WQqn7zJ1k23_w>
    <xme:ibW9ZtQr5owi0AbYf5cFG8mX2gMWbRs6m07ayfZcB6Tvn7empOnp1OMLkXM4Nb2lY
    2FRGslyekYl_1DX8g>
X-ME-Received: <xmr:ibW9ZnV5MQAIg_4HIl1B_WQDANVXSUUmYlKD5PyMMZiHlAurCzIlBlJX342CydqWZGYkt08QdsOQ_ZUZMCfpcVU5a-bzGVRo0310kW1ekehFbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhstghhuhgsvghrthhhsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ibW9ZvhA7zq1U-ej5AAGyRmMzNr50Re3_SqgKVkQ0evHoFVUuxfEHg>
    <xmx:ibW9ZvA9IT35kWa2YnhAsx0B2vj09NbohouZk1G_j6_WHNkZfjqZZQ>
    <xmx:ibW9ZoKb855TTCK-vT25YlL6dqFdhmBmHNkoTjjF3dZ2eTrr8cGzGQ>
    <xmx:ibW9ZuCT5RXnPqwydK183O8SotyGp60wGiXsJPsZcxQGkeSUkhtzQQ>
    <xmx:ibW9ZiMZPEckKgiYSk8apThsXsCxTBsD6IZs7h89Ysd7Opw25LlvMhDr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:00:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a88e3ee6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 07:59:47 +0000 (UTC)
Date: Thu, 15 Aug 2024 10:00:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 4/5] setup: make object format configurable via config
Message-ID: <e1cdaf0f0edec578d1cb9358fd4c6f6b39aaad3a.1723708417.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723708417.git.ps@pks.im>

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

