Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAAC1D5CEB
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787450; cv=none; b=Vq9jgxubCC7yjn2E08SOkFG0vhZlzKNzc7qFG6209V5O3Oo995TFNQfSDkyWy2fcl7Gl9gpPYxytU/2INTtxqTxKf3GRO1mrl+ebOy64jsU29lMPgd/V9jmlZq4014rMoytEGz9fGRZFSC5B8+PEhrchJcUiKx9m8T/m9h/bL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787450; c=relaxed/simple;
	bh=Nx5BgxDdaWVvyV3eSH7cjiTUb9DtU6BSgRnLWE2sgQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dztlBd7zgLz4ZYyavZOs7wkxJ5ZMn5wacBNnrZiVY292syDdGitDBoDaxJe2gXNkqxGtez20W7s4/sqFHsowQWxw6c8qZkwjwa6bYzWhwJRkgsGQJl6FDNgTASkBEpAS2p7fQN0T0WEIUqFJqHoAdsSNrvk7wV49JViTqZ/GdhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eJZoi6Cw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9X1vtRY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eJZoi6Cw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9X1vtRY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76BC32540076;
	Tue,  5 Nov 2024 01:17:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 01:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787448; x=1730873848; bh=EYA2fFcw8O
	Hr6WykBKTaGxi2eJQNE+cRD46lbdQiA6Y=; b=eJZoi6CwIzmSIVY4ENmVlEsFv7
	mPQo/NpgyR10lkz7P3ki6SqN8JBTBOPJ8h8XIXTCSrkIdGnEb1aiQPVJVeygRHgJ
	CnYZ+5QidtbA/av15SKCqFSatbwd9J9TBEgzmGRyfgDkip94RgJ57gu9I0K1ttP5
	cbLAiNkeLLNn7QBk9DiDdM19xmKnuHleKfLyv1Q5Z8q6UxulekiNcduf6G4QJwuv
	4cn8vFu8IQIPevq+ChmnDuRzItQc+qPZgJ3q+rc/jQv3vJBtAt41VMkEiFXE9EOf
	2tfBMdf1jt/F8nSa0VmMMlPiH1qGuAsb3fwNQD1DaR4mgeoTuPhubjV0zYWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787448; x=1730873848; bh=EYA2fFcw8OHr6WykBKTaGxi2eJQNE+cRD46
	lbdQiA6Y=; b=L9X1vtRY0eJ+alxYCfHMbS2SXuAzzjE81l1ApSZyytupUgrdz8N
	4RO9lVHyZ/jVUvc8ftLTHKvun/lR7YZjzBRb1+JFwjwMHY8XoC+axAiU5f6simyv
	vrupsaPQkFhqhye5FS4P/6tc9KcjPeOoClLTIi91ZY+U4vlCWqnvG9Ty02zH+i4N
	eWNPQhSnjJo+2bQ+dm8A7dYGlGHpdw76sxxG+dAo1fRau/nhnDUHuGeUJK1YJ7qD
	ttDe49bV/wlbd3HNh6X7a3Drj5dkw2PjbxJ43JBHr5N2CjDFj+Nwpt/BFHaja3+o
	IOJdqYOv/8SqrmLQJWycd1u2Zt3FkDb3PDw==
X-ME-Sender: <xms:eLgpZwjjcQXUou5fjA9TjnREniTufvNvvGHkxCXT86pLgxYF3bE6rQ>
    <xme:eLgpZ5D2zCb-d4ybzrB2z4vrsXnyfsoriGt5SRc6k-spgGMiE8MZqZeSY-ITdlluF
    bwKKBS9Pc6XJYcFBA>
X-ME-Received: <xmr:eLgpZ4Gz6s4Q5A8gOs8saZ36He4CgvUYjXZfOXyrMw7awBrhyi0n5FiI6pAJeP1IGP-Ri47xqTC4q_EdAyjWvmLrVz92FPhpFSBM3jaUlFJBpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:eLgpZxTAA5VQZoKa8aOhMSaldbVPnSmhOV_A5h76ncMUJkOKZisiNg>
    <xmx:eLgpZ9yE3ndmHnTR_Bv2oTzGlrIlxExk6qEjGPCBglU94OqEQogWMA>
    <xmx:eLgpZ_7V0rhxPOHZHdsKCIy3gVcRiebMapi2lTX9u4Dm89Vyq-OYFg>
    <xmx:eLgpZ6zizBrB9RdX7i2HyM9AQGlAcFZnl9HLcNqQJEc44wGU_1MsDQ>
    <xmx:eLgpZwp1v--x_YvxmlzIOAdWQvx9J8xFfDv4ZdYBTV7oEjd1uehit-A_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5100918c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:05 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 12/22] builtin/commit: fix leaking cleanup config
Message-ID: <a627e03702e184f038607b78ec28085020b60ec3.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

The cleanup string set by the config is leaking when it is being
overridden by an option. Fix this by tracking these via two separate
variables such that we can free the old value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c            | 17 ++++++++++++-----
 t/t7502-commit-porcelain.sh |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 18a55bd1b91..71d674138c9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -135,7 +135,7 @@ static struct strvec trailer_args = STRVEC_INIT;
  * is specified explicitly.
  */
 static enum commit_msg_cleanup_mode cleanup_mode;
-static char *cleanup_arg;
+static char *cleanup_config;
 
 static enum commit_whence whence;
 static int use_editor = 1, include_status = 1;
@@ -1387,8 +1387,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
 
-	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
-
 	handle_untracked_files_arg(s);
 
 	if (all && argc > 0)
@@ -1636,8 +1634,10 @@ static int git_commit_config(const char *k, const char *v,
 		include_status = git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "commit.cleanup"))
-		return git_config_string(&cleanup_arg, k, v);
+	if (!strcmp(k, "commit.cleanup")) {
+		FREE_AND_NULL(cleanup_config);
+		return git_config_string(&cleanup_config, k, v);
+	}
 	if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
@@ -1658,6 +1658,7 @@ int cmd_commit(int argc,
 	       struct repository *repo UNUSED)
 {
 	static struct wt_status s;
+	static const char *cleanup_arg = NULL;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
 		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
@@ -1757,6 +1758,12 @@ int cmd_commit(int argc,
 	if (verbose == -1)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
+	if (cleanup_arg) {
+		free(cleanup_config);
+		cleanup_config = xstrdup(cleanup_arg);
+	}
+	cleanup_mode = get_cleanup_mode(cleanup_config, use_editor);
+
 	if (dry_run)
 		return dry_run_commit(argv, prefix, current_head, &s);
 	index_file = prepare_index(argv, prefix, current_head, 0);
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index b37e2018a74..84f1ff52b67 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -5,6 +5,7 @@ test_description='git commit porcelain-ish'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit_msg_is () {
-- 
2.47.0.229.g8f8d6eee53.dirty

