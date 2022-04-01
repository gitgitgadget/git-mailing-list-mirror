Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA3EC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347081AbiDAO2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346913AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033352856B4
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:27 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEN-009TW3-4X; Fri, 01 Apr 2022 15:26:26 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 17/22] git-p4: normalize indentation of lines in conditionals
Date:   Fri,  1 Apr 2022 15:24:59 +0100
Message-Id: <20220401142504.58995-18-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that when wrapping the arguments of conditional
statements, an extra level of indentation should be added to distinguish
arguments from the body of the statement.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#indentation

This patch either adds the indentation, or removes unnecessary wrapping.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 97c2f82ee8..a25adc8bae 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1085,8 +1085,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=T
         originHead = line
 
         original = extractSettingsGitLog(extractLogMessageFromGitCommit(originHead))
-        if ('depot-paths' not in original
-            or 'change' not in original):
+        if 'depot-paths' not in original or 'change' not in original:
             continue
 
         update = False
@@ -2098,8 +2097,8 @@ def applyCommit(self, id):
                     if regexp:
                         # this file is a possibility...look for RCS keywords.
                         for line in read_pipe_lines(
-                            ["git", "diff", "%s^..%s" % (id, id), file],
-                            raw=True):
+                                ["git", "diff", "%s^..%s" % (id, id), file],
+                                raw=True):
                             if regexp.search(line):
                                 if verbose:
                                     print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
@@ -3112,9 +3111,9 @@ def streamP4FilesCb(self, marshalled):
                 self.stream_file[k] = marshalled[k]
 
         if (verbose and
-            'streamContentSize' in self.stream_file and
-            'fileSize' in self.stream_file and
-            'depotFile' in self.stream_file):
+                'streamContentSize' in self.stream_file and
+                'fileSize' in self.stream_file and
+                'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
@@ -3930,8 +3929,7 @@ def run(self, args):
                 settings = extractSettingsGitLog(logMsg)
 
                 self.readOptions(settings)
-                if ('depot-paths' in settings
-                    and 'change' in settings):
+                if 'depot-paths' in settings and 'change' in settings:
                     change = int(settings['change']) + 1
                     p4Change = max(p4Change, change)
 
-- 
2.35.GIT

