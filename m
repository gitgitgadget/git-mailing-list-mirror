Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCEDC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347038AbiDAO2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346985AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A822856B8
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:28 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEN-009TW3-JD; Fri, 01 Apr 2022 15:26:26 +0100
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
Subject: [PATCH v5 18/22] git-p4: compare to singletons with "is" and "is not"
Date:   Fri,  1 Apr 2022 15:25:00 +0100
Message-Id: <20220401142504.58995-19-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that comparisons with singletons such as None should be
done with "is" and "is not", and never equality operators.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#programming-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a25adc8bae..2f2450f7d9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -857,7 +857,7 @@ def p4Where(depotPath):
             if data[:space] == depotPath:
                 output = entry
                 break
-    if output == None:
+    if output is None:
         return ""
     if output["code"] == "error":
         return ""
@@ -879,7 +879,7 @@ def currentGitBranch():
 
 
 def isValidGitDir(path):
-    return git_dir(path) != None
+    return git_dir(path) is not None
 
 
 def parseRevision(ref):
@@ -4425,7 +4425,7 @@ def main():
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-        if cmd.gitdir == None:
+        if cmd.gitdir is None:
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-- 
2.35.GIT

