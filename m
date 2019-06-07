Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A331F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfFGBJM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:12 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37498 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:12 -0400
Received: by mail-pf1-f202.google.com with SMTP id x18so303254pfj.4
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gA6z56v919bqdiDLMiR2LscBxFAIVVuC8++8ttiUOPI=;
        b=LiXmu2F/kGN9+Op9GJoPbt2UGxr4w2QUsIui34Yx+kXy/xur+tt6WQtEux5XrPXTL5
         R8vqW7tjY2BgAznFFbij/imkbVYoelueFvnSZKwqAy1QBuIEMCvVANCgRtAw7f0LkyWM
         cLiJnrKLsIRS0TerjbCCCM5Xbk2NdhrG8goXMWAeIe/475ZxnvwpvXvJioNou4trS4UA
         mcCmQRxu/bpcRUbOaHGOuAUvS6UGTuexrmB0/jQW4fXjd5skXQoD5hIhyOSEQpSJlJtY
         GbUdR1KbVD8alPZZIHbtFJBs2piplmNyTX5iYi7uiFE+6o2cGePaTVOogGjpLLft8b0d
         OIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gA6z56v919bqdiDLMiR2LscBxFAIVVuC8++8ttiUOPI=;
        b=Glr351Trp6A1cqSna6nJ9qlsHqSC/2ZxaKZVARj7nSy5ev4596gb2ZNBcMmSkwt3OV
         uUPEQpV8V40HTIZRL72xVVWRHU0AmboIxnpz1WxLTU/OuwEXi54uyGumeBrrznR3s8PU
         W3c5exjm7lSFhmS1ZOfwi5fylVaK5OCG8zA7YqMotHnOS/c+0gr4BoZH1Pndnu1HOf6s
         dg/ft2GXpw08unlnNADHuQZ3o+aesqtXyYW5swo9W8kWpz1yMc7RAjnkBK5LeLXInJp6
         cPXQHYp/wl9+pGflcnY4IccDUSmnga7x+3O1S51xHspCmrbwVpz0JJte+MgQrQ6Jwdd4
         1ofg==
X-Gm-Message-State: APjAAAXCWwJ/MgOG3noC4yzh028P1RTzz3ydcUbLns/7QeAo+vJY24ln
        Jkfr/2SNOsfEPAhh/CAeRc2Dz+HLj2knUjZMzGnGbc65m4yqj4XtsNyRA2JGrdfTIeCmkPHYRzA
        l2k8ebnTIIpOtTiD+ZvF6E1lvDWcafhMS+pNDhT1uXqe1FPfNnhtiF/wooy3mYXWEBaLPKCDVSw
        ==
X-Google-Smtp-Source: APXvYqx3Uvc2ssESvoBGmWo+x5J2MxfLYqQ3DCPw+ZQGRklYGq3T/d50lDTVQWeiCLko1rFi1utzd1cL0haI7tG5XoU=
X-Received: by 2002:a63:1516:: with SMTP id v22mr595360pgl.204.1559869751535;
 Thu, 06 Jun 2019 18:09:11 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:05 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 07/13] walken: filter for authors from gmail address
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to demonstrate how to create grep filters for revision walks,
filter the walk performed by cmd_walken() to print only commits which
are authored by someone with a gmail address.

This commit demonstrates how to append a grep pattern to a
rev_info.grep_filter, to teach new contributors how to create their own
more generalized grep filters during revision walks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 9cf19a24ab..6c0f4e7b7a 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "pretty.h"
 #include "line-log.h"
+#include "grep.h"
 
 static const char * const walken_usage[] = {
 	N_("git walken"),
@@ -25,9 +26,8 @@ static const char * const walken_usage[] = {
  */
 static void init_walken_defaults(void)
 {
-	/* We don't actually need the same components `git log` does; leave this
-	 * empty for now.
-	 */
+	/* Needed by our grep filter. */
+	init_grep_defaults(the_repository);
 }
 
 /*
@@ -51,6 +51,10 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 	opt.revarg_opt = REVARG_COMMITTISH;
 	//setup_revisions(argc, argv, rev, &opt);
 
+	/* Add a grep pattern to the author line in the header. */
+	append_header_grep_pattern(&rev->grep_filter, GREP_HEADER_AUTHOR, "gmail");
+	compile_grep_patterns(&rev->grep_filter);
+
 	/* Let's force oneline format. */
 	get_commit_format("oneline", rev);
 	rev->verbose_header = 1;
@@ -77,7 +81,7 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
  */
 static int git_walken_config(const char *var, const char *value, void *cb)
 {
-	/* For now, let's not bother with anything. */
+	grep_config(var, value, cb);
 	return git_default_config(var, value, cb);
 }
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

