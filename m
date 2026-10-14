Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFE471412
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961459; cv=none; b=uRBK2e3EWw1+2GzQUj9kJcPsiL05crO5gpNahVhkmPWPOfpiSP+JpphIt6ZEkj7JKkN8Kt70+fs3slpAK1dmae/MAo4ZM6TPSSqyCs/cOIJ/uMMwHz5mAkntEmWBoH30NJLLCFQR6N924xzTl98rrTab8MNKyJkHErRBE6Apz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961459; c=relaxed/simple;
	bh=v8DTE473I6YKrBWyN9gFxU/cv0O7EpY938nh5ZyOe/o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZpX6wyxau8xABRwweAeeP6iIIt+ftvBTzs+LGnKhNnPUFIfTNn2zw18ntaHCQH7sw9tWLhnwWY821UUWUHfm30+V3nwBo/VODxBuNhqT1sKSb753tt7v3Z6obnRX+5KAJLfh+JsoZveaQ3gYdhjrcWYy6rXay0NIahInr0IzIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYhdpeZu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYhdpeZu"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab98332238so2047198a91.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961458; x=1792566258; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lzqT3n+68Wmh1moG4NQqnao4F3DR3XAFd6lUNcLJze4=;
        b=RYhdpeZuamdL/Eow0Nh3y/bLEZn4h0/ENGIwpXOnz1+4w/H+erfxpRWoxAsy7EVqVV
         breK7854j8pZmPhAlJx/9Olz/m3FUU+5QtIkrA38PzqWKfTE4iC03mGfnnc1a1roL59W
         GMnNW36m+AbaoQWqBFNXNKQG5E3Empl/zfehA0RID1V7UjZEuBXv/78b6yumz1/53knP
         DMDPUqoFDiKgOOYacv97e4FenhawNjVbHvGIh5l8ideRhNgcATNB51JnpkhrQ4FLFxIj
         JP1msnrQd6i75IR/l1ySwtzqzgskv/vPScHsajbwN5GH5EAR8uPd6eGZthQn9CQGuIId
         VKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961458; x=1792566258;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzqT3n+68Wmh1moG4NQqnao4F3DR3XAFd6lUNcLJze4=;
        b=qLOMeumwpxiHMpy0K1CtC4r9jVZgH6mQB4eSryCKkhhF7klwT41vqZ9JH41L9pt1MN
         sTMHOOxoTyU62yCT3J29S7Bni9qUzMd141uZ97B71OTwGY++2MU7lF8lqIeKrHqXl6vS
         KSHi34IY+mbEroU/TQhlr69Eb4XmfZtJeqAnus0dKtV+7Fnvp+4WRP9FpptrbMoJlHFx
         K6KW3DY2/fnRf4Zxw09KI0l1Qo+7BDePkHB6wRTww9zSfVVWeVzSpIOuyLI3JjISrHyr
         aBh7TogEWiurgRutp7PXb2oiT8RboDfhvLIZQ4hgSmlIu4vtpUQE8NtNmdeQx+ZEIJcf
         d5jg==
X-Gm-Message-State: AFq9FYJC0r1+3I0fwtid9B3W9UBk0XLwOHFiV8VIAgBzjhqLpFUBXe+o
	gOdCImUOT6muAZUwmsWNR5u66EuJpuU7HEeHnVctzzSqfeMD568ZMv/KHdNaRA==
X-Gm-Gg: AYBFou0D78A70XC7tteNjLpWUiuJ8Y89MJBAg+gJqGu8s6DBbHPfuZIp4zhxmVx+xMB
	xknzn67p6xCMRQLlbCCrYjWQMQtPAtT78Km4Mh2NY1MQWugoX1Qybvz9OpbIVgIA3XggzOK7l0X
	WXWd2+LbDjSni/oUqUcVPFQapBwOpQHSZb5mc4LDPFsdbwFFJEUJ+4YIFdZ6yxEZMS0zuYdNZBs
	cEAHUbOwvcmE1z+x/sbZTwBnWCFCGS21MEItBYs17F9dG6+Cg8ZkTTJYrAI6KUSCTO2BjrqZal3
	OwLghvu+gOj+VkW1d3/vI91fjVP5/0B2xdjhPokockyfZbkSiU/sCJPJRVkDWRYFl3FsPBCeeoI
	k9K0BWyPclr63aOhJSjoTbt+hhRNULq0s+ylKvbhuLXMiZxWo3JHTdIf1jYBwwnAnhBAxURCitA
	UGmKQU5IuqVzqS5RtxRsEGDKcs+0dSwSKf4z8Gh4SL2WehQHjgSYqgbZfvXtXZsald7tpB7ENJc
	g==
X-Received: by 2002:a17:90b:3b90:b0:3a6:f1d2:57fb with SMTP id 98e67ed59e1d1-3ab3ae7b9d1mr13001306a91.48.1791961457433;
        Wed, 14 Oct 2026 00:04:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6658931a12.23.2026.10.14.00.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:04:16 -0700 (PDT)
Message-Id: <2a48c21bc834367af595f4480596e100502623c9.1791961452.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 07:04:08 +0000
Subject: [PATCH v9 1/5] fetch: add remote.<name>.refmap
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
 builtin/fetch.c                  | 10 ++++-
 remote.c                         | 12 +++++-
 remote.h                         |  6 +++
 t/t5510-fetch.sh                 | 63 ++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 3 deletions(-)

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
index b2decc6cfd..c1c65c7528 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -509,6 +509,12 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	/*
+	 * The --refmap command line option, if given, takes precedence
+	 * over remote.<name>.refmap.
+	 */
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -552,8 +558,8 @@ static struct ref *get_ref_map(struct remote *remote,
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

