Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D26C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9093E60BD3
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhG0VVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhG0VVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59585C061A12
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:45 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y4so709652ilp.0
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=osYhzOfL/Q1CCniRYR/PN9zkDjw5WSpuGU67to6sB8E=;
        b=ukkDp62uoZ0h9gVu6zkh0ApUxyXMfyQleXkBAN9gicTlKkom8FVsT5CVzygf2S5zO4
         42JwlSS1+4FoBvhpPWZ55BtOT5gQ6qdNOOTTxCJ+73W8mfygmI10gX0lnULQEn4KeDud
         AvGayapFFLoi+8R95hahw/JVb5Gh0+ouKo6CUrhr8RLWxV+GE0vCsj8HLrOKOhl0WH0x
         e0Wws97jgrRWxY1yRgHX31KxgY1+9rucoco8Xrq3fiZtq73jkLaF4Nq4avMA7o0nuYpA
         xfqoKuPYX6CaAfoQ+nhv7YYdJis670zBDFX7s5WzyDA/CXUQMtt6BYrb4o0I9Em9RyOC
         n2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=osYhzOfL/Q1CCniRYR/PN9zkDjw5WSpuGU67to6sB8E=;
        b=Wxag0PdBl/K9KxjtPZJJ8oUEy3yv9Vgpy4IqOJdvrB2Sd1xXL0Z9DA+sKceKp6yelN
         c7c7aYJupwG09HW2TwQL7l/JwmvohhgFBnhKxiO2F1NN5ISFksiQ2PqcLiGsrgKU8q6B
         X6fKUtnB0GVJIeucUUa9KzPGf302/q5RqzvW0bWmeP+MZRqtvh4BDDmzR3w0XWinhOp5
         rZsNU3EXvTVaVWZVt56GZDFzozcEP+N2ybtnVZGg8MVK3e+6daiFiByGdu2ENKZT/wQG
         RFE6Fi//heqgGGhV+ifi704pmx39Jw3yZbmdyEKkvvrZ+IwN7jWZpNw6tjKXb1llYrUV
         Jg9w==
X-Gm-Message-State: AOAM531qyFyliff+x9RYce8zbVKuRoPyvQX+Z/m/AEzDwr28HmCOVsxa
        gDM1HjASbnBeXNlJveDBGV6QlEW8eA7juEEZ
X-Google-Smtp-Source: ABdhPJzdDracU8qutnxmUdw6vDs0leDVst6K195FlRQqHt3mWh7aT292oOUWw0sdhT+gohzyAOG6kA==
X-Received: by 2002:a05:6e02:1947:: with SMTP id x7mr18745812ilu.85.1627420784703;
        Tue, 27 Jul 2021 14:19:44 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id o13sm2557317ilq.58.2021.07.27.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:44 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 08/25] midx: close linked MIDXs, avoid leaking memory
Message-ID: <114773d9cdc1e83992afe8c007477940ee8ba03a.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository has at least one alternate, the MIDX belonging to each
alternate is accessed through the `next` pointer on the main object
store's copy of the MIDX. close_midx() didn't bother to close any
of the linked MIDXs. It likewise didn't free the memory pointed to by
`m`, leaving uninitialized bytes with live pointers to them left around
in the heap.

Clean this up by closing linked MIDXs, and freeing up the memory pointed
to by each of them. When callers call close_midx(), then they can
discard the entire linked list of MIDXs and set their pointer to the
head of that list to NULL.

This isn't strictly required for the upcoming patches, but it makes it
much more difficult (though still possible, for e.g., by calling
`close_midx(m->next)` which leaves `m->next` pointing at uninitialized
bytes) to have pointers to uninitialized memory.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/midx.c b/midx.c
index 8956492b9c..18e1949613 100644
--- a/midx.c
+++ b/midx.c
@@ -195,6 +195,8 @@ void close_midx(struct multi_pack_index *m)
 	if (!m)
 		return;
 
+	close_midx(m->next);
+
 	munmap((unsigned char *)m->data, m->data_len);
 
 	for (i = 0; i < m->num_packs; i++) {
@@ -203,6 +205,7 @@ void close_midx(struct multi_pack_index *m)
 	}
 	FREE_AND_NULL(m->packs);
 	FREE_AND_NULL(m->pack_names);
+	free(m);
 }
 
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
-- 
2.31.1.163.ga65ce7f831

