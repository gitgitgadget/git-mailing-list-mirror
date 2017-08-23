Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D599620899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbdHWMiS (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36477 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMiR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id y129so1397445pgy.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmFgj086DJY1CmBYrhP3hcGS5fUlOaAXaAKy4ObTELw=;
        b=eBRKe1jCCt6mdpNJy+p6tF47ajSLT7+uwUIJekppD0AiSrLK6otYmjnXyR6t+fVLmv
         pgT9vIs0a5J9r5PChoB2MCONvhJqlbFSaCY7Ih50ChuLtF2XesLjaTUHtvQGtA3X0xbG
         WE8eJvlVXy4o9rnjYA8jxZrfC62L8Z3HpDWCctcu0pQp83SiKBZJI7UiT2/zKIozfXuf
         vE/MnXEZyuosCvgAetPfGA2ChQkdbLlBNdWdHC0XGnrz9euSZzneO/gvYlXHgsvvNEWn
         Oi52u+/Op8x5lQhQEMNWDMi/E9N2JY5r+gHV+EST2RbtfpdVcvJ3oxIQma2k0iWhmbQg
         DZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmFgj086DJY1CmBYrhP3hcGS5fUlOaAXaAKy4ObTELw=;
        b=ihICJgFPGbyNKBRzWgAKUfJdbpuUrCIZpyw54R4XwigvAHmACY9KUBkAQlstWM4tdl
         dr+YnNfD+ogyDjmHWdA21JEeV6Q/qApYzUaRzU1+5H8cqv2PlAbikWiVIHfXYXTllawN
         BqV7Y1ekQQrZmHwt7LRqcD2mtsyU9gzWjhV9s/rwvcN5dBedc9isbyGfepoBP0kedDJL
         e8lrJhztRhoRsJkP3vEcn8i6cL79T3+E1G6yP5hMvu7StQsSuc65py95ICh2SyA18RPi
         oBzyYT5/041gKf02toFrcIvTntlvtDJHYH80BFOXJcVoRpx1K1/+/CfECXAVyajhMqHi
         zaEw==
X-Gm-Message-State: AHYfb5i4M1t3b6wFcZs+df91++mGMK1Fmm+tIlYeEPLAUTxvhoZRuORv
        PEvPpc61j8Z22mfX
X-Received: by 10.98.102.74 with SMTP id a71mr2685035pfc.73.1503491896561;
        Wed, 23 Aug 2017 05:38:16 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id 204sm3285452pfu.118.2017.08.23.05.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 09/16] refs.c: move for_each_remote_ref_submodule() to submodule.c
Date:   Wed, 23 Aug 2017 19:36:57 +0700
Message-Id: <20170823123704.16518-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c      | 6 ------
 refs.h      | 2 --
 submodule.c | 7 +++++++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index cd61509bc8..7fa19e9309 100644
--- a/refs.c
+++ b/refs.c
@@ -368,12 +368,6 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_remote_ref(get_main_ref_store(), fn, cb_data);
 }
 
-int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_remote_ref(get_submodule_ref_store(submodule),
-					fn, cb_data);
-}
-
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.h b/refs.h
index a8d6f33703..5d25da227a 100644
--- a/refs.h
+++ b/refs.h
@@ -313,8 +313,6 @@ int for_each_tag_ref_submodule(const char *submodule,
 			       each_ref_fn fn, void *cb_data);
 int for_each_branch_ref_submodule(const char *submodule,
 				  each_ref_fn fn, void *cb_data);
-int for_each_remote_ref_submodule(const char *submodule,
-				  each_ref_fn fn, void *cb_data);
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
diff --git a/submodule.c b/submodule.c
index e072036e79..98e1f9d3c7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -69,6 +69,13 @@ int is_staging_gitmodules_ok(const struct index_state *istate)
 	return 1;
 }
 
+static int for_each_remote_ref_submodule(const char *submodule,
+					 each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_remote_ref(get_submodule_ref_store(submodule),
+					fn, cb_data);
+}
+
 /*
  * Try to update the "path" entry in the "submodule.<name>" section of the
  * .gitmodules file. Return 0 only if a .gitmodules file was found, a section
-- 
2.11.0.157.gd943d85

