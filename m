Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3501F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeJXD3Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:29:16 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41788 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeJXD3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:29:16 -0400
Received: by mail-vk1-f195.google.com with SMTP id c82so622138vke.8
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYQ7WC5GgyrF/7tf7L4/hn553p2vcpxNHwyugM8Z+L4=;
        b=Rva82Q1JeXzRWpzzmvwhyTmqJ5lTg0Z5iGV3r7Ik16zv35Ngoey3elhVbkBmJJ5xQ3
         qjV96sPkXyjpPi6sM+KR+r+0cRz1yBuCOiwdBMGJHQCPwA3aRbYFjy6We54+COY5X/ZO
         uLI4L0aBhKevYQfA0tQjC2KELNCN9x8H1nV76LH72yRlLoJ33HS2siTrkQ2e8UiRLZz2
         vf7kXYSZqpkMxdKiMeHTDcz2TxMnOXGwZULsD5bOwvitIVbeov7sgpg+2uI9eCrQfEgD
         Uh5JAE1HRCLnETblufS16jywxN84obNjLXv1uVguURX5CLrfalhPHIn04uUrhE4j+ub2
         wiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYQ7WC5GgyrF/7tf7L4/hn553p2vcpxNHwyugM8Z+L4=;
        b=a5Wb8RapM1BJoogL/P3iA/zqyyD0QzS7PRhObwqzTLfRbRQpdNS9Ug5CFCi+hZ4K+/
         ka+YFyXjILmsb6ifimO7D5w/rHexac4PpeAzpebsOLw5VA3BuCIDzmRJG+TBfYpGilfu
         M3Ld/+2BrGCYmlOspD1AKtg4/8Y31aSm67sL8OY8EO+72fwTyAiLMJG9XiEJpu1U8ns/
         4ugbO7893jBhq58QBM5ZtwcVU1ApmXmtab2i5+GPj/xHWbrzlCA7reHhv4nmURdFVtz8
         gzlgKCseq+4GFcPSvjn/O0bBtfIwYRczeTGfqdBR48Ps1FZ+Qp9G/reRBTIHzWDWbQvl
         JI9Q==
X-Gm-Message-State: ABuFfog53HunSeI1WfS1BGX/Nhwx2aWR90Oi84GeW2/9sKEm/uh6BKqN
        ZdSHFP1m7VLNO/YIv/IAaRdJNZTAj3k=
X-Google-Smtp-Source: ACcGV61hAyA0SHkIpiiGSM75vMINrbITZsXKwkLSuhQWz6uPusdGDZ+/Zcqa6HkVunmbO7lHSH9Ihw==
X-Received: by 2002:a1f:cfc7:: with SMTP id f190-v6mr21884181vkg.11.1540321475412;
        Tue, 23 Oct 2018 12:04:35 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e79sm473284vsd.1.2018.10.23.12.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:04:34 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 2/3] reset: add new reset.quiet config setting
Date:   Tue, 23 Oct 2018 15:04:22 -0400
Message-Id: <20181023190423.5772-3-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181023190423.5772-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181023190423.5772-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add a reset.quiet config setting that sets the default value of the --quiet
flag when running the reset command.  This enables users to change the
default behavior to take advantage of the performance advantages of
avoiding the scan for unstaged changes after reset.  Defaults to false.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt    | 3 +++
 Documentation/git-reset.txt | 5 ++++-
 builtin/reset.c             | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f6f4c21a54..a2d1b8b116 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2728,6 +2728,9 @@ rerere.enabled::
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
 
+reset.quiet::
+	When set to true, 'git reset' will default to the '--quiet' option.
+
 include::sendemail-config.txt[]
 
 sequence.editor::
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 1d697d9962..2dac95c71a 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -95,7 +95,10 @@ OPTIONS
 
 -q::
 --quiet::
-	Be quiet, only report errors.
+--no-quiet::
+	Be quiet, only report errors. The default behavior is set by the
+	`reset.quiet` config option. `--quiet` and `--no-quiet` will
+	override the default behavior.
 
 
 EXAMPLES
diff --git a/builtin/reset.c b/builtin/reset.c
index 04f0d9b4f5..3b43aee544 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -306,6 +306,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
+	git_config_get_bool("reset.quiet", &quiet);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
-- 
2.18.0.windows.1

