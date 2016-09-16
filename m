Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1442070F
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757327AbcIPAMw (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:52 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34838 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757290AbcIPAMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:33 -0400
Received: by mail-qk0-f194.google.com with SMTP id w204so4450487qka.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Y0jb8NOiGyjGg5fzVURBk3tzb97pQomYf80wzoDMAbQ=;
        b=zBlcfF3tj5QivQRObvglDhxrps28QwMHSJ+rQ+WOtgYQo+BlfBXV7v5U8AchmNLBBb
         b8/UyMv5twW84c6Q+eNJQ2xLiuXWl9M48q9qz4G6koiY3PyJHRFPCTEW73hY4XrORfDP
         Rru24oE6fcVTpn+u7x1uxltwxpbDJ2Ku2r61PRuTMQbgN3SZFadG/mlgNYDzO9XTc4nL
         KH8ufRZqHreFI1Xq+3EFOU0AhhbHhuC5YVtaDRjv4MlV7zdLhXnpOvySlHPaKhMV7Uk1
         dolX9EEu6hEJZXG0v6e3iUZCe7zO7roi75HTFOLO7F5JKv3VwMgKpOZNuKv6ZwVJIh0Z
         HBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Y0jb8NOiGyjGg5fzVURBk3tzb97pQomYf80wzoDMAbQ=;
        b=PKN3xOFFUACDPzg4dgVuAIE772eDtThYTIcXaiWngwuT4esS1JyyftIIN0roXElQYz
         yBarkw1QQsFBUQxINRUjI7ipvQhVskrzR85YKo/VDTEd2zc3dBOS9ChafwNzSRlEHFch
         xSPkyKlnXUnTHEk0Ml3ITaGuR5WCV4/v7BV9fghCj2Lnowqnr4NFapoMRdHZDCUVQ3Bu
         hXCw0S5DBENbbE9Zvp2WMDTPpEb3CuY+By+1FsM0jHC3z7Xm0gJJ05YRCGeJuuP+4TIV
         cdUYo4J1IVwfjwxnZq2C0NeF8zAbion7DJcEVow0ocrxisM0f8AXRNSf8Ghy8SxYpXpg
         fRSg==
X-Gm-Message-State: AE9vXwMstLNTxtWj7Tl/PCFl3tbe8qLwpfjb+f+LXJ01PoAxmpBNJvIA+HeaW46pGLF+jg==
X-Received: by 10.55.191.132 with SMTP id p126mr4086765qkf.302.1473984752015;
        Thu, 15 Sep 2016 17:12:32 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:31 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 10/11] run command: add RUN_COMMAND_NO_STDOUT
Date:   Thu, 15 Sep 2016 20:12:21 -0400
Message-Id: <1473984742-12516-11-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add option RUN_COMMAND_NO_STDOUT, which sets no_stdout on a child
process.

This will be used by git clone when calling index-pack on a downloaded
packfile.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 run-command.c | 1 +
 run-command.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index 863dad5..c4f82f9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -574,6 +574,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	cmd.silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
 	cmd.use_shell = opt & RUN_USING_SHELL ? 1 : 0;
 	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
+	cmd.no_stdout = opt & RUN_COMMAND_NO_STDOUT ? 1 : 0;
 	cmd.dir = dir;
 	cmd.env = env;
 	return run_command(&cmd);
diff --git a/run-command.h b/run-command.h
index 42917e8..2d2c871 100644
--- a/run-command.h
+++ b/run-command.h
@@ -70,6 +70,7 @@ extern int run_hook_ve(const char *const *env, const char *name, va_list args);
 #define RUN_SILENT_EXEC_FAILURE 8
 #define RUN_USING_SHELL 16
 #define RUN_CLEAN_ON_EXIT 32
+#define RUN_COMMAND_NO_STDOUT 64
 int run_command_v_opt(const char **argv, int opt);
 
 /*
-- 
2.7.4

