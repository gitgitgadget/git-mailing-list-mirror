Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826172070F
	for <e@80x24.org>; Thu, 15 Sep 2016 21:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbcIOVRg (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 17:17:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35141 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbcIOVRe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 17:17:34 -0400
Received: by mail-it0-f68.google.com with SMTP id e20so181324itc.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k8dA9nFSoBcibTjeVYv9CJCGkWLiyAUrcvxzqxoB8SE=;
        b=K7/qvqnw6VB5utUhPNcdAv8nqo3IIpKI49hzYxFRs7haEsKr66LEEc8j1Z59lYejzc
         Tmi0oUlJLfYBWNqT2FIzmh7Pacayd+DSB6eDiG8QDXYbxKGmvA0DvIIKAWag2j64pmRV
         PTZC+4oiuLCQJ2LwpoyQIJPEF7Xi6cC1MTu3zhIu09et9dhQ7JO5SO7h2tRyptm86QYo
         NUvseRkCCaJ6qhrJo1+5R/qQCHUcNT5TKwBqzjLNm4e75+equ03AgmmJwsa1qqYfchaV
         oVbSUaknRtYhtRDdLVrIyNjueQObcFuGC47SHoRdyB+kREOkWyYOaqfzTLkrne/+F3CV
         rBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k8dA9nFSoBcibTjeVYv9CJCGkWLiyAUrcvxzqxoB8SE=;
        b=I+CxtEZW1WbdLGDSYuArCmGiTG1OXawcY4pSOcs6PyDus8hUR5rRiSpommQFZEVqeq
         g8qfnmP/kVC3KZcYrkN8STbWL/thoSiGgP32elFV+RxrJ9UH6e5qL9pyOE1VdVGqpXrd
         UNrSElDYiHvDvZeqyr85fBt2IHdq6K16J3T/17lJHBi1ZF/BzV26FVI5YcukPy+GyK85
         f4MwgxyeoQsPmBfRAm2nL0Xzz+QkaQuogP4F+1iH/tpaQFf3GB1FwIuzWwbUxndqWOFt
         7eGsoXgAo/GEoHskCueTBTBGbr8OjTIuN6Ucn1NMoZvPs54gPHO3vkZFWYqOpZkYcyay
         Tdqg==
X-Gm-Message-State: AE9vXwNiufnpEq2jdngf82+R3U1PE0Huzfq5+cf2aKzXLcI7tf/gWKDvYzOvcDMzVTO4ew==
X-Received: by 10.36.123.199 with SMTP id q190mr1848043itc.46.1473974252959;
        Thu, 15 Sep 2016 14:17:32 -0700 (PDT)
Received: from CHIC02QV065G8WN.sea.corp.expecn.com.sea.corp.expecn.com ([172.56.12.80])
        by smtp.gmail.com with ESMTPSA id 103sm2418177ioi.29.2016.09.15.14.17.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 14:17:32 -0700 (PDT)
From:   Ori Rawlings <orirawlings@gmail.com>
To:     git@vger.kernel.org
Cc:     Vitor Antunes <vitor.hda@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>,
        Ori Rawlings <orirawlings@gmail.com>
Subject: [PATCH v2 1/1] git-p4: Add --checkpoint-period option to sync/clone
Date:   Thu, 15 Sep 2016 16:17:18 -0500
Message-Id: <728dfb8e2bf4aa9f6297eada7b8e8a107fd382e6.1473973732.git-series.orirawlings@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <cover.9c54bbdd9f054215b5432c4ba3081110e2e91724.1473973732.git-series.orirawlings@gmail.com>
References: <cover.9c54bbdd9f054215b5432c4ba3081110e2e91724.1473973732.git-series.orirawlings@gmail.com>
In-Reply-To: <cover.9c54bbdd9f054215b5432c4ba3081110e2e91724.1473973732.git-series.orirawlings@gmail.com>
References: <cover.9c54bbdd9f054215b5432c4ba3081110e2e91724.1473973732.git-series.orirawlings@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Importing a long history from Perforce into git using the git-p4 tool
can be especially challenging. The `git p4 clone` operation is based
on an all-or-nothing transactionality guarantee. Under real-world
conditions like network unreliability or a busy Perforce server,
`git p4 clone` and  `git p4 sync` operations can easily fail, forcing a
user to restart the import process from the beginning. The longer the
history being imported, the more likely a fault occurs during the
process. Long enough imports thus become statistically unlikely to ever
succeed.

The underlying git fast-import protocol supports an explicit checkpoint
command. The idea here is to optionally allow the user to force an
explicit checkpoint every <x> seconds. If the sync/clone operation fails
branches are left updated at the appropriate commit available during the
latest checkpoint. This allows a user to resume importing Perforce
history while only having to repeat at most approximately <x> seconds
worth of import activity.

Signed-off-by: Ori Rawlings <orirawlings@gmail.com>
---
 Documentation/git-p4.txt            | 12 ++++++-
 git-p4.py                           |  7 ++++-
 t/t9830-git-p4-checkpoint-period.sh | 59 ++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100755 t/t9830-git-p4-checkpoint-period.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index c83aaf3..e48ed6d 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -252,6 +252,18 @@ Git repository:
 	Use a client spec to find the list of interesting files in p4.
 	See the "CLIENT SPEC" section below.
 
+--checkpoint-period <n>::
+	Issue explicit 'checkpoint' commands to the underlying
+	linkgit:git-fast-import[1] approximately every 'n' seconds. If
+	syncing or cloning from the Perforce server is interrupted, the
+	process can be resumed from the most recent checkpoint with a
+	new 'sync' invocation. This is useful in the situations where a
+	large amount of changes are being imported over an unreliable
+	network connection. Explicit checkpoints can take up to several
+	minutes each, so a suitable value for the checkpoint period is
+	approximately 1200 seconds. By default, no explicit checkpoints 
+	are performed.
+
 -/ <path>::
 	Exclude selected depot paths when cloning or syncing.
 
diff --git a/git-p4.py b/git-p4.py
index fd5ca52..4c84871 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2244,6 +2244,7 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("-/", dest="cloneExclude",
                                      action="append", type="string",
                                      help="exclude depot path"),
+                optparse.make_option("--checkpoint-period", dest="checkpointPeriod", type="int", help="Period in seconds between explict git fast-import checkpoints (by default, no explicit checkpoints are performed)"),
         ]
         self.description = """Imports from Perforce into a git repository.\n
     example:
@@ -2276,6 +2277,7 @@ class P4Sync(Command, P4UserMap):
         self.tempBranches = []
         self.tempBranchLocation = "refs/git-p4-tmp"
         self.largeFileSystem = None
+        self.checkpointPeriod = None
 
         if gitConfig('git-p4.largeFileSystem'):
             largeFileSystemConstructor = globals()[gitConfig('git-p4.largeFileSystem')]
@@ -3031,6 +3033,7 @@ class P4Sync(Command, P4UserMap):
 
     def importChanges(self, changes):
         cnt = 1
+        self.lastCheckpointTime = time.time()
         for change in changes:
             description = p4_describe(change)
             self.updateOptionDict(description)
@@ -3107,6 +3110,10 @@ class P4Sync(Command, P4UserMap):
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
                     self.initialParent = ""
+
+                    if self.checkpointPeriod >= 0 and time.time() - self.lastCheckpointTime >= self.checkpointPeriod:
+                        self.checkpoint()
+                        self.lastCheckpointTime = time.time()
             except IOError:
                 print self.gitError.read()
                 sys.exit(1)
diff --git a/t/t9830-git-p4-checkpoint-period.sh b/t/t9830-git-p4-checkpoint-period.sh
new file mode 100755
index 0000000..6ba4914
--- /dev/null
+++ b/t/t9830-git-p4-checkpoint-period.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='git p4 checkpoint-period tests'
+
+. ./lib-git-p4.sh
+
+p4_submit_each () {
+	for file in $@
+	do
+		echo $file > "$file" &&
+		p4 add "$file" &&
+		p4 submit -d "$file"
+	done
+}
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'no explicit checkpoints' '
+	cd "$cli" &&
+	p4_submit_each file1 file2 file3 &&
+	git p4 clone --dest="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		git -C "$git" reflog refs/remotes/p4/master >lines &&
+		test_line_count = 1 lines &&
+		p4_submit_each file4 file5 file6 &&
+		git -C "$git" p4 sync &&
+		git -C "$git" reflog refs/remotes/p4/master >lines &&
+		test_line_count = 2 lines
+	)
+'
+
+test_expect_success 'restart p4d' '
+	kill_p4d &&
+	start_p4d
+'
+
+test_expect_success 'checkpoint every 0 seconds, i.e. every commit' '
+	cd "$cli" &&
+	p4_submit_each file1 file2 file3 &&
+	git p4 clone --dest="$git" --checkpoint-period 0 //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		git -C "$git" reflog refs/remotes/p4/master >lines &&
+		test_line_count = 3 lines &&
+		p4_submit_each file4 file5 file6 &&
+		git -C "$git" p4 sync --checkpoint-period 0 &&
+		git -C "$git" reflog refs/remotes/p4/master >lines &&
+		test_line_count = 6 lines
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
git-series 0.8.10
