Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6985298
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947277; cv=none; b=o5DfjxIkA5nLVtYxe4ZaKQMJH4pmOcMWf+hushhtHfogzWSLNupwKzBaF02HosGjtmncGl4HwBnMyNjzVJMa72ZjCNLKwYtN3zVJmY+PyI2GO9XuOU7aDiQ+hqsiGS26gMfUKNVTYAuSNfvZ0mQWtXjJyQMUzyLJSy7ZFr/Y5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947277; c=relaxed/simple;
	bh=DbbXB4zEaszazM4bkLylTQ+K8t7C6fNK8vE/z9aKkUQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GzcF8SUJmS9Zt/2Cwtk6cofBdY1sL2uIzuCkGwPvhXn653a7eSB64Lt4IDOfOtsskhgu34cBnv25hmOHL44sq1U8nACd1LOO1TIuSoc4VwYI/qzcnE5T/iSW8FD5vhqitlke4J8hJaEIt5VQSggK5BGiV4CIzASSiMwvKf+JzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn55PaJR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn55PaJR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-356c4e926a3so2702969f8f.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719947273; x=1720552073; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/6Vnk/p8wybyE9A664a4l2znMy22d7ABH+o0EWPwsY=;
        b=Cn55PaJRBeD36isowa509f1OKaZF+VE19X2V/YrXBm9KvFGXiD250Le/WlSErvBxYy
         1TNv5YFt40IMsyOquYYvMFv0fn+E0QdH7AzEbBbxJg5qgUegDeGg+YSMsmeCsSAhYxwH
         1FgQe5f0++jj5dtQRYnuRLPIQllBQXKVEle9xFySbkGoKS/euGJRl3UL7DIcWBloUOD3
         KqXC+dTBHt9IDgpRMSBUNgP61jEFg+aFBKRcRN2ub/qvJP8iB7m75zfcmNndkrw3guvv
         TBbgaqtCFATpcpowhmAA309V6bB6j583dVZUJhliLJ9fFOgJkEOCCbVVs62WfuX4cWmt
         C2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719947273; x=1720552073;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/6Vnk/p8wybyE9A664a4l2znMy22d7ABH+o0EWPwsY=;
        b=WFDCaQGv98vWoPmldo2yucoBavvf9pEgcCJAa18WsWF0A4UlZ2vnZDcN3KHk9HbEwd
         JNNxnq+RgtWmkkMkbsBXilViZp8ILx8Dk2nwTNGNnwiMxiAXcqXYRf3CCgOeId5ME+KX
         2SL96kFen1dJvsksQf93ghTkIdXxgAooVov/Jmh8g//ok51v8luC7eXBzFObNLj+v7k+
         wOIDP+jTgJtsurIIUCX9uYKrR7wz9ftEeHRHM3cxn/2L8xxOhLk7Nj/exUw+4gEMteIM
         ahex7v6PRTaBI6iPjG6pD6yeQUF1VjZe9rAJHGraswD0VSAJS3Wz3ZeC1nJqk0AjzQ9r
         og6w==
X-Gm-Message-State: AOJu0YxKfXx3t9cCPcRLTqZmocuAbT4Fs8FM5jPGhnYna8Wu31phQ9WF
	USlOQUkP2WjE7GzkFWDsfnvasPlI8uRRR1hv4aeyZNFjUOZcZLLdNTvDAA==
X-Google-Smtp-Source: AGHT+IF39ZeBv8SZO/5oHfmw+I6llSeurUNYBIUA5hZreV+Mdeo++tLOXnPZf9K63SJjj+cs1NdfNg==
X-Received: by 2002:a05:6000:400c:b0:365:980c:d281 with SMTP id ffacd0b85a97d-367757248e5mr6926251f8f.45.1719947273113;
        Tue, 02 Jul 2024 12:07:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103366sm13921967f8f.102.2024.07.02.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:07:52 -0700 (PDT)
Message-Id: <3e57c2eacfcd604510404481f366cf3755260c2c.1719947271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com>
References: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com>
From: "Bruce Perry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jul 2024 19:07:49 +0000
Subject: [PATCH 1/2] clone: shallow-submodules should be single-branch by
 default
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
Cc: Stefan Beller <stefanbeller@gmail.com>,
    Emily Shaffer <emilyshaffer@google.com>,
    Bruce Perry <bruce.a.perry@gmail.com>,
    Bruce Perry <bruce.perry@nrel.gov>

From: Bruce Perry <bruce.perry@nrel.gov>

Recursive cloning with with the `--shallow-submodules` command
line option (or the `shallow = true` option in .gitmodules) and
no specification of `--[no-]single-branch` does result in a
shallow submodule clone, but obtains all available branches.
This behavior is unexpected because in other circumstances
shallow clones imply single-branch clones. It also violates the
documented behavior: the documentation states that performing a
clone with `--recurse-submodules` is equivalent to doing a
nonrecursive clone then immediately running `git submodule
update --init --recursive`. However, with the `shallow = true`
option in .gitmodules, the former results in a shallow but not
single-branch clone of the submodules, while the latter results
submodules that are both shallow and single-branch.

Modify the logic for git clone with `--recurse-submodules` so
that if no option is specified for `--[no-]single-branch`, then
no `--[no-]single-branch` option is passed to the internal call
to `git submodule update --init --recursive`. As a result, the
default will be used, which is to make shallow clones also
single-branch and non-shallow clones multi-branch.

Modify the tests for shallow-submodules so that the submodule
has multiple branches and the expected behavior in terms of
obtaining branches is validated: shallow submodules must also
be single-branch, while non-shallow submodules must obtain
both branches.

Make a slight clarification to the documentation regarding
the above behavior, although primarily the effect is to bring
the behavior in line with the present documentation.

Signed-off-by: Bruce Perry <bruce.perry@nrel.gov>
---
 Documentation/git-clone.txt         |  3 +++
 Documentation/gitmodules.txt        |  4 ++--
 builtin/clone.c                     |  6 +++--
 t/t5614-clone-submodules-shallow.sh | 36 ++++++++++++++++++++---------
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5de18de2ab8..69248421390 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -297,6 +297,9 @@ or `--mirror` is given)
 
 `--`[`no-`]`shallow-submodules`::
 	All submodules which are cloned will be shallow with a depth of 1.
+	Also implies `--single-branch` for the submodule clones
+	unless `--no-single-branch` is passed, in which case histories near
+	the tips of all branches of the cloned submodules are fetched.
 
 `--`[`no-`]`remote-submodules`::
 	All submodules which are cloned will use the status of the submodule's
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index d9bec8b1875..c8160cd1df7 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -95,8 +95,8 @@ affected by this setting.
 
 submodule.<name>.shallow::
 	When set to true, a clone of this submodule will be performed as a
-	shallow clone (with a history depth of 1) unless the user explicitly
-	asks for a non-shallow clone.
+	shallow clone (single branch with a history depth of 1) unless the
+	user explicitly asks for a non-shallow clone.
 
 NOTES
 -----
diff --git a/builtin/clone.c b/builtin/clone.c
index b28f88eb43d..50ccce8902d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -58,6 +58,7 @@ static const char * const builtin_clone_usage[] = {
 };
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
+static int option_single_branch_submodules;
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
@@ -816,8 +817,8 @@ static int checkout(int submodule_progress, int filter_submodules)
 			strvec_pushf(&cmd.args, "--filter=%s",
 				     expand_list_objects_filter_spec(&filter_options));
 
-		if (option_single_branch >= 0)
-			strvec_push(&cmd.args, option_single_branch ?
+		if (option_single_branch_submodules >= 0)
+			strvec_push(&cmd.args, option_single_branch_submodules ?
 					       "--single-branch" :
 					       "--no-single-branch");
 
@@ -997,6 +998,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (option_depth || option_since || option_not.nr)
 		deepen = 1;
+	option_single_branch_submodules = option_single_branch;
 	if (option_single_branch == -1)
 		option_single_branch = deepen ? 1 : 0;
 
diff --git a/t/t5614-clone-submodules-shallow.sh b/t/t5614-clone-submodules-shallow.sh
index c2a2bb453ee..b23c7d085aa 100755
--- a/t/t5614-clone-submodules-shallow.sh
+++ b/t/t5614-clone-submodules-shallow.sh
@@ -14,10 +14,14 @@ test_expect_success 'setup' '
 	mkdir sub &&
 	(
 		cd sub &&
-		git init &&
+		git init -b main &&
 		test_commit subcommit1 &&
 		test_commit subcommit2 &&
-		test_commit subcommit3
+		test_commit subcommit3 &&
+		git checkout -b branch &&
+		test_commit branchcommit1 &&
+		test_commit branchcommit2 &&
+		git checkout main
 	) &&
 	git submodule add "file://$pwd/sub" sub &&
 	git commit -m "add submodule"
@@ -30,16 +34,18 @@ test_expect_success 'nonshallow clone implies nonshallow submodule' '
 	git -C super_clone log --oneline >lines &&
 	test_line_count = 3 lines &&
 	git -C super_clone/sub log --oneline >lines &&
-	test_line_count = 3 lines
+	test_line_count = 3 lines &&
+	git -C super_clone/sub log --oneline --all >lines &&
+	test_line_count = 5 lines
 '
 
 test_expect_success 'shallow clone with shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	test_config_global protocol.file.allow always &&
 	git clone --recurse-submodules --depth 2 --shallow-submodules "file://$pwd/." super_clone &&
-	git -C super_clone log --oneline >lines &&
+	git -C super_clone log --oneline --all >lines &&
 	test_line_count = 2 lines &&
-	git -C super_clone/sub log --oneline >lines &&
+	git -C super_clone/sub log --oneline --all >lines &&
 	test_line_count = 1 lines
 '
 
@@ -50,7 +56,9 @@ test_expect_success 'shallow clone does not imply shallow submodule' '
 	git -C super_clone log --oneline >lines &&
 	test_line_count = 2 lines &&
 	git -C super_clone/sub log --oneline >lines &&
-	test_line_count = 3 lines
+	test_line_count = 3 lines  &&
+	git -C super_clone/sub log --oneline --all >lines &&
+	test_line_count = 5 lines
 '
 
 test_expect_success 'shallow clone with non shallow submodule' '
@@ -60,7 +68,9 @@ test_expect_success 'shallow clone with non shallow submodule' '
 	git -C super_clone log --oneline >lines &&
 	test_line_count = 2 lines &&
 	git -C super_clone/sub log --oneline >lines &&
-	test_line_count = 3 lines
+	test_line_count = 3 lines  &&
+	git -C super_clone/sub log --oneline --all >lines &&
+	test_line_count = 5 lines
 '
 
 test_expect_success 'non shallow clone with shallow submodule' '
@@ -69,7 +79,7 @@ test_expect_success 'non shallow clone with shallow submodule' '
 	git clone --recurse-submodules --no-local --shallow-submodules "file://$pwd/." super_clone &&
 	git -C super_clone log --oneline >lines &&
 	test_line_count = 3 lines &&
-	git -C super_clone/sub log --oneline >lines &&
+	git -C super_clone/sub log --oneline --all >lines &&
 	test_line_count = 1 lines
 '
 
@@ -87,7 +97,7 @@ test_expect_success 'clone follows shallow recommendation' '
 	) &&
 	(
 		cd super_clone/sub &&
-		git log --oneline >lines &&
+		git log --oneline --all >lines &&
 		test_line_count = 1 lines
 	)
 '
@@ -105,7 +115,9 @@ test_expect_success 'get unshallow recommended shallow submodule' '
 	(
 		cd super_clone/sub &&
 		git log --oneline >lines &&
-		test_line_count = 3 lines
+		test_line_count = 3 lines &&
+		git log --oneline --all >lines &&
+		test_line_count = 5 lines
 	)
 '
 
@@ -124,7 +136,9 @@ test_expect_success 'clone follows non shallow recommendation' '
 	(
 		cd super_clone/sub &&
 		git log --oneline >lines &&
-		test_line_count = 3 lines
+		test_line_count = 3 lines &&
+		git log --oneline --all >lines &&
+		test_line_count = 5 lines
 	)
 '
 
-- 
gitgitgadget

