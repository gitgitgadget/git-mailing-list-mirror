Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C3C61DA4
	for <git@archiver.kernel.org>; Sun, 19 Feb 2023 00:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBSAZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 19:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBSAZx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 19:25:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68A13D5C
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 16:25:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e20so1475392wra.4
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 16:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvFrZqYoygyxo5mqLznxoj6WwXN4o7NEBUaK4OBIdf0=;
        b=M9ZUm5U9mkhSm7CZNalitUurq2/wCAFwzCIkpxZZrqZHBGnuEd67wZCW4eW6sGsj52
         /E6pU+KGFAN65bSYdsActNlLT9S9CDDMpFypLkPV2giCk/7vvQqfa5blZAesw9W5z755
         ShbGlcx6jUq2/vt3IyRHSxNp80h5SfNurHjBCa3HE3HNXqi1jzCOe0nTwX7R6hk3rEyr
         Pddp+BDPOM7dtEv0PI7k2hP9ooCjYnNYbdea1llWJE2uXGXYEQMnguvD+RT5dYMr+41U
         ySbBnX/bqGAc//Cy1doPFKTsRSi/DMWPqZ2uk6jKwoQfcg/nda2BuWUk51llEccZJRpc
         ydHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvFrZqYoygyxo5mqLznxoj6WwXN4o7NEBUaK4OBIdf0=;
        b=quIZSWmdEgi5+IAK5wH22IE8VEut68WvA3sznCyiF4cycuE8uh4mQAFc38aNdTyBHB
         AdT6ym3G+MoSG/VGHVrCYYy/9CXyXfJg8zI/QjPJ2W8i7wG39EBPfNKrTH5dpOeOcgwC
         1KQmilGztSJPc3qv1HhXVhHv5VfJ+ZXE/sSad9AxpCRw1luJKnBHh294D95IKIg9alV6
         jrWN64fJR77tH+IsnXmbH4yrJqmaT6DxuAAQHeDVmSisv+S2Nd8VcySJ02wVJjtq0UBu
         3ca15+aW6hQh8V1DuFIcz62Zmso1HzhYvTtBO8dBXUM84vxIOE7LFi4T9GpOkP8EZ+2Q
         o8TA==
X-Gm-Message-State: AO0yUKU4hG/zf7EOc8nUIBmSzmhRMZdWMCpMO4H7lcNiYSCbGZ8FHVhW
        Zw3hVtv39WtOEIOH1o3gWmFHZHEeoEQESA==
X-Google-Smtp-Source: AK7set8QRyoVTxu22n7USDmhmis60hT/nSZS5JSwowGKe8MhvA2kbBFit9keQlskpv+U0BTvmBeWRA==
X-Received: by 2002:a5d:6906:0:b0:2c6:66f1:3b5d with SMTP id t6-20020a5d6906000000b002c666f13b5dmr1065888wru.12.1676766350017;
        Sat, 18 Feb 2023 16:25:50 -0800 (PST)
Received: from localhost.localdomain ([41.108.250.66])
        by smtp.gmail.com with ESMTPSA id c11-20020adffb0b000000b002c5503a8d21sm2076453wrr.70.2023.02.18.16.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 16:25:49 -0800 (PST)
From:   Idriss Fekir <mcsm224@gmail.com>
To:     git@vger.kernel.org
Cc:     idriss fekir <mcsm224@gmail.com>, gitster@pobox.com,
        cheskaqiqi@gmail.com, christian.couder@gmail.com
Subject: [PATCH v3 1/1] trace.c, git.c: remove unnecessary parameter to trace_repo_setup()
Date:   Sun, 19 Feb 2023 01:25:27 +0100
Message-Id: <20230219002527.84315-1-mcsm224@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230215104246.8919-1-mcsm224@gmail.com>
References: <20230215104246.8919-1-mcsm224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: idriss fekir <mcsm224@gmail.com>

trace_repo_setup() of trace.c is called with the argument 'prefix' from
only one location, run_builtin of git.c, which sets 'prefix' to the return
value of setup_git_directory() or setup_git_directory_gently() (a wrapper
of the former).

Now that "prefix" is in startup_info there is no need for the parameter
of trace_repo_setup() because setup_git_directory() sets "startup_info->prefix"
to the same value it returns. It would be less confusing to use "prefix"
from startup_info instead of passing it as an argument.

Signed-off-by: Idriss Fekir <mcsm224@gmail.com>
---
Thank you very much, Christian Couder.
 git.c   | 2 +-
 trace.c | 7 +++----
 trace.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

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
index 794a087c21..efa4e2d8e0 100644
--- a/trace.c
+++ b/trace.c
@@ -291,10 +291,9 @@ static const char *quote_crnl(const char *path)
 	return new_path.buf;
 }
 
-/* FIXME: move prefix to startup_info struct and get rid of this arg */
-void trace_repo_setup(const char *prefix)
+void trace_repo_setup(void)
 {
-	const char *git_work_tree;
+	const char *git_work_tree, *prefix = startup_info->prefix;
 	char *cwd;
 
 	if (!trace_want(&trace_setup_key))
@@ -305,7 +304,7 @@ void trace_repo_setup(const char *prefix)
 	if (!(git_work_tree = get_git_work_tree()))
 		git_work_tree = "(null)";
 
-	if (!prefix)
+	if (!startup_info->prefix)
 		prefix = "(null)";
 
 	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
diff --git a/trace.h b/trace.h
index 4e771f86ac..b6e35b9470 100644
--- a/trace.h
+++ b/trace.h
@@ -93,7 +93,7 @@ extern struct trace_key trace_default_key;
 extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
-void trace_repo_setup(const char *prefix);
+void trace_repo_setup(void);
 
 /**
  * Checks whether the trace key is enabled. Used to prevent expensive
-- 
2.39.2

