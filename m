Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D69120195
	for <e@80x24.org>; Sat, 16 Jul 2016 05:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbcGPFGq (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 01:06:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33000 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcGPFGp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 01:06:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id f93so8092054lfi.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 22:06:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfUMCOPYIHju0JmzVmZ2Q1yhiBEPepC6Q6MW2+wdpJM=;
        b=B9MlM8hfMG6T9ZqyjVMOWj4m1ZumNA1oMKm/sEGoQteXsfii8B5wMGH521hSx+ajOG
         xIgu28mr/LE56MAORy15kRxll9aSp6WzgArybAXqcJDxwJJHIijPJ7ndrJ6RvTf2CmgF
         LmYueLALxf2wLjrjjAeiP+Wn2nRGFui8zFIXpcZDxm5PyNe4dZmFapNGhbsh/c0rBRoz
         eE18rSWY8DwZrKayM5S88jiyb6sVH/4WgNZz6U+L2qHAUX+22Ujz8Ppir3l/uA4uTba5
         RPOsd9xHxgXAtx2+BetavhJwXWe4IF40cXE351B8v4zenm448kLKSQBZwdSBnQpwJuex
         ibTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfUMCOPYIHju0JmzVmZ2Q1yhiBEPepC6Q6MW2+wdpJM=;
        b=Zc4YuLddoenQtfPohu67GuAhlx25PGJeJq70Y+V7XhKwyhmVECm69yrs2T4DTuwfCs
         zldar6qW37hj9dbLJgrZYIemwjVOa/uGHMJfd6blaZxded/ueLUGGd6rM6kOG/lfT/2g
         zJunSg/9yBXt9fFxB7/mKNB5cv/dN3FAyFMu07RKSub8BB6/I+k0k/13tYUTcFHLsHUz
         VXh1VQxlVva16NEMBvEIlsPWR68SZZhZb/lMKsAcmxLL2THjpG0ZP2nuHwmvvVC2dHo3
         hwOK/7RI1oX6JPO5pIYItqZpyV8a0c//5c5/F738+vMLuAVTb8/TRzvp4Vj8hK1QQ+FW
         zJzw==
X-Gm-Message-State: ALyK8tJzmJlCWL3oiWWkpbc28J2EHojMOGIqIqUT1kTsQcPLg26fvBKjOnJ3PSBL5gVAXA==
X-Received: by 10.46.9.71 with SMTP id 68mr11458039ljj.0.1468645603148;
        Fri, 15 Jul 2016 22:06:43 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g40sm634654ljg.22.2016.07.15.22.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jul 2016 22:06:42 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/4] cache-tree building fix in the presence of ita entries
Date:	Sat, 16 Jul 2016 07:06:23 +0200
Message-Id: <20160716050627.9416-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160709052356.30570-1-pclouds@gmail.com>
References: <20160709052356.30570-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

v4 removes the leading underscore from _EMPTY_BLOB and _EMPTY_TREE and
updates 4/4 slightly like this.

diff --git a/cache-tree.c b/cache-tree.c
index 2d50640..f28b1f4 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -325,6 +325,7 @@ static int update_one(struct cache_tree *it,
 		const unsigned char *sha1;
 		unsigned mode;
 		int expected_missing = 0;
+		int contains_ita = 0;
 
 		path = ce->name;
 		pathlen = ce_namelen(ce);
@@ -341,7 +342,8 @@ static int update_one(struct cache_tree *it,
 			i += sub->count;
 			sha1 = sub->cache_tree->sha1;
 			mode = S_IFDIR;
-			if (sub->cache_tree->entry_count < 0) {
+			contains_ita = sub->cache_tree->entry_count < 0;
+			if (contains_ita) {
 				to_invalidate = 1;
 				expected_missing = 1;
 			}
@@ -381,10 +383,9 @@ static int update_one(struct cache_tree *it,
 		}
 
 		/*
-		 * "sub" can be an empty tree if subentries are i-t-a.
+		 * "sub" can be an empty tree if all subentries are i-t-a.
 		 */
-		if (sub && sub->cache_tree->entry_count < 0 &&
-		    !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
+		if (contains_ita && !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
 			continue;
 
 		strbuf_grow(&buffer, entlen + 100);

Nguyễn Thái Ngọc Duy (4):
  test-lib.sh: introduce and use $EMPTY_TREE
  test-lib.sh: introduce and use $EMPTY_BLOB
  cache-tree.c: fix i-t-a entry skipping directory updates sometimes
  cache-tree: do not generate empty trees as a result of all i-t-a
    subentries

 cache-tree.c                         | 14 +++++++++++---
 t/t0000-basic.sh                     |  2 +-
 t/t1011-read-tree-sparse-checkout.sh |  8 ++++----
 t/t1100-commit-tree-options.sh       |  2 +-
 t/t1700-split-index.sh               | 24 ++++++++++++------------
 t/t2203-add-intent.sh                | 31 +++++++++++++++++++++++++++++++
 t/t3102-ls-tree-wildcards.sh         |  8 ++++----
 t/t4010-diff-pathspec.sh             |  2 --
 t/t4054-diff-bogus-tree.sh           | 10 ++++------
 t/t5504-fetch-receive-strict.sh      |  4 ++--
 t/t7011-skip-worktree-reading.sh     | 12 +++++-------
 t/t7012-skip-worktree-writing.sh     | 10 ++++------
 t/t7063-status-untracked-cache.sh    |  6 +++---
 t/t7508-status.sh                    |  2 +-
 t/test-lib.sh                        |  5 ++++-
 15 files changed, 87 insertions(+), 53 deletions(-)

-- 
2.9.1.566.gbd532d4

