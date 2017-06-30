Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605C8202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbdF3AIE (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:08:04 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:32812 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbdF3AH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:58 -0400
Received: by mail-pg0-f42.google.com with SMTP id f127so55149222pgc.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GLiW8ho1KW8Za2Nat/uBAjKEO71eNbNE+XuQwfn92mA=;
        b=OqU+yqQCl5TU67Asqm2Tyjzfo3yBhy6QvzF5cumLsf4bQWK/avVEC6k0zH7wOK3xVn
         QWFN0h8sDHPxSR07UPvzd2n2vekjPurdcnxldZGdjt4UcDkgPdPg279HAePi8N40JIpn
         VboxWNGRZta5JenfJuBPGfa7Wf3ayHYASX4eb+if2bp3eYfEky2NfEndR3G7nHeLOtIt
         f+FpVJXgIC1c6BfVnwxV1p02WBu9ZCzlwSPKjaAJBECvseQN4D3WO4hXVS0zGJ29vzPA
         N6EKBMtkXzpGOmKM5iz810hL6k+OpLK3uFiLqDQvvdnUwXOVZafjL2VIlFi783yA8qQT
         rURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GLiW8ho1KW8Za2Nat/uBAjKEO71eNbNE+XuQwfn92mA=;
        b=QS5pSOnUZoyQPUcywSKZ7vrKFArye7Z2OUWjj4fZt94hXW0yOyf5xmMtW/FeTakkuQ
         JId5fu7UxmvLUqSk1UDZB63hoQK45LZTtWGOtJzzs/+iWlUynv13Tm249cGGYpiSiooT
         ykZB2AI84gHScemGtlsJJDWbnWZzujkForVVw0butgGUFOzOdPs3NhHuDCfoWSqXsd6l
         YZnLdPWWLl8pCY+Dhe8ZToL49ftwFCqsmAHHVl6Os5Dx3tVJR7os/zVfYdt2FnkIaQsI
         HExxSIA3NNn7W47mlju6U9KfkhS5NL/9sKEoH/uQmWAwG3a3vMyFHGGcFsmbY8wvAMGe
         LRmw==
X-Gm-Message-State: AKS2vOzcWhMqfriycElHJ/fMByMfDEvGAXSMowKGLQi/ZC2WAPFRH1ZA
        qS1fD3dmILl+cNBhYcy6ng==
X-Received: by 10.98.16.12 with SMTP id y12mr18673346pfi.85.1498781267606;
        Thu, 29 Jun 2017 17:07:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id s15sm10667686pgo.48.2017.06.29.17.07.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 19/25] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
Date:   Thu, 29 Jun 2017 17:07:04 -0700
Message-Id: <20170630000710.10601-20-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e0d39d04da..5a9c55736d 100644
--- a/diff.c
+++ b/diff.c
@@ -571,6 +571,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
 	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_WORD_DIFF,
+	DIFF_SYMBOL_STAT_SEP,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -766,6 +767,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_WORD_DIFF:
 		fprintf(o->file, "%.*s", len, line);
 		break;
+	case DIFF_SYMBOL_STAT_SEP:
+		fputs(o->stat_sep, o->file);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -5077,10 +5081,10 @@ void diff_flush(struct diff_options *options)
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
2.13.0.31.g9b732c453e

