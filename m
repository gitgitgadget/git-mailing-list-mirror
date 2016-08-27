Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B511F859
	for <e@80x24.org>; Sat, 27 Aug 2016 10:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754274AbcH0K3j (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 06:29:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34881 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbcH0K3i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 06:29:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so2718474wmg.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7ic9y1gK/zxh0pXmqlhVduUFYAv60vAsrZR9JXzT5UM=;
        b=nRAxwT0Tz/BFVuN2J35XaJ3cDpCMWwnFzF/AeytoDaBSNtk6hY/3iOvx6VezxNjJl6
         kx5ziGw9hxop1nWmwmO1PO3srBPiOJU/Okpt9MpZ7SNwu9rHnBSFHXFK3FG7ggw8lHba
         96b6rPi30l4tp+ItUNZ/lO8n7XrFi5IlRN8rsm+4kQlXyTN5qLlQ9eUo3FDc9TrTfv9Y
         /43MUdkKHIcjwqV+iDbeFKzKv+vlhIquCGTq5hf3k+5qrO822borSWvs0sXXOgqglAxZ
         FrBeUHorAr3PEaGRdiYBir4q63iY487JjFqrDYrVZysnHRTePo+eYAMzzTVtGCG1eK5a
         CSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7ic9y1gK/zxh0pXmqlhVduUFYAv60vAsrZR9JXzT5UM=;
        b=WxRB7kZMhdAWw6jQLd4B95lX/H41MQddcXNmiGmn3maxGwdvmiIqEYnUITyxzygh6E
         8JZjxKE8QBIsNw3AclHu8QA/Oj7gu/0bQv9Eccupunlzn0BBvBl4hgXOIo20SLq1PMEg
         SctSLksGNgTxrQivFJroF0NWpk3g01J6h7WDSgt/8D1aG8x0j4wVBpCsBB+qOG6XBi5n
         hm5RblzFQXIEj2GmGJPmBjG4rmu8khrQ/4ESrR6eBt04z7hZ4AuxMAZouRl7zfchTjyU
         e9DlDWNaJ+wu/b0AmCqJA+ppIyk40jxW+PPHnP8e+V0jgwigfaPuxltAYbheYtfWnb2U
         bfTw==
X-Gm-Message-State: AE9vXwPLjXdp4zZWP65jASJ1XpXEmnOGGgxq1n1iYpqvEtvTO7L6IppkpMVIIpZlR8ZbDw==
X-Received: by 10.28.125.80 with SMTP id y77mr2766926wmc.25.1472293776419;
        Sat, 27 Aug 2016 03:29:36 -0700 (PDT)
Received: from hurricane ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id s6sm24005245wjm.25.2016.08.27.03.29.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2016 03:29:35 -0700 (PDT)
Date:   Sat, 27 Aug 2016 12:29:33 +0200
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Subject: [PATCH] make dist: allow using an installed version of git
Message-ID: <20160827102929.GA11769@hurricane>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b1de9de2 back in 2005 ensured that we could create a tarball with 'make
dist' even if git wasn't installed yet. These days however, chances are
higher that a git version is available. Add a config.mak knob to allow
people to choose to use the installed version of git to create the
tarball and avoid the overhead of building git-archive.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 Makefile | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d96ecb7..3dabb75 100644
--- a/Makefile
+++ b/Makefile
@@ -378,6 +378,9 @@ all::
 #
 # to say "export LESS=FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
+#
+# Define USE_INSTALLED_GIT_ARCHIVE if you don't want to build git-archive as
+# part of 'make dist', but are happy to rely on a git version on you $PATH
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -2423,8 +2426,15 @@ quick-install-html:
 ### Maintainer's dist rules
 
 GIT_TARNAME = git-$(GIT_VERSION)
-dist: git-archive$(X) configure
-	./git-archive --format=tar \
+ifndef USE_INSTALLED_GIT_ARCHIVE
+	GIT_ARCHIVE = ./git-archive$(X)
+	GIT_ARCHIVE_DEP = git-archive$(X)
+else
+	GIT_ARCHIVE = git archive
+	GIT_ARCHIVE_DEP =
+endif
+dist: $(GIT_ARCHIVE_DEP) configure
+	$(GIT_ARCHIVE) --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
 	@cp configure $(GIT_TARNAME)
-- 
2.10.0-rc1-230-g8efea0f
