Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0587B20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfDPJh3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44421 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDPJh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so10031800pll.11
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azgoSFZCwzgvXepH0ecGgtBNHsBW2kXjKepiOpIl6pE=;
        b=Arzd7hN8qokBxOXJBAk/PDEgFEvfs8GwF6yQcv/lws9yHxCtAJbRqwtp0wNLM9dVoB
         FEL26qwbF1lPKZpPe85Rf//OF/piEfCeR7p5yDs6W+N3RK9MvpA7jUB3deUgKryiXuoK
         rWa2daFiRBOGXjJ6g0aXAZgnUkoti0sbZmz2BHz/E+mnLgmrUXfduQecV+ylrK4E64nO
         80fRq3Sv1LPfVbAn/xNnwZczuvxqNMVTBbcXW6pGpdbAsF0+hoGBB6yrMLMceOqtLtEf
         08fPr2z8qog0ppxih3bUTAHPyCiNMWgluO3kz2vUfRVn0f6HNLyd/LDW6jmZTO2mA65O
         MZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azgoSFZCwzgvXepH0ecGgtBNHsBW2kXjKepiOpIl6pE=;
        b=XjlG494A2N09r3/MODss/55rxt2Xgj+VSKIqRTLgSmXg2nnJG18rMb1Q1+i7Jfay4h
         gU1d9q551Ce+MBD1Fmwrz+xetIySowpPm/at9HKj7H8yfJ1Y1LcEF8/wd9xdq98IqDM3
         sRe058N14FrETBS9H6H43HctEnUnQ5OUTLna5IrnuvwT47JZsRSWDOjsOciaTVMcHrPf
         +JZmKmdo40u9PGYshJyLEsQVMlIf2mcl4iwTmGdJVI1VzX4PnZKvmTMcOtqfW6v68hnJ
         5gcwAgxoUVVqSgho5tAy1sAI/1FxO6L0yWXVZ7Pywld/S0A4QcVX7+0xgbi2pZ3TXTlF
         wwBw==
X-Gm-Message-State: APjAAAWz57kXYdtALk5hnWy5iCn+K2jeqa24hR3pLF2vR3rkrpkLbEh/
        iLnVf3LanqpH6somMMDnklE=
X-Google-Smtp-Source: APXvYqy9Tqwd4zWSfpInJMsN+uHKODnvP8C6i5BdWa8jS3l0kAzlXRSU7AE8nT7Ig0IJH8fzRwUiGw==
X-Received: by 2002:a17:902:ab91:: with SMTP id f17mr16687134plr.151.1555407449010;
        Tue, 16 Apr 2019 02:37:29 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id z14sm77990160pfn.161.2019.04.16.02.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 29/34] sha1-name.c: remove the_repo from get_oid_with_context_1()
Date:   Tue, 16 Apr 2019 16:33:36 +0700
Message-Id: <20190416093341.17079-30-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6b53ea2eeb..64a50d1291 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "submodule.h"
 #include "midx.h"
 #include "commit-reach.h"
 
@@ -1797,7 +1798,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			oc->path = xstrdup(cp);
 
 		if (!repo->index->cache)
-			repo_read_index(the_repository);
+			repo_read_index(repo);
 		pos = index_name_pos(repo->index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
@@ -1842,6 +1843,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
+			/*
+			 * NEEDSWORK: Eventually get_tree_entry*() should
+			 * learn to take struct repository directly and we
+			 * would not need to inject submodule odb to the
+			 * in-core odb.
+			 */
+			if (repo != the_repository)
+				add_to_alternates_memory(repo->objects->odb->path);
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
 				ret = get_tree_entry_follow_symlinks(&tree_oid,
 					filename, oid, &oc->symlink_path,
-- 
2.21.0.682.g30d2204636

