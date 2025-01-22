Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F1211A27
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545502; cv=none; b=Quz1ADeeVXegO2Wv56RhwiedAJO6PaiLR6VNwGzuZBIItDBN12QPncMNcN3K/2DJW7tUoy7MZ3f5x1+N9BMKmZtX1yeVHLLvhoNSlT55IvbfJ64/rNKRtnWHyRgTisnnQgcDJzl1eBRwCoQ4gA+VGrQ5lGQkM1xKtRL5g6/xDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545502; c=relaxed/simple;
	bh=VnYLdVtYL8RLYYbgjo+E5f3fqLnUBJqIHoIsPwHu2AM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIflW/BhWGFWqNBasRJyH2FEGBjMZTr3F1NMU6WWdKvarltghU+je1RRntvP4YzdN1RE5NS4WMl6PSuK3+4O00duBes21CQPl2YM4f/TyWAjwCu1nrH+bvz9B3ugRzMv7eQ6ltPVgacaXALUCxavEcbV1AsI9cu4tts/8ECstyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EyUGhRIT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GXIJQkja; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EyUGhRIT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXIJQkja"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD3E42540140;
	Wed, 22 Jan 2025 06:31:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jan 2025 06:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737545499;
	 x=1737631899; bh=6YJGkpQKHvHagOehyOyRSIgDEZJa1mfEzo8H9lZmzd4=; b=
	EyUGhRIThJ/CJP9RowopLP96VEwhfJnbeOSXOX9vur3AK6EcE6XPCot7PrLU9fC+
	s7241oxsEplsTtBa0Q4ZB7iVRZ150TyO8jZskrw+Hk4An0n1guT/jwBqIVH5R7Tw
	NNjp09ryw3e5W5mztpb+dgcCid9yvLkSKIY0alepFq35x+0dyhhxaAUg1HUrib7w
	nEx1lykUo/aRfB6J50taTpbnkdKHKuDHDsjmcZPhLlQ/C2mj8fU4r8wSIIiNNxVQ
	LhHeTc+1mh/V/owNoStZpLyPA7gBuJVYVH8NYv3Nb6JmO30MY1fSgo+Zrbhyb7cl
	lwgJ89qWgAAfSCTrd41glA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737545499; x=
	1737631899; bh=6YJGkpQKHvHagOehyOyRSIgDEZJa1mfEzo8H9lZmzd4=; b=G
	XIJQkja6w30ObLHWZYk8bYjQICtCYrWmW4zdt8ZxX6NVG42m1bfueI4BUyyDiPxu
	w7g86PxDY5EVeb6819ve+WCVRDaNfE4aLutY5jvtOH8PJR1MfmKJD5F+FUjJVSsZ
	RppgC9J2II32fXeMgbbrTKOogvvHk0OnsuOj4pcMJ9LBPdgNrCC8bC1yj01hXWhz
	V5tagLDnkjKQtuycIyQXp3utD0oGDibBF+tEFW1FP0bDD+bbhwHu25AtGtCugvGN
	1l1NbuJDs7pET1jURqXHAulAXVc9QBrfuGO++O7Awn2L+RYUII7ZXWKPegyFnFr0
	xVY9umsSs0uyVN+QvZHJA==
X-ME-Sender: <xms:G9eQZ07dPwwWVj90AGZVx42XMVu11Zz80TuaAWzeFSxKyvfQuDLzUA>
    <xme:G9eQZ15q44fPdCjBb1sBLbRlCskBC_Ui6OznpXCCwwvQr9qSmejgPs22RCOtgAHg1
    9hm-6wM0bMBfsd59w>
X-ME-Received: <xmr:G9eQZzcWbbevhISFW0OPNE03d7NBEzqrl_En1YECSkpfdK7wnMWPXHb-0it3akaayLDUaJ71qSXcFBRsvS0JsMdNQBoPPXQ9aCQEZ-kvRHx4ijI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhhosggvrhhtrdgtohhupheskhhoohhrughinh
    grthgvshdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghnuggrlhhlrdgs
    vggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtoheptghhrhhishgtohholh
    esthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:G9eQZ5JL_4zBQ7iKc2k2ElYZI3z-OJvmJ-X5PW0UjciCMNuyLTzpLw>
    <xmx:G9eQZ4IddOm3jDW0042zc-ZSq54CUrTc3NdjQa3GZOhUqxE_YHfCQA>
    <xmx:G9eQZ6z4sSlm2V4rFhndDEtY34ZKKpKT58OOaNWM2byUZF6er58GXQ>
    <xmx:G9eQZ8L6Xn_BsYe_orhlWLA3RH-Z7S8hbpS_PtBIKWZP6Iqup3NZJA>
    <xmx:G9eQZw8yt871ewUJ5lcHCjCZfMIXzHRPMX8bXs5xAeH-5z0W5m69nEfi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 06:31:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b26ebc31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 11:31:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 12:31:33 +0100
Subject: [PATCH v4 5/5] remote: announce removal of "branches/" and
 "remotes/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
In-Reply-To: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Robert Coup <robert.coup@koordinates.com>, 
 Christian Couder <chriscool@tuxfamily.org>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Back when Git was in its infancy, remotes were configured via separate
files in "branches/" (back in 2005). This mechanism was replaced later
that year with the "remotes/" directory. Both mechanisms have eventually
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
 remote.c                               | 26 +++++++++++++++++++
 remote.h                               |  2 ++
 t/t5505-remote.sh                      |  6 ++---
 t/t5510-fetch.sh                       | 13 ++++------
 t/t5515-fetch-merge-logic.sh           | 47 ++++++++++++++++++----------------
 t/t5516-fetch-push.sh                  | 14 +++++-----
 9 files changed, 99 insertions(+), 43 deletions(-)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
index 27acff86db..7c388e56c8 100644
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
+not aware of any active users that have complained about this deprecation.
+Furthermore, the ".git/branches/" directory is nowadays misleadingly named and
+may cause confusion as "branches" are almost exclusively used in the context of
+references.
++
+These features will be removed.
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index fa8b51daf0..85911ca8ea 100644
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
index 1ad3e70a6b..e565b2b3fe 100644
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
index 10104d11e3..ec69863f11 100644
--- a/remote.c
+++ b/remote.c
@@ -293,6 +293,7 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 	rewrite->instead_of_nr++;
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static const char *skip_spaces(const char *s)
 {
 	while (isspace(*s))
@@ -300,6 +301,21 @@ static const char *skip_spaces(const char *s)
 	return s;
 }
 
+static void warn_about_deprecated_remote_type(const char *type,
+					      const struct remote *remote)
+{
+	warning(_("reading remote from \"%s/%s\", which is nominated for removal.\n"
+		  "\n"
+		  "If you still use the \"remotes/\" directory it is recommended to\n"
+		  "migrate to config-based remotes:\n"
+		  "\n"
+		  "\tgit remote rename %s %s\n"
+		  "\n"
+		  "If you cannot, please let us know you still use it by sending an\n"
+		  "e-mail to <git@vger.kernel.org>."),
+		type, remote->name, remote->name, remote->name);
+}
+
 static void read_remotes_file(struct remote_state *remote_state,
 			      struct remote *remote)
 {
@@ -308,6 +324,9 @@ static void read_remotes_file(struct remote_state *remote_state,
 
 	if (!f)
 		return;
+
+	warn_about_deprecated_remote_type("remotes", remote);
+
 	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_REMOTES;
 	while (strbuf_getline(&buf, f) != EOF) {
@@ -337,6 +356,8 @@ static void read_branches_file(struct remote_state *remote_state,
 	if (!f)
 		return;
 
+	warn_about_deprecated_remote_type("branches", remote);
+
 	strbuf_getline_lf(&buf, f);
 	fclose(f);
 	strbuf_trim(&buf);
@@ -374,6 +395,7 @@ static void read_branches_file(struct remote_state *remote_state,
 	strbuf_release(&buf);
 	free(to_free);
 }
+#endif /* WITH_BREAKING_CHANGES */
 
 static int handle_config(const char *key, const char *value,
 			 const struct config_context *ctx, void *cb)
@@ -572,6 +594,7 @@ static void read_config(struct repository *repo, int early)
 	alias_all_urls(repo->remote_state);
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
@@ -583,6 +606,7 @@ static int valid_remote_nick(const char *name)
 			return 0;
 	return 1;
 }
+#endif /* WITH_BREAKING_CHANGES */
 
 static const char *remotes_remote_for_branch(struct remote_state *remote_state,
 					     struct branch *branch,
@@ -725,12 +749,14 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
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
index a7e5c4e07c..45b0c9babb 100644
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
index 08424e878e..e96ac8c767 100755
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
index 3b3991ab86..04d8a96367 100755
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
index 320d26796d..4e6026c611 100755
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
index 9d693eb57f..e705aedbf4 100755
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
2.48.1.321.gbf1f004a4a.dirty

