Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED9C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 06:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbhLJGZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 01:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbhLJGZs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 01:25:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D4AC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 22:22:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q3so13231927wru.5
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 22:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AaMFAGuHyGmRJkNO/12RO83mwTwL2xBcBbb2UHD9ays=;
        b=Ww9PMQ8ucyX4nOW1ODt6h4Y7FFO2xKrfemxtYSrVkGfGytXsPMLvgCAQ4ZniK2yzmq
         d7QhFUFYyjqXVb/+AbPiq+zXF22RQQJwqSJuBgIFRyZWAxqmswkzXvQADvmOMoRoC60N
         4S0mWD8LUcqZhkf7SjsZ0uv8aBBB1gOKpiK5e/TS+SZV8NV2od2bwZSK2nQZRHpPI0Gj
         J8qvKC2S3thIwcdRZ/smHF+nHA5BXXgQqgPW2Zqc6xXzw4QIsu6jOKsIRhjWyILqWobv
         XXGpa7oIhCTm8uxge/et9PdwmzGw1v4K/NmxQRrp59egAPe8MfX643d3D3BIzAiqqYcG
         B7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AaMFAGuHyGmRJkNO/12RO83mwTwL2xBcBbb2UHD9ays=;
        b=6IWDfQJgsMdQ3UbTrG7lm4/90QuTaszPz+M15Nzeokjo9hhwxfGUCYNbivhEBTRKua
         BzJTU/Sf6afQKrNVbfmjsPqse7ZoZuh31dIqEUO2zBpNdodOIFIg2TdGsNztVqthDlMy
         TfoPZ1Jrskrz4Hf2eebf40rpV5reTo8c2LADn4pu0IiD8iuU3MtpO7GCUsMH2Z2o/sG8
         biO1V1lHDYl7V0MHkTbH6asnkz7TVwOTqJG9TAF5qli6fRDMxYbGgUtoPPuGBoPRAN5p
         Tu3BNtNINpHyZJxpbe5sS+IEZHayOt3eU98def+0+rdwYU7/OFDth38qXkzvTHYLBGuf
         7IaQ==
X-Gm-Message-State: AOAM533fvLc2+v+6vDywIOARfOgTXDJbTAIKo//TlW9UI+VsCy8xyl7W
        UXT0hubvPM+zDPUqSgeNojHhVEAPnTg=
X-Google-Smtp-Source: ABdhPJxL6ck4Lxnyn49CijoxH+5MN2+cePzgteWYZ0ueZ2xK3xee1yzZf8sDwWXKm8Bb7YmEWm9HRA==
X-Received: by 2002:adf:fb86:: with SMTP id a6mr11851834wrr.35.1639117332052;
        Thu, 09 Dec 2021 22:22:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1sm1476759wrz.92.2021.12.09.22.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 22:22:11 -0800 (PST)
Message-Id: <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 06:22:09 +0000
Subject: [PATCH 2/2] checkout: introduce "--to-branch" option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we want checkout to a branch (e.g. dev1) which reference
to a commit, but sometimes we only remember the tag (e.g. v1.1)
on it, we will use `git checkout v1.1` to find the commit first,
git will be in the state of deatching HEAD, so we have to search the
branches on the commit and checkout the branch we perfer. This will
be a bit cumbersome.

Introduce "--to-branch" option, `git checkout --to-branch <tag>`
and `git checkout --to-branch <commit>` will search all branches
and find a unique branch reference to the commit (or the commit which
the tag reference to) and checkout to it. If the commit have more
than one branches, it will report error "here are more than one
branch on commit".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-checkout.txt |  8 +++-
 builtin/checkout.c             | 33 +++++++++++++
 t/t2018-checkout-branch.sh     | 85 ++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh          |  1 +
 4 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d473c9bf387..2a240699fd9 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
-'git checkout' [-q] [-f] [-m] [--detach] <commit>
+'git checkout' [-q] [-f] [-m] [--detach] [-w|--to-branch] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
@@ -210,6 +210,12 @@ variable.
 	`<commit>` is not a branch name.  See the "DETACHED HEAD" section
 	below for details.
 
+-w::
+--to-branch::
+	Rather than checking out a commit to work on it, checkout out
+	to the unique branch on it. If there are multiple branches on
+	the commit, the checkout will fail.
+
 --orphan <new_branch>::
 	Create a new 'orphan' branch, named `<new_branch>`, started from
 	`<start_point>` and switch to it.  The first commit made on this
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3eeac3147f2..696248b05c0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -28,6 +28,7 @@
 #include "xdiff-interface.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "../ref-filter.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
@@ -70,6 +71,7 @@ struct checkout_opts {
 	int empty_pathspec_ok;
 	int checkout_index;
 	int checkout_worktree;
+	int to_branch;
 	const char *ignore_unmerged_opt;
 	int ignore_unmerged;
 	int pathspec_file_nul;
@@ -1512,6 +1514,35 @@ static int checkout_branch(struct checkout_opts *opts,
 		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
 			return switch_unborn_to_new_branch(opts);
 	}
+	if (opts->to_branch) {
+		struct ref_filter filter;
+		struct ref_array array;
+		int i;
+		int count = 0;
+		const char *unused_pattern = NULL;
+
+		memset(&array, 0, sizeof(array));
+		memset(&filter, 0, sizeof(filter));
+		filter.kind = FILTER_REFS_BRANCHES;
+		filter.name_patterns = &unused_pattern;
+		filter_refs(&array, &filter, filter.kind);
+		for (i = 0; i < array.nr; i++) {
+			if (oideq(&array.items[i]->objectname, &new_branch_info->oid)) {
+				if (count)
+					die(_("here are more than one branch on commit %s"), oid_to_hex(&new_branch_info->oid));
+				count++;
+				if (new_branch_info->refname)
+					free((char *)new_branch_info->refname);
+				new_branch_info->refname = xstrdup(array.items[i]->refname);
+				if (new_branch_info->path)
+					free((char *)new_branch_info->path);
+				new_branch_info->path = xstrdup(array.items[i]->refname);
+				new_branch_info->name = new_branch_info->path;
+			}
+		}
+		ref_array_clear(&array);
+	}
+
 	return switch_branches(opts, new_branch_info);
 }
 
@@ -1797,6 +1828,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git checkout <no-such-branch>' (default)")),
+		OPT_BOOL('w', "to-branch", &opts.to_branch,
+			 N_("checkout to a branch from a commit or a tag")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_END()
 	};
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 93be1c0eae5..53e45cfe7fd 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -270,4 +270,89 @@ test_expect_success 'checkout -b rejects an extra path argument' '
 	test_i18ngrep "Cannot update paths and switch to branch" err
 '
 
+test_expect_success 'checkout -w with oid' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git branch -M main &&
+		test_commit initial file1 &&
+		HEAD1=$(git rev-parse --verify HEAD) &&
+		git switch -c dev &&
+		test_commit step2 file2 &&
+		HEAD2=$(git rev-parse --verify HEAD) &&
+
+		git checkout -w $HEAD1 &&
+
+		echo "refs/heads/main" >ref.expect &&
+		git rev-parse --symbolic-full-name HEAD >ref.actual &&
+		test_cmp ref.expect ref.actual &&
+
+		echo "$HEAD1" >oid.expect &&
+		git rev-parse --verify HEAD >oid.actual &&
+		test_cmp oid.expect oid.actual &&
+
+		git checkout -w $HEAD2 &&
+
+		echo "refs/heads/dev" >ref.expect &&
+		git rev-parse --symbolic-full-name HEAD >ref.actual &&
+		test_cmp ref.expect ref.actual &&
+
+		echo "$HEAD2" >oid.expect &&
+		git rev-parse --verify HEAD >oid.actual &&
+		test_cmp oid.expect oid.actual
+	)
+'
+
+test_expect_success 'checkout -w with tag' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git branch -M main &&
+		test_commit initial file1 &&
+		git tag v1 &&
+		HEAD1=$(git rev-parse --verify HEAD) &&
+		git switch -c dev &&
+		test_commit step2 file2 &&
+		git tag v2 &&
+		HEAD2=$(git rev-parse --verify HEAD) &&
+
+		git checkout -w v1 &&
+
+		echo "refs/heads/main" >ref.expect &&
+		git rev-parse --symbolic-full-name HEAD >ref.actual &&
+		test_cmp ref.expect ref.actual &&
+
+		echo "$HEAD1" >oid.expect &&
+		git rev-parse --verify HEAD >oid.actual &&
+		test_cmp oid.expect oid.actual &&
+
+		git checkout -w v2 &&
+
+		echo "refs/heads/dev" >ref.expect &&
+		git rev-parse --symbolic-full-name HEAD >ref.actual &&
+		test_cmp ref.expect ref.actual &&
+
+		echo "$HEAD2" >oid.expect &&
+		git rev-parse --verify HEAD >oid.actual &&
+		test_cmp oid.expect oid.actual
+	)
+'
+
+test_expect_success 'checkout -w with branches' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git branch -M main &&
+		test_commit initial file1 &&
+		HEAD1=$(git rev-parse --verify HEAD) &&
+		git tag v1 &&
+		git branch dev &&
+		test_must_fail git checkout -w $HEAD1 &&
+		test_must_fail git checkout -w dev
+	)
+'
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 518203fbe07..4ec134338c2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2021,6 +2021,7 @@ test_expect_success 'double dash "git checkout"' '
 	--orphan=Z
 	--ours Z
 	--theirs Z
+	--to-branch Z
 	--merge Z
 	--conflict=Z
 	--patch Z
-- 
gitgitgadget
