Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A93C10B8
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624313; cv=none; b=pqxFh3OjN+wFTEP3z508GJkZg9qKx/9CjakksAOYu1AwCIloGQeVlukMrkz055oLeLbHPmpIKD0B+3EtsGLwzRTMpILsz4fDpxZv0AmE9VRmNl2ZU4k+UCJ96aBwtZVR00PFEWWgdTXc0gTRlaoN6x4GKIfvwkX6AZ5+GAyyGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624313; c=relaxed/simple;
	bh=HOT+OixhFxTSPFQSrrT1UsexgulZHmCzxsCNFfCABG0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HxhcrSfx94B3pwYFlFHyn+LTYo/r+3I/MsjZyRZEexYB1iDuozMJV1xXg/TvbMRXfod/QUWcxKVLzs/9PI0L5ikRW8MpZZ8fzbiMb+ybwrwLPamW4XRrRNz7vvQW0DrXsus0eKcd0rMzb0Q5nHuZxPdfH0vI9trOpIcjdIxwbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awSNWV1S; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awSNWV1S"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso8859775a91.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784624311; x=1785229111; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BC2ZreAC1VZnRHGS/ZQWOnF1XRZptrjm7ddyc0gxeW4=;
        b=awSNWV1Swi/LoXZwJzprFvdQlxraEe7EaOnq9Gjm4ZbkhOqDcGfgSWaMHtKL/C10yg
         qLcshgxv2SHiF+OI2JyKFYVLgYv+wBj7YKoQF5eBsJdV+ST4Lr8I5eUQ21q72XoSfoLq
         4/Y6bWwwD8+t+tC83qKdXrH4pSLtIHSW/3ecpy87U9MypqGItH52de+33nYERA1TwmF3
         LOMSTU6fB0SnY8Ew0zXMs7ZLLb25LkfNwhYmQWki3pHX5ojtDjf0kRXgUBDAfazz8wF6
         h4CtFWyKtjTBzM+Z/nsyyYxsWewPXOqLTvLoRsd5FzBHTjG7ZrFqLJhd5LYj71nXufbR
         tWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624311; x=1785229111;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BC2ZreAC1VZnRHGS/ZQWOnF1XRZptrjm7ddyc0gxeW4=;
        b=EZcJR9O3vCclpMIJte4L6nUEgYT95CJxo7RdbPzcg7Z4hE5VXJ6JEillxncph7QFev
         5pvxdZLB88++QyOveZwWtKb6iUBWoVlAls/J7nBK1+J+EdFhK5gN7BIp8W/3zYZhlH35
         FyYLqyc+g40qjskAD0lJNSPdbi45SEkvIxpvIr3kWpEBTEdJDB2kYl9mNXdiBNyXDJ/3
         P119XpwG2FoHlu8R31MM+brNdPMOmtkhRhZZLjk5iF4FR7Y8s+RYUZ1oYX3rFg4HqByT
         sO3LGbNXAKCoobnA4wB11qMzFCHT3sLwEZPLwF6CN+nWXh5/7JZrG2Vi9EJMPIFsk4F/
         dkEw==
X-Gm-Message-State: AOJu0YymrjZJ/8sfye/gaEi6Y/otbppi8D7n9E4lkwOaZ3RJPqRYbk4J
	NWJnl1QPWNH9vxCjrghOp9cS1cEM18ypV3rWfc2ttmGHPr94RJDBuFhpBS6wPw==
X-Gm-Gg: AR+sD13UzBJ59LgA3qv+qE/Mg2iADZ9jf8W6vqxSUR3UeC+h4Los0v45UBRVh4guGnv
	8IaDU5KPhWThOCUNXKzYPOvM2XsuiXKFb2cZsKH0slUw+PqM7xmWM8jC/XOV8Zhpry4N3vIGEuG
	0a2ov/zTqv1ZCsKLHPijaPfbu9KqGocZ6snQ3k0AiJZPrC1KkKNGCiX83QTClbqksBIOCycU7Ol
	TmJiw43t6Otuxe3rxR+3ENrheRqibNXNRZ1o4oRt5H59Mw4tibHLSa4Rw3r68NZUf04/WoV1TAW
	06uSGVVcBGjfwwlyQYoqid9aYTInAetI15bHcBdu8vJYoAJnUzuM/LPVZh4QVnN1wekAPk0BGUX
	8BWqgMhCl0T8P5+nj5YlNSp5gsyprJC8GpxGqbxvZ2CalKcjEA5qw41fXBGD019QhveCSrAcgao
	0Xfqz8cPI=
X-Received: by 2002:a17:90b:3ccd:b0:38d:a8be:a597 with SMTP id 98e67ed59e1d1-38e4b5c98afmr19520976a91.37.1784624311268;
        Tue, 21 Jul 2026 01:58:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.152.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9234e206sm1123719a91.10.2026.07.21.01.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:58:30 -0700 (PDT)
Message-Id: <6e924a7fecb364780a5e11d27c20a08599e0d21e.1784624306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
	<pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Jul 2026 08:58:26 +0000
Subject: [PATCH v2 2/2] remote: find tracking branches for URL push
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Git already accepts a repository URL as branch.<name>.pushRemote and
can push to it. When a configured remote has the same URL, however,
"git status" cannot show that remote's push branch.

This can happen in fork workflows when the original remote is renamed
to "upstream", the fork is added as "origin", and an existing
pushRemote value still contains the fork URL. The URL still points to
the right repository, so pushing works. However, @{push} is unavailable
because Git does not connect the URL to "origin". As a result,
"git status" cannot show the push branch, and an up-to-date push can
leave its local tracking information stale.

When exactly one configured remote has the URL as one of its
remote.<name>.url values, use its fetch refspec to find and refresh the
push branch. Keep the URL as the push destination so the configured
remote's push settings do not change existing behavior. Keep the
current behavior when no remote matches or multiple remotes match.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |   2 +
 Documentation/revisions.adoc     |   3 +
 remote.c                         |  27 +++++++-
 remote.h                         |   2 +
 t/t5505-remote.sh                | 104 +++++++++++++++++++++++++++++++
 transport.c                      |   5 +-
 6 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..e22b6c846d 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -55,6 +55,8 @@ This option defaults to `never`.
 	repository), you would want to set `remote.pushDefault` to
 	specify the remote to push to for all branches, and use this
 	option to override it for a specific branch.
+	The value may be the name of a configured remote or a repository
+	URL. A URL is used directly as the push destination.
 
 `branch.<name>.merge`::
 	Defines, together with `branch.<name>.remote`, the upstream branch
diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 6ea6c7cead..670fc66053 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -127,6 +127,9 @@ some output processing may assume ref names in UTF-8.
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
   the remote-tracking branch that corresponds to that branch at the remote.
+  If the push destination is a URL and exactly one configured remote has the
+  same `remote.<name>.url`, '@\{push}' reports the remote-tracking branch for
+  that remote.
 +
 Here's an example to make it more clear:
 +
diff --git a/remote.c b/remote.c
index 0dc36956c3..2e07bd998f 100644
--- a/remote.c
+++ b/remote.c
@@ -1887,13 +1887,38 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static char *tracking_for_push_dest(struct repository *repo UNUSED,
+struct remote *repo_remote_for_push_tracking(struct repository *repo,
+					     struct remote *remote)
+{
+	struct remote *first_match = NULL;
+	struct remote_state *remote_state = repo->remote_state;
+
+	if (remote->origin != REMOTE_UNCONFIGURED || remote->url.nr != 1)
+		return remote;
+
+	for (int i = 0; i < remote_state->remotes_nr; i++) {
+		struct remote *candidate = remote_state->remotes[i];
+
+		if (!candidate || candidate == remote ||
+		    !remote_is_configured(candidate, 0) ||
+		    !remote_has_url(candidate, remote->url.v[0]))
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
index 6f5e86dede..2c86661294 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -24,6 +24,28 @@ setup_repository () {
 	)
 }
 
+setup_url_pushremote () {
+	rm -rf fork.git client &&
+	git clone --bare one fork.git &&
+	git clone one client &&
+	fork_url="$TRASH_DIRECTORY/fork.git" &&
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
@@ -1018,6 +1040,88 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but keeps g
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
+test_expect_success 'adding fork remote makes URL-valued pushRemote trackable' '
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
