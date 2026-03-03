Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4148C8B5
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559123; cv=none; b=DSE2vVn9ghDaPNRwsdPA2VyskQp0ilwVvhINLGUcAGt3u/lVdbl9EC38J+21xD1Nz+eNAEdijKBV4UIfgwsYI3XeK5RxFVA11U+f6oDOn0TXBTEL1dGRs21vAK35JtIUnovQsrixphLTT6UAZp87FAg85Tn7VU8Ae3w9wkv/7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559123; c=relaxed/simple;
	bh=C9bVlDL9o2vHQvG0mSeueGFTzj9fnnbuNWZrOVZouWk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qufmbv2GIXfiScPCvQEKlKUllRb0gUZOuQT9ZfS8CkRwFvm7M2XfepU3IRbt0lvaj6EcfCjQxJVto8TEEHjcZadUxsplruN4GK/JSWwakL9Xd4q4oXz5mtSL1s3FKh6sqyKDG/AaS3hANlvG10A4YyGr36HmWlplQN2QQPS0wS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvdmo6//; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvdmo6//"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899a9f445cbso74706936d6.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559120; x=1773163920; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+azCGRlnBLZIe7m2fbfbgbJF0lKMAnL59doqZ8+ziE=;
        b=Bvdmo6//oxWJgcxLYgJkWYACV8tYPkUJ6bXG8DlD8Jtc+gRLXrig2GWKnu8YTUdZFD
         K28Y8JDM3EI69wbdGv0eBTpmb570khq9y9pptUtkazemD1OSg/6RIPYiHsigh9L7TMO6
         +YKmy9eOz/dklbXx3n3CoL755MpL7J2eLFaP0ld/ldZ9dtUXMeU9o1lz5LSFGs21fgrs
         pQv81pZCnRnlyNUnbIbeC2jN5lNSaT2+vzEXZaznHqw5/j4cjr7RBEbRlw/CuULo35Je
         4Lze0Q9h4hZpw+3MozqqsTByaj/MwuPSptRV+q4GzaGfwKQKg9QOYYy+vyuLYAqW3jA/
         RdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559120; x=1773163920;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+azCGRlnBLZIe7m2fbfbgbJF0lKMAnL59doqZ8+ziE=;
        b=mB3SAAmWKxhjgYeeyxfUQKXT5wuPG5g5sl0dG2IPQFReIdecAqhw7V7a0dCySyBysL
         vi/p7zFBYzS+IOsDogjr1JgDT0GPRxnBmMyVu0Gz8Zm55nmySumT0ax1CpN3c8Nwk4mL
         DirwFCT2zoXIXUbJSJxIKhmX9Q+JaIhbsRo4vRVeFLeTxUNSDEi9X9be91mr/YXGYB03
         bC+N391mKdLH1YRmTC29QitVp0DjNaXNlgpxhpkZ1JOU0ed7NuLzfklusxwmmlEC6CYU
         w3LS83MWsv3J4LP2LRrD9ovBTXAHc++GHyJbpD8Hd2fGMQmbID2SL73enb2KpjmUmGfl
         SgYQ==
X-Gm-Message-State: AOJu0YwpZ+r0lnnKNC2MgbrwRBpusGSRHu8Cx/dJkzrEgkVeb84JnfiO
	vacnK2/APeCC5NQK+AGH0zyBm2Ylp6mm+DSDI2dV2TGLSHqSML5QKOnPtJPNvw==
X-Gm-Gg: ATEYQzw99+sMwVXbtUJgkBxkbrCGiDupReIPGi3kCgZjoRI8doDQMUr7XJ4grIusNSt
	G9PfUstgU8g+FYi7wxTpP1NvZYmoLMmTi3lRAdUJ2gXhgP3aCAyTveoUbfW0rBcZtKoICOXq9Vo
	IInhCQiGKQYwGWBG6xG5Vbz6pjr4Xl42E9CGGO9uce56B7O2gvGEa+s7IDOflDtpUfdv8ClzhUI
	CLxsvGrQjH6iRQctOb0XiunODIFbQt0iwcMesrrFX8hkpFvaHKPrL2/56eV+nOCqAJbDwMvrtPK
	cRWyTPWwdcm/o0Y4tDEu30BNB9BB+IsfbDL6pGnfXXfJcaD6xjoymj33wuYmiE5Z792H1ORMaUH
	pMWZOFmZOjgaTLd5RJ6+WefO2XGJ0KP9o4Ljj0lAbiuLVNxNBL4WzvtypHuMp1aiU+a3CgPcT8t
	0S9wp5/Qxz0KkKJfhf3Mivhw3Z
X-Received: by 2002:a05:6214:528e:b0:896:f588:b2e5 with SMTP id 6a1803df08f44-899d1e8fe5amr239718726d6.36.1772559120283;
        Tue, 03 Mar 2026 09:32:00 -0800 (PST)
Received: from [127.0.0.1] ([20.161.28.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a04849c78sm40315676d6.10.2026.03.03.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:31:59 -0800 (PST)
Message-Id: <e759b350692360e968a61e2f9744138104e77ba6.1772559114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
References: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
	<pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 17:31:53 +0000
Subject: [PATCH v4 3/4] for-each-repo: work correctly in a worktree
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
to use the new sanitize_repo_env() helper method to erase these
environment variables.

During review of this bug fix, there were several incorrect patches
demonstrating different bad behaviors. Most of these are covered by
tests, when it is not too expensive to set it up. One case that would be
expensive to set up is the GIT_NO_REPLACE_OBJECTS environment variable,
but we trust that using sanitize_repo_env() will be sufficient to
capture these uncovered cases by using the common code for resetting
environment variables.

Reported-by: Matthew Gabeler-Lee <fastcat@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/for-each-repo.c  |  3 +++
 t/t0068-for-each-repo.sh | 48 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 325a7925f1..82727c4aa2 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
@@ -19,6 +20,8 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 	struct child_process child = CHILD_PROCESS_INIT;
 	char *abspath = interpolate_path(path, 0);
 
+	sanitize_repo_env(&child.env);
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

