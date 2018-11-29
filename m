Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAFA211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeK3JGT (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34096 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeK3JGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so3169765ljd.1
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IRHjREdsUJLmqkVQZrF5zmJSDqIEzg1GRgeGt66pq8U=;
        b=aeJMgMGT0rf6vhQWjsDOejH7beN/UYpYfEtv6jCZSNGfIHt4SIZK3JYtWikgja3g6Y
         LQt7gKcs9YiafAsS4PFUxwQcnsgla5ALeYAfFHoBkvnyr+Z4U9yC5TQYo75UIDTr/M4l
         U4yaN0RAN+yE3f83y3d67R1IwvGfsCvUWJsNRY1HeBaHXn6pyR5TuKQpzBbsbBN+sU52
         Q9fw6CbeaiGd0KIZ9I6O7njpMxSSCcsIz76vrTluXyWmxtb0WaMWYIA8f884IQ7pwWrr
         WTG+34mjDhhayIuMDswc0JX4o/5wDkmrAP16qo5dLbvzC1ZvX7l8BTZpD2K/snkeNFl9
         GtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IRHjREdsUJLmqkVQZrF5zmJSDqIEzg1GRgeGt66pq8U=;
        b=O7XPeqN2LNao3hPbFRL6wY21khEA4hiYh8SaP5g0ynVjiOmaFWVVLktBSWBZU2PIpb
         4LrqBEIpTeNANIv5UhsCq48lJDlsMxaOmVJPBI3IUvFs8dQcf1tEsg3gcxegvBw2fKIv
         aOxs6z3qajpRQHuxH1DW37RRDDjtyTrz8mMlkwfwXHfGIRCcF6AhdDnn6CCxrc+6jHAM
         xgRHhpf/HdqeFvLzGno8m4uOWqnyP+5oqUJhOo1u4s3blDcNDXhpAR7BCRDiXNjfvhEd
         L/HjwfKNMOI4bFK6R8uyagsVxyn5zAhEanrS52M9/rTC/g0Ps0p0XebkC9Co3y5TlovS
         5Evw==
X-Gm-Message-State: AA+aEWaDXYDwOXf7fv8uQZDm6sB0PYtnRIGGU4ciASz92Iqa6GwF7vSj
        i+S6R53o7Lo0pEGhxJKPFIU=
X-Google-Smtp-Source: AFSGD/XVOv3nzSojIg6XEG3MIP5jOi6YaP6dflubHwn/RHqTKRPukh8J+9tp5RQvd3t86snWRmPt2w==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr2175433ljf.96.1543528762916;
        Thu, 29 Nov 2018 13:59:22 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:22 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 09/14] switch-branch: stop accepting pathspec
Date:   Thu, 29 Nov 2018 22:58:44 +0100
Message-Id: <20181129215850.7278-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command is about switching branch (or creating a new one) and
should not accept pathspec. This helps simplify ambiguation
handling. The other two ("git checkout" and "git restore-files") of
course do accept pathspec as before.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ceb635de36..880030e929 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -55,6 +55,7 @@ struct checkout_opts {
 	int ignore_other_worktrees;
 	int show_progress;
 	int dwim_new_local_branch;
+	int accept_pathspec;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1089,10 +1090,16 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!argc)
 		return 0;
 
+	if (!opts->accept_pathspec) {
+		if (argc > 1)
+			die(_("only one reference expected"));
+		has_dash_dash = 1; /* helps disambiguate */
+	}
+
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
+		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
 			dash_dash_pos = i;
 			break;
 		}
@@ -1167,7 +1174,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		if (argc)
 			verify_non_filename(opts->prefix, arg);
-	} else {
+	} else if (opts->accept_pathspec) {
 		argcount++;
 		argv++;
 		argc--;
@@ -1468,6 +1475,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
+	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1494,6 +1502,7 @@ int cmd_switch_branch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
+	opts.accept_pathspec = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
@@ -1513,6 +1522,7 @@ int cmd_restore_files(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
+	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(options);
 	options = add_common_options(&opts, options);
-- 
2.20.0.rc1.380.g3eb999425c.dirty

