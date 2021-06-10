Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA88EC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56DD613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFJNBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:01:15 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41703 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhFJNBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:01:06 -0400
Received: by mail-wr1-f41.google.com with SMTP id o3so2209066wri.8
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=klC6VEuyKIpd+Nu14XmBSWVzuGSr27bQzhJmItD0ZHQ=;
        b=QLDa/RKHvE5+0U54+yFCuU5QKLejsBmwBSa81Uy51Z51iYRUZVyxpq8b67L32a/+MU
         9XjEsnskGp9xfV1YuYBSNXoIFELFU0wY6W0UGchK9XA1tGN2Bla4Nzrr32NC5hgjDYuy
         zDnmbqLWScsihOj17coILzIRmZXObhnnhaE/GnrCteN14r6niR1w5VgETxe+steYMdwJ
         XcH7VNz6SS9OTYF/2pzjEq6kTyqeHqDfT6L7VhqfVt+5kUnk3FhcLzsf+L+FzE2pnAZv
         GRKmKU4xrS3SHA7AZ6XYtdeDmV+/JyHA72WYq77Mv1hyOwJjJD5ruwRDoMcdc5k85rTO
         xgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=klC6VEuyKIpd+Nu14XmBSWVzuGSr27bQzhJmItD0ZHQ=;
        b=OGOM50ej8EjwPS50/on/bHUQjcJrgjZBg8U623oEBsAuKfPpmk4pYBw6ffGjHWFWwb
         ZLJNC8SWz6Q19AZqVRFTBzcDnBD7j7tIP2w5rkuMTMVyx/OM9M58zAM+nKT27R73tTnP
         gtJlTyDA8ohGedE7ESyUXbxma2AhhVVq0A0KsyeEbBfbQnM3OBc2JiloHXEIJX8uQEcy
         IUm/EGRKHQOSRxhdAhHiY2LJmO8xkCKBQbszYc80W4KEPV2OtcXucsGBQt6ujh3/ozJX
         VG/sbF07gLb7IIoyHiTnrlU1HVXGWub9Vv/75Vl0y9pS2Qf6wJHCSTD3AjY2owiYfNh0
         foWQ==
X-Gm-Message-State: AOAM532ZOeDbkSefte/WnXFP4uEKiQsOGWrXloT+YwFso2fE9mEAgoGM
        ueSfUNqpwe7a66sSowT3kt8hgy6LUJg=
X-Google-Smtp-Source: ABdhPJyBJ/4HQxwKo16C7f79gsvwE4e0+S7bNzXN66x5hP8aOLyM8aDDieMtZg/zHJx9OCHl6W7d4A==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr5098826wra.223.1623329874222;
        Thu, 10 Jun 2021 05:57:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm3927898wre.70.2021.06.10.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:53 -0700 (PDT)
Message-Id: <d86516219689e9179f3ba18c2ad2391d8ca27076.1623329869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:47 +0000
Subject: [PATCH v2 7/8] refs: clear errno return in refs_resolve_ref_unsafe()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is done in a separate commit, to pinpoint the precise cause should there be
regressions in error reporting.

This is implemented by renaming the existing logic to a static function
refs_resolve_unsafe_implicit_errno(), minimizing the code diff.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index ed2dde1c0c6d..191cbf5a330f 100644
--- a/refs.c
+++ b/refs.c
@@ -1687,10 +1687,10 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid, int *flags)
+static const char *
+refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
+				       const char *refname, int resolve_flags,
+				       struct object_id *oid, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
@@ -1779,14 +1779,24 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	return NULL;
 }
 
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    int resolve_flags, struct object_id *oid,
+				    int *flags)
+{
+	const char *result = refs_resolve_ref_unsafe_implicit_errno(
+		refs, refname, resolve_flags, oid, flags);
+	errno = 0;
+	return result;
+}
+
 const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
 					       const char *refname,
 					       int resolve_flags,
 					       struct object_id *oid,
 					       int *flags, int *failure_errno)
 {
-	const char *result = refs_resolve_ref_unsafe(refs, refname,
-						     resolve_flags, oid, flags);
+	const char *result = refs_resolve_ref_unsafe_implicit_errno(
+		refs, refname, resolve_flags, oid, flags);
 	*failure_errno = errno;
 	return result;
 }
-- 
gitgitgadget

