Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CC1C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiLLWuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiLLWt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:49:57 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FE60E8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:49:03 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y23-20020aa78057000000b00574277cb386so755011pfm.16
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPpuIbJOfBZ40jm8I4bnWOn08D+JMmEeOVygJEeJuNM=;
        b=BiL5nEGBODsFlj6WiKaXKM0YlI0v5W7JZh/r6NQ/yGDYwoSa8dMwW4qwgR83GxWUO1
         m7LKNS5fiYEDk/RUOp9sppNHSnbpyxS0wbUPduyqZEd4n/tzPXXrsqf5vhFHA2VtlonQ
         bO8axiYO5Mvzw4Zf18PpM6AnmDu0gM/zRWD36iB3z3DTOaR0b1Hq/BHvqhbRiVo+4icc
         gkwadDN9vSPmS4kuh1ZJIdXY32YFjyYsMFN/eaN/d3CyehN2enxQX0elIUjqm/YcCEZr
         epCn8+yUN9sOBcPby9gO1Do39rN7OOMt1tyIeBElycLwn7ACTsumw5OTjAr1XcsVYFbY
         19CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPpuIbJOfBZ40jm8I4bnWOn08D+JMmEeOVygJEeJuNM=;
        b=blXXpwPxI4cnm5Qzc/YC4UC/iRYEkIVna+EOQfTM8VMQUM0u9NmTp4X/g+0++q+JRS
         QO5rO/rTlmAuCR33eujmagZwo6LRGLsyM9tXowSn2OPJqAn1KnDBXZjsuhE13TOpHfVk
         04vS5+VvI8PvvLXjfRFVLnozCLPxTg3ZxtPSI4TQqRgeLA6HsRy/r8dGIOK6Qn0O5rhz
         Z5J9tZYXZkepuGX3uTCGmRPPSxZiQ2oWy5nzEZJjJTA3+KfzAm8TzucnwGp82Zicgh6f
         m+wXe7nYrBkItxyaxFAYBQXjgHWeuQHPdCjh620GNSbXWXuNUpV0BH0xn4SbMxeCX2Q+
         hp0w==
X-Gm-Message-State: ANoB5plNv1E1YmU5kkpNthM1HTG3iOUe+Z64bC5zwvr6pr4cj/IgxcBI
        5DWqgtqvvuEAWEG/e2Op2YY0ECbIfmB6brAp6mO3H92vl/vdn+REdqjpFw1D17J/Yv+ITGWRNVI
        MhzrH6M0S7DozbUtM2ZR3wh9Sd/R281mDQtaBW4PcPC7O3zfBkENJtLTpORtk+9bExu5i4qQY2z
        kL
X-Google-Smtp-Source: AA0mqf5Kx/zg6PP+hPi08rIuhZhsS58nPcT1yFMzsvL2sD/AnTKs458nsu2rXdi4qqhz70Kl/fF1DwIvlQWy71DznUnt
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:e691:b0:220:1f03:129b with
 SMTP id s17-20020a17090ae69100b002201f03129bmr908pjy.0.1670885342578; Mon, 12
 Dec 2022 14:49:02 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:48:51 -0800
In-Reply-To: <cover.1670885252.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670885252.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <b54972118acb0552c21e507035c550b704adc812.1670885252.git.jonathantanmy@google.com>
Subject: [PATCH v5 4/4] commit: don't lazy-fetch commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing commits, fail fast when the commit is missing or
corrupt, instead of attempting to fetch them. This is done by inlining
repo_read_object_file() and setting the flag that prevents fetching.

This is motivated by a situation in which through a bug (not necessarily
through Git), there was corruption in the object store of a partial
clone. In this particular case, the problem was exposed when "git gc"
tried to expire reflogs, which calls repo_parse_commit(), which triggers
fetches of the missing commits.

(There are other possible solutions to this problem including passing an
argument from "git gc" to "git reflog" to inhibit all lazy fetches, but
I think that this fix is at the wrong level - fixing "git reflog" means
that this particular command works fine, or so we think (it will fail if
it somehow needs to read a legitimately missing blob, say, a .gitmodules
file), but fixing repo_parse_commit() will fix a whole class of bugs.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 572301b80a..a02723f06b 100644
--- a/commit.c
+++ b/commit.c
@@ -508,6 +508,17 @@ int repo_parse_commit_internal(struct repository *r,
 	enum object_type type;
 	void *buffer;
 	unsigned long size;
+	struct object_info oi = {
+		.typep = &type,
+		.sizep = &size,
+		.contentp = &buffer,
+	};
+	/*
+	 * Git does not support partial clones that exclude commits, so set
+	 * OBJECT_INFO_SKIP_FETCH_OBJECT to fail fast when an object is missing.
+	 */
+	int flags = OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
+		OBJECT_INFO_DIE_IF_CORRUPT;
 	int ret;
 
 	if (!item)
@@ -516,8 +527,8 @@ int repo_parse_commit_internal(struct repository *r,
 		return 0;
 	if (use_commit_graph && parse_commit_in_graph(r, item))
 		return 0;
-	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
-	if (!buffer)
+
+	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
-- 
2.39.0.rc1.256.g54fd8350bd-goog

