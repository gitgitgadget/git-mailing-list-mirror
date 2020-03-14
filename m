Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D35C0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 02:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E5E2071C
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 02:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6nG66/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCOCUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:20:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53638 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCOCUY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 22:20:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id 25so13932748wmk.3
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5FnD2JN/w/r0j7nu8os40pOeRubrdPU5wn0DNfUTFeg=;
        b=o6nG66/xJvEx53mjshhOzqNuyESnf/kA57A/yBHDfeVgRc9zaG2FECvgkwT5Qrcglk
         4x26bImEKTsvDOPaGKvm0MESw4CXHi9FaCVGhwgKMuZdrpFHFC26Cs1HJIl7qtw4chsy
         tuYdZsBKuYGzi2OMtnUvwcLE1VwE2kxtWT83Ulblel7niW9oKMnB/9PFKOd3DxO7HX5J
         XSeTAnFwjyE3Bn5UqyiPoBJPnskLlHKWxhSZxJJfxzZ+jWp/s+SVju4VjD6PJJkqdNS5
         +hI0EP/2a7+DXV8bLTwLSC9OcQiAf37+SkbkAKJqryvhZQBQtUJnluI8uVZoXkmNaFag
         VI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5FnD2JN/w/r0j7nu8os40pOeRubrdPU5wn0DNfUTFeg=;
        b=ftwHzinAfCrIAkDb6iko7z8SRNDCgMwVRHJhehAf/kCcApa8my2rJ03N66TZQzLQ9N
         LrEQeiThsEmYFWdyFxMQ4jyTIUHyOJiTp45Jownj7JJpNF6i/5otZTvEfKnV+ln6YVeY
         9cptwSaNJERE6ulv38c7kAoL6GbWUwjWWkVo0caIiZZZTmHYGv1FSo++3HpWgHTAfTRL
         D7uESNtQMjumOy11o/6PCcK/RzwwJFFIgv0XWROo6OJk4VaVr822MdqFtn7R7zVVEYzl
         JKXJNTWCi/uUssWvYCqBHr8vfauzKC6MNd+0fi2dk50M7MTKLvfcWTs8w005jZ9ph2iC
         z59g==
X-Gm-Message-State: ANhLgQ1eFUSoY0S91KcFGM7FmOEHSKFH4s4O/cxPSj338ckhayY3iA2j
        hu3VtrY2AUyZ04sC6iDuNjNtc3QG
X-Google-Smtp-Source: ADFU+vs0Op8AIDSwp9OCc+0Fk6pWgj/ymCu3X68l+YdE96gYaSMxzQDn6f8pEMHaVzl9xmHFjBHziQ==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr17307655wmc.156.1584213348965;
        Sat, 14 Mar 2020 12:15:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm67583217wrr.45.2020.03.14.12.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 12:15:48 -0700 (PDT)
Message-Id: <pull.727.git.git.1584213347500.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 19:15:47 +0000
Subject: [PATCH] oidset: remove unnecessary include
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When commit 8b2f8cbcb1 ("oidset: use khash", 2018-10-04) moved from
using oidmap to khash, it replaced the oidmap.h include with both one
for hashmap.h and khash.h.  Since the hashmap.h header is unnecessary,
and the point of the patch was to switch from hashmap (used by oidmap)
to khash.h, remove the unneccessary include.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    oidset: remove unnecessary include

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-727%2Fnewren%2Foidset-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-727/newren/oidset-cleanup-v1
Pull-Request: https://github.com/git/git/pull/727

 oidset.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/oidset.h b/oidset.h
index 5346563b0bc..d8a106b1275 100644
--- a/oidset.h
+++ b/oidset.h
@@ -1,7 +1,6 @@
 #ifndef OIDSET_H
 #define OIDSET_H
 
-#include "hashmap.h"
 #include "khash.h"
 
 /**

base-commit: 30e9940356dc67959877f4b2417da33ebdefbb79
-- 
gitgitgadget
