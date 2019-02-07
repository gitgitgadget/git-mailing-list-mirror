Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9BA1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 18:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfBGSid (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 13:38:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34048 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGSid (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 13:38:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id z15so993298wrn.1
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 10:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwW0lein+9NUoth+RaLlDw21GD5TksUohccy0SetMFc=;
        b=M+7e0ZxNL5V4Da0whNUPK4v0EqacLhvhkZhZu3E6LkiBWVBVI0sal0TPp8W3nVei//
         zEGCHFAK5DChWbI0pU5Z020BQh7HaomoJHO6x56I9Q7O/re/JDdFtZw9GqsGQuM6mrhG
         /JsaHRAUa6XzRrWU0L8pm2Q5WGpL3yhsr2aYMgt4xWUqYEkew1BXm/cgrAUQJ4Ub7rd2
         CMD9R8vQqEUmehiDWyG60bPDA2iB7Kd4RpS/30fdw0h+YoY8EHFsFcVfAN9MGPfsyCbw
         gPHwDW6cjGj/Ty9eqvTLmpptTLzlKbl38WVh7WdmtCtF5OWWy9jkYIzYIUE2+1p1OpVN
         Sprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwW0lein+9NUoth+RaLlDw21GD5TksUohccy0SetMFc=;
        b=DtUoWouf1Zh45Pv5mU9uSaW0Abo8VpN74homd6i49NjR6//fqkf6RHyer15liSM8GK
         zUrdoa/jNUu9XKgHPrRkASjQ5bLJzSzJYsvPVJ9wT/3Dzy1Z4R+SdmX0YPS/nl5z+IcH
         1Kn7lfgdd8v+lQaJgOzzWICLXckHby+gwl629H/kwg5qvJSS4Vbn7ZjIjiBsmksZNKur
         eQPTMxdEYMKgeX1icD793JpypxPG8T7Vqo2MDVKjcs9jTrT6h7/u4fM0qn16i1BFtNAu
         t03P4C+2Mej7njn4glG4qgvCaqNOrrutYqDNeH28t3sHmYN1xart6mVTJlfxYc5E7m0b
         /TnQ==
X-Gm-Message-State: AHQUAuZcvSx1dKSG3P8l2RtmPb3bU1IM2NACsrFi2eD3OlL+TuvXLbiY
        JWRnSikEHvqMl8a3vHkSOyA=
X-Google-Smtp-Source: AHgI3IYwPuXDeHNOMd06fiuvvPjLWga4B2q9x/hUMVkE4hCIoLr0i8nePF32C9yETLimd4ZmEGJXOw==
X-Received: by 2002:adf:8121:: with SMTP id 30mr6878489wrm.51.1549564711311;
        Thu, 07 Feb 2019 10:38:31 -0800 (PST)
Received: from localhost.localdomain (x4db57a12.dyn.telefonica.de. [77.181.122.18])
        by smtp.gmail.com with ESMTPSA id c8sm22912466wrx.42.2019.02.07.10.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 10:38:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] ci: make sure we build Git parallel
Date:   Thu,  7 Feb 2019 19:37:36 +0100
Message-Id: <20190207183736.9299-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.940.g8404bb2d1a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 2c8921db2b (travis-ci: build with the right compiler,
2019-01-17) started to use MAKEFLAGS to specify which compiler to use
to build Git.  A bit later, and in a different topic branch commit
eaa62291ff (ci: inherit --jobs via MAKEFLAGS in run-build-and-tests,
2019-01-27) started to use MAKEFLAGS as well.  Unfortunately, there is
a semantic conflict between these two commits: both of them set
MAKEFLAGS, and since the line adding CC from 2c8921db2b comes later in
'ci/lib.sh', it overwrites the number of parallel jobs added in
eaa62291ff.

Consequently, since both commits have been merged all our CI jobs have
been building Git, building its documentation, and applying semantic
patches sequentially, making all build jobs a bit slower.  Running
the test suite is unaffected, because the number of test jobs comes
from GIT_PROVE_OPTS.

Append to MAKEFLAGS when setting the compiler to use, to ensure that
the number of parallel jobs to use is preserved.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 16f4ecbc67..cee51a4cc4 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -185,4 +185,4 @@ GIT_TEST_GETTEXT_POISON)
 	;;
 esac
 
-export MAKEFLAGS="CC=${CC:-cc}"
+export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
2.20.1.940.g8404bb2d1a

