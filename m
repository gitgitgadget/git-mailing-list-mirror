Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A29207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933367AbcI3WSS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:18:18 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36613 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbcI3WSO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:18:14 -0400
Received: by mail-qk0-f195.google.com with SMTP id m184so7129413qkb.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H4BfkkuHVkMqrvkZ4ZOjIdZ+yzbC5AIhyPC6hypDHpM=;
        b=OCAeqO3AwLf3yjQPRYDP5av0qmOHtUak7JvaKSQTUclvXeBF60gcuoxihoCDghDZjy
         1aJ7WM87VlEubidGbQpu/FSjVRPqEdARI0aPjDrh7dZC7n+r89l80cpJ6p6w8hbcbywP
         3O37GYrDiWHogwd5g1n6u4uBnIzcxmOUl7hDpPMjxLvtP5COffcUzreJ3vaHSSDPot+M
         NJ84SDvjiy9bhhipO4/Qnf2TQQOgmXHwdKJGd38XA6+79HHwbGssQND2vmFqHc1N9D8O
         1AN6S6EQP/PeMVAFpTEjXc3hAp5Zj8AiIlCOaFOShHlhXSuscsObMfgzOIlR2e5DPSB6
         Rukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H4BfkkuHVkMqrvkZ4ZOjIdZ+yzbC5AIhyPC6hypDHpM=;
        b=QQySUE/hbLnLPckeyP0AZseWxoTiYmgC+ODZbSqpGAovmjR3yWeQT3to5m5bOPTtGo
         zCfnLmvPnLM2oN3to8bK0vLPoN+nJaOPgUwtirs+saLJL6LaX39dFYRPgRfLQDuJiT/X
         dYrYYlcx8nkKkf+z1GXVD5ayETKSKK8fHM2qrfLWUHy6c9Lft9qSvIsUGc1zDjBIfh5U
         LNrIpnKISU8otcidLplJ3tS07GBtPw+hZsQhLfumqYf6W1mteWv9Tv4B4eNwePWDWvXS
         mBWpqyUma4JUMkC13js+OCTosEy60lyM8LFyJbLSZP6suzjUxBi2xbcDH1YzutJIeb1s
         rfig==
X-Gm-Message-State: AA6/9RlcFa7drgptz5WRVZB6z9ib9B5LIMJl9zPSw4dMJJIrxLJuRVcNgb81yOv9bJAk9eQg
X-Received: by 10.55.6.145 with SMTP id 139mr9870405qkg.246.1475273893307;
        Fri, 30 Sep 2016 15:18:13 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id x21sm11347615qkb.19.2016.09.30.15.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 15:18:12 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v3 2/5] ref-filter: add function to print single ref_array_item
Date:   Fri, 30 Sep 2016 18:18:03 -0400
Message-Id: <20160930221806.3398-3-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160930221806.3398-1-santiago@nyu.edu>
References: <20160930221806.3398-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

ref-filter functions are useful for printing git object information
using a format specifier. However, some other modules may not want to use
this functionality on a ref-array but only print a single item.

Expose a format_ref function to create, pretty print and free individual
ref-items.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 ref-filter.c | 10 ++++++++++
 ref-filter.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index bc551a7..ee3ed67 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1655,6 +1655,16 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	putchar('\n');
 }
 
+void pretty_print_ref(const char *name, const unsigned char *sha1,
+		const char *format, unsigned kind)
+{
+	struct ref_array_item *ref_item;
+	ref_item = new_ref_array_item(name, sha1, 0);
+	ref_item->kind = kind;
+	show_ref_array_item(ref_item, format, 0);
+	free_array_item(ref_item);
+}
+
 /*  If no sorting option is given, use refname to sort as default */
 struct ref_sorting *ref_default_sorting(void)
 {
diff --git a/ref-filter.h b/ref-filter.h
index 14d435e..3d23090 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -107,4 +107,7 @@ struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 
+void pretty_print_ref(const char *name, const unsigned char *sha1,
+		const char *format, unsigned kind);
+
 #endif /*  REF_FILTER_H  */
-- 
2.10.0

