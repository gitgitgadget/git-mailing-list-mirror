Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177702047F
	for <e@80x24.org>; Mon, 25 Sep 2017 04:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbdIYEIP (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 00:08:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35637 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdIYEIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 00:08:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id r20so2967319oie.2
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRN9VrHbFjGi1xvxsU/qKkSANvCxo7Kh5bIVjSRx0Ck=;
        b=P5a19hojb//fXhTyUv8JtHZZWcJU2gN/Q3zx6/DrZ69WiW2CSn2RxGe2Q/kpigGBrk
         RAQbxJN5z0HMQ8TnEf5tt4CdGzqKebjn6Wl5MoQhpsihFA9f+TUsqmGe1ykpchvlwGOi
         DZYyLvf4LSxAtvw3KaYrJTxIH0f1JQldCjHhvZec4OWfQbsujJmL03GSSybCHcE7cJA8
         Xf1wj3rcuS7Mqabjjj0Tggrx6cHqtzKVdqwmjQefFiC88ViSz4hsaezyh4Mc16xTOhOx
         Cez4Ryf1k1XSm8azGR03HsCsFizM+nUxMFqZOChG2tM9uw04dgj/mVE3U7sWUoWqWleM
         n6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRN9VrHbFjGi1xvxsU/qKkSANvCxo7Kh5bIVjSRx0Ck=;
        b=VMQH20QhZpdBAjHvaYjTqlarmxQhZH79Hze9UbfYMc79GQLQYK3wMt3b2tjEWouLwZ
         Kg557gPQ+fB56moobS+oRcWh2XJ6i9fuE+H3jQiiT04Dq++LPD8xG6kIAaD01KtD2sPS
         pdPiwaDsz7Ij/ibMZurQUbdN82v/6oy+pbz0QgYgCAhzBqEXruiMMtxVEzkETG6cAOyQ
         fRyLCR0dwRvt0NShFDbfFV2tWCoU6nxLwbXhREbQm+BmgCOra/0ECDcS4pEUHK4W4E+P
         qWeHLDHKW77GRTwftUSsfzeJkENXVg2BZEyFtzV5PKn+KLogYypyjk04bq3QtD6Q4s9G
         +9DQ==
X-Gm-Message-State: AHPjjUhVftgzEAqQcWRtUUwKuQ++L7o2BWvl5U+EIIk7xvh3MrpgwNbK
        ys+BNDSZhC4zJvX1VTUvEFxNt7fw
X-Google-Smtp-Source: AOwi7QCtnHOmbySZOTPhQIWYc4YWDe5VQo3CqrywnHjED4bjJWdNhz/ClutK3YPe0svKx7TaE9XKkQ==
X-Received: by 10.202.207.132 with SMTP id f126mr8146801oig.272.1506312492600;
        Sun, 24 Sep 2017 21:08:12 -0700 (PDT)
Received: from pixel.attlocal.net (75-59-239-78.lightspeed.sntcca.sbcglobal.net. [75.59.239.78])
        by smtp.gmail.com with ESMTPSA id x206sm6514571oig.55.2017.09.24.21.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Sep 2017 21:08:11 -0700 (PDT)
From:   Brandon Casey <drafnel@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Casey <drafnel@gmail.com>, pclouds@gmail.com
Subject: [PATCH 2/3] parse-options: write blank line to correct output stream
Date:   Sun, 24 Sep 2017 21:08:04 -0700
Message-Id: <1506312485-8370-2-git-send-email-drafnel@gmail.com>
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1506312485-8370-1-git-send-email-drafnel@gmail.com>
References: <1506312485-8370-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When commit 54e6dc7 added translation support to parse-options, an
fprintf was mistakenly replaced by a call to putchar().  Let's use fputc
instead.

Fixes t0040.11, t0040.12, t0040.33, and t1502.8.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 parse-options.c               | 2 +-
 t/t0040-parse-options.sh      | 6 +++---
 t/t1502-rev-parse-parseopt.sh | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 0dd9fc6..6a03a52 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -599,7 +599,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		if (**usagestr)
 			fprintf_ln(outfile, _("    %s"), _(*usagestr));
 		else
-			putchar('\n');
+			fputc('\n', outfile);
 		usagestr++;
 	}
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a36434b..0c2fc81 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -92,8 +92,8 @@ test_expect_success 'OPT_BOOL() is idempotent #2' 'check boolean: 1 -DB'
 test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no-yes'
 test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no-no-doubt'
 
-test_expect_failure 'OPT_BOOL() no negation #1' 'check_unknown_i18n --fear'
-test_expect_failure 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear'
+test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown_i18n --fear'
+test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear'
 
 test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
 
@@ -288,7 +288,7 @@ test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 
 >expect
 
-test_expect_failure 'OPT_CALLBACK() and callback errors work' '
+test_expect_success 'OPT_CALLBACK() and callback errors work' '
 	test_must_fail test-parse-options --no-length >output 2>output.err &&
 	test_i18ncmp expect output &&
 	test_i18ncmp expect.err output.err
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 1bfa80f..ce7dda1 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -139,7 +139,7 @@ END_EXPECT
 	test_i18ncmp expect output
 '
 
-test_expect_failure 'test --parseopt invalid switch help output' '
+test_expect_success 'test --parseopt invalid switch help output' '
 	sed -e "s/^|//" >expect <<\END_EXPECT &&
 |error: unknown option `does-not-exist'\''
 |usage: some-command [options] <args>...
-- 
2.2.0.rc3

