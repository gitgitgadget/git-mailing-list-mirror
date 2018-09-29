Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E85B1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeI3BkX (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:40:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32803 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeI3BkW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:40:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id o21-v6so7250366lfe.0
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41b5LyjPxBOGJy2oERhln0Kbaiw7quSdzC9AzbHcFf4=;
        b=DDRYqMbAFWVgwiqZ/P/6T6f7oz3YSf4K0cGxFd8+zl0tPN5R011i8nRVXhYMrMDVr1
         AfYsUjsScjDVozLiHWvjycK165sjq279qdCH0FlqOPxvCx9RguM3ZiyVDsWDZHiS+pbA
         JA9so9JYCseazAohiZnFeO8KRfJpFu5ndeGKuQi8JwSN6TX2X9/MJ52fWcjhAyhJz6JJ
         QshNIMi8fXDN/4UjLr1FIh9fWE9BaVbHADD2Mq1AbwsjW89ZP9zS4N6D9oQQsF4NEmPZ
         vIBY6d3G9uJFXE75ry3ucD5RwiDFCKF2wEiD256Lxqd8NpLDPkXkjpiSjfvX9rY8ITf9
         y0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41b5LyjPxBOGJy2oERhln0Kbaiw7quSdzC9AzbHcFf4=;
        b=munzGjBXGjiu2rk9RhJA0Vnoe4as7O/Z9JSqWsJCTmUUMjAjOIgtsV7FcAAdyc4Ewe
         SD8pCdP2PVkQC5m/CVHM4mSWjX8MdZUJeWizft5dvgo7g1AdThK5KpeaZghY5hL6bYF2
         lAXTcXyMm5xtl61HofgZwZeGqbt1903xQRFbPMp5lJkwRm7h1npd37MLMsHM8WPvUsRY
         x4Wbmsw11Go1wXVaGvyQp7drOLM9Bab33xwZW/pcvBz9Kf7CJmW3iyUlr3ykqYMui/w2
         xQA6Hc6CDOi802xK+7Ydyml+rFhu7aq2s3SjvYIFMfXoPZ8LTrA0vV3ZVX5FRl9QB93C
         3PBA==
X-Gm-Message-State: ABuFfoh72zimYW+ly+fSdjrxd1tMWCasdC/MN3UwLyWYV2P9VXa3kHwV
        uTe8SdteKa3LisrUlekFsio=
X-Google-Smtp-Source: ACcGV619U3nMYKsuu7QRLeAqu5QduLDMYzGECg1K650sB2cBtq3ES+GmGnrInGAGnI/1nk3LljsuWQ==
X-Received: by 2002:a19:e21c:: with SMTP id z28-v6mr110331lfg.20.1538248246876;
        Sat, 29 Sep 2018 12:10:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1638494lfi.23.2018.09.29.12.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:10:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 4/8] revision.c: correct a parameter name
Date:   Sat, 29 Sep 2018 21:10:25 +0200
Message-Id: <20180929191029.13994-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929191029.13994-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
 <20180929191029.13994-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is a callback of for_each_reflog() which will pass a ref
name as the first argument, not a path (to a reflog file).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index e18bd530e4..63aae722c1 100644
--- a/revision.c
+++ b/revision.c
@@ -1277,13 +1277,14 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static int handle_one_reflog(const char *path, const struct object_id *oid,
+static int handle_one_reflog(const char *refname,
+			     const struct object_id *oid,
 			     int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
-	cb->name_for_errormsg = path;
-	refs_for_each_reflog_ent(cb->refs, path,
+	cb->name_for_errormsg = refname;
+	refs_for_each_reflog_ent(cb->refs, refname,
 				 handle_one_reflog_ent, cb_data);
 	return 0;
 }
-- 
2.19.0.341.g3acb95d729

