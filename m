Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC0520248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfDFLf0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34063 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so4491253plt.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3v2pGZYYNA4vHhXBdQpgOJwZY6sVcbs2AiPmlO3aS4c=;
        b=MQ4wpACngvKazX/PhZ9PJLHtVPe1tUgJEy55uGHb0jpNK0ZoLhGV0MU+wvlp4qsTEc
         K5b9lKGO0pcNw0RNEPFr/S9E2ePvms9tzPEUiYP36l5ob59+18Dz7hTcU5udNKTXqhMB
         a9c5sBOMaLX8v1Uyr4UU39Iw/QBWUVOyo+UbQgqburD+4P5yll/VUcf+/9Zs2tjwFkAf
         4s03uTQHLVvHPFIHl+wzexwq5CZT/objtOs5YphBUv3jqtCAsqbAZgX9IeL8IhFWyZbE
         i/v9cQK1s2kyWCILNNnxMR1+GPO0GPYQCUnp7/SMKD99g0g2hJvQX9lB+TZWnokqQbAl
         uV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3v2pGZYYNA4vHhXBdQpgOJwZY6sVcbs2AiPmlO3aS4c=;
        b=mEdu9yJ9Ue1eFxhAMkRpWKg7N+Y9bvHfj3tj3krN2YVsxKJ+25l9xsK3GKzhBtDhmT
         cpEZ4JUpyNrAV2HhvHqWJgcC3gg7AIfGjxYtpL6RmuZLZ6ICWJpQQ1b+WiHtXa+FsJFc
         sThYZDWlHEUtF2SNWKvg9kHfkE3AfqRX0k0MG8SUTkx72SnDlpekosBjJxqu1/wiLZU3
         gwj55oDtn//Ey+bmDJkU/p5ekMKZc10c3fX2kmBj2mb8EPnI/1/CjKkW3FwII0RRWyv8
         MPdPKklXh3rO10YmtsSmBcosL8hM2GbZcMibgJUTGBU8NfaNt7lAzD+9MN7RXjFm+0jn
         afgw==
X-Gm-Message-State: APjAAAXSQiMMJJeFrz+1n+MXY5t4T3vhV+Ay/RiFoxJjhYM1uwzZ3JC9
        L5wsLTtMeNSCh7bGK0+mGvs=
X-Google-Smtp-Source: APXvYqzzRvF/SryMLL7AfdVTqykvmVsFT4UFmHd4QWtOd6b/fNHr9dRAz75oIwZ6adPLSiPdtrHhJg==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9mr18904158plk.76.1554550525795;
        Sat, 06 Apr 2019 04:35:25 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id v82sm57670167pfa.170.2019.04.06.04.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:25 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 02/33] builtin rebase: use oideq()
Date:   Sat,  6 Apr 2019 18:34:22 +0700
Message-Id: <20190406113453.5149-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Use oideq() instead of !oidcmp(), as it is more idiomatic, and might
give the compiler more opportunities to optimize.

Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
v1.0.7 (previous Coccinelle versions don't notice this).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 868bcd1446..c064909329 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1792,7 +1792,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * we just fast-forwarded.
 	 */
 	strbuf_reset(&msg);
-	if (!oidcmp(&merge_base, &options.orig_head)) {
+	if (oideq(&merge_base, &options.orig_head)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
-- 
2.21.0.479.g47ac719cd3

