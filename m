Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4D420951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbdCNVr7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:59 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34331 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdCNVrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:03 -0400
Received: by mail-pg0-f41.google.com with SMTP id 141so638363pgd.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihD4+nNTpp4O/UYIAMAO12FyPZpXBU+yQ2N2SZvDhVI=;
        b=gmNyZ+1mBNTA+X1qE50s6RPxPrbuBGFa+h2gvnBkq8ozH08Th8hjRiI1WKtC1R7nF+
         N/iVmQYLM/LeCG3uiM5nPxYHIvA1WKcM88zDSB4x+CEMzUF7oJSdqHL29esWsC8ujE/k
         nGPv88Uo6UnR/aXGp2rv8CKbdEMBWbx58bvLuu1V7N/2AuQbwCrY0tOQwnke5WDMdN1H
         6BPX905QWCtKGd1mdoD56zySAbsktM7vpE4ugvQQELPkNRlUgeTXb/7AMsIRsmxYBhBd
         6Klvu2hYrmfReIahMKNB8JoTkhvDQqPIt3VfgMbMkVV9sAHyfI9ooiW/bykfYAimhMF3
         V7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ihD4+nNTpp4O/UYIAMAO12FyPZpXBU+yQ2N2SZvDhVI=;
        b=ACm1t0wD8IxPPlOfi6pNn37f8KCgZDsEWwOrRz7npEotSt7a76TfSffq1xQ4viXCan
         hbNjFmmNAoLFpCCY+bzEvz5FX63N1fqLun2X2kh53fbzIeKCLXhDzK8oHMSQnmT2Zx2O
         ekxFxUMD2xNCB0fz8tNgD7hGo7g26WBPxIhPbuSQgIiIQ5r3E7jBiotFDx4Wp4K/Xk0j
         mRM02xEXKh1uCgH1bA/bPZYkh5zILp7PJMN0D1IG5Rn5NOcWouE4L7WiXl56Ts2PoTB6
         HZ9yHgVleIRDT/+0XNDq/vkfqbzO62Sxi1U1TyyMUR94tUP+yxWtBLukd7jkY5pObptn
         NERQ==
X-Gm-Message-State: AMke39l+wZ+3ZwEwWQypPdAsp3+I+BOOvwTMGUvuCHOSi6/X2P+NxV8AS0R78bTZo9ePQUJy
X-Received: by 10.99.168.5 with SMTP id o5mr46148183pgf.148.1489528021700;
        Tue, 14 Mar 2017 14:47:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id g27sm40270214pfk.95.2017.03.14.14.47.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 10/19] update submodules: add a config option to determine if submodules are updated
Date:   Tue, 14 Mar 2017 14:46:33 -0700
Message-Id: <20170314214642.7701-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we introduce the options and flag for commands
that modify the working directory, e.g. git-checkout.

Have a central place to store such settings whether we want to update
a submodule.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 6 ++++++
 submodule.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/submodule.c b/submodule.c
index 04d185738f..591f4a694e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -17,6 +17,7 @@
 #include "worktree.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
 static int initialized_fetch_ref_tips;
@@ -542,6 +543,11 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+void set_config_update_recurse_submodules(int value)
+{
+	config_update_recurse_submodules = value;
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index 0b915bd3ac..b4e60c08d2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -64,6 +64,7 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
+extern void set_config_update_recurse_submodules(int value);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

