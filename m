Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0622A7E9
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043715; cv=none; b=nov1PFX6ITrKJtot1XupSc6Re6KhkN4cgzhiX/iQAW98MpbSBCNpRv3PiEuVMri3Z4/x/hENzVT75PTfTmrFCihvVOlOOemhcZh6qyru1vC0wpTyu72Ly7lln+0QgIKhsAdY3GDJ/9Shu5QFNrK1DigxNkJCokgVcJMbyPHhN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043715; c=relaxed/simple;
	bh=fClW7Ovucv1f65uJNwLsjE+wUxohuoVdmgCAHOxhfAE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JeujqxUkQvH/NnWk5wl/jBcvBhqbnxgsLBYDuHgNe3HjYRPL7THMxZau7A8d5BMre1ZlzcfWIJh54TpdInkH/Yyr50oKdZYp/3WOOYYN+hPRPdmfjfML3mrVtff0FyR5Ojz3861KVYS/H+1FAfpaTAzV2zcMT7SA6iyyenHdTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edAcPxi/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edAcPxi/"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so13895466d6.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 14:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760043712; x=1760648512; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hRBfgz0V6QcsbomkUNcvJpGLtGabGLauXbo4bImB4/c=;
        b=edAcPxi/J9FDJMEjdfEInItisePGqj2gS3o7uzU0r4n0gHGwETfXykVT3g4oa//0cG
         44yIM5WFSkwIiqA4reNF31ziHOXArGa2t8sE1MvgqzoefCB8VtjAC6iG+6jPD9kb5ITG
         UJczYinyOVKWyNyRYJuskMMuEMf9/Vio9XuldA9zPgguM+AWG7brY4wJkAsLVcEl2TnS
         +0+kC1P9CaG/Xg5QESrQqarPSw+X/TyDV8eigtCrVoqRgIP+zVHPdjyhNVy9kPGFbsO2
         px13zdaQtyB2hjBQGlj1OcaKwgFcAZ2tnhnq/mJ3V8uGtIX3a6nowSYK6f97upUMCzxX
         PCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760043712; x=1760648512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRBfgz0V6QcsbomkUNcvJpGLtGabGLauXbo4bImB4/c=;
        b=xLRAbqQCo0SCHjgBOzY2Yk1Cg/h3vVXjKJbGtQqiiVmwOQlTcQpbhBuv/HGu+cveNO
         wEAIC1w+apk5v78dFFGXsmmz6+GzwEAdiA1ka2f4avToFAsGI4O96BErdB2pA253vptV
         otCypocCelhkVzDiAjvjXmeYdgn6JJHCWX+hLkHup8/8sCCBNJq3xmc525DVpzqoyMY8
         6/S1AiRHnqy0IDjgJfSMk5abkqcxlScnkkDcg+rwU26CoQl9r2VtFpvrqCq0p8s9C0Ti
         CWaabOxKLL9Pxk9fpDwjEMz5WgSDaymnPTmyToysxYuGix6iBcA/VaquPFGV13+170zW
         8mqA==
X-Gm-Message-State: AOJu0Yyti/NOK6UTu9MgV6yTy2nBnnhQ7w6H3zZgw3mxPBMLnuo4rGIB
	TfbNa+V+K/sojij+0+uFDpfZq81JREWOoD9xSL3249RTQSD4yhPNuA02vVBmeg==
X-Gm-Gg: ASbGnctzJTNsvHW9ptXX4q8IPn9813yGV4+4ZBzh9yY9WdB3Ml4nUEtck8+AuD7T4gI
	dAP5l5LWp15VftC/FOV/VZDK2LN2aCte1B+NoRbf4e0r3eGYUvqYoG2PnrkxWtmKQqCb6hGb5rl
	waFgkeqRPwV5vKIcBgUDIxRA8um2qd2USCUoEARuK4l6pfupiLKewOdRTXjxg9wbp61RFFgUDOG
	q/rKxDhtawNyN3hukKh3+wKTAz5/SrgaGI1tMukwfGEG81qetzHdjVDzw+h+jmKFd5ArdNoR1OB
	ZPO2a8gwcOmKu/AsYN0nTr8CUxJFfRdbQlGz4LKG+YVPgQdM1A4qW0Y24PfLbURJLjToLv6kazW
	7G7EQORHi/W41LD5rsrxKxhNeIy0PHKkPlm178Jrq9X5/HF7G
X-Google-Smtp-Source: AGHT+IEaohxrdGEtZM68gsseTJNHX9yK85zPQ7G4/1kQsFK6gzZLANoMyy7pc1rqYZoV+XqCseHh2g==
X-Received: by 2002:a05:6214:d63:b0:804:6a87:c9dd with SMTP id 6a1803df08f44-87b2104f3a9mr135085216d6.5.1760043712071;
        Thu, 09 Oct 2025 14:01:52 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.38.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc345df08sm3261956d6.10.2025.10.09.14.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:01:51 -0700 (PDT)
Message-Id: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
From: "Emily Yang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Oct 2025 21:01:50 +0000
Subject: [PATCH] commit-graph: add new config for changed-paths & recommend it
 in scalar
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
"--no-changed-paths" option.

Large monorepos using Git's background maintenance to build and update
commit-graph files could use an easy switch to enable this feature
without a foreground computation. In this commit, we're proposing a new
config option "commitGraph.changedPaths" - "true" value acts like
"--changed-paths"; "false" disables a previous "true" config value but
doesn't imply "--no-changed-paths". This config will always respect the
precedence of command line option "--changed-paths" and
"--no-changed-paths".

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
    
    Thanks, Emily

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1983%2Femilyyang-ms%2Fchanged-paths-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1983/emilyyang-ms/changed-paths-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1983

 Documentation/config/commitgraph.adoc |  8 +++++
 builtin/commit-graph.c                |  2 ++
 scalar.c                              |  1 +
 t/t5318-commit-graph.sh               | 44 +++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/Documentation/config/commitgraph.adoc b/Documentation/config/commitgraph.adoc
index 7f8c9d6638..c540e8a43d 100644
--- a/Documentation/config/commitgraph.adoc
+++ b/Documentation/config/commitgraph.adoc
@@ -8,6 +8,14 @@ commitGraph.maxNewFilters::
 	Specifies the default value for the `--max-new-filters` option of `git
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
+commitGraph.changedPaths::
+	If true, then `git commit-graph write` will compute and write
+	changed-path Bloom filters by default, equivalent to passing
+	`--changed-paths`. If false or unset, changed-path Bloom filters
+	will only be written when explicitly requested via `--changed-paths`.
+	Command-line options always take precedence over this configuration.
+	Defaults to unset.
+
 commitGraph.readChangedPaths::
 	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
 	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
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
