Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A179201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 11:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbdKNLnl (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 06:43:41 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43128 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755135AbdKNLn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 06:43:28 -0500
Received: by mail-pf0-f195.google.com with SMTP id a84so9330628pfl.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pe4mLrE728bsB2FeIh61mwUOIWI1zrllikyzzD8ad2w=;
        b=sRtzO/SwCl9c8wErWSuP0R9gzZn66Gt7IpvMzscH5krU9qpGlEXFgBdskl4+FKfLwq
         eMLpHGwUEEnmxIwoL4JiSgdKpOWP6d+J5yWI+skIk4feGamdEaxBKYG6kymUPmF06C7w
         +lhb90mH/AlJOzN4OUdRDuBe+5MBZYxI43geLI5diJ7KfHFnV/jM0BxtGB3whZqrmPNg
         nLOMsUY9QmZg4fa3m/TItQIbIab7+GIgjzNY54xLt8/oBnBhlAcCfh5BHqfhlYg9yX5I
         t6aBxqUhb3b/LSGDXyKN1wnc8lUHSXAaDSnRqFep6EJKuBygbiZKA7VjgNXwxQ8rBbMk
         azcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pe4mLrE728bsB2FeIh61mwUOIWI1zrllikyzzD8ad2w=;
        b=uSBrmLw/rZYpLpp2FYwiDEdzf3KKjIsmlyqxJAoQCMbXXa0v/oMb4D9Y7ckAx3jvUH
         sqCKPQqKPT7K+XSkwU0whTG+Yye/PdEDYTDnWEfR6XqyZD0JnIc+n4rlgl7g2JqQY+hi
         AV1ZcsS93gsmMvwUxCdcsezigjkua2TNsNcegkhwxCBESeNiewRsA2fgnWpNUsR8EiJc
         yB9TYgjs44ecKL4+DME6m5J8hKulyrxIzfqZKFFxX1GhZIo6+eUJS5PdnX11r03eU78Q
         7aYPPphSB7lCt8gLR3126+Hv7uhADItYCm4mLf+TjxLfhYxKCdhmXGhIx6wHte5bGb+y
         NbwQ==
X-Gm-Message-State: AJaThX7OjVGD+5/z/nyDfVKQLA4ax+BPR5nsyZmTxGZdTMwsDdoqoPU9
        V/g2bW6DpqzTvsTlVGxoaVa3TB/pTlXdxw==
X-Google-Smtp-Source: AGs4zMaRao9XE5uCfRzdEiP532ITkD1ez16NzKbf3IDc0a+rkVWiuoMHvtZcGjx8iXjJ1vFs97sa5g==
X-Received: by 10.99.164.18 with SMTP id c18mr11776874pgf.167.1510659808208;
        Tue, 14 Nov 2017 03:43:28 -0800 (PST)
Received: from localhost.localdomain ([157.50.9.118])
        by smtp.gmail.com with ESMTPSA id m25sm38945584pfg.49.2017.11.14.03.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 03:43:27 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] builtin/branch: remove redundant check for HEAD
Date:   Tue, 14 Nov 2017 17:12:59 +0530
Message-Id: <20171114114259.8937-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
References: <20171013051132.3973-1-gitster@pobox.com>
 <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lower level code has been made to handle this case for the
sake of consistency. This has made this check redundant.

So, remove the redundant check.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 builtin/branch.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ffd39333a..5fc57cdc9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -793,9 +793,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
 
-		if (!strcmp(argv[0], "HEAD"))
-			die(_("it does not make sense to create 'HEAD' manually"));
-
 		if (!branch)
 			die(_("no such branch '%s'"), argv[0]);
 
-- 
2.15.0.rc2.397.geff0134c7.dirty

