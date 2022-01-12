Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0673C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356008AbiALSIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355991AbiALSHz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:07:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF7C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:07:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so3952715wmo.5
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W5Yj2jthDENAX/pjHPe/3jF4bTw09ifuA6lPu72S2Y4=;
        b=lJ7b3bBv3b3uG3BqchnoNyGMYXOjb4U73VFWyZtFG9MW4R3tl1bESKi03XI+ZNK/sn
         Aly5pZgJFwNp8e8YkyBdDZrrZCyIu6lIKhmh+m5vYkAAc8Qr43Z2Hw69MNB5ngPs3Y6q
         2mdfc+2XzOHGEq1eocsqdUnjFOL4eYb3wGgVr2iMLgp7A6+wbKXNA7T38wQxekbbO7jI
         3m5awcZ+63t/l3FMg9SbU8ia4m17v6pA8XYfvFhesmyqTO2Kbx5V0qqJCAdLeqlsvxr0
         DIAIb9gs9ipB+teL+574EsVCN5w2S7eZw4T47U2r+Q5RcMGEEXaeYp/lJByCDxA/bwtO
         FwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W5Yj2jthDENAX/pjHPe/3jF4bTw09ifuA6lPu72S2Y4=;
        b=MSqfskx1HhzCBrYxx9dARl2/cAg0BWOdk2BUkESlAUxsgXy8WfmgSZzEGVAU1wgxel
         sSyJsTD3gVflwiVdoHcDi9Y4EEIe75e+kjIF/M+sk0XZWXcVmuD9MLq7GzoAeVywubUU
         j8/FuAvVJnPp+TrYGpcX2ciuhHv0PdOGnifuUpuRdeJp9B2/06WJFz5pweyLKFJ+GfcT
         c5dYBxfysRW8LmIZztNu2U1V3ibhcCkDYFEKiGQIHXXZcNtBb5WJPcrwZS9lfNz9BmUX
         hqEKcP6l4EHVlTGp2ZgSmORGmic16hjVRblSr9OzP/rZRqJ+w6FBobes2fWd2O31ezu5
         RcUQ==
X-Gm-Message-State: AOAM532Uyukps5ZRUXPkel9gRmr9iY5SOUl1F/FoGpg7hgxwB+KcEZCQ
        goYLZRnmxjPqCHglXgUHBHC1C3gN2iQ=
X-Google-Smtp-Source: ABdhPJxfk/503VFdz24ohiRKZWUwyxj/cg2ql/h3gF/hFbCFOTz6lbcf8l8TT6YNeTo/KwWQB60lFQ==
X-Received: by 2002:a05:600c:19d4:: with SMTP id u20mr590973wmq.138.1642010873870;
        Wed, 12 Jan 2022 10:07:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13sm385834wmh.45.2022.01.12.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:07:52 -0800 (PST)
Message-Id: <2d2e1177ff7c15f9a026ebe1e1be17791d9930f0.1642010868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 18:07:42 +0000
Subject: [PATCH 1/7] Documentation: object_id_len goes up to 31
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The value is stored in a 5-bit field, so we can't support more without
a format version upgrade.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index d7c3b645cfb..6a67cc4174f 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -443,7 +443,7 @@ Obj block format
 Object blocks are optional. Writers may choose to omit object blocks,
 especially if readers will not use the object name to ref mapping.
 
-Object blocks use unique, abbreviated 2-32 object name keys, mapping to
+Object blocks use unique, abbreviated 2-31 byte object name keys, mapping to
 ref blocks containing references pointing to that object directly, or as
 the peeled value of an annotated tag. Like ref blocks, object blocks use
 the file's standard block size. The abbreviation length is available in
-- 
gitgitgadget

