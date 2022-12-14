Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A764AC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiLNTSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiLNTSA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:18:00 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B3A2B18A
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:55 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id oj5-20020a17090b4d8500b00219e1abad17so126967pjb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0SlVZkfKeAIUW0WmifB0dUMZXZrpQSzsdT2j7ZsqeY=;
        b=ESjpKNCbMh8AGyhYxCOsh3FajrtDvF6J02Pm478X/R1XhNzeMeeQ4YU/Tagg/QK3nw
         3KbK2JWJLpz5OEBlNhucofxd1WdyVIM+tc/wo8OzkobtH/L7Macz6fH9EHg3+m2Xm5XV
         MADDTMKOmYEZ1kCUMx1Qt5vj/Bslz8QBNnC1I+YYnmjInMkx/FLP8zqCr6Jl8qkOhd2F
         kdlE1ZpV/gcDaV6pu2PVjAB0bWs1uGHLItTmHefQ1YzUWD+1IkNasYgN2vtseXfesopb
         lQqBdhCneZ3+J6LVGDdS01PhMdl974PRgRVKTW3GdHvq8R9RIJp/37bcazDn7uVutP/V
         qStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0SlVZkfKeAIUW0WmifB0dUMZXZrpQSzsdT2j7ZsqeY=;
        b=Pko7HrXNphsQw/eMha5GktNz93Aw1Fpdg025kYqrku0+CvKCUIkSIUUbQsCZhhGJ/d
         ElrxiON7WpXGLRELocv6iyPZT77CPCzkWNeH+gkBHkfseVjHF2KNNr1dc+LKJm+kDujR
         yEa1YCEUtWX+QxyJcRZZ2YaADIDNBETJyMQlKlINOBKo7oPcfBHC2zCcvq2zLMreN7tm
         t7LODV36RWdTBGccb0jGEpPdZyp7AnrBfFX49CsgXpR40JhlscyEOta4U5NVLKzr+pNK
         7O69GlHrjH6ltNTZkX2AAuycOWHAyanxUtI9mRmiPOCNZC3u7tGGQuFYDi3WJvi6DRAU
         v3tA==
X-Gm-Message-State: ANoB5pnp/LJtiZCsJcX34FS2oxF2Y5YKSq5t0QjNS1YoGKH9o9sEokol
        XqRqwgVqKzMg636uowamkXtVG65poKyHo3UcrHtLCcNN+7fKfVGXijBkCegf9uR/2ALJVjusKr1
        EQdJdIWokba0rV59iPfr3N1pbFVf7jhJklwRfLTZ2z/PwLe26PRcjezqMXDheYbqFZ7RTo1tbeV
        nL
X-Google-Smtp-Source: AMrXdXv8vTSIB/e3OBWVk3Bi1aE/UJTSaC27ngJJyud4OpnpQebNf4/StQoIgG7WAbuWqFRzNRAMs90kmdm+7z4mcu6s
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8c0b:b0:219:c1fb:5da8 with
 SMTP id a11-20020a17090a8c0b00b00219c1fb5da8mr398928pjo.221.1671045474417;
 Wed, 14 Dec 2022 11:17:54 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:17:43 -0800
In-Reply-To: <cover.1671045259.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1671045259.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <8acf1a29e7586354a800dcce1a6237448f914c7c.1671045259.git.jonathantanmy@google.com>
Subject: [PATCH v6 4/4] commit: don't lazy-fetch commits
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
2.39.0.314.g84b9a713c41-goog

