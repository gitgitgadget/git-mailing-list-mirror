Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913E8202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 19:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbdJ3TrB (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 15:47:01 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46557 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932877AbdJ3Tq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 15:46:59 -0400
Received: by mail-io0-f195.google.com with SMTP id 101so29874072ioj.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J+QAmbhFL68giqcuCmSjSh9xPcoNtMUlXwaYnz2gYss=;
        b=c6ChNL5/0Qm18swzEd9Q6ZfYTmctfT59+KEPW1i4iFTxSTMSDFQDWuKClElsC6cQZs
         m72aBvL2u7yQKoMtBL2YCJ5EN57F/HA1jgvIFcDuUwlaMdBbensRIyPFto1YOac4mZB6
         B9dakBG/SJXvYeUuvIrmPiVOd4W9ZaXOdM92ZtgBHLcRbFORjRlFZPZyad2eSyS3InrU
         BxhxoMcofxSlyBHx85JXalWG8lRIJN4yDKYfZ0b/SwfkKTdOqdpAiN95+XeNvealE3el
         wxSHutKv+B9hajlfcjRU4YEugc+HyxUwsHS5PRsr2oyuPWoKmaH6e90YVPBjybQDciZ2
         E1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J+QAmbhFL68giqcuCmSjSh9xPcoNtMUlXwaYnz2gYss=;
        b=FxUE9QWHG2mrpz3jJv8R4Kt4d+484kVBtpfH2vPs43q28LT76NngyMSiYdH84+CwQ1
         qfn59rcpgucgRPyuba+kQcx6x1A4uYzcf3Q8pODaLRlgh52Ci2L+Z4dPw94604yf05JB
         9VdZdIwYizFmwaSsJJfb/86EvYK00o8HzQ/+Dp8ExiPnyh6eJAdDlHqxRq00gKjRb3il
         eaiXEmpHwPueRodGYeBM5wuw2rioa+jta2fEe3EVTKKWudCAyT4QmS4QHHU1cA1fA9x+
         AIM9kZB2HwclID0tDCLsqsnrb81uBTCuwk0Gb2dGvky8ixuiHfRKbx4A6Adi7D1CpRIy
         0IXA==
X-Gm-Message-State: AMCzsaWtUwsefL6wSJo4kHNSoxjdTlfvHpsw8jx5DWtKTT1I9hE6z08x
        17/DfR484bHrPpvCmXBaLfwFxqVPHps=
X-Google-Smtp-Source: ABhQp+TyQxxYia0GODgyLAqLXBcLVcA/eOTfOrmCWE7ECobqnEMXEUpEywuV05KB+y7J5JkgrB8Tiw==
X-Received: by 10.107.135.202 with SMTP id r71mr12168035ioi.26.1509392817859;
        Mon, 30 Oct 2017 12:46:57 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g195sm2372805itc.14.2017.10.30.12.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 12:46:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 4/4] diff: remove touched flags
Date:   Mon, 30 Oct 2017 12:46:46 -0700
Message-Id: <20171030194646.27473-5-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171030194646.27473-1-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171030194646.27473-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the set of parallel touched flags are no longer being used,
remove them.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/log.c | 2 --
 diff.h        | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 82131751d..9c0815270 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -134,8 +134,6 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
-
-	memset(&rev->diffopt.touched_flags, 0, sizeof(struct diff_flags));
 }
 
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
diff --git a/diff.h b/diff.h
index 4eaf9b370..7e567108e 100644
--- a/diff.h
+++ b/diff.h
@@ -111,9 +111,8 @@ static inline struct diff_flags diff_flags_or(const struct diff_flags *a,
 }
 
 #define DIFF_OPT_TST(opts, flag)	((opts)->flags.flag)
-#define DIFF_OPT_TOUCHED(opts, flag)	((opts)->touched_flags.flag)
-#define DIFF_OPT_SET(opts, flag)	(((opts)->flags.flag = 1),((opts)->touched_flags.flag = 1))
-#define DIFF_OPT_CLR(opts, flag)	(((opts)->flags.flag = 0),((opts)->touched_flags.flag = 1))
+#define DIFF_OPT_SET(opts, flag)	((opts)->flags.flag = 1)
+#define DIFF_OPT_CLR(opts, flag)	((opts)->flags.flag = 0)
 
 #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
@@ -142,7 +141,6 @@ struct diff_options {
 	const char *line_prefix;
 	size_t line_prefix_length;
 	struct diff_flags flags;
-	struct diff_flags touched_flags;
 
 	/* diff-filter bits */
 	unsigned int filter;
-- 
2.15.0.403.gc27cc4dac6-goog

