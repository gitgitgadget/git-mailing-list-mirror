Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B4F201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 20:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdGCUco (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 16:32:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35880 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdGCUcn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 16:32:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so26938039pfk.3
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bOXepOG0Rc2FK7g2KqREwG7yt/IvQZStff0aIWuVXeo=;
        b=Vz7lcKBYjXV02YrEjVeNIdNUvCiJovZJqmuBxz8ltTAT5bYSZOPRi1gdKjwtNad/qQ
         x/iZNV/Ouk7MPER8/XVoGjNDDuYR3meE70URBEv8VcGYmtTHOpTTfmVNkVnGfcmrB/6T
         qn+c1r0m4uAQGhEvKVHA7I1Q0uUQhjQpfhhq7EoabtjGBSSbOdtfABlqKgvGZOnl6skS
         r+Vpptq5qZSrgX7L2sMdM0MxlQeFOSjO04veQxw/y/rHgWuzMxpVvibA3GLFUJumc0y8
         3Y34CvHM12vuEOF1MQAKzEm2DbuuhfQwJnLbbqlC8TGIGg6tMd9RL6Paj0G5eosJgzlZ
         gSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bOXepOG0Rc2FK7g2KqREwG7yt/IvQZStff0aIWuVXeo=;
        b=euvpRLN6WpXPqzdJvYwoBcI3FkHZZdy463+UyGt3AA0IyrlwYxIC3tzyYlAZOJxzAo
         lLlh8vlSlWWoW24I9BAiWCyj6obivxE1mRUWNc/Ar607YxKw7ziz5Dr+l7P+2do8sFBN
         LBnYWj9vA234pGMUsb9Xw07h3ps9dyhe2jm8KPuH1IMoSW3MdJpIIyjLPDze+LUrw7c/
         2HvIRqrNcY+oL86v9J3AsLvygqcw61xWUYPoc4VxLbKtOxMtFeCS2zprruFQNse6m9or
         cFr4/NdG8LXFZntx9AF6B50RjldNSSOSKiU7hncGgcYZhT6MG65HjtY4+zMFg5uRc9XU
         ntFg==
X-Gm-Message-State: AIVw111Mm1jiqkWdayMpfZqkMPSNu5G/Z0q5EJ9TkbmVwj+qsjsuHtdG
        NLXs+FCxyRpdQnic
X-Received: by 10.84.131.6 with SMTP id 6mr12738368pld.33.1499113962133;
        Mon, 03 Jul 2017 13:32:42 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id y192sm28558594pgd.38.2017.07.03.13.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 13:32:41 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 1/5 v4] submodule--helper: introduce get_submodule_displaypath()
Date:   Tue,  4 Jul 2017 02:02:18 +0530
Message-Id: <20170703203222.14051-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CAME+mvVRSovmXLDUzz8dNiruvLrXFv3iUifqXDm+HwQDu1mJpQ@mail.gmail.com>
References: <CAME+mvVRSovmXLDUzz8dNiruvLrXFv3iUifqXDm+HwQDu1mJpQ@mail.gmail.com>
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
This series of patches are build over the 'mater' branch.

Complete build report is available at:
https://travis-ci.org/pratham-pc/git/builds
Branch: setnamerev
Build #119

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

