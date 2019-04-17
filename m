Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16F320305
	for <e@80x24.org>; Wed, 17 Apr 2019 07:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfDQH6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 03:58:48 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:35083 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731170AbfDQH6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 03:58:48 -0400
Received: by mail-pf1-f176.google.com with SMTP id t21so11726070pfh.2
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvPSUcHAVSvcoM2wbvTzC6J64auHg17TQ97um7Q/2ro=;
        b=HJmW6vGAZqYFPOg+8v382VGcBipYalwnq+htwrzfE13mL16igk0+vlxvLFA+gm4CA7
         6HsKJW9LRPgcbze1mzjgIQ8PSovjgvtgW8JyI0afDHnRX3g0CSqqlOocDxLuPxLlI0bn
         KIFEWRaRd8VScu4l38hNkle9Z4yLrVBY834oR5mn2aiTY6HFM1VddLBaqECbF4LreaWS
         QTJDOJ9QgTm6BuaZlr/FBXGGQhHKHJrsFFti9FoCqO7DVQ+azMb8PylmNU2t6o+ykr7y
         i4aCmM3rZIRpS6gUyWm50xlQ/+WFaenCZTG4xr6t2AEtzn4tHI1x7uTbIDSfMdBFLXrv
         idow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvPSUcHAVSvcoM2wbvTzC6J64auHg17TQ97um7Q/2ro=;
        b=ENKzEgu7m7bzXPs8sxf2ZmIPFLG2FcX3iE1Zl9zwCcK7HVNyZ8Do9/mpYMeFsBdGuW
         7VybSpyylhc96jdL6vpj4WkxvaZDjRaKnC27KsHaZgoRtBL9BhtGc0gaZgT1w3XVjePB
         VAOxkNN6RzDdlMx4kZrg2VOAWxDkXxuYLOed4kcNIM1cE+1UAu6vjhY6q7siwn94HNqc
         XWa3mfQoDZ3kl+t+ljmMUjHmw1y+mUdi1D5zTiSb1uZ7oGdN25bEFQmzHtLUnnHwnT+o
         Z/pqj34C1I1VnedF5e1t/5fCvTWx2TprDn0/JrQmOnXtggR6IgdcARIFcj4yYUhKtANx
         k9HQ==
X-Gm-Message-State: APjAAAVBXtIKFEHWpWuDwbehv4iGxiLOsa5l58QSO6WlNN8uHDUJ5yB9
        JYwssGDbamvnQZRGl3la/UuGRmhd
X-Google-Smtp-Source: APXvYqw9GYU/nUTQFdRUf/wjK6izGPiLtMG+rMrc+cgXTRPj14CqGFdudoyvyHN/DDErXMFq6zTMNg==
X-Received: by 2002:aa7:8c86:: with SMTP id p6mr89169035pfd.37.1555487926710;
        Wed, 17 Apr 2019 00:58:46 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id n5sm62682464pgp.80.2019.04.17.00.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 00:58:46 -0700 (PDT)
Date:   Wed, 17 Apr 2019 00:58:44 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 4/4] cocci: prevent extern function declarations
Message-ID: <d5a1663048d38bcbe4fbaff8fffe875c5795941e.1555487381.git.liu.denton@gmail.com>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555487380.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since function declarations already implicitly imply extern, create a
Coccinelle rule which removes the redundant extern.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/coccinelle/noextern.cocci | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 contrib/coccinelle/noextern.cocci

diff --git a/contrib/coccinelle/noextern.cocci b/contrib/coccinelle/noextern.cocci
new file mode 100644
index 0000000000..8cb39ac947
--- /dev/null
+++ b/contrib/coccinelle/noextern.cocci
@@ -0,0 +1,6 @@
+@@
+type T;
+identifier f;
+@@
+- extern
+  T f(...);
-- 
2.21.0.832.gd5ec0d3bee

