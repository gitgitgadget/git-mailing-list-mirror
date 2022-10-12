Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3219C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJLMxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJLMxC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:53:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80717C90F1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w18so26098462wro.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWpVJInZugH1z+IBM1n7b7iFlEZKKmBfgM3uDXDEkNI=;
        b=TrlwwyUCa2JLbP4+eZDfqRRw+KItBCX4KFgPW/QR1U226Qu4UK28dJ0orWFHYnOBXk
         M6WvqNld0SYJv6UR4Bgk2c//VHMxbjZWUc7taT81s9wbuL0ip0gO/4z2PlJr1h9P5KBB
         IKt0WNJBwGlEK5AASYghn0IvOv53igeWSen8fk/GKWwFLSKSqA1A0nIUKqcs8iBJxwZv
         deApwJ/kJFTXucQCRqEZFjsT5Ok2zeeL2u7gUyp51Lt/vQxunvI2EPx40LC4vXvx7ckJ
         5nPTpffptWhHszLW0UKadxxEkeZvsCDRT/QuC5/3k8Dz6EN/5wW7Ti/nHpOi0Zx9VhlN
         IAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWpVJInZugH1z+IBM1n7b7iFlEZKKmBfgM3uDXDEkNI=;
        b=q4x1ZqsGKhBV1scogjGuWioI3hY4oXHeSb60wrjbQX6v6M3Z9vRF0U2Zda1qKFRGJq
         pB7IKUEr7g4bCPsoAiQJ3SAnBXMWws+vJxK9at5OH1G6xkP2CuP15gbURKlHwPFWrXLN
         pjM5j9wVcywWHMxB7p2bFpUUz7Guiuf4syR/DX6bw2XYZru2/gQcy5UKhyVrtAqPCT7P
         PcQiVU8VDpNbBr0rqprI8Z97hHNkU8NSV2wnxU9XzT9Jmn7cWaGgECjUlPvRG2m7Fw25
         gXBAH/0IgVy+w9zMn2vcVlqFRQQjy5Ow3Fff1g50mzGtAMriKHVVSIpcPW4AUWWe8FnL
         ZMjg==
X-Gm-Message-State: ACrzQf0SSabBL7dWQyTWojkklrk1JtdT3syP/9c6hiJd+WOBiqLMOKAS
        rgo3j1HzUkI97ZOCwo4lmCNsfwlBDqY=
X-Google-Smtp-Source: AMsMyM5ww9cZ/jIwBWkFFZh/NyA2WUtfLmRUG14yDnFjppBXvezp77+bTIg9x+Fe79v3sh52HGJtyg==
X-Received: by 2002:adf:ef05:0:b0:230:32dc:a7ce with SMTP id e5-20020adfef05000000b0023032dca7cemr10709926wro.319.1665579172236;
        Wed, 12 Oct 2022 05:52:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c228800b003c6c76b43a1sm1711192wmf.13.2022.10.12.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:51 -0700 (PDT)
Message-Id: <8dc5a8e4e63dc98642176e5b78be739ef721d2d8.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:35 +0000
Subject: [PATCH v5 08/12] bundle: properly clear all revision flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The verify_bundle() method checks two things for a bundle's
prerequisites:

 1. Are these objects in the object store?
 2. Are these objects reachable from our references?

In this second question, multiple uses of verify_bundle() in the same
process can report an invalid bundle even though it is correct. The
reason is due to not clearing all of the commit marks on the commits
previously walked.

The revision walk machinery was first introduced in-process by
fb9a54150d3 (git-bundle: avoid fork() in verify_bundle(), 2007-02-22).
This implementation used "-1" as the set of flags to clear. The next
meaningful change came in 2b064697a5b (revision traversal: retire
BOUNDARY_SHOW, 2007-03-05), which introduced the PREREQ_MARK flag
instead of a flag normally controlled by the revision-walk machinery.

In 86a0a408b90 (commit: factor out
clear_commit_marks_for_object_array, 2011-10-01), the loop over the
array of commits was replaced with a new
clear_commit_marks_for_object_array(), but simultaneously the "-1" value
was replaced with "ALL_REV_FLAGS", which stopped un-setting the
PREREQ_MARK flag. This means that if multiple commits were marked by the
PREREQ_MARK in a previous run of verify_bundle(), then this loop could
terminate early due to 'i' going to zero:

	while (i && (commit = get_revision(&revs)))
		if (commit->object.flags & PREREQ_MARK)
			i--;

The flag clearing work was changed again in 63647391e6c (bundle: avoid
using the rev_info flag leak_pending, 2017-12-25), but that was only
cosmetic and did not change the behavior.

It may seem that it would be sufficient to add the PREREQ_MARK flag to
the clear_commit_marks() call in its current location. However, we
actually need to do it in the "cleanup:" step, since the first loop
checking "Are these objects in the object store?" might add the
PREREQ_MARK flag to some objects and then terminate without performing a
walk due to one missing object. By clearing the flags in all cases, we
avoid this issue when running verify_bundle() multiple times in the same
process.

Moving this loop to the cleanup step alone would cause a segfault when
running 'git bundle verify' outside of a repository, but this is because
of that error condition using "goto cleanup" when returning is perfectly
safe. Nothing has been initialized at that point, so we can return
immediately without causing any leaks.

This behavior is verified carefully by a test that will be added soon
when Git learns to download bundle lists in a 'git clone --bundle-uri'
command.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/bundle.c b/bundle.c
index 0208e6d90d3..c277f3b9360 100644
--- a/bundle.c
+++ b/bundle.c
@@ -202,10 +202,8 @@ int verify_bundle(struct repository *r,
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
-	if (!r || !r->objects || !r->objects->odb) {
-		ret = error(_("need a repository to verify a bundle"));
-		goto cleanup;
-	}
+	if (!r || !r->objects || !r->objects->odb)
+		return error(_("need a repository to verify a bundle"));
 
 	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
@@ -250,15 +248,6 @@ int verify_bundle(struct repository *r,
 		error("%s %s", oid_to_hex(oid), name);
 	}
 
-	/* Clean up objects used, as they will be reused. */
-	for (i = 0; i < p->nr; i++) {
-		struct string_list_item *e = p->items + i;
-		struct object_id *oid = e->util;
-		commit = lookup_commit_reference_gently(r, oid, 1);
-		if (commit)
-			clear_commit_marks(commit, ALL_REV_FLAGS);
-	}
-
 	if (verbose) {
 		struct string_list *r;
 
@@ -287,6 +276,14 @@ int verify_bundle(struct repository *r,
 				  list_objects_filter_spec(&header->filter));
 	}
 cleanup:
+	/* Clean up objects used, as they will be reused. */
+	for (i = 0; i < p->nr; i++) {
+		struct string_list_item *e = p->items + i;
+		struct object_id *oid = e->util;
+		commit = lookup_commit_reference_gently(r, oid, 1);
+		if (commit)
+			clear_commit_marks(commit, ALL_REV_FLAGS | PREREQ_MARK);
+	}
 	release_revisions(&revs);
 	return ret;
 }
-- 
gitgitgadget

