Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531A02082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbdFWBa3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:30:29 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34070 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754021AbdFWB3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:52 -0400
Received: by mail-pg0-f52.google.com with SMTP id e187so15008105pgc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Zd8PrP4EIaov/AztwmHCyqboCnwyuVH/leCwnTrOI0=;
        b=XzfC7G6bHjQG0QUgH2ILE3/vto8Nprltumb+zvWuLaOrk0fYjD4r7iQKce3k3MlKm4
         0PMm9Pi0Mfjgo4De3fB+8qdlYPPA74M23BIUWy89yVErv8b+UNdgE4zwxoTgxcp8uTOx
         i1gOCfR9eRMSCIz1B+8xK/vZOS4h9+uw6zWQS9xnoXS/bmicF+mDfcxvyR5K2W3tG9Od
         +vGupkS8dfoVi93FdhBPng88uiFf+dY4JOVnRK4Weajq6Y+U+Qc4oHSfWfJVacGPU7dE
         5GIx47gBDu767CuB2zsTkOzMGPNEf5LL9t4MXgwgrJMhoWw6u/AqMmDD6GONoqkk9xMs
         WHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Zd8PrP4EIaov/AztwmHCyqboCnwyuVH/leCwnTrOI0=;
        b=kqUVkcDYFDK37ax/eSih5egAkw8pXNaJv2oVaHhnP4eokzYt1prMSSZaMqSRO1Ww/T
         kzuk2A0JHM4gyNHBmXJ20suv5XDpWUdO+A9TEEGvKQZoE4Ugcev2t90TbCXU701gxOAw
         pEAtjOC05oYAJNZ+8WxY1697xzASkcVb3W/2EU2QX65Wjt5Tuxm2pd6/txL/cpfsEN+s
         ty8ktGFiU5gAA60ZXglml9NEthe7ZUzb9YRf83yyRCHvu+/hOGKyIOm7fF6/tq2EzgPB
         XotwVdb1/msbwXcsB+XC3KTDtiEt0P376FScSkOcu5cTaRdtnS5h46f1Mx8hKxUBG78C
         Hx9w==
X-Gm-Message-State: AKS2vOy/21x4But3/9dnXgdumHADwypIxzA/1O/f+k0i0fpJG0nzK0nH
        fUoKTlsh704VQmMS
X-Received: by 10.99.113.11 with SMTP id m11mr5464313pgc.45.1498181392233;
        Thu, 22 Jun 2017 18:29:52 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id m73sm6700189pfi.12.2017.06.22.18.29.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 19/25] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
Date:   Thu, 22 Jun 2017 18:29:13 -0700
Message-Id: <20170623012919.28693-20-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 60630d2c3f..0ed86ba984 100644
--- a/diff.c
+++ b/diff.c
@@ -570,6 +570,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
 	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_WORD_DIFF,
+	DIFF_SYMBOL_STAT_SEP,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -765,6 +766,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_WORD_DIFF:
 		fprintf(o->file, "%.*s", len, line);
 		break;
+	case DIFF_SYMBOL_STAT_SEP:
+		fputs(o->stat_sep, o->file);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -5082,10 +5086,10 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
 			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0, 0);
-			if (options->stat_sep) {
+			if (options->stat_sep)
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
-			}
+				emit_diff_symbol(options, DIFF_SYMBOL_STAT_SEP,
+						 NULL, 0, 0);
 		}
 
 		diff_flush_patch_all_file_pairs(options);
-- 
2.12.2.575.gb14f27f917

