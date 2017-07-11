Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A11202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 14:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbdGKOLZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 10:11:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35612 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755627AbdGKOLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 10:11:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so83971pfq.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OEFsHj+87pX/OglN59pVelbz4t3EEM5MY29VsymPS94=;
        b=vZKV75OPkerwibu5UDtidHlyMOGk6AdEyHgi2mUcxAuP/pOny28BWhmG1BUeI0/ZKg
         EHhVRLkdwUnwykaA2TvD4KhsV1KM8eov6r4nswbhhdPK1Y57UwXskLzHrz45VZNMPd0G
         s1iTZUq257zLogZgSJrGzLnoSd8HeJ004S023a2/81BF1UMuRBN4xYYtpN8S+rN0qSzB
         lCZBR+aVNYgW1dVQ3NJMjJtgw1Zki7QVNRsQKgFPmsvOb8MAvdbsNonQONQ0srAZtKWO
         oGbeTrXTgxTmlEGHwnrbYrnke/N5q5GUeZqIwSCBxj7uOa05OED5et09+jobzcb0cz3d
         pZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OEFsHj+87pX/OglN59pVelbz4t3EEM5MY29VsymPS94=;
        b=fboH151LzUv+R1uhehEKLnGBJypjtapq+9iNHJpS21/vagwVsley0RCT1mWF56ZcsE
         BTDglrAS0dVtT9t9SSHfmgFTlFbZXwx318LIqxogI7rrRfkOfYRAF7OU52WE8zLmgoPh
         FiPfcmzx9goshUWhEm8BdPMCc7PxOzABIroD+Z5dtVk42oDlSiAza22lg/hxSaKm8sLb
         iIwIAYiYK0L2YS4PZYVqbl4/NfMLAPIWz8BIWoGc/E3Pl+lmMJr+3ATQMrdmWsXzh5g2
         lVaLrSbOHYuEFykyz/5ODDrKjU2DLDGo44nWWba5pt+DHU4bLAd1lOkIJsqM1D0vSUQ+
         7jsQ==
X-Gm-Message-State: AIVw112r1YkkdrneL64qpvMmoaqkKZB/iPJcERrREN81wsCiir0HwUFv
        Sq/gkLfA/fVMpg==
X-Received: by 10.99.98.193 with SMTP id w184mr86177pgb.155.1499782283802;
        Tue, 11 Jul 2017 07:11:23 -0700 (PDT)
Received: from localhost.localdomain ([117.249.129.113])
        by smtp.gmail.com with ESMTPSA id i19sm98579pfj.78.2017.07.11.07.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 07:11:23 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 1/4] hook: cleanup script
Date:   Tue, 11 Jul 2017 19:41:08 +0530
Message-Id: <20170711141111.7538-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <xmqqfue45asd.fsf@gitster.mtv.corp.google.com>
References: <xmqqfue45asd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prepare the 'preare-commit-msg' sample script for
upcoming changes. Preparation includes removal of
an example that has outlived it's purpose. The example
is the one that comments the "Conflicts:" part of a
merge commit message. It isn't relevant anymore as
it's done by default since 261f315b ("merge & sequencer:
turn "Conflicts:" hint into a comment", 2014-08-28).

Further update the relevant comments from the sample script
and update the documentation.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/githooks.txt                 |  3 ---
 templates/hooks--prepare-commit-msg.sample | 24 ++++++++++--------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 706091a56..fdc01aa25 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -121,9 +121,6 @@ it is not suppressed by the `--no-verify` option.  A non-zero exit
 means a failure of the hook and aborts the commit.  It should not
 be used as replacement for pre-commit hook.
 
-The sample `prepare-commit-msg` hook that comes with Git comments
-out the `Conflicts:` part of a merge's commit message.
-
 commit-msg
 ~~~~~~~~~~
 
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f227e..279ddc1a7 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -9,28 +9,24 @@
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 
-# This hook includes three examples.  The first comments out the
-# "Conflicts:" part of a merge commit.
+# This hook includes two examples.
 #
-# The second includes the output of "git diff --name-status -r"
+# The first includes the output of "git diff --name-status -r"
 # into the message, just before the "git status" output.  It is
 # commented because it doesn't cope with --amend or with squashed
 # commits.
 #
-# The third example adds a Signed-off-by line to the message, that can
+# The second example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-case "$2,$3" in
-  merge,)
-    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
 
-# ,|template,)
-#   @PERL_PATH@ -i.bak -pe '
-#      print "\n" . `git diff --cached --name-status -r`
-#	 if /^#/ && $first++ == 0' "$1" ;;
-
-  *) ;;
-esac
+# case "$2,$3" in
+#  ,|template,)
+#    @PERL_PATH@ -i.bak -pe '
+#       print "\n" . `git diff --cached --name-status -r`
+# 	 if /^#/ && $first++ == 0' "$1" ;;
+#  *) ;;
+# esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
-- 
2.13.2.957.g457671ade

