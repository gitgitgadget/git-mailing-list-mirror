Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB5D1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933108AbeFYQqt (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:46:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42181 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeFYQqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:46:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so14373800wrk.9
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dAKP2BZqA1UibuK+I2lv+5q2mGNArThU6TM1eu1lUiQ=;
        b=KUK33oNclah9D56RbQRBuetShrjwWDMjhyd9ougTrInYMnRp56IJ4avHzZ9P6Nk32n
         taF+9aTbvcU5l2BODtZpSyDvDdcnG5I773tA0leu0VUdrSYGstkTcrfJkgogPnJ7PFcl
         31t7jrYEdmNdJX7wRds7mxML+FQTPD9x580WrO1meFPYgbv9R0n/+lZTV+GliBcTR5kO
         nrNIauVuU/YrDuHaRZRAYJOmzZvnwK1mrEci4GDx5AiKYyt+Vcy8YQ5UE3w0BhoDOz3o
         XWL/puL50NgTNkHZmsK2jY1kmBzMuqlpKiguD4GpYr6rHlKfS2kBcJnliI/Yy/AWhN60
         ZSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dAKP2BZqA1UibuK+I2lv+5q2mGNArThU6TM1eu1lUiQ=;
        b=cONkK7V2R5/IvlmGdleHJT8RguOSScsrQAN6C8qP9qSbhT3zTqsaa9n2uVSdUyMev6
         gcpqM/LDeZJVxt2ba+xIEwIt/OHNeuPluTz4s+iW6sWyW7fZysbwbSwaVvXZerVvmKAF
         vApOLH1VUy0KSTXPti7Suk3iaXSJeV4gawW1WlETuALKI09GVEIptYk9zCR8IWDuM/qy
         fzhw2yco8n5NNUtSb/RU7nSdiAXz/cneLe0DxZiXhB/Gs4Y5tUlfxOLk7igj7A7iesLx
         7Pwx36asdEMyNHxG9uZWTACZb87NNrCLryV076e7594A26L+Xj6j6GbM8f3AbeuhpIHg
         t/eA==
X-Gm-Message-State: APt69E1+ObSviVXDamq3hptC2jD9q4viNnPG6FC2Y5PGHW64QyFW/h2F
        8Sdqlo4X5kONwFLoyFhhbsdjTy7a
X-Google-Smtp-Source: ADUXVKL2Tzc8e1GeNWXbX4seT42kbnG1IX/KVJuO4PFuEbfVVEYiXVse/eXKfwxgClcP1XA2caBsuw==
X-Received: by 2002:adf:8650:: with SMTP id 16-v6mr11378090wrw.73.1529945206573;
        Mon, 25 Jun 2018 09:46:46 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id v10-v6sm26419997wrn.97.2018.06.25.09.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:46:45 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 1/6] stash: implement the "list" command in the builtin
Date:   Mon, 25 Jun 2018 19:46:34 +0300
Message-Id: <a4b25124d0d3f28c5d122f8226a50978e39c9200.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash list to the helper and delete the list_stash function
from the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 33 +++++++++++++++++++++++++++++++++
 git-stash.sh            |  7 +------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index a38d6ae8a..2ed21f5d1 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 #include "rerere.h"
 
 static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper list [<options>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -19,6 +20,11 @@ static const char * const git_stash_helper_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_list_usage[] = {
+	N_("git stash--helper list [<options>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_drop_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
@@ -595,6 +601,31 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int list_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_list_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (!ref_exists(ref_stash))
+		return 0;
+
+	argv_array_pushl(&args, "log", "--format=%gd: %gs", "-g",
+			 "--first-parent", "-m", NULL);
+	argv_array_pushv(&args, argv);
+	argv_array_push(&args, ref_stash);
+	argv_array_push(&args, "--");
+	ret = cmd_log(args.argc, args.argv, prefix);
+	argv_array_clear(&args);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -625,6 +656,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "list"))
+		return !!list_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 8f2640fe9..6052441aa 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -382,11 +382,6 @@ have_stash () {
 	git rev-parse --verify --quiet $ref_stash >/dev/null
 }
 
-list_stash () {
-	have_stash || return 0
-	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
-}
-
 show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
@@ -574,7 +569,7 @@ test -n "$seen_non_option" || set "push" "$@"
 case "$1" in
 list)
 	shift
-	list_stash "$@"
+	git stash--helper list "$@"
 	;;
 show)
 	shift
-- 
2.18.0.rc2.13.g506fc12fb

