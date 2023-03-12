Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6375C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjCLVHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjCLVHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 17:07:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B23F3B0F3
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:07:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nn12so10051196pjb.5
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678655238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiqKXg7nuisFhpy5qsjj7aeQUCZntqFeaavElN3ASCs=;
        b=L7GlFFAstEPTNBYfDGW40ICIXAfIJV3282wjdckhQSxsr9UgVq1RlIe5M1rEdRQG/z
         7arHM4T6rlSwrHhXAOpDyFNCbFMFTB3t1Jael9JT8a+GvelvCh1ABqVTAHaQyXnbHzkn
         R1ns+hAsvk+88KevRlJbaIwkHdfTlIBEMRBMWS42kvbtqO5Gzi+99dMO45zt0UsZsuh5
         It77+a6xJOF+qgItLp3eZXxelFNAjv2t3dYJwCIc+TZOJViDMCT4DIvyVkp78S8omkOB
         dUdxcO3BMvr5R1+2tgGqlsgr0BaPa8tic9hUX4f6JW1XkJmSc9ak9QX7R/8i+g5jhaD/
         4C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiqKXg7nuisFhpy5qsjj7aeQUCZntqFeaavElN3ASCs=;
        b=8JJzMhWCLefiUw45LXtOfZ+YAmvJHCEk/OB5ZSZJvuR9hqxNV6ZwC2g84gmT5mM02m
         FhHC2zbaZ6GwE9dQFd0lrb5DENxZbcnnLKIVmzN0IRzTuyP7Q3Ug7NAGWyv6pqFEqtaa
         9//CgPBkz9RBYLXp/dvE4YA4Fadpv/D436dqe7aFzCE3NXoNAOtFV+E8LpYnuJLpD70/
         l7V1Y9LDvIMw7ATFGKCpXeCMSuxcB3CcoDFzWTdsJLvCMW8depIp56he9PaKgdicSiyN
         30zL/05IqtMa01//IELfIGEYhRnWKVD1pZ2vyIQ8fG19Wyby5XQ3yWISay/JqP683BlJ
         DD0Q==
X-Gm-Message-State: AO0yUKVXhkRIRvJ0mmMFYeIOUWg1RbwXePtg+nWgoJTFhptO9V8drOAD
        hux+2yvRODVRG1LcQnMB4gqYJmIfaPe1Pw==
X-Google-Smtp-Source: AK7set/brrmZiUaj3rCrvjPeZ3paqLcp/k9nOji8JWoCK+TQBKWalC5AIoFAbdR797a8/DcUTncnyQ==
X-Received: by 2002:a17:90b:3b8b:b0:237:62c6:ab64 with SMTP id pc11-20020a17090b3b8b00b0023762c6ab64mr32518168pjb.38.1678655238205;
        Sun, 12 Mar 2023 14:07:18 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b0019f2a7f4d16sm2653043plg.39.2023.03.12.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:07:17 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com, jonathantanmy@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v7 1/3] rebase: add documentation and test for --no-rebase-merges
Date:   Sun, 12 Mar 2023 15:04:54 -0600
Message-Id: <20230312210456.92364-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312210456.92364-1-alexhenrie24@gmail.com>
References: <20230305050709.68736-1-alexhenrie24@gmail.com>
 <20230312210456.92364-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as I can tell, --no-rebase-merges has always worked, but has
never been documented. It is especially important to document it before
a rebase.rebaseMerges option is introduced so that users know how to
override the config option on the command line. It's also important to
clarify that --rebase-merges without an argument is not the same as
--no-rebase-merges and not passing --rebase-merges is not the same as
passing --rebase-merges=no-rebase-cousins.

A test case is necessary to make sure that --no-rebase-merges keeps
working after its code is refactored in the following patches of this
series. The test case is a little contrived: It's unlikely that a user
would type both --rebase-merges and --no-rebase-merges at the same time.
However, if an alias is defined which includes --rebase-merges, the user
might decide to add --no-rebase-merges to countermand that part of the
alias but leave alone other flags set by the alias.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt | 18 +++++++++++-------
 t/t3430-rebase-merges.sh     | 10 ++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..4e57a87624 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,20 +529,24 @@ See also INCOMPATIBLE OPTIONS below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
+--no-rebase-merges::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
 	With `--rebase-merges`, the rebase will instead try to preserve
 	the branching structure within the commits that are to be rebased,
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
-	resolved/re-applied manually.
+	resolved/re-applied manually. `--no-rebase-merges` can be used to
+	countermand a previous `--rebase-merges`.
 +
-By default, or when `no-rebase-cousins` was specified, commits which do not
-have `<upstream>` as direct ancestor will keep their original branch point,
-i.e. commits that would be excluded by linkgit:git-log[1]'s
-`--ancestry-path` option will keep their original ancestry by default. If
-the `rebase-cousins` mode is turned on, such commits are instead rebased
-onto `<upstream>` (or `<onto>`, if specified).
+When rebasing merges, there are two modes: `rebase-cousins` and
+`no-rebase-cousins`. If the mode is not specified, it defaults to
+`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
+`<upstream>` as direct ancestor will keep their original branch point, i.e.
+commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
+option will keep their original ancestry by default. In `rebase-cousins` mode,
+such commits are instead rebased onto `<upstream>` (or `<onto>`, if
+specified).
 +
 It is currently only possible to recreate the merge commits using the
 `ort` merge strategy; different merge strategies can be used only via
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f..d46d9545f2 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -250,6 +250,16 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success '--no-rebase-merges countermands --rebase-merges' '
+	git checkout -b no-rebase-merges E &&
+	git rebase --rebase-merges --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
 test_expect_success 'do not rebase cousins unless asked for' '
 	git checkout -b cousins main &&
 	before="$(git rev-parse --verify HEAD)" &&
-- 
2.39.2

