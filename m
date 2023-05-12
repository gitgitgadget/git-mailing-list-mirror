Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34AC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbjELHFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbjELHFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:05:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9E100FB
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3075e802738so8647428f8f.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875096; x=1686467096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1XCD6kbwxSOo4fHvPtSX0C1hnDuj/3E6NFDkAQt6x8=;
        b=BQ/J40wp/O7lplbHgXWLPlMqsnsR9m8v92lwOUM9CGWtfwxXE+VbcEtjPMZBjgOHw/
         yr6aeQuuUNTWJEqRqqqiZAFs35zlegpWy/39WWA8uXNo6vZDoAELXia/amHvh3crmnt5
         btzsYw1uSjj6NjwbVu2exo8tAC+tHETXsUjDZciNq4I2YlYzRj+Pk3fdXazQVktc6qMH
         sv8rM3DhWVc1gOej8WMlO0p7zwm6h516JtHz8O+BneWCUz+r5fW9Kc//Y2m997dG2fKA
         /en7Dxte4VwKHhcZAIgAyWuk/xTmKajqNp3yU4z3axxeymR4IVN7QutWa3bPOJSXUORS
         FeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875096; x=1686467096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1XCD6kbwxSOo4fHvPtSX0C1hnDuj/3E6NFDkAQt6x8=;
        b=O2HG34xzNC7vO5k5SABzR0zI52HZWZ9QV3Ztbj6s1sFhwLZHKfrT09up886OdhLBDR
         udin7Vl8bDLlCkMIUzyK9C5ADji1mW8ecGtQmpGsZuYMkAdae5swTdvqPw8ulDZuyoMR
         RXstn3UrhF6e5Z+Kv93Q0fWfXkxUQXJEz1MQ338j6qQNs4DxwWNKtF4Fc7Mfhvf/LdIY
         UtXXz98OJQTbHnkx5tkziTRu+p/10y/5XBmxbFAIC80gMYQ/mwzGCePz+yQzFYfs/hdj
         1yQXZ1tBg/oAruIU6mvQwiLiC1880hdzpHCcSrfCNxKboBOlQ50cSQDC1s1C+pdNxUJK
         W9pw==
X-Gm-Message-State: AC+VfDxQ8r2gI0e5qYq88XUMQ0aWrL15zeShhIlv6tY7Xk5ovFPBPpJg
        QHMdLJYGEfJwHMF2kpi1pua/7ms5gkk=
X-Google-Smtp-Source: ACHHUZ6uc9FlzPTeE/MN66y0ajPLv9cJGUdfcmnlHzmc000EQQC/mEF/3eju4j9rp/Jt/5pFSvZ0cw==
X-Received: by 2002:adf:dd02:0:b0:2f9:9911:93d1 with SMTP id a2-20020adfdd02000000b002f9991193d1mr18338143wrm.24.1683875095803;
        Fri, 12 May 2023 00:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11-20020adff5cb000000b0030649242b72sm22491100wrp.113.2023.05.12.00.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:55 -0700 (PDT)
Message-Id: <e0bfeb985562197f1f96b8735e8a15f9ae7a0b39.1683875072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:26 +0000
Subject: [PATCH v2 25/27] khash: name the structs that khash declares
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

khash.h lets you instantiate custom hash types that map between two
types. These are defined as a struct, as you might expect, and khash
typedef's that to kh_foo_t. But it declares the struct anonymously,
which doesn't give a name to the struct type itself; there is no
"struct kh_foo". This has two small downsides:

  - when using khash, we declare "kh_foo_t *the_foo".  This is
    unlike our usual naming style, which is "struct kh_foo *the_foo".

  - you can't forward-declare a typedef of an unnamed struct type in
    C. So we might do something like this in a header file:

        struct kh_foo;
        struct bar {
                struct kh_foo *the_foo;
        };

    to avoid having to include the header that defines the real
    kh_foo. But that doesn't work with the typedef'd name. Without the
    "struct" keyword, the compiler doesn't know we mean that kh_foo is
    a type.

So let's always give khash structs the name that matches our
conventions ("struct kh_foo" to match "kh_foo_t"). We'll keep doing
the typedef to retain compatibility with existing callers.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 khash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/khash.h b/khash.h
index 56241e6a5c9..a0a08dad8b7 100644
--- a/khash.h
+++ b/khash.h
@@ -62,7 +62,7 @@ static inline khint_t __ac_X31_hash_string(const char *s)
 static const double __ac_HASH_UPPER = 0.77;
 
 #define __KHASH_TYPE(name, khkey_t, khval_t) \
-	typedef struct { \
+	typedef struct kh_##name { \
 		khint_t n_buckets, size, n_occupied, upper_bound; \
 		khint32_t *flags; \
 		khkey_t *keys; \
-- 
gitgitgadget

