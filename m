Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3701F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeGVKyT (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45162 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeGVKyS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:18 -0400
Received: by mail-io0-f193.google.com with SMTP id k16-v6so3481964iom.12
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjBvHO9MPTXmqqvxf/AQk5h29uhL06J7AP7vg8qMh6w=;
        b=cfiTip0qZ2hZwWIzDpFyERM7T2FErbXcXPYOm2g+sLmwUtiaqXZtRSQGo89DN8cN1u
         BSX0ADOhvgzfO56X+bMVI90QcVxmhiqvA49/1owxrgfZIM7Ia+DxMpEolyMSQrB4MIb3
         Mst6g6/8CjPVW7R+8peUcuJRaNiiM9airwkxIFeYbmvTIN9hV76UusoU2JHOAfhanNRh
         YoPJL5mQZKWNXhCNoBavikc/AqTy2VSSboRagqQAajuh/V019Lh/1O8hwwCAsRVzwBib
         XLgsWnePBMB3N/9PCVjdUPBYrU/zfUnsVTSvoXotrawdMZeGnzekEIMwHT1cR3+8B1e5
         ah+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TjBvHO9MPTXmqqvxf/AQk5h29uhL06J7AP7vg8qMh6w=;
        b=T/Fc93i6GnXEIgwXw5F2IGu7fJBUI7rHR+fl4fjzumEH7zcKSLmTLg5fQflSgisAg6
         R2jA+ct89VUphao9kB+p76iKqEGM+X9nepheZO1dSZWqHaSx+cucqqfPhPLWOa2M1oPn
         n/Qedw0y0ld0L1/DAZDaueTrShXvNp1TVmiaOeY/VVkLufRIdVM5T6JahAXldMKzSEUC
         2uOzGMSHRLknBf89bZ4pDHaF36yn6bSx8EC85M8C7Ft9qlG2Dj+I0z66AzM+E1scRoDD
         5r5BOzUtUOSkzlGQRRg3d2uXeKxVv+PPp/3pG5BM+rnBtno0qKgjW65VMUGU8taERE1i
         E94w==
X-Gm-Message-State: AOUpUlE/ED7ek16AjnR10/zFi5UzZoGJ/vjZQ9F6NTHJojwltf+i/sOh
        tcau01xDrH3d/YNY9UYv8XI61yb5
X-Google-Smtp-Source: AAOMgpdiAmf5xPgvJX3K7bFyPDsBcKsux1AbujlsUIwJOLv6Fen75FiyqnsdX2J7YPBL1Nro+BzN0g==
X-Received: by 2002:a6b:ee17:: with SMTP id i23-v6mr3479245ioh.52.1532253488852;
        Sun, 22 Jul 2018 02:58:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 14/14] format-patch: allow --range-diff to apply to a lone-patch
Date:   Sun, 22 Jul 2018 05:57:17 -0400
Message-Id: <20180722095717.17912-15-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submitting a revised version of a patch or series, it can be
helpful (to reviewers) to include a summary of changes since the
previous attempt in the form of a range-diff, typically in the cover
letter. However, it is occasionally useful, despite making for a noisy
read, to insert a range-diff into the commentary section of the lone
patch of a 1-patch series.

Therefore, extend "git format-patch --range-diff=<refspec>" to insert a
range-diff into the commentary section of a lone patch rather than
requiring a cover letter.

Implementation note: Generating a range-diff for insertion into the
commentary section of a patch which itself is currently being generated
requires invoking the diffing machinery recursively. However, the
machinery does not (presently) support this since it uses global state.
Consequently, we need to take care to stash away the state of the
in-progress operation while generating the range-diff, and restore it
after.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt |  3 ++-
 builtin/log.c                      |  9 +++++----
 log-tree.c                         | 15 +++++++++++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9b2e172159..aba4c5febe 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -241,7 +241,8 @@ feeding the result to `git send-email`.
 
 --range-diff=<previous>::
 	As a reviewer aid, insert a range-diff (see linkgit:git-range-diff[1])
-	into the cover letter showing the differences between the previous
+	into the cover letter, or as commentary of the lone patch of a
+	1-patch series, showing the differences between the previous
 	version of the patch series and the series currently being formatted.
 	`previous` can be a single revision naming the tip of the previous
 	series if it shares a common base with the series being formatted (for
diff --git a/builtin/log.c b/builtin/log.c
index 10c3801ceb..f0e99256a0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1575,7 +1575,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     N_("show changes against <rev> in cover letter or single patch"),
 			     parse_opt_object_name),
 		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
-			   N_("show changes against <refspec> in cover letter")),
+			   N_("show changes against <refspec> in cover letter or single patch")),
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("percentage by which creation is weighted")),
 		OPT_END()
@@ -1816,8 +1816,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die(_("--creation-factor requires --range-diff"));
 
 	if (rdiff_prev) {
-		if (!cover_letter)
-			die(_("--range-diff requires --cover-letter"));
+		if (!cover_letter && total != 1)
+			die(_("--range-diff requires --cover-letter or single patch"));
 
 		infer_range_diff_ranges(&rdiff1, &rdiff2, rdiff_prev,
 					origin, list[0]);
@@ -1866,8 +1866,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		print_signature(rev.diffopt.file);
 		total++;
 		start_number--;
-		/* interdiff in cover-letter; omit from patches */
+		/* interdiff/range-diff in cover-letter; omit from patches */
 		rev.idiff_oid1 = NULL;
+		rev.rdiff1 = NULL;
 	}
 	rev.add_signoff = do_signoff;
 
diff --git a/log-tree.c b/log-tree.c
index 56513fa83d..37afc585dc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -15,6 +15,7 @@
 #include "line-log.h"
 #include "help.h"
 #include "interdiff.h"
+#include "range-diff.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -750,6 +751,20 @@ void show_log(struct rev_info *opt)
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
+
+	if (cmit_fmt_is_mail(ctx.fmt) && opt->rdiff1) {
+		struct diff_queue_struct dq;
+
+		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
+		DIFF_QUEUE_CLEAR(&diff_queued_diff);
+
+		next_commentary_block(opt, NULL);
+		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
+		show_range_diff(opt->rdiff1, opt->rdiff2,
+				opt->creation_factor, 1, &opt->diffopt);
+
+		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
+	}
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
-- 
2.18.0.345.g5c9ce644c3

