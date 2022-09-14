Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1462C6FA82
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 23:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiINXy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 19:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiINXyz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 19:54:55 -0400
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E87917068
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 16:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1663199687; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lkWpflOQrItS2yhOYP2a27K2pEaFIJJWuYSU2Q8IAbnkx7dsT70ja/knuSbH88CJkbWXX2SQ18h9C/ELZC97aEX1d8oEE/pGavv2LWcyZ5JxwjUmruj36iTC4IphcEbB8C4XI0vojgQAXGJzK1e06MkNZ02A/NTyJjjDmvfC1QY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1663199687; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Ye2Z9e86adffDxoO1iSA7amA6CUKfJR55V6yRtX7ISQ=; 
        b=Hc6hvutrPOrF9THeAVzxofRvkRshEFYtJKQNUxXJWH4WrNBml9CIEeCF1XOCQUNQ7+N3cngTvvyeTpcBnktl6lPMKOykgCKxf35QTw11PK8B0Ga5YJB/8FrQElzGfdZWmI4AW23U+6JmZh0WkhPDY0tIILOGufuT0M1qadjyKGI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1663199686163425.80595711399735; Wed, 14 Sep 2022 16:54:46 -0700 (PDT)
Date:   Wed, 14 Sep 2022 16:54:46 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "git" <git@vger.kernel.org>
Cc:     "hanwen" <hanwen@google.com>, "Junio C Hamano" <gitster@pobox.com>
Message-ID: <1833e6d2e00.103444050857631.1873200534809982162@elijahpepe.com>
In-Reply-To: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
References: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
Subject: [PATCH] reftable: use const with the pq_entry param
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Conners <business@elijahpepe.com>
---
 reftable/pq.c | 2 +-
 reftable/pq.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index 156f78a064..dcefeb793a 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -71,7 +71,7 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 	return e;
 }
 
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry *e)
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
 {
 	int i = 0;
 
diff --git a/reftable/pq.h b/reftable/pq.h
index e5e9234baf..e85bac9b52 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -26,7 +26,7 @@ struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
 int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
 void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry *e);
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
 int pq_less(struct pq_entry *a, struct pq_entry *b);
 
-- 
2.29.2.windows.2



