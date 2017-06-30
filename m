Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754D8201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbdF3Trv (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 15:47:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34189 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbdF3Trs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 15:47:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so16291594pge.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oHZ89fUZaqLhG2gLRcqAGxFtzKJXPiWO3BKVEeUsxnc=;
        b=t8lWN1kC/lvUEwUiC9hQa9/5IGBL0XutVFegRCjiYJeMWVqLaXg7x7fq7QJ8rA0FdM
         Oz0h58o070L4dFYzZU93H4+hZBpRuBJXHlouykkAaKNm0CSkhHBe6weFwk3qnhOSQrI1
         3fBcM5JdZa4hX+w91DPnNYe2MKO92v0iiYs86l4H/boyjeIMqji2R1tZGz97UoQCFddh
         Y4DJ3ThjICA9vw4LBbrOLESy2xsQ25V6SNQT7HEA8KcXjwJIk3Kf9f7pGJGdxKXrHl0w
         iwr/JnnMdJnQ90HIW7OJsl/Txal0RRypeX7tsix2OBc/ZF2bnwBq7t0vhGQ/VdCS+fOJ
         dMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oHZ89fUZaqLhG2gLRcqAGxFtzKJXPiWO3BKVEeUsxnc=;
        b=QdWycP9WJazzIipLE8rDhqKgTwqdiUcTfZSRbL0qg0vO6r2WCr2gUd1+lr79Y5ddHJ
         Un5fJomRPIs94dIWGGFaeFe+zTzdI0i+LwKXWeyTj5JdzW41FmQBzerFEiBdU7a5rtS5
         +0uknDi5tLanM+9rNS0QS5D5gIvJdonllPIJJ+3DrmczDNMtb5gg4Z9ubIfVSJBAbwcN
         0rgvwgeeOM0WTH+em8lVU/r8DeeKkKSf2+j0LUm0Vqw5tv4/QGU1SvA2QtosStpKjfLP
         E0A1gm2P97qSTJ2nShXiYbXn/5YXLyam9sN+mqcwS6HlyqecmvFZcG09A4OXqsQ4N357
         NlMA==
X-Gm-Message-State: AKS2vOzWC4nAwYpHfozVqrG/7AsToec8ckqXmHWNv9iDuvz1LlmF/62G
        hNl3ay+HY+Nvm5an
X-Received: by 10.84.229.71 with SMTP id d7mr26676130pln.231.1498852067522;
        Fri, 30 Jun 2017 12:47:47 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id g10sm20972131pfc.38.2017.06.30.12.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 12:47:46 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 1/5 v3] submodule--helper: introduce get_submodule_displaypath()
Date:   Sat,  1 Jul 2017 01:17:23 +0530
Message-Id: <20170630194727.29787-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function get_submodule_displaypath() to replace the code
occurring in submodule_init() for generating displaypath of the
submodule with a call to it.

This new function will also be used in other parts of the system
in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
The patch series is updated, and is based on 'master' branch.

This patch series contains updates patches about
Introduction of the function: get_submodule_displaypath()
(This patch wasn't posted in the last update by mistake)
Introduction of the function: for_each_submodule()
Port shell function set_name_rev() to C
Port submodule subcommand 'status' from shell to C
Port submodule subcommand 'sync' from shell to C

Complete build report of this patch-series is available at:
https://travis-ci.org/pratham-pc/git/builds
Branch: patch-series-1
Build #114

Also, the above series was also build by basing it on the 'next'
branch for the purpose of testing the code.
Since the function is_submodule_initialized changed to
is_submodule_active, this change was required to be added in the
above patches while basing it on next.
After doing the required changes,
Complete build report of the above is available at:
https://travis-ci.org/pratham-pc/git/builds
Branch: patch-series-1-next
Build #116

I have held back the following patch since some work is still
required to be done:
Port submodule subcommand 'foreach' from shell to C
Port submodule subcommand 'deinit' from shell to C
Port submodule subcommand 'summary' from shell to C
I hope to complete this and post these patches later with the
weekly updates.

 builtin/submodule--helper.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8517032b3..1bfc91bca 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,27 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
+	} else if (super_prefix) {
+		int len = strlen(super_prefix);
+		const char *format = is_dir_sep(super_prefix[len - 1]) ? "%s%s" : "%s/%s";
+		return xstrfmt(format, super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -339,16 +360,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
-
-	if (prefix && get_super_prefix())
-		die("BUG: cannot have prefix and superprefix");
-	else if (prefix)
-		displaypath = xstrdup(relative_path(path, prefix, &sb));
-	else if (get_super_prefix()) {
-		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
-		displaypath = strbuf_detach(&sb, NULL);
-	} else
-		displaypath = xstrdup(path);
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(null_sha1, path);
 
@@ -363,7 +375,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_initialized(path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 	}
-- 
2.13.0

