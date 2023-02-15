Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA43C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 10:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjBOKnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 05:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjBOKnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 05:43:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9D965AC
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 02:43:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso1191173wmo.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL/og56JYgRoPNJza48wlv2wx1DsTjVILDAq6S+XogM=;
        b=j6FBwwps7uY3mO0uNCdmfHun+btV3oazLdHgBpxUitmpTfohMYSkPm85qeYmJCG2PS
         2FU/VEJgVig7D09rBGU0Xcvs9sG5FbgO54a6kn3lx21SjbYTgLx/p4InpgHMtsW8RaIg
         jPoJptvl/EK8WOgvgPCMEDBq++TV3zp37J7fuBwj+CO7ELeTNpdJ7phzI6uzAIvhkNVH
         iEwlxCZEWzpYTnoio0mj0IW6H/0yCU1irmoNu8UqLKDbmzR198E0dP3A3f7+lTImDTw1
         /1l6yc9sZJHT9qvffUQMl5Asqtk/EXyIb/9t+WeH7e+fy/SErHwOWVpPxaT6s59cmnfj
         KGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL/og56JYgRoPNJza48wlv2wx1DsTjVILDAq6S+XogM=;
        b=m9nfx+F9iTIbZc4ildIxEutsEIldUMkbMX7pYvDm5UbfM2oznjI7r9fZy8FeIL4zys
         OzxaO1LrR+s2MN1LToNP46kUz553qzNLoG2yPAG3VDTLpqGBDjShZ+2V7OXQiHTCU92m
         SwoVIuoaM94ZjIPbVEuZJWHH8ZjddxyXrvfl9tKoI5jYZK6+nKVpMvu1EglPFaS17dsb
         e4ENMR7bRGqIIeysocYAqyBDB/m67b8IRtYn5PiIlyNae5voPirh6ZEaXm8n0iXZXWOA
         wlaxpRUaTkLApNRyUgCThLunJRlbW7pc5JMU5BhUd8WUhZpV78ulFaAC5b86S3hFgu13
         Mpmg==
X-Gm-Message-State: AO0yUKWQaI+YyXdNPn8MQz8xAQ403eXgh1txS+Q3lWGQOwYE4iVAoobC
        CPso7Suwm+MKlULKjyjQWb57O0MQUG0=
X-Google-Smtp-Source: AK7set83CQLSpRd+//DvMaWqMGaXxgazOIQ+QPBdBe4GctGQmwpu/D2/u5OMHZ7lEy/KppmgWPOH1A==
X-Received: by 2002:a05:600c:4b1b:b0:3df:fbd5:690 with SMTP id i27-20020a05600c4b1b00b003dffbd50690mr1443908wmp.17.1676457807511;
        Wed, 15 Feb 2023 02:43:27 -0800 (PST)
Received: from localhost.localdomain ([41.109.93.231])
        by smtp.gmail.com with ESMTPSA id p7-20020a7bcc87000000b003e11f280b8bsm1645030wma.44.2023.02.15.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 02:43:27 -0800 (PST)
From:   Idriss Fekir <mcsm224@gmail.com>
To:     git@vger.kernel.org
Cc:     idriss fekir <mcsm224@gmail.com>
Subject: [PATCH 1/1] remove parameter (prefix) from trace_repo_setup
Date:   Wed, 15 Feb 2023 11:42:46 +0100
Message-Id: <20230215104246.8919-2-mcsm224@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215104246.8919-1-mcsm224@gmail.com>
References: <20230215104246.8919-1-mcsm224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: idriss fekir <mcsm224@gmail.com>

Signed-off-by: Idriss Fekir <mcsm224@gmail.com>
---
 git.c   | 2 +-
 trace.c | 6 +++---
 trace.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 96b0a2837d..6171fd6769 100644
--- a/git.c
+++ b/git.c
@@ -430,7 +430,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		use_pager = 1;
 	if (run_setup && startup_info->have_repository)
 		/* get_git_dir() may set up repo, avoid that */
-		trace_repo_setup(prefix);
+		trace_repo_setup();
 	commit_pager_choice();
 
 	if (!help && p->option & NEED_WORK_TREE)
diff --git a/trace.c b/trace.c
index 794a087c21..316070a43e 100644
--- a/trace.c
+++ b/trace.c
@@ -292,9 +292,9 @@ static const char *quote_crnl(const char *path)
 }
 
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
-void trace_repo_setup(const char *prefix)
+void trace_repo_setup()
 {
-	const char *git_work_tree;
+	const char *git_work_tree, *prefix = startup_info->prefix;
 	char *cwd;
 
 	if (!trace_want(&trace_setup_key))
@@ -305,7 +305,7 @@ void trace_repo_setup(const char *prefix)
 	if (!(git_work_tree = get_git_work_tree()))
 		git_work_tree = "(null)";
 
-	if (!prefix)
+	if (!startup_info->prefix)
 		prefix = "(null)";
 
 	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
diff --git a/trace.h b/trace.h
index 4e771f86ac..ca943037c6 100644
--- a/trace.h
+++ b/trace.h
@@ -93,7 +93,7 @@ extern struct trace_key trace_default_key;
 extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
-void trace_repo_setup(const char *prefix);
+void trace_repo_setup();
 
 /**
  * Checks whether the trace key is enabled. Used to prevent expensive
-- 
2.39.1

