Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4536D1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbdLMUMs (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 15:12:48 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:40024 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdLMUMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 15:12:47 -0500
Received: by mail-it0-f66.google.com with SMTP id f190so5671503ita.5
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qixXYuaUxrgsW2ILmDjeosrEfuqa2mCgsbPIRpyhnsQ=;
        b=kE9TuNijbjE2Pi2gqRCqExAnyqMJ9CytC9kN4kSkx5MviZ8DXo0Y4d/4L4m0o5Ah8+
         /W5W5Su7Se3XlQd4pJPco3bTjdPvx8nGP7WjfqaviZQZYoxnnFoQcvQSc3cKzNZVyTmo
         f9T8zXFzc/B2s1BrLu5jkk+iQEqBM+MrYaTJ2ftNO6b0p6wLOuH1FujGLSOeIjxSRife
         xEqEoOaSk6jRNzttXNdEgH/j7XEZykHqGNL+oelOtqpgiXNIftA7moQojdqQCjy6eDRq
         XEFqTgAvH37u7lpHHHg/AzW4NlZTiGM7D3KRPJCqLnk7ziCtFsksYnFaDJ/BzuHjBpON
         TMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qixXYuaUxrgsW2ILmDjeosrEfuqa2mCgsbPIRpyhnsQ=;
        b=fqD9+Vb+Ey8rXG91TqJMmD111jaJEhZF5OSBDeaeq5VrRDluotfuMgT9Cbao92dNUJ
         PpVSv/2KxcF9QRStnEC+q7UDW7SjNZjpslCHIlkPmLeuKikdAs1FufnhZWzq64kixfe2
         R1YtAgBW2v6pDPQCvIzE3Md1srXjVtwddvw6y0PMWI8VhEdoxFxnHIes87Tcb/8L4gxu
         xA1pEKtZrdMUpfvH0bcCf8AjFE1JWQftkxJFh9AKllmPAIKbCYLIqlvhwuFDK6GmkiGR
         57AnCSyPcDqPzWoMkHwwK6BS1Oct414V/d3pV68jlM7EkCxB+Zh/0qEYXK4Gg68jHYh5
         9/Zw==
X-Gm-Message-State: AKGB3mLxS5yg2iSUpotVZzA7pX6N3r5i+AiXJ95Gs6VvpdmVCldDpDKP
        MLfskBkv3cPcZybI2nRSkia87w==
X-Google-Smtp-Source: ACJfBotkCFGDEHWrDDtSx25dOpXnA3wevtH/jrToMLGvRZf4uA5ZxyvLFMjBXN4YyrIzVeDo3r6g+A==
X-Received: by 10.36.85.142 with SMTP id e136mr274798itb.52.1513195966175;
        Wed, 13 Dec 2017 12:12:46 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o200sm1385632itg.10.2017.12.13.12.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Dec 2017 12:12:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     dnj@google.com, git@vger.kernel.org, judge.packham@gmail.com,
        kostix+git@007spb.ru, manschwetus@cs-software-gmbh.de,
        max@max630.net, peff@peff.net, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH] t/helper: ignore everything but sources
Date:   Wed, 13 Dec 2017 12:12:42 -0800
Message-Id: <20171213201242.115601-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
In-Reply-To: <xmqqr2rzzmf4.fsf@gitster.mtv.corp.google.com>
References: <xmqqr2rzzmf4.fsf@gitster.mtv.corp.google.com>
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

Thanks Todd and Junio for mentioning the .gitignore file.


 t/helper/.gitignore | 44 ++++----------------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d02f9b39ac..5b540625af 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,40 +1,4 @@
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
+!*.[ch]
+!*.sh
+!.gitignore
-- 
2.15.1.504.g5279b80103-goog

