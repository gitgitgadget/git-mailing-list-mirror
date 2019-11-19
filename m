Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B78B1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKSBHD (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:07:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33283 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfKSBHC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:07:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so11263425pfb.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 17:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=meH4f8LdpBqeKcUunz7UXpC09f0XInkG+sJvKU+0AWY=;
        b=sM3txx/2ipcjiIrnWfgjnxghPHQVszCjVs3Vrcqmr/ozRZDxbpg2B+RmfAyaGYNRfc
         jhe4lkA6KZqWNk6LAsN4QuVBNyTv89WMiJEq/twHCu8eFdfXBH3iBcQrAtxjD/ILgOSn
         eyEKZpSEsCuvZiUi9fUrspEWwmLH8tVWvIZCyhtozABaGfzf61GAeHt5nAIHy6P9f0oM
         TmezamHWUb2GcpjMFqjtB8qCBMI3JZ+Yo53HCU4hvEP/XQ086gfCB+ujqjKVMdnvOHnP
         pRY13WSjI1KciL/jYxKm1JBEOLWIyhvUz8J/xarQNUINl9wQbHw+BA5FsxZ+yoxsTe2x
         4U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=meH4f8LdpBqeKcUunz7UXpC09f0XInkG+sJvKU+0AWY=;
        b=nW6lgdFHmg3N7Oo58D5CRJlpHHNqg4DmQZF5EkG2EEw/Jg2FRqJ69Pb7j5sT5s5ffo
         90FQU+5IWVYVNNteb34X2u65NNaJkjimNsXcCnMx1155mpe1fiAA8tvPLx90icTu9fXk
         2rE9SRFAjR8EUoXauwph/CjaIBXybuyK6TKNCMxowzm8wzJXKdBj6tBbdyUixfxlKeNl
         kfnpftcMHo4SBI6ArVZEvgDlubQVLdDtaVJENqmB2Pq0cgeky/Zs4HSot74vvRan+Nbb
         YqgEblqPjCUvAYU4Aqd6bGNsn0pFyhUZpnn76DxtKOBQErEO/8g3ahXFj0I9/kUbs1oj
         LoQA==
X-Gm-Message-State: APjAAAWSURfN7wLMSYZuuvsFyQx23S0pkOXJeqE+rxifbctyPDp418Nf
        GOOB6FdFGkTyx1Ds/t3Yu6IcTl0y
X-Google-Smtp-Source: APXvYqxiYikL/5vQmPOTgm0TX4uLxkas3+5gMefF3EEoNzRoo07K6MikVmFfplrWjdE4ayAFFRYq0A==
X-Received: by 2002:a63:3144:: with SMTP id x65mr2348200pgx.283.1574125621680;
        Mon, 18 Nov 2019 17:07:01 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 193sm25034913pfv.18.2019.11.18.17.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 17:07:01 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:06:59 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/3] range-diff: use --no-notes to generate patches
Message-ID: <48e850df876eccd3c6cda49ee048565b2592e33b.1574125554.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574125554.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit being range-diff'd has a note attached to it, the note
will be compared as well. However, this shouldn't happen since the
purpose of range-diff is to compare the difference between two
commit-ranges and, since the note attached to a commit is mutable, they
shouldn't be included as part of the comparison.

Add `--no-notes` to the `git log` call and mark the corresponding test
as passing.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 range-diff.c          | 2 +-
 t/t3206-range-diff.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 7fed5a3b4b..725930ee92 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -52,7 +52,7 @@ static int read_patches(const char *range, struct string_list *list)
 
 	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
-			"--no-prefix",
+			"--no-prefix", "--no-notes",
 			/*
 			 * Choose indicators that are not used anywhere
 			 * else in diffs, but still look reasonable
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 29b9a6f854..671703f85b 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -505,7 +505,7 @@ test_expect_success 'range-diff overrides diff.noprefix internally' '
 	git -c diff.noprefix=true range-diff HEAD^...
 '
 
-test_expect_failure 'range-diff does not compare notes' '
+test_expect_success 'range-diff does not compare notes' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
-- 
2.24.0.420.g9ac4901264

