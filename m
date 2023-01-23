Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E56C54E94
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjAWPWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjAWPW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E629E0B
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t5so11168505wrq.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNFrRUzAOuNSF8t1leDfh9Tj6xawIPV4QkdV6yQMg+U=;
        b=aHTcAUqo5ES01/XNA2DdU9UAhqDCKo4JpVOR2vPXZ1HGqcsB8puXYCbdVANyM9gD38
         lBBhsMGDLot2lYDIcsSb+Lstwm45YLDNx1wcrq814NpHS/lPddGhw6AieAkrNp1+U09t
         QEQyPJZeg6sY87thsidS5+mMWz5oLHaKvvbiOSAWsNhMabUvhZz4rgcgPimn1/g0UDQ9
         JLJJUwu37NxnOKzKZSW/Dip2GULPO7Y7LGYldE8ikZlXY8uETlrtJiiBTMqCi6w3UKpm
         SKrQBxqrsx3IppGUCbVy/n6iFH7YIe1+7laWesTqz9LXdnfRRYhTiha3XXl+y8KnSGWc
         O5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNFrRUzAOuNSF8t1leDfh9Tj6xawIPV4QkdV6yQMg+U=;
        b=vO6d9kl5Iyf6A4jJQwTdn6gwR2zt7+XZgDCaRcGe3ufQnRUAUsZIBzmmFOoXO6Std7
         x6bEDTbBkneFECQuywq3PrMjovpRomytuLmVhjzXXT5whvqR8q+/j5T6HJ5RkKVsHR/+
         Qm8NfI5xwK7WClPHkOj4spqvj7xKMyJp9NJ9kiqQt3oQojAFxZ6dStAJ23RocNxOJRy/
         tlW5h9tenSc+tfGTnGRN0MgGllAu2NTpRZMyqs6rgm6DOa3/BWLEir+BFXioCPZAHvhB
         9kzlWpWYC/wCmBw4ZSRwdkvj2ilGHww7qORLrZyokDVGKLbXz3pMEQMmuok3mTQAJ6YI
         TRug==
X-Gm-Message-State: AFqh2kpxDZRNa2MemaRFps2DdHPPMoXJ9nYw/StsSYfi8elatqSAxb9F
        wEVzCF07xOBUl1E97w2wpHaxXCDawHM=
X-Google-Smtp-Source: AMrXdXt8NkK7rXYg1/Dis30TLiMUJzptDsMdVi6bfW+C4Zh0L5DfsWy+dd6oo9lxl/mIWd5JsydCAg==
X-Received: by 2002:adf:ee8d:0:b0:2bf:95cc:744f with SMTP id b13-20020adfee8d000000b002bf95cc744fmr10235251wro.56.1674487318412;
        Mon, 23 Jan 2023 07:21:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b002a01e64f7a1sm19113789wrb.88.2023.01.23.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:58 -0800 (PST)
Message-Id: <d491070efedffa95e9bf7d8f18d7707d43776488.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:47 +0000
Subject: [PATCH v2 07/10] bundle-uri: drop bundle.flag from design doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The Implementation Plan section lists a 'bundle.flag' option that is not
documented anywhere else. What is documented elsewhere in the document
and implemented by previous changes is the 'bundle.heuristic' config
key. For now, a heuristic is required to indicate that a bundle list is
organized for use during 'git fetch', and it is also sufficient for all
existing designs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/technical/bundle-uri.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
index b78d01d9adf..91d3a13e327 100644
--- a/Documentation/technical/bundle-uri.txt
+++ b/Documentation/technical/bundle-uri.txt
@@ -479,14 +479,14 @@ outline for submitting these features:
    (This choice is an opt-in via a config option and a command-line
    option.)
 
-4. Allow the client to understand the `bundle.flag=forFetch` configuration
+4. Allow the client to understand the `bundle.heuristic` configuration key
    and the `bundle.<id>.creationToken` heuristic. When `git clone`
-   discovers a bundle URI with `bundle.flag=forFetch`, it configures the
-   client repository to check that bundle URI during later `git fetch <remote>`
+   discovers a bundle URI with `bundle.heuristic`, it configures the client
+   repository to check that bundle URI during later `git fetch <remote>`
    commands.
 
 5. Allow clients to discover bundle URIs during `git fetch` and configure
-   a bundle URI for later fetches if `bundle.flag=forFetch`.
+   a bundle URI for later fetches if `bundle.heuristic` is set.
 
 6. Implement the "inspect headers" heuristic to reduce data downloads when
    the `bundle.<id>.creationToken` heuristic is not available.
-- 
gitgitgadget

