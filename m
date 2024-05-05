Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0AEA4
	for <git@vger.kernel.org>; Sun,  5 May 2024 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714874305; cv=none; b=We/7UoXL/u2JWmZGq5E/jIrqLtyV4+IxIOlmbv/Qmqsael8vkolv73pmFcfcZvsNJP6EM9d1Po+fVFnEDUjIOx0uJeyBUJYVtjyvEnR0iL5ZIp5dfXW9o+sq+6mMdPEVzoNXNc2ZjGEB/K9trBgVdA72I6bVmpAWoyAhSTJplmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714874305; c=relaxed/simple;
	bh=6XXsZbaSE1+cWUiM1YrRkdTTnx9xnnxk+kkLYzHyhts=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hlRm15Xa6/Jg0em1JrP7tK89lqwC7wgvRiJZOn902hqbyzpsIyXczlLR8F3FNmGM7F8n8/dFe9svh19EJC79DEO1FkjVbJ01GkZywgwZLKH/W8N6HDSgE0EafbppHi4/iC46wTzG28mTdCV43xu8ebVRgOURF9S1A07FnfZXV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtRmMaGW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtRmMaGW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso7368515e9.1
        for <git@vger.kernel.org>; Sat, 04 May 2024 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714874301; x=1715479101; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf505yleB6Cc1F3zXo8uBBu1nx+u8tohhDB4yctkcDY=;
        b=QtRmMaGW40xIPVDOlyvQckdYiCESxUSOgU55JVsj0NzKH+1oX5k+LrygFWmGNI2tLk
         fgvFFKfSTVew/dQPWeAgkBrTvST8j04J19IjSX+lCStfIvuADGukeuORe0gVnNlglgxI
         zYsqa4PNVWlLMfjaj8VziQUe3M5BSfJ1LdU1g+sR5ofJIPmCB5hbjWHyHBZKkOVhDZy9
         bwR9hXKF9vfxuegHKfe1uwYb2pokt7mQEeMa+kwCctkfExcH3vNobJ+wrn0SveOqpOuh
         CL/k597QIK9oUtVR/kFi+bQv4GYIku5uLhML2TbIyWHCZWDSvfAfYbqLlY6mvwltqYmJ
         NDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714874301; x=1715479101;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf505yleB6Cc1F3zXo8uBBu1nx+u8tohhDB4yctkcDY=;
        b=NJcJl5E61xrIvp9qSj7h8Nn9CuUvnNLpkl+PktcVftcPTKF68N4vqmM0EchXjdvayu
         a8FyB3bTjeu5lkIDj3ZYu8SxtsNktnhSCTtVLpb6JeROybPXz7RIcFr2xYazGg6qYFs/
         Th9npU7j4evH7Jl/jvMBLZy3Co4r43EQDobL7GQGTX6LqsrpCF/toO8RRGsJQFY8GFEB
         ZAenhwTlT7j+hAlrEms2NFV0HvZfSBMMuQTo4aCxaf9AFF4OeCnZVm/sNk6PXXhrPiY/
         JTLuNci8TxhY10gyxVYMVRl6MjMaOdCoje64tOnrocp125sfCwnLxC6ycITT/QgxJub9
         PB1Q==
X-Gm-Message-State: AOJu0YzqUDDPe2AILtA1guwF190sqLP1TTfDfkx+6FdZXkW91hTaNT8H
	FkuW+UtgXpGA3otPfOIkFZ0rKln2KIsA9PmdFlB4HaDa1SMUBSLv2RT/og==
X-Google-Smtp-Source: AGHT+IFJsnF9juHFtyIrr7u4NpVHJWwM5oHxdI4/OX/0/euKPGqZztcRbGo45DzAuJ8GTglwYA4WYA==
X-Received: by 2002:a05:600c:4eca:b0:41b:f5ea:e6fa with SMTP id g10-20020a05600c4eca00b0041bf5eae6famr4728242wmq.10.1714874301051;
        Sat, 04 May 2024 18:58:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b0041b4c293f75sm10783460wms.13.2024.05.04.18.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 18:58:20 -0700 (PDT)
Message-Id: <pull.1724.v2.git.1714874298859.gitgitgadget@gmail.com>
In-Reply-To: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>
References: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 May 2024 01:58:18 +0000
Subject: [PATCH v2] scalar: avoid segfault in reconfigure --all
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

This NULL reference appears to be due to the way the loop is abusing the
the_repository pointer, pointing it to a local repository struct after
discovering that the current directory is a valid Git repository. This
repo-swapping bit was in the original implementation from 4582676075
(scalar: teach 'reconfigure' to optionally handle all registered
enlistments, 2021-12-03), but only recently started segfaulting while
trying to parse the HEAD reference. This also only happens on the
_second_ repository in the list, so does not reproduce if there is only
one registered repo.

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
    this issue can happen. I've included Patrick's test cases and given him
    co-authorship. I forged his sign-off, so could you please ACK that
    sign-off, Patrick?
    
    -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1724%2Fderrickstolee%2Fscalar-reconfigure-repo-handle-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1724/derrickstolee/scalar-reconfigure-repo-handle-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1724

Range-diff vs v1:

 1:  6f0f5fa8f00 ! 1:  5be703b6c70 scalar: avoid segfault in reconfigure --all
     @@ Commit message
          reinstate the_repository to its old value after we are done performing
          logic on the current array item.
      
     -    Add a test to t9210-scalar.sh to test 'scalar reconfigure --all' with
     -    multiple registered repos, as a precaution. Unfortunately, I was unable
     -    to reproduce the segfault using this test, so there is some coverage
     -    left to be desired. What exactly causes my setup to hit this bug but not
     -    this test structure? Unclear.
     +    Add tests to t9210-scalar.sh to test 'scalar reconfigure --all' with
     +    multiple registered repos. There are two different ways that the old
     +    use of the_repository could trigger bugs. These issues are being solved
     +    independently to be more careful about the_repository being
     +    uninitialized, but the change in this patch around the use of
     +    the_repository is still a good safety precaution.
      
     +    Co-authored-by: Patrick Steinhardt <ps@pks.im>
     +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## scalar.c ##
     @@ t/t9210-scalar.sh: test_expect_success 'scalar reconfigure' '
       	test true = "$(git -C one/src config core.preloadIndex)"
       '
       
     -+test_expect_success 'scalar reconfigure --all' '
     ++test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
      +	repos="two three four" &&
      +	for num in $repos
      +	do
      +		git init $num/src &&
      +		scalar register $num/src &&
     ++		git -C $num/src config includeif."onbranch:foo".path something &&
      +		git -C $num/src config core.preloadIndex false || return 1
      +	done &&
      +
     @@ t/t9210-scalar.sh: test_expect_success 'scalar reconfigure' '
      +		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
      +	done
      +'
     ++
     ++ test_expect_success 'scalar reconfigure --all with detached HEADs' '
     ++	repos="two three four" &&
     ++	for num in $repos
     ++	do
     ++		rm -rf $num/src &&
     ++		git init $num/src &&
     ++		scalar register $num/src &&
     ++		git -C $num/src config core.preloadIndex false &&
     ++		test_commit -C $num/src initial &&
     ++		git -C $num/src switch --detach HEAD || return 1
     ++	done &&
     ++
     ++	scalar reconfigure --all &&
     ++
     ++	for num in $repos
     ++	do
     ++		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
     ++	done
     ++'
      +
       test_expect_success '`reconfigure -a` removes stale config entries' '
       	git init stale/src &&


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
