Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB7DC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLGAlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiLGAlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:41:05 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF5EE31
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:41:05 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id m9-20020a63ed49000000b00477f449365fso13227156pgk.15
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot6NELdT95zBdwiOuRrC2ZytyjPhK8vL2z6c0OEyzyk=;
        b=G64VTpAvsvz+oGC7nnQ6NSUDwXp0Xcv1VbtDP0ngsXFuXTBb73WxNMctDPgF7W4mCn
         7gaXU+yyy8kkfypS4y9vLFzt+JqR2c50nh58fNbaljDuJYyuoqg6AH0Z+5voCMAhAW0R
         +mvmq2uJwtRH7TTygdXeI6RqCOpQL8X9g/ot5a1l1l/jzTrDoX9qzRcEGXLlH5VA4JGu
         AcmGGcJkx+DVRPFdnZ2DfVQGTLjq62WQrkpIZ75SifnIdarZlCNqVC1ignihiHR2P3L4
         k/9O0WweyaaOxV+e0Gegh+AnYkJ/+IG5Cl7KEM/Jb5NQupoXt9YdZTvCIQ5blaJVGf8A
         Etkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot6NELdT95zBdwiOuRrC2ZytyjPhK8vL2z6c0OEyzyk=;
        b=0PqHITZ0cDdqjp6IOQ+bizJjQwcns8S0GvJV2mUTz2zZ8mFtIwlKMoo3Xj/exBH9Rc
         X16ci/Ax44Db0Ve1kPRtHfMkDPfEQMGK7BWvCusMKcfXjuFs+E++lLNVKEbfzi1lUY+2
         PaWKL4pxMEh8lJUPzvD/H+uFssDnKz7YfYR318xGPDF2JpIgCNgKrCG/R07rzY1O5VQK
         2/lbSTDITCrRjR27LPQ79Yxsk0FYfJOP3PCR8bkTv6lDXya/txR7GXU8MxxNcqYaN5nk
         5dhE1lAbXwPH9JgyE5PrLP86BiBDpROmlA+rAy5C7KXDwJtJzfVOvMqaK4Aa7PrUl5Od
         K4vw==
X-Gm-Message-State: ANoB5pkQlCklySmd4riKhNbvnhXj54V8H497VaS69vMydVXEps3KIlen
        Z81oxZb9qGvFCwXj0MQdFmIlj6BSBt4mnwhon8QyMWMbJK5jxhmevnm8aOAG7bTQkTnrU4Ac/VP
        UazF4ps8bjYjxx2dJSF7hX2pJplDeETmpeqej969plxZwiQX2jdFf7HZaIpoU3X1RjvwMWVPEAR
        MU
X-Google-Smtp-Source: AA0mqf4/Yta72Tj2vaVN7EX9W1LRjnf7DJaJr6HeHqNti//ZV7J3iserW6SMjXG8qGIcO/uJM2arwic+Wr9FU2byaYtV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:f48d:b0:212:c877:e948 with
 SMTP id bx13-20020a17090af48d00b00212c877e948mr104617430pjb.39.1670373664649;
 Tue, 06 Dec 2022 16:41:04 -0800 (PST)
Date:   Tue,  6 Dec 2022 16:40:53 -0800
In-Reply-To: <cover.1670373420.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670373420.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <c5fe42deb04285b85d5354a57e90bf9410cc2420.1670373420.git.jonathantanmy@google.com>
Subject: [PATCH v2 3/3] commit: don't lazy-fetch commits
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
2.39.0.rc0.267.gcb52ba06e7-goog

