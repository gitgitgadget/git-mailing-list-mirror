Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8531F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeFGFH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:07:56 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45891 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeFGFH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:07:56 -0400
Received: by mail-oi0-f68.google.com with SMTP id b130-v6so7406403oif.12
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k8FStSTpoVlHWBPmwK8K+R521XNUQliuA7SKgd0XOiI=;
        b=Gq4HFnYsnh7GqvzUx76exgn6oPWJREHC1NGixZDZ/YyBCoKY5roKxnJ2bayGbQLlRM
         wbvdXg/ELqn5kb5PzZ0ebUfzTUlQvtgetSbceb+y0socOFT6nlAR9yUUo0IuZ2Ob0mvi
         nQBlTi5uAphqFX4tYKDRrNJG+YxMDRI48Hq0cxWOc4ufisQ3RiJ7b6rEZ76lfhZNdbAg
         CCoZZR47Q2qAENnn8L6BDU4fEUk0TkO//hZyyhLaYp9vgv1bX03mz2CJRaHSoVeeqCgD
         33zzNqYEaljA+7GwPwKtwkvHwGu1jTRidN9wfDDTLGhvB4nm2JZeup9rHx/+ocgbE8Ln
         r5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k8FStSTpoVlHWBPmwK8K+R521XNUQliuA7SKgd0XOiI=;
        b=ak3dhWZdZTYlRpry3gGYg2HXlCRzg/B3DLrKd70i3IqUyknO2AvZghVYaJdEmRC+Mv
         EfnRNApVT0l8dL+sAQdhsYmB5ZWcJP+oKyxNyB4FrECkdIoYI/FIekWhkKr9wXse01ac
         R3Z5F2eiVL+NlPf9o8AGXR/arNOalpLMr9Sfhk5FokzGEf5gr4lUfuaOy9yyaWXUo717
         Bvt67HDnW+lTuGGRTv7s87Jj00C/XmFa4YKrUte81ggEx89UWPjky6sp9oBurBv32PKQ
         dEQ9knqBFeEiDjRJJDxIYRx4fNs6NpJolk5J6n/OPOU1OLa6FtGu3DMNaF1sLCAk5aFe
         qBIg==
X-Gm-Message-State: APt69E3gjfaTwHoOMOa4cEVQIyXe7GlHimklGrTPGAdbY0rW3O6rQx6M
        QFqcMjC29tFpY1jf7qTKg2iLYA==
X-Google-Smtp-Source: ADUXVKLLVaxMQExbnYkkBEIVTvVKG1GV18jGwxYn1PBkp2CfOCIxIbRi+P4Wsz9E5+UVvcGg+2jVuQ==
X-Received: by 2002:aca:4046:: with SMTP id n67-v6mr142361oia.205.1528348075231;
        Wed, 06 Jun 2018 22:07:55 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id 64-v6sm4158258ots.36.2018.06.06.22.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:07:54 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] git-rebase.sh: handle keep-empty like all other options
Date:   Wed,  6 Jun 2018 22:07:47 -0700
Message-Id: <20180607050747.19726-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 40be59ecc4..a56b286372 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -276,6 +276,7 @@ do
 		;;
 	--keep-empty)
 		keep_empty=yes
+		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
 	--allow-empty-message)
 		allow_empty_message=--allow-empty-message
@@ -480,11 +481,6 @@ then
 	test -z "$interactive_rebase" && interactive_rebase=implied
 fi
 
-if test -n "$keep_empty"
-then
-	test -z "$interactive_rebase" && interactive_rebase=implied
-fi
-
 if test -n "$interactive_rebase"
 then
 	type=interactive
-- 
2.18.0.rc0.46.g9cee8fce43

