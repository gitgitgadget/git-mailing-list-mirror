Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD941163D
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465815; cv=none; b=EV/2rLOb4XPv4hinWFICC9phqMGPf5pPYSYc76Zad+0fcw/EX6zGhTUIuOCe1Un19F9z/ACGKXd2MXVMHf8dCLDhFA/DmZ2RMxblBUC8EPBtBi3sKhYit82t3YjO/gnyzEKM+q02lu07rQ1dWArRgx9FpUgzY8fnuflH9ethk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465815; c=relaxed/simple;
	bh=KcOOjoyI4pWtx6i+n3VoXyAiS9yuIE4Fwvss+tPOkJM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CoLq+Q+wqsdfBnO/Ed+COY8N+EDoPlu4uO+NqwXdK64ePllfEG+zYx8ae24Kvy1cVplfvGYnLFUqewdPck3gA3QZwx9IknzmzU/gvwQy+6HS3rCfs4L1VkhZuW4utCoILjjVnOJZWCKAPHImtBX4bbX84JS1t/M8n/eVLjkHW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqU0qctx; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqU0qctx"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12732e6a123so5993178c88.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772465812; x=1773070612; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg8D9tLsRNCrAVW7MgAm5L0D2f7vjHMJgt0myOKQB/0=;
        b=mqU0qctxvjPV8wHddnaevcO+jLWD4vwDdvs8r2ogbHRS13DD/5QLct6fvomLnb43/o
         TFabe+//XmI3NIehbKkoVi4HP9YMSrJzkxpCll37BAa4Szbz//h5OhIORmoqxD1KUfGa
         3YxO/KENyvRf7a/9c3ynMzIGyB4G041viTWJYiiJJBlFkpVXz542Pim+76DtgHUhPXPz
         Bmv1RKEcOU/42e5USI3iH29AwRIlobB54OF70cjMHd9D98EPMZs6R8i+WsdhkS2KanQD
         EeF1uQBOXQuMWRF7KZk6WTQg6Nm+mAVNujXDcIFftISB/9RM0cLvuYqutDidlQGLc0HS
         aHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465812; x=1773070612;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jg8D9tLsRNCrAVW7MgAm5L0D2f7vjHMJgt0myOKQB/0=;
        b=PlQw46X+8l/0L9kM+IGIOGESqjVKZBk+6ZhpVsGIEnJgZ5mQh3lZuPP8YuRMpGalvY
         GDYapZyqDAp2CNIiH/O7UOHL60MaFfEK3D5+7Iz1tZ+78HyVuMH9977keKqHst+1s2JO
         QwmrHRHASE2MYeNnUzd32+U6j0R5mJelGo3uYRtlkvt61UEJs4CnT8cNQ+sN3M/t6v9F
         5xVO9Hm9mW6D3RmaM9D7IVhqltndWklLYkP7bngvkp3BvyjszDpFlzsytefNvOpdaXSj
         OQfjb0/7eZ+zwTZX5s9m5GvrJwBCLGTLqyr/ZKDal5/3O2QRU6EL3RBmiO6Nu5pOVf4l
         nBNw==
X-Gm-Message-State: AOJu0Yw46Z4IudIUcwYicXZ16LHGqIg4jQzSEfvDJUfWiKbW/xxYZpZA
	SJEIKZZMDYwlczIZVOT7a7lW4yvj2tBZa3nz1H/7zH1gjEX9edaUVK8lRhfmww==
X-Gm-Gg: ATEYQzxrnuZ1ldLXwA/r0HQ/5acHsLT3rDaWq0UJXgsr17GaHoNZedk09KT3vrMm7s1
	5X/UX7H43A+W16Iw/lW8Hovk192408GIxSBxa5kSsXwneZWTNCjxEHTZV5YRYB+2okYS/l/52UH
	HA56lEVlMqZvXZs/N+aJgn4Q1Bu2N3tqtsemVo4gKcywcDsQxZXjZr+iqQUMPN3KqBUleRCWQbs
	YnsV+c6427D3NPyGb5OD26Ihq00Ex6jaG/8ud+6yHWKpAjU6jvDDKIohFw/x5XeH9Hnp1C7Cb5J
	KTVIdENniOSvrL1eOyTuArlLJ+c10mBlKVFfUUFZdj3QBevKJF91nzm9vr5VTAa3I4eSCTxpbMY
	BJF/a81hdOETMtGErLda2fPX3lWc98U8XniLsj9McGKGrEDTvMWkjtJHMG30N4VbsUFs9LuqYAy
	OmRufUdczkC2J3IvvxX/F44Vw60S5/3SLS0dCisg==
X-Received: by 2002:a05:7022:48e:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-1278fd45411mr6011363c88.27.1772465812194;
        Mon, 02 Mar 2026 07:36:52 -0800 (PST)
Received: from [127.0.0.1] ([172.184.214.215])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49c1sm19042661c88.1.2026.03.02.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:36:51 -0800 (PST)
Message-Id: <2a6091095f120426fed554a08871f2b4dcd15282.1772465805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 15:36:44 +0000
Subject: [PATCH v3 3/4] for-each-repo: work correctly in a worktree
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When run in a worktree, the GIT_DIR directory is set in a different way
than in a typical repository. Show this by updating t0068 to include a
worktree and add a test that runs from that worktree. This requires
moving the repo.key config into a global config instead of the base test
repository's local config (demonstrating that it worked with
non-worktree Git repositories).

We need to be careful to unset the local Git environment variables and
let the child process rediscover them, while also reinstating those
variables in the parent process afterwards. Update run_command_on_repo()
to use the new clear_local_repo_env() helper method to erase these
environment variables.

During review of this bug fix, there were several incorrect patches
demonstrating different bad behaviors. Most of these are covered by
tests, when it is not too expensive to set it up. One case that would be
expensive to set up is the GIT_NO_REPLACE_OBJECTS environment variable,
but we trust that using clear_local_repo_env() will be sufficient to
capture these uncovered cases by using the common code for resetting
environment variables.

Reported-by: Matthew Gabeler-Lee <fastcat@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/for-each-repo.c  |  4 +++-
 t/t0068-for-each-repo.sh | 48 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 325a7925f1..8bbdc33128 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
@@ -15,10 +16,11 @@ static const char * const for_each_repo_usage[] = {
 
 static int run_command_on_repo(const char *path, int argc, const char ** argv)
 {
-	int i;
 	struct child_process child = CHILD_PROCESS_INIT;
 	char *abspath = interpolate_path(path, 0);
 
+	clear_local_repo_env(&child.env);
+
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "-C", abspath, NULL);
 
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 512af34c82..80b163ea99 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -8,10 +8,12 @@ TEST_NO_CREATE_REPO=1
 . ./test-lib.sh
 
 test_expect_success 'run based on configured value' '
-	git init one &&
-	git init two &&
-	git init three &&
-	git init ~/four &&
+	git init --initial-branch=one one &&
+	git init --initial-branch=two two &&
+	git -C two worktree add --orphan ../three &&
+	git -C three checkout -b three &&
+	git init --initial-branch=four ~/four &&
+
 	git -C two commit --allow-empty -m "DID NOT RUN" &&
 	git config --global run.key "$TRASH_DIRECTORY/one" &&
 	git config --global --add run.key "$TRASH_DIRECTORY/three" &&
@@ -35,7 +37,43 @@ test_expect_success 'run based on configured value' '
 	git -C three log -1 --pretty=format:%s >message &&
 	grep again message &&
 	git -C ~/four log -1 --pretty=format:%s >message &&
-	grep again message
+	grep again message &&
+
+	git -C three for-each-repo --config=run.key -- \
+		commit --allow-empty -m "ran from worktree" &&
+	git -C one log -1 --pretty=format:%s >message &&
+	test_grep "ran from worktree" message &&
+	git -C two log -1 --pretty=format:%s >message &&
+	test_grep ! "ran from worktree" message &&
+	git -C three log -1 --pretty=format:%s >message &&
+	test_grep "ran from worktree" message &&
+	git -C ~/four log -1 --pretty=format:%s >message &&
+	test_grep "ran from worktree" message &&
+
+	# Test running with config values set by environment
+	cat >expect <<-EOF &&
+	ran from worktree (HEAD -> refs/heads/one)
+	ran from worktree (HEAD -> refs/heads/three)
+	ran from worktree (HEAD -> refs/heads/four)
+	EOF
+
+	GIT_CONFIG_PARAMETERS="${SQ}log.decorate=full${SQ}" \
+		git -C three for-each-repo --config=run.key -- log --format="%s%d" -1 >out &&
+	test_cmp expect out &&
+
+	cat >test-config <<-EOF &&
+	[run]
+		key = $(pwd)/one
+		key = $(pwd)/three
+		key = $(pwd)/four
+
+	[log]
+		decorate = full
+	EOF
+
+	GIT_CONFIG_GLOBAL="$(pwd)/test-config" \
+		git -C three for-each-repo --config=run.key -- log --format="%s%d" -1 >out &&
+	test_cmp expect out
 '
 
 test_expect_success 'do nothing on empty config' '
-- 
gitgitgadget

