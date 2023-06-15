Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C24AEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbjFOCyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbjFOCx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:53:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94D26AD
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30fc2b44281so3889544f8f.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797635; x=1689389635;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5D/54p+HpeCu+GmS68q0IoXxV4LWpBoO9Tq42MbRDU=;
        b=UgtXxZSBzZA8TGFT5V6txdeqZiol1HHuA8V0A5wXia5z64BZYQVfFYw5W4fcC4A+mH
         iSteFsGAeuNRU81ajFf3wcOd/GcKKlZ5wlf+Nk+WEnFnomtUXYejnHmb6l1cjf6ow510
         t0QG5x7XNrD+A2b6eKEHPtXpECWZfPrjDgX3xLwnblINELHFj/t0MpIOm+KbRxeKkYRQ
         QZpMwaBRzhA2ivmFzEH5A+rz4mYMoASUn0MXLQ69Qp9jGWvRyK9MR1k23dXij57wa3XF
         QZXqyT6k4lIu0Qn0x67MQuEuU16Fy/z4HLQGXXufhO+VW9MQrIv+zM5mtB6H/31qvEA0
         OXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797635; x=1689389635;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5D/54p+HpeCu+GmS68q0IoXxV4LWpBoO9Tq42MbRDU=;
        b=L2ZZ7cJR+PU4tPzAGhIYdSxZv/DbpZ06RyIraKYmMxOSEhG0wRerYeJC0kGyvia/vp
         g3gVP0RGPTuUh+kz3Ren5jYLRn6U5cPVGhjCHgBekcUE67ehHO9LvhzNtmOX01oyDuuf
         FssL0da6zdsuOJYqlo88mPwrZl/kdk85uTem/aN1tD88/JgulS/RirNUgyDLMOFRzvpo
         YrpG5/V74VChXWkvHFnLyLtwOKChk5EE6VgRNZO0U9n6RCbeHNZBdTsKYFiAU8qqPvUi
         gYcdxCPPsNW9KiuLApQe5wkqJN4BPz/Z5+EtfYlkNxWlNH2aGnEYk0OD2GaxVJ6wBxTC
         3f/w==
X-Gm-Message-State: AC+VfDxWhVLtiZMdWcRlG4AJvlXA7dmfbmEshjVkbbzfrcyepuI1ZZph
        IB9VnKbseuimPbTvEOPaIVO3WyKSMDg=
X-Google-Smtp-Source: ACHHUZ7/R1bNSDuY8qq7mTJCAniu0gO+tNJWrry2TK/MwnuRC04ec1Q4cqViwZteAczs0AOB11bG5g==
X-Received: by 2002:adf:dec5:0:b0:30f:bf71:501b with SMTP id i5-20020adfdec5000000b0030fbf71501bmr8129216wrn.61.1686797635112;
        Wed, 14 Jun 2023 19:53:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d5584000000b0030fc576633dsm8988789wrv.16.2023.06.14.19.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:54 -0700 (PDT)
Message-Id: <a4a2ed16dcce9cd01b46d01661fcbce80413e2fb.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:46 +0000
Subject: [PATCH v4 5/9] doc: trailer: remove redundant phrasing
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
index 58a9c691492..7516593c470 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -72,9 +72,8 @@ inside or after the value. The value may be split over multiple lines
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

