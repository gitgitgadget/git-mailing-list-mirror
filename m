Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099742023D
	for <e@80x24.org>; Fri,  3 Mar 2017 10:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdCCK6s (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 05:58:48 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:39318
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751050AbdCCK6p (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 05:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1488538666;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=QUETeCcdMcq+xRfJueY/vCNeDxoyPNqH2TTH9es7iZY=;
        b=SVicDMGvZJDm3tzhAKDELKf58PlAupAX1DAH3ewiVhPYjdwg9gwZCrntn3A8zhMw
        Y029IfOAG0Q2o8qfwuapsMGHgxfeepGc0uoKbVWG85Q+pPhFgqpsI4dRC/7I1X1f6BE
        Hb+/K8Aiy3gpD0GCzbu6sKRuLM0fhudFiY8kbvp4=
From:   Sebastian Schuberth <sschuberth@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015a93d18443-c574aaf8-5656-49e8-8848-810e1fadc87a-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Do not require Python for the git-remote-{bzr,hg}
 placeholder scripts
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 3 Mar 2017 10:57:46 +0000
X-SES-Outgoing: 2017.03.03-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not make sense for these placeholder scripts to depend on Python
just because the real scripts do. At the example of Git for Windows, we
would not even be able to see those warnings as it does not ship with
Python. So just use plain shell scripts instead.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 16 +++++++---------
 contrib/remote-helpers/git-remote-hg  | 16 +++++++---------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 712a137..ccc4aea 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -1,13 +1,11 @@
-#!/usr/bin/env python
+#!/bin/sh
 
-import sys
-
-sys.stderr.write('WARNING: git-remote-bzr is now maintained independently.\n')
-sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-bzr\n')
-
-sys.stderr.write('''WARNING:
+cat <<'EOT'
+WARNING: git-remote-bzr is now maintained independently.
+WARNING: For more information visit https://github.com/felipec/git-remote-bzr
+WARNING:
 WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-bzr \\
+WARNING:   $ wget -O $HOME/bin/git-remote-bzr \
 WARNING:     https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
 WARNING:   $ chmod +x $HOME/bin/git-remote-bzr
-''')
+EOT
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 4255ad6..dfda44f 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -1,13 +1,11 @@
-#!/usr/bin/env python
+#!/bin/sh
 
-import sys
-
-sys.stderr.write('WARNING: git-remote-hg is now maintained independently.\n')
-sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-hg\n')
-
-sys.stderr.write('''WARNING:
+cat <<'EOT'
+WARNING: git-remote-hg is now maintained independently.
+WARNING: For more information visit https://github.com/felipec/git-remote-hg
+WARNING:
 WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-hg \\
+WARNING:   $ wget -O $HOME/bin/git-remote-hg \
 WARNING:     https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
 WARNING:   $ chmod +x $HOME/bin/git-remote-hg
-''')
+EOT

--
https://github.com/git/git/pull/333
