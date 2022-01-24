Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E090C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 22:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382573AbiAXWdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355485AbiAXWRR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:17:17 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E28C04A2CD
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:12 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id t1-20020a6564c1000000b002e7f31cf59fso10508955pgv.14
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tdSBCdj83xP4iOMnUELbBmRWAjZFBy7Q3ekNtIBGSAo=;
        b=LQqJ/3iLQgMzC6sGHLIyqbfRIBw+4PNje5Z/hGNxLDplTGGXSoZIQyYscRF1+dFYFU
         LZdr65GgakPz2GEtkZEoaBZZAPf1ht8OMAuiZRm5NDJlpOM8oPlj0wFnbx8hBCtOMFKr
         kbDRq8boNCqPJncnbPJJXFYMEkO5mWCazMQAEYfVqFQa8gLbnhlTOkZVk1UGfVcjTBoA
         fUzM0qjCioBN38Ejf7hay+oer3wbrlbv1NuPYfYbooCGuJnMGJ98s+0uBTu1u92++me5
         JkrJTBG9b7BvAEvl6tc1r/gVNtjgs8TEoKzDmTSQFjjzIzwZe6ctxXNaHkXRPJ98LVbt
         d1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tdSBCdj83xP4iOMnUELbBmRWAjZFBy7Q3ekNtIBGSAo=;
        b=gyNQxSVfNR545uIYJH064fTFRtHjyNYVo003MIH/stdC3AZHN0/nKQWc8VjpYXNi34
         3XlYxA0qrrPOz7IEK0otLGdWUXwWKFsh7rrr8Oc3JC/mHglLU5XeRSQ1glUbNbocJPba
         RAXO6CGKhQ9Hu2yRFlW5bfkkkcIDRcN+TVasmhD+CbQoGjhQYHmV0yPNkC3vQem51Vji
         wC/klBQETkzIjhKxjDS0kzUntYhlcuWZBoCbIUpImgzd9ASy/0ijuha2GE2FnRzb1T8W
         ESrUU5iUnf9bb+xLFqck0crCCGiXeklvPZZLrEZZVnDcCvczvlKzN2JdQ7pvijPHY0XY
         DPRg==
X-Gm-Message-State: AOAM532UBXspRLvaVO4iwscCUE0uxTTzKUSC96spEIEnJKgDqpIjozbT
        QX4ImLflkKiLgGIX6wMatXwYNrTvLmB/yVOodwPnrU4IOteP8oBOGKP0ohULgL9g9OA+nR2NxSm
        wf0auuTW/0BRYSDVt0s3Iol3sXeIoDifwrjhpXzg8Ln1m3mpCUSQP5gn6H5eueoo=
X-Google-Smtp-Source: ABdhPJztf/8vqjGazrSJIoaciNJr8Pc5X76bMjgV6mTRfQMY2cwaAjiW/ioUtWL63NSHRNd0OMfNrlFBt6XH+w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:9001:b0:14a:a1b2:1e6d with SMTP
 id a1-20020a170902900100b0014aa1b21e6dmr15819754plp.124.1643057111998; Mon,
 24 Jan 2022 12:45:11 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:44:42 -0800
In-Reply-To: <20220124204442.39353-1-chooglen@google.com>
Message-Id: <20220124204442.39353-7-chooglen@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-1-chooglen@google.com> <20220124204442.39353-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v7 6/6] branch.c: use 'goto cleanup' in setup_tracking() to
 fix memory leaks
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index be33fe09fa..1e9a585633 100644
--- a/branch.c
+++ b/branch.c
@@ -239,7 +239,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	if (track != BRANCH_TRACK_INHERIT)
 		for_each_remote(find_tracked_branch, &tracking);
 	else if (inherit_tracking(&tracking, orig_ref))
-		return;
+		goto cleanup;
 
 	if (!tracking.matches)
 		switch (track) {
@@ -249,7 +249,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		case BRANCH_TRACK_INHERIT:
 			break;
 		default:
-			return;
+			goto cleanup;
 		}
 
 	if (tracking.matches > 1)
@@ -262,6 +262,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 				tracking.remote, tracking.srcs) < 0)
 		exit(-1);
 
+cleanup:
 	string_list_clear(tracking.srcs, 0);
 }
 
-- 
2.33.GIT

