Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E521F403
	for <e@80x24.org>; Tue,  5 Jun 2018 09:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeFEJOH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 05:14:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38147 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeFEJOC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 05:14:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id 94-v6so1554462wrf.5
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5nmkpPdpBdRM0A7phvnbwfR+StIx84lNZH3CMvaljU=;
        b=dsjhb6zA8yJyufwqQcDX3Hf6DEFLOPcv9qS7eU/PPXrBLBYzoOvpdwwCOYDP7U5/Yl
         22ctXBtiPAXjVm7yZYrQqyc6xOfT2k9jKggZZLFtOUIVt5GGfgcm3gumDfoTgZLGGxh8
         LIeED6CETJTVgkAdHA58ftfA0HXoy9U3ok3uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5nmkpPdpBdRM0A7phvnbwfR+StIx84lNZH3CMvaljU=;
        b=MBb0ML1F+AR3qU0a2pODzmzLJG+FFN2T//RXJV7/6XdDyPWK728FM4Ev02WoT6wwRJ
         3ZO2fe3bAfViKzBcBbMNrTdlL42itFIdPvrOY9zv+PFia48uMDAq2aoKYS8KxgZkv0pS
         gutY04PMbLEIjKP9EVi6u7OWgdjLtYtqDAi5lxgto3S0v2nTbRMy7YQWNqRIMNuMyMM0
         /Len0NZoIwqtHfr38vowAOfN19hYHOLZFQHbcTqHanBb0filWWv3Pznfkgsqh8LeZYni
         XZUWlE7Q+bYWLsRtK5nAYSH5UyB39CjvX4B0I2toaAiXwXxpeaJsO0lAVEnsVBQ60w3O
         x22w==
X-Gm-Message-State: ALKqPwcpbwGtb+tHUkiBwQy0cb4xXpIHvUAfB1flnJ8YS/Wp3n0snGqB
        W8/0f2WIJjnjAqRlOCFAlCXibM6rpp8=
X-Google-Smtp-Source: ADUXVKJ8YNfPUkvU5dRjgZXOzFOhPQ30kSn5/r0VLn2V8jAHSDRccZ0oivFQuK6wtAT7Sk5EjWpa3g==
X-Received: by 2002:adf:edc6:: with SMTP id v6-v6mr17690729wro.264.1528190040297;
        Tue, 05 Jun 2018 02:14:00 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id i46-v6sm42018545wra.36.2018.06.05.02.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 02:13:59 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 3/3] git-p4: auto-size the block
Date:   Tue,  5 Jun 2018 10:13:50 +0100
Message-Id: <20180605091350.14476-4-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180605091350.14476-1-luke@diamand.org>
References: <20180605091350.14476-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 originally would fetch changes in one query. On large repos this
could fail because of the limits that Perforce imposes on the number of
items returned and the number of queries in the database.

To fix this, git-p4 learned to query changes in blocks of 512 changes,
However, this can be very slow - if you have a few million changes,
with each chunk taking about a second, it can be an hour or so.

Although it's possible to tune this value manually with the
"--changes-block-size" option, it's far from obvious to ordinary users
that this is what needs doing.

This change alters the block size dynamically by looking for the
specific error messages returned from the Perforce server, and reducing
the block size if the error is seen, either to the limit reported by the
server, or to half the current block size.

That means we can start out with a very large block size, and then let
it automatically drop down to a value that works without error, while
still failing correctly if some other error occurs.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 26 +++++++++++++++++++++-----
 t/t9818-git-p4-block.sh | 11 +++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b337562b39..6736f81b60 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -48,7 +48,8 @@ def __str__(self):
 defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
 # Grab changes in blocks of this many revisions, unless otherwise requested
-defaultBlockSize = 512
+# The code should now automatically reduce the block size if it is required
+defaultBlockSize = 1<<20
 
 p4_access_checked = False
 
@@ -969,7 +970,8 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     changes = set()
 
     # Retrieve changes a block at a time, to prevent running
-    # into a MaxResults/MaxScanRows error from the server.
+    # into a MaxResults/MaxScanRows error from the server. If
+    # we _do_ hit one of those errors, turn down the block size
 
     while True:
         cmd = ['changes']
@@ -983,10 +985,24 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
         for p in depotPaths:
             cmd += ["%s...@%s" % (p, revisionRange)]
 
+        # fetch the changes
+        try:
+            result = p4CmdList(cmd, errors_as_exceptions=True)
+        except P4RequestSizeException as e:
+            if not block_size:
+                block_size = e.limit
+            elif block_size > e.limit:
+                block_size = e.limit
+            else:
+                block_size = max(2, block_size // 2)
+
+            if verbose: print("block size error, retry with block size {0}".format(block_size))
+            continue
+        except P4Exception as e:
+            die('Error retrieving changes description ({0})'.format(e.p4ExitCode))
+
         # Insert changes in chronological order
-        for entry in reversed(p4CmdList(cmd)):
-            if entry.has_key('p4ExitCode'):
-                die('Error retrieving changes descriptions ({})'.format(entry['p4ExitCode']))
+        for entry in reversed(result):
             if not entry.has_key('change'):
                 continue
             changes.add(int(entry['change']))
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 8840a183ac..e5ec9cdec8 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -129,6 +129,7 @@ test_expect_success 'Create a repo with multiple depot paths' '
 '
 
 test_expect_success 'Clone repo with multiple depot paths' '
+	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		git p4 clone --changes-block-size=4 //depot/pathA@all //depot/pathB@all \
@@ -138,6 +139,16 @@ test_expect_success 'Clone repo with multiple depot paths' '
 	)
 '
 
+test_expect_success 'Clone repo with self-sizing block size' '
+	test_when_finished cleanup_git &&
+	git p4 clone --changes-block-size=1000000 //depot@all --destination="$git" &&
+	(
+		cd "$git" &&
+		git log --oneline > log &&
+		test_line_count \> 10 log
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.17.0.392.gdeb1a6e9b7

