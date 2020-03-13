Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E154FC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DBF20753
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 21:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuCoMivY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCMVJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:09:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40193 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 17:09:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id f3so6848936wrw.7
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NiNrG755Z0k8x688hvzUUy9DhNJOI0zucQPu/+Gu8aw=;
        b=XuCoMivYQDnllzEXhOcVDAPjJJBrYN8S2nN8zb8LJAgLXTdSc9JqhdrEjtC6+K3msJ
         AOp84WrXpRAT0sRp5NMVL85Wsz5gO/7o7HxZjR9QUUDnCo0JAOclkC23r4lVr66e6PyR
         EVMVIvCDGX4tgqZ2Mp8hyAX6q/7bsGZXCTH9noRDZP2VmefPXh/xARrgI6EnDwb/AgdV
         DSSQ4kHzDE4sThfFtlx0Wzxy9rGap3unKWSp3d53fdvz779iQgZkiZeKK3FReMzS/RvM
         7mtDzkS7oOiDtNpgXCG5YUx/vxBYjJPfA5oaqxHeRnO3ub/ARPoMOpmwzpoaRzVP/Kbd
         UeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NiNrG755Z0k8x688hvzUUy9DhNJOI0zucQPu/+Gu8aw=;
        b=DzA00XYNHXwndIYEsOwe1Tbg0MnqtH4zDv13CPBzjnSxbd4zST7UuGvy1eoemet9Wq
         GHGCqoz08kB1JfPV+CYT711X7z0hQfnMIDHTZCnEeydmviIFbiaI1GAvLLWfqC2SO1Qj
         YfD9jBMjlTUltossI4g1zvyZxoQ9tY96GOPvznyAThFKT5d7hGClm4cxC4a8M6T9jJKY
         tKvUXW8zg3u6zgZv+Zo/Z5rYutTWZVUJfP8y7epX3GsBfUcbw9cXRGcBuZxCaIdF03wY
         pTgL6+rk5Q2v1zF3grkiEVyLKfvfiFhDdpw+CFa49IFUcXNxACn5gqe+3RDK0EadR1lp
         V2sg==
X-Gm-Message-State: ANhLgQ1g3WkJI98odUN8oDyQTtr0ggpkkSd3GjzhN49WWyzUTOcOpdAR
        n/9iqnwZFSyOfFeisUh/kg1fatYr
X-Google-Smtp-Source: ADFU+vtZ/IfZPOS+fCpAQgsoQjV1bFW/Qsw8p1wc1W58F4u6VLRcLlcg/D72QYPx6N66zQbpd7R8uQ==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr2508033wrm.363.1584133743752;
        Fri, 13 Mar 2020 14:09:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm13381352wmb.21.2020.03.13.14.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:09:03 -0700 (PDT)
Message-Id: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Mar 2020 21:09:02 +0000
Subject: [PATCH] clone: use --quiet when stderr is not a terminal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

"git clone" is used by many build systems to download Git code before
running a build. The output of these systems is usually color-coded to
separate stdout and stderr output, which highlights anything over stderr
as an error or warning. Most build systems use "--quiet" when cloning to
avoid adding progress noise to these outputs, but occasionally users
create their own scripts that call "git clone" and forget the --quiet
option.

Just such a user voiced a complaint that "git clone" was showing "error
messages" in bright red. The messages were progress indicators for
"Updating files".

To save users from this confusion, let's default to --quiet when stderr
is not a terminal window.

To test that this works, use the GIT_PROGRESS_DELAY environment variable
to enforce that all progress indicators appear immediately, and check
that a redirected stderr has no output. We also need to update some
tests that inspect stderr after a "git clone" or "git submodule update"
command. It is easy to update the clone tests with the --verbose option,
while we can remove the clone output from the expected output of the
submodule test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    clone: use --quiet when stderr is not a terminal
    
    I think this is generally how we are intending Git builtins to work.
    There was a complaint recently about my proposed addition of progress to
    'git read-tree', but that was because scripts would suddenly get noisy
    if they were not expecting it. This is the opposite: we will make 'git
    clone' quieter.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-581%2Fderrickstolee%2Fclone-quiet-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-581/derrickstolee/clone-quiet-default-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/581

 builtin/clone.c             | 3 +++
 t/t5550-http-fetch-dumb.sh  | 2 +-
 t/t5601-clone.sh            | 7 ++++++-
 t/t7406-submodule-update.sh | 8 --------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1ad26f4d8c8..a2e6905f0ef 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -957,6 +957,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
+	if (!isatty(2))
+		option_verbosity = -1;
+
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b811d89cfd6..c0bdcafa304 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -332,7 +332,7 @@ test_expect_success 'redirects can be forbidden/allowed' '
 	test_must_fail git -c http.followRedirects=false \
 		clone $HTTPD_URL/dumb-redir/repo.git dumb-redir &&
 	git -c http.followRedirects=true \
-		clone $HTTPD_URL/dumb-redir/repo.git dumb-redir 2>stderr
+		clone --verbose $HTTPD_URL/dumb-redir/repo.git dumb-redir 2>stderr
 '
 
 test_expect_success 'redirects are reported to stderr' '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 84ea2a3eb70..2902a201977 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -39,7 +39,7 @@ test_expect_success 'clone with excess parameters (2)' '
 
 test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 	rm -fr dst &&
-	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
+	git clone --verbose -n "file://$(pwd)/src" dst >output 2>&1 &&
 	test $(grep Clon output | wc -l) = 1
 '
 
@@ -297,6 +297,11 @@ test_expect_success 'clone from original with relative alternate' '
 	grep /src/\\.git/objects target-10/objects/info/alternates
 '
 
+test_expect_success 'clone quietly without terminal' '
+	GIT_PROGRESS_DELAY=0 git clone src progress 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'clone checking out a tag' '
 	git clone --branch=some-tag src dst.tag &&
 	GIT_DIR=src/.git git rev-parse some-tag >expected &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4fb447a143e..ebf08e3a77a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -115,18 +115,10 @@ Submodule path '../super/submodule': checked out '$submodulesha1'
 EOF
 
 cat <<EOF >expect2
-Cloning into '$pwd/recursivesuper/super/merging'...
-Cloning into '$pwd/recursivesuper/super/none'...
-Cloning into '$pwd/recursivesuper/super/rebasing'...
-Cloning into '$pwd/recursivesuper/super/submodule'...
 Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
 Submodule 'none' ($pwd/none) registered for path '../super/none'
 Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
 Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
-done.
-done.
-done.
-done.
 EOF
 
 test_expect_success 'submodule update --init --recursive from subdirectory' '

base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
-- 
gitgitgadget
