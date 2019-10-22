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
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE591F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfJVKU1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43309 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so10360502pfo.10
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xTSof9GFWiSeHeRpOf+sfGfJD9gluHEsIe8LRxX6pSY=;
        b=lMx88pyt9XIOWgc/hpIYwtGHV53F9gwyQnBLChCOoGab0pJM+YUEJdQWIc3Suw0MBA
         MiUh198iA8+GFgD6ri7yqRm1oFk9obUfchx7U4zvGfPM8EGQNq5DkcDb4xFlyeTSf9d4
         lqQM+2Guy49/wl2HyXR84aweLxaZHKHLG1bK7BfMGLdGyudGjw0bNM8AjerUe3f135GJ
         fN7YuL6H9NJeugATojGJ+zzqa7OnregclL5okuF8S7ZEkS/1K0tlsqxF0rbDkVTI1RQB
         kG2oTg7Anb5dIm/qTTmfkHW4V7jr827LP4hbkmD0bMKTQVQf4cY+OwGrHUb5BrhC6ahY
         hkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTSof9GFWiSeHeRpOf+sfGfJD9gluHEsIe8LRxX6pSY=;
        b=sM5DeAkmTSCz6xJkANnK/TEyP6I1HBWa6zTnLwUniOCzCnlzMWf8IEaFHqB0tZwKp0
         323NNVQdOqrz19V49ZVqrcjaj7kqoMKRhJslaj6SyyBqq2iD65urDFa169qt+ba//3Tp
         18+0IER85dLhbIlvK1POJS/me75nl0FoKEWnx58HH10owawQ/qKN0lUelGlI8/xaLjWY
         YHGhLsJ6AvfvE+5CVo4r81MLDDfozElpC4Xppr2n2b8owl5/UIjpH6SreXwkNkEkW7cF
         mGsKHDUWSog67XZbzQJC1ttMxwOt/0C0wQhlRN16qVr5z8F/jduTziLggPJw9/0PR2Cj
         IZGg==
X-Gm-Message-State: APjAAAVWNQ2Htv2B8SxA1vzgRykBD1k/IX61Plpha8ob/wqIaRJU1KG1
        6qaBtje7KS4legoeOqVAfymTnTos
X-Google-Smtp-Source: APXvYqy11/fM3yl3/Ck4ujCUocxjo8o7JaMROR25tzUj9XibSstYk7hLwM8pGZDSBMMNjZDvqrfowQ==
X-Received: by 2002:a63:df42:: with SMTP id h2mr2756262pgj.405.1571739624421;
        Tue, 22 Oct 2019 03:20:24 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id z63sm3590378pgb.75.2019.10.22.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:23 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:22 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 11/14] t5520: don't put git in upstream of pipe
Message-ID: <56bcbf304792676aa4f61b37122467eda0f2a184.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, if the invocation of git failed, it would be masked by the pipe
since only the return code of the last element of a pipe is used.
Rewrite the test to put the Git command on its own line so its return
code is not masked.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 8b7e7ae55d..8ddf89e550 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -668,7 +668,8 @@ test_expect_success 'pull --rebase fails on corrupt HEAD' '
 	(
 		cd corrupt &&
 		test_commit one &&
-		obj=$(git rev-parse --verify HEAD | sed "s#^..#&/#") &&
+		git rev-parse --verify HEAD >head &&
+		obj=$(sed "s#^..#&/#" head) &&
 		rm -f .git/objects/$obj &&
 		test_must_fail git pull --rebase
 	)
-- 
2.24.0.rc0.197.g0926ab8072

