Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36DB203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbcHKSqx (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:46:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35767 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbcHKSqv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:46:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so847452wmg.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:46:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=csak9AEB0Qvt69EMkVYjsNutcybttdcMbO5jjADqu0U=;
        b=EqMqGyhr0/sRCYKezx8zkpDvEeSCDvoY8uDfGdBpKFvQBsgGz+goq3bCi/UVgDCPtD
         //uAh4mW2OgN5mmC1WfcRJmb3nWhkrHxoY5Zh0I90anMPLHbNSBKz8kRe7uScWYB5oSC
         f0BtrdKCaaht32shuQUzrcx2VNWSeiMGoGIiBW3wpK7ThmubqgavEfwL8TOXebhZRR2m
         Wj94MBxALnG/9nARBgQkCeOnHH1iYHy97YkEyOAniR51ZyHijtKhiFwqPno3uUZps3sG
         ApftsRJMcKR1UpIPA4kYHOJvvJKYqrrq3vtTiVLQvxVDFOt7babKBVb9bSZClmNRMPtl
         mG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=csak9AEB0Qvt69EMkVYjsNutcybttdcMbO5jjADqu0U=;
        b=mycgGIm3ivXOFBe5Y5409vVgcOSFuRmdOqEeCvI0V05+/EdFDqbGfejQRDBElHizvg
         BBiVCv+dv2mRCODKuCicMrcLo3tZhg+rOTleypjwVZtMsWoTx+OxJ0ZsJ81bU90cJkTo
         JZIsAZRMYt8NvVwZKTGLPurRuoMEcLFTXyB0F6yC37IEC6c0xUMydALWpSv4e7zsTr6j
         N6Z6q31SYhJ0reWTO077K2zV9YallmazthaO0c/6gBQ9wiONU6emutRtdDPYTxx5+htK
         Xw9lPJNIyD+fjHNGXVlwPRWiB4EOo6SputSFcKR50az+WAal1PyCEd6kyLorqE4mMJJ0
         XBDw==
X-Gm-Message-State: AEkooutb9zzl+2oezsGopBhSLfrGbgFT39GcvLDj6JDuswSias6y/r+0lqk0iFAffUt3uA==
X-Received: by 10.28.229.19 with SMTP id c19mr11802355wmh.0.1470941209426;
        Thu, 11 Aug 2016 11:46:49 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:46:48 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 04/13] apply: make some parsing functions static again
Date:	Thu, 11 Aug 2016 20:44:52 +0200
Message-Id: <20160811184501.384-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some parsing functions that were used in both "apply.c" and
"builtin/apply.c" are now only used in the former, so they
can be made static to "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 apply.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 7b96130..c0cb3f5 100644
--- a/apply.c
+++ b/apply.c
@@ -27,7 +27,7 @@ static void git_apply_config(void)
 	git_config(git_default_config, NULL);
 }
 
-int parse_whitespace_option(struct apply_state *state, const char *option)
+static int parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		state->ws_error_action = warn_on_ws_error;
@@ -57,8 +57,8 @@ int parse_whitespace_option(struct apply_state *state, const char *option)
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-int parse_ignorewhitespace_option(struct apply_state *state,
-				  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+						 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
diff --git a/apply.h b/apply.h
index 5ec022c..df44b51 100644
--- a/apply.h
+++ b/apply.h
@@ -97,11 +97,6 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-extern int parse_whitespace_option(struct apply_state *state,
-				   const char *option);
-extern int parse_ignorewhitespace_option(struct apply_state *state,
-					 const char *option);
-
 extern int apply_option_parse_exclude(const struct option *opt,
 				      const char *arg, int unset);
 extern int apply_option_parse_include(const struct option *opt,
-- 
2.9.2.769.gc0f0333

