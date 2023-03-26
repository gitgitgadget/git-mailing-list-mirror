Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4DFC77B62
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCZWp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCZWpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:45:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A565BB8
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s13so4018854wmr.4
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679870747;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HWgix6MtXPwLulkf+Lqdg0AYUoo+ggdD0mNFQepnrc=;
        b=f4wzi7oKJS0ScQNlZx95SEiOUqZ6rvJUrp7D/x3yQpnUik3lbDFFr9WXe2VG0oMMj4
         OhdPrwZfK28WqTMa72czIUwe9caUxaqJx7rFTpqu4yKvtW9Z4Fxj2+C9lhAZJ3qQ01Gf
         DggN/+jqBzybpi+5EsNV2USnwVTM1+LFObv3+TevOvsJ/DYVUaoRD/PrvPrJIA1e9KiQ
         dMF8J1dtd6DtRq14Xf/bUHT/sYpGZ8Ako41QIedkS2r6RhyW24p09JL3R1MF15ogy9RZ
         ze4wGgGUObMUF7LcTU9FR//Kg3hEbEzhz0Wefe7OVmnx/nv/IVbDKjqRkYUWuJxS0yCV
         pXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870747;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HWgix6MtXPwLulkf+Lqdg0AYUoo+ggdD0mNFQepnrc=;
        b=4HJv3435u3GrLsqqznSb6a0FTEpL+sH3UXeGvLdqNNGHtjSq5I/QUkrWaCm3sJjoER
         uYpOH9WeMrZSRIw4PhybukWpe0JynsPbdYzLMKww1TurQkRnF0eFcnsCN0VnkVNZ5dLE
         b3gBjlnLiOvFEAGRfpOv0RybqBDSyO+9S2dAjjAKD0GHNzRlSxCMwNjWIEy26BTZKQ8S
         HsJj/Qj8Ygmu/unG4UPQT8sEqGJji3axJw3sAS9skatNQENJiaqOGmr3O6Ae9gUSJUkK
         8XZ8WRi6I2siHgsc6iVTN1sZpJB5VVyRUCiO69DZV25VkUY5m8NM+UJ+oZ56XSLu3Ruv
         gYgw==
X-Gm-Message-State: AO0yUKVN3wsaKmEWkdwxlS7cYybA+/9V57XQJZWFRqpb7D2V1dpHA/zy
        Cjxfuj5ifyOhE19amGDOLtPTHKx3Vtc=
X-Google-Smtp-Source: AK7set8InYCGCq/x5TsSaJVQtj9sxJNlimWVLhs90BTNXYz6LRF5CSNkJHypd5rIsPcePlzE0SDWMw==
X-Received: by 2002:a1c:f619:0:b0:3ed:514d:e07f with SMTP id w25-20020a1cf619000000b003ed514de07fmr8338466wmc.3.1679870747347;
        Sun, 26 Mar 2023 15:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3-20020a05600c45c300b003ed51cdb94csm6687652wmo.26.2023.03.26.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 15:45:46 -0700 (PDT)
Message-Id: <89b3cd9a66823829ce6e425e827b70bc2816d3cd.1679870743.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
        <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Mar 2023 22:45:42 +0000
Subject: [PATCH v2 3/4] fsmonitor: avoid overriding `cache_changed` bits
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

