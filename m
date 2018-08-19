Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714E31F954
	for <e@80x24.org>; Sun, 19 Aug 2018 10:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbeHSODT (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 10:03:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37009 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeHSODT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 10:03:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so9463299ljk.4
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 03:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/261UxXOCz/Adl+JNuBJYRqL4aIxuqj6N/KUGmAKwc=;
        b=kWDMQqfHL9+SrI7zB7mUVXtxtozVzYUpaITosYiPkdB4Q1nxwG1gmhS1yvt5TR13bA
         YwHdO12c9lO8xCBzMIudfs99rIktX1Q0wdKv7P/sxGXvh/ERF1TMCyRFC3B+ukqPgz8H
         NeOZwEjHpf7tBEkIEjdfnVqI4XFdNSE9NNVNpcdbbsOWMACTYr/JhoKfJvzWhovZGSNg
         ps1IgRtjBybmgjs6ni9VhVU/jWIQJwnL9SjT5dtIzxoMBRmZ3dzMvvjViYvBW0cl8HZU
         WTO3XAK179ROnRfQEz4jy5v3TWb4oUKKUkxc+vcOL2m+ibcM1a8boxX9vaVUjZy+xUdY
         YyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/261UxXOCz/Adl+JNuBJYRqL4aIxuqj6N/KUGmAKwc=;
        b=KwvOBVhH3dSR5xPnhYhzV6pVxapGrRxw2Btt807ChGzLkdrEbDa7wDPqoNwwpS1p8X
         6LOlN9hcOex+lxDhbjTmOka5QpwwtJY4GGl+M9EdLjVaeBxgJxGxOsafSDaJRhtjnEN4
         a+jtGRrYW2OXU1CcmGpNul/pz7HhwttBHszgvmeAiU120OVHUa1a5QXS/C2toHnUnKgK
         JlldmzerkE1ZlDCs2jUsRNmnpmPXI23QQp/2HS8mFPf9/VE2U5xNDWMcGV4nSqro7TQ6
         TgnQdGc9CH5Co5/oCSoTO8U19UvjiH9PBrnTz1aHNJ5MrgyryeC3CAIEO9Bc3ALAz7XK
         25cQ==
X-Gm-Message-State: AOUpUlGi7Vx+qSC8VYUn1+r1hqmek90Icw600L3fTihTY7TtMmvZpJd/
        buK51ZJSdrOUkNr2oF7KubLJ1dOi
X-Google-Smtp-Source: AA+uWPyFfKr8uBWVJvZIx9DLuH/hw0AX7d0Bsd3p4WT+4EkhZWn9PRRbdsstpCK3WRyK8IpZI1XOcg==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr29977942ljc.145.1534675933927;
        Sun, 19 Aug 2018 03:52:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g133-v6sm1243388lfg.81.2018.08.19.03.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 03:52:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] generate-cmdlist.sh: collect config from all config.txt files
Date:   Sun, 19 Aug 2018 12:52:10 +0200
Message-Id: <20180819105210.19296-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script uses Documentation/config.txt as input for "git help
--config" and "git config" completion but it misses the fact that
config.txt includes other txt files. Include all *config.txt as input
when scanning for config keys. This could produce false positives, but
as long as we stick to the blah-config.txt naming convention, we
should be ok.

While at there, move diff.* from config.txt to diff-config.txt where
all other diff config keys are.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt      | 12 ------------
 Documentation/diff-config.txt | 12 ++++++++++++
 Makefile                      |  2 +-
 generate-cmdlist.sh           |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 95ad715a44..132bf08eaf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1203,18 +1203,6 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
-diff.colorMoved::
-	If set to either a valid `<mode>` or a true value, moved lines
-	in a diff are colored differently, for details of valid modes
-	see '--color-moved' in linkgit:git-diff[1]. If simply set to
-	true the default color mode will be used. When set to false,
-	moved lines are not colored.
-
-diff.colorMovedWS::
-	When moved lines are colored using e.g. the `diff.colorMoved` setting,
-	this option controls the `<mode>` how spaces are treated
-	for details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
-
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 77caa66c2f..85bca83c30 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -208,3 +208,15 @@ diff.wsErrorHighlight::
 	whitespace errors are colored with `color.diff.whitespace`.
 	The command line option `--ws-error-highlight=<kind>`
 	overrides this setting.
+
+diff.colorMoved::
+	If set to either a valid `<mode>` or a true value, moved lines
+	in a diff are colored differently, for details of valid modes
+	see '--color-moved' in linkgit:git-diff[1]. If simply set to
+	true the default color mode will be used. When set to false,
+	moved lines are not colored.
+
+diff.colorMovedWS::
+	When moved lines are colored using e.g. the `diff.colorMoved` setting,
+	this option controls the `<mode>` how spaces are treated
+	for details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
diff --git a/Makefile b/Makefile
index 73aa943e28..4cb4ac2d5d 100644
--- a/Makefile
+++ b/Makefile
@@ -2044,7 +2044,7 @@ $(BUILT_INS): git$X
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
-command-list.h: $(wildcard Documentation/git*.txt) Documentation/config.txt
+command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index c4124acbe7..fa1e5475e8 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -80,7 +80,7 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	grep '^[a-zA-Z].*\..*::$' Documentation/config.txt |
+	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt |
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
 	sort |
 	while read line
-- 
2.18.0.1004.g6639190530

