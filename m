Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A233EAF9
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968930; cv=none; b=n6934mo+o91aZe2UA3cw3xnj0uUI7qEDv6aq8wdyhmUD2ehkkKRCw2gb6tZeadp3rmg0K6MXjCGD3pRZb5PDbvVoh/yumJ2tFfxrZvdSpkLOTxf61rh3Y6ecdjsYdZIu93piYSl0eaQYtFm3HCsoELNOfCTKc7b7riJ7LH6wadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968930; c=relaxed/simple;
	bh=3Iz4qjYEvJWnOHQ2fTY+GBxAtUxjsJ4xTpLNZz2Qw1E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i2MnXthSliZY/j0qE7cXAkMGWAztbHrGWRbdAPbOHxMFR7f09+niL5wtkRfO8Shwzev+B647grWMVMccdNMJlP40eRPt+LbYQ4PXe8gibsMhPEf/5wjVE3qXr56KsUJfNq0EyuX1UZnQe3cYrVuDfCrWJE2ssK2F+Yg7hbFRg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC9Kbo5f; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC9Kbo5f"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb40030be5so603358185a.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771968928; x=1772573728; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtnO1S+Uadi0xiWNE9T17Qvzkm5eFy0bYW0AuxRMV/4=;
        b=fC9Kbo5fXMkfChjQlrZdxOcDbfpLY86PQzSWLnJQ8A81AQGlq1zJlMciEwboCrTCu7
         DTizXjdSO0CzVSX2guPQpPAWkZn1Kbw63LNz/JgWTQP0c5Lio6PHeu7HIFK5Nxvm3QCN
         R64fDJJqS7N2Hjp+wFChhI0xBdp1+/CsxqGw08rcT+WltDy+46c3ik8WNGRplBR9V7gZ
         +5ltrFVYP+0MPuWZ3bF+UibDAzZ7nmEFfdKC91BmP8Z6a/svGvyfWLVuYBlbEDhAPYeL
         HNH9zpT0XjojK/aCzY38pNMghDs9XhtgrXHJHnlonZQALv0WwA7GFV0driQK9HC3x5kf
         6pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771968928; x=1772573728;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KtnO1S+Uadi0xiWNE9T17Qvzkm5eFy0bYW0AuxRMV/4=;
        b=m2ON61xsBV1FmdxG8EBLB5upywg+Byxayipz5PK7EC/jfMlD/KLtGb3nxjEyRlMkuS
         1CxkAowj7ydqDey9uiZ+rudXqOVvhfZyRydAZxys7a2dARVcv0zcEiZz1r7D0CNuqSdN
         BSLKEvWupt9Z4iZtB7SxK/LKg7ac/+4SajWMdHwAJrcLY5Ti2nbCUGxEvPiAaq5gxPeb
         9uKxph1wlvgHCev4Cst4h61gD5yybMytWrMgnXhaOLKVsM/Y4V/EcEJAHe/8F+TMKK4O
         MugML///0f0IL9G2sn0k3bvDaFbZEc/TLNdzGf/XwQXFgxqfdTZqArlIN7ONGPBbZROd
         PSKg==
X-Gm-Message-State: AOJu0Yza/0TGQP15tsVm6htWHRh8fqqai0ejpyVm05+/L6tt3dLeYg6J
	TyIk0NHIH+/dLvvDYrjk+ZO7WjqyYuTJtwodwiP7WItIzoHhy1RK9w1J0yXGfQ==
X-Gm-Gg: AZuq6aLrG/ZoJ+6DWNmHXB/3fY2OFL4oc6LhzHvU03f6izGrCi/HZ3ZUnHh1SdnvFcH
	XXHmqYdRdIKC9VJZ/J+mpug0eRtL1pXXFs0he75Fu7L+9PBbjlUrqt/c1hp7kTnYKGUrfjZctzW
	DQjgGTVjuUAMaxtxGKoKo9TFCs9pjSzYt/lMOW6gfIhekA8aON4IpgjbH5GRt0PEVlyf0qGFSj0
	8LG7d+Pjo4CRKqlaLoeDzb48GwO0XIYtOTy+LRYlv1Etnsjukf/fqBUc8g/Iw6ZT0D5spypc7AM
	W5hwQQ5Z1izgdoR3t0yPt7n/OZV8CwUohMO+iIqhmCYyhDW36wCqNxF0WCBczeoDEJi0FoScy9u
	NS8LWkY/Oerv2JDj3FictkpNLdEaw7X0mYKKvH2Tw7hF+dcWntsQb6fJIjNQcOMs1oL1S4wyB4L
	zN1zivGDw9XNF8OILXJFvT/0o=
X-Received: by 2002:a05:620a:bd6:b0:8cb:1d9a:42ac with SMTP id af79cd13be357-8cb8ca6e5eamr1480597885a.51.1771968928097;
        Tue, 24 Feb 2026 13:35:28 -0800 (PST)
Received: from [127.0.0.1] ([20.55.87.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1202e2sm1074119885a.44.2026.02.24.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 13:35:27 -0800 (PST)
Message-Id: <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
	<pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Feb 2026 21:35:24 +0000
Subject: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
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
to store, unset, then reset the non-NULL variables.

Reported-by: Matthew Gabeler-Lee <fastcat@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/for-each-repo.c  | 33 ++++++++++++++++++++++++++++++---
 t/t0068-for-each-repo.sh | 14 ++++++++++++--
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 325a7925f1..3f3e71979c 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
@@ -15,19 +16,45 @@ static const char * const for_each_repo_usage[] = {
 
 static int run_command_on_repo(const char *path, int argc, const char ** argv)
 {
-	int i;
+	int res;
 	struct child_process child = CHILD_PROCESS_INIT;
+	char **envvars;
+	size_t envvar_nr = 0;
 	char *abspath = interpolate_path(path, 0);
 
+	while (local_repo_env[envvar_nr])
+		envvar_nr++;
+
+	CALLOC_ARRAY(envvars, envvar_nr);
+
+	for (size_t i = 0; i < envvar_nr; i++) {
+		envvars[i] = getenv(local_repo_env[i]);
+
+		if (envvars[i]) {
+			unsetenv(local_repo_env[i]);
+			envvars[i] = xstrdup(envvars[i]);
+		}
+	}
+
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "-C", abspath, NULL);
 
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		strvec_push(&child.args, argv[i]);
 
 	free(abspath);
 
-	return run_command(&child);
+	res = run_command(&child);
+
+	for (size_t i = 0; i < envvar_nr; i++) {
+		if (envvars[i]) {
+			setenv(local_repo_env[i], envvars[i], 1);
+			free(envvars[i]);
+		}
+	}
+
+	free(envvars);
+	return res;
 }
 
 int cmd_for_each_repo(int argc,
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 512af34c82..d55557a934 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -10,7 +10,7 @@ TEST_NO_CREATE_REPO=1
 test_expect_success 'run based on configured value' '
 	git init one &&
 	git init two &&
-	git init three &&
+	git -C two worktree add --orphan ../three &&
 	git init ~/four &&
 	git -C two commit --allow-empty -m "DID NOT RUN" &&
 	git config --global run.key "$TRASH_DIRECTORY/one" &&
@@ -35,7 +35,17 @@ test_expect_success 'run based on configured value' '
 	git -C three log -1 --pretty=format:%s >message &&
 	grep again message &&
 	git -C ~/four log -1 --pretty=format:%s >message &&
-	grep again message
+	grep again message &&
+
+	git -C three for-each-repo --config=run.key -- commit --allow-empty -m "ran from worktree" &&
+	git -C one log -1 --pretty=format:%s >message &&
+	grep worktree message &&
+	git -C two log -1 --pretty=format:%s >message &&
+	! grep worktree message &&
+	git -C three log -1 --pretty=format:%s >message &&
+	grep worktree message &&
+	git -C ~/four log -1 --pretty=format:%s >message &&
+	grep worktree message
 '
 
 test_expect_success 'do nothing on empty config' '
-- 
gitgitgadget
