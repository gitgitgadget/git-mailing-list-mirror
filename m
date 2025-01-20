Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6041917CD
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358992; cv=none; b=YrdrRRI9NlvKPri3WmsRGgVOd6dpGijX7JQ6/kv7WB0aDR+ei1eHb/lcnA7GGusY+xv3YUVWmKchNbdZC7wOs8eDPoXD7W2jiHO/Frva3NkqE0to4JCjy5DSQNTB5tVfT92sPFhmUPED3NO7iR44vVfAONmxRExO+lHkiN/plfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358992; c=relaxed/simple;
	bh=cJKad1SJzB9YdaynIAqrhdxHhmyV7dsf260RfPGq8hA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3IInnJy3fWIhslYKM14YUYL8Sbqd8NpUKlWDFyy0EQY99B12pqaIs+DSgznZsPFjE3senbqz28ag3AgLH71hJDQcfQ3QyrrLs1BYKJ7ZgYAJti7qHcLg7RUVe0TPiflxvKVZ3eClUjZtcsde4gsR1vSYTsgBumW4/RxJW9pZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JFYVIzvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eY1BZXBk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JFYVIzvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eY1BZXBk"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6AAFD2540109;
	Mon, 20 Jan 2025 02:43:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 20 Jan 2025 02:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737358989;
	 x=1737445389; bh=Q9yKb7D+JLuqIPDIPttYSkjhz2gOOLpB24GPipks+OE=; b=
	JFYVIzvFxyEX8Z/2zsPpXyC/Ls/F/TEULigoqvuDEYEMEgr445GyZwMeEZkGaT5O
	51ZdzfQTI07K5PNbF4DrlmDZtkJwLVGikcYGI8rmuMgYW8O4TmEonODpTMbCO/Ja
	Udh5Of4GfW4+dcozCP0s9c4hF+I++zvRfZBDfQBDZVLYM1aboC7Ud0e8P2UD6wl4
	shK+4HAflikrET1jkBYTgq++0l5u7jlACZSms8cRvju8ZgqhX50JvYQWU0I67ra3
	vfrYtv76MoWEPZpUqXnhBrj2FLeQiTo+1ERunMcxcWeJdl566hzAY9ADTEJ1tGDR
	JIpsaodp0UbHR/waL6Iomg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737358989; x=
	1737445389; bh=Q9yKb7D+JLuqIPDIPttYSkjhz2gOOLpB24GPipks+OE=; b=e
	Y1BZXBkUGzoTwFf0ASQy88QbhW3WucjrfsrCJRsg2k0Hws2du9e+X1eriCeTw8n+
	DOmpMH2ECVjJt98oiun0a6FajoMfRR40viANK7H21/+kaQXdEv8TvtHEchQu82yF
	gdBdgWxWGk/nbHI5+QgvPSiz9nfeSw6RRhlZRvrd7u7CBeGOA7fWqkBwULgKdjCy
	TaUTZ0sVIwo+g1wkQsq43PfnisGTOexYVwWkLOls3j0uPECSS55vp5Dsf4fKXGmS
	HpMwJxsFvgRn0+VAaxcwcaxhcwBW5turGzfuXJ0N7fc5/yJF7kFjiuxu8cQJwba5
	/KIkjWsJIgwT3a8JF4hgQ==
X-ME-Sender: <xms:jf6NZ6hJ0Bz0WSG9VwrN82a7xYKszRq5oauwn3cnDo2Nu8Rj7Dfu9w>
    <xme:jf6NZ7BoskXFtC4mix2J77rG2bxeMKxbNkilqMHKGXEsTGqrewlLhdSG63YpQe6Cs
    -xULzdyaDp-tkkoxw>
X-ME-Received: <xmr:jf6NZyELpRBUAlAWT_Bcuduq3PDzJA0ZPxOw0aKTJ4PkI_90eWqxftyoah8LMaPHBpG1MLewOpC51R0kiOs3x7ktSJpm7gjlJapBdN688ZiN5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtg
    hpthhtoheprhhosggvrhhtrdgtohhupheskhhoohhrughinhgrthgvshdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jf6NZzTPlINwn5Mq1qUPX8heqxzuX23uUrfE1EQ-zdQtpz3cSecvcw>
    <xmx:jf6NZ3y1uBBQWPkct8kCBZCYxGgbCDOnHxY-QaaqRlHVT11UbANPcA>
    <xmx:jf6NZx5K6WhJHZFt7ZIV9AMC4JtSMYI4r24Z7CBq-u_M_j3kvcAYEA>
    <xmx:jf6NZ0wUMQ6mPPJ1J5UEK6WrBvUiGC4u7y4BbdJayoILoMLFqRJCXw>
    <xmx:jf6NZ-loA_2U-I4R--HekzoPZu4VTu4YAA02qC0THyHh1TBrA4bRvZv7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 02:43:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bfacb9fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 07:43:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 08:43:02 +0100
Subject: [PATCH v3 5/5] remote: announce removal of "branches/" and
 "remotes/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-pks-remote-branches-deprecation-v3-5-c7e539b6a84f@pks.im>
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
In-Reply-To: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
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
 remote.c                               | 19 ++++++++++++++
 remote.h                               |  2 ++
 t/t5505-remote.sh                      |  6 ++---
 t/t5510-fetch.sh                       | 13 ++++------
 t/t5515-fetch-merge-logic.sh           | 47 ++++++++++++++++++----------------
 t/t5516-fetch-push.sh                  | 14 +++++-----
 9 files changed, 92 insertions(+), 43 deletions(-)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
index 27acff86db..a91eb3bc55 100644
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
index 10104d11e3..5feb0ae886 100644
--- a/remote.c
+++ b/remote.c
@@ -293,6 +293,7 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 	rewrite->instead_of_nr++;
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static const char *skip_spaces(const char *s)
 {
 	while (isspace(*s))
@@ -308,6 +309,13 @@ static void read_remotes_file(struct remote_state *remote_state,
 
 	if (!f)
 		return;
+
+	warning(_("Reading remote from \"remotes/%s\", which is nominated\n"
+		  "for removal. If you still use the \"remotes/\" directory\n"
+		  "it is recommended to migrate to config-based remotes. If\n"
+		  "you cannot, please let us know you still use it by sending\n"
+		  "an e-mail to <git@vger.kernel.org>."), remote->name);
+
 	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_REMOTES;
 	while (strbuf_getline(&buf, f) != EOF) {
@@ -337,6 +345,12 @@ static void read_branches_file(struct remote_state *remote_state,
 	if (!f)
 		return;
 
+	warning(_("Reading remote from \"branches/%s\", which is nominated\n"
+		  "for removal. If you still use the \"branches/\" directory\n"
+		  "it is recommended to migrate to config-based remotes. If\n"
+		  "you cannot, please let us know you still use it by sending\n"
+		  "an e-mail to <git@vger.kernel.org>."), remote->name);
+
 	strbuf_getline_lf(&buf, f);
 	fclose(f);
 	strbuf_trim(&buf);
@@ -374,6 +388,7 @@ static void read_branches_file(struct remote_state *remote_state,
 	strbuf_release(&buf);
 	free(to_free);
 }
+#endif /* WITH_BREAKING_CHANGES */
 
 static int handle_config(const char *key, const char *value,
 			 const struct config_context *ctx, void *cb)
@@ -572,6 +587,7 @@ static void read_config(struct repository *repo, int early)
 	alias_all_urls(repo->remote_state);
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
@@ -583,6 +599,7 @@ static int valid_remote_nick(const char *name)
 			return 0;
 	return 1;
 }
+#endif /* WITH_BREAKING_CHANGES */
 
 static const char *remotes_remote_for_branch(struct remote_state *remote_state,
 					     struct branch *branch,
@@ -725,12 +742,14 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
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
2.48.0.257.gd3603152ad.dirty

