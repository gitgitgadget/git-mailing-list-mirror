Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712181F4B6
	for <e@80x24.org>; Sun, 30 Jun 2019 05:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfF3FSb (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 01:18:31 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39337 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3FSb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 01:18:31 -0400
Received: by mail-ua1-f68.google.com with SMTP id j8so3771424uan.6
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 22:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9BiO06fnvmuxjtUt0B4BRyoYJsFI3lY3XLTfl2OvJgY=;
        b=DrFnYURJ1PGFOkrtdZRSxxUko5EtRejmh0Vu2okCnytHhxcQ7u+6lsXJ4fAAb9nuOe
         pttkbvpfS1qIWF7/8Q+D+p4gmYRjkJqbOaMS3k+hr8QURRMb9O3wutFnJ5cT5ThG2ZET
         oPL3bPRR6Uz/63u3fHmFGoH2FMcJBfxZL0zElVFFz2rrA7InLJLjVC2yNIn/CDnUUl80
         lxyrmuXODQtd0FLKLO6oJPcPkXvHnqJZvGmGflDyasCNO7gxpj3GO+YDvUTxFW7rc2ol
         +LreBYOFGrtDwKvGPxdoXNzY7uVax2rXGQ2rXJvue12HTz7qfet21VKx6t+aOABOB+Ck
         HisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9BiO06fnvmuxjtUt0B4BRyoYJsFI3lY3XLTfl2OvJgY=;
        b=KlwmIn736O4jO1Uk5eQTO0iOfp2sxvm+pY2VYD5qXRoJlX59nXsxjZFw8WQwEyP2WQ
         p72eVm3DeNyU9e7UkAIe/1PvxE9ARHiUPP8TFavqHIHN0vDz7nsUTj9oGisADfxLthNs
         fSghafYV1G5ASIeLGt1PnM/UVvpuqlj36rCBWQc13CzCYeGyPuyYtOE8dCcw+5Eib64V
         GTY8cM28rlDB3Ebe9PBwnxhDtmfbQblONrwTGYcSluNtlu2NqlDkysYgNZxMTx7Q5byU
         iaL8YKB746z87+kKN6hi6CDTgO/i8jRGD3pvBhpWykG26wlluK1Ou0NHUFOGedzj/cmw
         7znw==
X-Gm-Message-State: APjAAAUDZtBlTLaaE6J7SuVvwpkYJjMCcccz1OTKaw8xgwTmaFgHi+JL
        HWB4jG1SU/hE+ROS2Gr6b4fSs1mH
X-Google-Smtp-Source: APXvYqwB0kIw7niA7L5VR/ksv3V5m6LdBkH73XYV8YlJWMu3mD+OK+vhvSdkhBoQF7IPmhBm4oohOQ==
X-Received: by 2002:ab0:7252:: with SMTP id d18mr10890600uap.23.1561871909513;
        Sat, 29 Jun 2019 22:18:29 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.195.224])
        by smtp.gmail.com with ESMTPSA id y71sm1416568vsc.19.2019.06.29.22.18.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:18:28 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
Date:   Sat, 29 Jun 2019 23:18:15 -0600
Message-Id: <20190630051816.8814-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.22.0.216.gf74291ffb7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rebuash allows us to do squash/rebase without having to resort
to use rebase.

Consider the case where we have feature branches with merges in history:

Rx: revisions in main branch
Fx: Revisions in feature branch
Mx: Merge revisions (some of them with conflicts)

------------
	R1---R2---R3---R4---R5---R6---R7
	 \         \              \
	  F1---F2---M1---F3---F4---M2---F5
------------

If on M1 there were conflicts, it's more than likely that if we tried to
cherry-pick R1..F2 on top of R7, we will have to deal with a conflict. But that
conflict has already been taken care of on M1. So, in order to leverage that
work that has already been done, instead of looking back, we look forward.

First, we create a (temporary) merge commit of both branches (M3)

------------
	R1---R2---R3---R4---R5---R6---R7---M3
	 \         \              \       /
	  F1---F2---M1---F3---F4---M2---F5
------------

At this point, all differences between M3 and R7 are the changes related to the
feature branch, so we can run git reset --soft from M3 to R7 to put all those
differeces in index, and then we create single revision that is both
squashed/rebased for our feature branch.
---
 .gitignore                    |   1 +
 Documentation/git-rebuash.txt |  76 ++++++++
 Makefile                      |   1 +
 command-list.txt              |   1 +
 git-rebuash.sh                | 324 ++++++++++++++++++++++++++++++++++
 5 files changed, 403 insertions(+)
 create mode 100644 Documentation/git-rebuash.txt
 create mode 100644 git-rebuash.sh

diff --git a/.gitignore b/.gitignore
index 4470d7cfc0..46b5c94c8f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -123,6 +123,7 @@
 /git-read-tree
 /git-rebase
 /git-rebase--preserve-merges
+/git-rebuash
 /git-receive-pack
 /git-reflog
 /git-remote
diff --git a/Documentation/git-rebuash.txt b/Documentation/git-rebuash.txt
new file mode 100644
index 0000000000..721da64010
--- /dev/null
+++ b/Documentation/git-rebuash.txt
@@ -0,0 +1,76 @@
+git-rebuash(1)
+=============
+
+NAME
+----
+git-rebuash - Squash/Rebase in a single shot
+
+
+SYNOPSIS
+--------
+[verse]
+'git rebuash' [-m <msg>] [ -u <upstream> ]
+'git rebuash' --continue
+'git rebuash' --abort
+
+DESCRIPTION
+-----------
+Rebuash allows us to do squash/rebase without having to resort
+to use rebase.
+
+Consider the case where we have feature branches with merges in history:
+
+Rx: revisions in main branch
+Fx: Revisions in feature branch
+Mx: Merge revisions (some of them with conflicts)
+
+------------
+	R1---R2---R3---R4---R5---R6---R7
+	 \         \              \
+	  F1---F2---M1---F3---F4---M2---F5
+------------
+
+If on M1 there were conflicts, it's more than likely that if we tried to
+cherry-pick R1..F2 on top of R7, we will have to deal with a conflict. But that
+conflict has already been taken care of on M1. So, in order to leverage that
+work that has already been done, instead of looking back, we look forward.
+
+First, we create a (temporary) merge commit of both branches (M3)
+
+------------
+	R1---R2---R3---R4---R5---R6---R7---M3
+	 \         \              \       /
+	  F1---F2---M1---F3---F4---M2---F5
+------------
+
+At this point, all differences between M3 and R7 are the changes related to the
+feature branch, so we can run git reset --soft from M3 to R7 to put all those
+differeces in index, and then we create single revision that is both
+squashed/rebased for our feature branch.
+
+git rebuash will take care of all the details, even figuring out
+what the upstream branch is if it is not provided.
+
+git checkout feature1
+git rebuash -u upstream-branch -m "Feature 1 in a single revision"
+
+
+OPTIONS
+-------
+
+-m <msg>::
+	Set the commit message to be used for the merge commit
+
+-u <upstream>::
+	Set the upstream branch. If it is not provided, the upstream branch
+	from the currently checked out branch will be used.
+
+--abort::
+	Abort the current rebuash process and go back
+	to the original state before starting rebuash
+
+--continue::
+	If rebuash stopped (due to a conflict of an empty commit message),
+	allow the process to go on after solving the current issue that made it
+	stop.
+
diff --git a/Makefile b/Makefile
index f58bf14c7b..c2869d7c11 100644
--- a/Makefile
+++ b/Makefile
@@ -614,6 +614,7 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-legacy-stash.sh
+SCRIPT_SH += git-rebuash.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
diff --git a/command-list.txt b/command-list.txt
index 3a9af104b5..cf1cb48fde 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -143,6 +143,7 @@ git-quiltimport                         foreignscminterface
 git-range-diff                          mainporcelain
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain           history
+git-rebuash                             mainporcelain           history
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators           complete
 git-remote                              ancillarymanipulators           complete
diff --git a/git-rebuash.sh b/git-rebuash.sh
new file mode 100644
index 0000000000..93c14cb9cc
--- /dev/null
+++ b/git-rebuash.sh
@@ -0,0 +1,324 @@
+#!/bin/bash
+# Copyright 2019 Edmundo Carmona Antoranz
+
+# Released under the terms of GPLv2
+
+# Rebuash will be used mainly when you want to squash and rebase
+# so that you don't have to go through the ordeal of rebasing
+# which would potencially bring conflicts that you would
+# rather avoid it at all possible.
+
+# rebuash takes a different strategy by merging with the target (upstream) branch
+# then resetting --soft onto the target branch to finish off with a new
+# revision
+
+# Valid options:
+# -u upstream branch (if it's not specified, it will be retrieved from current branch)
+# -m comment for the final revision (can be multiline)
+# --abort if the user wants to abort the rebuash operation
+# --continue if there was a previous conflict and the user wants to continue with the current rebuash operation
+
+UPSTREAM="" # upstream branch (will be retrieved from current branch if it is not provided)
+HEAD="" # the point where we started rebuash from (revision or branch, for messaging)
+HEAD_REV="" # point where we started the operation from (the revision)
+STEP="" # will be used when we need to continue to know in which step we are at the moment
+COMMENT="" # comment to be used on the final revision (might be empty)
+
+# actions
+START=true
+CONTINUE=false
+ABORT=false
+
+. git-sh-setup
+
+STATE_FILE="$GIT_DIR"/REBUASH_STATE
+
+function report_bug {
+    echo "You just hit a bug in git-rebuash"
+    echo "BUG: $1"
+    echo "Please, report this problem to the git mailing list and cc eantoranz at gmail.com"
+    exit 1
+}
+
+function save_state {
+    echo "UPSTREAM: $UPSTREAM" > "$STATE_FILE"
+    echo "HEAD: $HEAD" >> "$STATE_FILE"
+    echo "HEAD_REV: $HEAD_REV" >> "$STATE_FILE"
+    echo "STEP: $STEP" >> "$STATE_FILE"
+    echo "" >> "$STATE_FILE" # an empty line
+    echo "$COMMENT" >> "$STATE_FILE"
+}
+
+function read_state {
+    # read the content of state file and put it into the variables
+    if [ ! -f "$STATE_FILE" ]
+    then
+        echo Unexpected Error: Rebuash state file was expected to exist.
+        echo Aborting operation.
+        echo Please, notify the git mail list and explain them what the situation was
+        echo so that this bug can be taken care of.
+        exit 1
+    fi
+    UPSTREAM=$( head -n 1 "$STATE_FILE" | sed 's/UPSTREAM: //' )
+    HEAD=$( head -n 2 "$STATE_FILE" | tail -n 1 | sed 's/HEAD: //' )
+    HEAD_REV=$( head -n 3 "$STATE_FILE" | tail -n 1 | sed 's/HEAD_REV: //' )
+    STEP=$( head -n 4 "$STATE_FILE" | tail -n 1 | sed 's/STEP: //' )
+    # there is an empty line
+    COMMENT=$( tail -n +6 "$STATE_FILE" )
+}
+
+function remove_state {
+    if [ -f "$STATE_FILE" ]
+    then
+        rm -f "$STATE_FILE"
+    fi
+}
+
+function check_status {
+    if [ $CONTINUE == true ]
+    then
+        if [ $ABORT == true ]
+        then
+            echo Can\'t use --abort and --continue at the same time
+            exit 1
+        fi
+
+        # there has to be an state file
+        if [ ! -f "$STATE_FILE" ]
+        then
+            echo There\'s no rebuash session currently going on. Can\'t continue.
+            exit 1
+        fi
+    elif [ $ABORT == true ]
+    then
+        if [ ! -f "$STATE_FILE" ]
+        then
+            echo There\'s no rebuash session currently going on. Can\'t abort.
+            exit 1
+        fi
+    else
+        if [ $START != true ]
+        then
+            report_bug "START is set to false even though we were not aborting or continuing"
+        fi
+
+        if [ "$UPSTREAM" == "" ]
+        then
+            # as a fallback, try to get upstream from current branch
+            UPSTREAM=$( git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null )
+            if [ "$UPSTREAM" == "" ]
+            then
+                echo "Could not find out upstream branch. Please provide it with -u"
+                exit 1
+            else
+                echo Using $UPSTREAM as the upstream branch
+            fi
+        fi
+
+        # starting execution
+        # there must _not_ be anything going on
+        status=$( git status --short --untracked-files=no )
+        if [ "$status" != "" ]
+        then
+            echo Status is not clean before rebuashing.
+            echo Make sure to clean up your working tree before starting rebuash
+            exit 1
+        fi
+    fi
+}
+
+# Parse arguments
+function parse_options {
+
+    while true
+    do
+        value=$1
+        shift
+        if [ $? -ne 0 ]
+        then
+            # no more parameters
+            break
+        fi
+
+        if [ "$value" == "-u" ]
+        then
+            # user wants to specify the upstream branch
+            UPSTREAM="$1"
+            shift
+        elif [ "$value" == "-m" ]
+        then
+            # user wants to set up the comment for the commit
+            COMMENT="$1"
+            shift
+        elif [ "$value" == "--continue" ]
+        then
+            # user wants to resume execution
+            CONTINUE=true
+            START=false
+        elif [ "$value" == "--abort" ]
+        then
+            ABORT=true
+            START=false
+        fi
+    done
+}
+
+# Start execution of rebuash
+function start_rebuash {
+
+    # there must not exist a previous state file
+    if [ -f "$STATE_FILE" ]
+    then
+        echo You are in the middle of a previous rebuash execution
+        echo If that is not the case, remove the file "$STATE_FILE"
+        echo and also feel free to file a report with int git mail list
+        exit 1
+    fi
+
+    git show "$UPSTREAM" &> /dev/null
+    if [ $? -ne 0 ]
+    then
+        echo "Provided upstream ($UPSTREAM) does not exist"
+        exit 1
+    fi
+
+    # persist execution information
+    HEAD=$( git rev-parse --abbrev-ref --symbolic-full-name @ 2> /dev/null )
+    HEAD_REV=$( git show --quiet --pretty="%H" )
+    save_state
+
+    # start doing our magic
+    echo "Merging with upstream branch ($UPSTREAM)"
+    git merge --no-ff --no-commit "$UPSTREAM" 2> /dev/null
+
+    # we let the process move forward as if we are continuing
+    STEP=MERGE
+    save_state # continue_rebuash will read the state from file
+    CONTINUE=true
+    return
+
+}
+
+function continue_rebuash {
+    read_state
+    if [ "$STEP" == "" ]
+    then
+        report_bug "Bug: Can't determine in what step we are in order to do --continue."
+    fi
+
+    if [ "$STEP" == "MERGE" ]
+    then
+        git -c core.editor=/bin/true merge --continue &> /dev/null # do not open editor, use previous comment
+
+        if [ $? -ne 0 ]
+        then
+            save_state # just in case we add more _previous_ STEPS later on
+            echo "There are unmerged paths to take care of (or tracked and pending to be added to index)"
+            echo Check with git status
+            echo "Finish them (_DO NOT_ commit nor run git merge --continue). Then run:"
+            echo
+            echo git rebuash --continue
+            echo
+            echo You can also run git rebuash --abort if you would like to stop the whole process
+            echo and go back to where you were before rebuashing
+            exit 1
+        fi
+        STEP=RESET
+    fi
+
+    if [ "$STEP" == "RESET" ]
+    then
+        # move branch pointer to UPSTREAM
+        git reset --soft "$UPSTREAM"
+
+        # merge/reset went fine so we set the STEP to COMMIT
+        STEP=COMMIT
+    fi
+
+    if [ "$STEP" == "COMMIT" ]
+    then
+        # create new revision
+        if [ "$COMMENT" == "" ]
+        then
+            # no comment was provided
+            # what was checked out when we started?
+            if [ "$HEAD" == "HEAD" ]
+            then
+                # was working on detached head
+                TEMP_COMMENT="Rebuashing $HEAD_REV on top of $UPSTREAM"
+            else
+                TEMP_COMMENT="Rebuashing $HEAD on top of $UPSTREAM"
+            fi
+            git commit -m "$TEMP_COMMENT" --edit
+        else
+            git commit -m "$COMMENT"
+        fi
+
+        if [ $? -ne 0 ]
+        then
+            # there was some error while committing
+            save_state
+
+            echo There was an error while committing.
+            echo Aborting rebuash operation.
+            echo When you are ready to finish, run:
+            echo git rebuash --continue
+            exit 1
+        fi
+        STEP=END # just in case
+    fi
+
+    # everything went fine
+    remove_state
+    echo Rebuash operation was successful.
+    exit 0
+}
+
+function abort_rebuash {
+    # take it back to the original state
+    # make sure there was an state to start from
+    read_state
+
+    # most cases, we are in the middle of the merge operation
+    if [ "$STEP" == "" ]
+    then
+        echo Bug: Could not figure out the step we are in.
+        echo Please, report this problem to the git mail list
+        exit 1
+    fi
+    if [ "$STEP" == "MERGE" ]
+    then
+        # can ask to abort merge and we go back to where we were when we started
+        git merge --abort &> /dev/null
+    elif [ "$STEP" == "COMMIT" ]
+    then
+        # need to got back to where we were before
+        git reset --hard "$HEAD_REV" &> /dev/null
+    else
+        report_bug "Unknown step ($STEP)"
+    fi
+
+    remove_state
+
+    echo Rebuash was successfully aborted
+    exit 0
+}
+
+parse_options "$@"
+
+check_status
+
+if [ $START == true ]
+then
+    start_rebuash
+fi
+
+if [ $CONTINUE == true ]
+then
+    continue_rebuash
+fi
+
+if [ $ABORT == true ]
+then
+    abort_rebuash
+fi
-- 
2.20.1

