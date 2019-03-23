Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4EB20248
	for <e@80x24.org>; Sat, 23 Mar 2019 15:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfCWPZg (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 11:25:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47069 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfCWPZg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 11:25:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so3464280pfj.13
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Phnsw4zG02guc8oZcPcLY+WOWXthybQOjzshjFP+uuo=;
        b=FiXgMLidoWSw9uk6YCQTYgB5ruAzMYjYskVxUdoqV454mcPY1A/HnnAfvBs+oRzb4w
         XUbl5O23lP2W3OB84+2U3JLeNsE6H3JGvB+u/Fg0RIPJH7rhEaxgE1fjGRs7tsZFQ4G1
         rL62ctfWI7bV+NC3N2wyWLnUupSfiqBVZdaOCbGfkEpITOlwuE5hYpx1O+djJZFqC8lA
         pAp44H0jrn7qkcUq9hkE4BPpmTznfFkh+auq0MvhWc8jSCmU98ZrMLrMmGATGPDHMSmo
         lO92vQUfUuan4cx1V4gJOmqSJCcl22sSBKDEptmOInfgDtZ0CFnTQcRTFHiCf6eUnUmc
         ugnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Phnsw4zG02guc8oZcPcLY+WOWXthybQOjzshjFP+uuo=;
        b=KPKrwj0iFvNEmtGW7nmZwcMvn+kHamadjHOAj8H5EjpkjdOqypKfgC3uPk8YPGek3v
         vDR9Np92Jr5cUCDDzEh//tVN35p0r9Z6TxhE/R/jNthUQpFQld9GK/5u3fSQeQBczeAE
         cFctDGavG7TXchK+a6JNxsU4Cupves6g27nGHQ/i8HuNO894s3CCxKrM656TDYh2xmWX
         smzQZVWrcWS8G6VSyN9YXq4wISTrdZZYXcZewfmi1Fc/+eoShcwwyNBFh5AXwwOcb/Tn
         5FmkcyKHJ01Fe0p/HTREJL/EtrcqYa3vgNoG3pDgmaqjmIiCuMWEsLuSvgpPafPkRp3b
         hR9g==
X-Gm-Message-State: APjAAAU9B+asINK8SWEoMW8cm1lDeZvTmI44hh4CH06gFxmMMS5zD0gH
        BPS34MWSCflbPYXu2HqIhB1ru03L
X-Google-Smtp-Source: APXvYqzVZCXIT6AaU4gAIt5M9Z2ZeWnmqPrqM0YGqk48WMZoHC2ATVoRn0oD9ZhhyxjJccubHQyPbA==
X-Received: by 2002:a63:4e64:: with SMTP id o36mr14081499pgl.213.1553354735686;
        Sat, 23 Mar 2019 08:25:35 -0700 (PDT)
Received: from archbookpro.localdomain ([172.56.17.211])
        by smtp.gmail.com with ESMTPSA id j14sm14209528pfe.12.2019.03.23.08.25.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 08:25:35 -0700 (PDT)
Date:   Sat, 23 Mar 2019 08:25:28 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] rebase: teach rebase --keep-base
Message-ID: <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
References: <cover.1553354374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553354374.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common scenario is if a user is working on a topic branch and they
wish to make some changes to intermediate commits or autosquashing, they
would run something such as

	git rebase -i --onto master... master

in order to preserve the merge base. This prevents unnecessary commit
churning.

Alternatively, a user wishing to test individual commits in a topic
branch without changing anything may run

	git rebase -x ./test.sh master... master

Since rebasing onto the merge base of the branch and the upstream is
such a common case, introduce the --keep-base option as a shortcut.

This allows us to rewrite the above as

	git rebase -i --keep-base master

and

	git rebase -x ./test.sh --keep-base master

respectively.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77deebc65c..fffee89064 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -27,8 +27,8 @@
 #include "branch.h"
 
 static char const * const builtin_rebase_usage[] = {
-	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
-		"[<upstream>] [<branch>]"),
+	N_("git rebase [-i] [options] [--exec <cmd>] "
+		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
 	N_("git rebase --continue | --abort | --skip | --edit-todo"),
@@ -1018,6 +1018,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
+	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
@@ -1051,6 +1052,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
 			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL(0, "keep-base", &keep_base,
+			 N_("use the merge-base of upstream and branch as the current base")),
 		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
@@ -1217,6 +1220,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (keep_base) {
+		if (options.onto_name)
+			die(_("cannot combine '--keep-base' with '--onto'"));
+		if (options.root)
+			die(_("cannot combine '--keep-base' with '--root'"));
+	}
+
 	if (action != NO_ACTION && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
@@ -1541,10 +1551,19 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Make sure the branch to rebase onto is valid. */
-	if (!options.onto_name)
+	if (keep_base) {
+	    strbuf_reset(&buf);
+	    strbuf_addstr(&buf, options.upstream_name);
+	    strbuf_addstr(&buf, "...");
+	    options.onto_name = xstrdup(buf.buf);
+	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
 		if (get_oid_mb(options.onto_name, &merge_base) < 0)
+		    if (keep_base)
+			die(_("'%s': need exactly one merge base with branch"),
+				options.upstream_name);
+		    else
 			die(_("'%s': need exactly one merge base"),
 			    options.onto_name);
 		options.onto = lookup_commit_or_die(&merge_base,
-- 
2.21.0.512.g57bf1b23e1

