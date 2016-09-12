Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA353207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 22:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755738AbcILWCn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 18:02:43 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33463 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754964AbcILWCm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 18:02:42 -0400
Received: by mail-qk0-f194.google.com with SMTP id n66so12777354qkf.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GvjWRjbzP2Tzxzvtg5FKc6y2Wn9QlrbR/xp+UqKVm1Y=;
        b=O0T5D/0qVzXLmPcVS0dKmRPZ7tsPdHTuPe8iZ2R5xfVsaAvpyEkuJCRKnbs9BA+wna
         F8Z/X7+sVhLvAvn/tQ8a0oFokAuvCYvFOSF85j+ZFlQs68eKvrVBqn1sjtTfcC2bEl6c
         mPKTSSnU11Sqi2FZRyaev2Oxo0q0YU4vz83E/tBGygRbNC9GOOm01cvTwhYWLTOUNVO1
         diTPTFX1sR8etWCUjt30VUWSxtyvMCl2vuozAhkS4Iy6ab0MQl+7pu7zJ39pdNL7uiZR
         XveBgoNgaGUfoRCaTk37/dqGaALE6BUHfn9FywOoQxRIsdSN+pea83teRbn8AGgjqpll
         nvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GvjWRjbzP2Tzxzvtg5FKc6y2Wn9QlrbR/xp+UqKVm1Y=;
        b=UjazTjRCNJ5lZexAsBfelTgGZpjFyo+2OnF0hmOWjz+Cl5XVxe7R72/vTvdz7Qoz2Z
         7dlamNe/tss2aT27bKHTQSWi9rH7g8w/pj71IKUnJduuLl2rs+pXn+r+k1oubxCxCg+Y
         pLR0oQmNYP2Qc01E4FBidEt+43byCS+gxD93t1ADGKZZ8A8gkm+L09WsTEDZ7zFc1gkh
         E1qjpHajalnGuC3qz5KZK83sUPcvLM9MWStyBJiJif/3mPKuobpm2OVuNCHh0e+6q2Qw
         CaKEsId16Q5kpBHGI2Fk3U0G/puzdX7op0cqE/uhkk6ylDljPNRvyrgMrh6QrC6jNfZS
         Z3jA==
X-Gm-Message-State: AE9vXwPNADdPGwi/blBbCk3xkHFWaB4fFlpo4OYGcT5rzszUrshwLjMIeped7JT300Nn9g==
X-Received: by 10.55.168.69 with SMTP id r66mr22584718qke.155.1473717762050;
        Mon, 12 Sep 2016 15:02:42 -0700 (PDT)
Received: from CHIC02QV065G8WN.sea.corp.expecn ([172.56.13.215])
        by smtp.gmail.com with ESMTPSA id o65sm11724292qkc.48.2016.09.12.15.02.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 15:02:41 -0700 (PDT)
From:   Ori Rawlings <orirawlings@gmail.com>
To:     git@vger.kernel.org
Cc:     Vitor Antunes <vitor.hda@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>,
        Ori Rawlings <orirawlings@gmail.com>
Subject: [PATCH] [git-p4.py] Add --checkpoint-period option to sync/clone
Date:   Mon, 12 Sep 2016 17:02:13 -0500
Message-Id: <1473717733-65682-2-git-send-email-orirawlings@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1473717733-65682-1-git-send-email-orirawlings@gmail.com>
References: <1473717733-65682-1-git-send-email-orirawlings@gmail.com>
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
 git-p4.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52..40cb64f 100755
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
+        self.checkpointPeriod = -1
 
         if gitConfig('git-p4.largeFileSystem'):
             largeFileSystemConstructor = globals()[gitConfig('git-p4.largeFileSystem')]
@@ -3031,6 +3033,8 @@ class P4Sync(Command, P4UserMap):
 
     def importChanges(self, changes):
         cnt = 1
+        if self.checkpointPeriod > -1:
+            self.lastCheckpointTime = time.time()
         for change in changes:
             description = p4_describe(change)
             self.updateOptionDict(description)
@@ -3107,6 +3111,10 @@ class P4Sync(Command, P4UserMap):
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
                     self.initialParent = ""
+
+                    if self.checkpointPeriod > -1 and time.time() - self.lastCheckpointTime > self.checkpointPeriod:
+                        self.checkpoint()
+                        self.lastCheckpointTime = time.time()
             except IOError:
                 print self.gitError.read()
                 sys.exit(1)
-- 
2.7.4 (Apple Git-66)

