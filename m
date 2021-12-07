Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC797C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhLGNl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhLGNl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAEFC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a18so29584486wrn.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AX7AELtrhtiyAKC6KZCsWLD4t7wORrZE9iy7m31WOdQ=;
        b=lPhUSxhxwC4vs6bNXgGREnmdh54IijWfFxG9BzzsmUSLPIfKVT564IVbTotAZOPpxB
         N+i+p+S0jRORPgDM+1DFvSLvpb74ZNlgBPSjUmEBCKlTpoTAXlSBKyJwhcEe9UnQ/3P2
         NOvIj/3oT2eV8yQOE+EKsqKY19bu4RDhqU2z3m3xhnHgemrJeyGboMf5Ck3H0ipq3Wme
         edOEAQ70vRbVROXKA2Ya622aXgJ9rB1cJzEjsZERt1TAz7JdbCMpCRfpMlaxXg86Gn1p
         eVXPkfO0ilFY0Tu8q7C2N0ScD0muXg/v4QtIpAqyLgjP6mPE0Ye5NKxZjI0b+O1Zc1D5
         H5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AX7AELtrhtiyAKC6KZCsWLD4t7wORrZE9iy7m31WOdQ=;
        b=iAwIiiUnt5Kul/rkxqa7jumSWYhAMMdkyRDPh40dsTyWNhLqsvGPK/VGPY+Gr9G/mY
         op7d8CdNug6xDSoBgWmNXd2skXHCj7FuX7S+F/ASaXYl2MIOCN1/Qcz7UBML/WTFbLIG
         tnG3C0FpaCHahsmXfpczbfybsjwNs/qyuqjeFsOVJ82GYloZi6UY+HkWod9ArjWvZlN+
         HCPh18ttCZHQ7ivFgbKisxcFEpNCWpcBhNIT8vcYV3UArOYsDYi3BxT2HOTNfSPtZlW5
         yiPjuQeegRjugK+MBusfq0EdAkBttKS2PzlupIITlezDgd0vvgQ3Afp6ue3IrjZI1jR6
         BvNw==
X-Gm-Message-State: AOAM533tcYcG+W8x+hepXrjScwNAlHUWm/+FITKbMUVAkPyhPTvN7Uxr
        u5o+vGyf7vH+3ASsbmhjY6P29O7PhqU=
X-Google-Smtp-Source: ABdhPJyfu5kTtTG+0weoD4xeZc4glGDpEWy5QCb0i/1DwND1/eABjS4Mho46Kvu2b5bK1lNFVDSjiA==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr50609083wry.415.1638884304194;
        Tue, 07 Dec 2021 05:38:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm18265506wrb.75.2021.12.07.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:23 -0800 (PST)
Message-Id: <dcd4e9f5f26a9c3df8151a24e5c703f72641c8e3.1638884300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:15 +0000
Subject: [PATCH v4 3/8] test-ref-store: plug memory leak in cmd_delete_refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index abb0ba101ae..8fee3cfce1a 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -138,11 +138,14 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
 	const char *msg = *argv++;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
+	int result;
 
 	while (*argv)
 		string_list_append(&refnames, *argv++);
 
-	return refs_delete_refs(refs, msg, &refnames, flags);
+	result = refs_delete_refs(refs, msg, &refnames, flags);
+	string_list_clear(&refnames, 0);
+	return result;
 }
 
 static int cmd_rename_ref(struct ref_store *refs, const char **argv)
-- 
gitgitgadget

