Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20ACE1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 04:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfBOEbh (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 23:31:37 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56543 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387875AbfBOEbg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 23:31:36 -0500
Received: by mail-pg1-f202.google.com with SMTP id d3so5914712pgv.23
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 20:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QU47JvHFRedWNRbpYpM9oy2VnbbNsUEnGjpvHEma4d0=;
        b=ugfvqLOuy2ERudB38bLfl6KdqP5gPnoASCRau37lYR0YL56VW7faexbTcTitcsqUc9
         AKSvGys7EAViYxd3FPxRdIH4/YC5zLfklX2x2UyfpBrknI1ujzsDZ4j24blNDs78A6qk
         hlW15FhBXcH1Mu4Mu4ouMF1WIr2oNdraUVJ0pKVfvcEsU2k7Nnb5wPNEi+VXBexzS1uI
         fqqLMZLArrEqLPezzRgP/M+DhvqJA0T0POOb6wQ6tqiluiYwDK+sj9XPaYSLXBI5kFdS
         1H4G63Rvv9h3OpDruZ6Qs6r55ZVNzWhL0alSSpk6M0RbkHV+kKvwRpgAvLE95sWJYxrr
         k9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QU47JvHFRedWNRbpYpM9oy2VnbbNsUEnGjpvHEma4d0=;
        b=pbpnC2nC3gBsxdtAzObk9+Kaf4oQpeA1RFbVDppPOjPRMxtrvaEmz4SEbkJIjhaVtx
         qCxwVGO8Q71xzWeG8Sak+dnOSfEWLoF5v2DIMXyWPaKIyYdo54nwEX23WULsrWHhQ+xZ
         upib6v2fM/upvfyF+lFY++0OUdguB2b4B/0h0w2HiDwJm+UPVu1vbXU8SLO6dkJm65HT
         fkaKcat5oL5EBIMqMF44HyXU16nOIBQCaqStSiwRt36Ha0hTx8JrWZz5nRUnSIaFlSDN
         45zOsO0lOqWYQOhEK2JxbUvbgNfc5TXhIV4PNznE96ioCjZavtJ8jfST8zzG6Ixsp74r
         fu/A==
X-Gm-Message-State: AHQUAubSzYBMYXvUm1RXxO67qJEU4DvB8wTvN+8xTNUnSSgEyptkVvYG
        vxXFcb+zpVbxF8BASPv64v8/6v48cJSDaDm3vtlGoS4zAl5jaR7owvm0MM0i1dXGDsdmazSa46G
        KSsgPpm+pN1gRWLLoLmssB/RRtYi1EKnSNfnnRShzCw57IsYCGC7o0+Bm8A==
X-Google-Smtp-Source: AHgI3IaL8blvhUlnDv3kf3zsRPvye1zLA9ZdYplyCw61OxDGtVtZPoGfMGRIv3HBX/Yb0SSrKSkN4xQMCY8=
X-Received: by 2002:a62:9687:: with SMTP id s7mr2728397pfk.56.1550205095211;
 Thu, 14 Feb 2019 20:31:35 -0800 (PST)
Date:   Thu, 14 Feb 2019 20:31:05 -0800
In-Reply-To: <20190215043105.163688-1-sxenos@google.com>
Message-Id: <20190215043105.163688-8-sxenos@google.com>
Mime-Version: 1.0
References: <20190215043105.163688-1-sxenos@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v5 8/8] evolve: add the git change list command
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

This command lists the ongoing changes from the refs/metas
namespace.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 builtin/change.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/builtin/change.c b/builtin/change.c
index 807d148805..a7db3cea04 100644
--- a/builtin/change.c
+++ b/builtin/change.c
@@ -6,15 +6,64 @@
 #include "config.h"
 
 static const char * const builtin_change_usage[] = {
+	N_("git change list [<pattern>...]"),
 	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
 	NULL
 };
 
+static const char * const builtin_list_usage[] = {
+	N_("git change list [<pattern>...]"),
+	NULL
+};
+
 static const char * const builtin_update_usage[] = {
 	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
 	NULL
 };
 
+static int change_list(int argc, const char **argv, const char* prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct ref_filter filter;
+	/* TODO: Sorting temporarily disabled. See comments, below.
+	 * struct ref_sorting *sorting = ref_default_sorting(); */
+	struct ref_format format = REF_FORMAT_INIT;
+	struct ref_array array;
+	int i;
+
+	argc = parse_options(argc, argv, prefix, options, builtin_list_usage, 0);
+
+	setup_ref_filter_porcelain_msg();
+
+	memset(&filter, 0, sizeof(filter));
+	memset(&array, 0, sizeof(array));
+
+	filter.kind = FILTER_REFS_CHANGES;
+	filter.name_patterns = argv;
+
+	filter_refs(&array, &filter, FILTER_REFS_CHANGES);
+
+	/* TODO: This causes a crash. It sets one of the atom_value handlers to
+	 * something invalid, which causes a crash later when we call
+	 * show_ref_array_item. Figure out why this happens and put back the sorting.
+	 *ref_array_sort(sorting, &array); */
+
+	if (!format.format)
+		format.format = "%(refname:lstrip=1)";
+
+	if (verify_ref_format(&format))
+		die(_("unable to parse format string"));
+
+	for (i = 0; i < array.nr; i++)
+		show_ref_array_item(array.items[i], &format);
+
+	ref_array_clear(&array);
+
+	return 0;
+}
+
 struct update_state {
 	int options;
 	const char* change;
@@ -184,6 +233,8 @@ int cmd_change(int argc, const char **argv, const char *prefix)
 
 	if (argc < 1)
 		usage_with_options(builtin_change_usage, options);
+	else if (!strcmp(argv[0], "list"))
+		result = change_list(argc, argv, prefix);
 	else if (!strcmp(argv[0], "update"))
 		result = change_update(argc, argv, prefix);
 	else {
-- 
2.21.0.rc0.258.g878e2cd30e-goog

