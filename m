Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD9C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 20:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLHU55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLHU5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 15:57:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54A593A59
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 12:57:22 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pm5-20020a17090b3c4500b00219864a46f0so1824619pjb.7
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 12:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPpuIbJOfBZ40jm8I4bnWOn08D+JMmEeOVygJEeJuNM=;
        b=DnG0WL72FurdYIreQ0qyJXDk+6kkLu3lDRREa0I0TAO2UPQHL0MX8BdXtgwAfzaD8q
         40sJ+KNtn9/wXEY+5RQE/50YxHzQLksYnUh1fV+XizdLxN10VdihHNR+p7L9CerOcHvZ
         f4xv6OSA+GTCHEF6IKiRuLnKPpCbHEPSZ9Rez5U64bucKxYBHUSrvCoBiWYvOjaKNrR6
         dV3u5Dn7pGe51hGPNpWKjWo5fQCPmGnmcID3CH4bOdKNZiQISOeT47ulJg+B9Ax4dnvt
         wceq+nXlZKZIlNZUmlzdxn0wTe2tsrk7jqaCeqZFbeLsNXeHrra2DWxEvcDBsEG7QpQo
         UzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPpuIbJOfBZ40jm8I4bnWOn08D+JMmEeOVygJEeJuNM=;
        b=MC9iuE1bKQfo6MPcXQeJU994+n8AifaewcWXnyQzWJ2FXQjKdq/eeN3AprkuIb/IAw
         HVX5Y9lKEa8gz4/xwPIf2b03UkRFzp3AiFHLzKDAdd6hMA5TgdlZTvUlKV4l/H6ATv8P
         0kSD7VEiPkStK6S845iJIC3MOGK75ZLw5opVp2wP2HThO31DhFRM8RLkEjoRlcw99/4I
         J5hvSEIHw4od16wVS/z8vNT9dLz3CD8OFzCi2hpQpBr1FTPiA462gzoUrIZgiKO0oWqT
         gzQXHvtINgo9f0EH4VlNsVLjyMqx1YQjrGqriCycvTr4k5wlb47vdsw94VgloEDXp3b2
         Vftg==
X-Gm-Message-State: ANoB5pmn6apBrTXoUYEwSFs+ctked2GyGX6VUiM3aWmWQtw2+pBGkqMD
        H3YagAjAzEn1ZjU2DfMXPcRU8SXbTRnsP/iw+vXqKtcb/zjbhwqYeClDSprSV+oYuzW8Uuo7cHl
        DJjk/TEdia8fHvOoj9DbDi6pElq5vEocR9jPt65g+qtteyPifR9WfjAXW0Mhbn4ihH7Ea+JqYJe
        x7
X-Google-Smtp-Source: AA0mqf6lGXFfgEISf120UBhuMM8OgXCmVyQK/T/lHA8/Or+4W0TJW0Xv27pPwCSIq5rvZAiZeBlGuhR91FK6D+6OhoxJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:f89:b0:219:5b3b:2b9f with
 SMTP id ft9-20020a17090b0f8900b002195b3b2b9fmr4101309pjb.2.1670533042033;
 Thu, 08 Dec 2022 12:57:22 -0800 (PST)
Date:   Thu,  8 Dec 2022 12:57:08 -0800
In-Reply-To: <cover.1670532905.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670532905.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <5924a5120bc8e0bf529fc1cde5c23724550f72a4.1670532905.git.jonathantanmy@google.com>
Subject: [PATCH v3 4/4] commit: don't lazy-fetch commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com, gitster@pobox.com
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

