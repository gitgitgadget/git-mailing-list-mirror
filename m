Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B9AC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E0B610A5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhJ0IaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbhJ0IaA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:30:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F2C061226
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d10so2734259wrb.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aQ+QGgdrhU/K/8kJGcFYpcyWyJs67bJ2MtdVzXvmszA=;
        b=h7nlveD3Ja8Xyaz+V9fs66JhGXYsM3E9hvxiErhCfsFVPjS1MJ9XKEtIAeTxxIHS0z
         6XOS7v7v8BsNL7SLoXzQ8USyMwKaxS7jspvvYZeZTxDbXzVaurnm+MIBybbTiQgM9U7Y
         yL4rHvPa7IEo7HcajRaq/vr88cByjkBAsAoTAb/VrVvk8Mzsap2H5D3Sg3l9jhHwavKv
         JFdmciITCNMG/TihHeVo6q374XBm3c+BiFAAjrSQ1QNhUmLwPz6inXXxm7DQPCS47sHC
         J4DAXrm7LpKQnB1aGuaCJDh7/3tX1nP1IFViwMMzLasO6gzcSmt0gAM1Qsjv5hSTwS3G
         ZRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aQ+QGgdrhU/K/8kJGcFYpcyWyJs67bJ2MtdVzXvmszA=;
        b=XIeBYPR/4C/3DALDGfUEJn6ZwKjabrzdt767cRmQ90r5YrJoUhI/jn98GZgBWstNYG
         MjGNQbMPd8g8ZeuJNcFsu+BAnDVtY/FGb/fol/o+LyrlvExC1zgylUsNFTZ9CoVAosrR
         ytZjx9VORIx9NxOW2Mgide1+nc6F3HoAnYavgNwvOiqziQv3CYkDmQw2FiP6yQVqjQRN
         OT7EW+CS21KV8Uw++YlY9b7wLirkDeeRuFNYLRHf50Gd+e10N08n8DYAZA+dxJogJpuh
         EAM7EolOfvL4pVf5eLNdbv/VGKOFmZfBrdvSp5zEEXEZ8dH700XwBkq7K5SMrKYT7hEP
         TCCA==
X-Gm-Message-State: AOAM531MCWtWlMZk9o6O+ja9UznxW0SBj01Rtjxk+02nEq8w70Pdfys0
        DqwYF9kAc2btdl4d5A1Sozz/Vd9v4OM=
X-Google-Smtp-Source: ABdhPJxKgcAagt4nDaA6UHBKx6NmmKlkm3Ql5Mkf/HK0dxmaHzja4ksOMdrJ8ivIFNd8QgYFPpRgeg==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr33053410wrp.28.1635323245894;
        Wed, 27 Oct 2021 01:27:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm3421748wrt.76.2021.10.27.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:25 -0700 (PDT)
Message-Id: <5ee54a9e25f00fab14511f81ebdd3ac8e89475a3.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:13 +0000
Subject: [PATCH v6 09/15] scalar: teach 'clone' to support the --single-branch
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like `git clone`, the `scalar clone` command now also offers to
restrict the clone to a single branch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          |  9 +++++++--
 contrib/scalar/scalar.txt        | 12 +++++++++++-
 contrib/scalar/t/t9099-scalar.sh |  6 +++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 0401462b9b3..754e19d781d 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -326,12 +326,15 @@ static char *remote_default_branch(const char *url)
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
-	int full_clone = 0;
+	int full_clone = 0, single_branch = 0;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
 		OPT_BOOL(0, "full-clone", &full_clone,
 			 N_("when cloning, create full working directory")),
+		OPT_BOOL(0, "single-branch", &single_branch,
+			 N_("only download metadata for the branch that will "
+			    "be checked out")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
@@ -402,7 +405,9 @@ static int cmd_clone(int argc, const char **argv)
 
 	if (set_config("remote.origin.url=%s", url) ||
 	    set_config("remote.origin.fetch="
-		       "+refs/heads/*:refs/remotes/origin/*") ||
+		       "+refs/heads/%s:refs/remotes/origin/%s",
+		       single_branch ? branch : "*",
+		       single_branch ? branch : "*") ||
 	    set_config("remote.origin.promisor=true") ||
 	    set_config("remote.origin.partialCloneFilter=blob:none")) {
 		res = error(_("could not configure remote in '%s'"), dir);
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index e8730967f16..56f744a4aa9 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,7 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
-scalar clone [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
+scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
@@ -57,6 +57,16 @@ HEAD[:<directory>]`.
 	Instead of checking out the branch pointed to by the cloned
 	repository's HEAD, check out the `<name>` branch instead.
 
+--[no-]single-branch::
+	Clone only the history leading to the tip of a single branch, either
+	specified by the `--branch` option or the primary branch remote's
+	`HEAD` points at.
++
+Further fetches into the resulting repository will only update the
+remote-tracking branch for the branch this option was used for the initial
+cloning. If the HEAD at the remote did not point at any branch when
+`--single-branch` clone was made, no remote-tracking branch is created.
+
 --[no-]full-clone::
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 295398f62cc..9a35ab4fde6 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -45,13 +45,17 @@ test_expect_success 'set up repository to clone' '
 
 test_expect_success 'scalar clone' '
 	second=$(git rev-parse --verify second:second.t) &&
-	scalar clone "file://$(pwd)" cloned &&
+	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
 		cd cloned/src &&
 
 		git config --get --global --fixed-value maintenance.repo \
 			"$(pwd)" &&
 
+		git for-each-ref --format="%(refname)" refs/remotes/origin/ >actual &&
+		echo "refs/remotes/origin/parallel" >expect &&
+		test_cmp expect actual &&
+
 		test_path_is_missing 1/2 &&
 		test_must_fail git rev-list --missing=print $second &&
 		git rev-list $second &&
-- 
gitgitgadget

