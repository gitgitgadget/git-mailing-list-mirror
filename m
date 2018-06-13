Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9551F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936014AbeFMXGc (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:32 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:45457 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935843AbeFMXG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:29 -0400
Received: by mail-oi0-f73.google.com with SMTP id 9-v6so2613612oin.12
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HdgaNW1cFKupuUVlcW/QW1xN2gdooq5gmG/GydcbWaw=;
        b=MvJexL9kRnLFpGN5A2vJy/Bd7/uO//jk9Ri4Xd7SuhQxPRWhZJ7UpDCs5fMf0fJxge
         KX00DYaNcbz3tteZXCc2h1F/tOohEyT1Iyg4NVsQJ2Cw6727woIO+W7iLOPqukAyt0ga
         i3cI48IsgZdUTWkrzXLvWHzDAe85pQFT4kl3My3Boul36YovyUfm/VqJOTTNY90LLaMt
         sQyGcapN+AlSV1q517Izxb0CM20uWOTT7t+xjVIdrvGxY9QQ19CbtFRUQjusY4H9JBMt
         z4xVT1cZ+hXU0yjbaJC/2Y4g6z1aZNQVmaEkj1dl7bFtLKs7x+jnprk1cYKEJJdGUejp
         tszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HdgaNW1cFKupuUVlcW/QW1xN2gdooq5gmG/GydcbWaw=;
        b=JG/DvgQmBb4z3gErINZc25Xi2uG0W2N6ndv9oxhvW1sfkF7RCsh+wUuL1Q8XvIysXe
         0pZGTBR7lgZxkxoWa/v3BGHHJEqruY7cg9Bti/l05UVAHVeclbe/uAM8B35ug4K0Ts+N
         M7Oa2PcCthMVj5ViL2vOfDaE0TafjJSMgM45VTV3e7EVaJmcIv42A2d770dWk5isiPpt
         SPtlmqXl5XPKKOZnXICVoEe6D94dwM0WmLE+Guc41zLQFOJd1QiBJRvUb/CNNpapaaf6
         EGa7lookE8m9b0WF1qaeaE36GH/ymLFt02fnKZzwWLtDgVXhcmVretbVqSocvdWbO2w+
         01iQ==
X-Gm-Message-State: APt69E0mZjKxupY52HkUXpEomfea9h10veFDV09xOCR7NFdvsjnRFo+G
        Cq0vC4UZYuTqpFbOa4CPEl3V5PLE9X7asnIq7pd3fETmxsJPD11vF5PCiXrkkYcQlS7JzDxHpaT
        1sWM6hcfj1nEuILUqF/nSfIFpbU98dAhrcOLHfKnVXRjU9wIPNt5e4XaUBiny
X-Google-Smtp-Source: ADUXVKJyKuuSG5XQaJjzRpA6qBLyxdvI/iavHMXkcaDpf9YDRwcm1cAUvuxcZnjCFjPMWDxzGZDqBo+Hn2H/
MIME-Version: 1.0
X-Received: by 2002:a9d:2a33:: with SMTP id t48-v6mr82568ota.25.1528931188519;
 Wed, 13 Jun 2018 16:06:28 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:14 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-24-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 23/31] commit-slabs: remove realloc counter outside of slab struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The realloc counter is declared outside the struct for the given slabname,
which makes it harder for a follow up patch to move the declaration of the
struct around as then the counter variable would need special treatment.

As the reallocation counter is currently unused we can just remove it.
If we ever need to count the reallocations again, we can reintroduce
the counter as part of 'struct slabname' in commit-slab-decl.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-slab-impl.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 87a9cadfcca..ac1e6d409ad 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -11,8 +11,6 @@
 
 #define implement_commit_slab(slabname, elemtype, scope)		\
 									\
-static int stat_ ##slabname## realloc;					\
-									\
 scope void init_ ##slabname## _with_stride(struct slabname *s,		\
 						   unsigned stride)	\
 {									\
@@ -54,7 +52,6 @@ scope elemtype *slabname## _at_peek(struct slabname *s,			\
 		if (!add_if_missing)					\
 			return NULL;					\
 		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
-		stat_ ##slabname## realloc++;				\
 		for (i = s->slab_count; i <= nth_slab; i++)		\
 			s->slab[i] = NULL;				\
 		s->slab_count = nth_slab + 1;				\
-- 
2.18.0.rc1.244.gcf134e6275-goog

