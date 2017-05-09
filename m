Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130F31FDEA
	for <e@80x24.org>; Tue,  9 May 2017 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbdEITSd (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:18:33 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34884 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdEITSb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:18:31 -0400
Received: by mail-pf0-f170.google.com with SMTP id v14so4547021pfd.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KU57ijK9fBM4XANaNycL5GUG6FLK7cbnzJaWoxWohUg=;
        b=dOfsQ/tLGI0KXGmcuxlbNBARVACfI7iKbiO/i5q+Iywq3RGx4Vyk346hrFnGULyVFs
         uypv7jJcd8olPSMbTbC1F45du6MSREoLKSUOdrDD8negHPsF+wfdq28BSRiuPrdELUl1
         BjFXg3MlccNhJOY/a74QSCb72QV/FH2ESQqj+SKEA0ZzGSfm8WSqHni9CrMEnXw+gcp9
         QQUu+ktbH4jsjPnzWpyK3nDK8rXSOZlwaPadlE3dBAjsVaN/XYcPFus07V1V6zQXUUX3
         ftWWjts8sGcBfHI1n0xGLHO5QM8MmfBMippa/isWySmQXwlwqPsPhJzJ0hak94t7nTZM
         4rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KU57ijK9fBM4XANaNycL5GUG6FLK7cbnzJaWoxWohUg=;
        b=keevAGer3zBhloKEuLXHeiMkNY62Rx4sRvGJDpUNWkctoOSGcQCnPGhYRRjOD35P8O
         JLHnAkLKzSdUyEpNIlvJWOdWi3kgZ9t0vepIowVMssDhwr7vTPP5DOvokGWJZGDeKwUt
         90b6piQA4iMqwSbdBEEenGR2O/mvnV28+LNM5BdYTUy47eTV70T7hZfQvbq45zModiKf
         wxM4+c3t0VBgc9IUwBEG3/pp605JKZtN4CBEe05d3/GgO79vW84r43NOATr+E2PsQcTC
         8MVON/zx4qcBBposFpsGgBug2Sa37bNZapihhu6bAXwEs3p9iBdfntyDHHmAQOOizWuo
         KK5g==
X-Gm-Message-State: AODbwcA4ORZLPX3iWU4GKA8c+FjaOOR2mAMEDWkWUTg+3KRsPfsdGucr
        xtsXhEOOYwQeeUeW0EPoYA==
X-Received: by 10.99.53.207 with SMTP id c198mr1930786pga.182.1494357505323;
        Tue, 09 May 2017 12:18:25 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w23sm1124427pfl.133.2017.05.09.12.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:18:24 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/8] pathspec: provide a more descriptive die message
Date:   Tue,  9 May 2017 12:17:58 -0700
Message-Id: <20170509191805.176266-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509191805.176266-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current message displayed upon an internal error in
'init_pathspec_item()' isn't very descriptive and doesn't provide much
context to where the error occurred.  Update the error message to
provide more context to where the error occured.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 303efda83..61b5b1273 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -555,7 +555,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		 * would trigger that.
 		 */
 		die_inside_submodule_path(item);
-		die ("BUG: item->nowildcard_len > item->len || item->prefix > item->len)");
+		die ("BUG: error initializing pathspec_item");
 	}
 }
 
-- 
2.13.0.rc2.291.g57267f2277-goog

