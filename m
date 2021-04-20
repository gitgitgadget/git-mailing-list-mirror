Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C11EC43461
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEE0613CE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhDTNBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhDTNBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47EC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so10295569wmh.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fphz+EEOAxgTJJQhjqmvF+GFQzeosXj3NtJlzYmx64=;
        b=a30QKG2V7+tyg3fssAsW0DtE8+8ybzu0EJcXhHgaqYkGzyBYaaSlBD+rgsTfJbCGVk
         vkxL/o5nEDJnFpFp8Xc/5DL+3FCvautw7muyhOVVhmLMQSjO9FZ8S0Wz8o8aht+PAOhw
         aP3zxvoF7acOdmrANS2KVeS5X+2i8YRzRU+R/dtFEH6otP8GqT0nf8O1SfkaBZripmAl
         2gZGooXVzTEtb+0X0n+XkZpBTCMID3MpetU4fKhCKj2mohUf5XIdbH/oOCQAkJKsMUH+
         OyLPEyQgKhwBvp2f7EFjwn9ctB0bRCnpR1EZ9PXlzv02TPw5ADNjxrG6TrMZDFcS9RW5
         Sdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fphz+EEOAxgTJJQhjqmvF+GFQzeosXj3NtJlzYmx64=;
        b=FQvTqrGAaKpV7n7nXrjxsKaSAD9/JIdNdJec2S/US9y8K/bEk2bQhQS+s0olr4Ktvx
         YMf7um8KptY+jEUNPvKLcv4XCxyWg2wYBwCuXYNdOlmIZU6ndzgYgdicKL9Sot0/aL5J
         s6Vqpzftt+74GXdt3uBpamZI+mzUOf9B3FOPcG0YnacpVeJ8T3C7BTMpkPT+6sC7gA3t
         mhjCTil9RWekB+ugWKos4q9zJvuvnlFALNhtCdHcUKRmqit82IbuyV8GYfZBeTpw8gZl
         62fBQA5i8yOEL3zk9n4mIA2+ymddJJPE573UkmIF1ypyVaC6LmFS2stlgvPxDjmwOgdn
         STLA==
X-Gm-Message-State: AOAM5324jIGXJjTMhPTpPNtq1oYrEa2EHrWuWWPU3yaZrMYrKBw9D72O
        Xdl9vr1BXN1IBsaiiCBe9V8hFqtJkzSNKQ==
X-Google-Smtp-Source: ABdhPJyM+wUpmhK1XUIe/xhrHLqjoUr6aiKrvFLBloZDkBHhNip4FpO+rLk125pEQjfhaGuVEtpCdw==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr4561272wml.28.1618923632409;
        Tue, 20 Apr 2021 06:00:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] object-name.c: make dependency on object_type order more obvious
Date:   Tue, 20 Apr 2021 15:00:11 +0200
Message-Id: <patch-05.10-a607239b56-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an assert to make it more obvious that we were effectively
hardcoding OBJ_TAG in sort_ambiguous() as "4".

I wrote this code in 5cc044e0257 (get_short_oid: sort ambiguous
objects by type, then SHA-1, 2018-05-10), there was already a comment
about this magic, but let's make sure that someone doing a potential
reordering of "enum object_type" in the future would notice it
breaking this function (and probably a bunch of other things...).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index 4d7f0c66cf..b6a7328b7a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -408,6 +408,8 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
 	enum object_type b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	enum object_type a_type_sort;
 	enum object_type b_type_sort;
+	const enum object_type tag_type_offs = OBJ_TAG - OBJ_NONE;
+	assert(tag_type_offs == 4);
 
 	/*
 	 * Sorts by hash within the same object type, just as
@@ -425,8 +427,8 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
 	 * cleverly) do that with modulus, since the enum assigns 1 to
 	 * commit, so tag becomes 0.
 	 */
-	a_type_sort = a_type % 4;
-	b_type_sort = b_type % 4;
+	a_type_sort = a_type % tag_type_offs;
+	b_type_sort = b_type % tag_type_offs;
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
-- 
2.31.1.723.ga5d7868e4a

