Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 781821F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbdBCCy2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36260 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdBCCy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so1190232wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voUviMC2Sbh2gf5osechItDhOXzF/XiPA1r2Qjv3pcA=;
        b=e+hTrSjotaqtbE9t4YtUhgJdJm5o/CBrcyA8g7jUobEs3ACvrKshGS9AfU9nOMUYPk
         aVtSx2cS+V3VJ7+vv7xb6S7jYohhFBRSPZaR3bofSbAd2Kmqj6Vvj/g3fnq0shb20jhK
         ejfPsiXEMUy7KANZX9gd+Z9KgOiPuACCDcemkxq/pyOpUYOtsbyOF+iKpdEGPZ1m0FAH
         RF2OL5I84XKiafPQYToexO3kOVsmyojLpZ2ZILSpooMUfcKvkt0oRgIn3MLFBuZtSGAI
         xai2WmnbkbBniya4qhG/GlqHQttmuL1+tUavNULAPnisjiPbYH0LlDtiF4LQYSvTcLBA
         3qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voUviMC2Sbh2gf5osechItDhOXzF/XiPA1r2Qjv3pcA=;
        b=lEtaHM7ZI6CAXnW4VH4BJN0Aag2I7BoSTb7NOr/iITsE3w9h6EQNQstrrnAy+iSz9o
         F9wiYz/zNFpjv75a6coJnd43eoAj2A+rUWHb9ZvY50hpbPA44mMJswtgwdx9YYxNrFM9
         jl4vnAViBwR/XyCs6wxUvVYQLkq5wtcJ0Y1AwcUE8xVXtPuQN675RRPsDqzMbZJ6/Pfl
         L4AUOTShSR4Qt7zPSsp3pgn5j/gjjgzbGhOUSe4ZUvilTDED25e84JQb4Td7BuEF3SjN
         L7W68tcGWwnOEL0pUQzg71t88CHPh91e+CeZ5uvUkcMJ5q9iw2q/GX4FOkm+tsIaE2kE
         bN3w==
X-Gm-Message-State: AIkVDXK68aMSkjTY9rHZ8qkPNcFHZb+vsA1pMJevIPUULpcQ308UFIhCHtGavlTrAGT8Kg==
X-Received: by 10.223.170.195 with SMTP id i3mr11475935wrc.123.1486090465281;
        Thu, 02 Feb 2017 18:54:25 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:24 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/12] completion: remove redundant __gitcomp_nl() options from _git_commit()
Date:   Fri,  3 Feb 2017 03:53:54 +0100
Message-Id: <20170203025405.8242-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Those two options are specifying the default values that
__gitcomp_nl() would use anyway when invoked with no options at all.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ed06cb621..f20d4600c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1216,7 +1216,7 @@ _git_commit ()
 {
 	case "$prev" in
 	-c|-C)
-		__gitcomp_nl "$(__git_refs)" "" "${cur}"
+		__gitcomp_nl "$(__git_refs)"
 		return
 		;;
 	esac
-- 
2.11.0.555.g967c1bcb3

