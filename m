Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25482047F
	for <e@80x24.org>; Fri, 29 Sep 2017 09:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdI2JpJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 05:45:09 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32938 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdI2JpH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 05:45:07 -0400
Received: by mail-pg0-f65.google.com with SMTP id u136so1084408pgc.0
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QFE/F0NBbaVr/XkghRGpxEbL6uIWvNlPNIwYiO2R83U=;
        b=Jzuwvin/OGdBo+4KS7urlmwB+GQOp8J/xJtk3QITkO2MzzfgFS+8BsXB1SsMG1lXaf
         zypkwrmybJ30rKb0yO0xUOXVAxletlWXsuy8me7qGTnO24h9YIjdUeqsjIaAqy7+NXe5
         7bBjAKgDKMBl3b9DL/mnOKn32IkHxi01YCSajubSfypm9AZ/U16e5V/8aIeNqmkVBbPz
         tJIPgm80ptbtfks82jaFNXk++Vgwr2Pe8XqYbIu6E5xR4386bvy/kYJWpH3QEovExKf5
         HX1BDLSWDhgUC7lLtPk3Ey4I1RDB4jbfRvTC1BBHSXEs4S/MJyOXvfgVCFHxlRKlkXF/
         ysIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QFE/F0NBbaVr/XkghRGpxEbL6uIWvNlPNIwYiO2R83U=;
        b=Mh8licfwPPayV8QqA6NVNXtmyEM9aBKrEMBabKAYbY6WBHlQ2FRL+yR1c9EoLY3VuA
         93Laakb5SHAmJAet0Fv/ayS1v02N7P37RliXn3w0PXfb0dYqk8mxkpm8ObP+6YLjwpMg
         R/QS+mCriCxGgZXZHZRd4qpbBoCxas68VWCCoWRipHEuqZJ0RzxJv0W+YW4Wah08FPPQ
         Wpe1NpQk0A4LDEViURX7iKgRwAPUe9cOVc9dIL2gzPw1WbK3AawHgO/Vn7H2lSJZNycM
         RX2QuYgEPfiBBl+Uj0jrvYx/0oqmcTWEDCiXXlhSX9ooBBaDgoHqsJ8Nk74zYb2Wl970
         GD5g==
X-Gm-Message-State: AHPjjUgO9npBjRl55/wLnnDYkj2V/WH2lgRzz7hf3eQMa6mc7r8NzsRA
        FBJYb8M8kydgFupg7Chwjbs=
X-Google-Smtp-Source: AOwi7QAvVwA9BJ3fY6hy67CNEOproKT1UA5DDO1aY0LZ9KXZJBCqpf2Vqs/opuoKWlEKVAppIInDzA==
X-Received: by 10.84.234.200 with SMTP id i8mr6441050plt.275.1506678307043;
        Fri, 29 Sep 2017 02:45:07 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.87])
        by smtp.gmail.com with ESMTPSA id s76sm6930477pfj.119.2017.09.29.02.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 02:45:06 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sbeller@google.com, Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v6 2/3] submodule--helper: introduce for_each_listed_submodule()
Date:   Fri, 29 Sep 2017 15:14:52 +0530
Message-Id: <20170929094453.4499-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20170929094453.4499-1-pc44800@gmail.com>
References: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
 <20170929094453.4499-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function for_each_listed_submodule() and replace a loop
in module_init() with a call to it.

The new function will also be used in other parts of the
system in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cdae54426..20a1ef868 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -14,6 +14,11 @@
 #include "refs.h"
 #include "connect.h"
 
+#define CB_OPT_QUIET		(1<<0)
+
+typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
+				  void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -349,7 +354,22 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void init_submodule(const char *path, const char *prefix, int quiet)
+static void for_each_listed_submodule(const struct module_list *list,
+				      each_submodule_fn fn, void *cb_data)
+{
+	int i;
+	for (i = 0; i < list->nr; i++)
+		fn(list->entries[i], cb_data);
+}
+
+struct init_cb {
+	const char *prefix;
+	unsigned int cb_flags;
+};
+#define INIT_CB_INIT { NULL, 0 }
+
+static void init_submodule(const char *path, const char *prefix,
+			   unsigned int cb_flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
@@ -411,7 +431,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!(cb_flags & CB_OPT_QUIET))
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -438,12 +458,18 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	free(upd);
 }
 
+static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
+{
+	struct init_cb *info = cb_data;
+	init_submodule(list_item->name, info->prefix, info->cb_flags);
+}
+
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -468,8 +494,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
 
-	for (i = 0; i < list.nr; i++)
-		init_submodule(list.entries[i]->name, prefix, quiet);
+	info.prefix = prefix;
+	if (quiet)
+		info.cb_flags |= CB_OPT_QUIET;
+
+	for_each_listed_submodule(&list, init_submodule_cb, &info);
 
 	return 0;
 }
-- 
2.13.0

