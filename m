Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DD920357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932329AbdGJORz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:17:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35213 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbdGJORy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:17:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so12912854pgc.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cu85KT4VJGvcUdYeaENgqvY78qjCyEzmgOi9U9cmPUg=;
        b=Y7nUI7WatbBqBrGxfEHYDtOL6eTba/RXX/9bZ3nINBbUoxaoUveP2+dhfV+6Zi8waO
         XDsnSsgby51MducYrNi4ZVJdd55kjb8BX4+Q9mtZmrcKEGQeQm96R7JmCpamAO7crCUj
         VdGcpU9PUm51X0YXT/kK9pjx+a+3tPpL1DowPksRjPciFzaNJaFzRnbzwZ2jLyCgsuim
         icopmSQsMJ2sJipS/sxO/a2C2CHZ8C/eQKrn5ybc+DqJWSnkoC6yFnBe5VE/Az+eyOVR
         F22v0pPP1Xbxc40r01itVQXydzujYqR3S946ARyMHYc/CCNNrlQfuG1cDgOn3gA3OlX2
         bnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cu85KT4VJGvcUdYeaENgqvY78qjCyEzmgOi9U9cmPUg=;
        b=YhcZUTUedaP2sWMIFCJfUVvirguripwDekjP7IxEZcruYQYMQbviiU07tqXJJjb+Qm
         9ypLLsS1y+OmmzhZpzkby2OskM20GQC87zL1e71b34n/ESQZO4I0tJG1NSjQB6Ape265
         4V6eaQPJRccoLwkjTf3XqNJ0gYMHKlPhk8oj5vNrk/XOVvIK5OgtGi4rRoRp3W5BpSqo
         E79WEeyGxF1HGaaQqeYTl9b9Ty4R8QQF1oU+RHx1BzNK6DjxUUAT0uG2cXheZRTJ/Ci7
         UaFvsKFW5ncKIWDW9yuboHoVCkUytx81gz75KoncCEhYCFqgpmx2qHMEoAcGeegM8zsY
         hQlw==
X-Gm-Message-State: AIVw110F+M4vMKEBlJo7HgaGOFonrSj15Trb04oRbYWa0vZVPiqdi8ui
        b5s0WHTQ3Lquvw==
X-Received: by 10.99.38.69 with SMTP id m66mr14859524pgm.72.1499696273780;
        Mon, 10 Jul 2017 07:17:53 -0700 (PDT)
Received: from localhost.localdomain ([117.209.158.50])
        by smtp.gmail.com with ESMTPSA id t78sm25469923pfa.48.2017.07.10.07.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 07:17:53 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 1/4] hook: cleanup script
Date:   Mon, 10 Jul 2017 19:47:41 +0530
Message-Id: <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
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

Further remove the relevant comments from the sample script
and update the documentation.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/githooks.txt                 |  3 ---
 templates/hooks--prepare-commit-msg.sample | 20 ++++++++------------
 2 files changed, 8 insertions(+), 15 deletions(-)

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
index 86b8f227e..b8ba335cf 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -9,8 +9,7 @@
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 
-# This hook includes three examples.  The first comments out the
-# "Conflicts:" part of a merge commit.
+# This hook includes three examples.
 #
 # The second includes the output of "git diff --name-status -r"
 # into the message, just before the "git status" output.  It is
@@ -20,17 +19,14 @@
 # The third example adds a Signed-off-by line to the message, that can
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

