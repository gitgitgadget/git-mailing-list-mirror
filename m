Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA7F20248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKNNh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39593 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDKNNh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so3506508pga.6
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZSiJ+OUTgllPE63xjdQxdRuQMZRUtaC1GIYZDlWxsc=;
        b=i9AnNgIW5Po+ggceSjFdQNnVut61PCqvXfXtL5PCT14RkJLQCXnqAnLhYhHtRme4lJ
         HrioKXFsIoJ0+E7zo60fe/qudtoUXwdXYAsjDwqId+G8OcSFYjuwu/mDquOe+kNpNarB
         4P4PQz2Cja7NWMRzx/noZWpJUE7LAclw6FeedScY1JNKy6W4Z/MRbLAUAIcriN/JW4GZ
         pGtabA+WJMrmQyhpbDRrJHwOef+UOUIcvQGoS61hIQKBycxGZK+Jiwru/7zgKC93qRut
         wBMbGi4cIkHa5P3yfivXE4UkVagAtS1cD60BThVHZbR15mQdtPVoD9IWEtUVypesw6CK
         UFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZSiJ+OUTgllPE63xjdQxdRuQMZRUtaC1GIYZDlWxsc=;
        b=YCcPgrdIA+hhqr5WVLsLbis8+gdocQfAY9thoh4xq2hlkaHzXW069YbhVtaj++w6wk
         APNiFWc+mvtNnNtWyezdTkeupRvOWHkqzvXxacWxfAbeR0PKRDuGaQ327XugXqBMzkKo
         BpLgbzN7fwRbZw0p8DyM4kk6xQ4Tbiunefg7EopD4BEE9vmYn2PzOe+glfaM7Q8+uPqp
         WREI37x7OdYMDWuOWP2JpJtSmuc/1Pf7Qb7dir4u5gyXnB3/GRw/cALk+C2nBkpVt2yc
         YjKZFi0KmIKJyiuw1TmmQpdMaK5XrOnfrcSKnCXm4VPR+fQc6rSFJFfKtjGw+V4+kedt
         MGnQ==
X-Gm-Message-State: APjAAAUocb8IRee+6XOMOF5WILOcShMMjVWObhiu8qnSCCaIvPpE8hAF
        URRpY4C6LD3IoSLSa/9x54wI61qi
X-Google-Smtp-Source: APXvYqy4+Eogc5DFPle5XOlxHUs+SFpl7VTMScQ9gZAab8p7tnEmFEyFRDUO/4bwA/pS9Q8peK13lw==
X-Received: by 2002:a63:e048:: with SMTP id n8mr31581702pgj.41.1554988416118;
        Thu, 11 Apr 2019 06:13:36 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id f15sm34861444pgf.18.2019.04.11.06.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 10/16] restore: support --patch
Date:   Thu, 11 Apr 2019 20:12:12 +0700
Message-Id: <20190411131218.19195-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-restore is different from git-checkout that it only restores the
worktree by default, not both worktree and index. add--interactive
needs some update to support this mode.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c        |  6 +++--
 git-add--interactive.perl | 52 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 824ab65886..bed79ae595 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -454,9 +454,11 @@ static int checkout_paths(const struct checkout_opts *opts,
 			patch_mode = "--patch=checkout";
 		else if (opts->checkout_index && !opts->checkout_worktree)
 			patch_mode = "--patch=reset";
+		else if (!opts->checkout_index && opts->checkout_worktree)
+			patch_mode = "--patch=worktree";
 		else
-			die(_("'%s' with only '%s' is not currently supported"),
-			    "--patch", "--worktree");
+			BUG("either flag must have been set, worktree=%d, index=%d",
+			    opts->checkout_worktree, opts->checkout_index);
 		return run_add_interactive(revision, patch_mode, &opts->pathspec);
 	}
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..3dfb3629c9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -149,6 +149,20 @@ sub colored {
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
+	'worktree_head' => {
+		DIFF => 'diff-index -p',
+		APPLY => sub { apply_patch 'apply -R', @_ },
+		APPLY_CHECK => 'apply -R',
+		FILTER => undef,
+		IS_REVERSE => 1,
+	},
+	'worktree_nothead' => {
+		DIFF => 'diff-index -R -p',
+		APPLY => sub { apply_patch 'apply', @_ },
+		APPLY_CHECK => 'apply',
+		FILTER => undef,
+		IS_REVERSE => 0,
+	},
 );
 
 $patch_mode = 'stage';
@@ -1049,6 +1063,12 @@ sub color_diff {
 marked for discarding."),
 	checkout_nothead => N__(
 "If the patch applies cleanly, the edited hunk will immediately be
+marked for applying."),
+	worktree_head => N__(
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for discarding."),
+	worktree_nothead => N__(
+"If the patch applies cleanly, the edited hunk will immediately be
 marked for applying."),
 );
 
@@ -1259,6 +1279,18 @@ sub edit_hunk_loop {
 n - do not apply this hunk to index and worktree
 q - quit; do not apply this hunk or any of the remaining ones
 a - apply this hunk and all later hunks in the file
+d - do not apply this hunk or any of the later hunks in the file"),
+	worktree_head => N__(
+"y - discard this hunk from worktree
+n - do not discard this hunk from worktree
+q - quit; do not discard this hunk or any of the remaining ones
+a - discard this hunk and all later hunks in the file
+d - do not discard this hunk or any of the later hunks in the file"),
+	worktree_nothead => N__(
+"y - apply this hunk to worktree
+n - do not apply this hunk to worktree
+q - quit; do not apply this hunk or any of the remaining ones
+a - apply this hunk and all later hunks in the file
 d - do not apply this hunk or any of the later hunks in the file"),
 );
 
@@ -1421,6 +1453,16 @@ sub display_hunks {
 		deletion => N__("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
 		hunk => N__("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
+	worktree_head => {
+		mode => N__("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
+	},
+	worktree_nothead => {
+		mode => N__("Apply mode change to worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Apply deletion to worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Apply this hunk to worktree [y,n,q,a,d%s,?]? "),
+	},
 );
 
 sub patch_update_file {
@@ -1756,6 +1798,16 @@ sub process_args {
 						       'checkout_head' : 'checkout_nothead');
 					$arg = shift @ARGV or die __("missing --");
 				}
+			} elsif ($1 eq 'worktree') {
+				$arg = shift @ARGV or die __("missing --");
+				if ($arg eq '--') {
+					$patch_mode = 'checkout_index';
+				} else {
+					$patch_mode_revision = $arg;
+					$patch_mode = ($arg eq 'HEAD' ?
+						       'worktree_head' : 'worktree_nothead');
+					$arg = shift @ARGV or die __("missing --");
+				}
 			} elsif ($1 eq 'stage' or $1 eq 'stash') {
 				$patch_mode = $1;
 				$arg = shift @ARGV or die __("missing --");
-- 
2.21.0.682.g30d2204636

