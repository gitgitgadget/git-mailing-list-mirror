Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E5D1F462
	for <e@80x24.org>; Wed, 29 May 2019 09:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfE2JL3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 05:11:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46783 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2JL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 05:11:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so1193180pfm.13
        for <git@vger.kernel.org>; Wed, 29 May 2019 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0jOzc7G6XFPLlt32gwMqGdsObbDSmH/UyvFp7hIUaw=;
        b=R6VIwJ7EvLzs2mFfZcDzRHUTblG52gmAPWoaicCBSgZOuulskz67gFjqwdU9GO/Gqb
         Uibj9lsxyP76zb+S2VnQWMF2Rqq1qcpLux2wW/3wu9MRoddnES9bNP+OI9pBVQmzyosy
         /i8XW+Tx+BmRPn2RK7IwNMmI0QxzUDzHDPQUCMgPOib+FkV6l44fpd3RBIEYSXdVKl6k
         xcnzFf2dWPaFSnrWZvcivOChp86vr1PusNtfDMeP9xdKnmCl6UbjRg+MtQh3du9JM5Y1
         QVqRwKhPju5EiAUAopwuiXrB+gDj6J9dpEsieiJOhZIvaVS5vlS6mD/YwLJdF9BFnbSJ
         cpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0jOzc7G6XFPLlt32gwMqGdsObbDSmH/UyvFp7hIUaw=;
        b=TjxXIBmUKX3gOAGsiUlzmPlTFGrYy9BqCPltOk11bQHiyaVVdMNYWEFKpN6yT9qK1G
         lUXF7CYwGJVpivy/QlMXRtMVzxF8V/srUlF+aNPdNpbW9EiVVQ49+ro7R0m79yILo6SL
         DAcQHC2G7xafi3iPH/d7mYgOLSw0b01W/fVyBcRhZlx/bHjqEx+E9TOuMmQTrXxLMIeV
         vN3aIV5nGAM+WJ8aOxXkkAyOznzT+v5nKocyOYJEy4MCQ6ALvdZiJadofKpc9xRkPJxK
         lpU0fc+11GTjLgB+ZOnb28/nE6veBxuaTwJVHUvI9uUA1ZLx3wAwCrzLwCpfv5N0+a5K
         Vnnw==
X-Gm-Message-State: APjAAAVg/ZAIa/BEpS/9jO/dfDp7gFibigULuWkW+McgHPQsw0hd8VPU
        13WpA45FojLeGw61TWlJybQ=
X-Google-Smtp-Source: APXvYqxLok3k8y+8lpGhI3/IrHGzOm63/yt2yKx8k2u7e5izTjCMExOqrtV6ARoVjuSkP9vzZiG/jg==
X-Received: by 2002:a17:90a:8a09:: with SMTP id w9mr10402930pjn.140.1559121088104;
        Wed, 29 May 2019 02:11:28 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id 124sm18204564pfe.124.2019.05.29.02.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:11:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 29 May 2019 16:11:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, bturner@atlassian.com, git@vger.kernel.org,
        gitster@pobox.com, tmz@pobox.com
Subject: [PATCH v2 0/3] fix diff-parseopt regressions
Date:   Wed, 29 May 2019 16:11:13 +0700
Message-Id: <20190529091116.21898-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190524092442.701-1-pclouds@gmail.com>
References: <20190524092442.701-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 reduces diff noise. My C is rusty (and probably holey too). For some
reason I remember "unsigned" is equivalent to "unsigned short", not
"unsigned int".

Nguyễn Thái Ngọc Duy (3):
  diff-parseopt: correct variable types that are used by parseopt
  diff-parseopt: restore -U (no argument) behavior
  parse-options: check empty value in OPT_INTEGER and OPT_ABBREV

 diff.c                                    | 10 ++++---
 diff.h                                    |  2 +-
 parse-options-cb.c                        |  3 +++
 parse-options.c                           |  3 +++
 t/t4013-diff-various.sh                   |  2 ++
 t/t4013/diff.diff_-U1_initial..side (new) | 29 ++++++++++++++++++++
 t/t4013/diff.diff_-U2_initial..side (new) | 31 ++++++++++++++++++++++
 t/t4013/diff.diff_-U_initial..side (new)  | 32 +++++++++++++++++++++++
 8 files changed, 107 insertions(+), 5 deletions(-)
 create mode 100644 t/t4013/diff.diff_-U1_initial..side
 create mode 100644 t/t4013/diff.diff_-U2_initial..side
 create mode 100644 t/t4013/diff.diff_-U_initial..side

Interdiff dựa trên v1:
diff --git a/diff.h b/diff.h
index 4527daf6b7..d5e44baa96 100644
--- a/diff.h
+++ b/diff.h
@@ -65,39 +65,39 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FLAGS_INIT { 0 }
 struct diff_flags {
-	unsigned int recursive;
-	unsigned int tree_in_recursive;
-	unsigned int binary;
-	unsigned int text;
-	unsigned int full_index;
-	unsigned int silent_on_remove;
-	unsigned int find_copies_harder;
-	unsigned int follow_renames;
-	unsigned int rename_empty;
-	unsigned int has_changes;
-	unsigned int quick;
-	unsigned int no_index;
-	unsigned int allow_external;
-	unsigned int exit_with_status;
-	unsigned int reverse_diff;
-	unsigned int check_failed;
-	unsigned int relative_name;
-	unsigned int ignore_submodules;
-	unsigned int dirstat_cumulative;
-	unsigned int dirstat_by_file;
-	unsigned int allow_textconv;
-	unsigned int textconv_set_via_cmdline;
-	unsigned int diff_from_contents;
-	unsigned int dirty_submodules;
-	unsigned int ignore_untracked_in_submodules;
-	unsigned int ignore_dirty_submodules;
-	unsigned int override_submodule_config;
-	unsigned int dirstat_by_line;
-	unsigned int funccontext;
-	unsigned int default_follow_renames;
-	unsigned int stat_with_summary;
-	unsigned int suppress_diff_headers;
-	unsigned int dual_color_diffed_diffs;
+	unsigned recursive;
+	unsigned tree_in_recursive;
+	unsigned binary;
+	unsigned text;
+	unsigned full_index;
+	unsigned silent_on_remove;
+	unsigned find_copies_harder;
+	unsigned follow_renames;
+	unsigned rename_empty;
+	unsigned has_changes;
+	unsigned quick;
+	unsigned no_index;
+	unsigned allow_external;
+	unsigned exit_with_status;
+	unsigned reverse_diff;
+	unsigned check_failed;
+	unsigned relative_name;
+	unsigned ignore_submodules;
+	unsigned dirstat_cumulative;
+	unsigned dirstat_by_file;
+	unsigned allow_textconv;
+	unsigned textconv_set_via_cmdline;
+	unsigned diff_from_contents;
+	unsigned dirty_submodules;
+	unsigned ignore_untracked_in_submodules;
+	unsigned ignore_dirty_submodules;
+	unsigned override_submodule_config;
+	unsigned dirstat_by_line;
+	unsigned funccontext;
+	unsigned default_follow_renames;
+	unsigned stat_with_summary;
+	unsigned suppress_diff_headers;
+	unsigned dual_color_diffed_diffs;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
@@ -151,7 +151,7 @@ struct diff_options {
 	int skip_stat_unmatch;
 	int line_termination;
 	int output_format;
-	unsigned int pickaxe_opts;
+	unsigned pickaxe_opts;
 	int rename_score;
 	int rename_limit;
 	int needed_rename_limit;
-- 
2.22.0.rc0.322.g2b0371e29a

