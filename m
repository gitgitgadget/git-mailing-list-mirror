Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8791F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeICWbe (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40427 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICWbe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so1021928lfi.7
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+Kj1VaD6rVVILNrJ+wkHEV4pP1IUVxxYcORiVww0Cc=;
        b=XiVhN6qZxNLc8n58SgHXBVgbGrQW2qU0eMuN3wkbKDiqPHPC33GxBWPrHgNZVn/DOl
         U2Zi0xpmlQBeoyR0CXi/j0Ws5c69KP/Da7B9pX+AydU4zpbnk6KhvLMpchXPfSxMIiuC
         YflfAPWE3a3nZACnNCOAD/amAfsCt7d7aD1x+G6RGMYdkrBrDQO8GkGHHt9bZN2Tz2Yc
         EOTCpgBrX/rp6nwc5xy39HBY1TaUNgGjiPccjfYCptbkEwuicE8WdfaD+cJT7HvVj5ZJ
         rb2cX6O5E2+/debbAGWiUWakmM7cqHwowiQIsMDShjiPTMQITmafsIQhb78rqPbiZIVA
         cjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+Kj1VaD6rVVILNrJ+wkHEV4pP1IUVxxYcORiVww0Cc=;
        b=bdlYkzCMHNGVWN4fLjYwrzWpj2juC5vfoa3/D7SmtbOPn8krbi851XykAN56JrIazL
         vCQ+3TLjJmbB1Ww57NA+umFrE6U1GOXmruGvS69AdKsF3AAmSS9tj/e07hTZWZmEFrRZ
         pAditMzc9k2C7sMPGdQ/r96OryBfv27XSIzLUb8C9axMKO0uv8fcDHNs307XlANPl/0i
         HU0omgtOJ1UKiJL7/47+ZnfIhXTK1uES4EzXMFc/RU1l0oaV2+pvAei1TvYqzWFY5MVl
         huqBXPjVE0RvuKj2vOg638G0Azi+WLd0KW+q0qTCe+qqCCGz5D3Fade726K4NG6ssHyN
         etXQ==
X-Gm-Message-State: APzg51AzSeSHi/6jXsjIbhiCXb+F2ji3mWbnJzi3EonH/WVomwbZwR3R
        qkxbWlb1AerbTG7ZzdYm2LA=
X-Google-Smtp-Source: ANB0VdauoMXq4sL+QzjtbIp4Ck1NToOqU+SPHbOpASdh2r1+KBaZ63YA0wGwAD2d9X9bUQ0Bqd5ZJQ==
X-Received: by 2002:a19:5353:: with SMTP id h80-v6mr19236779lfb.9.1535998213398;
        Mon, 03 Sep 2018 11:10:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 02/24] read-cache.c: remove 'const' from index_has_changes()
Date:   Mon,  3 Sep 2018 20:09:10 +0200
Message-Id: <20180903180932.32260-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function calls do_diff_cache() which eventually needs to set this
"istate" to unpack_options->src_index (*). This is an unfortunate fact
that unpack_trees() _will_ destroy src_index so we can't really pass a
const index_state there. Just remove 'const'.

(*) Right now diff_cache() in diff-lib.c assigns the_index to
    src_index. But the plan is to get rid of the_index, so it should
    be 'istate' from here that gets assigned to src_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h      | 2 +-
 read-cache.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 4d014541ab..260e4ee44a 100644
--- a/cache.h
+++ b/cache.h
@@ -703,7 +703,7 @@ extern int unmerged_index(const struct index_state *);
  * provided, the space-separated list of files that differ will be appended
  * to it.
  */
-extern int index_has_changes(const struct index_state *istate,
+extern int index_has_changes(struct index_state *istate,
 			     struct tree *tree,
 			     struct strbuf *sb);
 
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..86134e56a6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2122,7 +2122,7 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-int index_has_changes(const struct index_state *istate,
+int index_has_changes(struct index_state *istate,
 		      struct tree *tree,
 		      struct strbuf *sb)
 {
-- 
2.19.0.rc0.337.ge906d732e7

