Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93C92047F
	for <e@80x24.org>; Fri, 29 Sep 2017 09:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdI2JpG (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 05:45:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36077 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdI2JpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 05:45:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id f84so985894pfj.3
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=elbVIdFunYkuAXq5vckSSEQmoIWronB0aDaAhfI/b6g=;
        b=IwKHd4/B9sIB0zVQCQ7BmKm+K8rs+me1xObbPCTGx1y3LLw+dLgEmyaxxIRBPAfHmq
         RjqzkNYusWpVT4Em8oeKAnKIywf28K6i/bs+DbP//LF5+PLppX1NXTK445ZkH3Gwl5Q3
         fe2C+oRa33eaAmDH5vtId2pv8sF8fxlXlxhed48Zv877pQHVHRaDFLwSV+D3GrKhCMQV
         mP4x0XZmGD+5cLOgCdaN/x/3Kum/WxwCxpMhchEKpfmUr/H5f+kWoDdjRDuPWlK6dZr/
         NS4cGQH5HDAxziHCkNXx+YGRSJJirCKeU8BXZttGluRGmBpWdVT4u8G5oE0mRCZBEd8B
         Rajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=elbVIdFunYkuAXq5vckSSEQmoIWronB0aDaAhfI/b6g=;
        b=aDYpod2vOrvWxoL2N+zRKDTjGTDXhlV3eNXpnbfmQY7xcSv6I0KlE+EGSzQX3dVs87
         u3JYaq7j6IvA1uehfbB9xK5OtQyazOQURsftKrIBkRKKFoF14rsv9JKQUCFqTl1dzGtT
         kUyGzSWOCdNwWgJd5MMlcbK/MVjTmWInmkYZG71VEW6WUP/hS0S7A1Zmu54xAaYj8DzF
         9I2IJqbKY0MSTSM1MFdBItRB93AdUODZuolxj/MDzf7wEEkI6CwuOXilggtWzv3dahSM
         oCiG6pH8lbhzao0SKWp0F5vOGSQyLfeKrrcHwkVl9QbOMcMtrVEW2h60A6zEDMhIMCnx
         bewg==
X-Gm-Message-State: AHPjjUjozVOsxhPrwmcqok6CtSTkkUuxVKCTpA4Hh4mxJ5iWTgV8b2oV
        /5gAa3PbYxYqCaX+howzMdc=
X-Google-Smtp-Source: AOwi7QDSsl3tUbohVPn0x/BJTUvyjj/KhPmA0oTlqS6S5iHnYBMM02UWZQoKCsZZlgz5/mbs5frHyw==
X-Received: by 10.98.65.20 with SMTP id o20mr6897061pfa.211.1506678303628;
        Fri, 29 Sep 2017 02:45:03 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.87])
        by smtp.gmail.com with ESMTPSA id s76sm6930477pfj.119.2017.09.29.02.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 02:45:03 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sbeller@google.com, Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v6 1/3] submodule--helper: introduce get_submodule_displaypath()
Date:   Fri, 29 Sep 2017 15:14:51 +0530
Message-Id: <20170929094453.4499-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20170929094453.4499-1-pc44800@gmail.com>
References: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
 <20170929094453.4499-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 818fe74f0..cdae54426 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,26 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
+		return xstrfmt("%s%s", super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -335,15 +355,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
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
 
@@ -358,9 +370,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
+		strbuf_reset(&sb);
 	}
 
 	/*
@@ -368,7 +380,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
 	 */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
@@ -405,9 +416,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
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

