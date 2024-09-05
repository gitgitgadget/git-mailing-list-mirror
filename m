Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1318E25
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504732; cv=none; b=G2x5hg8XWkpL2CPEqqupxjFGevdtK/tasgsyfAWlxUjSMAmmZzpRFHTf2zww9mhhgjxW2VUC0V41kTFpzpKeExOyoZfXEBfVSIKVn+dGUkFDTKFDT7Se/NBdClFSQLZuUlVplOwoIGq+Mt/di4/0bGo24Z/QK6m9BNVZbe4Ux6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504732; c=relaxed/simple;
	bh=kpFihyVt4hkvKrCjulmPbv3rAzz1yoo5/AKLFr/cK+c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FIbCcEbpQKlpnaBNBWBtRgGHDByZn5cEwxZD5ZMEU0UPSzwRnmMJE9H4xs8OduC8nZf6WL0moEAYRwO6VgJmHBYxkdFZbkLJHf12nMYRq/N5mesXHx0S928TIgB5Rdy9UHhxQAq/wlvHRhXLe0ZXgpbmfZ+xtI0v6wmAGoDRUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dITo3llD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dITo3llD"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86910caf9cso255001366b.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 19:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725504728; x=1726109528; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyX8BiQrSbOobc2X29oXbwMuF3Ay/vwpV/ohgKIXecw=;
        b=dITo3llDKErVkSJCHzTPdMzlSO7ZsINzFGe0kKpFmsNpRjg8meEKqPN97RPIuOcZD8
         ueuWN7maxhELbf97dK6ApN/u6YcCsltRriMyOBTUuzI0XnD1iO1e0qZilYJ+SKKB3cdS
         o6TA7gzB/28SNoZEXS3Whb53PuZ3kKKlHroD7F9Vwky/5gmFJBLjQh/EmSuUPSmoodMW
         ISsWSP09I4oIoNg2BJvPd7cX9IIKAC25S6QO+VuWZXZH8SnCIr7K2YDNgK77/wSqA/yc
         gaop2WHU4HWMkgjYElBbrmjsLdxDKJvluY3JRAXnWlRUjBdm2CW8+MKMl6q18tatGAlc
         yANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725504728; x=1726109528;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyX8BiQrSbOobc2X29oXbwMuF3Ay/vwpV/ohgKIXecw=;
        b=HMOmCpDR/Ww61uLdBBeJPjOl+R3LGTLU6k1wXFyCNM7Uh5inTpTWJ8VdXmjTSCMVXG
         a7JVuNcnTn0Ff2NlYpuPscbjIkvz+T3FtBFt9pHfPeq9ygW6lcNgH0c/RRNL41S0Psou
         DXiWIwr5uazs69AISP5rsyHjhLnleMie2g6FzrBrUxzUM4tTx27XBz2YoTwMe+8eX5cQ
         JGlClqVbeh3LlipG6A9poiCBKzCR27/mfuYU7CdPJM8omYBsOoMmWbs+0jgSbnJsOXZY
         G57oDIBTGtJlyR8+bDY/Q8bkvrvM3LIIoG3QvfjfMhcwzjJrJwkIfx88jOxONpG+rTMd
         rMew==
X-Gm-Message-State: AOJu0YzWgr/cDLT2lWcmYLQ3jWzsIqZz88IEj71JDiYeMq2ysrWSrNY9
	jjXzwQbinO91rWcsePjAmsXJZ7UnW+odBLdz75cQ+Z+2/iUmsg9WD6aVTg==
X-Google-Smtp-Source: AGHT+IEMxL/ue2ITTFTGvfXdVH0bHSEqYAHEgN77IW2ZeGMK2elWqmdIIb/OaC54myyxJ+hsqY1CKQ==
X-Received: by 2002:a17:907:3fa4:b0:a7a:8dcd:ffb4 with SMTP id a640c23a62f3a-a8a430913f9mr483037766b.17.1725504727166;
        Wed, 04 Sep 2024 19:52:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623c2b8csm66420866b.181.2024.09.04.19.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:52:06 -0700 (PDT)
Message-Id: <pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com>
In-Reply-To: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 02:52:05 +0000
Subject: [PATCH v2] remote: prefetch config
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
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    "Junio C Hamano [ ]" <gitster@pobox.com>,
    Derrick Stolee <stolee@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>

From: Shubham Kanodia <shubham.kanodia10@gmail.com>

Large repositories often contain numerous branches and refs, many of
which individual users may not need. This commit introduces a new
configuration option (`remote.<remote>.prefetch`) to allow
users to specify which remotes to prefetch during
the maintenance task.

Key behaviors:
1. If `remote.<remote>.prefetch` is unset or true, running
   `git-maintenance` will prefetch all refs for the remote.
2. If `remote.<remote>.prefetch` is set to false, the remote
   will be ignored for prefetching.

In a future change, we could also allow restricting the refs that are
prefetched per remote using the `prefetchref` config option per remote.

Both of these options in unison would allow users to optimize their
prefetch operations, reducing network traffic and disk usage.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
    remote: prefetch config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1779%2Fpastelsky%2Fsk%2Fmaintenance-prefetch-remote-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1779/pastelsky/sk/maintenance-prefetch-remote-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1779

Range-diff vs v1:

 1:  667553b114b ! 1:  1d58b782e22 remote: prefetch config
     @@ builtin/gc.c: static int fetch_remote(struct remote *remote, void *cbdata)
       	if (remote->skip_default_update)
       		return 0;
       
     -+	if (remote->prefetch == 0)
     ++	if (!remote->prefetch)
      +		return 0;
      +
       	child.git_cmd = 1;
     @@ remote.h: struct remote {
       	struct refspec fetch;
       
      +	/*
     -+	 * This setting for whether to prefetch from a remote
     ++	 * The setting for whether to prefetch from a remote
      +	 * when a fetch is invoked with a prefetch flag.
      +	 *  -1 = unset
      +	 *   0 = don't prefetch from this remote
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +		# Run maintenance prefetch task
      +		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
      +
     -+		# Check that remote1 was not fetched (prefetch=false)
     -+		test_subcommand ! git fetch remote1 --prefetch --prune --no-tags \
     -+			--no-write-fetch-head --recurse-submodules=no --quiet \
     -+			<prefetch.txt &&
     -+
     -+		# Check that remote2 was fetched (prefetch=true)
     -+		test_subcommand git fetch remote2 --prefetch --prune --no-tags \
     -+			--no-write-fetch-head --recurse-submodules=no --quiet \
     -+			<prefetch.txt &&
     -+
     -+		# Check that remote3 was fetched (prefetch unset, default to true)
     -+		test_subcommand git fetch remote3 --prefetch --prune --no-tags \
     -+			--no-write-fetch-head --recurse-submodules=no --quiet \
     -+			<prefetch.txt &&
     ++		# Check that if remotes were prefetched properly
     ++		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
     ++		test_subcommand ! git fetch remote1 $fetchargs <prefetch.txt &&
     ++		test_subcommand git fetch remote2 $fetchargs <prefetch.txt &&
     ++		test_subcommand git fetch remote3 $fetchargs <prefetch.txt &&
      +
      +		# Verify that changes are in the prefetch refs for remote2 and remote3, but not remote1
      +		test_must_fail git rev-parse refs/prefetch/remotes/remote1/one &&


 Documentation/config/remote.txt   |  5 ++++
 Documentation/git-maintenance.txt |  7 +++---
 builtin/gc.c                      |  3 +++
 remote.c                          |  3 +++
 remote.h                          |  9 +++++++
 t/t7900-maintenance.sh            | 42 +++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 8efc53e836d..c2b3876192c 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -33,6 +33,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.prefetch::
+	If false, refs from the remote would not be prefetched for
+	the prefetch task in linkgit:git-maintenance[1]. If not set,
+	the value is assumed to be true.
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 51d0f7e94b6..2fd38706ea2 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -97,9 +97,10 @@ commit-graph::
 
 prefetch::
 	The `prefetch` task updates the object directory with the latest
-	objects from all registered remotes. For each remote, a `git fetch`
-	command is run. The configured refspec is modified to place all
-	requested refs within `refs/prefetch/`. Also, tags are not updated.
+	objects from all registered remotes unless they've disabled prefetch
+	using `remote.<remote>.prefetch` set to `false`. For each such remote,
+	a `git fetch` command is run. The configured refspec is modified to place
+	all requested refs within `refs/prefetch/`. Also, tags are not updated.
 +
 This is done to avoid disrupting the remote-tracking branches. The end users
 expect these refs to stay unmoved unless they initiate a fetch.  However,
diff --git a/builtin/gc.c b/builtin/gc.c
index 427faf1cfe1..2ca3a3e7d6a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1027,6 +1027,9 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	if (remote->skip_default_update)
 		return 0;
 
+	if (!remote->prefetch)
+		return 0;
+
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "fetch", remote->name,
 		     "--prefetch", "--prune", "--no-tags",
diff --git a/remote.c b/remote.c
index 8f3dee13186..05edb3a5f40 100644
--- a/remote.c
+++ b/remote.c
@@ -140,6 +140,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	CALLOC_ARRAY(ret, 1);
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
+	ret->prefetch = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
@@ -456,6 +457,8 @@ static int handle_config(const char *key, const char *value,
 		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prefetch"))
+		remote->prefetch = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
 		if (!value)
 			return config_error_nonbool(key);
diff --git a/remote.h b/remote.h
index b901b56746d..4522fdec354 100644
--- a/remote.h
+++ b/remote.h
@@ -77,6 +77,15 @@ struct remote {
 
 	struct refspec fetch;
 
+	/*
+	 * The setting for whether to prefetch from a remote
+	 * when a fetch is invoked with a prefetch flag.
+	 *  -1 = unset
+	 *   0 = don't prefetch from this remote
+	 *   1 = prefetch from this remote
+	 */
+	int prefetch;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index abae7a97546..7484e1f1d46 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -245,6 +245,48 @@ test_expect_success 'prefetch multiple remotes' '
 	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
 '
 
+test_expect_success 'prefetch respects remote.*.prefetch config' '
+	test_create_repo prefetch-test-config &&
+	(
+		cd prefetch-test-config &&
+		test_commit initial &&
+		test_create_repo clone1 &&
+		test_create_repo clone2 &&
+		test_create_repo clone3 &&
+
+		git remote add remote1 "file://$(pwd)/clone1" &&
+		git remote add remote2 "file://$(pwd)/clone2" &&
+		git remote add remote3 "file://$(pwd)/clone3" &&
+
+		git config remote.remote1.prefetch false &&
+		git config remote.remote2.prefetch true &&
+		# remote3 is left unset
+
+		# Make changes in all clones
+		git -C clone1 switch -c one &&
+		git -C clone2 switch -c two &&
+		git -C clone3 switch -c three &&
+		test_commit -C clone1 one &&
+		test_commit -C clone2 two &&
+		test_commit -C clone3 three &&
+
+		# Run maintenance prefetch task
+		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
+
+		# Check that if remotes were prefetched properly
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
+		test_subcommand ! git fetch remote1 $fetchargs <prefetch.txt &&
+		test_subcommand git fetch remote2 $fetchargs <prefetch.txt &&
+		test_subcommand git fetch remote3 $fetchargs <prefetch.txt &&
+
+		# Verify that changes are in the prefetch refs for remote2 and remote3, but not remote1
+		test_must_fail git rev-parse refs/prefetch/remotes/remote1/one &&
+		git fetch --all &&
+		test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
+		test_cmp_rev refs/remotes/remote3/three refs/prefetch/remotes/remote3/three
+	)
+'
+
 test_expect_success 'loose-objects task' '
 	# Repack everything so we know the state of the object dir
 	git repack -adk &&

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
