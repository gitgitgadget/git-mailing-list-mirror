Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41919EEC4
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554764; cv=none; b=mgcJCGyF7dDsOkP7PVl1hOgof/01YX/opLzxGKbnglv7CsL4JVqXTkuhRMTbBgWfL6BA5WIqyr37nQ1SV1SHCRM3Li2E+1/mw5YpFMNfw3Esv3oSjeUAG3bnKmpROhK5V1q19uz/TAXHvghbdNCPWgUbSZdVLqJuRC95nz1r5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554764; c=relaxed/simple;
	bh=ccSigKlAgpT50EybWLcLfiRdm0MVW7HM53jfRAb5Rwo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=giRcRVLMsDBb2H4piY/NUYW/ax386nK4ieEEqr+lqC2fq5UxcCBdYt/vV4pwGYA35PrUfFigcZyM9HofkngJszrcpaLucQiabkimR4hh2rChlTWyeGKBbJ+V328ZINCeJzxETCFhZV9B6g8QImS0lQFHl1mXv+5qQ/91eDsLTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+xAiVLd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+xAiVLd"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83597ce5beso173800166b.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725554761; x=1726159561; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSV0jTF1HdXDWaToE6UD2Nqfik0k3u+Jq+UQz8r8yWI=;
        b=G+xAiVLdkfaZRnoesJ05ClwaH3VGnl3XYTHBXEPBZBUNk72tXTTx2ELcIwLfse89zS
         vnf4dtHN0vERlht1YWMoCjm2Nm7wdIFBg+7NNAY5Yk3+OzPWsPfSTDV23KdZkQpSWGOE
         Bk+hlJe24smY8swrsc54aTvLbB6BpH1D0/6j9v218tqynPtnjpjf0OCZ5jviguhY6eKp
         B3DgtpVJEieSDNAaGLbmj7Vf4WSSKZ+KXw8a4CLML3xYsAKnKkObPQdi+e+52sjR3pIo
         ZUR5sg8yimRn6XhwR09Mos5yxmUGlDESDx0+TM/38vNGkH+qFOHuNDDVIaXDiUKQB68z
         7nsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554761; x=1726159561;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSV0jTF1HdXDWaToE6UD2Nqfik0k3u+Jq+UQz8r8yWI=;
        b=aj0eA1mv3SmITtHWDPWlq4d5+lLzsmBT13rtkWCnT/9+j2grfcPSzGyWFFdTEFmb35
         gHxtkEwRJroyMjfgpsiNgPrw81k+voBKN4hx39TwxbQr9CBbaLXVh2ro8sLVINbujdG3
         igJYZTLklfCkyuRvu99r4qUnI0OODvi3IE1FeNcDwToJT2t43VfRtZffxy5DYm9uoh+7
         /YxfjxRfp2DeEvaoz6bY3RE3vXEFUhg0IsQ0UJZC1CssZZXCQycVl9bbGlsGXurpvY6x
         7KM84ey2G1iyT44/stgVlOwXOBXD43cRvMceFoPdTKLraH4U+7eV3DSk5KmFQefKtnkY
         N8sg==
X-Gm-Message-State: AOJu0YygetQ2Mq4G/d7uGwa7+q2rLuHehaE4cnLGJMXFjwLehTT8D3pR
	2OuJM1JIMArf5Wi43w4qtHVgn6zo68hrIGYbyY5NjCpw0KxGFpPar6G/Gw==
X-Google-Smtp-Source: AGHT+IF7jG244RPUUex7XAHn1fyJa4dwLo+H8ZqxnkQJJ+oJYZiWbrDxd4ih4sQ/LZKnOsDRzExjxw==
X-Received: by 2002:a17:907:9303:b0:a8a:7884:c491 with SMTP id a640c23a62f3a-a8a7884c7a4mr231521166b.17.1725554760043;
        Thu, 05 Sep 2024 09:46:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a7ff8914esm28840466b.156.2024.09.05.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:45:59 -0700 (PDT)
Message-Id: <pull.1779.v3.git.1725554758463.gitgitgadget@gmail.com>
In-Reply-To: <pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com>
References: <pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 16:45:58 +0000
Subject: [PATCH v3] remote: prefetch config
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1779%2Fpastelsky%2Fsk%2Fmaintenance-prefetch-remote-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1779/pastelsky/sk/maintenance-prefetch-remote-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1779

Range-diff vs v2:

 1:  1d58b782e22 ! 1:  c348f8efd33 remote: prefetch config
     @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
       	CALLOC_ARRAY(ret, 1);
       	ret->prune = -1;  /* unspecified */
       	ret->prune_tags = -1;  /* unspecified */
     -+	ret->prefetch = -1;  /* unspecified */
     ++	ret->prefetch = 1;
       	ret->name = xstrndup(name, len);
       	refspec_init(&ret->push, REFSPEC_PUSH);
       	refspec_init(&ret->fetch, REFSPEC_FETCH);
     @@ remote.h: struct remote {
       
       	struct refspec fetch;
       
     -+	/*
     -+	 * The setting for whether to prefetch from a remote
     -+	 * when a fetch is invoked with a prefetch flag.
     -+	 *  -1 = unset
     -+	 *   0 = don't prefetch from this remote
     -+	 *   1 = prefetch from this remote
     -+	 */
      +	int prefetch;
      +
       	/*


 Documentation/config/remote.txt   |  5 ++++
 Documentation/git-maintenance.txt |  7 +++---
 builtin/gc.c                      |  3 +++
 remote.c                          |  3 +++
 remote.h                          |  2 ++
 t/t7900-maintenance.sh            | 42 +++++++++++++++++++++++++++++++
 6 files changed, 59 insertions(+), 3 deletions(-)

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
index 8f3dee13186..4024018b1d6 100644
--- a/remote.c
+++ b/remote.c
@@ -140,6 +140,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	CALLOC_ARRAY(ret, 1);
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
+	ret->prefetch = 1;
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
index b901b56746d..182dc105a5a 100644
--- a/remote.h
+++ b/remote.h
@@ -77,6 +77,8 @@ struct remote {
 
 	struct refspec fetch;
 
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
