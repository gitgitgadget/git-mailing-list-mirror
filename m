Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE6DC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36CC613B5
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhGIPiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:38:12 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:57008 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhGIPiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 11:38:11 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 11:38:11 EDT
Received: from localhost (200116b8607d4e002ab3dc4673e718ab.dip.versatel-1u1.de [IPv6:2001:16b8:607d:4e00:2ab3:dc46:73e7:18ab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 3275812A0102;
        Fri,  9 Jul 2021 17:25:31 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [filter-repo PATCH] filter-repo: help with local install
Date:   Fri,  9 Jul 2021 17:25:30 +0200
Message-Id: <e3d6c6d670b46d4f0dc133e83c6feede4d55c412.1625844149.git.git@grubix.eu>
X-Mailer: git-send-email 2.32.0.375.gf4d99f6c19
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Makefile suggests a local install and works almost as is, except for
the python path. Make it work automatically for this typical use case,
and give a corresponding hint in INSTALL.md.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 INSTALL.md | 5 +++--
 Makefile   | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/INSTALL.md b/INSTALL.md
index 00aabb7..d479681 100644
--- a/INSTALL.md
+++ b/INSTALL.md
@@ -75,8 +75,9 @@ filter-repo only consists of a few files that need to be installed:
     You can create this symlink to (or copy of) git-filter-repo named
     git_filter-repo.py and place it in your python site packages; `python
     -c "import site; print(site.getsitepackages())"` may help you find the
-    appropriate location for your system.  Alternatively, you can place
-    this file anywhere within $PYTHONPATH.
+    appropriate location for your system, `python -c "import site;
+    print(site.getusersitepackages())"` for a local install. Alternatively,
+    you can place this file anywhere within $PYTHONPATH.
 
   * git-filter-repo.1
 
diff --git a/Makefile b/Makefile
index 31f5e3a..c97d1f6 100644
--- a/Makefile
+++ b/Makefile
@@ -4,7 +4,7 @@ bindir = $(prefix)/libexec/git-core
 localedir = $(prefix)/share/locale
 mandir = $(prefix)/share/man
 htmldir = $(prefix)/share/doc/git-doc
-pythondir = $(prefix)/lib64/python3.6/site-packages
+pythondir = $(shell python -c "import site; print(site.getusersitepackages())")
 
 default: build
 
-- 
2.32.0.375.gf4d99f6c19

