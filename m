Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C9FC04FDE
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 21:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLIVov (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLIVop (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 16:44:45 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84EFB6DAF
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 13:44:37 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l10-20020a170902f68a00b00189d1728848so5158054plg.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 13:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPpuIbJOfBZ40jm8I4bnWOn08D+JMmEeOVygJEeJuNM=;
        b=AYtLS0knMGg41O0tol3pyGlvJshBloKJpbXFMBJUW3u5AeykQ0OjbxF+ey7lQnS7CF
         us60Frcp6b380smAI8TVtaMwnu0nRKRhQXzMR4nnjAZLLQDa567/orKyi4+p2Sg5/55s
         yvEVC/BH8q3PMeskJ+2suSTMx5bvIo58qqMhEpYyEbJL5hdcFtejaOkNCSwpPVNQ19I2
         5vuK7/oJeaGoTiuj/HDJen2v65VA05aDsbHZ9ItJnxzbDmxnkorZWLI9+TPIwsIFJciI
         X19uhyWUNElXSVUQV6zq1T1aQzTFjthMVkl3Qa2C7Trk9+ReTZwSxrfS7YGUdEchNm7M
         CjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPpuIbJOfBZ40jm8I4bnWOn08D+JMmEeOVygJEeJuNM=;
        b=kmgtMXy1j2mFRWktrMq5Iw1Ji44QZEcdqM/QuCGM7nm62PtbZr6DQUjZr4Qad8b5mQ
         QBScGGsEYOD1xtdvRlFxAhPPAdvqdexij8OMsRgxGPTwWkzbnAKNmOyg4arqYrNOZDgY
         0c+i6VfJLDxT3LcZZbjMlduCWsZjXPtd+2JCNc6BuZSaZm+gQkiuUn7jVxjpft6Inx8s
         CthGYbiEjtOjxzAkSeGSSa7kBmfZMhu5x1u82hfctK/zTrpFzfWACP4Sj8N4KW7LDqgl
         23HO0Vh5Ial+XQ2m8wMYfDzXwtUXpFi3P0GQDIAQm2G8aMPuJeOJnoIJ4TV1hSbWpITm
         UW+Q==
X-Gm-Message-State: ANoB5pktTYQgqTFqmR57RUVsyapMPqpUmCnx/t9ecLmy0YxiNsxT+ayc
        r76uZfAmalxE5Z5fUBUE9I23aAAzkDz6r4qAC2MlPASLa7kReYb/IYcfjbBQEYRdBMO9oOAkzMW
        Pbbef36XSFOryoZu1cKJVWCoAs4yG64jxXkeHcNnRncq6OAiVtDfQPOvh9AxBM3k7nYJ/61xUR/
        AM
X-Google-Smtp-Source: AA0mqf4sFEKmw9S5x7XUdLT2QYUKOwXFFa9D4W3eKVXB7YE5i7mIlK8B4YMNjCVMHP0tq5b028EOa5U2sDQZ2NY9f7+A
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1941:b0:56b:a80f:38d4 with
 SMTP id s1-20020a056a00194100b0056ba80f38d4mr78930375pfk.12.1670622277489;
 Fri, 09 Dec 2022 13:44:37 -0800 (PST)
Date:   Fri,  9 Dec 2022 13:44:25 -0800
In-Reply-To: <cover.1670622176.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670622176.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <1a0cd5b244652fc821714380bfd3cb5425388c8b.1670622176.git.jonathantanmy@google.com>
Subject: [PATCH v4 4/4] commit: don't lazy-fetch commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>
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

