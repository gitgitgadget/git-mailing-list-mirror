Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B019EB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbjFOCyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbjFOCx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:53:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03B26B1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8c74af64fso12978915e9.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797633; x=1689389633;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue53EZBCMKFJaY0oPdIPR+2S73vx8SmmOg6dfRJBTj0=;
        b=kF6Gol6Kb7Zlmt+A4YwbyybcWNCEnZdxDH/K+MwUnP/C40Rn/yE8iduzJ5IbqmFllW
         Xp2pKiru1wNolB7I6bvlI5MCNHgItSQI3agwI4t/P6Er8ckKUmXQ6Z9/mM0bLTO7COfD
         kwbNKLw/4GWEuxWxik/ptGDP7JjdqSHbbUaK42rFB9Wr8vpQ2/qvz3td0TUuGEE9Qmob
         6ZGzrfMotbSons0XIDWTclCSR5F4p7IkGp3amcrohNzejrAVmbCsFhd6lGfORF5mawIj
         DBLGwO06GDShPSzSv8D7roh2oDI3XO+1Hj7FW8ON1dVNkux6WSlnpMaA/IfmHvlak3Z8
         YpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797633; x=1689389633;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue53EZBCMKFJaY0oPdIPR+2S73vx8SmmOg6dfRJBTj0=;
        b=SEHn05OXdhJfJpKfPo2fPJGOUdZx4KVYHbrBGkyeubNwYGa5jBE5EiPYHcQjNdvzs5
         XAxyuT/PGQQuQTKWAkWBP3s9g673/yiR36HxoPD1wStPxwwEwd1TqmNm8Gic1SB1ie/B
         G79dpBGfZghMl/CHddiT1oqlHjKNVfkjnnWVA6OPYbnqGuOnruIlRT0PvL1Tc0slhDfd
         lf4bQ7N/HhghjGBSowBSGuUw6IJL7ebLnDU0DC7wZphz0K7TaVTEtdWphKIWGe0ABejE
         UlZcKw/yiRqbF62y+agB+LqRtUVA0dDDWSIkAG20y9pZQGSF06lF7lSmwhAxNX5/5MEz
         loCw==
X-Gm-Message-State: AC+VfDwALX+7mPps5R/egWz/6Q2DI94R//xuKp+uiqa/DfsIurcRog0D
        ETIiWsOUN70tthIgJUp1WUjdAHczodM=
X-Google-Smtp-Source: ACHHUZ4Ddvyu/barebCkEmpfuAJka/DqyxakDmMBUkyPXXJ9U/JbLTUl2vdifIbk3f6c9wyxjEYduA==
X-Received: by 2002:a5d:534a:0:b0:311:112d:eaeb with SMTP id t10-20020a5d534a000000b00311112deaebmr906022wrv.33.1686797632933;
        Wed, 14 Jun 2023 19:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002ca864b807csm19708822wro.0.2023.06.14.19.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:52 -0700 (PDT)
Message-Id: <65386432ca4a8a41acdb4f061a8ca6a8f02d289b.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:43 +0000
Subject: [PATCH v4 2/9] doc: trailer: swap verb order
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

This matches the order already used in the NAME section.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 35faf837892..da8fec7d5fe 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Parse or add 'trailer' lines that look similar to RFC 822 e-mail
+Add or parse 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
-- 
gitgitgadget

