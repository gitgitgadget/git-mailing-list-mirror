Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C08AC433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F05F207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FgBcoRol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgIBTCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBTCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 15:02:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B3FC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 12:02:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z4so216715pgv.13
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cM2q/PhLAWKA2NCRhg4AKraYGb4lt2+fZI7ovVqtIao=;
        b=FgBcoRolqeOn7qC1LPGyPZlLiXzKNcvLp4lTKK/FsBbkPzDPYG2mXD9kkE4IEm2APz
         1UTkU1OSplWxChrv12zbjcl+2ciqJgOr2lNkb1pXaFjxRX5DhtyZdJCR1HJefHBLdDJF
         1ZmnItVMVSTULHJ5Pi5AKSVKnVYtnYVKZuSJQDgUjVIUBggBUDyNw1WQbh9DZHdpMUTw
         pgkVTImCVGpzT8s9p1PlHEd0Xbn1gfjiLxUaZkTM3Cn2Mm/aIkRj2e8KlBIRMgivCHRP
         4VzFqezyeNwNDCZl4MaY2nHdiepmvCPahRuhwRKQ8y251JEdQa3/NjXARBBvF6mkFxeo
         OBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cM2q/PhLAWKA2NCRhg4AKraYGb4lt2+fZI7ovVqtIao=;
        b=GsW3AWG3IFHaG0mc1p1coZHeq3wffkno9XhKj4jG/NmrvzNGvCCy5QFuZlObjNDVmG
         c8j7r207BsURJN/zYEtTpvJRiJU2mN2zKCTGVePRG+OO9NCpjMPfvMopYUAYdys4rObB
         4n9rmiBHSbj0UHR3UJdfuJd9oSgalL12My5moJTMiSkf/rKjF2EXYZbuGv6Z5YkRvWVu
         iSxUgJ8tVWFMBlgbTB5Ez39oy/9ZNpSf4zH9LcpyE1xJhOk/7KNFjD4wQ2SaydO+9Ieo
         xQTOnjp4PWyA/DXliuWW/vsP+iPn50H7Y2do8TmEpupv/Pbd7avqBJ6S9+Aj3v+2E2eZ
         N7sA==
X-Gm-Message-State: AOAM532+TD08nsJI4Xqr3VORbj4lCF0F2mk1Rsh8KBgc22h1r+0pU/QP
        reCm4Yg1pPPp83tEu/1m2YUMQn7yGfikV1EE7OYrstPpaRo8vPaQqjx6EGBiqtumINsOyVzRGJv
        2HtpscIH/rmGP0Sp49xgv2zrsK2c/bvoMrpKYywcmGTC4qRloZeVg5mIpyZ5jjyTsz/p/VYhwqc
        Yi
X-Google-Smtp-Source: ABdhPJxcxhBa9CYpe8PeIgF296+0gIFh7FfGgdhE5AX0pWp1N1nTVOsvr3H4GNv1uGAlQPgaJB4i4KvF5WTDsr6WZ3Fr
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ee54:b029:d0:4c09:c0 with
 SMTP id 20-20020a170902ee54b02900d04c0900c0mr3117884plo.2.1599073354617; Wed,
 02 Sep 2020 12:02:34 -0700 (PDT)
Date:   Wed,  2 Sep 2020 12:02:32 -0700
Message-Id: <20200902190232.317477-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH] fetch: no FETCH_HEAD display if --no-write-fetch-head
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

887952b8c6 ("fetch: optionally allow disabling FETCH_HEAD update",
2020-08-18) introduced the ability to disable writing to FETCH_HEAD
during fetch, but did not suppress the "<source> -> FETCH_HEAD" message
when this ability is used. This message is misleading in this case,
because FETCH_HEAD is not written. Also, because "fetch" is used to
lazy-fetch missing objects in a partial clone, this significantly
clutters up the output in that case since the objects to be fetched are
potentially numerous. Therefore, suppress this message when
--no-write-fetch-head is passed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on origin/jt/lazy-fetch.

This might be important for Stolee's maintenance prefetch patch [1] too
- presumably we don't want to show FETCH_HEAD there, as it would be
misleading and would clutter in the same way (albeit to a lesser
extent).

[1] https://lore.kernel.org/git/da64c51a8182ec13aeed8f0157079fb29a09ee85.1598380599.git.gitgitgadget@gmail.com/
---
 builtin/fetch.c          | 3 ++-
 t/t0410-partial-clone.sh | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 320ba9471d..442df05f5a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1023,11 +1023,12 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note,
 						       summary_width);
 				free(ref);
-			} else
+			} else if (write_fetch_head) {
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
+			}
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index d681e90640..584a039b85 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -183,7 +183,7 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
 '
 
 test_expect_success 'fetching of missing objects' '
-	rm -rf repo &&
+	rm -rf repo err &&
 	test_create_repo server &&
 	test_commit -C server foo &&
 	git -C server repack -a -d --write-bitmap-index &&
@@ -194,7 +194,10 @@ test_expect_success 'fetching of missing objects' '
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "origin" &&
-	git -C repo cat-file -p "$HASH" &&
+	git -C repo cat-file -p "$HASH" 2>err &&
+
+	# Ensure that no spurious FETCH_HEAD messages are written
+	! grep FETCH_HEAD err &&
 
 	# Ensure that the .promisor file is written, and check that its
 	# associated packfile contains the object
-- 
2.28.0.402.g5ffc5be6b7-goog

