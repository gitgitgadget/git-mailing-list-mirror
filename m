Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B5C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1EF86109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhHMVGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbhHMVGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:06:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3760DC0613A4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a25cb0c0000b0290593e6b14f6aso9487894ybg.22
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5clB5IdAobX2tXTwZtbKpFVYZyKYjRCpEsEhjhCZ/hQ=;
        b=X6RLFyjsNy8PxhXzU9irl+LhnupBon7Tw8S+rUq3Jwy0SsQgl8pxbdhmP+2ZXTOTts
         QzG5adirKCD2izEoQgSRY1HDT+MCdnrfOZ/IK1gQO66FuN+aETiEJN99rV7Sfvn9oiKn
         tAB+Q10Tyje0xHfr9TI4iOBzjhpFotFYWTWnzDb9Ahc/0xrvs/zCQk8ZPvVlSwhT/qll
         tqTG9fRopI89d9knTvn+z994EZgN8C7UjcASxuqYoSDlIQaPiMLdIQM6pJWcvfgOYcA1
         j+vzjeu+4nRM6BFoQVD3kuePfwXJUdeQlt33pRePtuafFhPt61XXgoyZdZnnRidwRemQ
         1JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5clB5IdAobX2tXTwZtbKpFVYZyKYjRCpEsEhjhCZ/hQ=;
        b=bLATlWA+Fk/17/679Tutnv0FRTeoHrLJPCzxsd28ZxRFK4rWN5vuadQc5fB1CrdyJF
         1fDkDKJviNhh7m1USTZiKTIIrrtZJzd8HDcGabNHkFXgyFjF07hJc5CyKgrf7744Q+v2
         pZjsKqnXyFhZJ8bYk1TUIuAquJGbokJPQOYCFvZWPWATbuC9HdjIGjcMGS8WN5E41ezf
         YNxgq3yNIJD72zAnInVydFcWrKN2mPFa5rml7o4665AF3z49bNWMnAYadpaoQPm9t+RO
         DUEbrKmzILhJU2Ngnwu3WVg8Pl5oYvrhplmZvRmD33Vo5nIO+BCfZyju8mAxdiZFSkRW
         1LHA==
X-Gm-Message-State: AOAM533LMHPnrQkgd2rt1yqkUBzeGAQn9TM+MAzp3yfwVoTG1f2RuUXh
        5bTioXPw5zgDwJ2hXG+GZnz3Sg2pol8HK7S9+QnCxoOZiHM2zRORr5aDRNwSWRBlP1RHEbrNhkQ
        MfHL1jnMcCRuNGY838ssNQHSY11ma6tYUu239MGF+fA4JNyS96MC2kZXd9dZJjRweVh7ueqHHgO
        Ky
X-Google-Smtp-Source: ABdhPJw8PYbK5z+ZPGEn/troWZFM/7ndmjIg3i+wZTgyOmHlKPw2OHdLd8TGxW2nxdSgYV259NH9bL+FYU3RlUgpJevX
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:100b:: with SMTP id
 w11mr5555840ybt.216.1628888740380; Fri, 13 Aug 2021 14:05:40 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:23 -0700
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
Message-Id: <4a51fcfb77e4d13597db62e5dc697e8c94cf06fb.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 8/8] t7814: show lack of alternate ODB-adding
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patches have made "git grep" no longer need to add
submodule ODBs as alternates, at least for the code paths tested in
t7814. Demonstrate this by making adding a submodule ODB as an alternate
fatal in this test.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t7814-grep-recurse-submodules.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 828cb3ba58..3172f5b936 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -8,6 +8,9 @@ submodules.
 
 . ./test-lib.sh
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
 test_expect_success 'setup directory structure and submodule' '
 	echo "(1|2)d(3|4)" >a &&
 	mkdir b &&
-- 
2.33.0.rc1.237.g0d66db33f3-goog

