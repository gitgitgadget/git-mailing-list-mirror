Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8749CC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A9C2072E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2ywW+eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404849AbgFYMtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404800AbgFYMtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D831C061795
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so5714594wrm.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSY9ppiqBuxjNhnWpM8tlVZkd8trufCqv0ywlZ6IJlY=;
        b=L2ywW+eWHblIHO1ni/H+D8plf4+3y5ORpJXY5tnO9Bpk+yFDmVCMrWVGgdYPX2w4nz
         hhbO4Hte23hLxyyoersFJLbbBLIW8uNDt+wu0v12x7wPeY8FTa29oFJhvTsmXP38+yG8
         aZpx1mtZ3pv4K9R92FMo1fc1xfEpztH6rkRLvrZxyeOqW3GZRXMTRNLvDG8jNXUZafVw
         4hlmymPG1DBZbLNXHdAxZJZYqnI9XRklTImtN74ILJVVFW7hZr/gcO6jMZuEMfu8PAfH
         NCw9ypJ6mdPIgx5esjP2X0L8Cqchk+WUpl2qGgkOEFITp6sMJqf+p/Ru1HrWWMZVBIyZ
         OLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSY9ppiqBuxjNhnWpM8tlVZkd8trufCqv0ywlZ6IJlY=;
        b=ODTlk3n37Hxcklv8Yi5iakCp0Fukugsq9SzuVsU34agN695IF0S/dHOT5uYgaJWVia
         ICsJ9p2KdrKqBqTUr4yVm5QUhAIyDFupnJ3wRiUE+s0hoAF61cmbw0yiHUn0p11Lbb5i
         2EuTzbL7Q6sgxs2pYGDVFkdQJnjLhJ4yRRLLcelJR8t8JyiGWN6Txa712XiFbmJV8yfe
         3qDotfTzVSK6j4G89AwGJPxxyc2G0d+VauOXQFM+cj50scKHO2hIi1iQ9z+/wqS0Julk
         toRKj1uT4p1UAPSHVJDNQ1NWT55IBMTRBhhZsODJYtv2Th902W+R4ISU+KkzCHKBLBEO
         ALDA==
X-Gm-Message-State: AOAM531D+b3fMf/O5fZ4EVKXtbF6LjQfLADozXE5+ObhBOoYnwahSa5m
        JUg8hXWHd2iL18UyAJvabTXXjfrb
X-Google-Smtp-Source: ABdhPJwMp2xte1dG7BVrIkSOXretMY36/L6B3Qo0kGEWuBwoT4VBREU8kvcVtaGiqYnM7/Iu1cVnzg==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr26560309wru.411.1593089353641;
        Thu, 25 Jun 2020 05:49:13 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:13 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 16/17] sequencer: use the "resolve" strategy without forking
Date:   Thu, 25 Jun 2020 14:19:52 +0200
Message-Id: <20200625121953.16991-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fd7701c88a..ea8dc58108 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -33,6 +33,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "merge-strategies.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1922,9 +1923,15 @@ static int do_pick_commit(struct repository *r,
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts_nr, (const char **)opts->xopts,
-					common, oid_to_hex(&head), remotes);
+
+		if (!strcmp(opts->strategy, "resolve")) {
+			repo_read_index(r);
+			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else
+			res |= try_merge_command(r, opts->strategy,
+						 opts->xopts_nr, (const char **)opts->xopts,
+						 common, oid_to_hex(&head), remotes);
+
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-- 
2.27.0.139.gc9c318d6bf

