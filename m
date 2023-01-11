Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996F6C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 13:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjAKNO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 08:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjAKNOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 08:14:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45C8167F5
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 05:14:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso14307391wms.5
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 05:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UiHKhDg+aeZ8pHfDqId/dzizGiEcvGt8wv/vq76Bik=;
        b=pMqHZAOA4H3TGBMaugJnh9/bHLohgzgZKTZCXES0LkN9w+9VPe55l7v2fVnyrq6vl8
         DOj6Q5iLmnHNuNd3dKqCXM4iIKQrNPZ0iNuTjxuLjw9R1fQF2AWBgOdkJt3j0zIdeb46
         uPam+PZch6iMp5R4KpE7sWIyXWit/cx+w1V4Pk+FQIZ5OrwKgEkMMlgF7XQFMRPnvkxC
         P4owU9V3Lk8tu98F/oRsTkj+5/MSmLCrCuESosZX8h27q2kWiA+1DGXE7Y2eTGBYIEeR
         Y7nA6WyagZX/STjx3KGz+EmXMwU9V5z568FVHlm+RnZGVWU7pZfO8DipR+ORJ3VvPo7y
         H8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UiHKhDg+aeZ8pHfDqId/dzizGiEcvGt8wv/vq76Bik=;
        b=bNDJHCKUir0kFVVOUDpspzWd6Luiwkp2zWvvxw0DCToa9ZHagofEj/+oVOVyBTgTyB
         KrEZ3KGIsrVZpRDK/iKIzoFL+otMbA3x9U1QDwhSRCmmoTj+ZWiBB87dToWNOO9o5gNQ
         QTNK8WMkHAzyxdb/yLvHj9HsgxQoFKK9DbuwRTuB4yTBfDnu7cilSPuuX3gmcJykb40I
         k90Op2XC/yeRYJtVZWmo3RHjNOSyZlcJ1v3aAJmwhdopKGiNnMSI2fZhHhjuC9RJMQeQ
         XQfD82jCtIWxO5yyoy57Ox+vPMHJ1VNRP3ats6Tn0X3ba8tZADhoJX0QSQmJGZciJ0KG
         F7Rg==
X-Gm-Message-State: AFqh2koGLaa5V+jU9uvTXAsUXHwA860/1ZmEzLL9Vfzgb2TcODCOyHDp
        LPTFo7s6onjY0h2OvOLoPj00CXor8hE=
X-Google-Smtp-Source: AMrXdXvnn6ZiyukqBzkk5ZTotG+rORrTqy6EmG5hDXqebLqGFBQH1GOWlldupENSFDET2weQh4JHzA==
X-Received: by 2002:a05:600c:4e4f:b0:3cf:9d32:db67 with SMTP id e15-20020a05600c4e4f00b003cf9d32db67mr51861682wmq.3.1673442861966;
        Wed, 11 Jan 2023 05:14:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1-20020adf9b01000000b0028e55b44a99sm13585738wrc.17.2023.01.11.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:14:21 -0800 (PST)
Message-Id: <pull.1441.v3.git.1673442860379.gitgitgadget@gmail.com>
In-Reply-To: <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com>
References: <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 13:14:20 +0000
Subject: [PATCH v3] scalar: show progress if stderr refer to a terminal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Sometimes when users use scalar to download a monorepo
with a long commit history, they want to check the
progress bar to know how long they still need to wait
during the fetch process, but scalar suppresses this
output by default.

So let's check whether scalar stderr refer to a terminal,
if so, show progress, otherwise disable it.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    scalar: show progress if stderr refer to a terminal
    
    When users use scalar to download a monorepo with a long commit history
    (or the client and server network communication is very poor), we often
    need to spend a long time in the fetch phase of scalar, some users may
    want to check this progress bar To understand the progress of fetch and
    how long they have to wait, so we should enable scalar to display fetch
    progress.
    
    v1. add [--verbose| -v] to scalar clone.
    
    v2.
    
     1. remove --verbose option.
     2. check if scalar stderr refer to terminal, if so, show progress.
    
    v3.
    
     1. fix some tests suggested by Derrick Stolee.
    
    Note: output look like this:
    
    $ scalar clone git@github.com:git/git.git
    Initialized empty Git repository in /home/adl/test/git/src/.git/
    remote: Enumerating objects: 208997, done.
    remote: Counting objects: 100% (870/870), done.
    remote: Compressing objects: 100% (870/870), done.
    remote: Total 208991 (delta 0), reused 870 (delta 0), pack-reused 208121
    remote: Enumerating objects: 470, done.
    remote: Counting objects: 100% (418/418), done.
    remote: Compressing objects: 100% (418/418), done.
    remote: Total 470 (delta 1), reused 0 (delta 0), pack-reused 52
    Receiving objects: 100% (470/470), 1.96 MiB | 1.64 MiB/s, done.
    Resolving deltas: 100% (1/1), done.
    Updating files: 100% (471/471), done.
    branch 'master' set up to track 'origin/master'.
    Switched to a new branch 'master'
    Your branch is up to date with 'origin/master'.
    
    
    "new branch", "new tag" output is a bit annoying, it would be better to
    suppress them, but keep the progress.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1441%2Fadlternative%2Fzh%2Fscalar-verbosity-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1441/adlternative/zh/scalar-verbosity-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1441

Range-diff vs v2:

 1:  2e4c296bd19 ! 1:  38e7e0d44d1 scalar: show progress if stderr refer to a terminal
     @@ t/t9211-scalar-clone.sh: test_expect_success '--no-single-branch clones all bran
      +
      +	test_terminal env GIT_PROGRESS_DELAY=0 \
      +		scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
     -+	grep --count "Enumerating objects" stderr >actual &&
     -+	echo 2 >expected &&
     -+	test_cmp expected actual &&
     ++	grep "Enumerating objects" stderr >actual &&
     ++	test_line_count = 2 actual &&
      +	cleanup_clone $enlistment
      +'
      +
     -+test_expect_success 'progress without tty' '
     ++test_expect_success TTY 'progress without tty' '
      +	enlistment=progress2 &&
      +
      +	test_config -C to-clone uploadpack.allowfilter true &&
      +	test_config -C to-clone uploadpack.allowanysha1inwant true &&
      +
     -+	scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
     ++	GIT_PROGRESS_DELAY=0 scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
      +	! grep "Enumerating objects" stderr &&
      +	! grep "Updating files" stderr &&
      +	cleanup_clone $enlistment
      +'
     ++
       test_done


 scalar.c                | 10 +++++++---
 t/t9211-scalar-clone.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/scalar.c b/scalar.c
index 6c52243cdf1..e5cc554c537 100644
--- a/scalar.c
+++ b/scalar.c
@@ -404,7 +404,7 @@ void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
-	int full_clone = 0, single_branch = 0;
+	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -499,7 +499,9 @@ static int cmd_clone(int argc, const char **argv)
 	if (set_recommended_config(0))
 		return error(_("could not configure '%s'"), dir);
 
-	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
+	if ((res = run_git("fetch", "--quiet",
+				show_progress ? "--progress" : "--no-progress",
+				"origin", NULL))) {
 		warning(_("partial clone failed; attempting full clone"));
 
 		if (set_config("remote.origin.promisor") ||
@@ -508,7 +510,9 @@ static int cmd_clone(int argc, const char **argv)
 			goto cleanup;
 		}
 
-		if ((res = run_git("fetch", "--quiet", "origin", NULL)))
+		if ((res = run_git("fetch", "--quiet",
+					show_progress ? "--progress" : "--no-progress",
+					"origin", NULL)))
 			goto cleanup;
 	}
 
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index dd33d87e9be..2da8ca6f2bb 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -3,6 +3,7 @@
 test_description='test the `scalar clone` subcommand'
 
 . ./test-lib.sh
+. "${TEST_DIRECTORY}/lib-terminal.sh"
 
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
 export GIT_TEST_MAINT_SCHEDULER
@@ -148,4 +149,29 @@ test_expect_success '--no-single-branch clones all branches' '
 	cleanup_clone $enlistment
 '
 
+test_expect_success TTY 'progress with tty' '
+	enlistment=progress1 &&
+
+	test_config -C to-clone uploadpack.allowfilter true &&
+	test_config -C to-clone uploadpack.allowanysha1inwant true &&
+
+	test_terminal env GIT_PROGRESS_DELAY=0 \
+		scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
+	grep "Enumerating objects" stderr >actual &&
+	test_line_count = 2 actual &&
+	cleanup_clone $enlistment
+'
+
+test_expect_success TTY 'progress without tty' '
+	enlistment=progress2 &&
+
+	test_config -C to-clone uploadpack.allowfilter true &&
+	test_config -C to-clone uploadpack.allowanysha1inwant true &&
+
+	GIT_PROGRESS_DELAY=0 scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
+	! grep "Enumerating objects" stderr &&
+	! grep "Updating files" stderr &&
+	cleanup_clone $enlistment
+'
+
 test_done

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
