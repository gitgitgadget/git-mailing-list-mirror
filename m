Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC941C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FBD61A50
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353301AbhJAKGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353235AbhJAKGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E146C06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u18so14617334wrg.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9tEkhINn7Ua/VjxkmDpw5wJZK+Z/dD2CWTL/hR0YrGA=;
        b=NWhrEllfuOBqaxQ6WeB08rnJELfRLBlYYr6h1zw1JNCAEoOFiix2Ma8PWb9NON3bhH
         DYRXIBnq0A0yHj8I65Hw8v6s5i2L+geX0bEuWFEN+uYRivW90gZMPSACuHLVIb3GiOZK
         f6vBmSU86j+d7bWTo/D3DrSNgP22T25mW5R4JpcjPYFWluHyx2NXyXKvG/kxyOqIq7lI
         SxaXH9uyNkkdHtVm+Q3pJlLxgKB0pDJU4k0HkyPYBnlD1RZfnXGsxzZzjYmGqxca2yQL
         rUeBpFZMerdEhWJEAUHqdvMfRaFYgwxYMmWjecLkw0BmFsH4F03iLH7saf3rc8A27zi9
         z6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9tEkhINn7Ua/VjxkmDpw5wJZK+Z/dD2CWTL/hR0YrGA=;
        b=FpZGTaJj9P0bfp8Ev7Vt+agy/EYv3N50WLfHEz2mcB+OGiM4kCwcHPPL1i7/+0ysUQ
         Qf/EFfWGC18oCBInhlTKRv/RwjtXuV6tjQLgA0scuGLLUt/cki5DET3yFNHgz8/+OZNN
         wl/lvDfZ6MVV/cPOdmMAUOrIvPzy1KvaUgYKOx4LKNIK6N59hUbxr/1rpmfi4jSjOaWy
         1wIyMGxLnBLyr9uSQyziHszvpkGvz7RhC7E87R+H5IjfVpG0bzu6fpAVefBweoCm18bT
         XQLT+xLvie/ltdPdspCL7qsC59gRaweLnUgxHyqkRDMrK6FmhJrKnUEVt+ldAb5m3Csl
         N/iA==
X-Gm-Message-State: AOAM531ZlZX5n+Yviphr0xPInt2kBYWDVve8jI8AmV3r5ivtP2/Pjm9z
        kklLgWxhil1DDMr8y0hADto7yImAO+U=
X-Google-Smtp-Source: ABdhPJx8TcrdT5sNiYYslx194lQuZHHNQjv+cVEiXakMc68kfcUdBOcZ6Qn6Y6m5oyTrFeNl4nFCkQ==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr11173290wrd.31.1633082706079;
        Fri, 01 Oct 2021 03:05:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i92sm5232362wri.28.2021.10.01.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:05 -0700 (PDT)
Message-Id: <28872cbca687b057663a4e3408cb94d69fb60f94.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:54 +0000
Subject: [PATCH 03/11] reset_head(): don't run checkout hook if there is an
 error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The hook should only be run if the worktree and refs were successfully
updated.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index fc4dae3fd2d..5abb1a5683e 100644
--- a/reset.c
+++ b/reset.c
@@ -125,7 +125,7 @@ reset_head_refs:
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
 	}
-	if (run_hook)
+	if (!ret && run_hook)
 		run_hook_le(NULL, "post-checkout",
 			    oid_to_hex(orig ? orig : null_oid()),
 			    oid_to_hex(oid), "1", NULL);
-- 
gitgitgadget

