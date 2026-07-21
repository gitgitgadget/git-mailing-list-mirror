Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B29472534
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664866; cv=none; b=qbC4w3etyYf0CpAfUjoJICU1QP7CZH9uIqPVhUehJNBj2lWvL+B8GCXC28X/kgG/PkpZzLK7uBnnPjBTgzACPhK7ngbS8qsDzIRiTEhm/dJmJcrRINSpLliqWIY9W22BhkMa+fjEww+AyU9ktcOohsZpQBsMBU4CHsSO0XsZzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664866; c=relaxed/simple;
	bh=dlaDFmx4x6EK4ayW34W9pd75frEzE0Vb3oIkN5y1Prk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hLaXfaxXCGmMFOZQ40hKNe7Y8WfGAucrrmAexFv6jDt0Pn6B6we1cv+TVkHDyjUdh6YGvcAKfd5TSciPDOjwle5AtMed5dckzFkGycaUWsaMLYhk6UYHVhN/qTc0g/rmpv2Pgv7tL8ggQYizhmDTTIPMlzyov8yAJ7vnALB7i4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhNZmR27; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhNZmR27"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-451fd21113cso4092709fac.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784664864; x=1785269664; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wihbUMJrv1HnnyO2eUBIXPXaVlWrIlzw7FpbI1UVPNY=;
        b=mhNZmR27Ogi03hFkNPXrJIddFi7RdoZGJsM84A+9eUjQXUy2hyh5oXl2lSU1mGE1ia
         flboZrvHvyZDjdoyBWRymUY5XXdfL98iL+/lIM2nLKlQt1LxK9CxvuSoFN+hp9mct6/F
         T7qg/aeYOOI+XUKmEl357bMwVepQh0/uDdqM5d4ZQwurJqZI9x9ixz05/7LW/JmitY8y
         GeVL20l7pO48nAlTJYrTfS4g1PBqeqe27U0UlctVjGBu1kVW0dlWIhcKVOCiQPTb0EPi
         n4foQHSwRbFqh4IHyofSx2Tf/B7KDKExp6I0GPp8jvpYEk5ASvfAormSaPHDKcRuMYa0
         7nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784664864; x=1785269664;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wihbUMJrv1HnnyO2eUBIXPXaVlWrIlzw7FpbI1UVPNY=;
        b=nB3u1Fdh5ChEFnOUB3aoHocCschDRLg62JucXr1Fl20SsRC1ZLjRtUhb+A5VKj65IX
         bUpz7v91Gn+KnjX41gJ8Ut14f2fvKTQyAGgI77AMlx3MZqQV/2mhmQOFv/rUirVFKqIc
         BxL/RE45O/zlVxSRMJkCD+WjZyOSxxc1MquZsduUqoi462SvfmxXS5oHlNx9ah8rXd2P
         XClTSM3dJKWj8vviNXgrLni76wN+lKnmCJfVjupYegMPCccKkR99DriK35EKd9R29GiB
         MoKDAR2a78JkOoDNfvBoyfIlK07DrfDiGA0ZiZqoYslVsshRGyzQr4j9H/UQ4UXB3QwW
         rExw==
X-Gm-Message-State: AOJu0Yw2+u3TVyrNjZwmUN/PPVaQ0Rj8CnZgre+IP/eMVQF+jU5ZyzCH
	qAI32yYV7hE5vkjJ9ob4Xe9rpkXpO8XWheXYVKy0bcR+LNxVzH+lkebQHsWkNgds
X-Gm-Gg: AR+sD11vV4lnD1//tB+SmM2WVxHwFs1Nxae+QfhMu/8Nap3ZlcrbUm5sITRyaPlvp/T
	EF/MVTFNmkADtpFKqdpARojEs1TjqJQZ4Nel0ZjshbbtbyCgOGxHhbM6MTmW1JwXTk9MPfVQ8K5
	lhecxeXmbzmKgPggUj3F1phVtTMwNDQuYDj3Xg4XC7TS0ZAVAJl6kNj6sweztrXM4KBAzaqHsK/
	ZeP3AKimJkxypzXLxJ/4yDtf/p10F/5mAjTfMSDiSMsjHpH/yuYhFViWfQwqu1ghBpRCXw0TC4L
	3MqOBa+LP83+zzRJLbT9oREZjQWjRTMqVLRTEaoouR0v0t9wHUJswpMFxdvuqVqMAeI2oXZ2kO/
	97tCUyJjIpjgLfduwWPRVfFP98X3Jkti+/9aDjaUvy0fqhPnjFfDgfdxa+HLTbGLHMhI5Yv5OD5
	6840FxSw==
X-Received: by 2002:a05:6871:887:b0:448:6ba8:539f with SMTP id 586e51a60fabf-457631d7655mr602035fac.6.1784664863578;
        Tue, 21 Jul 2026 13:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.123.151])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766f16541sm377839fac.6.2026.07.21.13.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:14:23 -0700 (PDT)
Message-Id: <a343af9d500a598826c5fe9a3abbe9df2f5916e8.1784664859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
References: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
	<pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Jul 2026 20:14:19 +0000
Subject: [PATCH v3 2/2] remote: find tracking branches for URL push
 destinations
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Git accepts a repository URL as branch.<name>.pushRemote and can push
to it. This branch setting takes precedence over remote.pushDefault.

A branch can be configured with a URL-valued pushRemote before any push
occurs. If the remotes are later rearranged with "git remote rename" and
"git remote add", the newly added remote may use that URL. The URL value
is unaffected by the rename and continues to take precedence over
remote.pushDefault. The URL and the remote then point to the same
repository, but Git does not connect them for tracking. Pushing works,
but @{push} cannot identify the remote's tracking branch. As a result,
"git status" cannot show the push branch, and an up-to-date push can
leave its tracking information stale.

When exactly one configured remote uses the push destination URL, use
that remote for push tracking. Continue to push to the URL so the
configured remote's push settings do not change existing behavior. Keep
the current behavior when no remote matches or multiple remotes match.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |   1 +
 Documentation/revisions.adoc     |   3 +
 remote.c                         |  34 ++++++++-
 remote.h                         |   2 +
 t/t5505-remote.sh                | 124 +++++++++++++++++++++++++++++++
 transport.c                      |   5 +-
 6 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..5a85fde8de 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -55,6 +55,7 @@ This option defaults to `never`.
 	repository), you would want to set `remote.pushDefault` to
 	specify the remote to push to for all branches, and use this
 	option to override it for a specific branch.
+	The value may be the name of a configured remote or a repository URL.
 
 `branch.<name>.merge`::
 	Defines, together with `branch.<name>.remote`, the upstream branch
diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 6ea6c7cead..78f96fe8b0 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -127,6 +127,9 @@ some output processing may assume ref names in UTF-8.
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
   the remote-tracking branch that corresponds to that branch at the remote.
+  If the push destination is a URL and exactly one configured remote has
+  that URL among its `remote.<name>.url` values, '@\{push}' reports that
+  remote's remote-tracking branch.
 +
 Here's an example to make it more clear:
 +
diff --git a/remote.c b/remote.c
index 0dc36956c3..4a29669443 100644
--- a/remote.c
+++ b/remote.c
@@ -1887,13 +1887,45 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static char *tracking_for_push_dest(struct repository *repo UNUSED,
+struct remote *repo_remote_for_push_tracking(struct repository *repo,
+					     struct remote *remote)
+{
+	const struct strvec *push_urls;
+	struct remote *first_match = NULL;
+	struct remote_state *remote_state = repo->remote_state;
+	const char *check_url;
+
+	if (remote->origin != REMOTE_UNCONFIGURED)
+		return remote;
+
+	push_urls = push_url_of_remote(remote);
+	if (push_urls->nr != 1)
+		return remote;
+	check_url = push_urls->v[0];
+
+	for (int i = 0; i < remote_state->remotes_nr; i++) {
+		struct remote *candidate = remote_state->remotes[i];
+
+		if (!candidate || candidate == remote ||
+		    !remote_is_configured(candidate, 0) ||
+		    !remote_has_url(candidate, check_url))
+			continue;
+		if (first_match)
+			return remote;
+		first_match = candidate;
+	}
+
+	return first_match ? first_match : remote;
+}
+
+static char *tracking_for_push_dest(struct repository *repo,
 				    struct remote *remote,
 				    const char *refname,
 				    struct strbuf *err)
 {
 	char *ret;
 
+	remote = repo_remote_for_push_tracking(repo, remote);
 	ret = apply_refspecs(&remote->fetch, refname);
 	if (!ret)
 		return error_buf(err,
diff --git a/remote.h b/remote.h
index 72a54d84ad..cca02033b9 100644
--- a/remote.h
+++ b/remote.h
@@ -345,6 +345,8 @@ char *remote_ref_for_branch(struct branch *branch, int for_push);
 
 const char *repo_default_remote(struct repository *repo);
 const char *repo_remote_from_url(struct repository *repo, const char *url);
+struct remote *repo_remote_for_push_tracking(struct repository *repo,
+					     struct remote *remote);
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 6f5e86dede..983aff6552 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -24,6 +24,28 @@ setup_repository () {
 	)
 }
 
+setup_url_pushremote () {
+	rm -rf fork.git client &&
+	git clone --bare one fork.git &&
+	git clone one client &&
+	fork_url="file://$TRASH_DIRECTORY/fork.git" &&
+	(
+		cd client &&
+		git checkout -b topic --track origin/main &&
+		git commit --allow-empty -m topic-change &&
+		git config push.default current &&
+		git config status.compareBranches "@{upstream} @{push}" &&
+		git config branch.topic.pushRemote "$fork_url" &&
+		git push
+	)
+}
+
+check_status () {
+	git -C client status >actual &&
+	cat >expected &&
+	test_cmp expected actual
+}
+
 tokens_match () {
 	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
 	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
@@ -1018,6 +1040,108 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but keeps g
 	)
 '
 
+test_expect_success 'URL-valued pushRemote without matching remote is not trackable' '
+	setup_url_pushremote &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'adding matching remote makes URL-valued pushRemote trackable' '
+	setup_url_pushremote &&
+
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin "$fork_url"
+	) &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is up to date with ${SQ}origin/topic${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'pushInsteadOf URL pushRemote is trackable' '
+	setup_url_pushremote &&
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin "$fork_url" &&
+		git config "url.$fork_url.pushInsteadOf" fork: &&
+		git config branch.topic.pushRemote fork:
+	) &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is up to date with ${SQ}origin/topic${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'up-to-date URL push refreshes stale tracking branch' '
+	setup_url_pushremote &&
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin "$fork_url" &&
+		git commit --allow-empty -m another-topic-change &&
+		git -C ../fork.git fetch ../client topic:topic
+	) &&
+
+	check_status <<-EOF &&
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 2 commits.
+
+	Your branch is ahead of ${SQ}origin/topic${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+
+	git -C client push >actual 2>&1 &&
+	test_grep "Everything up-to-date" actual &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 2 commits.
+
+	Your branch is up to date with ${SQ}origin/topic${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'duplicate remote URL leaves URL-valued pushRemote ambiguous' '
+	setup_url_pushremote &&
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin "$fork_url" &&
+		git remote add duplicate "$fork_url"
+	) &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+'
+
 test_expect_success 'rename handles remote without fetch refspec' '
 	git clone --bare one no-refspec.git &&
 	# confirm assumption that bare clone does not create refspec
diff --git a/transport.c b/transport.c
index fc144f0aed..30a4ab2cd5 100644
--- a/transport.c
+++ b/transport.c
@@ -1553,8 +1553,11 @@ int transport_push(struct repository *r,
 	if (!(flags & (TRANSPORT_PUSH_DRY_RUN |
 		       TRANSPORT_RECURSE_SUBMODULES_ONLY))) {
 		struct ref *ref;
+		struct remote *tracking_remote = repo_remote_for_push_tracking(
+			r, transport->remote);
+
 		for (ref = remote_refs; ref; ref = ref->next)
-			transport_update_tracking_ref(transport->remote, ref, verbose);
+			transport_update_tracking_ref(tracking_remote, ref, verbose);
 	}
 
 	if (porcelain && !push_ret)
-- 
gitgitgadget
