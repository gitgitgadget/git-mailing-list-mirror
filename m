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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE78C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387E9611C0
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFGMhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:37:12 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:42596 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFGMhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:37:09 -0400
Received: by mail-wm1-f41.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso1821310wms.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wFfpok35DynSJzLw2iHIzdshoI7yibKc8zfxCLq0Mn8=;
        b=c2E6qwF0Mtz3Ow363vUpgOZzTlsJJKP160gjU697heeeEFyZlByQ/SxTj6+iiw8/LO
         jUE+P/O4hoQYeONSwV2XRVNRM1jILt8BTfbt7NdFxJ51tfmkUZ44xTmWIiPIK6YQup3D
         xqHga8FchcUC771UvyVMsdc/K/RybXcfaf6ac/8g8kjsGdp4rEpnVElUKic5MtdPaNP2
         FyztqwMDONEBD6V01RNvAsp7uKsv37FhAMeDqZBbUGQe8VNXw5cV9N3KpR5vXq0wY/TE
         RD8nBS4NQVmKhIJTtkJ5RgpROsupV4eyZjmKr+UWhzzEp7n9P3BUoFUMMbWNdcLViNkN
         R95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wFfpok35DynSJzLw2iHIzdshoI7yibKc8zfxCLq0Mn8=;
        b=YtA6uDY7vIw7mJCcxra71Jo6nFAZLPbkCI0bgyKgmQgdhFA/vJmcgfQdzt/MebIuLq
         ImttB9gvnQBLc48vu15FOSVuoDyYqaTHCY2WVpOjBivUmBYfTAm+QlzgGtxXGk8a/cER
         MnqJ3O93MoeUCV4HrvdYQSpMW/NxmWVNETQxBgW6IBx9P3T5E76t5QLKwZ51iov2KrwT
         VNB7X/WwsHaKAmtt7bDxrftwI4o1PGrnPShjIOCapmG8jfOUevpFlREMCFjLWLY2bHN3
         WjMlFVFMfpZ1TNGXc+2Qba4y52zxMrJaqWsPuDZ4rEY939azv7AJs+2eQCuyZH/t6fjs
         YJ3Q==
X-Gm-Message-State: AOAM533cpkQ9NWo4onPkAwVqwFjwVQhWLVA+zMY8Y9PMscDU0xrU7vBd
        n8VSMzviEoIEKjOgk5ADjRcJK3f+CZc=
X-Google-Smtp-Source: ABdhPJxg14GR2Q01t53Eh0eZv3jeg9Zcg5MkzQeIeaA8LMY9UQUoTuqC983o/IAeRAsqQ+p+DmsCJQ==
X-Received: by 2002:a05:600c:4f90:: with SMTP id n16mr16644166wmq.139.1623069257772;
        Mon, 07 Jun 2021 05:34:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm13292661wrp.3.2021.06.07.05.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:17 -0700 (PDT)
Message-Id: <f3f6223e955f48ea9f7d6bf70a5a230682744285.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:04 +0000
Subject: [PATCH v5 06/14] unpack-trees: preserve cache_bottom
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

The cache_bottom member of 'struct unpack_trees_options' is used to
track the range of index entries corresponding to a node of the cache
tree. While recursing with traverse_by_cache_tree(), this value is
preserved on the call stack using a local and then restored as that
method returns.

The mark_ce_used() method normally modifies the cache_bottom member when
it refers to the marked cache entry. However, sparse directory entries
are stored as nodes in the cache-tree data structure as of 2de37c53
(cache-tree: integrate with sparse directory entries, 2021-03-30). Thus,
the cache_bottom will be modified as the cache-tree walk advances. Do
not update it as well within mark_ce_used().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index dddf106d5bd4..1067db19c9d2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -586,6 +586,13 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	ce->ce_flags |= CE_UNPACKED;
 
+	/*
+	 * If this is a sparse directory, don't advance cache_bottom.
+	 * That will be advanced later using the cache-tree data.
+	 */
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		return;
+
 	if (o->cache_bottom < o->src_index->cache_nr &&
 	    o->src_index->cache[o->cache_bottom] == ce) {
 		int bottom = o->cache_bottom;
-- 
gitgitgadget

