Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AB3D5C1E
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410172; cv=none; b=nJDdabv3KOP3YXBOPKjp5VoljWVWr1Omz43QBS8+Bv7YGPI35IrunVCfWWWpKRa0QKhLgVbYhe0KStXWC1NfOt6prrr9E4mcrmLTmH/HpyBAbwoSohmLuZGnQ+DuMk9rgWO0sOqXOOUgauAuczLPMpqu7gztzBwXKr7cqJ3DPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410172; c=relaxed/simple;
	bh=6XD/4fZiyI7qwuAgYgy8Mwdy5k74P+7IXbBbG5WHubs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a1bBlgIhCuDEYBOGatqkTCxn0fW7ABS15bG8P/EXq2dI3DdcHj32eCnrtRH8CBKxc0GRQ+dVtAXDtMNdMzntd+4iykEwaTa9i389VZGPwMRjMhqJ3tsOs4t5XhkthKklpxNqZPWKxqHkbcPvq9favErwi05TDiUBgoUZh+vWQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGeAD9l+; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGeAD9l+"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8256106635eso1221565a34.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410169; x=1792014969; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NQo1Hws+HsXBbw1Bo6bEwZwNkKrNE3CFbMFyNe5D7H0=;
        b=mGeAD9l+2IxBq5pMM3f3yClRApZrd/fsknAgXi7TU1FLiuRCrp5wXL9EZOgSrYFltf
         GJAhQq2SPzRmCBWrJig4ouEvYiAPeNRP7Gy4Y60f+DSOYLj0ltzo1+jvED+63jNW7QSS
         B0nzSJOwhN+uzN0g4eQgxJEXUP70Jdqr31UuOtSooxDcEUGGycYR6Hzu1fAXWNsv+a2u
         lfQKv802E8w21jnOTjYHyyMoRHKqy9sYq8Fp4WPsO6qaoVW+PAq7Gc7RVAQ+hH+VNKaQ
         3ZEkS6ZcI/JRFj5g1M9bW5kiDiKFNv73tO8LClzdbvfuWynycGMYlK2M3j1oLJdY8tGJ
         Bqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410169; x=1792014969;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQo1Hws+HsXBbw1Bo6bEwZwNkKrNE3CFbMFyNe5D7H0=;
        b=yrkjBWFQPHb3KqpHKOarmcYVVdYEroyh/qryByI7BpB4or2BmLNwt4RQlii8Ak3VHd
         EeaZNtLAKDySlN4RvCGWKLbgcqq1cWfKTvWMOHffHxk1wtPbvZBAbDcgCDvK+eDjLOBA
         ry0aOJEffh9sy3uWGoeURdLUkGGel4qK9WVbsOHgnWBV46FRnIfgpsw1V8FdYz+tiWyU
         b9g0iOsxggPUNpIx81IbgoaC+VkNUAKI33LKJrjKL29ile9+j8HNyl2VzgSYVBou51vR
         umdxq7AtUifVgjdrpufvoPS+pIpUC0IgpyVLYIcpV/2bvOQX3Ybp5D/LAaMlScVtWsAq
         ZXZg==
X-Gm-Message-State: AFuF++lLAPVnkRkT+6v3wYvzF/LbfIeFGis+gU/2i5MHxZmWbbwohY5J
	tRkJMe9aRnhk5AjJ5tp+xuk+jW9h4CCR0AUNDz3ozFQloHoA7c6W/fU6qlZCAaJw
X-Gm-Gg: AYBFou3Y9/TqzyWr5vybDzyqUVaQS9JNNAxdnwD+Snsa+xmSZPhN6Je7E7C4S2wjha1
	D5MphEFsm5g+zZJBoJ5vvWvwMVLm49CfkUvQ2uIEtrHE9iDRSJzrpCUzfbBhFrnd0qHh07zvKFo
	ESy+B6Zp9r7yAjOO6xGbN9pX3Wiy3r/8ZrFOpggKA1MN9mF5bDi7OP5TlHc6xUEF3cSz60JxCIK
	u/vA2N28aSe9bJq4am1NJuE8mMBi0UAVU3+AfW07SnegRQuG4WbvCaWdjLhNP77XgoJVBAqKK1g
	zD9SMBw/FXQjibo8BBR2OH5ZelyGqXMVWpeI3AZHMubmXWifiqkt7EFo3g1VyXxxKSHJNCw3g1J
	fvQ4BHlJO7pQXA7k08CUeBLdDl218epqGWgd3WQm5EuXUQcsJt/2CXj/1h+8W3VHbT/2fMfFRww
	lFUFui84FsA/j5Y7Z/bQ+OlfEIhwJQAoRAAl3UvUkBF79/M4LaCk9Pw9JIJ3/hnNLSEjrfEkhiz
	qCS
X-Received: by 2002:a05:6808:2383:b0:4e9:3412:14a5 with SMTP id 5614622812f47-4fc45b6975dmr3078500b6e.28.1791410169203;
        Wed, 07 Oct 2026 14:56:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.147.134])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc49a71636sm3466085b6e.16.2026.10.07.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:56:07 -0700 (PDT)
Message-Id: <b5db64d56fa328ae95c420f20ecb1ebe6a39b987.1791410164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 21:56:01 +0000
Subject: [PATCH v7 1/4] fetch: add remote.<name>.refmap
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

Add a per-remote config variable, remote.<name>.refmap, that provides
the default value for --refmap the same way remote.<name>.fetch
already provides the default refspecs to fetch. Like --refmap itself,
it only maps refs that are actually being fetched, so it has nothing
to do when there is nothing explicit to fetch, on the command line or
via remote.<name>.fetch.

A refspec-less fetch with a refmap configured but nothing else to say
what to fetch falls back to the same defaults as a remote with no
refspec or refmap at all. Only an explicit --refmap given on the
command line with no command-line refspec to go with it is still
rejected, since that combination is a plain mistake to type, unlike a
remote.<name>.refmap configured on its own. A remote.<name>.fetch
that is also configured is used as before.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |  5 +++
 Documentation/fetch-options.adoc |  3 ++
 builtin/fetch.c                  |  6 ++-
 remote.c                         | 12 +++++-
 remote.h                         |  6 +++
 t/t5510-fetch.sh                 | 63 ++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..103eada406 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -33,6 +33,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.refmap::
+	The default value of the `--refmap` option for linkgit:git-fetch[1].
+	Used to map remote refs being fetched to remote-tracking refs to
+	store. See the `--refmap` entry in linkgit:git-fetch[1].
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 47dea1de8e..c2101a7b39 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -244,6 +244,9 @@ endif::git-pull[]
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
++
+`remote.<name>.refmap` provides the default value for this option, the
+same way `remote.<name>.fetch` provides the default refspecs to fetch.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..b0ad8c0b5f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -509,6 +509,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -552,8 +554,8 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap.nr)
-			fetch_refspec = &refmap;
+		if (effective_refmap && effective_refmap->nr)
+			fetch_refspec = effective_refmap;
 		else
 			fetch_refspec = &remote->fetch;
 
diff --git a/remote.c b/remote.c
index 71170f36a9..99a086ea5a 100644
--- a/remote.c
+++ b/remote.c
@@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	refspec_init_push(&ret->push, the_hash_algo);
 	refspec_init_fetch(&ret->fetch, the_hash_algo);
+	refspec_init_fetch(&ret->refmap, the_hash_algo);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
 	string_list_init_dup(&ret->negotiation_include);
@@ -176,6 +177,7 @@ static void remote_clear(struct remote *remote)
 
 	refspec_clear(&remote->push);
 	refspec_clear(&remote->fetch);
+	refspec_clear(&remote->refmap);
 
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
@@ -539,6 +541,12 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		refspec_append(&remote->fetch, v);
 		free(v);
+	} else if (!strcmp(subkey, "refmap")) {
+		char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		refspec_append(&remote->refmap, v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -988,7 +996,9 @@ void ref_push_report_free(struct ref_push_report *report)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return refspec_find_match(&remote->fetch, refspec);
+	if (remote->fetch.nr)
+		return refspec_find_match(&remote->fetch, refspec);
+	return refspec_find_match(&remote->refmap, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
diff --git a/remote.h b/remote.h
index cca02033b9..ac485a584d 100644
--- a/remote.h
+++ b/remote.h
@@ -90,6 +90,12 @@ struct remote {
 
 	struct refspec fetch;
 
+	/*
+	 * How to map refs fetched without an explicit destination into our
+	 * own namespace, the same as the --refmap command line option.
+	 */
+	struct refspec refmap;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 300bd5396d..cfd09db155 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,69 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	)
 '
 
+test_expect_success 'remote.*.refmap acts like --refmap on the command line' '
+	test_when_finished "git -C three config --unset remote.origin.refmap" &&
+	git branch -f side &&
+	git -C three config remote.origin.refmap \
+		"refs/heads/*:refs/remotes/other/*" &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
+		test "$o" = "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
+		git rev-parse --verify refs/remotes/other/main
+	)
+'
+
+check_fetched_refs () {
+	git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'remote.<name>.refmap without tracking (baseline)' '
+	test_when_finished "rm -fr fetch-refmap-baseline fetch-refmap-upstream" &&
+	git init -b main fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git -C fetch-refmap-upstream branch other &&
+	git init fetch-refmap-baseline &&
+	(
+		cd fetch-refmap-baseline &&
+		git remote add origin ../fetch-refmap-upstream &&
+
+		# Without fetch refspec, but with fetch refmap.
+		git config --unset-all remote.origin.fetch &&
+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
+
+		# Nothing tracked, nothing fetched, no error.
+		git fetch origin &&
+		check_fetched_refs <<-\EOF &&
+		EOF
+
+		# Nothing tracked, explicit ref on the command line.
+		git fetch origin main &&
+		check_fetched_refs <<-\EOF &&
+		refs/remotes/origin/main
+		EOF
+
+		# With both refmap and fetch configured, remote.<name>.fetch
+		# wins: a refspec-less fetch follows it as usual, and
+		# remote.<name>.refmap plays no part in deciding what to
+		# fetch, only in remapping something that is already being
+		# fetched by name.
+		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
+		git fetch origin &&
+		check_fetched_refs <<-\EOF
+		refs/remotes/origin/HEAD
+		refs/remotes/origin/main
+		refs/remotes/origin/other
+		EOF
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

