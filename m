Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF91D54FE
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654109; cv=none; b=smI7EDH9tVuFAtwgJJ8/D693N0s4S4tqHvakbhxjtij4gvuXvAhXIiRgjX97gf5wjc3dMig3StZy4MXe62/o/VQxVvkt7LGbLYOuzc8Ez5rMfeVIA+z7A7ee65nCEr+keuEpCD0hPyvjTSb/FI68CIF+gZ5oC3nNHYPHtIZndmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654109; c=relaxed/simple;
	bh=aLFXpzT/6P/FJAhYmlW6PDIIMFhouhBcTLGc0mR7rY4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y/mwOSlVEVSaNgV9fwgoxnA4OB6Bl8ex0NgcZNHjRtqtgNds8sxyScSqmFNixMdP3pPzsQ2Ck+icj+sRZImxtwDMbAjMoXeZMzKBQZ87EnB+q6ecxhBOwZRPqeVAA3Er3XRqUXgrCJtgN+yfCPD9PT4n3efPMTI3EpOpuuaWB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/BABe7l; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/BABe7l"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso3012894a12.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725654104; x=1726258904; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPVTKUyu48TmGq4ii3w1w0bTVeDPTa/SwjAK2pMPSMs=;
        b=F/BABe7lxcAjMHFItpXPev2QZAG1qMge7G5x+JRlaN7CIGLHY/USMCb1D7KZn5MaWo
         5oR3k2luX8kClwSXIgU4NXbr8z2D14ZeGJsa7HVc5UPmczb0RTTho8DNAZqwzg0DVTow
         q1PjbSCT9wO1deGwEV+afOy9pK1C9BVDN47eF/Ob0CCkNF29p/i3HvZN9sm6TXKAM9B+
         YN41edBoAh3WRzl6VcuGWBRVDzDu0BRDTs+wh1u5QiYOdtPAe++/eFB5HHAYypKmlAGU
         iTmnkLEjrUqwuG4gxEFPrMW1AuemDQm31dX3XG3A+KNJAh8c9rsxZHpkJGsdWuiXy0wS
         VzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654104; x=1726258904;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPVTKUyu48TmGq4ii3w1w0bTVeDPTa/SwjAK2pMPSMs=;
        b=ulvRDb200Me+d0MBrdiNRXjNOHoLj1gs0NM1F+MF47Xt/HLiDskRlNkvARnG7iwTg8
         q30pSDd6nOa6xh2uO1cP5fYg230KOpAvJXtruX2EXviVnMSGAXSjSeGUQpqTK3VD8/rF
         +T5xBM5YT7ATSigDwo/W0HmzxyowywoCLV5zjIfasnZlfR4TIVygw0+COzMUDcFT+eeD
         stwDB4mYVy+5LekjxtvvaJ+MAAzIhkrZdL9gQjrXpM39KmQjqS+Fui2q+k0DL2mFhb0b
         MXqekTJrx5fMLV8jR9r01UFw0fR6LxyZMvsduJKiKRoE9czBZg+SWmOMyKX0CpXPUeiv
         tUNg==
X-Gm-Message-State: AOJu0YxghHc5q8FkO0RRGf4M14sVj6LXfzlMgOym/nCYRz4asSQEj+uO
	f/OIiCxvAn7o+O/9lQp7s581Ql378OBgYOVsZ5H7InRb4Dt2jC9g/RLzRw==
X-Google-Smtp-Source: AGHT+IFSnPWhcCBGskwkVqiRAvFIDSN+UmB70a/aNELjhlaGDoAaru+sbXvECYcpajcrNTwlyC9adw==
X-Received: by 2002:a17:906:4fc3:b0:a86:789b:71fe with SMTP id a640c23a62f3a-a8a88858b14mr342586766b.48.1725654103521;
        Fri, 06 Sep 2024 13:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d164sm314505766b.111.2024.09.06.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:21:42 -0700 (PDT)
Message-Id: <pull.1780.v2.git.1725654102035.gitgitgadget@gmail.com>
In-Reply-To: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
References: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Sep 2024 20:21:41 +0000
Subject: [PATCH v2] scalar: add --no-tags option to 'scalar clone'
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
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Some large repositories use tags to track a huge list of release
versions. While this choice is costly on the ref advertisement, it is
further wasteful for clients who do not need those tags. Allow clients
to optionally skip the tag advertisement.

This behavior is similar to that of 'git clone --no-tags' implemented in
0dab2468ee5 (clone: add a --no-tags option to clone without tags,
2017-04-26), including the modification of the remote.origin.tagOpt
config value to include "--no-tags".

One thing that is opposite of the 'git clone' implementation is that
this allows '--tags' as an assumed option, which can be naturally negated
with '--no-tags'. The clone command does not accept '--tags' but allows
"--no-no-tags" as the negation of its '--no-tags' option.

While testing this option, combine the test with the previously untested
'--no-src' option introduced in 4527db8ff8c (scalar: add --[no-]src
option, 2023-08-28).

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    scalar: add --no-tags option
    
    The need for this was discovered due to the release behavior of an
    internal monorepo. The use of Azure DevOps' limited refs feature does
    not apply to tags, so the number of tags was causing some pain for
    users.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1780%2Fderrickstolee%2Fscalar-no-tags-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1780/derrickstolee/scalar-no-tags-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1780

Range-diff vs v1:

 1:  f0e8217869a ! 1:  3378b4f728a scalar: add --no-tags option
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    scalar: add --no-tags option
     +    scalar: add --no-tags option to 'scalar clone'
      
          Some large repositories use tags to track a huge list of release
     -    versions. While this is choice is costly on the ref advertisement, it is
     +    versions. While this choice is costly on the ref advertisement, it is
          further wasteful for clients who do not need those tags. Allow clients
          to optionally skip the tag advertisement.
      
     @@ Documentation/scalar.txt: cloning. If the HEAD at the remote did not point at an
      +	By default, `scalar clone` will fetch the tag objects advertised by
      +	the remote and future `git fetch` commands will do the same. Use
      +	`--no-tags` to avoid fetching tags in `scalar clone` and to configure
     -+	the repository to avoid fetching tags in the future.
     ++	the repository to avoid fetching tags in the future. To fetch tags after
     ++	cloning with `--no-tags`, run `git fetch --tags`.
      +
       --[no-]full-clone::
       	A sparse-checkout is initialized by default. This behavior can be
     @@ scalar.c: static int cmd_clone(int argc, const char **argv)
       				show_progress ? "--progress" : "--no-progress",
      -				"origin", NULL))) {
      +				"origin",
     -+				(!tags ? "--no-tags" : NULL),
     ++				(tags ? NULL : "--no-tags"),
      +				NULL))) {
       		warning(_("partial clone failed; attempting full clone"));
       


 Documentation/scalar.txt |  7 +++++++
 scalar.c                 | 15 ++++++++++++---
 t/t9210-scalar.sh        | 18 ++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
index 361f51a6473..7e4259c6743 100644
--- a/Documentation/scalar.txt
+++ b/Documentation/scalar.txt
@@ -86,6 +86,13 @@ cloning. If the HEAD at the remote did not point at any branch when
 	`<entlistment>/src` directory. Use `--no-src` to place the cloned
 	repository directly in the `<enlistment>` directory.
 
+--[no-]tags::
+	By default, `scalar clone` will fetch the tag objects advertised by
+	the remote and future `git fetch` commands will do the same. Use
+	`--no-tags` to avoid fetching tags in `scalar clone` and to configure
+	the repository to avoid fetching tags in the future. To fetch tags after
+	cloning with `--no-tags`, run `git fetch --tags`.
+
 --[no-]full-clone::
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
diff --git a/scalar.c b/scalar.c
index 6166a8dd4c8..09560aeab54 100644
--- a/scalar.c
+++ b/scalar.c
@@ -410,7 +410,7 @@ static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
 	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
-	int src = 1;
+	int src = 1, tags = 1;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -421,11 +421,13 @@ static int cmd_clone(int argc, const char **argv)
 			    "be checked out")),
 		OPT_BOOL(0, "src", &src,
 			 N_("create repository within 'src' directory")),
+		OPT_BOOL(0, "tags", &tags,
+			 N_("specify if tags should be fetched during clone")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
 		N_("scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]\n"
-		   "\t[--[no-]src] <url> [<enlistment>]"),
+		   "\t[--[no-]src] [--[no-]tags] <url> [<enlistment>]"),
 		NULL
 	};
 	const char *url;
@@ -504,6 +506,11 @@ static int cmd_clone(int argc, const char **argv)
 		goto cleanup;
 	}
 
+	if (!tags && set_config("remote.origin.tagOpt=--no-tags")) {
+		res = error(_("could not disable tags in '%s'"), dir);
+		goto cleanup;
+	}
+
 	if (!full_clone &&
 	    (res = run_git("sparse-checkout", "init", "--cone", NULL)))
 		goto cleanup;
@@ -513,7 +520,9 @@ static int cmd_clone(int argc, const char **argv)
 
 	if ((res = run_git("fetch", "--quiet",
 				show_progress ? "--progress" : "--no-progress",
-				"origin", NULL))) {
+				"origin",
+				(tags ? NULL : "--no-tags"),
+				NULL))) {
 		warning(_("partial clone failed; attempting full clone"));
 
 		if (set_config("remote.origin.promisor") ||
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index a41b4fcc085..e8613990e13 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -169,6 +169,24 @@ test_expect_success 'scalar clone' '
 	)
 '
 
+test_expect_success 'scalar clone --no-... opts' '
+	# Note: redirect stderr always to avoid having a verbose test
+	# run result in a difference in the --[no-]progress option.
+	GIT_TRACE2_EVENT="$(pwd)/no-opt-trace" scalar clone \
+		--no-tags --no-src \
+		"file://$(pwd)" no-opts --single-branch 2>/dev/null &&
+
+	test_subcommand git fetch --quiet --no-progress \
+			origin --no-tags <no-opt-trace &&
+	(
+		cd no-opts &&
+
+		test_cmp_config --no-tags remote.origin.tagopt &&
+		git for-each-ref --format="%(refname)" refs/tags/ >tags &&
+		test_line_count = 0 tags
+	)
+'
+
 test_expect_success 'scalar reconfigure' '
 	git init one/src &&
 	scalar register one &&

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
