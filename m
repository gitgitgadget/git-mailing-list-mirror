Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B643F1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 20:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdLLU4L (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 15:56:11 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:43952 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdLLU4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 15:56:10 -0500
Received: by mail-it0-f46.google.com with SMTP id u62so1266434ita.2
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oWbooo8/5xa8X1mUMk/SVosIeud9gmeT4hQGrr3GC7Q=;
        b=cCj1/UlH5ERSKradFajmFl9ZPpI8GNXSaXp89N/6aDsU1Bz3DVuQskKj07xmQFtUTv
         Li9CsehbSwHwmD3bGF6KnwPKFiS05Z40HiTa2GNSnkqeBjIgYd5Na4x+O/QAB64+aRGT
         PbiM22mDXSALi8zquJ2zEJt2ooRLxg3HHYuhuyTHV0d6ighZhGaKSASxJ8oH/LykEfXA
         gv5rpQI+vQy04IBpe5kYPEZIgt+q7yKfIQQBX2Xpq5U64VBxD4HcPJ2WHfCmJRIMUfLq
         yvshkHCiBF6wYmxl0gKi/H4V+MLuEnkSvSCXYxLVmXrAiVPvS2jmLa+f1motVi925xIc
         rt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oWbooo8/5xa8X1mUMk/SVosIeud9gmeT4hQGrr3GC7Q=;
        b=PiisBD0UhCw+Otqa7+WPq9RNIqhiTuQFKkxwFa44T0S0udj6nKgMcycPlI9jyb4Jxi
         lSRslKA0f3ZkxmdO2wdqazyt9abHL1VK8E0Dfju2fTGeVM+4krGY1yfo4PWmvQQbgVY1
         CFcXZCbv4Th9NU+0EGIrcxL4Aa29rmnn4XtCFaRE9GPmwUkeIPd4fX9TAXBUJi5G8eaD
         jyKBoze5fLJiBRMCtLZDmBWNTAVG5tAhlTeL07oQBehV5pMOm+49OH87UqI/q9IFwrET
         mbQtwEG14MwKhrN4lM2slKjUjgv/XwSBm/+r8e9ipuPgvanRMx6n1aT+dAQwHQlWqrRW
         bMTQ==
X-Gm-Message-State: AKGB3mLTtwCrEiRhbR5TjirYVXPzbDYcugPnECkvNYsxE2T2lrKz3KlQ
        FGovp/jafpwnKc+DI8FWG2Tq0Q==
X-Google-Smtp-Source: ACJfBosq+sdCL7KRrKC+1izyy1CYu8ca/H21SHU43ttFgtnRpG77SqWHKniWSwO7F16fe3GFP28Msw==
X-Received: by 10.36.185.26 with SMTP id w26mr187875ite.48.1513112169064;
        Tue, 12 Dec 2017 12:56:09 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id x124sm12388iod.86.2017.12.12.12.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 12:56:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     dnj@google.com, git@vger.kernel.org, judge.packham@gmail.com,
        kostix+git@007spb.ru, manschwetus@cs-software-gmbh.de,
        max@max630.net, peff@peff.net, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH] t/helper: ignore everything but sources
Date:   Tue, 12 Dec 2017 12:56:06 -0800
Message-Id: <20171212205606.75581-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
In-Reply-To: <xmqqbmj31zve.fsf@gitster.mtv.corp.google.com>
References: <xmqqbmj31zve.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compiled test helpers in t/helper are out of sync with the .gitignore
files quite frequently. This can happen when new test helpers are added,
but the explicit .gitignore file is not updated in the same commit, or
when you forget to 'make clean' before checking out a different version
of git, as the different version may have a different explicit list of
test helpers to ignore.

Fix this by having an overly broad ignore pattern in that directory:
Anything, except C and shell source, will be ignored.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> If we ignore everything but resurrect *.[ch] with negative exclude
> rules, can we do the same without moving things around?

Yes, there is also one lonely shell script in there, which also needs
exclusion.

 I guess we want to test this overly broad pattern in a sub directory,
 as I could imagine that at the top level directory we'd have more cases
 to think through (I used to put untracked files into the top level dir,
 but I do not do it anymore).
 
Thanks,
Stefan

 t/helper/.gitignore | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d02f9b39ac..ee1e39fd08 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,40 +1,3 @@
-/test-chmtime
-/test-ctype
-/test-config
-/test-date
-/test-delta
-/test-drop-caches
-/test-dump-cache-tree
-/test-dump-fsmonitor
-/test-dump-split-index
-/test-dump-untracked-cache
-/test-fake-ssh
-/test-scrap-cache-tree
-/test-genrandom
-/test-hashmap
-/test-index-version
-/test-lazy-init-name-hash
-/test-line-buffer
-/test-match-trees
-/test-mergesort
-/test-mktemp
-/test-online-cpus
-/test-parse-options
-/test-path-utils
-/test-prio-queue
-/test-read-cache
-/test-ref-store
-/test-regex
-/test-revision-walking
-/test-run-command
-/test-sha1
-/test-sha1-array
-/test-sigchain
-/test-strcmp-offset
-/test-string-list
-/test-submodule-config
-/test-subprocess
-/test-svn-fe
-/test-urlmatch-normalization
-/test-wildmatch
-/test-write-cache
+*
+!.sh
+!.[ch]
-- 
2.15.1.504.g5279b80103-goog

