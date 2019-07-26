Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51351F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfGZPx2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33676 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387870AbfGZPxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so24855927plo.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Z6F9twMkSbreoW1v/Rpsvj7PeUmVMVkgcfx+om6qCU=;
        b=Fxq5m6ZPf7aXxUu6nJj8m6QQzGEx7wb5Jj0mUhRQ+tdOEWDm+rccAiVtnCTtaQUo9U
         ChlMb/oozVFVAhn9JrVY3Ux+RnYAwuNbRJvHlRigWTocPS+VX3JhEaiFdv05tGg/8kDG
         00+JTJMx1HG57q0f9JrfvQvxAgZDr/GQISVbMyGxRRuBoFYUDWhHPfSZLryD0gEToYoZ
         fWQuRdOdUEygPPrECAbhSeLya1Zs/wbATZFDUycZKMjHK1Q1QyjifHmuxYRDJkA6sTD0
         Z6clf0xm8VoubqeaOBixQSmeccBiTHy0GUSoE7QDmNKi1oOTWf3yKw5JAMItOKLfi0Yh
         IIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Z6F9twMkSbreoW1v/Rpsvj7PeUmVMVkgcfx+om6qCU=;
        b=c0Ry7E8OOlN8YwDhxS7EaMxvO5Ks8+Y35baWDL4kXCHtl1ockZOaunvHGuvwkLphvM
         gcdCW2PeO+rhdQwam9fjL01cmxsCLRK2Afk03UGLn165iiTDR6xglIlicX2K4OX2MZC8
         4P1x8ySISRJoWTC9vGh3ZU4wfogUNu32vnCwrXrPCqWMvP11/k+cnAupr3ZQJdJv2k92
         vNI/yxH9CaSoLuUrOlAWT+nehl17hzerT7IlGmd0TWgY0eiskMa8pFfSdazWpISZY3Kn
         qKIA6xaDiTBQH3C3kYr9C20bO1ZBw+50DGHEiNl164P28DKIWCE3TyRCffcPvDhvGgMh
         ptGw==
X-Gm-Message-State: APjAAAUxtPd4wxoM1xXDJgL1kUT347YkFY9vejUW6QVyxpWBFloHAjCn
        R8BWxyMBQELu3rtEX/TbjBOjG/nU
X-Google-Smtp-Source: APXvYqxR5IS2Pc0aDhsBLw7dLCNWHxdEaVx+EpuDCTyF3va2Jp+dbt2esxoareQedN+vFRlOEqciSg==
X-Received: by 2002:a17:902:8489:: with SMTP id c9mr98098002plo.327.1564156404798;
        Fri, 26 Jul 2019 08:53:24 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:23 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 18/20] merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
Date:   Fri, 26 Jul 2019 08:52:56 -0700
Message-Id: <20190726155258.28561-19-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to implement the same outward facing API as found within
merge-recursive.h in a different merge strategy.  However, that makes
names like MERGE_RECURSIVE_{NORMAL,OURS,THEIRS} look a little funny;
rename to MERGE_VARIANT_{NORMAL,OURS,THEIRS}.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 14 +++++++-------
 merge-recursive.h |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 27e0bdf48c..49eb50c17b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1046,10 +1046,10 @@ static int merge_3way(struct merge_options *opt,
 		ll_opts.variant = 0;
 	} else {
 		switch (opt->recursive_variant) {
-		case MERGE_RECURSIVE_OURS:
+		case MERGE_VARIANT_OURS:
 			ll_opts.variant = XDL_MERGE_FAVOR_OURS;
 			break;
-		case MERGE_RECURSIVE_THEIRS:
+		case MERGE_VARIANT_THEIRS:
 			ll_opts.variant = XDL_MERGE_FAVOR_THEIRS;
 			break;
 		default:
@@ -1359,15 +1359,15 @@ static int merge_mode_and_contents(struct merge_options *opt,
 							&b->oid);
 		} else if (S_ISLNK(a->mode)) {
 			switch (opt->recursive_variant) {
-			case MERGE_RECURSIVE_NORMAL:
+			case MERGE_VARIANT_NORMAL:
 				oidcpy(&result->blob.oid, &a->oid);
 				if (!oid_eq(&a->oid, &b->oid))
 					result->clean = 0;
 				break;
-			case MERGE_RECURSIVE_OURS:
+			case MERGE_VARIANT_OURS:
 				oidcpy(&result->blob.oid, &a->oid);
 				break;
-			case MERGE_RECURSIVE_THEIRS:
+			case MERGE_VARIANT_THEIRS:
 				oidcpy(&result->blob.oid, &b->oid);
 				break;
 			}
@@ -3786,9 +3786,9 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
 	if (!s || !*s)
 		return -1;
 	if (!strcmp(s, "ours"))
-		opt->recursive_variant = MERGE_RECURSIVE_OURS;
+		opt->recursive_variant = MERGE_VARIANT_OURS;
 	else if (!strcmp(s, "theirs"))
-		opt->recursive_variant = MERGE_RECURSIVE_THEIRS;
+		opt->recursive_variant = MERGE_VARIANT_THEIRS;
 	else if (!strcmp(s, "subtree"))
 		opt->subtree_shift = "";
 	else if (skip_prefix(s, "subtree=", &arg))
diff --git a/merge-recursive.h b/merge-recursive.h
index 0d5e928832..350fb43a01 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -28,9 +28,9 @@ struct merge_options {
 	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
 	long xdl_opts;
 	enum {
-		MERGE_RECURSIVE_NORMAL = 0,
-		MERGE_RECURSIVE_OURS,
-		MERGE_RECURSIVE_THEIRS
+		MERGE_VARIANT_NORMAL = 0,
+		MERGE_VARIANT_OURS,
+		MERGE_VARIANT_THEIRS
 	} recursive_variant;
 
 	/* console output related options */
-- 
2.22.0.550.g71c37a0928.dirty

