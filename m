Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF5D1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfBGUF7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:05:59 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45929 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGUF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:05:59 -0500
Received: by mail-pf1-f201.google.com with SMTP id 74so708220pfk.12
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 12:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=peuxNE8YzMQpfH2GQlN7VaP+Z78JSfllS3h/CqLO//U=;
        b=P4A3boDdHiKZXHBgZ58hjPteQ7dYRIQcC9cVM8YMGtccQDx0DZo41ALvZPEAonweMW
         Hes3M0iNxMuEwhagD4j6h88poHW37cMuW5u7BgHQGlZmKvhoXHoUIcIpS97+wPD8iJRi
         mZxwB5oyAjq05N2wf1qusfwerleq8b2FYgNHgn3jLhOnKZ4g2adCvOSoQkgE2goBBluO
         7rkoRLNtdquCugdXOWoaW6pUNeKMlGrYSkcv6wTXQtHqwhIpU5xOZ5ZxdLhG0EdI4Fkv
         8A6zjKe3WWOYGqF+sL0O8Gdv9ERo8EGHMn/LmY4gqpL89yYoPKbTQzq9yRFG56Nc7ExB
         vcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=peuxNE8YzMQpfH2GQlN7VaP+Z78JSfllS3h/CqLO//U=;
        b=sSSDwrtgm/JIID3yOVxxBzH009e1KkjMYdkDS5q1DVHu/4FqVf4ydWVxxBc3BxHxsj
         WSrm5m48IrdFEwfgqh3cbFwPF06l8BplAO7zz2rP5fUnzKCNljnakYplV6zGy12CPPab
         tUZwVnXxYT7Oi0WFrxs/5SHnte4i4X7SPP6jEZ1voWmlbKfSogD33OmzJKmckgW1OBQ8
         jx1SXJhRmQ5aKVtTne5RGOc7eMqUglLdlzs0x8dAP0DObDlQ6S1WBk7wokWGdEQwkhBI
         3vTjCqaSucV0JjgXGBgztGxbzxTj33epvUQeKSa/C3Ps/c5xYz6qFh19DgTU65kRiJSh
         BYlg==
X-Gm-Message-State: AHQUAuZJC0wGAX33WlU3kMDYZNP5BDKtusbrD9lhf9InZAy4cIVeqj+/
        2wXVb81rINs9DAZ9NSl4R5Q6tZ4c3q8KcxjPWUFMGXuFa+9ljOJroWgakAWMDPMbvb+lnnoi13Y
        PeVJCuDjVl1nptmhQCVpTBNAuDZRrPAgaC2MN9zyAhNmUzdq6qV4nzwyaymgfwjU=
X-Google-Smtp-Source: AHgI3IaDUYcR+vc8EWCDwC7gLxSsQ1zNfwQdRz58zRr9nXIf60mQdUhr/tS+OA4wPBkdX8huVQoOF4g7Pl709Q==
X-Received: by 2002:a65:5b0d:: with SMTP id y13mr6568279pgq.3.1549569958518;
 Thu, 07 Feb 2019 12:05:58 -0800 (PST)
Date:   Thu,  7 Feb 2019 12:05:53 -0800
In-Reply-To: <cover.1549569479.git.steadmon@google.com>
Message-Id: <2dc66703537cfdbd6eb08ac4a7341c0f278621a1.1549569479.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1549569479.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH 1/2] fuzz-commit-graph: initialize repo object
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various #DEFINE "constants" in commit-graph.c now depend on
the_hash_algo->rawsz, but this object must be initialized before it can
be used.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 fuzz-commit-graph.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
index cf790c9d04..0157acbf2e 100644
--- a/fuzz-commit-graph.c
+++ b/fuzz-commit-graph.c
@@ -1,4 +1,5 @@
 #include "commit-graph.h"
+#include "repository.h"
 
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
@@ -9,7 +10,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
 	struct commit_graph *g;
 
+	initialize_the_repository();
 	g = parse_commit_graph((void *)data, -1, size);
+	repo_clear(the_repository);
 	free(g);
 
 	return 0;
-- 
2.20.1.611.gfbb209baf1-goog

