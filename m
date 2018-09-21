Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5BD51F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbeIUVrW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39183 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389804AbeIUVrW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id v77-v6so11877699lfa.6
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+QhZbZt9w45UpZPze7biwtQnB6PjzcTcm362WzJp6I=;
        b=vcNBw7pKIu7GXTw03coXEcG57ZTxAWHBxHXJGMy/++elQ+hvPhAK139dZZL0mZASQ/
         JAZB9wn+xsXD6Px6QXWFAVVZf7ZHuGQXois3i3202vdJf95dWoIm9w++5OPaTTersZt0
         uiARnzsKFSXsKZnaPFgPryvpBcxKDOO7zn4PgOC/CdWwcpYuWx1R9zVwkUYLHWG6OIrZ
         r+dWuZCANMMTaTnyuz+EsFXmPf65FPo73j1OL8u6MfHLyrvZg3gK21q1KUZrMmdn2TdN
         X76Ro6UVhEca529HojTkhgYqj0Ew4nW13y/ZlkSOX5913q2fn7ZM3/xC7bneP6ggQOG+
         5qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+QhZbZt9w45UpZPze7biwtQnB6PjzcTcm362WzJp6I=;
        b=RSLyfyazc5sQTz9ZNxGI5XLeLKtaEQJoAvcseOYks0QzCFfdKH8cnlQs12Vq+kIEW+
         GYTChk1MSm49LegMk+QdCJhzAB9IYN++GbpquzleF60iZ4QYBrlOEwhBEVWksb3FvkSA
         vbZsfMJt3V6Zuum8sH4fyJ/ekfmcyE8Cu8+0Qx3WYaSndIYg9U5Djt0nkmHPDVJwznj5
         8IpKw2TVpZWDFB+RYQH5yUsfPbPHdmKEy3ue1FtcLxfF/nDyl6LEB3vDp40nfL8ZMp/y
         dw+v/QXEuxyg9hxKYGpxckmMfmkPt6iMh3RAqqwoP7yFZG0ga1odDKn7rk8Ijn7+vpkx
         srEw==
X-Gm-Message-State: APzg51ALjNLw0RIxRt79FI/5/s4VzydSy513YnUfQUpWcyiObNGV/YuZ
        AXoSnU8Sz/YApX2MXw1lhHc=
X-Google-Smtp-Source: ANB0Vda9m/o0CJu4MboNAhU4z8ud9RHk329eGSuipLeMbuKpCra9uIak6pb1/HQ2GClRqgBID1rKYg==
X-Received: by 2002:a19:e21b:: with SMTP id z27-v6mr31849850lfg.68.1537545470450;
        Fri, 21 Sep 2018 08:57:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 02/23] read-cache.c: remove 'const' from index_has_changes()
Date:   Fri, 21 Sep 2018 17:57:18 +0200
Message-Id: <20180921155739.14407-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function calls do_diff_cache() which eventually needs to set this
"istate" to unpack_options->src_index [1]. This is an unfortunate fact
that unpack_trees() _will_ update [2] src_index so we can't really pass a
const index_state there. Just remove 'const'.

[1] Right now diff_cache() in diff-lib.c assigns the_index to
    src_index. But the plan is to get rid of the_index, so it should
    be 'istate' from here that gets assigned to src_index.

[2] Some transient bits in the source index are touched. Optional
    extensions can also be removed. But other than that the source
    tree should still be valid.

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
2.19.0.640.gcd3aa10a8a

