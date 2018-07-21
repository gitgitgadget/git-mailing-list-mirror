Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22A21F597
	for <e@80x24.org>; Sat, 21 Jul 2018 06:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeGUH0M (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 03:26:12 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43469 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeGUH0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 03:26:12 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so5457285ybl.10
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 23:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FJsY5gWHs86k2XtaykqMqcTKM0H1xHTdMvKm3xZDNcI=;
        b=FDvOn+PCgH8siR0+fByrKluGpNw/lOkvtftjbVEC9Cx3dQ/LQlXP5IDOg9qnJX682+
         VczGAkXHkshsVCaKE4zlVe6U4XclGdMrTw0UVwqTJKwuU10Hxs5gUehGFIYmhvQKuQRQ
         cCYWAqAi1m9fbSertSEq4RynALBJBeZgjoJRDc5mOsaHoX+qhujuJqsEsXwAQ0wvfCMX
         kQy6ovTh+9VN2TPxmkoyrAWGw93b9XiJ1EaKTrZVgMPFatj5ozLg16FRVZD88FaK6ywU
         HySvOnbQ9YgmzRlI8x19ynatKn5SmEZO9h+1mhlF4jvg8FAhN8n6IDeB3xH77vmPXEHX
         rIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FJsY5gWHs86k2XtaykqMqcTKM0H1xHTdMvKm3xZDNcI=;
        b=Hg7xPlLrY9kvFNtEHoOkJogl/6VnWse4LEz0BcHYkjYK+rfbKiKJwSeiLJFJVD3mTv
         +xNH1ViY0Ft54HzSZIoCTPpIJiqL1+zVJOky8dzkvxRQ4bxA9YPNs5Xt+pQqpbLFVRr7
         L5NUSPJ4luRfcrFm7vrroyCVfbs0qnoDCcuQFN3AwNku4ar/xEnv5+AtKuJXJWlyBaJr
         5Dd2sZJzbcztgqWNqiQ8MP1zOxqxdQH4U7NtTpXaqcUpmk6+tFPzTvnL3gOEWR5l5Qdl
         kagzA8G3uDrIjcVO3bT7KjnlJRsfM/vJS1d2en+NK28FnI0Aohq9Zn+CuDiGXSAP4kYf
         QnPA==
X-Gm-Message-State: AOUpUlHXFSQGyjuwOKGyVcn+lxQcuUedRLMkOWxeCmeCquATd7TGB5db
        13dXXwQ8Bwie0qHoHhUGlTVgzE5G
X-Google-Smtp-Source: AAOMgpc/gJSjIGFUnZpCsjge+v2nOprIjAkyA/1Jl9kOObOFHFPQCAcqulzu7T2Ay3anJHbNKXLD9A==
X-Received: by 2002:a25:5806:: with SMTP id m6-v6mr1413024ybb.469.1532154878102;
        Fri, 20 Jul 2018 23:34:38 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id w199-v6sm1739509ywd.104.2018.07.20.23.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 23:34:37 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, kewillf@microsoft.com,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] t3507: add a testcase showing failure with sparse checkout
Date:   Fri, 20 Jul 2018 23:34:27 -0700
Message-Id: <20180721063428.20518-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.234.g2d1e6cefb
In-Reply-To: <20180721063428.20518-1-newren@gmail.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180721063428.20518-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <peartben@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Testcase provided by Ben, so committing with him as the author.  Just need
a sign off from him.

 t/t3507-cherry-pick-conflict.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 7c5ad0862..25fac490d 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -392,4 +392,17 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'failed cherry-pick with sparse-checkout' '
+       pristine_detach initial &&
+       git config core.sparseCheckout true &&
+       echo /unrelated >.git/info/sparse-checkout &&
+       git read-tree --reset -u HEAD &&
+       test_must_fail git cherry-pick -Xours picked>actual &&
+       test_i18ngrep ! "Changes not staged for commit:" actual &&
+       echo "/*" >.git/info/sparse-checkout &&
+       git read-tree --reset -u HEAD &&
+       git config core.sparseCheckout false &&
+       rm .git/info/sparse-checkout
+'
+
 test_done
-- 
2.18.0.234.g2d1e6cefb

