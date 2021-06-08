Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC105C47094
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B3361130
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFHCBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 22:01:16 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44882 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHCBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 22:01:15 -0400
Received: by mail-oi1-f181.google.com with SMTP id d21so20041864oic.11
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 18:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/mbvgb/dsxhUSWrZwCSZ8o/R9Fq99UwBx2TPA+jmiMw=;
        b=mSItZonuxLrbU9+yKFM29UqTs/ygA0XGA9uDuh7ZSJS/jMuPkblA6ysikpvFr0BK0G
         A82lumiBDEza6tQg/3Ow2fTHD4ScYd7NbW0N6PCbZb+bmOjPMP1MkX8RVoMaflZdciG/
         ikkQNorS0ORQanml2cpPW8jRji6dTPYSBaGW9l65It0R2Naz7tNCTaoUAAJiaNcVBLu1
         3Il++2w6jpKeX0ea8Kfnl/TWUEmScHNa1sTSLd8AdzKIZ6le5ivdZjF13UOXdEBssxYf
         GcfVMg+bZZV+u4IjMiTW/3dB/hACJAVsEworCoAfkD+VcSJAPl5FD1wGDbnaKU6wrBcn
         hwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/mbvgb/dsxhUSWrZwCSZ8o/R9Fq99UwBx2TPA+jmiMw=;
        b=P4dZSgm7ltiX8KRYpwCge/7tRMOrpJDwRjerIy1qw3jusn4aUfiwItcjX1bnAD9DZ7
         7IUeQVeR/SL6waR5jBf/vBacwwz9JC1kQzzOYfnL+/sm30FgYSeN2TkiS5ChHIg4/QFq
         YZMSHss1Z8pcoZlNCjobPf086pHV6nEi62kT9eN8cMY2b+k+iaVGE/KEelopQpFpn1/H
         02bIQhXcDBSNzdyGWPkBM3tV3IauSKYdfGTypBbFmv/nUmMIKQ+ZUeSS4/zYQ4daiptL
         n1zh8DI5GQ5X+5kAkkUfD7NyetDpaWD/1RcudPqhgJfUQvM28BSoPrUjHJct4DP7THCV
         nE9g==
X-Gm-Message-State: AOAM532SWaAtinJT8GYT60tiK2evNzupiKwSv6LKuNUuUIuO7sxlStu3
        tF0Dim2zUSwEE2fH5MOrn0aEPGfnZPeWIw==
X-Google-Smtp-Source: ABdhPJx4crL0Ph21tOmJuDclhFsgA/36YAyMumAW4yxbxoxVawrXk+FMQtJiJwPWKMT1pwwh+Di5dw==
X-Received: by 2002:aca:4244:: with SMTP id p65mr1249135oia.8.1623117490993;
        Mon, 07 Jun 2021 18:58:10 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id a6sm2571874oon.20.2021.06.07.18.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:58:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: merge: mention default of defaulttoupstream
Date:   Mon,  7 Jun 2021 20:58:07 -0500
Message-Id: <20210608015807.906101-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit a01f7f2ba0 (merge: enable defaulttoupstream by default,
2014-04-20) forgot to mention the new default in the configuration
documentation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/merge.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index cb2ed58907..6b66c83eab 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -14,7 +14,7 @@ merge.defaultToUpstream::
 	branches at the remote named by `branch.<current branch>.remote`
 	are consulted, and then they are mapped via `remote.<remote>.fetch`
 	to their corresponding remote-tracking branches, and the tips of
-	these tracking branches are merged.
+	these tracking branches are merged. Defaults to true.
 
 merge.ff::
 	By default, Git does not create an extra merge commit when merging
-- 
2.32.0.2.g41be0a4e50

