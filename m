Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEA5C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D8620671
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4oBpKHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgEROb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgEROb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 10:31:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E46C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:31:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so5273065pjh.2
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IpR68yXmU+3udBkg5GYJ4IcPPoIj0b1LrZQlkkLDr3s=;
        b=o4oBpKHskT/EVTdkWenPbamYN6CtGT+2xH0qJ1smUFlq2vWwxfWOsu/BbQINqZkTvQ
         Xkmd8x5rkrSZ7obXPq6/CFcIV0j0IWRIqQ9+4AlMrhedyKV8AdDraZQqh5wmmpesWFEI
         hjp/gMPtG+rRqxO1/whsGwQqe/ZqYHrndYl6EkbpMvWiS8U+xchR/nCZR1D17Eac/Hld
         07qi0ZWU1qZ6yChxatO1vzioY46cvbK+K+/HhleiIxtDvUZE/nqc3sGDiowbHb6m3YLM
         Xg7z3J3teHWD2vjBSS73miUK5GumRGQuodt0azgji11v+/63Zr5mqYcZluKZvXMoStcx
         Nodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpR68yXmU+3udBkg5GYJ4IcPPoIj0b1LrZQlkkLDr3s=;
        b=bA9sHRKlw9RWcriMb3PpTKI7HsdozoJDvjUvX7SXPetP3L8WdylJ0aL+uolqsvgRYK
         StjoxAtr3XeTW+PMapSKExVN2L9VbOxlkh7hMaCSZR6m8fh+kzqFSo26FXxu01bTGvWD
         TND4uX9x4mkgRWH3oj74O2JJ+/RZyejsOBsB7j/nj5UBUK5iMjACmax+v7zt5lM8WEK8
         5WdLVXcpBN9QTkrplSRNvl66IBwKSNcwiSAXpBaBwS9ZKkH61H4RPhXzu7VuNCVTLEUC
         vMg9+FOq/5cYbRZSBlrdhUVFyC3/aDGdaNIMLKiaZBzHQtO0FxHzNHYfIGuElcYk7aKl
         jDQA==
X-Gm-Message-State: AOAM532rFP5zejdXwwnz6VU9C1oKBlIUN2e5yvsFCLR7XghkuMiGtv5F
        3MyIR8vgTTB8XCWZ3ZLaQMF4brJftwk=
X-Google-Smtp-Source: ABdhPJxscH6pZbevCiDqznwHQmJYrHfn/cHu4kvwthfBKKpP6eVV47lY/cLaqxeu6iS/rbQSfWEH3w==
X-Received: by 2002:a17:90a:b10e:: with SMTP id z14mr20370084pjq.57.1589812316403;
        Mon, 18 May 2020 07:31:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:1c:9c42:c40:e2b6:f2aa:f55d])
        by smtp.gmail.com with ESMTPSA id f64sm9212287pjd.5.2020.05.18.07.31.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:31:55 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] commit-slab-decl.h: fix define guards
Date:   Mon, 18 May 2020 20:00:23 +0530
Message-Id: <20200518143023.14217-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200516172837.2872-1-abhishekkumar8222@gmail.com>
References: <20200516172837.2872-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a9f1f1f9f8 ("commit-slab.h: code split", 2018-05-19) split commit-slab
into commit-slab-decl and commit-slab-impl header files. The define
guards for commit-slab-decl still use "COMMIT_SLAB_HDR_H". Fortunately,
commit-slab-impl introduced its own macro, "COMMIT_SLAB_IMPL_H".
Otherwise, the code would have been broken by not including
commit-slab-impl.

Let's correct the define guards for commit-slab-decl to match file name.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-slab-decl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-slab-decl.h b/commit-slab-decl.h
index adc7b46c83..bfbed1516a 100644
--- a/commit-slab-decl.h
+++ b/commit-slab-decl.h
@@ -1,5 +1,5 @@
-#ifndef COMMIT_SLAB_HDR_H
-#define COMMIT_SLAB_HDR_H
+#ifndef COMMIT_SLAB_DECL_H
+#define COMMIT_SLAB_DECL_H
 
 /* allocate ~512kB at once, allowing for malloc overhead */
 #ifndef COMMIT_SLAB_SIZE
@@ -40,4 +40,4 @@ elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
 	declare_commit_slab(slabname, elemtype); \
 	declare_commit_slab_prototypes(slabname, elemtype)
 
-#endif /* COMMIT_SLAB_HDR_H */
+#endif /* COMMIT_SLAB_DECL_H */
-- 
2.26.0

