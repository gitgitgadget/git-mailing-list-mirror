Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7951C27
	for <git@vger.kernel.org>; Wed,  8 May 2024 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126756; cv=none; b=lLXLHYEdVUrb8YHY13xP9DE4N+NhF0tkzQRQW0sP24GNjfMaUBaDIvjsJ31A/yaAwLF54+1Q9L2elmgjf6gUKXYW1kxTDIqaMWCj6KBcIMhPHko2oqIm1DuMdlW2nhnyQLt679vje3e2joJr8z6f22qeFEWuC0CwBBeafO+T9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126756; c=relaxed/simple;
	bh=mfgmNbX6z8bttKa1cSBdQ/+M3rpvrCoPOR3dVJGsoq4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W3zztSIvTbx9QhKY6+1UCHoWSeacKC+xEPS65P+eFQsVe/ACrlUGeH3yh5bYaBjRZOv5Oq4SdVmMA+ebZsv5VBQ8NW8Bw/Kk4uS+71L5HLQFTMapPcxvy7KKF6ntHoadP2jn2CuJbdQ9We7R7X7bHLfEwZD+6w/opxMnpSCDZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+fUBfxU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+fUBfxU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b869326daso25646225e9.0
        for <git@vger.kernel.org>; Tue, 07 May 2024 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715126752; x=1715731552; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSqHwTWmV5CCe+PnzZVJwa1EPZXm9gIp+G04AzlAOng=;
        b=K+fUBfxUfkLkj6tHTH+uIxetV/P+KscwSTmGAzIp1yZnpECcFYbHCvp1cwsiTY58ZW
         eHmZTWFtQB1CAcRTjW8/bkPA7QbAgndt870lHFGEkEfbLZ/vWJ8ntVSCwliT6WZKDOEE
         bnInXpcUmnJoQGk5Tw39Xzpi+jtG8ij9dAjlGAbEdZ/kCXU0NS4wEHutdoMvNDRpKCME
         MKzOteGwxR6o83y1stiNGkrLA10neNT4ago4ge4TxL8LoCOwx+QiQjFMN0hBnLMeFTOP
         oJiUWbPHION/INgSdNZwLgikTNZZ3+8NPWtzMBnm0Nloi003kfFqkQAm4bct4i+J3KpG
         ij1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126752; x=1715731552;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSqHwTWmV5CCe+PnzZVJwa1EPZXm9gIp+G04AzlAOng=;
        b=iAg3wWdIqxbVgx6Bu1LuKyzYOFfzJSVms0eBHkX6b/uA2DXZz+E6XTlxaSWCtrllbr
         O+sBmrvy1f4Bbam20TbD5luogiBp/62pWEBS0bSlbGc6iGlKBCcVn0Lhk3MZf+mFUKSz
         Xo59qGkrGOtQnpVdEJ5/ThldW73o9tkXJg5Tb5s/ZUBICH+JDwEyDTvsjvrxQ09Is0EE
         atqWmssMnB5mVuUx4QUfBhvve9oOl2Q1d0B/PASG6bbLWy/DDBikEGlwM+b1yWQN+cAk
         +4Lenbas3yac/xCf4tBiqCmLIvQS0S7gZnTS0O2ifczfMGbij38FODNnJK7B8BE0zRs1
         LPZA==
X-Gm-Message-State: AOJu0YxZ2IscU8sSCgNKTFvGo2ZKd1KavpgL99/opQiRf6F5bJVDYUxf
	Zzdz2mmw9++I+vadEHyBHl0fbzZyH+ZzvNh0zUj1/K32VQzGjKrFNQHPng==
X-Google-Smtp-Source: AGHT+IH4GM02ofBj+sN9JIHfP0T7soMJHeyxMBCfr7S4CPwHs2TnLGl99MBGdVsGS1pylOO3ea6EoA==
X-Received: by 2002:a05:600c:1548:b0:41c:12c:aaa2 with SMTP id 5b1f17b1804b1-41f72593122mr9183535e9.33.1715126751016;
        Tue, 07 May 2024 17:05:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b2653bsm2450145e9.4.2024.05.07.17.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:05:50 -0700 (PDT)
Message-Id: <pull.1724.v3.git.1715126749391.gitgitgadget@gmail.com>
In-Reply-To: <pull.1724.v2.git.1714874298859.gitgitgadget@gmail.com>
References: <pull.1724.v2.git.1714874298859.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 May 2024 00:05:49 +0000
Subject: [PATCH v3] scalar: avoid segfault in reconfigure --all
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

During the latest v2.45.0 update, 'scalar reconfigure --all' started to
segfault on my machine. Breaking it down via the debugger, it was
faulting on a NULL reference to the_hash_algo, which is a macro pointing
to the_repository->hash_algo.

In my case, this is due to one of my repositories having a detached HEAD,
which requires get_oid_hex() to parse that the HEAD reference is valid.
Another way to cause a failure is to use the "includeIf.onbranch" config
key, which will lead to a BUG() statement.

My first inclination was to try to refactor cmd_reconfigure() to execute
'git for-each-repo' instead of this loop. In addition to the difficulty
of executing 'scalar reconfigure' within 'git for-each-repo', it would
be difficult to perform the clean-up logic for non-existent repos if we
relied on that child process.

Instead, I chose to move the temporary repo to be within the loop and
reinstate the_repository to its old value after we are done performing
logic on the current array item.

Add tests to t9210-scalar.sh to test 'scalar reconfigure --all' with
multiple registered repos. There are two different ways that the old
use of the_repository could trigger bugs. These issues are being solved
independently to be more careful about the_repository being
uninitialized, but the change in this patch around the use of
the_repository is still a good safety precaution.

Co-authored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    scalar: avoid segfault in reconfigure --all
    
    Update 'scalar reconfigure --all' to be more careful with the_repository
    pointer, avoiding sudden halts in some scenarios.
    
    ------------------------------------------------------------------------
    
    I noticed this while validating the v2.45.0 release (specifically the
    microsoft/git fork, but this applies to the core project).
    
    Thanks, Patrick, for digging in and finding the critical reasons why
    this issue can happen. Patrick ACKed the sign-off in v2.
    
    v3 includes an update to the commit message. Sorry that I missed this
    paragraph when updating for v2.
    
    -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1724%2Fderrickstolee%2Fscalar-reconfigure-repo-handle-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1724/derrickstolee/scalar-reconfigure-repo-handle-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1724

Range-diff vs v2:

 1:  5be703b6c70 ! 1:  00d101986f8 scalar: avoid segfault in reconfigure --all
     @@ Commit message
          faulting on a NULL reference to the_hash_algo, which is a macro pointing
          to the_repository->hash_algo.
      
     -    This NULL reference appears to be due to the way the loop is abusing the
     -    the_repository pointer, pointing it to a local repository struct after
     -    discovering that the current directory is a valid Git repository. This
     -    repo-swapping bit was in the original implementation from 4582676075
     -    (scalar: teach 'reconfigure' to optionally handle all registered
     -    enlistments, 2021-12-03), but only recently started segfaulting while
     -    trying to parse the HEAD reference. This also only happens on the
     -    _second_ repository in the list, so does not reproduce if there is only
     -    one registered repo.
     +    In my case, this is due to one of my repositories having a detached HEAD,
     +    which requires get_oid_hex() to parse that the HEAD reference is valid.
     +    Another way to cause a failure is to use the "includeIf.onbranch" config
     +    key, which will lead to a BUG() statement.
      
          My first inclination was to try to refactor cmd_reconfigure() to execute
          'git for-each-repo' instead of this loop. In addition to the difficulty


 scalar.c          | 10 +++++++---
 t/t9210-scalar.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/scalar.c b/scalar.c
index fb2940c2a00..7234049a1b8 100644
--- a/scalar.c
+++ b/scalar.c
@@ -645,7 +645,6 @@ static int cmd_reconfigure(int argc, const char **argv)
 	};
 	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
 	int i, res = 0;
-	struct repository r = { NULL };
 	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
 
 	argc = parse_options(argc, argv, NULL, options,
@@ -665,6 +664,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 	for (i = 0; i < scalar_repos.nr; i++) {
 		int succeeded = 0;
+		struct repository *old_repo, r = { NULL };
 		const char *dir = scalar_repos.items[i].string;
 
 		strbuf_reset(&commondir);
@@ -712,13 +712,17 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 		git_config_clear();
 
+		if (repo_init(&r, gitdir.buf, commondir.buf))
+			goto loop_end;
+
+		old_repo = the_repository;
 		the_repository = &r;
-		r.commondir = commondir.buf;
-		r.gitdir = gitdir.buf;
 
 		if (set_recommended_config(1) >= 0)
 			succeeded = 1;
 
+		the_repository = old_repo;
+
 loop_end:
 		if (!succeeded) {
 			res = -1;
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 428339e3427..a41b4fcc085 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -180,6 +180,44 @@ test_expect_success 'scalar reconfigure' '
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
+test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
+	repos="two three four" &&
+	for num in $repos
+	do
+		git init $num/src &&
+		scalar register $num/src &&
+		git -C $num/src config includeif."onbranch:foo".path something &&
+		git -C $num/src config core.preloadIndex false || return 1
+	done &&
+
+	scalar reconfigure --all &&
+
+	for num in $repos
+	do
+		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+	done
+'
+
+ test_expect_success 'scalar reconfigure --all with detached HEADs' '
+	repos="two three four" &&
+	for num in $repos
+	do
+		rm -rf $num/src &&
+		git init $num/src &&
+		scalar register $num/src &&
+		git -C $num/src config core.preloadIndex false &&
+		test_commit -C $num/src initial &&
+		git -C $num/src switch --detach HEAD || return 1
+	done &&
+
+	scalar reconfigure --all &&
+
+	for num in $repos
+	do
+		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+	done
+'
+
 test_expect_success '`reconfigure -a` removes stale config entries' '
 	git init stale/src &&
 	scalar register stale &&

base-commit: e326e520101dcf43a0499c3adc2df7eca30add2d
-- 
gitgitgadget
