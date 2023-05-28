Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3870EC7EE23
	for <git@archiver.kernel.org>; Sun, 28 May 2023 09:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjE1J6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 05:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1J6s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 05:58:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E477B9
        for <git@vger.kernel.org>; Sun, 28 May 2023 02:58:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso24390725e9.2
        for <git@vger.kernel.org>; Sun, 28 May 2023 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685267924; x=1687859924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HouzmJDMWaY5T9pp6zZ6Fs/2/SP53e+peh1EBdbMLwI=;
        b=nSoB8JxF5CEXvgUd/OpqY0D2ja+fOZChFhXw8tZCt4SHKpIOxAYsttbJKPV0wjegZk
         adVYrNPix+/jrvlcsYg+rx49wYfi9tuXcQ83e7pAG8J1fqMjAcpgaBpSUvw4C+f326of
         nUMApQ0mrOvwS5CLEhynngRu9nu08xvmFUzUaD4OuExfH4AoOmkm6siFQEvrLszzPETb
         cvf1WBlf10kB+5Hh7ylBvku7EGj4cD6vpMbEl0PW+4aYsPsCrKMDfCSzTW0ujjDBR+7i
         8w6DpuZ6Y4rSiV8aROyVFoq3mjxS15PbDO4MZybGW1uR74FO6swzAzYtuPloLBmbhPTJ
         y+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685267924; x=1687859924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HouzmJDMWaY5T9pp6zZ6Fs/2/SP53e+peh1EBdbMLwI=;
        b=MJm0Ym9zSuxupGKhw5vYpPDZgrUzF+WW//qQoG5D+BfjKxp3tmAk9OOjPCtkrEmgFX
         mK0OzxgSEhswYqwgVByhmCjZol4XXu7Vuo2YecldLICICwuxaUYfTSmuPvjc730EnHAz
         Z8ANqbEOTs8zCr/ow/StEVMlL/v+zAhYyjiy8hDs2v/2wC3Pei5w+erUTHPuW1UsQR0J
         Z99PGVso/0jDFbGqu6GMgcaOfoJVbwEBDb6m/taQRFk1o0xx2nm8IMxESqJP5mczIH2x
         yW0qy65kHFSYIttqNbLdQiYUy1x6S7rdhDeOmtWx10HviBsTj0W/ms3H9g3yMGYoY6E5
         medA==
X-Gm-Message-State: AC+VfDzd74o0gMjr1pXlk89UA8yIO94kPtS6go1Fabu3W1RTh2QG8jQs
        qYXz5eY6V0DpYAO246p3aufoEqXhi1c=
X-Google-Smtp-Source: ACHHUZ5W/gaMio35QoxkFR2c9/K6Q83/Hd8XaGa6f3XtmbtCoXTroAiNATN1eoa8J9u9Dif8HhhtGQ==
X-Received: by 2002:a7b:c006:0:b0:3f1:789d:ad32 with SMTP id c6-20020a7bc006000000b003f1789dad32mr5913835wmb.11.1685267924328;
        Sun, 28 May 2023 02:58:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d4a4f000000b00307c0afc030sm10456599wrs.4.2023.05.28.02.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 02:58:43 -0700 (PDT)
Message-Id: <pull.1279.v2.git.1685267922901.gitgitgadget@gmail.com>
In-Reply-To: <pull.1279.git.1657480594123.gitgitgadget@gmail.com>
References: <pull.1279.git.1657480594123.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 May 2023 09:58:42 +0000
Subject: [PATCH v2] rev-parse: respect push.autosetupremote when evaluating
 @{push}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In a previous release, the push.autosetupremote config was introduced to
ease new branch management in "simple" single-remote workflows. This makes
"git push" work on new branches (without configured upstream) with
push.default set to "simple" or "upstream" and it implies
"--set-upstream" regardless of whether the same-name remote branch exists
or not.

The "@{push}" suffix logic was not adjusted to account for this new option,
however, and sometimes returns an error when "git push" would successfully
push to an existing remote branch.

This is an edge-case, as the main context where push.autosetupremote will
apply is for *new* branches, with no corresponding remote branch yet, and
so even if the defaulting is handled correctly, the rev-parse will still
fail with "unknown revision or path not in the working tree".

Fix this edge-case so "git rev-parse @{push}" works, if there is no
upstream tracking relationship set up but the remote tracking branch that
will be defaulted to does already exist and can be resolved.

Also add corresponding test cases.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    rev-parse: respect push.autosetupremote when evaluating @{push}
    
    Minor consistency fix for previously-introduced "push.autosetupremote"
    option.
    
    V2:
    
     * Rebased onto recent main, 10 months later.
    
    On the original thread, Junio expressed some concerns over the clarity
    of the code / the obviousness of the change, but I did not find any
    better approach.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1279%2FTaoK%2Ftao-rev-parse-autosetupremote-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1279/TaoK/tao-rev-parse-autosetupremote-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1279

Range-diff vs v1:

 1:  147e40ce932 ! 1:  d895e380b98 rev-parse: respect push.autosetupremote when evaluating @{push}
     @@ Commit message
      
          Fix this edge-case so "git rev-parse @{push}" works, if there is no
          upstream tracking relationship set up but the remote tracking branch that
     -    will be defaulted to does exist and can be resolved.
     +    will be defaulted to does already exist and can be resolved.
      
          Also add corresponding test cases.
      


 remote.c                  | 30 ++++++++++++++++++++++++++++--
 t/t1514-rev-parse-push.sh | 20 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 0764fca0db9..07194c616da 100644
--- a/remote.c
+++ b/remote.c
@@ -1906,6 +1906,23 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
+static const char *default_missing_upstream(struct remote *remote,
+				    struct branch *branch,
+				    struct strbuf *err)
+{
+	int autosetupremote = 0;
+
+	if (branch && (!branch->merge || !branch->merge[0])) {
+		repo_config_get_bool(the_repository,
+				     "push.autosetupremote",
+				     &autosetupremote);
+		if (autosetupremote)
+			return tracking_for_push_dest(remote, branch->refname, err);
+	}
+
+	return NULL;
+}
+
 static const char *branch_get_push_1(struct remote_state *remote_state,
 				     struct branch *branch, struct strbuf *err)
 {
@@ -1946,13 +1963,22 @@ static const char *branch_get_push_1(struct remote_state *remote_state,
 		return tracking_for_push_dest(remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
-		return branch_get_upstream(branch, err);
-
+		{
+			const char *up;
+			up = default_missing_upstream(remote, branch, err);
+			if (up)
+				return up;
+			return branch_get_upstream(branch, err);
+		}
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		{
 			const char *up, *cur;
 
+			up = default_missing_upstream(remote, branch, err);
+			if (up)
+				return up;
+
 			up = branch_get_upstream(branch, err);
 			if (!up)
 				return NULL;
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index d868a081105..ffa0db14585 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -21,7 +21,10 @@ test_expect_success 'setup' '
 	git push origin HEAD &&
 	git branch --set-upstream-to=origin/main main &&
 	git branch --track topic origin/main &&
+	git branch --no-track indie_topic origin/main &&
+	git branch --no-track new_topic origin/main &&
 	git push origin topic &&
+	git push origin indie_topic &&
 	git push other topic
 '
 
@@ -73,4 +76,21 @@ test_expect_success 'resolving @{push} fails with a detached HEAD' '
 	test_must_fail git rev-parse @{push}
 '
 
+test_expect_success '@{push} with default=simple without tracking' '
+	test_config push.default simple &&
+	test_must_fail git rev-parse indie_topic@{push}
+'
+
+test_expect_success '@{push} with default=simple with autosetupremote' '
+	test_config push.default simple &&
+	test_config push.autosetupremote true &&
+	resolve indie_topic@{push} refs/remotes/origin/indie_topic
+'
+
+test_expect_success '@{push} with default=simple with autosetupremote, new branch' '
+	test_config push.default simple &&
+	test_config push.autosetupremote true &&
+	test_must_fail git rev-parse new_topic@{push}
+'
+
 test_done

base-commit: 4a714b37029a4b63dbd22f7d7ed81f7a0d693680
-- 
gitgitgadget
