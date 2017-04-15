Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA141FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 14:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbdDOOlZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 10:41:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34922 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753862AbdDOOlY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 10:41:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id d79so2640986wmi.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3dLIu2vYxTEfc0bBPkjXIb+SskIYFCJVaW5oA3hGL/A=;
        b=D7ORSardsfOLEtzK1KR2NUYgmYYyqHD7aM0d0zEoN0ZV02nukM6/zRcBfFUFJDG+jS
         P2Rig8iTBq9x/+Yyt3e7WQ5nM40bK8J1f+TtzD5sz89XSj1BJHtTf6ykdw0CVqnKOPiQ
         6Y+VyLMjRnrXFNvSkIOgK6kxINvl0Efiglqg5BMM4Bef/aBodtbIJeWmCgD/SiAdWEHM
         dpI5fo41rshKppuEKyty/XteG/AA08UQLmLE1oBRMsdGYESvOCCCqqOX4yU2XBwp7jU5
         h20+ArDxCHdbIJrnYs6o1e8zvS6NHJnzoGYHVqkvBOMnDr6zHkdsxCgPATDpKG99X1zK
         FLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3dLIu2vYxTEfc0bBPkjXIb+SskIYFCJVaW5oA3hGL/A=;
        b=MWtoqrbjapusvXmUWcF8AhI/Cq2HqJju7iF99r5uLyZmMSJBla0djeV+P0BbPX3e7B
         +vqRU2Vs+HEGZAv80rNJW3do3VKW/9u38tEyrzIyp5JquqmqxKFDDN3Kp4UFmov4DSRV
         YLbjn/nVo21hH4ZYdvIoG4jmhPb3GeKdrQUHHJhohpR7fPW+ycYtEuHiQhduDYm7SJtd
         wb8IY9yXhIgtd3FKYVq/FVI2J/rynFT5kj6mkWJLArYn4nwmtLlZvANjFex4RB5tY9wJ
         hRIhvF5SBkylzPgvVcI5Tczff1etLp+n7cw/zCJGpMUdHegBFg6nEoYyluTA3jTS7z4g
         ud2g==
X-Gm-Message-State: AN3rC/7xndCrOoYNZNspixjqhtY0Y4kPW3MkDDB1/H3vrJoQyDFpAHOW
        W04aUhZd5kDdlw==
X-Received: by 10.28.181.69 with SMTP id e66mr2666786wmf.33.1492267283014;
        Sat, 15 Apr 2017 07:41:23 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id w52sm6620216wrc.14.2017.04.15.07.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Apr 2017 07:41:22 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 3/3] rebase: pass --[no-]signoff option to git am
Date:   Sat, 15 Apr 2017 16:41:03 +0200
Message-Id: <20170415144103.11986-4-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.765.g2bf946761b
In-Reply-To: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easy to sign off a whole patchset before submission.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-rebase.txt |  5 +++++
 git-rebase.sh                |  3 ++-
 t/t3428-rebase-signoff.sh    | 46 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100755 t/t3428-rebase-signoff.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 67d48e6883..e6f0b93337 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -385,6 +385,11 @@ have the long commit hash prepended to the format.
 	Recreate merge commits instead of flattening the history by replaying
 	commits a merge commit introduces. Merge conflict resolutions or manual
 	amendments to merge commits are not preserved.
+
+--signoff::
+	This flag is passed to 'git am' to sign off all the rebased
+	commits (see linkgit:git-am[1]).
+
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
diff --git a/git-rebase.sh b/git-rebase.sh
index 48d7c5ded4..6889fd19f3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,6 +34,7 @@ root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -i
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
+signoff!           passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
@@ -321,7 +322,7 @@ do
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date)
+	--committer-date-is-author-date|--ignore-date|--signoff|--no-signoff)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
new file mode 100755
index 0000000000..2afb564701
--- /dev/null
+++ b/t/t3428-rebase-signoff.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='git rebase --signoff
+
+This test runs git rebase --signoff and make sure that it works.
+'
+
+. ./test-lib.sh
+
+# A simple file to commit
+cat >file <<EOF
+a
+EOF
+
+# Expected commit message after rebase --signoff
+cat >expected-signed <<EOF
+first
+
+Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
+EOF
+
+# Expected commit message after rebase without --signoff (or with --no-signoff)
+cat >expected-unsigned <<EOF
+first
+EOF
+
+
+# We configure an alias to do the rebase --signoff so that
+# on the next subtest we can show that --no-signoff overrides the alias
+test_expect_success 'rebase --signoff adds a sign-off line' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	git add file && git commit -m first &&
+	git config alias.rbs "rebase --signoff" &&
+	git rbs HEAD^ &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	test_cmp expected-signed actual
+'
+
+test_expect_success 'rebase --no-signoff does not add a sign-off line' '
+	git commit --amend -m "first" &&
+	git rbs --no-signoff HEAD^ &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	test_cmp expected-unsigned actual
+'
+
+test_done
-- 
2.12.2.765.g2bf946761b

