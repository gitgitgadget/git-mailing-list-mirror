Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB71EEC0
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465810; cv=none; b=HXFDEJcqPspPZmCYaLR+ol9EYC61xHpQPH4vYuxTZuKVhvUoa/4wo0cXxZVIt3OZczG4xyMWdcivopeaTq9nkX4ocL1GNzrssZGB4PnDiw4z//4PbP4fGhaf2AJDzBqzJcpQgnjZusfD2RMuJ+UdnEKKFZEPIg0u1HS0AKbIdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465810; c=relaxed/simple;
	bh=of1agHN+NeyRvaWp9dR/ulkltnuZgo5/PVJ8Wu4TVsg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L34Po2Du8OUGnea0O0jKqejDoBHQAm9H3MKz+KQ+wdbUiu+vDehug+sXzqP9qE5qN25BJA1UTYpODCxi3sk6JdfvG6WUx8zhpG9NF0GbILIe2x4fVa4SsWQauXyTmf4rsX7Po9ua8WuI6Zkd68TO+Ry2Y5nvMlpG6k0Hl8SSFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km2hve02; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km2hve02"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12713e56abdso2703753c88.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 07:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772465808; x=1773070608; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u997dbNS9VlsnD+gDzqZP2hD7lRdg10UTE96P7nc6iA=;
        b=km2hve02Ojenk/FDvZQIB7X4qBG5oHLPQw4eIVZllxkccvRfKe2qDxCxWEguBhfpnv
         HsW0rpCvKAOIgw5iRQFP8TDyxJPjBZ+i3aoUbB3GA+yQMMYffwy3Nu5q85PkkatJYfNn
         A1sQ6NaPfgrYGq0GzmnKfCs6JxTVDCgfRSTg4ShMxnVcYkjPm/R3yRVwnWQnag7dP6SV
         5D8PZmKJUYihr8jfcpjdmVguUMEOJemNCs+Cv4M0KEW5UaLdIo/zMUC9yYWLUMznvIV5
         j7ir7loOVkE+pTwRV/oTF6O2Hdt6lOxJl0un9mvmWIOH6Yw9OYPXscLs17X8VAweNwR/
         /Tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465808; x=1773070608;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u997dbNS9VlsnD+gDzqZP2hD7lRdg10UTE96P7nc6iA=;
        b=YB/uDcibjl9O74wp3VwLRe0xxqCOUhSpCzuHINnuSLdHwEOnS90bADiHSC3jX5N4p1
         nnQnly1YnwNny3+d7DufE3TkcAsYV7W/wrviqVXmfUt0sHLdnrpGfVj0O7uZiHwBabcy
         DO9HsytG7PnXJseRgF+lDhiJbCEz6HTVsWc8W15/lYxjUbUUWRT/S1xNkdaBer7plzGJ
         uNZ9RqS2tqZ6Fo/7n4CHdC/9A3cfRD4+3UZ71864xVk01Cqz4iFbpM6JnOLqgtJbi+KQ
         82WH+mxIq0ypKn5Fokpgh62Qefethd35pVUV/5BkYDc2ZpgqMiysWzmcx/2BgZAL0tPO
         8vUw==
X-Gm-Message-State: AOJu0YxbfcMFYq3x/5YYW4bxLnsHQg5oGtonP04gz5wxNpG5Koz1xINk
	GS62oX47wQB2xqDSn99CgFpB9trtoO7cPoHR2dKlK8n9A/KnhO+ZhdziN+K3Xg==
X-Gm-Gg: ATEYQzw5kPdsY+/3Pjwg4oC8TaImppC0JDBjhpcBIT8+/YOERTjbVtZfEu1DNQu94QB
	khMaR3mdofL8D+L0roFiLzSH5VVB5+LMAyzAf3L63mhXDLjIuLbtANp9LI33TCcskJStCrqWeMU
	VbpO6aDxK3CsFmnO5lurqgstILsQ+Smvo6SJQFFyv8o01B6wkMwH9fWd87EkhPjOWW+4LVthUpJ
	IWww4YaPtYkHGQrQv38whj8IQoyOCmRwp3sVYbgJ4vlZX8j6thT/y99ppw1Didf0VUHflnqDCfR
	7Qq2QX+qBXTZZR96rs5miyjo9wioyai6RBJOF94oXg23a2xAMX3wjzpvAvg2PRjGpmKy3nO0gfs
	uvZMboNW2lFZDM6v8Lf0bxqS/cYe3BJKtX7PdhCjMWvWMsTcLgmwEHhEKvQBsP/RWItgpFQX61q
	HH9CwZieqGy6BL3gFapz2uaE3VjxA=
X-Received: by 2002:a05:7022:4595:b0:11b:9386:a38f with SMTP id a92af1059eb24-1278910bd71mr6654901c88.22.1772465807144;
        Mon, 02 Mar 2026 07:36:47 -0800 (PST)
Received: from [127.0.0.1] ([172.184.214.215])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df36asm14273404c88.4.2026.03.02.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:36:46 -0800 (PST)
Message-Id: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 15:36:41 +0000
Subject: [PATCH v3 0/4] for-each-repo: work correctly in a worktree
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
    fastcat@gmail.com,
    Eric Sunshine <sunshine@sunshineco.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

This was reported by Matthew [1] and is a quick fix.

[1]
https://lore.kernel.org/git/CABpCjbY=wpStuhxqRJ5TSNV3A-CmN-g-xZGJOQGSSv3GYhs2fQ@mail.gmail.com/

I also took the liberty of removing the_repository as I wanted to make sure
that wasn't involved here.


Updates in v3
=============

v2 included some important changes that apparently didn't save in my cover
letter. Sorry. The most important one was that the first patch was replaced
with one that tests the command outside of a Git repo so the first patch in
v1 can be caught as a bug.

But v2 also included a bug! The filtering of GIT_CONFIG* environment
variables was incorrect. Further, duplicating this logic from
prepare_other_repo_env() was a new bug waiting to happen.

Here is the new setup:

 * Patch 1 is the same as in v2.
 * A new Patch 2 extracts clear_local_repo_env() from
   prepare_other_repo_env().
 * The old Patch 2 is now Patch 3 with a much simpler implementation that
   calls clear_local_repo_env().
 * Tests are added to check that these config-related environment variables
   are preserved. The NO_REPLACE_OBJECTS case seemed like it would take
   longer than necessary to set up for the value it provides.
 * A fourth patch is added that simplifies the use of argv. It's separate
   because it modifies the original implementation in a way that is a "nice
   to have" but isn't necessary for solving the bug that motivates the
   series.

Thanks, -Stolee

Derrick Stolee (4):
  for-each-repo: test outside of repo context
  run-command: extract clear_local_repo_env helper
  for-each-repo: work correctly in a worktree
  for-each-repo: simplify passing of parameters

 builtin/for-each-repo.c  | 12 +++----
 run-command.c            |  7 ++++-
 run-command.h            |  7 +++++
 t/t0068-for-each-repo.sh | 67 +++++++++++++++++++++++++++++++++-------
 4 files changed, 74 insertions(+), 19 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2056%2Fderrickstolee%2Ffor-each-repo-in-gitdir-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2056/derrickstolee/for-each-repo-in-gitdir-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2056

Range-diff vs v2:

 1:  6e9d4f3029 = 1:  6e9d4f3029 for-each-repo: test outside of repo context
 -:  ---------- > 2:  13d783dbbd run-command: extract clear_local_repo_env helper
 2:  4e3f4aa6cd ! 3:  2a6091095f for-each-repo: work correctly in a worktree
     @@ Commit message
          We need to be careful to unset the local Git environment variables and
          let the child process rediscover them, while also reinstating those
          variables in the parent process afterwards. Update run_command_on_repo()
     -    to store, unset, then reset the non-NULL variables.
     +    to use the new clear_local_repo_env() helper method to erase these
     +    environment variables.
     +
     +    During review of this bug fix, there were several incorrect patches
     +    demonstrating different bad behaviors. Most of these are covered by
     +    tests, when it is not too expensive to set it up. One case that would be
     +    expensive to set up is the GIT_NO_REPLACE_OBJECTS environment variable,
     +    but we trust that using clear_local_repo_env() will be sufficient to
     +    capture these uncovered cases by using the common code for resetting
     +    environment variables.
      
          Reported-by: Matthew Gabeler-Lee <fastcat@gmail.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
     @@ builtin/for-each-repo.c: static const char * const for_each_repo_usage[] = {
       static int run_command_on_repo(const char *path, int argc, const char ** argv)
       {
      -	int i;
     -+	int res;
       	struct child_process child = CHILD_PROCESS_INIT;
     -+	char **envvars;
     -+	size_t envvar_nr = 0;
       	char *abspath = interpolate_path(path, 0);
       
     -+	while (local_repo_env[envvar_nr])
     -+		envvar_nr++;
     -+
     -+	CALLOC_ARRAY(envvars, envvar_nr);
     -+
     -+	for (size_t i = 0; i < envvar_nr; i++) {
     -+		envvars[i] = getenv(local_repo_env[i]);
     -+
     -+		if (envvars[i]) {
     -+			unsetenv(local_repo_env[i]);
     -+			envvars[i] = xstrdup(envvars[i]);
     -+		}
     -+	}
     ++	clear_local_repo_env(&child.env);
      +
       	child.git_cmd = 1;
       	strvec_pushl(&child.args, "-C", abspath, NULL);
       
     --	for (i = 0; i < argc; i++)
     -+	for (int i = 0; i < argc; i++)
     - 		strvec_push(&child.args, argv[i]);
     - 
     - 	free(abspath);
     - 
     --	return run_command(&child);
     -+	res = run_command(&child);
     -+
     -+	for (size_t i = 0; i < envvar_nr; i++) {
     -+		if (envvars[i]) {
     -+			setenv(local_repo_env[i], envvars[i], 1);
     -+			free(envvars[i]);
     -+		}
     -+	}
     -+
     -+	free(envvars);
     -+	return res;
     - }
     - 
     - int cmd_for_each_repo(int argc,
      
       ## t/t0068-for-each-repo.sh ##
      @@ t/t0068-for-each-repo.sh: TEST_NO_CREATE_REPO=1
     + . ./test-lib.sh
     + 
       test_expect_success 'run based on configured value' '
     - 	git init one &&
     - 	git init two &&
     +-	git init one &&
     +-	git init two &&
      -	git init three &&
     +-	git init ~/four &&
     ++	git init --initial-branch=one one &&
     ++	git init --initial-branch=two two &&
      +	git -C two worktree add --orphan ../three &&
     - 	git init ~/four &&
     ++	git -C three checkout -b three &&
     ++	git init --initial-branch=four ~/four &&
     ++
       	git -C two commit --allow-empty -m "DID NOT RUN" &&
       	git config --global run.key "$TRASH_DIRECTORY/one" &&
     + 	git config --global --add run.key "$TRASH_DIRECTORY/three" &&
      @@ t/t0068-for-each-repo.sh: test_expect_success 'run based on configured value' '
       	git -C three log -1 --pretty=format:%s >message &&
       	grep again message &&
     @@ t/t0068-for-each-repo.sh: test_expect_success 'run based on configured value' '
      -	grep again message
      +	grep again message &&
      +
     -+	git -C three for-each-repo --config=run.key -- commit --allow-empty -m "ran from worktree" &&
     ++	git -C three for-each-repo --config=run.key -- \
     ++		commit --allow-empty -m "ran from worktree" &&
      +	git -C one log -1 --pretty=format:%s >message &&
     -+	grep worktree message &&
     ++	test_grep "ran from worktree" message &&
      +	git -C two log -1 --pretty=format:%s >message &&
     -+	! grep worktree message &&
     ++	test_grep ! "ran from worktree" message &&
      +	git -C three log -1 --pretty=format:%s >message &&
     -+	grep worktree message &&
     ++	test_grep "ran from worktree" message &&
      +	git -C ~/four log -1 --pretty=format:%s >message &&
     -+	grep worktree message
     ++	test_grep "ran from worktree" message &&
     ++
     ++	# Test running with config values set by environment
     ++	cat >expect <<-EOF &&
     ++	ran from worktree (HEAD -> refs/heads/one)
     ++	ran from worktree (HEAD -> refs/heads/three)
     ++	ran from worktree (HEAD -> refs/heads/four)
     ++	EOF
     ++
     ++	GIT_CONFIG_PARAMETERS="${SQ}log.decorate=full${SQ}" \
     ++		git -C three for-each-repo --config=run.key -- log --format="%s%d" -1 >out &&
     ++	test_cmp expect out &&
     ++
     ++	cat >test-config <<-EOF &&
     ++	[run]
     ++		key = $(pwd)/one
     ++		key = $(pwd)/three
     ++		key = $(pwd)/four
     ++
     ++	[log]
     ++		decorate = full
     ++	EOF
     ++
     ++	GIT_CONFIG_GLOBAL="$(pwd)/test-config" \
     ++		git -C three for-each-repo --config=run.key -- log --format="%s%d" -1 >out &&
     ++	test_cmp expect out
       '
       
       test_expect_success 'do nothing on empty config' '
 -:  ---------- > 4:  f6582e9402 for-each-repo: simplify passing of parameters

-- 
gitgitgadget
