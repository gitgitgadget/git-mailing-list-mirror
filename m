Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB271F403
	for <e@80x24.org>; Wed,  6 Jun 2018 16:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbeFFQui (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 12:50:38 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33740 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933488AbeFFQug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 12:50:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so10197017lfy.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On6o8HUHOTTxiiS9KhMFX/PrBnZW6xB8vvPhBydwVB4=;
        b=tFyiSSY79YoNO7UMGUoQGNuIaK1DC3t2v7QVkEZeXgzx9PRlDt2TgEXfYYCZ+igrqo
         EhsoQkL64oOL0/uNpg5vmMmbQ2Yri026uDUoxpH0o6IC7UH7i7Q1JgxiQmx84OvEUAOL
         P9MzXknW6aer+xpZ9/K8zlTjrKCvb5AUf5Wkt9ONJi0Uw7cx5BG3GyQSb7VyuGq3a9LS
         zJaND8whe5gxlBs0/Z4WioiEFX99M25ABjaJOr2uRo4bjLaiQWqQUBXXX4vAfIjsfzgu
         wBimihkOr3a2OjX3xfWallWqIarw65jmd+A2dyg1p+lL08rdpbtiauyZZSkmtALXPP7F
         VXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On6o8HUHOTTxiiS9KhMFX/PrBnZW6xB8vvPhBydwVB4=;
        b=lI/ldBz6z4jVqFBlCXuN3Xcs4nmCyg/fDIVaVBgrsBE3D7DbUKk2mQaEWcuhnBy8gT
         gCHN7j6CnKuGmQaSzrPrennhpNBS8G+yGL0LrzXBVXCNSXK9NBPJnk5R97DhT4oO7hch
         +t5wBOPqxgA/+q69oSeeOGhkNsDqV0ntZYY/BPLXIiHT8kA7L4iMo7FqRX7UX3pCMiyM
         avT4Z2gIU+Jp5/UuPNsTUMOECiyw9CrYZHlNb98mPEuBL+sZvSgr8FLjk6Z1wzpPUu4Z
         tfAEXVnDk7xSDM1Ln7IXlIUS6NgT+gTPGYLi13ubmbSMW+iOmj5n5AVTPoeLJzKEt/gK
         11GQ==
X-Gm-Message-State: APt69E2RDPKE6IvcVE0idRaNgR8Wud9GCTdFDNKBsxFF2fg52lML5DUk
        OiKvOdy6lmlhlib1yQdDtrM=
X-Google-Smtp-Source: ADUXVKLntqOpO3i/J83alvtSkb+rz165KMtk/FHSMzmOLzIpkaK5YWYJIH1wDbetppKuDR3z3nq/dA==
X-Received: by 2002:a19:9886:: with SMTP id a128-v6mr2323719lfe.87.1528303834913;
        Wed, 06 Jun 2018 09:50:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y6-v6sm909489ljc.67.2018.06.06.09.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 09:50:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 02/23] unpack-trees: add a note about path invalidation
Date:   Wed,  6 Jun 2018 18:49:55 +0200
Message-Id: <20180606165016.3285-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606165016.3285-1-pclouds@gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com>
 <20180606165016.3285-1-pclouds@gmail.com>
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

