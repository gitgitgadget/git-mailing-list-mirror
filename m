Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C591F403
	for <e@80x24.org>; Wed,  6 Jun 2018 05:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeFFFCa (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 01:02:30 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43388 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeFFFC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 01:02:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id n15-v6so7010893lfn.10
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 22:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On6o8HUHOTTxiiS9KhMFX/PrBnZW6xB8vvPhBydwVB4=;
        b=KlOq/phtDBly9OuoayhAyv1XgyiIV8mH+G8ddYKN2OmHToedOy9EcI+AedqpzoJZZC
         KvYb3jyuixjLGgaFJ/JBizqi7t0nx8QEZ+t39k3yXvrBk4jT2dJru1vj3gW8aUzodidG
         JiZxxo6VbJc1ZN932k08UVhhc18U/zp4fKBWCHOzyTJkjvO7wqT+rhIvTIM8rsBzXkkB
         Er99xWdhtQ/y1sjj2Yy39njplG5Ff77W1Rx88hnp2OeyFuc0F9fe/t78Dcrsiy+YXZ3l
         kXsZyVV3CtTpxDrjGW2emQzFEJerQYbQkt5Ei3LRpkdHuVru0N5qeF6ReTaiahNi+dWz
         GygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On6o8HUHOTTxiiS9KhMFX/PrBnZW6xB8vvPhBydwVB4=;
        b=lE1Z2zO1gDYhXuDwTG8Wd+HOl1qLnwv4RqP7EwVrJrUXvxnUHha+wDkse3jW4UzgIy
         FrA0GPsHH2Ok5qECh0b+oDdEIGV0JTTQMvhXxGK9Ri1blnD6Pi1vy+phGs9gP75U4UEJ
         WL3GeV2BfA8pNsi/IZYQnjqu/ln9rkjIirMMQxHlSriZHJNCkMUa1QoZK+thJEDrkVz9
         YVD8z0ncwU3gWY+nnKgVmmQFtTqq9U5xdygpXoA2HwqXTMEGWB/d1YIpstHOLWUvqxOB
         kuZ42xUSPOY+GhIDdodt/cgAhtMUc3pi77clzfpp1YcM8foDi4kYJc0J3HMxOR0L8MV6
         Hejg==
X-Gm-Message-State: APt69E218B8GgvH6OGeXrpPkwvaKa88gbdMMEmhzpqowtanjvKx3cawK
        r17yhxmLQnzV8bUUxwMC420=
X-Google-Smtp-Source: ADUXVKIpAlYiLNps3U2bUxxtURNf8womEULqNp0u1zUkAgIWp0lT5aXgDTNm7KW4DOosVI30zSacwQ==
X-Received: by 2002:a19:e9d3:: with SMTP id j80-v6mr821201lfk.129.1528261345618;
        Tue, 05 Jun 2018 22:02:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4125798lji.4.2018.06.05.22.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 22:02:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 2/5] unpack-trees: add a note about path invalidation
Date:   Wed,  6 Jun 2018 07:02:04 +0200
Message-Id: <20180606050207.13556-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606050207.13556-1-pclouds@gmail.com>
References: <20180605154334.22613-1-pclouds@gmail.com>
 <20180606050207.13556-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02a77..5d06aa9c98 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1545,6 +1545,17 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
 }
 
+/*
+ * TODO: We should actually invalidate o->result, not src_index [1].
+ * But since cache tree and untracked cache both are not copied to
+ * o->result until unpacking is complete, we invalidate them on
+ * src_index instead with the assumption that they will be copied to
+ * dst_index at the end.
+ *
+ * [1] src_index->cache_tree is also used in unpack_callback() so if
+ * we invalidate o->result, we need to update it to use
+ * o->result.cache_tree as well.
+ */
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
-- 
2.18.0.rc0.333.g22e6ee6cdf

