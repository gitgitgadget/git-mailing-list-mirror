Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F1C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjEPGfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjEPGey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219BB49C1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3062b101ae1so8929537f8f.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218876; x=1686810876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj76xsVjf5vl8Ms8krg5HIm0o46KWMXTgiKsmC/q57A=;
        b=Cxdtuchc9i+HKcotqgjfkUMmli57SOAMMoGh3C4CPnm1jsR2lQw2AYe/SUpCoyKfVd
         /VssBu54Ei72Tp06zEjZK0zMTKFGR1er+i7N/5fOCOVbD79IDuS9B9NcCLW4FrgU8qiC
         GGNTdUADZAjtO1sR2QICJC03HNR3CnUEAQUUb5aHaeiUfWM0zzaEJbtrw02gC+PoU0TT
         Rr8YdeChGjMWiQhO0sKuYa7aSmIpoPPuwRuqvKF2wuaAEBGDXEASSdKtv5VDvz3lFRGj
         oEHBxqYBIf51g8fxuZs4xryjK14qIpLBpEq+Ue+x7dYlkV++QtmauqXInZ2/I6HuML+V
         DjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218876; x=1686810876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj76xsVjf5vl8Ms8krg5HIm0o46KWMXTgiKsmC/q57A=;
        b=OonixqHHI/5EvqMS8lhIUTb5aWOsNq8jbq0/0wpitCeR0MVaM20QMdaiOYiDvQF+b2
         D2btbgnTpq+jbizr58HdTZdm+GrRoLXDsaPYkqBiG4gI7EdtRVoffwQ7pH3q5Ut0GHwt
         lpP2oXg/uk9D3hK1ZK2+Pb+Sb/HPd+JCmhL8AZQhte3CsD3QyTp62SrWbTMfbGhodX6f
         WHHJXkfPfOFipL3kzxWWPMX3cYyDJc1j66HNhAnjwpIBt7JLSZSo+ER9LM01sxOksP2N
         Fnpf5LjX/lUpWiivmXbWonyldndlOeM35R+NlsujA0GUFQI7aw43TwxY7QKnLw/xTuZh
         LdUA==
X-Gm-Message-State: AC+VfDxr+lcSn3tgVz8h6Xmn6Ng+Sl5qLh5EXm1n3LaYo+0/1b81IMok
        uNs6uxc2OcZ5p84KTNyFa1bUHgq4/3Y=
X-Google-Smtp-Source: ACHHUZ6+Vt1OP2XmysqGKtoASSxeghhpAk7oAzyDyUxKxZ+5aRoy8o5dnw8HK05Wq+DQ64JfM9xF8g==
X-Received: by 2002:adf:de01:0:b0:306:334a:7cd1 with SMTP id b1-20020adfde01000000b00306334a7cd1mr25931437wrm.31.1684218875838;
        Mon, 15 May 2023 23:34:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d614c000000b003062c609115sm1399949wrt.21.2023.05.15.23.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:35 -0700 (PDT)
Message-Id: <6de1eebfea65c8a66bb7270fc7fb550d25d7d3f6.1684218853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:34:05 +0000
Subject: [PATCH v3 25/28] khash: name the structs that khash declares
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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
 khash.h        | 2 +-
 object-store.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/object-store.h b/object-store.h
index 12415e5ea73..05803a03e92 100644
--- a/object-store.h
+++ b/object-store.h
@@ -164,7 +164,7 @@ struct raw_object_store {
 	 */
 	struct object_directory *odb;
 	struct object_directory **odb_tail;
-	kh_odb_path_map_t *odb_by_path;
+	struct kh_odb_path_map *odb_by_path;
 
 	int loaded_alternates;
 
-- 
gitgitgadget

