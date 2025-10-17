Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A827E07E
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734744; cv=none; b=nb0mfLUMtlfGBzlGXUl+4tTPpwDOXy09goAkoxP1v59QwirEtllPU/m6ln5+PyWNeeIRHvZc6AbuaaQ41iDe4dFJnszPNbV4RF1b9IdRj+7iG9wl5bRPPeX8+3EOZerddF4JAtoyXXarK9gt/bmy6c1vXpIPHxssyXKOW1FwCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734744; c=relaxed/simple;
	bh=XefqBvAMTUmOnPhRQpqHJqdM/PyYI1r2eMOT/s2owrE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZcFicrRDHVWH60W5Ev6eaSPWvGOe/PPduiCE3vLmI7qhtECPKyZZpTA3Yt6g8oZS8mYnBnO9dC1rv8loet7gdAYIKUw5c3XNgc0mTM6Bln4Fr/VfHnJVtcHj9xCZspplKk5R6al2+3olvTJ4o/oonn/vcRXgW/YAJ4c31fcAivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3Mlk3fy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3Mlk3fy"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-85a4ceb4c3dso337848785a.3
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760734741; x=1761339541; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP0S/U6xDHKk2cbHpXWVKtC/D/5DxckZBVG5mmbFXew=;
        b=B3Mlk3fybEB6ZF9o09Mil6DfD3zdN87/g5u8cdLwByaY4dZcGWC8Y7fTze6T/2zBdy
         6LbI38xXa8uXtnQEEKuC67dW8nsEsAFnIm6r8sfFfbzHYeVwBvvJOaoNmW8MXFRkKTWv
         s/MR7bUbPgZLtsBIkxhr6k6Re04QURicMdsr60wyyPCn00LPffc3emdOUmgNXARp4tMF
         3dtjRgQA96K5K/aSJsDykz9ijGzhMF16X9lVWvARCoPEZrRVU15rUDqLRBH3ikaszDD8
         BHM0vPDFXxkn/J1kKuzO5tVYUAaBz6haECO9ZJJ4+coiib/OX1gKV9zGJmmA0AEdAt8d
         LFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734741; x=1761339541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fP0S/U6xDHKk2cbHpXWVKtC/D/5DxckZBVG5mmbFXew=;
        b=jmkmE6oZFThsRlzwV/uJWDMZCcYlfBcjxNAambzunSOV1cq5TfagG8sx28KCBZv6eX
         bCdUsUCX2WtKwQVwA+WfDwZZV3AqmMlpTNFN3Rp0Yxi7nOU8HIY9mbprqbLoa38ztOLq
         5NLtbUYaU0VltBDbIRXV2Duq/1DCEkhhHEsrUpJsmYaT7C9/A5hU3WtVyVM9saScwqxS
         PXqZnw3M+mtWGpdZZ5izKOLmcKbj1Fd+1LRe1WPN2/tJs79p5lX/cHIsF/7VOcLkbMpd
         zqgQyCDvUe/7w5ZDa0QmldweblavhGQstygAJrqi372WTM+ajXrZs+5h31/6tjYxNekF
         sLOA==
X-Gm-Message-State: AOJu0YwY21nQBKudjQiYFxhwpU/VZO0tHzHYv2fYucDK5yCBsYvEQixy
	VPLJxJeGR7Vc8PnJ3+/PjWhhX74KZGOZFDF7nmg0MUTncSHw2rftml4DAED/v8l9
X-Gm-Gg: ASbGncsLLpC2rq15mLVsGNgR1CJUAc/raZvUDBiViPvpFgFcprZuq7AbXI8RWzrFEud
	fDgArby4BGxOLMmlPP0WWO1GkyuXsob7g90v5oLLhVDJMgDLCDNXpFYSEtiyhyghwtdzVDB06Rp
	BIQEb8QeC6ziHE/cQ301ThAjBLWWwCU5ClpzR2XAS02nfuUiWTKp1MXRrXv5YMixPfQEiAXmFq3
	cs1soRldHzQJY6+XjkdO4T3U+R0R9P/wv+f3iJ+sWjxuCbqT4AZ5/Pq3tPqmsZqRIaLg1RVJ+uf
	M9ta9i3EKSFoRdeEV43gtDmpTOw/87pB6z2BExFItATejP78gOGMvmHd/ePQvTe6y9WwbtnuZz/
	uKvE6YfT6YsWe6GtoHvVcPRym/EDoJRxxKRyIrJK3HAPpvy22UxsPwADCoO5t8Z/8fConCInQQd
	H7gG9KY6V6pE4=
X-Google-Smtp-Source: AGHT+IFOg0RvJXRUJFyqektRR8I0p/2AF3vtiOjoDlXg41SYFnxhvojoKcJTxX/RBzi9p9p/EBItoQ==
X-Received: by 2002:a05:620a:19a2:b0:891:8ed1:b3c0 with SMTP id af79cd13be357-8918ed1b3f1mr295751785a.50.1760734740620;
        Fri, 17 Oct 2025 13:59:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.14.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891c9d2db9esm48520885a.0.2025.10.17.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:59:00 -0700 (PDT)
Message-Id: <pull.1983.v2.git.1760734739642.gitgitgadget@gmail.com>
In-Reply-To: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
References: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
From: "Emily Yang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 20:58:59 +0000
Subject: [PATCH v2] commit-graph: add new config for changed-paths & recommend
 it in scalar
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    me@ttaylorr.com,
    ps@pks.im,
    newren@gmail.com,
    Emily Yang <emilyyang.git@gmail.com>,
    Emily Yang <emilyyang.git@gmail.com>

From: Emily Yang <emilyyang.git@gmail.com>

The changed-path Bloom filters feature has proven stable and reliable
over several years of use, delivering significant performance
improvement for file history computation in large monorepos. Currently
a user can opt-in to writing the changed-path Bloom filters using the
"--changed-paths" option to "git commit-graph write". The filters will
be persisted until the user drops the filters using the
"--no-changed-paths" option. For this functionality, refer to 0087a87ba8
(commit-graph: persist existence of changed-paths, 2020-07-01).

Large monorepos using Git's background maintenance to build and update
commit-graph files could use an easy switch to enable this feature
without a foreground computation. In this commit, we're proposing a new
config option "commitGraph.changedPaths":

* If "true", "git commit-graph write" will write Bloom filters,
  equivalent to passing "--changed-paths";
* If "false" or "unset", Bloom filters will be written during "git
  commit-graph write" only if the filters already exist in the current
  commit-graph file. This matches the default behaviour of "git
  commit-graph write" without any "--[no-]changed-paths" option. Note
  "false" can disable a previous "true" config value but doesn't imply
  "--no-changed-paths".

This config will always respect the precedence of command line option
"--[no-]changed-paths".

We also set this new config as optional recommended config in scalar to
turn on this feature for large repos.

Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Emily Yang <emilyyang.git@gmail.com>
---
    commit-graph: add new config for changed-paths & recommend it in scalar
    
    Hello,
    
    I'm Emily and I'm interested in contributing to Git. This is my first
    contribution to Git, super excited!
    
    I'm from Microsoft and spend most of my time working in the Office
    MonoRepo (OMR, one of the largest repos in the world). Recently I've
    been working with Derrick Stolee on Git performance related topics. We'd
    love to propose a small enhancement on the existing changed-paths Bloom
    filters feature to benefit large repos like OMR. Please kindly review
    the code and provide your feedback!
    
    What's included in v2:
    
    I received feedback about the confusion around the config explanation,
    so in v2 I added more clarification in the doc and commit message,
    hopefully it helps!
    
    Thanks, Emily

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1983%2Femilyyang-ms%2Fchanged-paths-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1983/emilyyang-ms/changed-paths-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1983

Range-diff vs v1:

 1:  90b271e905 ! 1:  365db79f4d commit-graph: add new config for changed-paths & recommend it in scalar
     @@ Commit message
          a user can opt-in to writing the changed-path Bloom filters using the
          "--changed-paths" option to "git commit-graph write". The filters will
          be persisted until the user drops the filters using the
     -    "--no-changed-paths" option.
     +    "--no-changed-paths" option. For this functionality, refer to 0087a87ba8
     +    (commit-graph: persist existence of changed-paths, 2020-07-01).
      
          Large monorepos using Git's background maintenance to build and update
          commit-graph files could use an easy switch to enable this feature
          without a foreground computation. In this commit, we're proposing a new
     -    config option "commitGraph.changedPaths" - "true" value acts like
     -    "--changed-paths"; "false" disables a previous "true" config value but
     -    doesn't imply "--no-changed-paths". This config will always respect the
     -    precedence of command line option "--changed-paths" and
     -    "--no-changed-paths".
     +    config option "commitGraph.changedPaths":
     +
     +    * If "true", "git commit-graph write" will write Bloom filters,
     +      equivalent to passing "--changed-paths";
     +    * If "false" or "unset", Bloom filters will be written during "git
     +      commit-graph write" only if the filters already exist in the current
     +      commit-graph file. This matches the default behaviour of "git
     +      commit-graph write" without any "--[no-]changed-paths" option. Note
     +      "false" can disable a previous "true" config value but doesn't imply
     +      "--no-changed-paths".
     +
     +    This config will always respect the precedence of command line option
     +    "--[no-]changed-paths".
      
          We also set this new config as optional recommended config in scalar to
          turn on this feature for large repos.
     @@ Documentation/config/commitgraph.adoc: commitGraph.maxNewFilters::
      +commitGraph.changedPaths::
      +	If true, then `git commit-graph write` will compute and write
      +	changed-path Bloom filters by default, equivalent to passing
     -+	`--changed-paths`. If false or unset, changed-path Bloom filters
     -+	will only be written when explicitly requested via `--changed-paths`.
     -+	Command-line options always take precedence over this configuration.
     -+	Defaults to unset.
     ++	`--changed-paths`. If false or unset, changed-paths Bloom filters will
     ++	be written during `git commit-graph write` only if the filters already
     ++	exist in the current commit-graph file. This matches the default
     ++	behavior of `git commit-graph write` without any `--[no-]changed-paths`
     ++	option. To rewrite a commit-graph file without any filters, use the
     ++	`--no-changed-paths` option. Command-line option `--[no-]changed-paths`
     ++	always takes precedence over this configuration. Defaults to unset.
      +
       commitGraph.readChangedPaths::
       	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
       	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
      
     + ## Documentation/git-commit-graph.adoc ##
     +@@ Documentation/git-commit-graph.adoc: take a while on large repositories. It provides significant performance gains
     + for getting history of a directory or a file with `git log -- <path>`. If
     + this option is given, future commit-graph writes will automatically assume
     + that this option was intended. Use `--no-changed-paths` to stop storing this
     +-data.
     ++data. `--changed-paths` is implied by config `commitGraph.changedPaths=true`.
     + +
     + With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
     + filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
     +
       ## builtin/commit-graph.c ##
      @@ builtin/commit-graph.c: static int git_commit_graph_write_config(const char *var, const char *value,
       {


 Documentation/config/commitgraph.adoc | 11 +++++++
 Documentation/git-commit-graph.adoc   |  2 +-
 builtin/commit-graph.c                |  2 ++
 scalar.c                              |  1 +
 t/t5318-commit-graph.sh               | 44 +++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/commitgraph.adoc b/Documentation/config/commitgraph.adoc
index 7f8c9d6638..70a56c53d2 100644
--- a/Documentation/config/commitgraph.adoc
+++ b/Documentation/config/commitgraph.adoc
@@ -8,6 +8,17 @@ commitGraph.maxNewFilters::
 	Specifies the default value for the `--max-new-filters` option of `git
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
+commitGraph.changedPaths::
+	If true, then `git commit-graph write` will compute and write
+	changed-path Bloom filters by default, equivalent to passing
+	`--changed-paths`. If false or unset, changed-paths Bloom filters will
+	be written during `git commit-graph write` only if the filters already
+	exist in the current commit-graph file. This matches the default
+	behavior of `git commit-graph write` without any `--[no-]changed-paths`
+	option. To rewrite a commit-graph file without any filters, use the
+	`--no-changed-paths` option. Command-line option `--[no-]changed-paths`
+	always takes precedence over this configuration. Defaults to unset.
+
 commitGraph.readChangedPaths::
 	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
 	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
diff --git a/Documentation/git-commit-graph.adoc b/Documentation/git-commit-graph.adoc
index e9558173c0..6d19026035 100644
--- a/Documentation/git-commit-graph.adoc
+++ b/Documentation/git-commit-graph.adoc
@@ -71,7 +71,7 @@ take a while on large repositories. It provides significant performance gains
 for getting history of a directory or a file with `git log -- <path>`. If
 this option is given, future commit-graph writes will automatically assume
 that this option was intended. Use `--no-changed-paths` to stop storing this
-data.
+data. `--changed-paths` is implied by config `commitGraph.changedPaths=true`.
 +
 With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
 filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index fe3ebaadad..d62005edc0 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -210,6 +210,8 @@ static int git_commit_graph_write_config(const char *var, const char *value,
 {
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
 		write_opts.max_new_filters = git_config_int(var, value, ctx->kvi);
+	else if (!strcmp(var, "commitgraph.changedpaths"))
+		opts.enable_changed_paths = git_config_bool(var, value) ? 1 : -1;
 	/*
 	 * No need to fall-back to 'git_default_config', since this was already
 	 * called in 'cmd_commit_graph()'.
diff --git a/scalar.c b/scalar.c
index 4a373c133d..f754311627 100644
--- a/scalar.c
+++ b/scalar.c
@@ -166,6 +166,7 @@ static int set_recommended_config(int reconfigure)
 #endif
 		/* Optional */
 		{ "status.aheadBehind", "false" },
+		{ "commitGraph.changedPaths", "true" },
 		{ "commitGraph.generationVersion", "1" },
 		{ "core.autoCRLF", "false" },
 		{ "core.safeCRLF", "false" },
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 0b3404f58f..98c6910963 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -946,4 +946,48 @@ test_expect_success 'stale commit cannot be parsed when traversing graph' '
 	)
 '
 
+test_expect_success 'config commitGraph.changedPaths acts like --changed-paths' '
+	git init config-changed-paths &&
+	(
+		cd config-changed-paths &&
+
+		# commitGraph.changedPaths is not set and it should not write Bloom filters
+		test_commit first &&
+		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
+		test_grep ! "Bloom filters" error &&
+
+		# Set commitGraph.changedPaths to true and it should write Bloom filters
+		test_commit second &&
+		git config commitGraph.changedPaths true &&
+		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
+		test_grep "Bloom filters" error &&
+
+		# Add one more config commitGraph.changedPaths as false to disable the previous true config value
+		# It should still write Bloom filters due to existing filters
+		test_commit third &&
+		git config --add commitGraph.changedPaths false &&
+		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
+		test_grep "Bloom filters" error &&
+
+		# commitGraph.changedPaths is still false and command line options should take precedence
+		test_commit fourth &&
+		GIT_PROGRESS_DELAY=0 git commit-graph write --no-changed-paths --reachable --progress 2>error &&
+		test_grep ! "Bloom filters" error &&
+		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
+		test_grep ! "Bloom filters" error &&
+
+		# commitGraph.changedPaths is all cleared and then set to false again, command line options should take precedence
+		test_commit fifth &&
+		git config --unset-all commitGraph.changedPaths &&
+		git config commitGraph.changedPaths false &&
+		GIT_PROGRESS_DELAY=0 git commit-graph write --changed-paths --reachable --progress 2>error &&
+		test_grep "Bloom filters" error &&
+
+		# commitGraph.changedPaths is still false and it should write Bloom filters due to existing filters
+		test_commit sixth &&
+		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
+		test_grep "Bloom filters" error
+	)
+'
+
 test_done

base-commit: 79cf913ea9321f774da29b2330b5781d5ff420ef
-- 
gitgitgadget
