Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF3020136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754981AbdBPLtp (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:45 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35769 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754801AbdBPLto (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:44 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so1485284pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35m45/pBT2vmF9x2+c7JiVQtpuPxXA45S9uz0OCV0lw=;
        b=ZCvqlIAFESULxM6XF7uluVfOQNcqk8HmpKwmq/T09JzVLsxvos0W2jf5z8JXx/pkC+
         M+iF0gHFSni+LxoDbPitF4RKyR0CVaVhgzZ9GzNxcXvvtvVDAduoN5rBG3XQPd5aLFOc
         A30zXcvabIEY2BysJup1IbXzOp1TWXO7JzrxFFVp6IP430VOS0v9lfJub9D1qgo6jGrN
         Zy6z2lQXEuM94srcaFK9HGizcVcRZr+sUSopXNwvrFU8pVqIwtQ6yCoA22lAr1Op/CAn
         xZJBviDOWOPcgIaQ0HDxhtF2BOzUOceIXHzFeeTZLlF6tiJCiUJQhJxko0li4nbxFI2E
         5AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35m45/pBT2vmF9x2+c7JiVQtpuPxXA45S9uz0OCV0lw=;
        b=Kk1z0VSjZ5NiL88AbhQvf87lE7VsLKBdQRXTg1UuOyvDZ9RQiUPrD8gP1uB192ahSZ
         NvPRRqrtTrNwZSjfJq/5NqwI7fnayAPZHPoxnXPTvvwraOkyvnmPYUXey1cvC3o9/bib
         2FWapPG5vMw2ZTSHqjGt443YZOdmTpPOuw2UFm95hWVBPTyXzZiXNoyixdKNd1ke71E6
         2ODsw9R6YZ1mSZzFdGhOPyOQHIMM88nQwgN/nim+tLbxsMVGqig3lEHKE14xkBPVmvIo
         ndLDNzhvwNI2lMhSH2W6mhossBqkxFbhnvjE7vFovpmWyLXubgvJVyNavIF9geqAhD4K
         uKZA==
X-Gm-Message-State: AMke39k685LVGpfG6NRe/ihMMu3mN2XixjIAq/WFrNdG0VVKhKKV5v2YtChaV/WLNpRS3A==
X-Received: by 10.99.109.140 with SMTP id i134mr83124pgc.11.1487245778532;
        Thu, 16 Feb 2017 03:49:38 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id m21sm13472269pgh.4.2017.02.16.03.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/16] refs.c: introduce get_main_ref_store()
Date:   Thu, 16 Feb 2017 18:48:10 +0700
Message-Id: <20170216114818.6080-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 7a474198e..10994d992 100644
--- a/refs.c
+++ b/refs.c
@@ -1445,15 +1445,23 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
+static struct ref_store *get_main_ref_store(void)
+{
+	struct ref_store *refs;
+
+	if (main_ref_store)
+		return main_ref_store;
+
+	refs = ref_store_init(NULL);
+	return refs;
+}
+
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
 
 	if (!submodule || !*submodule) {
-		refs = lookup_ref_store(NULL);
-
-		if (!refs)
-			refs = ref_store_init(NULL);
+		return get_main_ref_store();
 	} else {
 		refs = lookup_ref_store(submodule);
 
-- 
2.11.0.157.gd943d85

