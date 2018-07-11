Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9331F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbeGKNBN (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 09:01:13 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:39348 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeGKNBN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 09:01:13 -0400
Received: by mail-ed1-f47.google.com with SMTP id w14-v6so19144419eds.6
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRtHbTDV1Skh+7fq7VMYrbFTEzRLzWZhyI/PKUoMX8M=;
        b=ni2V6N44v0tATiYP5mSUtYmp65cdFBSpuuZerJztad6VwVbijOrKBqjxmVWGlRM4t7
         ZDLRTEMjfyAKfZO79P1qoOMGbK/lZoQdPjqbHwarzcU1xB5JV1Qf7x54xXdzB64Tpkgg
         s98X8i3woezhWklE/CyB6qKHVdFCJ6qpH/jSf5WzSPqbs6THOYaoJen/u635Alg8t0fE
         EX7GAA7/lkJz5RwQhSR8Waul0aMyb9sAx2X5B+knDEkClJ4ci/nT/dueyC39/yPn6zob
         hk9Rsz7Fx7h0mt3cZr94JbwiXZGDejHOP9ZlFjQzwl2K0lNOC0tuFaB552PzAv/fMEYc
         haQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRtHbTDV1Skh+7fq7VMYrbFTEzRLzWZhyI/PKUoMX8M=;
        b=EbL3nzhs4sshBK35eLdVFGPN5iENseLw5YQ8N7Z4KNe1F8t3qN/Gbl2Z/mFJE+HDrD
         tpboGQZYG5dTBzIp7RaaQti65bOhqXEzWQ45vpfE3pQFq/zCcRkeDwuS/bN9mO5dptPb
         RWGJaG5ZpopqvPZi+4OgWunqGfI5+b65ysd+5EnQDZjba9PeSO+vkjKg7YA+dJoxtD4C
         oRKIKqOgLH8Bw+9lb4mgrQIbGk4nDoJMxpoEj3qCDzJShd1xgDYoaXmFiTAJl3CjHXDD
         f03p95AJh80TkgL2mMtnDYIUdoGpSJW36ClJsnAQJXvnCIYGXMlDWcLkQzkVcBTELHv5
         +VYg==
X-Gm-Message-State: APt69E1N7CTekxH53UEtRi2W7ktGKZJ6lozMHwVaGNFrAlgSdXBSvqDu
        YJK9CDwJu4jAZa1Gs4tREaE=
X-Google-Smtp-Source: AAOMgpeUfnN2508ZwxH7PzDoW4bYVUy+8ZudxJpj+BxXmSzz2WM0cONpeTgf/6aBsPTcFtuUfdtigw==
X-Received: by 2002:a50:aa43:: with SMTP id p3-v6mr25852949edc.233.1531313819157;
        Wed, 11 Jul 2018 05:56:59 -0700 (PDT)
Received: from localhost.localdomain (x4db1cc71.dyn.telefonica.de. [77.177.204.113])
        by smtp.gmail.com with ESMTPSA id h1-v6sm768050edr.86.2018.07.11.05.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 05:56:58 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/3] t5541: avoid empty line when truncating access log
Date:   Wed, 11 Jul 2018 14:56:45 +0200
Message-Id: <20180711125647.16512-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180711125647.16512-1-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180711125647.16512-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second test of 't5541-http-push-smart.sh', 'no empty path
components' truncates Apache's access log by running

  echo >.../access.log

which doesn't leave an empty file behind, like a proper truncation
would, but a file with a lone newline in it.  Consequently, a later
test checking the log's contents must consider this improper
truncation and include an empty line in the expected content.

There is no need for that newline at all, so drop the 'echo' from the
truncation and adjust the expected content accordingly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5541-http-push-smart.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index a2af693068..d623cbad97 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -54,7 +54,7 @@ test_expect_success 'no empty path components' '
 	# service" test which reads the log too.
 	#
 	# We do this before the actual comparison to ensure the log is cleared.
-	echo > "$HTTPD_ROOT_PATH"/access.log &&
+	>"$HTTPD_ROOT_PATH"/access.log &&
 
 	test_cmp exp act
 '
@@ -124,7 +124,6 @@ test_expect_success 'rejected update prints status' '
 rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
 cat >exp <<EOF
-
 GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-- 
2.18.0.273.g57f1ecce9c

