Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E49C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCJRVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCJRVM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76ED10FBAD
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so6584348wms.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678468867;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKehZwzMxp2IDxyfm57q9YaxorHBAAhc4ddH2zrnLQA=;
        b=omAMv520ry5VBH6Mss8qQeKqv/+oTlYg+cR5i1ENPvEzDIooC7jx075x+5RUFHHhTA
         VugR86c3zOsImOMo7eA9sDbsezgap3PbCqTmMW/dUg428rT5AhQdoJUkjzXDvzZpJTVW
         gkSRqhJztb+fBPBcMr6mMHHpdKEzPHuXcuA799yHXQL77rxnrNIAFWZW8aMvpT8vPBMn
         K+TCES7tQw8jJITdaJlvk7CeKgpyvUwB17pro+JTLQlMN3P8Uh3vel2kC5+FAAp4Y/gb
         HfNhV3aahsDu66low+l6QgL5/kqckZOrACuK7+knPMTCcRpVPYL8XW7oBVTvCOAmkiWM
         j3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468867;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKehZwzMxp2IDxyfm57q9YaxorHBAAhc4ddH2zrnLQA=;
        b=iDwVssdaupnRVSycIb77ye5DuFZKHMXydJ1BUD3m8juLqaElLq+4kBRIuzB0Rth0TD
         cMXsl357yVIqy9sf/gav1C5ANlFRgyzmUy1Xjd0/U0aczmOq/ZDCo8W+Vr5NdsuPXugc
         tO1uuDIgHc+EnV+GfnNP8yFJdwZ7fA4vYGeoSfriLV/Safpl/w5nQJL1lefOzac1VTSL
         uCw7Tt+8IoHXvYFbqJqmseQnTUyIDuQXetltnXObPn/2AiD53h61PiYYgAWSCM4dTQ5c
         AkLG+bA0DoyxcDYU3+wde1rnk76Gqi3fUlmp1IoEwuWRF/TuMuQgqGbTRqd7gopq3a1q
         fvXg==
X-Gm-Message-State: AO0yUKU7LMOxwMk+CSiUW2CKCFTLNC8qlsJ9PwKKtKVkwDu3ofiVapQ0
        WZ0xqjDk8IusId1B3OLxC8MySWqHMGQ=
X-Google-Smtp-Source: AK7set+SHhwcd5P5k5cJv5PSeZfhI/DRD0Evh0PW4WHq3tcGhk3GYdZTOi084nkfzizQ25P08olTpQ==
X-Received: by 2002:a05:600c:5492:b0:3eb:2f3b:4478 with SMTP id iv18-20020a05600c549200b003eb2f3b4478mr3451493wmb.15.1678468867055;
        Fri, 10 Mar 2023 09:21:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10-20020a1cf20a000000b003eb5ce1b734sm480760wmc.7.2023.03.10.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:21:06 -0800 (PST)
Message-Id: <2f162a2f39f5d413fbe196e56d15ecf3080a2a8b.1678468864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 17:20:57 +0000
Subject: [PATCH v2 2/8] for-each-ref: explicitly test no matches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The for-each-ref builtin can take a list of ref patterns, but if none
match, it still succeeds (but with no output). Add an explicit test that
demonstrates that behavior.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t6300-for-each-ref.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a58053a54c5..6614469d2d6 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1501,4 +1501,17 @@ test_expect_success 'git for-each-ref --stdin: matches' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git for-each-ref with non-existing refs' '
+	cat >in <<-EOF &&
+	refs/heads/this-ref-does-not-exist
+	refs/tags/bogus
+	EOF
+
+	git for-each-ref --format="%(refname)" --stdin <in >actual &&
+	test_must_be_empty actual &&
+
+	xargs git for-each-ref --format="%(refname)" <in >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

