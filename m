Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A5311C15
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619340; cv=none; b=E1IfMHpVHm5/0awYbtxpM1Fu9/3u/Wa18RmAr7WBJCQGO6fVHK4S1vfwkaH5BHCTu3bletyENRLFFPWgMWeZ3pPng4lXsI6FTen7LgoDa1CwzmUcsTzLFyB9RPOWEpuvsa+t5SUo0RDhWbER1NCA2l1IkhhXJzvDTN4bf5l4tJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619340; c=relaxed/simple;
	bh=v8DTE473I6YKrBWyN9gFxU/cv0O7EpY938nh5ZyOe/o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SEe5/V5vLfHJPDhS3cKviCd7NgYeZvm7+GRBEq7yn0oCa/YlM4DMOKdu7pV4FYBnrNi+5g0ASDYr2QrfaeGNP2KuuwFViMz+4BrBMU8w8qn5NQwC1Dqt1ZWBBVzomvXXHl+8h4kkPmglJSJxlCJXiXpGDSh06iox0WHCJhqYfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibY9cTHo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibY9cTHo"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e762768f3so55461185a.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619337; x=1792224137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lzqT3n+68Wmh1moG4NQqnao4F3DR3XAFd6lUNcLJze4=;
        b=ibY9cTHoQAiDUkikLmRC4x28x4tYP4xP4o69vf66i92Mca6+2LDyThhzBo5LCKnMK4
         AxwUoLwpgu0bRY4TH/e4QQiMKob+VvGJWAKrHD48nUuWkTJFggcr0kj+CoO/uhMsc/v0
         kvix1ZiRs6LoaErWa4TTPwLcDPSkSs+oFwEFYkHGvfn0W7Ej7Tpz7WnBLysMJDA5aHSI
         XFn6MmlBUGdyEyXq3TuYXSs+WUsQda7Uk6+2y8hYBkmsQy4A0tqHpC+462skK8zNO5j2
         nDsg17ipUDmykSn61AwB7GcSTLROTGoWNx3j++HQ63MaEsIe7YkaA6OtLiXq52Z+aDU/
         eW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619337; x=1792224137;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzqT3n+68Wmh1moG4NQqnao4F3DR3XAFd6lUNcLJze4=;
        b=EeGjML45eKogeM3x8pu9OgqTY/ChGEz8RKMGDHFN58myEPxtwMXpaqM7WPpU++jBN2
         xgImeHa6aCTlbiweDtd6O7qWIzzm1PPjS+miOnFc10/1GJaWSafkm4u6wQ8xk6UYu/C6
         aa7cbXQD5pOf2lE5XLCzl2mVI9HW7Adrmy5jCa04qbAjCC/iwahy4w7LUSVSGbmBax6K
         h5Z8qfzjB4CUg+lxXR9dmZ53FtdljNI1cbtq9uIJ8x3hVpru+IFhSw27uqWjPJeUOHfW
         EvtckA7EjcUor2IyMqQ5w3mrcXuRhXyZPDGqYSj+QPIQE09gSOiaOe6dwREZdGSyfEcr
         yDDw==
X-Gm-Message-State: AFq9FYILy+9cOsTEfg4kDIwC76n2qPLGo6fxQN4HtmhIWg9IQvbNhrMS
	xnUaQhqFsE8uMkNwp4R+jnlpxY9I6OIhskQhduu3NaQXzHVbVsQNFjtioPwGDA==
X-Gm-Gg: AYBFou1POXa7gfoPK0n7fvj0j6QdOBZ2iL/LKjwGyZyqaB4EOHf10NLIaDqWHWll862
	xNhuEkMTI7O9cNjMzNNirMO0Y+QtME7QmYluarB72nJMs6xniSWIDbIwE10CfsnojdwLYo2JgCA
	rDYA6Vs+VGRbFjHZy3sijoUyk4DdaHx5ZYtRWq56K44rf+C9kpST/uFVoqgeIi5n1HXuLRp1nn0
	ZuJhGZa26DVYbfbssmMriJLK3wkMI6khOaoOOAS4Ik2i22Y13djSzlPUSLI9yO01Pk2iEoYsehR
	fcXsTrDxH95K9SPhFy/gHo82yB68SGkgRpo3PxOJuXU0h8Xi9+WRREhdY9BnQCHHja185xqWyaD
	+sj7H6oBKxlAD8LCZr9yfSstFbEIPyOan/X21oMP+MRv8P3kRi/xfMq9JvpMumNgWLJRR5WuDOX
	0l2b9z+jtYLlyRSWPmhBOPqOgpt1pjGnh7PQeYUldWbe7BzVIhC5hdvTVXXa7y/pxuv3S+7GeQQ
	nM=
X-Received: by 2002:a05:620a:a2cf:10b0:93e:c12c:f142 with SMTP id af79cd13be357-93ec12d0865mr417554185a.76.1791619336992;
        Sat, 10 Oct 2026 01:02:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.190.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5507646fsm38651016d6.28.2026.10.10.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:02:16 -0700 (PDT)
Message-Id: <2a48c21bc834367af595f4480596e100502623c9.1791619334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 08:02:10 +0000
Subject: [PATCH v8 1/5] fetch: add remote.<name>.refmap
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

