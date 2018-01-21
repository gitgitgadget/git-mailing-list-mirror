Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C5A1F576
	for <e@80x24.org>; Sun, 21 Jan 2018 23:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbeAUXmT (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 18:42:19 -0500
Received: from sonic301-7.consmr.mail.bf2.yahoo.com ([74.6.129.46]:41384 "EHLO
        sonic301-7.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750878AbeAUXmT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Jan 2018 18:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516578138; bh=38dV8mkYHF3HeCG/wfWlnUopoNmIzJ16+ClUup3uwVw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ea2rs/K24u8yW5l5WnwvR8b6fLB8zZr493e/lg7BkrI2uqGGGarlVPBaortevJFfnlDWeYY5+hKL61HSl1CIN3IgQfivdmahgrhsqy/xOJdb39OT7BUC6oHOUCrJbw6P4K5d093zuTKEttr40eX0m36ZxW2PMzhTTMlfZ/EN2lkcE8Ijsk/4eELiyEXpCmVC+NPnrCaoysK03jlWVQer/TK3hgHzQ9wkbJhs8QpsCn70ZKdJ01d9hsDWPbQZINDdnwErmcyuRdZSL0OOKaWNHeh1B9ddrlzPQRKsnu4SJXBMhYfeHPs9s2Rn2vXeCoIsSx9ewhzLH8ZCahwu99JTIw==
X-YMail-OSG: U_PPLO4VM1l784oZChpxzPbYvjW9URi5a.aXVKfPjRLDAOh7Md_L7YthQCP5mnl
 .qNbStKp7M1r9s7A0j1lkn.d2gvG8bNcLOzs3zu5Jf5.ViOOzAQ552FhQu8kJZ6YbeDfqPIXyWo4
 IgxmQyOL5HWNdf2aFXaWFmMRbBG33eFHGjJqnm0WPZYKZHX_54mzf9p.0iipP3q25kw741VeZS9w
 4zLqE44BwEsiIDUQIQg5uR6ARiBwGOezbovBSNYWCYmSs877RJWiEAdMgWPID49riJqXsaeGBrxY
 K2IBNovrkmR7A8Ycv9RYCS4z7YUv2XmZapHxTc29L8XVZnn6Dgz5tPGVG82BEOaVRdh4d8MltHIz
 2FcFb6QPA7qIN0X_WHNwBDEyQcLSR2ncLfGMrmt7_53hPoznMf2gNaLiU_kAAkQTLLbN66cJRLgT
 q78GWINQZUtnNr4ZqDZTkfXqm1X.hCMdfojYBK5lHaFufTjZUAm9vrFcs6WBKDSflhAz0OAy6FYS
 _dZ.3KioBpx20ZL5KHMABWWlinHXRIUCA9ICaCv9CFU2tHEz36g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Sun, 21 Jan 2018 23:42:18 +0000
Received: from smtp106.rhel.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([98.139.231.40])
          by smtp404.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 658003e76b47aa0b456f7039861b9699;
          Sun, 21 Jan 2018 23:42:17 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v4 4/4] Add intptr_t and uintptr_t to regcomp.c for NonStop platform.
Date:   Sun, 21 Jan 2018 18:42:03 -0500
Message-Id: <20180121234203.13764-5-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180121234203.13764-1-randall.s.becker@rogers.com>
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Fix missing intptr_t on NonStop in compat/regex/regcomp.c wrapped
using the __TANDEM guard define. This is done because
git-compat-util.h cannot be cleanly included into this file
without additional compile errors.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 compat/regex/regcomp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 51cd60baa..8bb4c966d 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -17,6 +17,14 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#if defined __TANDEM
+/* This is currently duplicated from git-compat-utils.h */
+#ifdef NO_INTPTR_T
+typedef long intptr_t;
+typedef unsigned long uintptr_t;
+#endif
+#endif
+
 static reg_errcode_t re_compile_internal (regex_t *preg, const char * pattern,
 					  size_t length, reg_syntax_t syntax);
 static void re_compile_fastmap_iter (regex_t *bufp,
-- 
2.16.0.31.gf1a482c

