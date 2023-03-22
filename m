Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E30C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCVQBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCVQBG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:01:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B9D65446
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:01:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t15so17615342wrz.7
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679500863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HWgix6MtXPwLulkf+Lqdg0AYUoo+ggdD0mNFQepnrc=;
        b=gcf+I1h5UGTYMpx7wEcVyOpRlws08uwOYvHQ4k42Nyhni37vjy8k2xpi+TBuao2eHZ
         yf6MvYCDYMs3hUHb6OVL5unyInmkQKDw3IK6AL35hGEE/SNPY7dwnwT83yNhwAopiKZP
         N/zYkkD6w9s3zrJRdytrQPl/bxE4xD34FhLZcWXUkY5+g1VtCoB3sEmHo6bdKnJABmj6
         wZgSCIKKWdJtQvFS/ZSm9N6vkmaFeOSkVObqY0nMsm3zJdhV0b7VDdsEfNhkX5aCGLvD
         PcTkEFJ30ex6dOxrmLPx9YY3zJDMSD/LdWYqirjCXdg1q2loSdfA9cNZwayVqsO7XtmD
         UHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HWgix6MtXPwLulkf+Lqdg0AYUoo+ggdD0mNFQepnrc=;
        b=GrdCY/mu6LeORQZKNIqmigwITW3pDB25MBQito8xv+KY9lDmwmsmW6oUkZvbGOTOqu
         95Gl1yJlx+hP9Zev8HVixIgA91zAMXGO5qQj5A6h5JV4eS/iG/8OZnqVa9Tu5dyaZOER
         UDStZEOeth0fiQjkr0ENWTkO+r8yNORyYOvqwLa1uawQUOBPe1bNXIABZ1rYgINYteqb
         ODVxw7uqJp2bDvleQKZMKHqt2Je+hmNV26t8c8YS5JWjBJKvkg9dWJ0IzTb4rdcm11C2
         4v6GlIT4G1GWE2GGx5BKZNSPRbIoKtPkD3T+uKSlYnulwoa+SVkmZSii4WQ0M9+k8elg
         JOFg==
X-Gm-Message-State: AAQBX9chq4US17P5bQS0Y5HEpUppkOxhtVjaGD4QP4hQ3ASWryEvdxET
        ji0X6bNEVKzAWtTYDiXATxnmI6NJo9k=
X-Google-Smtp-Source: AKy350aLSzGVW+g3+IqzTjMNQOtQ1js/iv5v1lAWrBX7clOEKpGASIkXIkuk9oRFPejHnFodnyWbfw==
X-Received: by 2002:adf:e5ca:0:b0:2ce:9877:84ae with SMTP id a10-20020adfe5ca000000b002ce987784aemr274051wrn.16.1679500863664;
        Wed, 22 Mar 2023 09:01:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe585000000b002cea9d931e6sm14186281wrm.78.2023.03.22.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:01:03 -0700 (PDT)
Message-Id: <c1c35f0f026993c493eaae3cf643b25c339205c4.1679500859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 16:00:58 +0000
Subject: [PATCH 3/4] fsmonitor: avoid overriding `cache_changed` bits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of e636a7b4d030 (read-cache: be specific what part of the index has
changed, 2014-06-13), the paradigm `cache_changed = 1` fell out of
fashion and it became a bit field instead.

This is important because some bits have specific meaning and should not
be unset without care, e.g. `SPLIT_INDEX_ORDERED`.

However, b5a816975206 (mark_fsmonitor_valid(): mark the index as changed
if needed, 2019-05-24) did use the `cache_changed` attribute as if it
were a Boolean instead of a bit field.

That not only would override the `SPLIT_INDEX_ORDERED` bit when marking
index entries as valid via the FSMonitor, but worse: it would set the
`SOMETHING_OTHER` bit (whose value is 1). This means that Git would
unnecessarily force a full index to be written out when a split index
was asked for.

Let's instead use the bit that is specifically intended to indicate
FSMonitor-triggered changes, allowing the split-index feature to work as
designed.

Noticed-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsmonitor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsmonitor.h b/fsmonitor.h
index edf7ce5203b..778707b131b 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -86,7 +86,7 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
 	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
 		if (S_ISGITLINK(ce->ce_mode))
 			return;
-		istate->cache_changed = 1;
+		istate->cache_changed |= FSMONITOR_CHANGED;
 		ce->ce_flags |= CE_FSMONITOR_VALID;
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
 	}
-- 
gitgitgadget

