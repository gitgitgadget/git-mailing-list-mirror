Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEE2C32772
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352671AbiHSQct (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353095AbiHSQag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8C11CF11
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy5so9670789ejc.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nzYC6orhp3pGxCRXrZND8zE5aEUGrJPwksX+apCN6Pc=;
        b=kJaF0/awz9Wt9yM0R+cMPxi0ZCS3LXeO3zmDVoHIs3lYXTmE50iP95ZWvRGd/rZfFt
         yeIF4L6rVgL0E2YXf3jXOcvcTNNT/TvEZj0owiKbphcUmCJma6LyjyBAo3+d/gHfzAUD
         FyJ6Mv30vhYVEPf7QEsX7qT0RoHspTm2cxdezJLdkmstAIl1mTgiIKRAQ8wz64wcTBhW
         MuXUwWw4ucCP6/2w9pje2EklazoB6t8F5KAhwM3dGU9k0VrmfL8X0sLjpUx7P64q1p/A
         fGVhVY22VpnP0q53fcdP2k7UvQLgqiNh14X/cLUkhEW5y2rig0FYxCBiYeha3bMfKrcV
         SS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nzYC6orhp3pGxCRXrZND8zE5aEUGrJPwksX+apCN6Pc=;
        b=RMNYZsWh1R7ckmnRrhGFCTSwqKlSO5xV8L1cq2/KfX20WTIllJ59w7iisA7NFyJmv/
         iAUBPEQA/6RPSl2eWvrnSB1EhuYWUT0xMJK/zwGPZjFuULUau0/gWhR/fs2wq7V7D8h9
         mDI3BsSIrI9hKrvFlamZlaptrnftrDh4UMt25ErLYhu/Wfh+eVf8koi3SkE/aHYCa1si
         z/yf18JxJqQdcLfsCQrPAt7kAFDBwUBrpvcF9xDjMZ8m4nu2nc073vQZaRVv/nk2atCu
         XlruYTctejqW8efuh95l/ddwZwjMaZVSHw1SwT6Auc/uuId9+0EbTXtR9yYUdKQ6b0ET
         c1ow==
X-Gm-Message-State: ACgBeo2a7IBrNcpeOokSm9rZYPxHkjEPuK7qvvgEsPXzHl5RWMDUFcrP
        g2rsx/KgSJ4FsaKzDAytGxVmlr+NtHg=
X-Google-Smtp-Source: AA6agR5VTMa5O5C2LZR/dOyCRmERyT9QAB2fmdDsIpfRvapHd9EhyLJjEGKXffgygTUpR0X0xscmLA==
X-Received: by 2002:a17:907:d88:b0:730:d0bc:977a with SMTP id go8-20020a1709070d8800b00730d0bc977amr5482230ejc.664.1660925091302;
        Fri, 19 Aug 2022 09:04:51 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906368800b006ff0b457cdasm2504045ejc.53.2022.08.19.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 10/20] builtin/bundle.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:01 +0200
Message-Id: <20220819160411.1791200-11-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git bundle' parses its subcommands with a couple of if-else if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling missing or unknown subcommands, and listing subcommands for
Bash completion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/bundle.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 2adad545a2..e80efce3a4 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -195,30 +195,19 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("create", &fn, cmd_bundle_create),
+		OPT_SUBCOMMAND("verify", &fn, cmd_bundle_verify),
+		OPT_SUBCOMMAND("list-heads", &fn, cmd_bundle_list_heads),
+		OPT_SUBCOMMAND("unbundle", &fn, cmd_bundle_unbundle),
 		OPT_END()
 	};
-	int result;
 
 	argc = parse_options(argc, argv, prefix, options, builtin_bundle_usage,
-		PARSE_OPT_STOP_AT_NON_OPTION);
+			     0);
 
 	packet_trace_identity("bundle");
 
-	if (argc < 2)
-		usage_with_options(builtin_bundle_usage, options);
-
-	else if (!strcmp(argv[0], "create"))
-		result = cmd_bundle_create(argc, argv, prefix);
-	else if (!strcmp(argv[0], "verify"))
-		result = cmd_bundle_verify(argc, argv, prefix);
-	else if (!strcmp(argv[0], "list-heads"))
-		result = cmd_bundle_list_heads(argc, argv, prefix);
-	else if (!strcmp(argv[0], "unbundle"))
-		result = cmd_bundle_unbundle(argc, argv, prefix);
-	else {
-		error(_("Unknown subcommand: %s"), argv[0]);
-		usage_with_options(builtin_bundle_usage, options);
-	}
-	return result ? 1 : 0;
+	return !!fn(argc, argv, prefix);
 }
-- 
2.37.2.817.g36f84ce71d

