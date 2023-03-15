Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC80C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjCORql (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjCORqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CDA637E4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay8so7861487wmb.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKehZwzMxp2IDxyfm57q9YaxorHBAAhc4ddH2zrnLQA=;
        b=Uwynq+hVJKjUgNZdefpjJwbsYmczG+tkVjk/ck7DvWG3QeePtpmkTa20+gTJ1EpY+e
         +zGQcj6LXfP94notivVvhHMi0qW7MfeYfY8R5KE8J6LbSr4ZcJZBuCx7xz9enI1tmDt/
         4uLagbFxhLhHWo0l7mWOFUxa4cmq2SB/fbl8IsNSfrZaLNz7+IpIoOGzeqtPHVWfPuvJ
         /JYo4z6JmJYXvkUsKrYKt7ZHIKxryCNWVXuOPOgRmrFJzJV1vC7pHssKN0R/60vEI14k
         QXL5a0JeMFZukYLnjGLJmC4R6VXZLfgKw9jUtaERly0y/se0wfFj7AzvcGIpTWpg8X1X
         TGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKehZwzMxp2IDxyfm57q9YaxorHBAAhc4ddH2zrnLQA=;
        b=yvg2krqF0lJlDCgoCN0chS3JMO3bwCHYAdWQnpkQIR7z4927WY1S2XY214wK/vdUu7
         CwhjVyL4l/egiwnI1iuRpdhXpdllDR9BPjfoTOWqOc7pa2D7F4h/QxUD/iYGDwwYZbGb
         pKdw77we6+1GN7donI1oHFDZaNt9+ftgHuKqP1pZtDStOl/uQ+6c1sniZkoPxAluNJch
         oNuQb3EuoxH7mt+FmniMCS06Jiqn0IJIzgUxQqrqq7s5h3TkL2Uv7Y5KW0fvTs+Zl+6/
         oaZfq0o3ALiqGQyRQj2HFwUQ96QG73I0jeLMHl8vNu+pvu2ufX2+S9eV1xrCXrU1WZQF
         3ODA==
X-Gm-Message-State: AO0yUKVyGQZgq0y9fbJFZ2NTBzhwok/uvxbPmHyexEVfO/wl7jWmKoBe
        GqiY4Hs2Pk6S0aLooMJHlB0kalCnOEA=
X-Google-Smtp-Source: AK7set9uClLOUqphoqIrovCbThSr0+/CJY6CDMk8QFdAfHXRuJsATIRG1J5JZEetPJ/8ADnGcu2GEA==
X-Received: by 2002:a05:600c:34c1:b0:3eb:383c:1876 with SMTP id d1-20020a05600c34c100b003eb383c1876mr18691133wmq.6.1678902346262;
        Wed, 15 Mar 2023 10:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b002c706c754fesm5077929wrv.32.2023.03.15.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:45:46 -0700 (PDT)
Message-Id: <f56d6a64d24147b4fc59118d82029fbe7cd5af38.1678902343.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 17:45:37 +0000
Subject: [PATCH v3 2/8] for-each-ref: explicitly test no matches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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

