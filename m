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
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3F41F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbfKHUIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44268 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbfKHUIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id f19so4603945pgk.11
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fIUZc4mjtg9EwEfY4suK5kzEtDA7SiW4D221jGJ6FXU=;
        b=njGihXc9wRRSwV2Y77/0eMb6mstPPEvcn/esw4b249x4tDRMFHozj+eGuibYhXBIQ/
         1ubApekYiJgOxgMW7Sl6H9Zjc2VxaLdNGv2nzpEdBJgdfEd/Sjk02Xt6o0NczhhosWrS
         +tJdVEcdQdK8khWKF+qASP1GHpFBSuZynzgmb4lauuDYXGpXad+cMDFKot/cqZCmBYg0
         AV6xNeZaDxjEjBCz+bjhdQ7vtSjCJIXicCsxevnhL/gEto75uKOTDZfNa3HrK/SEAWTQ
         29mGmrAhSifl5NKYSwBOjHKo7m7HKB/el71YAPX2xlvZ8gWot9S8kCYAxvMazx87YnJR
         mjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fIUZc4mjtg9EwEfY4suK5kzEtDA7SiW4D221jGJ6FXU=;
        b=QDeM7OkBUofdoKu7xIX48WIJa++rbYw2hEPvYrI5XAKqs8HMMsjz18sBEJdt3l+jxk
         ldBQO9RtQR4oj45seJle6povDbIgQTD02RBLWV0RYRfqc40Js2Ft/OBKqEGL7y8btXYi
         50rHf02qV9lpFd9Y/8F4BG+f48M5UMKJxGRmzK/BGZuAdukqaI3YnG7wwdBm/axgjyK6
         KEGoqXG+b1PNFwJzwiR8TMEtJPCWYYAs3tgjR91qgYKr2U0WPvvH4fQvWfrfYo/YxBII
         6AZ6yBAORsSoV2/7Qqv3ne7CiBqqHbc0BjQFmG7wBiTQ3hmUjM4DBUUEFfZ+/p5fBrVd
         c6ug==
X-Gm-Message-State: APjAAAXNIYzWlIyTd+ZAOvS9iWAVn5FtinML9Q5KNvW0bm1I748EhNQi
        C4zpA1TlXBf8r63Eq9z6rmVmGtJI
X-Google-Smtp-Source: APXvYqyLfu39v64Nf9RqyaMHggrvRveHBufwAAygQjfJtjOilPV94eGHXP4EIif6DuHpyf4a1jetxw==
X-Received: by 2002:a62:7c52:: with SMTP id x79mr14022638pfc.18.1573243714418;
        Fri, 08 Nov 2019 12:08:34 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id v10sm6644426pfg.11.2019.11.08.12.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:33 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:32 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/10] reflog-walk.c: move where the newline is added
Message-ID: <05dc446d417c28512c0d8a25bd8e62b9d7fb529e.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we want to possibly be able to continue the reflog message on
the same line without breaking the line. As a result, when
`oneline == 1`, strip any trailing new lines.

Add these missing newlines back in show_log().

While we're at it, cuddle the else with the closing brace of the if to
more closely match the existing style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 log-tree.c    | 4 +++-
 reflog-walk.c | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 923a299e70..4a7d668af6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -661,8 +661,10 @@ void show_log(struct rev_info *opt)
 					    opt->commit_format == CMIT_FMT_ONELINE,
 					    &opt->date_mode,
 					    opt->date_mode_explicit);
-			if (opt->commit_format == CMIT_FMT_ONELINE)
+			if (opt->commit_format == CMIT_FMT_ONELINE) {
+				putc('\n', opt->diffopt.file);
 				return;
+			}
 		}
 	}
 
diff --git a/reflog-walk.c b/reflog-walk.c
index 3a25b27d8f..6b6bd18e6c 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -285,9 +285,11 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
 		if (oneline) {
-			printf("%s: %s", selector.buf, info->message);
-		}
-		else {
+			int len = strlen(info->message);
+			if (len > 0)
+				len--; /* strip away trailing newline */
+			printf("%s: %.*s", selector.buf, len, info->message);
+		} else {
 			printf("Reflog: %s (%s)\nReflog message: %s",
 			       selector.buf, info->email, info->message);
 		}
-- 
2.24.0.298.g3e88fbd976

