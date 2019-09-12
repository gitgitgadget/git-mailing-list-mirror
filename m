Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC39E1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfILWNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:13:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36830 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbfILWM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so12349192plr.3
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LfxFckBPQkXprzJ5h6GMMtsUVgAUfOpRwfjU0xaWCs=;
        b=ojZPOl9qf+MvLjuIZJZaZsD26Ki6Y+/dttDCwA6CGvgC1oxod7oXD3WStJPh88gMpP
         8ahlDkDKdc+3UUp/v8a5JCo8eVaFm3xPszYHJIcukul9JND2ls0HkQpguG5m5bwjxzTp
         lPupCv3GMip/Zd8k8SrC6OOnJxpGxzsWtRBjZWSK8VebHs240jeGxTF2F+BA02g5D4sN
         IWzhP2uUZIDhMK2Z4VFd3EBO7InE0AJQg2dKTwaZxq1DrXEW0tcMK9CiigyTja29Tmtp
         AdYzN13Cq0/VHzYqdnM/lPYRMOgePNuw+6u7AejLxPPfPBXCdrpjVukHeIEVrZWdxmfW
         i9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LfxFckBPQkXprzJ5h6GMMtsUVgAUfOpRwfjU0xaWCs=;
        b=OLIisPpfPnLZl/jeJ0s/2f52r2ZFluNa7tdXhrbyAh6QmSySit76yOqY5BHygE1xHE
         oA55qt7Ud3UE+SmxtFDab+IwazM6+/0OzB2hV6nglhVlXxKprlR87eqTcMvQdQQdSJ3t
         ZAiKYvMf8No93PInosY9Z+N+Mj3Cx/rrtI/8JxIFDMcM0McdYZ5zYCLQeoSsFuKwx/zO
         +mzg+WHMN6TG6ucu5z5YWUzMSJQ5O/l7+aTKvlCYpOTG59ppKMgMetM1Mk/5QU19dKVN
         wmX8IZ5Wsg6IMu7qtZw6EKywY1rb87jOJpraK0pl4bfMje2K+M16WI0zBjc81dZ0N8bN
         PZIQ==
X-Gm-Message-State: APjAAAXEm17vVQqueqVqf21DmlHoHT0Nn7O/iHNK7lGsfHl5f+7i1MTL
        lTdOy+c8efAeNLEu7HlAgjG7MxrLR6M=
X-Google-Smtp-Source: APXvYqzM2/Zf1FiA8La8hofgyKeYpU7ZTXLzNShqlf7pan+elemOXOT8N8FBsoY5ZKMPZhRWsn7q1g==
X-Received: by 2002:a17:902:8a97:: with SMTP id p23mr29755306plo.91.1568326378027;
        Thu, 12 Sep 2019 15:12:58 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:57 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 11/12] clean: rewrap overly long line
Date:   Thu, 12 Sep 2019 15:12:39 -0700
Message-Id: <20190912221240.18057-12-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3a7a63ae71..6030842f3a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -158,7 +158,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 	*dir_gone = 1;
 
-	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && is_nonbare_repository_dir(path)) {
+	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
+	    is_nonbare_repository_dir(path)) {
 		if (!quiet) {
 			quote_path_relative(path->buf, prefix, &quoted);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
-- 
2.23.0.173.gad11b3a635.dirty

