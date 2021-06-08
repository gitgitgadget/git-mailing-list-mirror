Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657ABC4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A5D61183
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhFHQOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:14:53 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33337 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhFHQOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 12:14:53 -0400
Received: by mail-wr1-f51.google.com with SMTP id a20so22257260wrc.0
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WzqMxGoQ/3QN9nGAoj4YC9PoEKvW66Mog8VCSaih88w=;
        b=tsy4q+9XamJWbHePjctiOzU4ebGVAnasrVbKLPxgVwEHK7zspu1djho8t3wdTqBf/1
         QyO8Tr8aibjD+mU1iF3gbeqR3IILpkI82VanSAAb7ZhARqk7DXl2nc6SSHi95Jsgqccz
         TRb4aRlpej/SbFfk98GLEEmU2dsPObjoK8RJYT3UA27Oh1qlVwOtoMqYWTzQQv9gMmrJ
         5UDlNC3ZtDHY5HrzTw140RjbCc6B2Zue0G0+Jb5MgucPTPVrotcQALaG74Ct8PWolEDw
         A+0cbzyH5OGuwfHuLSMPN0giIPkw81y737lq3Q/HHIfxuceSbappo4NO/yG07a6ZBnD1
         fIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WzqMxGoQ/3QN9nGAoj4YC9PoEKvW66Mog8VCSaih88w=;
        b=JK7rr4Vn7ZCjuJzGH1ykkUkJCmGi2+GE4j1IZv+gUxhFoKenopDh6ZiQsgBQz33SMb
         dXK9X5ari7zYug+X7XZqMBVk9MRvWTFDPJxl0sQtdSi9R2bDjel/tf9nJS7sgveVOpvR
         StmFDObt9j2K1C37vYm2+quEznsXN8BBkge8jcxKU3WlqN1pz3NWbsR9fRKYCXfuREPM
         sf1PV9Eo5T0A/3t1HYVa17uwbqf9wkCJqa0a4hBY7qucw7pSTbpuVFtmf04hD2sPjOdc
         z6Zw2UBpeQtgR4ltIOyjxUd6lga2Ph832jP3Nqun1xTP8b/vZK6y4zUXRaJQZ47gfg3R
         GWog==
X-Gm-Message-State: AOAM5319IE0r8/XBp1FM7KKsiBvQNgsiLI99VZcjV1DKrEhgqOu8RLy0
        1Fv7EqAml4E5IOHQDaycswqbK4p/gZU=
X-Google-Smtp-Source: ABdhPJwLU7qQywro6oetwViXO2NYtNCZgxCISAg66iTOJkdLLwGQSeq9+kB2jFW8dlu7xyakm22lpg==
X-Received: by 2002:adf:c18a:: with SMTP id x10mr13553648wre.193.1623168706382;
        Tue, 08 Jun 2021 09:11:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y26sm11256689wma.33.2021.06.08.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:11:46 -0700 (PDT)
Message-Id: <55c0f2c4560a5361979f3fac52e19b720036fe79.1623168703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v4.git.1623168703.gitgitgadget@gmail.com>
References: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
        <pull.962.v4.git.1623168703.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 16:11:41 +0000
Subject: [PATCH v4 3/4] Fix various issues found in comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A random hodge-podge of incorrect or out-of-date comments that I found:

  * t6423 had a comment that has referred to the wrong test for years;
    fix it to refer to the right one.
  * diffcore-rename had a FIXME comment meant to remind myself to
    investigate if I could make another code change.  I later
    investigated and removed the FIXME, but while cherry-picking the
    patch to submit upstream I missed the later update.  Remove the
    comment now.
  * merge-ort had the early part of a comment for a function; I had
    meant to include the more involved description when I updated the
    function.  Update the comment now.

Signed-off-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
---
 diffcore-rename.c                   | 2 +-
 merge-ort.c                         | 8 +++++---
 t/t6423-merge-rename-directories.sh | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e333a6d64791..35378d84e8f1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1543,7 +1543,7 @@ void diffcore_rename_extended(struct diff_options *options,
 			/* all the usual ones need to be kept */
 			diff_q(&outq, p);
 		else
-			/* no need to keep unmodified pairs; FIXME: remove earlier? */
+			/* no need to keep unmodified pairs */
 			pair_to_free = p;
 
 		if (pair_to_free)
diff --git a/merge-ort.c b/merge-ort.c
index 061f15701359..2ec382e292a6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2533,7 +2533,7 @@ static int compare_pairs(const void *a_, const void *b_)
 	return strcmp(a->one->path, b->one->path);
 }
 
-/* Call diffcore_rename() to compute which files have changed on given side */
+/* Call diffcore_rename() to update deleted/added pairs into rename pairs */
 static void detect_regular_renames(struct merge_options *opt,
 				   unsigned side_index)
 {
@@ -2586,8 +2586,10 @@ static void detect_regular_renames(struct merge_options *opt,
 }
 
 /*
- * Get information of all renames which occurred in 'side_pairs', discarding
- * non-renames.
+ * Get information of all renames which occurred in 'side_pairs', making use
+ * of any implicit directory renames in side_dir_renames (also making use of
+ * implicit directory renames rename_exclusions as needed by
+ * check_for_directory_rename()).  Add all (updated) renames into result.
  */
 static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index be84d22419d9..e834b7e6efe0 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -454,7 +454,7 @@ test_expect_success '1f: Split a directory into two other directories' '
 #   the directory renamed, but the files within it. (see 1b)
 #
 #   If renames split a directory into two or more others, the directory
-#   with the most renames, "wins" (see 1c).  However, see the testcases
+#   with the most renames, "wins" (see 1f).  However, see the testcases
 #   in section 2, plus testcases 3a and 4a.
 ###########################################################################
 
-- 
gitgitgadget

