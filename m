Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96181D7984
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149907; cv=none; b=u4YrYxRa4v2GksG58d+WvVMdF9tJ1W0nwa9RtjQW6lCaYzC9dfVkwVUo+/SNgCX5wvanLFy2zEr04LnRgyqgjFOYy32oOu6vD2fMcN0ZEDbfb2abc0kcHOrOXQdHc2zCPjm8/rTFeu3K1KijCOjPOLoVTt+eGmgUgpZHk26YJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149907; c=relaxed/simple;
	bh=F94XyCJ7XMCjSUkh7JjvxEZw2N+2TYqDfXSbOe2XtQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4JjmHNj+w/eK/l18RhPpX18xWRrfKtU7zNI+FGlRWIYZ7INYkLsqVfP55Gz/rK0NSm4oPCKfdPU1WVHcUp3lXmWmTzgiVEISKDW+YxbreqYgn1zI+CIuwc4oYLieJU9FF7gnBY8VWlbSSZYuOPO9DMgxpEkkn903D1DVqwzW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mbhx6/3f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beMiOdeW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mbhx6/3f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beMiOdeW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id F06AC1380927;
	Mon,  6 Jan 2025 02:51:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 02:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736149903;
	 x=1736236303; bh=MgEuIRniV1tAj4AlpIomrnK2+ZJRGUrSTP+4e/IOD0k=; b=
	Mbhx6/3fNXh1s+StWfUP7sTZ5VpHyrItNVlNUujRSCIFnI1Tds/f/7CTjGDN28ve
	mdq7U9q86EWGCUtyjRfU2POw4ceA8asnFtwRWBWwGfgikc3qT2DemmTle1rLGM/m
	0wXRY7IEcKNYNkKsOBPwhPN9uoxyWVv4Lf0v2KAdaynBIRWwQWiFzfgUo4VAXoW1
	YO3JjoJBJSyDJN6hY+RlrCdkIvkmoScgmuISFO4N/1Sa0q9bA82h2+5/vdmTrE+9
	zXzuVvZg9b7hofjjcGfuV9udQmQKSdelWv4YItGZuQnsO0wievH7NjxMugLu+tWB
	RxiHdz4W/cX6hs8yvONGlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736149903; x=
	1736236303; bh=MgEuIRniV1tAj4AlpIomrnK2+ZJRGUrSTP+4e/IOD0k=; b=b
	eMiOdeWpooKMbpGz0VA4ZosROxMvSZwW+NPWgNnRbcskcUMUhTWgVXppD8ZCbV6D
	VrNq8LqHYVhllH6AhJGmFu07WEwrxwBN9QyqS2iH2nlPPIV7LABggHOmF6z/Iybi
	iUB7RtGme9wMQOm+PvK+w9MtXC2yP9wb8z6+nH3BKKa93RXV/KpNnWzPGr2UPE3P
	iJLAiOk00ZaDKjepp0/4RWzTAVeeQ27/xVMGXVh73rIpyrFBJFcBwqf1fdg9EH93
	Z6h42UyAxntjrUquLtfDmqdztSNRNfwkBrLAPn2LTu50hHdEVgE8jKsAypd80NPK
	VCdpIdanA/MGE5ijGiXjg==
X-ME-Sender: <xms:j4t7Z2Va-Dc4IO9Njt-kQuidIs5UBfd3rmugfZGRFFmQcdpbG8x_NA>
    <xme:j4t7ZylXBymjQ9sASheBSt-ComQbM_knh4qX7ohE0a2tOidseqmih_Jnk5jgr6MPc
    MmN4eVhQO2sDpby3w>
X-ME-Received: <xmr:j4t7Z6ZKm-8nvwGucAgesfpLgJyVG_-lyGQllIbvlDl5nbErB5z3i50MVM8HnHlhe9LP-G60g50o-ldsXX-pAILCOKmJg5MHqFiJQAgxdSuDWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:j4t7Z9VYG5QCZNNE-A0kAGvHiLgJkrX6rkkUZWelIVUoxcaCB9dV0A>
    <xmx:j4t7Zwn1E3inl-WNje10VlWUembJ829uI8Q65ajiGfhSU654t0h8Jg>
    <xmx:j4t7ZycH2EFJc2BQRCO0R8F--TuCMxBHvZzaSjEj8OO4YQCtiAPWUw>
    <xmx:j4t7ZyGn-fs425GQyzXU_Jyvl66g3B4WJSQTQ0Re7i4aUevZ4ccgxw>
    <xmx:j4t7Z1w62518FBlPFaUmTLphrxFsQmnIJ_E2nNRTyMlzxmowat8hXkXR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:51:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1dfe61e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:51:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 08:51:37 +0100
Subject: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Back when Git was in its infancy, remotes were configured via separate
files in "branches/" (back in 2005). This mechanism was replaced later
that year with the "remotes/" directory. These mechanism have eventually
been replaced by config-based remotes, and it is very unlikely that
anybody still uses these directories to configure their remotes.

Both of these directories have been marked as deprecated, one in 2005
and the other one in 2011. Follow through with the deprecation and
finally announce the removal of these features in Git 3.0.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt      | 25 ++++++++++++++++++
 Documentation/gitrepository-layout.txt |  7 +++--
 builtin/remote.c                       |  2 ++
 remote.c                               |  6 +++++
 remote.h                               |  2 ++
 t/t5505-remote.sh                      |  6 ++---
 t/t5510-fetch.sh                       | 13 ++++------
 t/t5515-fetch-merge-logic.sh           | 47 ++++++++++++++++++----------------
 t/t5516-fetch-push.sh                  | 14 +++++-----
 9 files changed, 79 insertions(+), 43 deletions(-)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
index 27acff86db4883a7d7967343c61711959b75a473..a91eb3bc5518d09b39c49ce07964ca3aba7b11dd 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -154,6 +154,31 @@ Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>,
     <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>,
     <20230323204047.GA9290@coredump.intra.peff.net>,
 
+* Support for storing shorthands for remote URLs in "$GIT_COMMON_DIR/branches/"
+  and "$GIT_COMMON_DIR/remotes/" has been long superseded by storing remotes in
+  the repository configuration.
++
+The mechanism has originally been introduced in f170e4b39d ([PATCH] fetch/pull:
+short-hand notation for remote repositories., 2005-07-16) and was superseded by
+6687f8fea2 ([PATCH] Use .git/remote/origin, not .git/branches/origin.,
+2005-08-20), where we switched from ".git/branches/" to ".git/remotes/". That
+commit already mentions an upcoming deprecation of the ".git/branches/"
+directory, and starting with a1d4aa7424 (Add repository-layout document.,
+2005-09-01) we have also marked this layout as deprecated. Eventually we also
+started to migrate away from ".git/remotes/" in favor of config-based remotes,
+and we have marked the directory as legacy in 3d3d282146 (Documentation:
+Grammar correction, wording fixes and cleanup, 2011-08-23)
++
+As our documentation mentions, these directories are not to be found in modern
+repositories at all and most users aren't even aware of these mechanisms. They
+have been deprecated for almost 20 years and 14 years respectively, and we are
+not aware of any reason why anybody would want to use these mechanisms.
+Furthermore, the ".git/branches/" directory is nowadays misleadingly named and
+may cause confusion as "branches" are almost exclusively used in the context of
+references.
++
+These features will be removed.
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index fa8b51daf08775f3d666a910d9b00486627e02af..85911ca8ea0b222ab9cc3dc2dd99c5136c72bd2b 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -153,7 +153,7 @@ config.worktree::
 	linkgit:git-worktree[1]).
 
 branches::
-	A slightly deprecated way to store shorthands to be used
+	A deprecated way to store shorthands to be used
 	to specify a URL to 'git fetch', 'git pull' and 'git push'.
 	A file can be stored as `branches/<name>` and then
 	'name' can be given to these commands in place of
@@ -162,7 +162,8 @@ branches::
 	and not likely to be found in modern repositories. This
 	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/branches" will be used instead.
-
++
+Git will stop reading remotes from this directory in Git 3.0.
 
 hooks::
 	Hooks are customization scripts used by various Git
@@ -238,6 +239,8 @@ remotes::
 	and not likely to be found in modern repositories. This
 	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/remotes" will be used instead.
++
+Git will stop reading remotes from this directory in Git 3.0.
 
 logs::
 	Records of changes made to refs are stored in this directory.
diff --git a/builtin/remote.c b/builtin/remote.c
index 1ad3e70a6b438a3c4446b16c02dc5c23c7fa14be..e565b2b3fec8bf2e4182e85d8d08953a14416881 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -640,10 +640,12 @@ static int migrate_file(struct remote *remote)
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch.nr; i++)
 		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
+#ifndef WITH_BREAKING_CHANGES
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
 		unlink_or_warn(git_path("branches/%s", remote->name));
+#endif /* WITH_BREAKING_CHANGES */
 	strbuf_release(&buf);
 
 	return 0;
diff --git a/remote.c b/remote.c
index 10104d11e3cba1908cd35f22b54e167755770404..55e91fab47197313fd8c2c1c5f73fcd46b4df4f7 100644
--- a/remote.c
+++ b/remote.c
@@ -293,6 +293,7 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 	rewrite->instead_of_nr++;
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static const char *skip_spaces(const char *s)
 {
 	while (isspace(*s))
@@ -374,6 +375,7 @@ static void read_branches_file(struct remote_state *remote_state,
 	strbuf_release(&buf);
 	free(to_free);
 }
+#endif /* WITH_BREAKING_CHANGES */
 
 static int handle_config(const char *key, const char *value,
 			 const struct config_context *ctx, void *cb)
@@ -572,6 +574,7 @@ static void read_config(struct repository *repo, int early)
 	alias_all_urls(repo->remote_state);
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
@@ -583,6 +586,7 @@ static int valid_remote_nick(const char *name)
 			return 0;
 	return 1;
 }
+#endif /* WITH_BREAKING_CHANGES */
 
 static const char *remotes_remote_for_branch(struct remote_state *remote_state,
 					     struct branch *branch,
@@ -725,12 +729,14 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
 				   &name_given);
 
 	ret = make_remote(remote_state, name, 0);
+#ifndef WITH_BREAKING_CHANGES
 	if (valid_remote_nick(name) && have_git_dir()) {
 		if (!valid_remote(ret))
 			read_remotes_file(remote_state, ret);
 		if (!valid_remote(ret))
 			read_branches_file(remote_state, ret);
 	}
+#endif /* WITH_BREAKING_CHANGES */
 	if (name_given && !valid_remote(ret))
 		add_url_alias(remote_state, ret, name);
 	if (!valid_remote(ret))
diff --git a/remote.h b/remote.h
index a7e5c4e07c53ce5a0f6d852ce9f9233e6bb61550..45b0c9babb1374a05471e86de2c248972adb2aae 100644
--- a/remote.h
+++ b/remote.h
@@ -21,8 +21,10 @@ struct transport_ls_refs_options;
 enum {
 	REMOTE_UNCONFIGURED = 0,
 	REMOTE_CONFIG,
+#ifndef WITH_BREAKING_CHANGES
 	REMOTE_REMOTES,
 	REMOTE_BRANCHES
+#endif /* WITH_BREAKING_CHANGES */
 };
 
 struct rewrite {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 08424e878e104cc19a43960b987cf868f542cad2..e96ac8c7676ceeb7299c8f0839d9654d527ae084 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1007,7 +1007,7 @@ Pull: refs/heads/main:refs/heads/origin
 Pull: refs/heads/next:refs/heads/origin2
 EOF
 
-test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/remotes' '
 	git clone one five &&
 	origin_url=$(pwd)/one &&
 	(
@@ -1033,7 +1033,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	)
 '
 
-test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/branches' '
 	git clone --template= one six &&
 	origin_url=$(pwd)/one &&
 	(
@@ -1049,7 +1049,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	)
 '
 
-test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/branches (2)' '
 	git clone --template= one seven &&
 	(
 		cd seven &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 3b3991ab8678a57fce3ad371e37900fb3c6c426a..04d8a96367910d4687b18a8f725dc365cf2ceedb 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -34,14 +34,11 @@ test_expect_success "clone and setup child repos" '
 	git clone . three &&
 	(
 		cd three &&
-		git config branch.main.remote two &&
-		git config branch.main.merge refs/heads/one &&
-		mkdir -p .git/remotes &&
-		cat >.git/remotes/two <<-\EOF
-		URL: ../two/.git/
-		Pull: refs/heads/main:refs/heads/two
-		Pull: refs/heads/one:refs/heads/one
-		EOF
+		git config set remote.two.url ../two/.git/ &&
+		git config set remote.two.fetch refs/heads/main:refs/heads/two &&
+		git config set --append remote.two.fetch refs/heads/one:refs/heads/one &&
+		git config set branch.main.remote two &&
+		git config set branch.main.merge refs/heads/one
 	) &&
 	git clone . bundle &&
 	git clone . seven
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 320d26796d24d8a2281d37220a7bdf73cafaa503..4e6026c6114fb8367136173ea2b7fdbc0baa37fc 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -104,28 +104,31 @@ test_expect_success setup '
 	git config remote.config-glob.fetch refs/heads/*:refs/remotes/rem/* &&
 	remotes="$remotes config-glob" &&
 
-	mkdir -p .git/remotes &&
-	cat >.git/remotes/remote-explicit <<-\EOF &&
-	URL: ../.git/
-	Pull: refs/heads/main:remotes/rem/main
-	Pull: refs/heads/one:remotes/rem/one
-	Pull: two:remotes/rem/two
-	Pull: refs/heads/three:remotes/rem/three
-	EOF
-	remotes="$remotes remote-explicit" &&
-
-	cat >.git/remotes/remote-glob <<-\EOF &&
-	URL: ../.git/
-	Pull: refs/heads/*:refs/remotes/rem/*
-	EOF
-	remotes="$remotes remote-glob" &&
-
-	mkdir -p .git/branches &&
-	echo "../.git" > .git/branches/branches-default &&
-	remotes="$remotes branches-default" &&
-
-	echo "../.git#one" > .git/branches/branches-one &&
-	remotes="$remotes branches-one" &&
+	if test_have_prereq WITHOUT_BREAKING_CHANGES
+	then
+		mkdir -p .git/remotes &&
+		cat >.git/remotes/remote-explicit <<-\EOF &&
+		URL: ../.git/
+		Pull: refs/heads/main:remotes/rem/main
+		Pull: refs/heads/one:remotes/rem/one
+		Pull: two:remotes/rem/two
+		Pull: refs/heads/three:remotes/rem/three
+		EOF
+		remotes="$remotes remote-explicit" &&
+
+		cat >.git/remotes/remote-glob <<-\EOF &&
+		URL: ../.git/
+		Pull: refs/heads/*:refs/remotes/rem/*
+		EOF
+		remotes="$remotes remote-glob" &&
+
+		mkdir -p .git/branches &&
+		echo "../.git" > .git/branches/branches-default &&
+		remotes="$remotes branches-default" &&
+
+		echo "../.git#one" > .git/branches/branches-one &&
+		remotes="$remotes branches-one"
+	fi &&
 
 	for remote in $remotes ; do
 		git config branch.br-$remote.remote $remote &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9d693eb57f7790ddb81cee0b905a101719069562..e705aedbf4a8d57ed188918077b9f82ed8e77b51 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -975,7 +975,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 	! grep "warning: updating the current branch" stderr
 '
 
-test_expect_success 'fetch with branches' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'fetch with branches' '
 	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
@@ -991,7 +991,7 @@ test_expect_success 'fetch with branches' '
 	git checkout main
 '
 
-test_expect_success 'fetch with branches containing #' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'fetch with branches containing #' '
 	mk_empty testrepo &&
 	mkdir testrepo/.git/branches &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
@@ -1005,7 +1005,7 @@ test_expect_success 'fetch with branches containing #' '
 	git checkout main
 '
 
-test_expect_success 'push with branches' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'push with branches' '
 	mk_empty testrepo &&
 	git checkout second &&
 
@@ -1022,7 +1022,7 @@ test_expect_success 'push with branches' '
 	)
 '
 
-test_expect_success 'push with branches containing #' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'push with branches containing #' '
 	mk_empty testrepo &&
 
 	test_when_finished "rm -rf .git/branches" &&
@@ -1211,18 +1211,16 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 '
 
 test_expect_success 'push --prune' '
-	mk_test testrepo heads/main heads/second heads/foo heads/bar &&
+	mk_test testrepo heads/main heads/foo heads/bar &&
 	git push --prune testrepo : &&
 	check_push_result testrepo $the_commit heads/main &&
-	check_push_result testrepo $the_first_commit heads/second &&
 	! check_push_result testrepo $the_first_commit heads/foo heads/bar
 '
 
 test_expect_success 'push --prune refspec' '
-	mk_test testrepo tmp/main tmp/second tmp/foo tmp/bar &&
+	mk_test testrepo tmp/main tmp/foo tmp/bar &&
 	git push --prune testrepo "refs/heads/*:refs/tmp/*" &&
 	check_push_result testrepo $the_commit tmp/main &&
-	check_push_result testrepo $the_first_commit tmp/second &&
 	! check_push_result testrepo $the_first_commit tmp/foo tmp/bar
 '
 

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

