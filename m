Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00523C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGKLnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiGKLmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:42:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF05A219A
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so452800wrv.4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GljN58UmSWv9ZCZ3wcziFOnC3XNhg25DsEjzL8nO6nM=;
        b=alxvCqO65fE5RQAXVA44uLVftVGyKJ9wzjkNhvOZS3GTok/FBEzsgyvkdIOEK9YvNM
         9sQkqVE+CnCgF8iLdrpxj2N5oQl8NGjdybG6JszgjvDnKU6JoS0oK18/iJUMnWNtoTq3
         /Cy+xfafrquQVbbxC6dMcNHzU856i3kFgh8zuHXYAMRHvs81nNMrj43OMgb0roOoaeLb
         VGPzX3OrftpNWoeP5V7B1HT5u345lKxHDd/aX8BQgn+rlvoaY3pvV8LNEAVqszkWFvi9
         19yOVZ7WhNEXDA1RgZxcmtHAqkLHImprlmlT9nCC52NyOFJLT87hHa+JD4rYzzgj0w1J
         QpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GljN58UmSWv9ZCZ3wcziFOnC3XNhg25DsEjzL8nO6nM=;
        b=WMNtwPIBD/RJV/TlRJ2DnWRzu7MNML/5GMvE5wLS1A7KFuMaLxbZsja83t06CqbQXq
         k842h+P4zxbil0MrDy1DR+j2ZqKal3j+gKVoKqAv80T4gX9sLvuM679IAjDYi1MeJLZv
         RJM3GWwXUr2DU+hZaJnchgkL+yBnUVhzBngxp9W/HkjhyP1tC/tzbXT5JDwMZ1FkcESH
         X4/fCCcOqWA+nR/tucM5LAn+9oLYLty7WIp/U2xbtoavSPArcu25J/swelb9pIwR3iaC
         UduL0A2Nl2PLElkB9/h9s1XA6NxldnV2kslY+cuszesxJvESZ1qEbW4l+hx27io6cM8n
         VWlQ==
X-Gm-Message-State: AJIora+vdLfTyvs4HCMPIxexu2NvzI179fehqdpJNCcUFt6m+gjGBfgy
        Bst615N9Vkm8UbyNDfDMj594YnLy01QyEQ==
X-Google-Smtp-Source: AGRyM1tB5l+IXRCVDiMHgWKd4w933tCWCAJzt4MH3GiQ1KcNxvg/iplLQnlOUVy1Gy+3dRbY0Klj6Q==
X-Received: by 2002:a5d:4807:0:b0:21d:925b:d867 with SMTP id l7-20020a5d4807000000b0021d925bd867mr15430451wrq.354.1657539464148;
        Mon, 11 Jul 2022 04:37:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0021d819c8f6dsm5562463wrr.39.2022.07.11.04.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:37:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/4] .clang-format: don't indent "goto" labels
Date:   Mon, 11 Jul 2022 13:37:28 +0200
Message-Id: <RFC-patch-4.4-e3a95c62bda-20220711T110019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net> <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change is a slightly mixed bag, we have a lot of "goto" labels
that are indented by exactly one space.

Before & after this change running "make style-all-diff-apply" will
yield:

	509 files changed, 13042 insertions(+), 12745 deletions(-)
	510 files changed, 13039 insertions(+), 12742 deletions(-)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .clang-format | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.clang-format b/.clang-format
index 5a106d959be..56d7e8f9def 100644
--- a/.clang-format
+++ b/.clang-format
@@ -148,6 +148,9 @@ SpacesInSquareBrackets: false
 # clang-format 12.
 BitFieldColonSpacing: None
 
+# Do not indent "goto" labels, they should be flushed left.
+IndentGotoLabels: false
+
 # Insert a space after '{' and before '}' in struct initializers
 Cpp11BracedListStyle: false
 
-- 
2.37.0.913.g189dca38629

