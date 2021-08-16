Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17409C4320A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17F260F46
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhHPVKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhHPVKq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:10:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F3C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:14 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m3-20020a17090b0683b0290178cb50bc1aso934770pjz.7
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5clB5IdAobX2tXTwZtbKpFVYZyKYjRCpEsEhjhCZ/hQ=;
        b=Un7XC+qIr7U16TulejmRnsbxDcOymq5UbIBjwsGA2jvaIXwRE7WLMuHKEG/lbDwubY
         FJAr6GO7+90K/P0BrIGL8X/LHhXnXJVuRjpGxQD83BrYB6M0zAUPD4+ZEFBbbT0hBQ+l
         o66Odbnph3CGIwi8i1kjrPcjWk3rAX8o/j9EiGtK64gFXgYEtQ4vBZSxA4qPbkGkCXuU
         MoJfY/qsa1MGCmEiKUdCZu7axdiqhJmwz0L/RjpY9bPMbAKM7AhX2D7HQfEctC258YpB
         ++0tbRXdoa2obD/rmu1mINrGd+fvQIv8K6cieJgLCZmTruUmd8QJ/Jh6Sd8fVM31zwkX
         EQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5clB5IdAobX2tXTwZtbKpFVYZyKYjRCpEsEhjhCZ/hQ=;
        b=VBXx8/IJivfklnYz7efHa0ZEhlho02BgF1TJI+8hTaEZ/qpY7zon1Wp8RhP64Kek2F
         jFd6gjhNoYCKpKEnL2il4/+L5lkB3+88Xn9c25uE54tTIb5jsyMfoxzmDQ6a70CSYSGO
         E8oPoUG+E3saZ6+uerssitI50ddDTYMnUhrAHQv3TsZXlKtgMDVFNYUInRT5qayJX4yf
         LyL1MPpGb9PoluMLVQ4pKSMrX06AfJ24PvBZKcUD4yCLUW6FQDXlsAHTaJziDrVWQfo7
         6XTN4aj6/T+KlyO386pXcVf61skHVbkBIVEoiv4fH8/ToRBO+5HyQZA7QAYXYf9F51Kb
         YvVQ==
X-Gm-Message-State: AOAM530F3G41UBbMzv97DnDQ9z4Bo0kLGZwFYNDG3oUZDCFkTTLzieiY
        QTDCX+u2OOYt+4EDl5V8ZASTC/MKI6HXtzTiNlwYG8EzaGmo43cqbAPuqvqwfolIlCtx9Q4S1Zk
        SrOfEazNkJj7aL7V6NUsiNtVaKKIxjXdB1/R5MY0mDAwbGZhtzhzaTUqGURJ7MlT8LZcS9owaio
        8V
X-Google-Smtp-Source: ABdhPJwHWOvg40dfOQTIHtDqXVVDKOy+V97ULxU/ise8d6k96FGdxcKGGFH/HpNgUrVej1sbdGe47noRTn4lGESaGK4Z
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8c83:b029:11b:3f49:f88c with
 SMTP id t3-20020a1709028c83b029011b3f49f88cmr578613plo.63.1629148214313; Mon,
 16 Aug 2021 14:10:14 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:09:58 -0700
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com>
Message-Id: <4b3176f99e315170740a38527d8f894ce2c411d4.1629148153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1629148153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 8/8] t7814: show lack of alternate ODB-adding
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        gitster@pobox.com
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

