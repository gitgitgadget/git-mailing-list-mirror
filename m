Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2792210C0
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914622; cv=none; b=tifxx4AqyRx7puVFOO4tTyhskfnvIQm2Q1S8i03ndNKKsxrq8lRkCkIBXfQOQ+HXtGtFxEIo9H5hxY9heN1wNCtwiHc50jo3mlsIZvEYPQ0idZSa/EgNlEnjgIoP+7P6Wf6w9NZk1TEPFUzruhF9vgGFA00V2XMSsrznIvD5X5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914622; c=relaxed/simple;
	bh=NIJpnmpdZQbYOT+T9G1AaGOfnzOFAdSBgIN2g1qqnYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7i1AI7L/0/AF5gvLG4qHj21plLR4Td6nTGJ2tLy6e0uP388ldt9cGYlf8XDFRqGmtf9r22T/8kxcqAge0ZK0C6VYq/m6OA7uNMSP2ZWtlIsiDx1XYmj3ZfwGkRuwrcZVPatJAkzVp1Hi4XS/+V2i0roJyWNoG20iEBsrVOc6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uf6hl/IZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qsduKURu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uf6hl/IZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qsduKURu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 884A4254026A
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 05:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914619;
	 x=1734001019; bh=yCosVgKgTrYo1CjaKigq8xkwAyTd1ZgSOCJJ/T+eS/k=; b=
	Uf6hl/IZ1EadKgpOBg09/IysaXtwsHBCIwWyYMiivnlB9gWex6qkaL/qNsVrhzbr
	azdTW9Upz09Q5+3WpMXsjiKjxGXonpWa7GuYBAL74hO+HGzwrtINWtZ1h42803X6
	AACy8OR1RLPAlJAdThZKCtz5/oel+PFexW1E0QrzGo7VFJujE+0UVBJb98nJ4r1R
	8Xjqj71L6xTpJZw4A8NIg/6v9KOtD6pOeDW6Nxgr+q3AmOOZdeLJ4xBie4a6YWLY
	zqjC+3bYeFQkZ/pUOhCkrVZVVfUWr/tOQGLfvKifukK9EgZeStCci9r7eZ7uXexc
	uRmPXO/KMTOet8eIveRu5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914619; x=
	1734001019; bh=yCosVgKgTrYo1CjaKigq8xkwAyTd1ZgSOCJJ/T+eS/k=; b=q
	sduKURuWzuvgdPSyzG4LNupKb0yWprZDP9i1xVa1Y0E/B38h4EGHboSb4IALRFSG
	V3J/DGXcitPEfUIvpTPYEiKOF8quRJZFgoMST0ILuPdSZP+ACEumBh9TPpOeB4Ld
	FOeYbsDshol3Q0GMM3iBzFEX02Y6iag/DvlElevhj4INvObeNTatOLKQ53uXGiP+
	VMfyzFa1Ba2UTPclAi2tL4OTlWrtybPcXOiXkPMi1ZJnphExSoNumYE6nURFqI4b
	y/WWQvcwyOIW6ixusiEdVz+1yEK9drzVhRar8jKHZ1pxfy2RpwVvsUc1R7Oj1g1L
	l2dQvRRhgI8CEH7yMYxng==
X-ME-Sender: <xms:-29ZZ6CLGSCapb8RcHk4-z74wUBHNvBYEM_WzG6llnnRv12rcFsq5Q>
    <xme:-29ZZ0hPyF3vAn05jqAtv_X8DvS208CgQxG-xDzbrkWShQaR-IhjI4TsZQb2WJLBI
    _7OiiPZ0edCGzOvnQ>
X-ME-Received: <xmr:-29ZZ9nJRGPH0HYWVrdHCGAPupchtDUdrpf5LGLDq_UDIY6E3ATUklggR3b1W-QBjL4b1Q2hv5SdWYHe76s0gEbMUa73DZjvAlAVFSxTGTbvbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-29ZZ4xTkpihA1un5l1J4Tyy9uygE642paaiz2gdRUbuv-vV3sIL7w>
    <xmx:-29ZZ_QesRa6-pm9Wpn69DtHAh2KaX44LGXz0hMT_8CUA3_fNrXkRw>
    <xmx:-29ZZzYCEG3mu_SiDbpTTActXYT3jVoMotM2y8LG5ngKInQLZ_0rcQ>
    <xmx:-29ZZ4QGMyLNdyJO7Oqj8512g38pNABNFm4sCDzVzyTo_jGvBsjl9g>
    <xmx:-29ZZ2LEU6-hGNJhgj_mh8M1pBQ8f7W2TFw16jEz8HXwFuIFAFE-Od74>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1c9b22a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:55:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:56:41 +0100
Subject: [PATCH 5/5] remote: announce removal of "branches/" and "remotes/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-remote-branches-deprecation-v1-5-1431e2369135@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
In-Reply-To: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Back when Git was in its infancy, remotes were configured via separate
files in "branches/" (back in 2005). This mechanism was replaced later
that year with the "remotes/" directory. These mechanism have evenutally
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
index 27acff86db4883a7d7967343c61711959b75a473..f9a3bc982efc1deb6570d1911e9f34731c6c2864 100644
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
+have been deprecated for almost 20 years and 14 years respectively, and I am
+not aware of any reason why anybody would want to use these mechanisms.
+Furthermore, the ".git/branches/" directory is noadays misleadingly named and
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
2.47.1.447.ga7e8429e30.dirty

