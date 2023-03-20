Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDDFC7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCTL1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCTL1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969D959CA
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h17so9969073wrt.8
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKehZwzMxp2IDxyfm57q9YaxorHBAAhc4ddH2zrnLQA=;
        b=ACSjYbaoyXHCfSwxQyu4ByB84DZyzlp6KpIJqZgh/2FiNtFMIKvM/4YHMBDV7GyF5j
         f9ziGc+SS57D1jQVeNIvUrp1iuWf8ep+sCto9sRXJC9fUOK+OtF7+Xn7zdH9guQWHXyz
         UBiFhEFktw7DSlVU2Bvw+o9iPuEQJQhM8rgPaobMy9MnbxguUV/5/abZTlB16W/mO/9t
         FhaH78qWLH+DmGt+ogFGZEhcKPAGvAxffvh+avLuJTxrbRIBJm7h1shQdzh10Du5Tet2
         o0s3lV6Gh4DKqQRgj3GAuN5mnO9W2QjI8STfaR/Tc3c7NSaYTGJPuzTD+3h2LMZUELUt
         LBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKehZwzMxp2IDxyfm57q9YaxorHBAAhc4ddH2zrnLQA=;
        b=TKn7X3+2DVoAp8+qNDyE+sIoPobdBq0GuP/s0TEeF9P3JILYn1uXa7qP3TRFWy8//d
         yeQ+r+vuHeBJtEKEcBIH/cVX4yOmxgsoz6/ST4sHDeAdUkNjjNKex4EQ7Gs/rhYH81UN
         a0YOM/NQ8JiR0dGaWXep2kJ3RX2QpfVAoyMY06VxeppbkQN4tDX0yBvcRcsh2BSVglfa
         lrySN6FjtxcZZzBFDUmKSGg4QytTBNuS4xlElCDc7FMNOd2lHJoCExpF38TPGP45DRnu
         pouZxKA4pefbgUA30GIJBdd9sPCvrNmidJZHmSfUtI3o7fkh2gXCkR37euccc3vh+ka1
         L39g==
X-Gm-Message-State: AO0yUKXWm6y0OOll2uezUkd13glFf+FKn0fQ64VCuOH0zoSwpRQtYO5r
        v772bqsuWyFkMSlACzqnIdls8pMhFbQ=
X-Google-Smtp-Source: AK7set+A2DKshESbG9nshUOk96x3Yt+Gfts97ptGvS3Bnih8wFGe1q89qnPFlBViFg8t+peaIOypgQ==
X-Received: by 2002:a5d:694d:0:b0:2ce:adbf:cb14 with SMTP id r13-20020a5d694d000000b002ceadbfcb14mr13144111wrw.28.1679311619056;
        Mon, 20 Mar 2023 04:26:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a056000100800b002d8566128e5sm227741wrx.25.2023.03.20.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:26:58 -0700 (PDT)
Message-Id: <1e3d499431aee563f6104f5ef1192658ece4ae4b.1679311616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:48 +0000
Subject: [PATCH v4 2/9] for-each-ref: explicitly test no matches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
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

