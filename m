Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6461411A08
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102694; cv=none; b=V+T1FhdKIeeKGPeesBxOobgFYHsaVylFacS2aHkw0WJ7Nk2La5cmU6+N/7ZfEhEpDAWKW3lfLPk3pLROIkkt/sE1VzfAXVvkeg3/yNkb189mwjmgD1faKWx4XYjXjz76yz9gFZ4+bqb8jfI6iKq+4eyKKITyS+dXvJbn7onu5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102694; c=relaxed/simple;
	bh=QUPC7RY16dYai89kDaWPyl/fDghFLbAhdjGMskXKPqE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bmn8UF2NDw+EdR8K7a6AO2OzxXAUWqRCsgItA7U6G7yTEjxupgesy7XZJrcBpwPbS//QaOsfe0SXzXXoOlr47SS8K060Cevv83Xey8fD/nMzK7GJSWZiT8giW2pPJCTBCiC0unABOEgZ+x8P8lKeSGltNzt4BDKQxTZm609a/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHuNpyfo; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHuNpyfo"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-351297d9de8so141279eec.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791102689; x=1791707489; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zZv+XdVLQPN/UITJZtNNeg9Lfr9Qz9ihJCKwsc6wk6A=;
        b=XHuNpyfoHhG1Paq2zuXWkJ4WNB8MEv2nl5VMRt8iapEh0DfmsLeb2wUXNwfuCJ+K5+
         TDT1KVxBfCEWuaKGiFXNRCnszIFRwBrmSp5gn7dQTJB7pN5fDRjWUbXCXxjpOm0LNzYY
         pkYqnUsuEc27ZLdNRCfEpgNHMXDvHv5LwwM4m4IXjH3JbY1c1Rcp3inq1lmI3K/RQY0Y
         BA6NCPvlvE6qWZd89LzmDbEaxrRCxNglQPyu964ZwsISzwsEaD6LWozeWpq9XE9zg5Hm
         0yS7U0bYuGfBspcpMtKOpcM8TBpi3a7mrGwBY3L7FPc8nue8Uhuj6ISuVPTbCCTzpxFJ
         aklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791102689; x=1791707489;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZv+XdVLQPN/UITJZtNNeg9Lfr9Qz9ihJCKwsc6wk6A=;
        b=GDYjzcr3FemswLUz5eUbO/gkhrkzvBrxVggQQl6/JM1wBn8XaS4UPV2eyyxMxbPzJw
         LtgeHousNwYZ5YkMEb5MFG8gEBhjhiZH2SW88HqW84kWY+ZNZh16f+J008JRjfKkfiAa
         pGE25rZ6s4aNEOVBsqn8xoxRlXtTNGxfflsI5dvfFOUJFdhFTnf9PQATyFw9LD3xcbNK
         pQTDJ64Djr2J6uPUuRy1HxFrQ6ttcuvn/FfPfE/ev5JVqh9u15N1SiblbJa2lhEkoLa3
         GdlTnejKHE1oAZ02KqfW9WpyWmop5OYAoZOHBPBJPgJWgWexY6TniYKy4bVo7atUQPTP
         AhJQ==
X-Gm-Message-State: AFuF++n6OoW3PFef/o7+TQ3MyLTlBhq3AtJtjcaARzXoYd0pOfwTjkvT
	1i5rbyEhdcxEoPfoCX6jtufy7ZxokmHqnYPkx2VtSOLXRJeY6OhkDe/L1IYVlA==
X-Gm-Gg: AYBFou1ejPYtExRyL5ELhtWUiH1gksLDbhP5ddP71B7ivfIKvDCBRqYQiUq1MXdS5sF
	aZR+p1e4fsiUAw0X4+vp6PoVIG2f/74T627769CZHzZJEsx6JbOm1T1aSTb05ym6H1uDL2XQ29R
	6gHWz0hMPlhz1YGnD+XgIgJqmTM5WL2C8016qEkethZHg+ez90DfYjFWY3PaYnafq0hRwG1Ekgz
	UeSlkXcNrbYkCanNb6xJfbTLuH6g1cI0JZxXYszZQBBMhGR5XRarHKhkkqI9p3JO1CQQsgtmWOI
	DqlbCQ6Hlz1uT6PHKFGdANv0sOb4RP3kzNc2f6taTOI62gokjjfmlYIyltI+fpj8u+c8oLjkLGc
	DK0lGJvisIPgyiQC3C8Q6H4yUE5g9WWXgNoJLz4AX08OWSbJlpToF3oa07Yj9XY7nOo76wcn1up
	PlW3H0zMh+5wA4t5Dq2Z2lKxqR07ZhGc4T1WT6bBaQMGdP290E3AAerc3ZXaErGAw6LS8Ip3FtC
	g==
X-Received: by 2002:a05:693c:65d3:b0:351:1230:5087 with SMTP id 5a478bee46e88-3511230747emr4519896eec.12.1791102688945;
        Sun, 04 Oct 2026 01:31:28 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35126f01924sm3171879eec.0.2026.10.04.01.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:31:28 -0700 (PDT)
Message-Id: <74c177e3e22d140c7cd29b8e8a2a550944eb5cd2.1791102684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 08:31:22 +0000
Subject: [PATCH v6 2/4] fetch: infer branches to fetch from a refmap-only
 remote
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Configuring remote.<name>.refmap without remote.<name>.fetch used to
make a refspec-less "git fetch <name>" fail with "--refmap option is
only meaningful with command-line refspec(s)", since a refmap only
says where to put fetched refs, not what to fetch.

Make that case infer what to fetch: the local branches whose
@{upstream} is already on that remote. This lets a remote be
configured to fetch only the branches actually in use, without
listing them by hand in remote.<name>.fetch, and without needing to
touch the command line every time.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   5 +-
 Documentation/fetch-options.adoc |   6 +-
 builtin/fetch.c                  |  52 ++++++++++++--
 remote.c                         |  29 ++++++++
 remote.h                         |   3 +
 t/meson.build                    |   1 +
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 7 files changed, 205 insertions(+), 10 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 103eada406..7c52e443a5 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -36,7 +36,10 @@ remote.<name>.fetch::
 remote.<name>.refmap::
 	The default value of the `--refmap` option for linkgit:git-fetch[1].
 	Used to map remote refs being fetched to remote-tracking refs to
-	store. See the `--refmap` entry in linkgit:git-fetch[1].
+	store. If `remote.<name>.fetch` is not set either, a refspec-less
+	fetch infers what to fetch from local branches built on this
+	remote, instead of fetching every branch it has. See the
+	`--refmap` entry in linkgit:git-fetch[1].
 
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 538914bc6e..315daf97d7 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -245,8 +245,10 @@ endif::git-pull[]
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 +
-`remote.<name>.refmap` provides the default value for this option, the
-same way `remote.<name>.fetch` provides the default refspecs to fetch.
+When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
+there is nothing to fetch, neither on the command line nor from
+`remote.<name>.fetch`, Git infers what to fetch from the local branches
+whose `@{upstream}` is on that remote.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 04d0a78ecf..e928f5d7e0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -511,6 +511,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref **tail = &ref_map;
 	struct refspec *effective_refmap =
 		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
+	struct refspec inferred_rs;
+	int inferred_branches = 0;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -518,15 +520,32 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct hashmap existing_refs;
 	int existing_refs_populated = 0;
 
+	refspec_init_fetch(&inferred_rs, the_hash_algo);
+
 	filter_prefetch_refspec(rs);
 	if (remote)
 		filter_prefetch_refspec(&remote->fetch);
 
+	if (!rs->nr && remote && !remote->fetch.nr &&
+	    effective_refmap && effective_refmap->nr) {
+		struct string_list tracked = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
+
+		branches_tracking_remote(remote, &tracked);
+		for_each_string_list_item(item, &tracked)
+			refspec_append(&inferred_rs, item->string);
+		string_list_clear(&tracked, 0);
+
+		rs = &inferred_rs;
+		inferred_branches = 1;
+	}
+
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
 
 		for (i = 0; i < rs->nr; i++) {
-			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
+			get_fetch_map(remote_refs, &rs->items[i], &tail,
+				      inferred_branches);
 			if (rs->items[i].dst && rs->items[i].dst[0])
 				*autotags = 1;
 		}
@@ -561,6 +580,8 @@ static struct ref *get_ref_map(struct remote *remote,
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+	} else if (inferred_branches) {
+		/* Already fully handled above. */
 	} else if (effective_refmap && effective_refmap->nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
@@ -656,6 +677,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	if (existing_refs_populated)
 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
+	refspec_clear(&inferred_rs);
 	return ref_map;
 }
 
@@ -1960,15 +1982,30 @@ static int do_fetch(struct transport *transport,
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
 		struct branch *branch = branch_get(NULL);
-
-		if (transport->remote->fetch.nr) {
+		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
+			!strcmp(branch->remote_name, transport->remote->name);
+		struct refspec *effective_refmap = refmap.nr ? &refmap :
+			&transport->remote->refmap;
+		int inferred_branches = !transport->remote->fetch.nr &&
+			effective_refmap->nr;
+
+		if (inferred_branches) {
+			struct string_list tracked = STRING_LIST_INIT_DUP;
+			struct string_list_item *item;
+
+			branches_tracking_remote(transport->remote, &tracked);
+			for_each_string_list_item(item, &tracked)
+				strvec_push(&transport_ls_refs_options.ref_prefixes,
+					    item->string);
+			string_list_clear(&tracked, 0);
+		} else if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
-				do_set_head = 1;
 		}
-		if (branch && branch_has_merge_config(branch) &&
-		    !strcmp(branch->remote_name, transport->remote->name)) {
+		if ((transport->remote->fetch.nr || inferred_branches) &&
+		    follow_remote_head != FOLLOW_REMOTE_NEVER)
+			do_set_head = 1;
+		if (tracks_this_remote) {
 			int i;
 			for (i = 0; i < branch->merge_nr; i++) {
 				strvec_push(&transport_ls_refs_options.ref_prefixes,
@@ -2009,6 +2046,7 @@ static int do_fetch(struct transport *transport,
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
+
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
diff --git a/remote.c b/remote.c
index 017cd9d13e..a5deb9b929 100644
--- a/remote.c
+++ b/remote.c
@@ -1884,6 +1884,35 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+struct branches_tracking_remote_cb_data {
+	struct remote *remote;
+	struct string_list *tracked;
+};
+
+static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
+{
+	struct branches_tracking_remote_cb_data *data = cb_data;
+	struct branch *branch;
+
+	branch = branch_get(ref->name);
+	if (!branch_has_merge_config(branch) ||
+	    strcmp(branch->remote_name, data->remote->name))
+		return 0;
+
+	for (int i = 0; i < branch->merge_nr; i++)
+		string_list_insert(data->tracked, branch->merge[i]->src);
+
+	return 0;
+}
+
+void branches_tracking_remote(struct remote *remote, struct string_list *tracked)
+{
+	struct branches_tracking_remote_cb_data data = { remote, tracked };
+
+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
+				  add_if_tracking_remote, &data);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
diff --git a/remote.h b/remote.h
index ac485a584d..da6c3ef53a 100644
--- a/remote.h
+++ b/remote.h
@@ -359,6 +359,9 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/* fills tracked with the refname of every local branch's upstream on remote */
+void branches_tracking_remote(struct remote *remote, struct string_list *tracked);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
diff --git a/t/meson.build b/t/meson.build
index f65eb04684..e287a6b947 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -730,6 +730,7 @@ integration_tests = [
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
   't5584-http-429-retry.sh',
+  't5586-fetch-refmap.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5586-fetch-refmap.sh b/t/t5586-fetch-refmap.sh
new file mode 100755
index 0000000000..b81fc48cbe
--- /dev/null
+++ b/t/t5586-fetch-refmap.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+
+test_description='"git fetch" with a remote.<name>.refmap but no remote.<name>.fetch
+
+When a remote has a refmap configured but no fetch refspec, a
+refspec-less fetch infers what to fetch from the local branches whose
+@{upstream} is on that remote.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit main-1 &&
+	test_commit main-2 &&
+	git checkout -b side main-1 &&
+	test_commit side-1 &&
+	git checkout -b next main-1 &&
+	test_commit next-1 &&
+	git checkout main
+'
+
+test_expect_success 'clone shallow and single-branch, then add a second remote' '
+	git clone --no-local --depth=1 --branch main --single-branch . client &&
+	(
+		cd client &&
+		git remote add upstream .. &&
+		test_might_fail git config unset remote.upstream.fetch &&
+		git config remote.upstream.refmap \
+			"+refs/heads/*:refs/remotes/upstream/*"
+	)
+'
+
+test_expect_success 'a bare fetch needs nothing until a branch is tracked' '
+	(
+		cd client &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'an explicit one-time fetch lets a branch be tracked' '
+	(
+		cd client &&
+		git fetch upstream main &&
+		git branch --set-upstream-to=upstream/main &&
+		test_cmp_config upstream branch.main.remote &&
+		test_cmp_config refs/heads/main branch.main.merge
+	)
+'
+
+test_expect_success 'a branch checked out from a one-time fetch is kept updated by later plain fetches' '
+	(
+		cd client &&
+		git fetch upstream side:refs/remotes/upstream/side &&
+		git branch side-topic upstream/side
+	) &&
+	git checkout side &&
+	test_commit side-2 &&
+	git checkout main &&
+	(
+		cd client &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/side
+		EOF
+		test_cmp expect actual &&
+		git rev-parse refs/remotes/upstream/side >actual-oid &&
+		git -C .. rev-parse side >expect-oid &&
+		test_cmp expect-oid actual-oid
+	)
+'
+
+test_expect_success 'a second branch tracking the same upstream branch does not fetch it twice' '
+	(
+		cd client &&
+		git branch side-topic-2 upstream/side &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/side
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'a branch tracking a different remote is not fetched from upstream' '
+	(
+		cd client &&
+		git remote add other .. &&
+		git fetch other next:refs/remotes/other/next &&
+		git branch next-topic other/next &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/side
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'git remote show does not choke on a refmap-only remote' '
+	(
+		cd client &&
+		git remote show upstream
+	)
+'
+
+test_done
-- 
gitgitgadget

