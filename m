Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7721F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfIQQf1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38374 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbfIQQf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id w10so1758740plq.5
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ftdu4Exttq/BU8KT+sAjKDJL7vcMTvRzU802jLa+JY=;
        b=GL9rJ/DkTVkps1KovdIQXvq22SRWBj2bR3999pULaPMH6F4900EWGJ5XkYvzLbt6Pa
         25Qwb4b6+nfPGLmXtJfjFTS323lFrSXtaj2VSQyVWpBRWCAP71O5QHIFd9MRJaNbXnxC
         kr0cPfghBRyR9VeZbsU5HkTPxM5Q81k8PVex479AuP8lct+2Bjw81VZc0MWldROj/VqO
         4QEawdtoFxTa/ecHqY9hUwYFE4LISGUjPtqilnB1HyuzTf9OABQZTD9malHmVRu9Ee8v
         TYCXPxB6TGwq/E6cSxn0WIYc6Ke5ZAQahREGCvkJxKxqRm5DC6fwan8ld0nymcj/i/Ne
         va0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ftdu4Exttq/BU8KT+sAjKDJL7vcMTvRzU802jLa+JY=;
        b=km/k0Q41VV5OmpeWvScynPUWDzBTzdtt+Z1InIt/Pqs1i9l/svWwchUMAkgi6XG3B+
         OBHixBttaqz/ghwtksrQY1wIX0SlY2NVkRF+CGKlixZQQYLhmUjc0zYpzgGpJWzOJVtF
         vZwJlDinhxmoTLd8p/LjjygHd+TLo57emg8HpB7gXCE/BQ3dD5MdbLuLZsNwsqHPuzmV
         lQh18vpsv0oD0yjBqeeYZkq6u9amQJeKZKq88AmLm7ERWUuVBy0u1dgQ4rPCgH0SEzFd
         22QbDcigecfahi0a39RQQNdu6S6sFwOhimWEVdDkohw+o9/+kzkXNDG2tv82nMWGpfBV
         LbSA==
X-Gm-Message-State: APjAAAXsmPoxJ9q396y3Dfb6OwE05bOi3wyAP/nEcqK/xAmHm4bkGOaT
        Za8z//+U3d4VtKRhhWYuuitBQDygErc=
X-Google-Smtp-Source: APXvYqwD/Y4pjbw2DMJY0MN2XDNunQftXS0Aq81sI5k42AlyYPx16OqpRa7WFV0f3ZJTnY55nV9dTQ==
X-Received: by 2002:a17:902:9a82:: with SMTP id w2mr563143plp.210.1568738126304;
        Tue, 17 Sep 2019 09:35:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 11/12] clean: rewrap overly long line
Date:   Tue, 17 Sep 2019 09:35:03 -0700
Message-Id: <20190917163504.14566-12-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
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
2.22.1.17.g6e632477f7.dirty

