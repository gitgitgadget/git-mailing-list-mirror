Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8322047F
	for <e@80x24.org>; Sun, 24 Sep 2017 12:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbdIXMJV (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 08:09:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37367 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdIXMJS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 08:09:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id e69so2457272pfg.4
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HQiGsStsueekIgEICRgx+3sumgm0sD94E7qYwof62go=;
        b=p1SLlDzvpyFSJAtWU5I3+6vet8M6ybjPiuz4pjJS5vDskOSDTkHyeasynFjzHU0d2m
         +uRlyi7ynR6Pn695lCZvOHfwAHDHNRteo4x/WQjYSA5zkRtXudV5pesv/jHUQ3Ru7NA2
         CoL+7kt7/4qo5bnrKhr1xsPC9AlK+MLwp37CEzUATnRb1AkOJ5b5xbv7LNxUxhEHEEDA
         KAM/gWmhKrX+/hQ1W1ttFMpWEuqSJ4dS7cSieoyRtlA2xQnnMWELTytk5O/FLKIwOtuu
         VRPDJ/nBLoJp8800jlyHSs0cl62OfOo9sWzxvraYTH3zuHT+Gqr8MXKDo6rmeq/x5xmw
         g6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HQiGsStsueekIgEICRgx+3sumgm0sD94E7qYwof62go=;
        b=krKEHBxyfEaB5S1rgWrb97zdp3cPnpfVWrMM/atExoWp3IDwhXUyum2tGV78u6Kyq6
         f4yH/j2miswZK0G5fdZCmRUHgpYiq+PIMxMz7V5Tffm9qUmmefrXkv3ukFsEVKXhmIt1
         k219jRqLOTTgXdqCc3x5IOUr6eaFW7GB4pv+yzaI/pYqKRs5G3j82UhSa3/xZ4NtVlaP
         DlBOn/QXsQRcjm5xSEPkPf9JWtBuuSJraJYv9z/P77HEL1rX3XjveXANKbsUHhWsnEgF
         yyg11q2MQYuP4GJmx4aXLFftjisI/3pje28BxQ/oMWCQvaSfa4k0dYnNTdq+Uk9VE4pk
         9iQA==
X-Gm-Message-State: AHPjjUh/46tmbZVQAuBtK5/hg3TKiFEDD/3NSumas9QUWJWFfJc+4sFO
        0Cp/sWBnOz387CmHJIAMKFA=
X-Google-Smtp-Source: AOwi7QDmHH1Tr5HxhVdocQGvMD7Ewd4dYJSwXY+4++z2aTFDSwNBDv1VMnKGIELzhrbcf3oJaoGsjQ==
X-Received: by 10.98.156.152 with SMTP id u24mr4382326pfk.255.1506254957244;
        Sun, 24 Sep 2017 05:09:17 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.87])
        by smtp.gmail.com with ESMTPSA id 65sm6908123pgh.31.2017.09.24.05.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Sep 2017 05:09:16 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     hanwen@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        pc44800@gmail.com, sbeller@google.com
Subject: [PATCH v5 1/4] submodule--helper: introduce get_submodule_displaypath()
Date:   Sun, 24 Sep 2017 17:38:55 +0530
Message-Id: <20170924120858.26813-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170924120858.26813-1-pc44800@gmail.com>
References: <20170921161059.11750-1-hanwen@google.com>
 <20170924120858.26813-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 818fe74f0..d24ac9028 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,29 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+/* the result should be freed by the caller. */
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
+		const char *format = (len > 0 && is_dir_sep(super_prefix[len - 1])) ? "%s%s" : "%s/%s";
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
@@ -335,15 +358,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
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
 
@@ -358,9 +373,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
+		strbuf_reset(&sb);
 	}
 
 	/*
@@ -368,7 +383,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
 	 */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
@@ -405,9 +419,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
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

