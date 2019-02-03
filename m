Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA281F453
	for <e@80x24.org>; Sun,  3 Feb 2019 08:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfBCIhN (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 03:37:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43357 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfBCIhN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 03:37:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so8769518eds.10
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 00:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JU7VKWR46yjnvf6WYbQ04FVK7rWXGo4ifkW/mZcfXms=;
        b=m25EDGfUAEJW3rsjeTYaiqtUXN88RFcBxR/nR2Qwz94MYe7CbFv7j2Jehbt8TWyeGy
         sRRz8BMoqie74v0BiIwTqgQyiC+TS/GsiiSGiOTdF5ru87EJMQ4kuFY9WZ9hj7PrjeiH
         jAM17fsRwNY2S/NNlqHDPviB9Jm494dj/GCT6n8o4gS2tmCZIcS46u0GkvMEnYko24ni
         ymiKBy5VOriFJImWY/aZ1oDoGxTOrxc8u5pURKrFerl3PaDDr/GvcDfUG8hAnxpKDqKv
         zrkVFflKiP37d4Xdhv0KWrN5TmwRZX+96gjDoNahKohnTzjm+CZstOiHz/mEfwKS/Uxb
         zcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JU7VKWR46yjnvf6WYbQ04FVK7rWXGo4ifkW/mZcfXms=;
        b=FS8LOz44pbM1zPZQtGLXEGdyXS1TQn7nvzGbjnIyIAZBZoFIAi4xU8LpUQphvXtTDq
         Rj9WSWKwHyMGAAmtgF0K51FQAjg2gSgYefPhY36DLPw/5O97rr7WAKPA1Y24UbsCCoBt
         rSv0769YaiIYsHyVm9uOarnMjESYBCuQmpuD+xaOis3+0u2t7vex3aeqnjRcTpMO37SB
         fFUvaEcffSIDPRqAj7wpLrH0l7LhzB5iCdPpu8c/7IwYacNqFC9Ak/2JkrruoqQWHtuo
         ziF+klkx9sumi2JyR9LlptKeq6QIjT7a3k17lrn+kru9u+Prl4aIF1uwuJklLrlmRTXN
         1p8w==
X-Gm-Message-State: AJcUukfZ0rA3eVbvv44ZcxuRcHTNWTYpA05P/70ZJdjSg3rKQTr1c5CH
        GNX8tCVOH+tgUkQHaIz8T9lPEMo3
X-Google-Smtp-Source: ALg8bN5bpsHtK/B1dXoBevDHt8Rw/BIzabPAjGOsGzvkqj4M9BnY3dBt5G1tpWCQs1cRYQlUeG/spA==
X-Received: by 2002:a50:e3cb:: with SMTP id c11mr46644880edm.80.1549183031207;
        Sun, 03 Feb 2019 00:37:11 -0800 (PST)
Received: from localhost.localdomain (ptr-a4kws7i1d1ur5f2ahhk.18120a2.ip6.access.telenet.be. [2a02:1811:5184:9200:cd6e:e17a:5948:6508])
        by smtp.gmail.com with ESMTPSA id 49sm3398748edz.59.2019.02.03.00.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 00:37:10 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Subject: [PATCH] doc-diff: don't `cd_to_toplevel` before calling `usage`
Date:   Sun,  3 Feb 2019 09:35:45 +0100
Message-Id: <20190203083545.5877-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1.309.g16a465bc01
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`usage` tries to call $0, which might very well be "./doc-diff", so if
we `cd_to_toplevel` before calling `usage`, we'll end with an error to
the effect of "./doc-diff: not found" rather than a friendly `doc-diff
-h` output. Granted, all of these `usage` calls are in error paths, so
we're about to exit anyway, but the user experience of something like
`(cd Documentation && ./doc-diff)` could be a bit better than
"./doc-diff: not found".

This regressed in ad51743007 ("doc-diff: add --clean mode to remove
temporary working gunk", 2018-08-31) where we moved the call to
`cd_to_toplevel` to much earlier. Move it back to where it was, and
teach the "--clean" code to cd on its own. This way, we only cd once
we've verified the arguments.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/doc-diff | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index dfd9418778..f820febf8f 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -39,12 +39,11 @@ do
 	shift
 done
 
-cd_to_toplevel
-tmp=Documentation/tmp-doc-diff
-
 if test -n "$clean"
 then
 	test $# -eq 0 || usage
+	cd_to_toplevel
+	tmp=Documentation/tmp-doc-diff
 	git worktree remove --force "$tmp/worktree" 2>/dev/null
 	rm -rf "$tmp"
 	exit 0
@@ -66,6 +65,9 @@ to=$1; shift
 from_oid=$(git rev-parse --verify "$from") || exit 1
 to_oid=$(git rev-parse --verify "$to") || exit 1
 
+cd_to_toplevel
+tmp=Documentation/tmp-doc-diff
+
 if test -n "$force"
 then
 	rm -rf "$tmp"
-- 
2.20.1.309.g16a465bc01

