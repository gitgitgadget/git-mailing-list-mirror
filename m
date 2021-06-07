Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246ECC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D66611C0
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFGMhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:37:25 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34516 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFGMhX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:37:23 -0400
Received: by mail-wr1-f45.google.com with SMTP id q5so17437792wrm.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QTzuOgoXGKpn026RiRL8qt8jaloUIGodP1E75w97/mM=;
        b=O2KDXci/wgZz6XxyyQYq8BfbihKUyrZQnGjZFIKrMAkybko1mxLb36NWKnZDO6e64t
         mXCquc04OvOcqNwTBJJvgMsi+R0/3bjBOX3biJ92y+3S9CrW2eTzjha2ePGS7HXAbuwQ
         wZojLKw1VffQKnRga4/KBQtM6MME7RjanOg8dw7GJDKJwusR2UnhL6jzpiZ2jyyFfawU
         FRbBQjvIQTLt+8lzk2/x7zoZDOC03LPNAIvvW6A4W310c33wLxjMRwmuf+yxwh+Ru4Ul
         WNRRTRitrrWDDAUd9ITX+c79f1N2/91id2Wq1pdgZmMZVggaM2IZY60UPb9zCrSYOMfA
         OtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QTzuOgoXGKpn026RiRL8qt8jaloUIGodP1E75w97/mM=;
        b=cpym2lOYpUw7j58AoQnNzQmdigIMig8GKVJQj4QJZo3mDdtrRiqivzM5jZCRvmDRO2
         zXJuRCcaS6xWIMzM8gfb+0BhZ/koU3MUYE0/I/KrQRBuQXHQLj6LTSg+FB+cDONajG+C
         RMO5I5KGKZ1KkDber7pC3p5JRHwbzIldT4Fe/XxoDau++wEXuD0zwlGw3avAb5y+l3im
         Le6uoakJY0Ujbr2U2taznCG1RY3YVQ+8dnLqsTS5ZhyF8U1E+gJfZPKmx1OnXmxpYviP
         5GQ1rU1Id6gq1J+z0b4NzH3stxzvmYDBvJz094QGRXTy3zg+NG4+tupEV9I/DFdGc1RP
         faSQ==
X-Gm-Message-State: AOAM5322eQdKI3tT5KAR3+AB5tUDHEmH9lOFks+Id0IOv+wkkim2SEs1
        9PLUSSMbfWTf8V6NsiWTaiWQ24ZUAGE=
X-Google-Smtp-Source: ABdhPJzFY0K8dMTkAzYRZCWj8dfirSOQHC3JDBdLXMMn4v1AXN2lPm+o05xOk7FNE7JZPsLS3fmPNA==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr17530307wrs.361.1623069255596;
        Mon, 07 Jun 2021 05:34:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm15423394wra.60.2021.06.07.05.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:15 -0700 (PDT)
Message-Id: <8aa41e749471df3bd9d593b8f55db6506eafea12.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:00 +0000
Subject: [PATCH v5 02/14] sparse-index: include EXTENDED flag when expanding
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When creating a full index from a sparse one, we create cache entries
for every blob within a given sparse directory entry. These are
correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
correctly written to disk in the case that the index is not converted
back down to a sparse-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 1b49898d0cb7..b2b3fbd75050 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -222,7 +222,7 @@ static int add_path_to_index(const struct object_id *oid,
 	strbuf_addstr(base, path);
 
 	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
-	ce->ce_flags |= CE_SKIP_WORKTREE;
+	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
 	set_index_entry(istate, istate->cache_nr++, ce);
 
 	strbuf_setlen(base, len);
-- 
gitgitgadget

