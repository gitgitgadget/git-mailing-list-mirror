Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0683D1F42D
	for <e@80x24.org>; Tue, 22 May 2018 08:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEVIlV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 04:41:21 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39186 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeEVIlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 04:41:18 -0400
Received: by mail-wm0-f42.google.com with SMTP id f8-v6so31211787wmc.4
        for <git@vger.kernel.org>; Tue, 22 May 2018 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpV8QILT0vf1h3kWJgHLs4XMiAC8W8qJUDFH/GsEPsM=;
        b=BIuDONBzDiJhthg+KQ/b17b6zKL5o/lqn+nZNmgdndYj2uE++RZhJ6p5++X80AYYzL
         S+J+BMlwWPXNRFvijDrGLjVMzxQoTCUOGt5e2eucRZz/CyryiX6wgK1KnK5zWwzQJ8Xk
         VpliQ7H/CdmzzSZsRpUk4iM17OcZZ6ODo6eqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpV8QILT0vf1h3kWJgHLs4XMiAC8W8qJUDFH/GsEPsM=;
        b=toTYhTxU930TQvnxEqUTmbd+SoqaXeCMGZJTEeAefnFwDcuKRso6QlSVEy1n8BW4zF
         BuAMD5aaSPSKuFVT1fC75xpdRgOu+qsZRv8FDdUqcPshgr/DYev26C3ol/RBFHAJSK0/
         SeHzexFyGR0Vxy4UhzftOjdoKntYU5biDK1dbupkafMlnbRHck74Kf5o02auMryKbXNJ
         u7DZCksbib9WD40SafOHSmWN+9C/n6b0SBA17I6HV/0w+EkC/+5WEyiebZK86khlzAwq
         hzg/MhjVqn+S1tYgabeQzXvDDrKRHkRjKpFY3AsW9yNABQ2WImwoxLY9tbcEwrZhkylF
         pkUA==
X-Gm-Message-State: ALKqPwd2gdv8PbEcoUmU5Ir6k2fVGayjtWr67H59CTho/GZLbXXNVWCB
        DyIn5gR6XSDMkasJrSyJD0kb0DQj
X-Google-Smtp-Source: AB8JxZp/+WPKdciNxDAl+m5550h0siwi7u2FJ1tz9VAfeKQc28a9Nh+cGogt9kWceej//fmK1jGf4w==
X-Received: by 2002:a1c:6f57:: with SMTP id k84-v6mr414377wmc.142.1526978477033;
        Tue, 22 May 2018 01:41:17 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id 135-v6sm19202922wmx.21.2018.05.22.01.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 01:41:16 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/1] git-p4: unshelve: use action==add instead of rev==none
Date:   Tue, 22 May 2018 09:41:09 +0100
Message-Id: <20180522084109.29787-2-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180522084109.29787-1-luke@diamand.org>
References: <20180522084109.29787-1-luke@diamand.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor found that the unshelve tests fail with newer
versions of Perforce (2016 vs 2015).

The problem arises because when a file is added in a P4
shelved changelist, the depot revision is shown as "none"
if using the older p4d (which makes sense - the file doesn't
yet exist, so can't have a revision), but as "1" in the newer
versions of p4d.

For example, adding a file called "new" with 2015.1 and then
shelving that change gives this from "p4 describe" :

    ... //depot/new#none add

Using the 2018.1 server gives this:

    ... //depot/new#1 add

We can detect that a file has been added simply by using the
file status ("add") instead, rather than the depot revision,
which is what this change does.

This also fixes a few verbose prints used for debugging this
to be more friendly.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 364d86dbcc..c80d85af89 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2463,7 +2463,7 @@ class P4Sync(Command, P4UserMap):
         """
         ret = p4Cmd(["diff2", "{0}#{1}".format(path, filerev), "{0}@{1}".format(path, revision)])
         if verbose:
-            print("p4 diff2 %s %s %s => %s" % (path, filerev, revision, ret))
+            print("p4 diff2 path %s filerev %s revision %s => %s" % (path, filerev, revision, ret))
         return ret["status"] == "identical"
 
     def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0, origin_revision = 0):
@@ -2492,7 +2492,12 @@ class P4Sync(Command, P4UserMap):
             if shelved:
                 file["shelved_cl"] = int(shelved_cl)
 
-                if file["rev"] != "none" and \
+                # For shelved changelists, check that the revision of each file that the
+                # shelve was based on matches the revision that we are using for the
+                # starting point for git-fast-import (self.initialParent). Otherwise
+                # the resulting diff will contain deltas from multiple commits.
+
+                if file["action"] != "add" and \
                     not self.cmp_shelved(path, file["rev"], origin_revision):
                     sys.exit("change {0} not based on {1} for {2}, cannot unshelve".format(
                         commit["change"], self.initialParent, path))
@@ -2610,7 +2615,7 @@ class P4Sync(Command, P4UserMap):
     def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         relPath = self.encodeWithUTF8(relPath)
-        if verbose:
+        if verbose and 'fileSize' in self.stream_file:
             size = int(self.stream_file['fileSize'])
             sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
             sys.stdout.flush()
-- 
2.17.0.392.gdeb1a6e9b7

