Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFB01F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeFHUc6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:32:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40812 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbeFHUc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:32:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so5809644wmc.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWDKFkRdbIg1t60b0/0qfEeHwcTEp8Qx4M+s7TxtCNk=;
        b=bTgKw9fdUJex0r9OwY0ob51+6WUL4My+LF7795/IXobmnewTxsWTTHTgmbkxE4Z1Sx
         byBXwQR5fs5Smpwh/Uq4zJioRHD2JLobisanspe+rdoK3FtSfBghRMA88MwAtnJrQrHG
         WZjcJ+Vo0sBlObP4hmrj2wNeABoXOzTLAErs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cWDKFkRdbIg1t60b0/0qfEeHwcTEp8Qx4M+s7TxtCNk=;
        b=Qm4udEgPRK24eFjsaue4bOQrUtPedqtv+O9wbu384UhkK5UiAsTPPDXh6hvvjFuYn4
         e08dh3sX5iLr2Pim+O/qJBFpMj6Qt7rpMIpAHDVXe3+Vnxo0lY3rjzebT6l5QlwxtKST
         yoTO1kr+QXwN/uzQRXe/BRwl+1pK0hT3r/GKEj8qmshY00BtnadgceS1GujRMqlLJOfY
         K81IOb/5HyvqQU5doRYGAlEMNonQgZfHWtW54ibMmevwNaaBMqdQ+GsCgXbiVYcoRJSC
         ULtEcRAmtny6yGowg5zRiEU69fyIOxofIrMogY3e02iYEVq1xon7MAVnAgPnEllpOoSE
         ufSQ==
X-Gm-Message-State: APt69E3JfXPMHqhoM5H+qGvIIRibSkjejGDILzGCEF2nGD419CVPGohC
        NGe4d8HofI25g3NaC/LcvZtxh/Gm
X-Google-Smtp-Source: ADUXVKIy5rChmvPxaknlvo6GlAQiB1FG+b54fquc+yfaMHIijIJ5KhW4p3YW0fCUe8+jCp1hn7WLeA==
X-Received: by 2002:a1c:7309:: with SMTP id d9-v6mr2527220wmb.60.1528489975673;
        Fri, 08 Jun 2018 13:32:55 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id k82-v6sm240001wmg.10.2018.06.08.13.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:32:54 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Eric Scouten <eric@scouten.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, viniciusalexandre@gmail.com,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/6] git-p4: disable-rebase: allow setting this via configuration
Date:   Fri,  8 Jun 2018 21:32:43 +0100
Message-Id: <20180608203248.16311-2-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180608203248.16311-1-luke@diamand.org>
References: <20180608203248.16311-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just lets you set the --disable-rebase option with the
git configuration options git-p4.disableRebase. If you're
using this option, you probably want to set it all the time
for a given repo.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt | 5 ++++-
 git-p4.py                | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index e8452528fc..3d83842e47 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -367,7 +367,7 @@ These options can be used to modify 'git p4 submit' behavior.
 
 --disable-rebase::
     Disable the automatic rebase after all commits have been successfully
-    submitted.
+    submitted. Can also be set with git-p4.disableRebase.
 
 Rebase options
 ~~~~~~~~~~~~~~
@@ -690,6 +690,9 @@ git-p4.conflict::
 	Specify submit behavior when a conflict with p4 is found, as per
 	--conflict.  The default behavior is 'ask'.
 
+git-p4.disableRebase::
+    Do not rebase the tree against p4/master following a submit.
+
 IMPLEMENTATION DETAILS
 ----------------------
 * Changesets from p4 are imported using Git fast-import.
diff --git a/git-p4.py b/git-p4.py
index c4581d20a6..5ab9421af8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1379,7 +1379,7 @@ def __init__(self):
         self.shelve = False
         self.update_shelve = list()
         self.commit = ""
-        self.disable_rebase = False
+        self.disable_rebase = gitConfigBool("git-p4.disableRebase")
         self.prepare_p4_only = False
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
-- 
2.17.0.392.gdeb1a6e9b7

