Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60787201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbdF3UyI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:54:08 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35375 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbdF3Uxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:44 -0400
Received: by mail-pf0-f175.google.com with SMTP id c73so72474176pfk.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GLiW8ho1KW8Za2Nat/uBAjKEO71eNbNE+XuQwfn92mA=;
        b=JiAopwKawwPNHYa3GhPukGY4WJvMWil+R8sokCX0KuRqHwjj0lkbeRSHbEmkiNhz1L
         TR2t07uecnZX8SwibhHXb5GQEgCHOZtdfEcx8guPAujOMOXHoC4G8vS2g0qBrMXjsDNu
         43USUMXYOR0z9Cv2W52JzpTM+eiqUvz/dfxzRRolX8r63SSGKNMnOouRj2AYc0ffkPAW
         id5+/hckoaYY5X6JWYa2CXE+1ZmJhRgpibvlEQk3anAUsQJRlOPYPRw61SOA25TUOohD
         qOYSfNABDhA7a4Nn5Jpj6pkk9xKthatbACPEkFgTCZeFvkt2JHNIhg9wjbKYQTyvxwGH
         mG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GLiW8ho1KW8Za2Nat/uBAjKEO71eNbNE+XuQwfn92mA=;
        b=HaBG2U6Lp3X6O6ZHFQovKkZTnnJ1tY26p//dwnyJs43tnGIdMSBfmuyKRIa37eK0Tg
         XEKum2jFogR6CsTsMF3kTtWU2XxmlMIEGSdFn0fO5Fw6cARJ2XunsQMhhh309XEAXwfp
         fM6GhPi3qHeo3FnNsR/jpAoPtDj6EaIBQp1qcy+f6Ehtkk6m5drpx+PjUhxUyKNGo6Vg
         fWBaC9/MEKY+iJVCx3ZXtHotwMrj5RjKOMe4UwwHSrobXao2Z8lxEB6HvpRuWocwd6l0
         3e6uJIYaN8E7suGmY2SY+RYVEzv8A4+PNl//NejVssatcZ1KKvDitAHwG2Ho4D59kGqH
         dRFw==
X-Gm-Message-State: AKS2vOxIUZjhYUmtTqsOVt/gGAhypzRRkTm97yvhdjMfMuqf92QpF5HJ
        r+bs3BwZ+Uy6enyCJ7LLxg==
X-Received: by 10.99.233.83 with SMTP id q19mr22991595pgj.205.1498856018445;
        Fri, 30 Jun 2017 13:53:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id m68sm23163858pfi.12.2017.06.30.13.53.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 19/25] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
Date:   Fri, 30 Jun 2017 13:53:04 -0700
Message-Id: <20170630205310.7380-20-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
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

