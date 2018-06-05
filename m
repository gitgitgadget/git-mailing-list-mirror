Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FF11F403
	for <e@80x24.org>; Tue,  5 Jun 2018 08:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeFEI3L (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 04:29:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45639 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeFEI3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 04:29:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so1376655wrm.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AlEG1JYEXUKHreyx4mc10QnnaeYRUeunjezGJf7uBb8=;
        b=eRwnfl8vJX97hTOf62O6WEfU6cWG5WC1yy7UIJn1akSrSTAQFYuXgnzel2bOuZwRUh
         qN/WT6p172tKelxgCCZ+PbjgIEgdzXiChCo955wOlUWv/EXKeQFDX47j7bUtcy+scLTA
         I9of24jWKJ2B0TKAtjaJ/HRBnwO9ldG6JNOCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AlEG1JYEXUKHreyx4mc10QnnaeYRUeunjezGJf7uBb8=;
        b=orUqspthJL6rimHaN0Yk7gg74DCxoC2lB4p6KWGS2bs8GL+4BkTxJUwjMb5NM2heD9
         JigPQF88q7zFV7RLRzfqRpolvpQu/inBl6oa6lZDOiKIl30lrdfD3r0bIY8HYtG7v/pO
         0GIwjFwn2BMOKcrIMQjCtfwS78oLC7BWuT7gOCltnzWZAo69qv5itIk+cY5gfa7IINAe
         gfBwfUf1kHirV46Afu4vvHucG4jB4sjyMVln4+x3Hd+skjZAYo3rxW/Gby5r7vjpTFpL
         IcQS8B5ih1TJu1J1maprXHKlZi3Tb/u8GoHImBbsVYvFUKQfU+8WbKnuxrnEQtRRFGOD
         f+Bg==
X-Gm-Message-State: ALKqPwf1ZJ3q9jzHwdMHyTa4EnKoMoe82gmJS+/YJ0AyU5IUlIRbGk06
        rScCPZqnk7A7/lj/jqVQU3wn18Lo
X-Google-Smtp-Source: ADUXVKJ52JdC3yGKK3Ub6WXjp9U2bTBYvzt+LzV1zA3cinqg4qVpJ+sYHz0kl+iOBTIEF8y/+GHnBg==
X-Received: by 2002:adf:86ae:: with SMTP id 43-v6mr14314481wrx.281.1528187345035;
        Tue, 05 Jun 2018 01:29:05 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id u3-v6sm25988533wrm.60.2018.06.05.01.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 01:29:04 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/2] git-p4: add option to disable syncing of p4/master with p4
Date:   Tue,  5 Jun 2018 09:28:54 +0100
Message-Id: <20180605082854.17090-3-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180605082854.17090-1-luke@diamand.org>
References: <20180605082854.17090-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option to the git-p4 submit command to disable syncing
with Perforce.

This is useful for the case where a git-p4 mirror has been setup
on a server somewhere, running from (e.g.) cron, and developers
then clone from this. Having the local cloned copy also sync
from Perforce just isn't useful.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt |  8 ++++++++
 git-p4.py                | 31 ++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3d83842e47..8f6a7543fd 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -369,6 +369,11 @@ These options can be used to modify 'git p4 submit' behavior.
     Disable the automatic rebase after all commits have been successfully
     submitted. Can also be set with git-p4.disableRebase.
 
+--disable-p4sync::
+    Disable the automatic sync of p4/master from Perforce after commit have
+    been submitted. Implies --disable-rebase. Can also be set with
+    git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
@@ -693,6 +698,9 @@ git-p4.conflict::
 git-p4.disableRebase::
     Do not rebase the tree against p4/master following a submit.
 
+git-p4.disableP4Sync::
+    Do not sync p4/master with Perforce following a submit. Implies git-p4.disableRebase.
+
 IMPLEMENTATION DETAILS
 ----------------------
 * Changesets from p4 are imported using Git fast-import.
diff --git a/git-p4.py b/git-p4.py
index 5ab9421af8..b9e79f1d8b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1368,7 +1368,9 @@ def __init__(self):
                                      help="submit only the specified commit(s), one commit or xxx..xxx"),
                 optparse.make_option("--disable-rebase", dest="disable_rebase", action="store_true",
                                      help="Disable rebase after submit is completed. Can be useful if you "
-                                     "work from a local git branch that is not master")
+                                     "work from a local git branch that is not master"),
+                optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
+                                     help="Skip perforce sync of p4/master after submit or shelve"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -1380,6 +1382,7 @@ def __init__(self):
         self.update_shelve = list()
         self.commit = ""
         self.disable_rebase = gitConfigBool("git-p4.disableRebase")
+        self.disable_p4sync = gitConfigBool("git-p4.disableP4Sync")
         self.prepare_p4_only = False
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
@@ -2240,11 +2243,14 @@ def run(self, args):
             sync = P4Sync()
             if self.branch:
                 sync.branch = self.branch
-            sync.run([])
+            if self.disable_p4sync:
+                sync.sync_origin_only()
+            else:
+                sync.run([])
 
-            if self.disable_rebase is False:
-                rebase = P4Rebase()
-                rebase.rebase()
+                if not self.disable_rebase:
+                    rebase = P4Rebase()
+                    rebase.rebase()
 
         else:
             if len(applied) == 0:
@@ -3324,6 +3330,14 @@ def importChanges(self, changes, shelved=False, origin_revision=0):
                 print self.gitError.read()
                 sys.exit(1)
 
+    def sync_origin_only(self):
+        if self.syncWithOrigin:
+            self.hasOrigin = originP4BranchesExist()
+            if self.hasOrigin:
+                if not self.silent:
+                    print 'Syncing with origin first, using "git fetch origin"'
+                system("git fetch origin")
+
     def importHeadRevision(self, revision):
         print "Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch)
 
@@ -3402,12 +3416,7 @@ def run(self, args):
         else:
             self.refPrefix = "refs/heads/p4/"
 
-        if self.syncWithOrigin:
-            self.hasOrigin = originP4BranchesExist()
-            if self.hasOrigin:
-                if not self.silent:
-                    print 'Syncing with origin first, using "git fetch origin"'
-                system("git fetch origin")
+        self.sync_origin_only()
 
         branch_arg_given = bool(self.branch)
         if len(self.branch) == 0:
-- 
2.17.0.392.gdeb1a6e9b7

