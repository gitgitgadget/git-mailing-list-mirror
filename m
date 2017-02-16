Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB362013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756250AbdBPAik (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:40 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34246 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756244AbdBPAie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:34 -0500
Received: by mail-pg0-f49.google.com with SMTP id z67so898822pgb.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w1cI2EFWb9lMxcuuzSyOwJyetS/w05jlCg34NcUCfxc=;
        b=ij2TObnAElwdvAgY4fmNEB7YjbLe2hXNfBWrw9LBYPzS7NPUqhPLeVmqFinWg9RBor
         fwEO1iH8MB0k5l8OEVaQVmtrGjGV98Z+mJeZCONAUE4UZfJ/idGy3xyHCfYL+yeS0vox
         NnEmd3g6z7yW4kPPDFRJpSc9uYRQfHKRRKsKcLrE3Z8xUAzNTKLpOgC38YXaMtC1Lw9R
         IPahx/HFnWCQsx2pZIyPCuBw4w+YPtB7q0RQMcMHzlBFS3qSV8FUzrG2/MFEvG424BwU
         MzN71TNBXFShD93hKiUDDas8DraCPId3duhMc6mUYBDlJzQZ/w4v0ePVjVtoqsAtmub0
         ML3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w1cI2EFWb9lMxcuuzSyOwJyetS/w05jlCg34NcUCfxc=;
        b=WeD/i9sR3o/NYuoApjhxh6Rw/hTbpEH62SJrclZvGy7z7+/XPGVlNjR+lUTTy8x4KY
         o2HsaeUjion82k9FcZJScSEt0z0LJLutbtkBJCHQjiZivF+xTCyA+y99+4+hYXW4NfjX
         y7CeYruLf3JpeqxVqe7LiQyJXkwfwHJIXkH3PsSLas89ygoCIVEOrW1vgt1PbSy/+q/G
         RBKYyNLbOHFDRVCPw1gSksx64WpVRjdbnPLsqFoAqQZhEw2whmwlcEWR9tNtfA61mQhM
         He1l8imEOQ7mK9eLuj+3KimwPMK35vcFp/IQ8xdnsOBIxpAdQwjCjtJYej6LL5hMje2R
         vuEw==
X-Gm-Message-State: AMke39mMv/8bBXsoof9sp91f+5eu84C0/e1lSPqmQBiPG9yNt/nXRKBf91SIIe24shiHefas
X-Received: by 10.98.103.195 with SMTP id t64mr40947726pfj.106.1487205508309;
        Wed, 15 Feb 2017 16:38:28 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id n70sm9577547pfg.34.2017.02.15.16.38.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/15] update submodules: add a config option to determine if submodules are updated
Date:   Wed, 15 Feb 2017 16:38:03 -0800
Message-Id: <20170216003811.18273-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
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
2.12.0.rc1.16.ge4278d41a0.dirty

