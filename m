Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F3A1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753662AbeADWw4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:52:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33028 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeADWwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:52:54 -0500
Received: by mail-pf0-f194.google.com with SMTP id y89so1406891pfk.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pOAirz5gnMxMzASz5jNLy2K5WtKqAMwk1F6S/plrUlg=;
        b=Kx5XJ73AANjQ/vyOCNnYWKdTUZMbddhU2IX6vx61A+YfyjXMp5NKafCcn0tV5phnHf
         QKa8Uy7m2dAe5+N6V5BBe0ke1JCnjdIUOdqFW7FizsSyuUA+QzXVWy/d/oF9fdzHYkdT
         vg8g1NVFzhT/bOGO5U1KFTwnV9uslqElpV6Z1sun1pJ8rA6Ts60AAD575PeKGYIy+Laa
         Rk1xrWecHhb56RkH3T69fNX517U/46KUWiOZnobWNEgu+v7sPA/bssLHQi5KU5feOtyy
         ejCvHFtgzY5bMY0GzmMqOqUS7ibN72zS4jqnjbumU0jnWJGThp5aM7paoqA5tYerU1fN
         XMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pOAirz5gnMxMzASz5jNLy2K5WtKqAMwk1F6S/plrUlg=;
        b=jQ/fgxF4YOSexKhKImh1a1zr4TNLlsN4waTPQdCS9j+VIeJWjpkvMLnij8QvbWGaiO
         BKOjyIjnEyMYYNYW5Vk63zZtz9hr0UO1jt1slzufTGFK+WRWM3MWfMVado9ocymrNOIS
         TFSOiIPq+uqWtT9TshjS1jC/t72NChVMMt5AgRrnD2c+ai3/uhYFDxM7EV9HtDQR7tXr
         dgBU2Sz3AipFq4e3np2iF4UjDdbqOo6vTXMrBJJXzJq+bnl6gBiziyVoKAJPlHajxat+
         IYQ46EB91IE9qytDBIzN0ekdwJ/u/6IFWiBccKT0yzWz2a1tcKVmaEN5O9OSFslClxzv
         D29A==
X-Gm-Message-State: AKGB3mI1TYKuyFG2McyLkYTdgdM8+GxcHQ9ZIu8LxFvGlyYosHg2uPIc
        c1OP7P+jSfBQ6GYDf3gdGL6PIQ==
X-Google-Smtp-Source: ACJfBotzcxL5qQBjrmfTaAYY5IWnjJ4IaYE68agh/2vNT3dZBnGCh38RUlQmIwdRmc5+7/U8tN/MAw==
X-Received: by 10.98.103.129 with SMTP id t1mr980090pfj.53.1515106373108;
        Thu, 04 Jan 2018 14:52:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d68sm9701311pfl.38.2018.01.04.14.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:52:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: [PATCHv2 3/6] diff: introduce DIFF_PICKAXE_KINDS_MASK
Date:   Thu,  4 Jan 2018 14:50:41 -0800
Message-Id: <20180104225044.191220-4-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104225044.191220-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
 <20180104225044.191220-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the check whether to perform pickaxing is done via checking
`diffopt->pickaxe`, which contains the command line argument that we
want to pickaxe for. Soon we'll introduce a new type of pickaxing, that
will not store anything in the `.pickaxe` field, so let's migrate the
check to be dependent on pickaxe_opts.

It is not enough to just replace the check for pickaxe by pickaxe_opts,
because flags might be set, but pickaxing was not requested ('-i').
To cope with that, introduce a mask to check only for the bits indicating
the modes of operation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/log.c  | 4 ++--
 combine-diff.c | 2 +-
 diff.c         | 4 ++--
 diff.h         | 2 ++
 revision.c     | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6c1fa896ad..bd6f2d1efb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -180,8 +180,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (rev->show_notes)
 		init_display_notes(&rev->notes_opt);
 
-	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    rev->diffopt.flags.follow_renames)
+	if ((rev->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
+	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
 		rev->always_show_header = 0;
 
 	if (source)
diff --git a/combine-diff.c b/combine-diff.c
index 2505de119a..bc08c4c5b1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1438,7 +1438,7 @@ void diff_tree_combined(const struct object_id *oid,
 			opt->flags.follow_renames	||
 			opt->break_opt != -1	||
 			opt->detect_rename	||
-			opt->pickaxe		||
+			(opt->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)	||
 			opt->filter;
 
 
diff --git a/diff.c b/diff.c
index 0763e89263..5508745dc8 100644
--- a/diff.c
+++ b/diff.c
@@ -4173,7 +4173,7 @@ void diff_setup_done(struct diff_options *options)
 	/*
 	 * Also pickaxe would not work very well if you do not say recursive
 	 */
-	if (options->pickaxe)
+	if (options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)
 		options->flags.recursive = 1;
 	/*
 	 * When patches are generated, submodules diffed against the work tree
@@ -5777,7 +5777,7 @@ void diffcore_std(struct diff_options *options)
 		if (options->break_opt != -1)
 			diffcore_merge_broken();
 	}
-	if (options->pickaxe)
+	if (options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)
 		diffcore_pickaxe(options);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
diff --git a/diff.h b/diff.h
index 8af1213684..9ec4f824fe 100644
--- a/diff.h
+++ b/diff.h
@@ -326,6 +326,8 @@ extern void diff_setup_done(struct diff_options *);
 #define DIFF_PICKAXE_KIND_S	4 /* traditional plumbing counter */
 #define DIFF_PICKAXE_KIND_G	8 /* grep in the patch */
 
+#define DIFF_PICKAXE_KINDS_MASK (DIFF_PICKAXE_KIND_S | DIFF_PICKAXE_KIND_G)
+
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
 extern void diffcore_std(struct diff_options *);
diff --git a/revision.c b/revision.c
index ccf1d212ce..5d11ecaf27 100644
--- a/revision.c
+++ b/revision.c
@@ -2407,7 +2407,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revs->diff = 1;
 
 	/* Pickaxe, diff-filter and rename following need diffs */
-	if (revs->diffopt.pickaxe ||
+	if ((revs->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
 	    revs->diffopt.filter ||
 	    revs->diffopt.flags.follow_renames)
 		revs->diff = 1;
-- 
2.16.0.rc0.223.g4a4ac83678-goog

