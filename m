Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD4B2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 16:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdCRQWx (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 12:22:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34975 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdCRQWw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 12:22:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so7788802wmb.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EIQ0dIVcOObglmd3WDYaE4cX46ae7Ou2NsWt2Nm0qHI=;
        b=movz9kO+npdWWiixOJnos+OUMWPPhyBu+qKfmMk+kRZpgMuxOvwGe7PNrKL1u3HRGp
         ldfF7G8KvWkeGaumtpZAyFVhCn3HelIRYlLXEtzKt2DZ42hN3ly5tZwTpQHCux1mXNit
         vKVwzqAmAgCDmom5ppfNZs6SX8pisBnrNOT6X3bLzN/oU+qX7oRkduvuUSa7YI0Y5FC2
         /tRA+CiCNGGO08/6CNAlzv2ta0UCnrfz2QKnh2jHfzLI4d/Bu9HHCItPJqP4EjoVfXjR
         qWHMBLpc3HjYVeTLmBQvWB0m6HA2Z77s2PSAemcFV/UPDUcNiY6WaAopBh2Q6/cGb9La
         OErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EIQ0dIVcOObglmd3WDYaE4cX46ae7Ou2NsWt2Nm0qHI=;
        b=ZoJ6mN9gozDsuu2WUZOL12wSPH8NzQm5/TZSoJo0FVYeDQmUuwi5OjUzau/XbYUliC
         YGg5hiHevImIc7r3aPOqkD42K0fXoMWlAySYpghInOHXH2QvwNIkNaqe4uwwG3jycF4j
         1GUGBkQYCkdLILqyzo3isPU3+2g611ISQQS/D5iWNj81GiLF6f2UzAGl4cB9G9DnT/kJ
         2zZvHhMYEwfXt68CoO6rZvVcqdKgCwby/2klQ6sT12FugmbwJVomO5Vera5eMYJporDe
         ulpcXNbUvmpu5y7fq3IfjBK7ex1AmmqBnM0moL8B1P/v3tRIe9jZJeE5CYiNKwcUY6rk
         cMVg==
X-Gm-Message-State: AFeK/H1KItS7J4O06yjk1Vh9afUBRSLzb6C0a36kLxq4o0Vc0jAoBf59Hn/tphCwffzl3A==
X-Received: by 10.28.154.14 with SMTP id c14mr3011429wme.75.1489853649818;
        Sat, 18 Mar 2017 09:14:09 -0700 (PDT)
Received: from localhost.localdomain (x590e29c6.dyn.telefonica.de. [89.14.41.198])
        by smtp.gmail.com with ESMTPSA id s17sm14111267wrc.25.2017.03.18.09.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 09:14:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 1/2] tests: create an interactive gdb session with the 'debug' helper
Date:   Sat, 18 Mar 2017 17:13:59 +0100
Message-Id: <20170318161400.19753-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.0.377.g15f6ffe90
In-Reply-To: <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com>
References: <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'debug' test helper is supposed to facilitate debugging by running
a command of the test suite under gdb.  Unfortunately, its usefulness
is severely limited, because that gdb session is not interactive,
since the test's, and thus gdb's standard input is redirected from
/dev/null (for a good reason, see 781f76b15 (test-lib: redirect stdin
of tests, 2011-12-15)).

Redirect gdb's standard file descriptors from/to the test
environment's stdin, stdout and stderr in the 'debug' helper, thus
creating an interactive gdb session (even in non-verbose mode), which
is much, much more useful.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 t/test-lib.sh           | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index bd357704c..4a50a6104 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -154,7 +154,7 @@ test_pause () {
 #
 # Example: "debug git checkout master".
 debug () {
-	 GIT_TEST_GDB=1 "$@"
+	 GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
 }
 
 # Call test_commit with the arguments
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 86d77c16d..23c29bce6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -342,6 +342,7 @@ fi
 
 exec 5>&1
 exec 6<&0
+exec 7>&2
 if test "$verbose_log" = "t"
 then
 	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
-- 
2.12.0.377.g15f6ffe90

