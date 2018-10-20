Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70A81F453
	for <e@80x24.org>; Sat, 20 Oct 2018 07:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJTPSx (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 11:18:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44185 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeJTPSx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 11:18:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id d23-v6so3368007pls.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 00:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxIdwquJzE+I4wk2f5VFdTkSq/hdx7XMK96EnQDf1Qk=;
        b=OIJM4r97Frj4nkcTNIA5Yw1e1Vdmuge+vyC+eLjEGGFkFcdfFM83cneKyqs84AwUX7
         F62g2cqohhKvDlGTbcxzq7y8GQ+O2Wvp1M3YMEbVtVCBlZHJIqvve5XNUVrmHXBfLhDE
         e/Up+57YYpotFdjmdhfVg4eWVyStxBoyUQdOBpbn1nkdzyxBUvvL0kBoozvXgZN0moWn
         uCO9PCnnxuiXdyPHFnvMOSpi6lNRO3xSqUZBc5XZ1hlwhoU/HhMOq50Nxt/05TPwwsEv
         6DVMUNpCSLfT9Q45ze5yZeRgJ+uk0mCpsr/zG1km8hthm2KrLGSiLjAdJ/2WtLqcFcHo
         GE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxIdwquJzE+I4wk2f5VFdTkSq/hdx7XMK96EnQDf1Qk=;
        b=Rc2dHve9O7gbvR5cJyJKXtfKDX5R33Nv/oWcsF8zg9XjDPVrh/GyvDP+kubVv0wHAw
         iP8LWwgnngBIZleYQeHKYjYk94eXRgLxVg6Fc3WiOJC3nD+Omk6eaP3+rz7bssH6ok2t
         4Syc60v9PGiMfmuH6J5ILY/IgZvcqeWV3a3b0wP14N1Gm1ZcHmeTGjxLiInv0m4duqCu
         aq08f+YGZgGsrqpUH/htCN84w1jI9Y0q1xGnK9r5K4UITYLU3m6fFeGhfWPNBy/BJiwF
         tFynwSX/mlED+9t2arLbg4keTC+BW/lqtBtm/eNu79oh6SihwMj3xtmTNPAB75zjBiTj
         oyeg==
X-Gm-Message-State: ABuFfoiqEaUlrHPYmKKwc94dmqVEomiE4sgFwQNd7NZ8jCdRBPpJWy9r
        yyWL89KvURSK7mQ61LzqLVE7fNWt
X-Google-Smtp-Source: ACcGV62jC+gpHW7NUy0Ha9YxISnkrlNOmmN9cyYByz2ejsyCa6Dj4BNKmcWso8BUract/1FZdTzVhg==
X-Received: by 2002:a17:902:24b:: with SMTP id 69-v6mr37992277plc.280.1540019367628;
        Sat, 20 Oct 2018 00:09:27 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id b10-v6sm38570211pfe.148.2018.10.20.00.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 00:09:26 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] builtin/receive-pack: dead initializer for retval in check_nonce
Date:   Sat, 20 Oct 2018 00:08:59 -0700
Message-Id: <20181020070859.48172-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NONCE_BAD is explicitly set when needed with the fallback
instead as NONCE_SLOP

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 95740f4f0e..ecce3d4043 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -507,7 +507,7 @@ static const char *check_nonce(const char *buf, size_t len)
 	char *nonce = find_header(buf, len, "nonce", NULL);
 	timestamp_t stamp, ostamp;
 	char *bohmac, *expect = NULL;
-	const char *retval = NONCE_BAD;
+	const char *retval;
 
 	if (!nonce) {
 		retval = NONCE_MISSING;
-- 
2.19.1

