Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B2C2D0A5
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59D2207BC
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlHwEvhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIALAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIAK6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71679C06125C
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so691825wmh.4
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRwrzj3BPk/K48IuZFLFzUEIerK1jDcOigS9kfN8NR0=;
        b=hlHwEvhe1ql6Hjdg72/GfvshPBICeJH6b3IP2n98A7zoM6fZteHtXeeA1jPMl9hbNy
         VQF5GFM/IghV2HzvNvbPA6WrPt3xkYCDfCt1z5FpHOIubWEKLCmqI6r4ZzN4d5cZdFyk
         iPJCTLaMBB7zcFoBYGxff2kP3g44G1CMlIk3xN7+b5rdO9IO/bDUdbrsOJDPJ1L+82Hw
         Jj3Y3BqHHmPWmQvWnGVj4StJ3bCs0ICN7fmUdignXpk+J/sGBaR4JTRsFYAA/KkXWvHz
         TLa3i7Czy2ZeULbGDvqqmvGXhfxEC/739/LzTwwlRtd5YFG6jzwNPuD95cWNqEOJ0jTo
         MDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRwrzj3BPk/K48IuZFLFzUEIerK1jDcOigS9kfN8NR0=;
        b=PKr8sKfuBhLIcJEKZnHcQ+RZ1kOY05dK4SFz6ejk7CKN/q8WjLBlef7TUsNT3efxLL
         y5IWEwdRGixGUAVxI8al+8n/Rbb1drkWNlY9KTBQ5Ntsojd7Nr4Ev56AwHops17d9gWB
         AvFbIpgCBiWgX4viFMVSk27R5IUe17xQ9Vzju6SqyvjG3tWWo0w6lD/d1f7QLTpa3DVh
         05yMZv5ujBlUK/3Wzl+NsW5I3KSdyoQTIzP8VaIa/GoXgd2rGNv4+JFZjhAugOd4WJhn
         D4sBrVPdPRA0ZXu5977zlnF695pPu/+z7VAgucPNtJJKujq+WfkHJEy9RNExIIBxrmeU
         FM0Q==
X-Gm-Message-State: AOAM533cAgubHLECR5MuThEjZc1v0LoBgsCrLS9mO/Ma6fThDxpYiJns
        hL5NSt2inEAGqqAnx2vSKbyY1fS+lbY=
X-Google-Smtp-Source: ABdhPJwtzkSsUgdLtG48hKNFnW0veztMLP98KMEj5yd42gwNUe1UXdLzBSMvy7RzcUJSKFyqgp/TZw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr1279369wme.46.1598957900894;
        Tue, 01 Sep 2020 03:58:20 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:20 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 10/11] sequencer: use the "resolve" strategy without forking
Date:   Tue,  1 Sep 2020 12:57:04 +0200
Message-Id: <20200901105705.6059-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
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
index 2425896911..c4c7b28d24 100644
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
2.28.0.370.g2c2dc3cc62

