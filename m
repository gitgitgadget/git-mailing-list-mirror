Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFB7211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeK3JGY (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37628 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeK3JGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so2649288lfh.4
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTlYnFYVuOvFqTdMOOe9mz6pSy5311ZJ0NCkttnJuHo=;
        b=Gfoj6F8wBvc/CB1hGcR/LcUzJoqS5TwTQC+OcnrQBRM4ZPc2BWhWfFuvWTMolUlSgh
         oHyG22gDAfH6pCBTHaoxydWGhPm9o0CNZtzdJyxm0drxWUOmhyDFUZn46BeSJt2hYrIA
         VipU1HpoiwOOaagJgJ8yi3fxqDFx9KRAt3rzHr/XWB4eIaSYuT3W4XnemE6PjJRLyZtw
         qqdgnDMk3TcDgWmvy5nH97iC6CWNr7DTBRSrcQG09kSnTBT90RcFz74L0pJKFSGF6mfS
         /I7VqpxF24Z6ITlYI4xMBSvvh1fV5e8aD7F4VkoFNb2SfRv+AE4cJIowZGUQkTkwd6WR
         Uirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTlYnFYVuOvFqTdMOOe9mz6pSy5311ZJ0NCkttnJuHo=;
        b=f1WHBaUIaQLbl5vwwCTq4qLrtR+khgMeaz/eH++PikhXeCS5X0X4TVxtieZyKqvBOj
         P9/GWMdv/G+RwriO85R3tQF/S6N1rU35gGEj2PKSaz6JiYbHGAnD5CoPbumUwgEqXcog
         itwQ9Jy+LhIiEYJrFO/UvNm9X1bPUXQ0UVhStR0SgucrcXUXTCK1QMUUXW+KSxFfAkik
         Oh8I76gjybJSJq92FIwmUDkAXbQNp9oi0D01KrYeAOhJeD3t9HFHKA2atXomxtqbjBIC
         Rmb7YltGsUjcOh2/5T7KyFe7X9qddWRr7iMRXPFrmsVbxFy1aQVsFG6HxqavrPktwHNe
         H6hg==
X-Gm-Message-State: AA+aEWaUN47TK+O9mgDdTl5EPjK64aOF0ml9US81zNnyf3Yl1qXc/OLX
        4EMJgi5UUoMcXJzpGdKWAeE=
X-Google-Smtp-Source: AFSGD/Xm0/Wpatgv5Quj5TYTjM04Zri8XinrGWZypzh+h1COrANdTXppu79M05LXSgArPJCvfnzdhQ==
X-Received: by 2002:a19:d58e:: with SMTP id m136mr2265847lfg.70.1543528767217;
        Thu, 29 Nov 2018 13:59:27 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:26 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 13/14] restore-files: make pathspec mandatory
Date:   Thu, 29 Nov 2018 22:58:48 +0100
Message-Id: <20181129215850.7278-14-pclouds@gmail.com>
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

"git restore-files" without arguments does not make much sense when
it's about restoring files (what files now?). We could default to
either

    git restore-files .

or

    git restore-files :/

Neither is intuitive. Make the user always give pathspec, force the
user to think the scope of restore they want.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7ff9951818..961a90b1c0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -59,6 +59,7 @@ struct checkout_opts {
 	int accept_ref;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_not_ok;
+	int empty_pathspec_ok;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1436,6 +1437,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
+	if (opts->accept_pathspec && !opts->empty_pathspec_ok && !argc)
+		die(_("pathspec is required"));
+
 	if (argc) {
 		parse_pathspec(&opts->pathspec, 0,
 			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
@@ -1515,6 +1519,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.accept_ref = 1;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
+	opts.empty_pathspec_ok = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1570,6 +1575,7 @@ int cmd_restore_files(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
+	opts.empty_pathspec_ok = 0;
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.20.0.rc1.380.g3eb999425c.dirty

