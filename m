Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5ACD1F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 11:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdH1L40 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 07:56:26 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33462 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdH1L4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 07:56:24 -0400
Received: by mail-pg0-f68.google.com with SMTP id m15so218412pgc.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9bZGT7pIgM2V9nwaFwpPnbBXVQf4qc6ze3EMGf6afU=;
        b=Cizas3RoKl591ZEruybTf7mcpU0JNHplOoXiYWI1RUWOESZVcIWqjF39wmKKDvQXqE
         NHPnEuX3fdIpx30GR5kajaZmU9BAcgSYbQ5zYmx9/z1QMg32crgSZnvHcuGkerhK8nRL
         EmxNXnVA3bNgPpRDivDoLrR4q5zFOOF+Itr3qVZaLAtTM4Z9ZFnevUP/bkJyBOOaS0b4
         h3v/zisGmS4Z0T70hJZceq0huv+psxUM83DfbGAHPPrqbQhfw2Y4vZqQiZfhOi3+rOyy
         idXTSHBHYgdSROQ/Z37PSxSU8J3W2lA36aV/nYDkyCqCkFSjMVyhnyiVfb8C3lY3+j1I
         0DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9bZGT7pIgM2V9nwaFwpPnbBXVQf4qc6ze3EMGf6afU=;
        b=s0/KcnEZBEaBcSFfflGHZFZQGrNMfpxK12nLQMAnCDS7XmIw0BXuC7VtCFQPeCB4aJ
         aVAUiRTcWDkmvgXK6oeJWjW+1DKEzhNjS08Qr4m+ADcylw9HzI5+/WKdS/mgHF1JkdMJ
         oRt9P+sQ8vy7o4tTSfdKuQVJBJmgAJ+DSB/y60ufuMJjRsOx7cVrTLqlfAWJpCAoVDHn
         0DgabIbDv4U1VABS1F4QKhBQxC+xRXusH+7bztLEeBVn+NXPnUuv4NpeqpBWhsb8xTHw
         ra+wBUZHdF33xwzichkwEF2rQLE6h3CnHxJiAZTkVJ7Yi5BD6T4EIgFWz3u0vFzwZSyj
         O3Dw==
X-Gm-Message-State: AHYfb5hdfPifeCS1xFhn04RZ4K9Ba+kj9phtCHLf7XYXBVGZ/iV/7IcQ
        FVwGIhUAtFKOOkPEXZXc+A==
X-Received: by 10.98.101.131 with SMTP id z125mr195670pfb.307.1503921384098;
        Mon, 28 Aug 2017 04:56:24 -0700 (PDT)
Received: from localhost.localdomain ([223.176.49.60])
        by smtp.gmail.com with ESMTPSA id h70sm748608pfc.92.2017.08.28.04.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 04:56:23 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v4 1/4] submodule--helper: introduce get_submodule_displaypath()
Date:   Mon, 28 Aug 2017 17:25:55 +0530
Message-Id: <20170828115558.28297-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170828115558.28297-1-pc44800@gmail.com>
References: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
 <20170828115558.28297-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 818fe74f0..e25854371 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,28 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
+
+		return xstrfmt(format, super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -335,15 +357,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
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
 
 	sub = submodule_from_path(&null_oid, path);
 
@@ -358,9 +372,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
+		strbuf_reset(&sb);
 	}
 
 	/*
@@ -368,7 +382,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
 	 */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
@@ -405,9 +418,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
 	}
+	strbuf_reset(&sb);
 
 	/* Copy "update" setting when it is not set yet */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
 	if (git_config_get_string(sb.buf, &upd) &&
 	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
-- 
2.13.0

