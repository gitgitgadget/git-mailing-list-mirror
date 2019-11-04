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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BEE51F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfKDUEF (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:04:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42699 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfKDUEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:04:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so6164592plt.9
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8IwljkIz6CVwZIm90p0bHcVH+CFlFeV4rtuB9hz+2FI=;
        b=MISWMH/0+AAiiZ71JA1D474+kkbBTJsbkb64OZYg8MpA8pbuR/o8BGdo8PV9/IPJe9
         +eeNQBJN8SXWOpzvAaaBBrDPEHliyx0JDOrofaPnLAEP8vvPdn1Lm30VntqYCBGY32kH
         2UNfLcPbyHtNb/srii7UyTjgIQ6ONxBKIscWB4gTMwsvIgJUXd78gMZU9vqB/36/HDhD
         aup4U9tT1s5yMDs3V8T6/KI/mOsyz+KCrOI5oPnQOoYEVtq0dF9Z1D92jBCapOkuZafT
         F792rjaAfcwuacty/GZBPXViTSbb6LuorEXdm1+65pibN6ce/YTHYWdgX60ICRQoiEj0
         2ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IwljkIz6CVwZIm90p0bHcVH+CFlFeV4rtuB9hz+2FI=;
        b=LvR8T/CrnYXsjJufCcxN2Lr8c0OxWU6lRL96hnpPcnF0fB19fVALK5EQjRk6LN0lWA
         H2jJZ+FLxEQL5pKeuXtvwQYTrDjkSjovwbO8ESiTI4rjlwP3Kl3yFPiyyKoYrmOasy7K
         bT/Z0j4DNBvxEw4dlSHYTr5QazgY1qDwQ1IjfWQYIN7CZMEpj6pT6EFBl4bAZg4ZhR0c
         IrqXnZ9HJfPdArh05HPr/fMTJgi2BYP7LApB8wGzCss6QKIhYOOyiYOzA9Q7LUwu+7JM
         nzAHbqpJQ1eXFRgfEra6gY6YnXEA/pVeAufxAClaK4e264gsbGfLQxeAM0VTo0axT0ra
         GerQ==
X-Gm-Message-State: APjAAAUXYz6aLDqAhhuZq+NRQG/xtmxBF93VP0N6Juc8yIucfTReBqmY
        SdM3b4GW1LJK4NX/SyfA5IOPLzPG
X-Google-Smtp-Source: APXvYqwpgX4QX8hGFRPGS6gO6iwm7hBbSz/4t8c6VslpikXgG7rBDOzvR3NSq6t0e8JhiP40HsZ0XA==
X-Received: by 2002:a17:902:aa04:: with SMTP id be4mr29576939plb.279.1572897843777;
        Mon, 04 Nov 2019 12:04:03 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id j22sm15132982pff.42.2019.11.04.12.04.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:04:03 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:04:01 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 6/8] reflog-walk.c: don't print last newline with oneline
Message-ID: <449c58009ae46d43ec2bd0499674c9858b706d04.1572897736.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we want to possibly be able to continue the reflog message on
the same line without breaking the line. As a result, when
`oneline == 1`, strip any trailing new lines.

Add these missing newlines back in show_log().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 log-tree.c    | 4 +++-
 reflog-walk.c | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

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
index 3a25b27d8f..e2b4c0b290 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -285,7 +285,11 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
 		if (oneline) {
-			printf("%s: %s", selector.buf, info->message);
+			struct strbuf message = STRBUF_INIT;
+			strbuf_addstr(&message, info->message);
+			strbuf_trim_trailing_newline(&message);
+			printf("%s: %s", selector.buf, message.buf);
+			strbuf_release(&message);
 		}
 		else {
 			printf("Reflog: %s (%s)\nReflog message: %s",
-- 
2.24.0.rc2.262.g2d07a97ef5

