Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF4A202BB
	for <e@80x24.org>; Sat, 30 Mar 2019 07:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfC3Hvb (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 03:51:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34161 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfC3Hvb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 03:51:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so11263020wmc.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 00:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glFy8OazfIHfrfnEiaa+cWhaxIfTbDlEK1qITXJ0mhc=;
        b=pzJ2bGHA/jSs39HY8W+/5qe6xEWacAK/+eBsmzc7YepY8b8cO+Zs5WL98jdevMvyoC
         0if7amdKeEVsk8vpOREC7vC6V0it8W+w70nFoQcD75dS9Th2ou/70EwqAZg3jZFyoOtM
         MYMbbhFKfPJFmhzXikJhcTUn7qtzM3/fdsKY7kSUsUMFHMUTRnYM5brb45391rtNt6Ic
         vK+/F1YwkPDoQ3vfqFYLj4gJEaRjM/YjoXK2hM60znpHJ3XTOHaKZwINXjEOgtyQI7dP
         68eCsCvaNVKtjx+0CFWXChxGPbdy4fv9AuKBGW8JgE6jK4y1YRE36gNeEiVmWeYjFKtl
         2d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glFy8OazfIHfrfnEiaa+cWhaxIfTbDlEK1qITXJ0mhc=;
        b=ijSlrMErMeKmxkXM+zIwCyFuejFCugJavoeYgOBf+xICHgsRv7Ib7gkRQauVnaboW6
         NLO5O9EOsrdccNrX8Hvfvv87SBjO8W6gF9lyThsXNA4/SJMOu0qmcOdrGaBv8jbvnqyK
         KLGBz2scif1U3/+UauL/SGnVMOVgjIIcrmyvhiYhZH455C/pZl2ang8ienHT3PWEAmJ2
         1eMS3XpbKRXjpdC58OFQF03RktoVvWzs0klG+L9Ufwy7zvWacdwTAPj0yi0mNmE51vYn
         8hei7c7C7fiBN3PH5VjHeh7ZwW3A86Ft4HIDqVlMYEjdT4qBJj5i0r/pRsLXZg3NzVen
         uUsA==
X-Gm-Message-State: APjAAAUfJlFxN3K6p+5HRT1Rym16ixgEmG+IVYD5bEZdBQRlQ8SPuOfr
        8yXH0NU3H3B5fuTLtD5JxOWDUxfg
X-Google-Smtp-Source: APXvYqxswfZKNNG84Y7AKnLMl3pHmFiCQI9zLC1HVWsBUbbf4ryzhchRUKWKXH6kBWKyWEdCaS+2GA==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr5900879wmj.90.1553932289132;
        Sat, 30 Mar 2019 00:51:29 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y9sm6999761wrn.18.2019.03.30.00.51.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 30 Mar 2019 00:51:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib: whitelist GIT_TR2_* in the environment
Date:   Sat, 30 Mar 2019 08:51:19 +0100
Message-Id: <20190330075119.13156-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add GIT_TR2_* to the whitelist of environment variables that we don't
clear when running the test suite.

This allows us to use the test suite to produce trace2 test data,
which is handy to e.g. write consumers that collate the trace data
itself.

One caveat here is that we produce trace output for not *just* the
tests, but also e.g. from this line in test-lib.sh:

    # It appears that people try to run tests without building...
    "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
    [...]

I consider this not just OK but a feature. Let's log *all* the git
commands we're going to execute, not just those within
test_expect_*().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 562c57e685..f6318c54c9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -379,6 +379,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
 		TRACE
+		TR2_
 		DEBUG
 		TEST
 		.*_TEST
-- 
2.21.0.392.gf8f6787159e

