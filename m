Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC09201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 18:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbdBVSqp (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 13:46:45 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35710 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755008AbdBVSqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 13:46:43 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so1463456wrb.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FPogeswIjeX/pJFZ0DmSBupOAXFpQOuwVvX8MCvDFzc=;
        b=pZlRRYuPIBcgjNR5PzAdCci2MxaAAuYHc6F1lVKy7i6HjJmGlHlwJrrfP4Cn+hl/W4
         s3/u/SyTSkOsyj4OWSorB+qEgY/E/zFAnV9Mhvv8qCG0nL4MBr3AFYhco3b9BGDzTeJO
         6Hzfegtlu352J8QIX1PSFmImc4osf2Yh/uRoEHkgQ+M+5DSI9E4V3WvsQalD+tvHnvDY
         SRk41IpARrpxuQzB87BSelpjn6qzaCQorj9EN+czfNPQ2UIF8M2Zi81mURE/CAjIfJRt
         FxcrneJ6VBYPKrT04QNypZILrJ8C+MwJhO4jkofuzI/CYqwE9O71hSEOT8rYBJFRN3vW
         JjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FPogeswIjeX/pJFZ0DmSBupOAXFpQOuwVvX8MCvDFzc=;
        b=gahbNOzg1dMVnw4onuDYRpIDCGxHvEHwzKBsubBVexsij7ZsgVI0aVDvsXarXRIhVv
         6dGMdwawUvYV6TAqlew2ac60B1hDI5hLUlOwVARdOGhjHbNOazUVVpNOw1Tuq5CUhJvM
         yHiybAICfdm4gs9wyyeBJZN+q/axrQW81OUAcgoXYEA7aKeEVfuNkMl1Vi4JWs+Y1jEU
         3MkviF39ivDsfu7VerI7+73Ek5VE4lTbBiETgeLt09Uu9Uo0BxcDZFK5XgJBxaUSK9Ht
         k5eN68ASI95OL1Vm/uWZSh8WRcXD0cFyDXG4tmgn+eanLN+KLvsQgYxSR1hkdCOJboO4
         0vUg==
X-Gm-Message-State: AMke39mH1Foyh1FMekBIQRJ9ptMmMwQq9jtBT4nGrXa2bbSM+4Dw2ejvQ1aM7Tgp5sDp5A==
X-Received: by 10.223.152.177 with SMTP id w46mr976702wrb.72.1487789193079;
        Wed, 22 Feb 2017 10:46:33 -0800 (PST)
Received: from localhost (cable-158-181-73-214.cust.telecolumbus.net. [158.181.73.214])
        by smtp.gmail.com with ESMTPSA id q4sm2768741wrc.35.2017.02.22.10.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 10:46:32 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] git add -i: replace \t with blanks in the help message
Date:   Wed, 22 Feb 2017 19:46:27 +0100
Message-Id: <20170222184627.3811-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.12.0.rc2.424.g63d3652c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Within the help message of 'git add -i', the 'diff' command uses one
tab character and blanks to create the space between the name and the
description while the others use blanks only.  So if the tab size is
not at 4 characters, this description will not be in range.
Replace the tab character with blanks.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index cf6fc926a..982593c89 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1678,7 +1678,7 @@ status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
 patch         - pick hunks and update selectively
-diff	      - view diff between HEAD and index
+diff          - view diff between HEAD and index
 add untracked - add contents of untracked files to the staged set of changes
 EOF
 }
-- 
2.12.0.rc2.424.g63d3652c7

