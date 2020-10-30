Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E9AC5517A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69B121534
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Pd5M6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgJ3Dmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgJ3Dmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906FCC0613E3
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:02 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h62so4441979oth.9
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=to/66f58ggxvN3D3hJjafigrplV2/UGbU/lYsScmKjM=;
        b=A0Pd5M6okvTNXywz7ougvLJbPBIuR2SCrrKA4XGm/TOZOiok6mYVuJvDM8dOB33Q7S
         XYwgGUJqVo4ZdpDayUh68NP8sf32SkY+l9gnWaK0W5A6XT/HXgcXpq3FJ2nscavczOdq
         COXKmd7o2AMNezqMaGihgWaASxrZRJzqLX6e6DTNVzAxJQLoHDZclfe2h/C/g/iS8snc
         Ln/RPybTBrrKuG7M0lxnQ+Rutm90iabU/PypKRZ1YIaFQo0FoxAOR2gzZLwDrttMurJD
         2nPx06DAGdVBsY49u+/k2w7ajeItyiYf3tCT5zF/i3wEtuYh2jHsQWqbeqrNOyAtAEFs
         aCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=to/66f58ggxvN3D3hJjafigrplV2/UGbU/lYsScmKjM=;
        b=m8Y6t+8CC0GuxGVOHo1rU/q356agqmsrM96O1m1F6VZak5K8QW1SoD75tOaS4gW0cr
         EoLtX4cT/xbtSObTLDWg9wMIBC+P268fGXLWOEw2WQ+WN1yAyqmizBCnR+4BUYG0Sv+B
         s+/rJbtp2Fcpjsl1lvGALcPK+xUOffNKgMOlzKBzL7/Uk8KcMUGQleGcdamKhFcJiLaZ
         0MJ1xYEWXxvnDw4y5xfFnNx2IOCdQLSkoQEYP9FFykYEONakejMhbuV8syLks5VVxKJ2
         byQd6hD4SeO6+VVtx7I9xSgWB8EFVukUffpeTlS/W7Kf6W7o/MDDqOuMWCjsu/3PhTQh
         TB6A==
X-Gm-Message-State: AOAM531uGt9wxkMkYss05QbyhGpy/l8tw2/aP1kUgDzlFffhQ1zUvLc4
        vwYaKtxcSZOy5dPaPqoDhdTilKdqf0n+Kw==
X-Google-Smtp-Source: ABdhPJz3hpfry77lY+PcvD9b0MLeR+LOfVaWKhqGzckWb4YMrwYtEo/uXxNqNY+ylNN9XRrPEFnbUw==
X-Received: by 2002:a9d:2182:: with SMTP id s2mr199273otb.328.1604029321810;
        Thu, 29 Oct 2020 20:42:01 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:42:01 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 18/20] tree: enable cmp_cache_name_compare() to be used elsewhere
Date:   Thu, 29 Oct 2020 20:41:29 -0700
Message-Id: <20201030034131.1479968-19-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tree.c | 2 +-
 tree.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tree.c b/tree.c
index e76517f6b1..a52479812c 100644
--- a/tree.c
+++ b/tree.c
@@ -144,7 +144,7 @@ int read_tree_recursive(struct repository *r,
 	return ret;
 }
 
-static int cmp_cache_name_compare(const void *a_, const void *b_)
+int cmp_cache_name_compare(const void *a_, const void *b_)
 {
 	const struct cache_entry *ce1, *ce2;
 
diff --git a/tree.h b/tree.h
index 9383745073..3eb0484cbf 100644
--- a/tree.h
+++ b/tree.h
@@ -28,6 +28,8 @@ void free_tree_buffer(struct tree *tree);
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const struct object_id *oid);
 
+int cmp_cache_name_compare(const void *a_, const void *b_);
+
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
 
-- 
2.29.1.56.ga287c268e6.dirty

