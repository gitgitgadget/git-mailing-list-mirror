Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA352027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbdE3Rcm (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:42 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35694 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdE3RcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:32:18 -0400
Received: by mail-pf0-f173.google.com with SMTP id n23so78350607pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EUDxQX9tDLlvRiE6LPXsQdut69tY+aimHQZsGXbOp7c=;
        b=mxemNg5f2dFBldHsXKbmj/0MY7jxsq9IzXrQz5y2hH7rwrPkO3xXJjBzL1rj0sqHJf
         PlEHQwB2AwIiTM3XVf0qRa+yQdWDOlofFcXndxCIZS/rl1FfR0GRxjJbZyjQZXqPUm08
         utceFf5n91hM1jk2JTZslRsZ+43qT/0g6cnDLMJ/2btMScG0akAEFV1Z2e9Z+kueIIjK
         2hw5p0mZLGQqYIz2wP2+PyrcK6ik+b+e3z2NlRKbugwjOHttjsSMKl5EgF0UIDHb9FDw
         g1KReF1q6XOAcnYyccvVSgsmn7k/CEMBdWlB3fj/nutN21vV9SUPVdaacUL6Vk4KkzvY
         6bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EUDxQX9tDLlvRiE6LPXsQdut69tY+aimHQZsGXbOp7c=;
        b=aWvfyiTgaHoGU36rk14YPASXDDaykMkYysHyd8ZbgHzgMrCPuly/1dqKcFUUv3ciyF
         x5qrFv/uCZTvOxyGnQZEiNUbloka7/5BegxFbSjZcpphsEWtHS1epzYDIXLFkQZE0Xab
         HzMsBGel68U6EhwKXvFA3NVvwgYCRoG34kryh1GGHhGm3R3iFPUt6qnC9JnW1E4BL9fF
         PsYO60QG4fbAhr6gBbq6cz0eMpp8iOyAr4olHx41GxjPOPtb11JZFOCPqjtqFXQAMWx5
         0PGvtJKZNpuOhFQjEYa5Q7+bAQU+B9a2twGHBqF+JovkprBKcBIeJNckalyrWK90sRRV
         x/jg==
X-Gm-Message-State: AODbwcCsgK2o4zSh0oXgtgIhtQHyb1VsP9WPppLMvvnaA3PTTv3lNKJZ
        Dp7WdQETU8jtP/B9
X-Received: by 10.84.174.67 with SMTP id q61mr84890861plb.97.1496165537923;
        Tue, 30 May 2017 10:32:17 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:32:17 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 32/33] diffcore-rename: use is_empty_blob_oid
Date:   Tue, 30 May 2017 10:31:08 -0700
Message-Id: <20170530173109.54904-33-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diffcore-rename.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3d9719dad..03d1e8d40 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -464,7 +464,7 @@ void diffcore_rename(struct diff_options *options)
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
 			else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
-				 is_empty_blob_sha1(p->two->oid.hash))
+				 is_empty_blob_oid(&p->two->oid))
 				continue;
 			else if (add_rename_dst(p->two) < 0) {
 				warning("skipping rename detection, detected"
@@ -474,7 +474,7 @@ void diffcore_rename(struct diff_options *options)
 			}
 		}
 		else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
-			 is_empty_blob_sha1(p->one->oid.hash))
+			 is_empty_blob_oid(&p->one->oid))
 			continue;
 		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
 			/*
-- 
2.13.0.219.gdb65acc882-goog

