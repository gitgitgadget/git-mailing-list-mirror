Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C9EB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbjFOCyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjFOCyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:54:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E522226B0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f7b641f54cso1092096e87.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797637; x=1689389637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saNHXBs3nv1StVWETe8Xt7DS62AovQzrX2XVG5hfY4o=;
        b=MI0ZleYj6w8Tx5EA/9/3DW/Wd7QRrXtvSjPQyOLUS2kvRhDdVO6rfUopgfkUpRuKSe
         57ZgndMbL4ecdG5u5PxGWciZx1RWDpHTtD3ECrcNnQmQTyjgmu9wiodsrwjtVhKIhOi2
         2Mhev9EcDUn+SkYKo67BtNkQNXGCm4bvOxqJO6GGVI8flqlKMcqjDSQHyZeA5dm5XYyu
         RFW0ew12/Lojj8/q5+fqx+iUZVZ7hIoLHoWbjZyAcEAsLgIaog7g3v5cugzuc8faPeMA
         R8lQl/XnoR1kI71Lj3BnsmWPD/vMz/xhu1flPsccSkFd0t7oOqRYdSmnwb3dQaq+iNHD
         kgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797637; x=1689389637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saNHXBs3nv1StVWETe8Xt7DS62AovQzrX2XVG5hfY4o=;
        b=Kn1lUu9wa3gMoSX3pr7lKJ3NZfxv44zgDKJcy0cVnRq1zHbt5s0H/60Nfqt3Vf/+vr
         Qk91SNWLcCW76eoWrKgH8NDaiW8A1VI50ek303mr96uSXF8jyqhTbh0vgHzKxHXye4u8
         E1VYfbg4dRSnoAAIPciiUbZ0mOfhPUjCPyyCIFoT1UDR6SBFf1N2dnZ1amOnmQeZuvG5
         K4nengiquKzguEzG6DGqA2QcfJf8fPfdhFENzOPI0chmV4Xu5eA3pK7XlaAMbqRdQYOs
         xE4GW4GoB9lkCzUGEcjT8G1DVw2sCATn7lRE2BEi7DE5C17vdcc6SERW68Vkn9lwtyjM
         G1XA==
X-Gm-Message-State: AC+VfDw8FUNa2GpEBbwZq9lJAN2ubWAzQbBXGAn7CttTmKRqpbvknCPa
        SZ1qJBuG8x8JZzpHm10d+qPPJrI+nk4=
X-Google-Smtp-Source: ACHHUZ5WtSWpisWfNJwvCdNoiLVjkLaz2oxu+nePWz3NYCnaijAVx2PCnpjaKzvrEliy0caCGHLh5A==
X-Received: by 2002:a19:430e:0:b0:4f6:5068:3c0f with SMTP id q14-20020a19430e000000b004f650683c0fmr8486234lfa.58.1686797636725;
        Wed, 14 Jun 2023 19:53:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14-20020adfeb0e000000b0030ae53550f5sm19697801wrn.51.2023.06.14.19.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:56 -0700 (PDT)
Message-Id: <f67458a366006763cc2fc9efa2dc5591732a323f.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:48 +0000
Subject: [PATCH v4 7/9] doc: trailer.<token>.command: emphasize deprecation
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

This puts the deprecation notice up front, instead of leaving it to the
next paragraph.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 97dc1c8c95d..6016af5c203 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -238,13 +238,13 @@ trailer.<token>.ifmissing::
 	that option for trailers with the specified <token>.
 
 trailer.<token>.command::
+	Deprecated in favor of 'trailer.<token>.cmd'.
 	This option behaves in the same way as 'trailer.<token>.cmd', except
 	that it doesn't pass anything as argument to the specified command.
 	Instead the first occurrence of substring $ARG is replaced by the
 	<value> that would be passed as argument.
 +
-The 'trailer.<token>.command' option has been deprecated in favor of
-'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
+Note that $ARG in the user's command is
 only replaced once and that the original way of replacing $ARG is not safe.
 +
 When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
-- 
gitgitgadget

