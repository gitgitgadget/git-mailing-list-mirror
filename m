Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B274C77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjFFCIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjFFCIb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45B116
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30ae61354fbso4815691f8f.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017308; x=1688609308;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihtd9EwjiHg64SAxF3DrjNuDHzuY5uPrRcpeQk4UUSw=;
        b=Z3y7Dp+Qs9bUz7w0eerVjIORKRVLDL6U+OOKMnLxLwO4V1nRDloQMqa/3MZdGS3FJI
         JCCacSqfSX8kwkjs+9TcLHxkua820HvEwccs4HGl/EcBN2CZ5CHHhlKTzMA9RNZ/Jq5K
         biWT6nXLsDJMM1npN0PyxhPKKD/REfSIyRx4+/uh24qS7mYRyUVhcL4CFXrDm3fzmVS7
         +cLtq0s7Bb1ua+EMVtd/ngo1yD9F4z+uIaLAiaDw+FJ8EjGAC4yY3dI5LbSope5iNE6L
         JYA91pMMaRpUIG1t2BvxTBvi7UHUuJTQKSZylXeGa6eStR8oY8q4vrQ4u8gWSHeeW8HD
         4P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017308; x=1688609308;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihtd9EwjiHg64SAxF3DrjNuDHzuY5uPrRcpeQk4UUSw=;
        b=FSJWpPHXj1ghYdN8tsCrXZUcrr3DK6lKKWYkEFLmiPmrNBn8GwVPSxv3ePmMjppLqi
         F+Pjz3kxl7MKSSaPh8reF2pY0yFGhicfHccVSoVH8bB91/MhoqhOxmjA0FNLFXC5A/cc
         vUBGJ6q8zGWu7U3zfY/ocpFZ/MJxI4tblKPWx5BDimBA7gwPJ9ner5ufFs4AiEtI6BOL
         K8VLlHNB14WzrJdZcVoyy+mkSDMKN6yQd0HH9Wf4AvMiOTehdSuMXF2QlF5QZJLHvGZa
         /ADAxNVkU1gqhOP8p2fEfiZLQ8jnYHu+UWhoHCeupIHcvec7cfhTE2/I8SWKb2oHUhDE
         C1zA==
X-Gm-Message-State: AC+VfDwD0vbTyI5cXiZFGQYXzng0wVVPshl2i3X5BRi3yc1kq4RNlbns
        c7HxopSHLXRsmokDr6+KS82GCOenN6U=
X-Google-Smtp-Source: ACHHUZ4bLYxDglkLOFgwuh73qtEJ1gxf0pVnbtlCYr27akDsucOAbmMoOeUoSBsdlvIcrgBBAby4cw==
X-Received: by 2002:a5d:5088:0:b0:30a:e4f0:40f7 with SMTP id a8-20020a5d5088000000b0030ae4f040f7mr520029wrt.2.1686017307955;
        Mon, 05 Jun 2023 19:08:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4-20020a7bc044000000b003f70a7b4537sm15901098wmc.36.2023.06.05.19.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:27 -0700 (PDT)
Message-Id: <4a2a0e41e4a1ff0313ffc41d4c1683b5f7e14721.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:20 +0000
Subject: [PATCH v3 5/9] doc: trailer: remove redundant phrasing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The phrase "many rules" gets essentially repeated again with "many other
rules", so remove this repetition.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 011ed0c3590..d1d3e50bde7 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -71,9 +71,8 @@ inside or after the value. The value may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
 the "folding" in RFC 822.
 
-Note that 'trailers' do not follow and are not intended to follow many
-rules for RFC 822 headers. For example they do not follow
-the encoding rules and probably many other rules.
+Note that trailers do not follow (nor are they intended to follow) many of the
+rules for RFC 822 headers. For example they do not follow the encoding rule.
 
 OPTIONS
 -------
-- 
gitgitgadget

