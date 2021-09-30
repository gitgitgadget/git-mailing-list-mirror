Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19476C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F0C617E4
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbhI3Fm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 01:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348123AbhI3Fm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 01:42:28 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B489FC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:46 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id jo30so2930057qvb.3
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9KkXs+6ZdbEgUMQgbBnJ+L6K4pTodfNTPiv8hZMw0Y=;
        b=avI2Cor+H1eC0lWDMkKhwxDHTArqb0jHzN/GGkOXf47dcZ1xo03iBbwiSV5fZuMcAV
         xlIY5Rg1s32leCIMytj4Smhi27Tnj/1iFIq6bIg0T+HJkXXO4YbicLQ9FJD0ulGD6FK+
         H2DFbtbUu3O9yLCL4iPp8ZEFBy1+YwDEQWg2YRfBgkV2dAOVBiZ/73lFcs+A/ktvFbdY
         ++h2BZrxlPHQtvnKUXm/77OkaYXt1RNIf0id3BKYcja7XYWJnONaXf7g6lLoZUvekLN3
         LVgG0ll0wy1WWFjWLWiGeXBbly72LGleb7ZmAmDpgZ2mQMqJ31cQlpd/ehCK6z7N1gBp
         XhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9KkXs+6ZdbEgUMQgbBnJ+L6K4pTodfNTPiv8hZMw0Y=;
        b=OMuVvd38Alf4J040AxCwIE33WR/bRgSs1B93EwOTv5DhGCtw/tDL6TF3GopMAMssj1
         HZkqqcHxu/CP3f28Aq9cOBXwd/R0Uj0/Frip1m1FKk8VIa7FoBt82HlN2IlnBJIptIVV
         G+ak0YJVKFyBIgqEeZ807jb7OoRAAIGiiy47f+aWrmpHpougAjiMJcf/vnnThPz/EumR
         POZVoKN4ZhUlrDxNs7DOALFkxXpatYzawI83Zv7JpWO+ORhQnYFuPYFNWbwFjgZgv2Zy
         jeRY5r4BErqNyDYP+Xx7vpmGRnP1uevS/CS6FXBE/ic4h58qnpT2tM7ROhD8XjVHJl8H
         SxLA==
X-Gm-Message-State: AOAM530/6qKg4j+RfNXL17MDfCUu8XNwpabmBmcrj4JqD7ZbdYA9MK/W
        Q04GjpS33UjhaWlkKmbfbkQI8P5APr56Gg==
X-Google-Smtp-Source: ABdhPJx/yH+B9KGNrOFyEXjN2C212/pzq4Bugr1UNgevyNh5mnLeU7zBGh5Tvv0BPIgPUvez2HOmfg==
X-Received: by 2002:ad4:5603:: with SMTP id ca3mr2142624qvb.11.1632980445645;
        Wed, 29 Sep 2021 22:40:45 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a2sm1006826qkk.53.2021.09.29.22.40.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Sep 2021 22:40:45 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, avarab@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/4] fixup! reftable: add a heap-based priority queue for reftable records
Date:   Wed, 29 Sep 2021 22:40:29 -0700
Message-Id: <20210930054032.16867-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210930054032.16867-1-carenas@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
 <20210930054032.16867-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

originally discussed as part of the -DNDEBUG thread[1], but still likely
to break the build with the parent variable set but not used when assert
gets compiled out.

moving to BUG or DIE still a better option otherwise, but this fixup will
at least address that specific problem (even if the function then is a
NOOP).

[1] https://lore.kernel.org/git/20210902053023.44006-4-carenas@gmail.com/

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/pq_test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/reftable/pq_test.c b/reftable/pq_test.c
index aaa86d1224..a678848743 100644
--- a/reftable/pq_test.c
+++ b/reftable/pq_test.c
@@ -17,11 +17,9 @@ license that can be found in the LICENSE file or at
 
 void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
-	int i = 0;
+	int i;
 	for (i = 1; i < pq.len; i++) {
-		int parent = (i - 1) / 2;
-
-		assert(pq_less(&pq.heap[parent], &pq.heap[i]));
+		assert(pq_less(&pq.heap[(i - 1)/2], &pq.heap[i]));
 	}
 }
 
-- 
2.33.0.955.gee03ddbf0e

