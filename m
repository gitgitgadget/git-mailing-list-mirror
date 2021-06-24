Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC741C49EAB
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C44613F2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhFXT0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhFXT03 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8CC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so4334120wmb.3
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gyu9PgYNV3Ums6c/6YGL9DfM3feiJBnryQ77wVwg2c8=;
        b=VyJi63aM89YzvL9MqUUnaUzMe+5G/P3K8lOyh++rUHpBdXDHB82fI7PbDmWVsfw3AX
         UOpYZoq5ngtYwmAqX3NGg/GV5Nrx1TpGsDeeOTp/EK1GkzoaMQ2KYFkQgzBOnPXUu08E
         sA3jnItE+vA1etg/vUTKQSH+mLAYgfFfLq2EdvyzpHRzGKk6HSKVhNDmpqLaoxLCA/lU
         bKfVtLrA1kJUtR0cHJyCiEGVMcOn0SfkcB7NY/lSdS0KOmgOdWSCDUkCamGCrdPArLZC
         x1Yz6VLDrqIxDW6b2zLOdxnDbE5xAE1XtNDPXsAZQh7Cm+SVYGNSlmeQ5cJwVlEnyClW
         ViFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gyu9PgYNV3Ums6c/6YGL9DfM3feiJBnryQ77wVwg2c8=;
        b=ZHq+UiejIM1q7mWManMFhxTwWFuH+EoqzxUtlfwuKoUPpZetJQA7B0l5rbr4ng0Uu0
         xtOkfU/qa4bTsXzIjt0k4HVlhDhTdw/AxZNR+1WJ9GVyH35Ro5IrwqkE8ptEZJkOr4JK
         PzVVCOa0op/Oyskg+fZugQUYXpBx92aR6zOz69+GEkoOrFowMTe2menC3BoYiDycRc32
         MczOlFzJ3Cssbym9ll69LlgaOvgD331QBSyih+QsNbJDwmFT3I7WPEzU6xBfyP2DR1JI
         f0JHZg3JD0inMaOlXJFuMXy9FshwIInwMy0PFHFHZsstnKKSOUaML2xI2FtHOQZWSYyi
         QIgg==
X-Gm-Message-State: AOAM5338EyTgU0ZasGa9j2ByS0ad1qUUK6rkTOfcAXfF264GjaydxLkZ
        kZvQrD7REAOmwtUNlbdTbRvfF03NJDKZPg==
X-Google-Smtp-Source: ABdhPJz3Cb2s2HOcK2WlHxUCdPn73UwuVgYr8/RiB9kVfxIf5QFv1us0wjLuhaoSlUf7ui0iypxmTQ==
X-Received: by 2002:a1c:984c:: with SMTP id a73mr5887846wme.17.1624562647489;
        Thu, 24 Jun 2021 12:24:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/21] cat-file tests: test that --allow-unknown-type isn't on by default
Date:   Thu, 24 Jun 2021 21:23:42 +0200
Message-Id: <patch-04.21-ea9a5ef0920-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for the --allow-unknown-type feature
added in 39e4ae38804 (cat-file: teach cat-file a
'--allow-unknown-type' option, 2015-05-03). We should check that
--allow-unknown-type isn't on by default.

Before this change all the tests would succeed if --allow-unknown-type
was on by default, let's fix that by asserting that -t and -s die on a
"garbage" type without --allow-unknown-type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index b71ef94329e..dc01d7c4a9a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -347,6 +347,20 @@ bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
 bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
+test_expect_success 'die on broken object under -t and -s without --allow-unknown-type' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file -t $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual &&
+
+	test_must_fail git cat-file -s $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
@@ -363,6 +377,21 @@ bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
 bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
+test_expect_success 'die on broken object with large type under -t and -s without --allow-unknown-type' '
+	cat >err.expect <<-EOF &&
+	error: unable to unpack $bogus_sha1 header
+	fatal: git cat-file: could not get object info
+	EOF
+
+	test_must_fail git cat-file -t $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual &&
+
+	test_must_fail git cat-file -s $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_expect_success "Type of broken object is correct when type is large" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
-- 
2.32.0.606.g2e440ee2c94

