Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B6D1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKOBAt (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36408 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOBAs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so3491798pls.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmBA5qhU9xB8o/2qxmmi2wCwnOm4tPyVjPYijs7BZYA=;
        b=SO/CqysZXTUSQYjoe0KWz2u4AHCtelYPy6MgzrL8ZL3ImSo6UXF/Y/xD49G8M3tffc
         nKUXfbKydgxpAJqMBmKWylNi0TO783iYqZTW5ntA7mbWPNpB32p8JxpakwqOOAF0utU6
         gR8mNvNHLE6FrhNQySWkefKH/CXQvCPTbqqGcohAOhHvWAmP0PBmbzh5zORrp2G6jrRz
         g5npYVYaWTxA5aAOluLCNn7cDCwrr1EtwxpbXdpvbjaP1vbN5JvTZ7TG+N80lWwfre+/
         UPZA7YGNgLlu47UVqfqlSU5ayGdzIu++Sq5D30kMDZ21GjIBzCKrrpHOhZ3Axb3ZXVOg
         tZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmBA5qhU9xB8o/2qxmmi2wCwnOm4tPyVjPYijs7BZYA=;
        b=fR577LiMgizUWPLeIm5eCYpDNPgDSuVaEdXvTM96j8WES+yS1IJvovfrYplMR1BqiN
         rfWlbjLDE1toW3uKfA0cUO5dlpVkZl8/rYm3EEYySA+COWLz5ZayDDOEOKTRBjZCAQTx
         yRUGpqfJyJfFmGkMnG4V0CTdvD1pJFH/VpuqkBo+Js/ZeQrkXgSgSVhHP4+AZT9P/AYS
         ZXAyUmLs8BXjGJ69tBsz7391sg+6nvmhzc4IMFfCqfRAiy7MOjP0mPA2/9Llhh8WGyof
         LbBWwyvGvQIDe2MyvEgPpvIK+OMjEco40YUmcj+Lr/Qc0h9x5dlz99/KaqIwpbtklKqM
         LVTQ==
X-Gm-Message-State: APjAAAXVi6t14ViXo71nXV3bDlHoOOcyPx6TIgGAynu7AWtMz2TUW1FU
        RQnYiZyj/CvbzFLhqieymnlTSOM/
X-Google-Smtp-Source: APXvYqwCWkL/skN4vbEbQMFzV5aBIJv+e05Bxznwr6vFy6ObId8ujBCXcrfCcCxIG5+Gg3q2fW6M+g==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr12317512plm.174.1573779647415;
        Thu, 14 Nov 2019 17:00:47 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id u3sm7930068pgp.51.2019.11.14.17.00.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:46 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:45 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 06/27] t3600: stop losing return codes of git commands
Message-ID: <96872839cf50b5cdbe77b233816ffe40b02cded4.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a command is in a non-assignment command substitution, the return
code will be lost in favour of the surrounding command's. As a result,
if a git command fails, we won't know about it. Rewrite instances of
this so that git commands are either run in an assignment-only command
substitution so that their return codes aren't lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index f6e659b7e9..0c3bf10edd 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -304,7 +304,8 @@ EOF
 
 test_expect_success 'rm removes empty submodules from work tree' '
 	mkdir submod &&
-	git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) submod &&
+	hash=$(git rev-parse HEAD) &&
+	git update-index --add --cacheinfo 160000 "$hash" submod &&
 	git config -f .gitmodules submodule.sub.url ./. &&
 	git config -f .gitmodules submodule.sub.path submod &&
 	git submodule init &&
@@ -623,7 +624,8 @@ test_expect_success 'setup subsubmodule' '
 	git submodule update &&
 	(
 		cd submod &&
-		git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) subsubmod &&
+		hash=$(git rev-parse HEAD) &&
+		git update-index --add --cacheinfo 160000 "$hash" subsubmod &&
 		git config -f .gitmodules submodule.sub.url ../. &&
 		git config -f .gitmodules submodule.sub.path subsubmod &&
 		git submodule init &&
-- 
2.24.0.399.gf8350c9437

