Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC3AC4167B
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AB861C32
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhKQOXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbhKQOXB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:23:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A0C061234
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4950190wml.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aNTH9FlmLUV1D0smRDtl/JcI0aq3IqqJlw7lcxaJwfw=;
        b=azciEDic9RN5YjI/oumXeipsNZ8P/3dkLai1/Yjxdh2kX5u3WoBfJDeHDe7/+oNSHB
         Qa9dYA3YrowtPToynfww6qNyS89EM4SD8HbUuijXF2nBv8OM1nJkroMHbylBhUT94TQf
         I00uJALM6N0qLT2dewAGdHZAJVPlaJ8VNi81FMmFZf1wFBv6EvBejIXuHe6qhvzjCzhJ
         Xr+vzzfTHgo9OWnbLQVGjjHhYpiqPn8l927kxgixZEs7d0Ujhpyueyt4NTLtasOz/J0/
         G5Fv9xkGdRNint0SXgaUPeIzwkmjtNiIRrBNcIjy2k1PiGLaL8f+oEWrRL2PTl0IT4OW
         bHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aNTH9FlmLUV1D0smRDtl/JcI0aq3IqqJlw7lcxaJwfw=;
        b=aoKytNnT0rkj9WROhzVaMFpQOf58oBZvgKXUkry9cH2Uvisy6J/gMFg/tpQPK4DLGn
         MgimVXD/wj1zmgCdidORc8kDzjCPg30aV9HTMzVSmjBsL0uTs443a0VF8kZwHYDw83Gh
         70R9QE/M6+r4qiAM7d1TXmefUJWoZCspgow86QC2n7DN4yumD7kFUTFLYYahU7E22B8I
         badvLBDkcJJ6L0BAW6Zve/GbP5Y3UUvK81wYnsCk720T90rSJ+3VYzeYgmNgXBfRJfmA
         jEMu5yKQ0lIQZA1TBMQvyJ0vwHyxcsf8L9M9yXW+sKdkhP/3c3fOTOGfTi7N2MdkFnTy
         7/6Q==
X-Gm-Message-State: AOAM532vJLP1IMOZOhX8REkpp7cl4OQ6Jikw/a4jKus0ZxfGGdebuyZu
        oJVyJxKgT48fwHkadopJHOtU9g1pqoA=
X-Google-Smtp-Source: ABdhPJy9p2ki+9ATI1iql5oMuuO7/KowJO2kJHp0SRBnnVtf3qrsr32xQnqa3RlnaWpV8okBr/1Scw==
X-Received: by 2002:a05:600c:4fca:: with SMTP id o10mr18075496wmq.175.1637158778774;
        Wed, 17 Nov 2021 06:19:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3sm3581wrv.69.2021.11.17.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:38 -0800 (PST)
Message-Id: <2677bcff335a7e408f5ea786343e765e71837ba7.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:17 +0000
Subject: [PATCH v7 12/17] scalar: teach 'clone' to support the --single-branch
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
index 43f83dde33b..516a75be3c4 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -327,12 +327,15 @@ static char *remote_default_branch(const char *url)
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
@@ -403,7 +406,9 @@ static int cmd_clone(int argc, const char **argv)
 
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
index 984d69e8f75..f60e086d6f9 100755
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

