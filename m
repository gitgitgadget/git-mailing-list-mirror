Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2F6C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5D961155
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhDWAQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 20:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbhDWAQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 20:16:23 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55416C061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c5-20020a0ca9c50000b02901aede9b5061so4957509qvb.14
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PbyIiFufSbyo/g1FNw00PACXkHOg84yyaWNB5eBEYCo=;
        b=uUMfvXUSbwO1+/xV5n/B8HsxXYbKmff0Cz8LkYQE5XpSN+9gB7VkIyiAMLR5Yl/usk
         jN+XmE8yr131JR3YGSIqjTv4bw04Xk3pp2gtZggReoyxD+NIAo9h1dXvg3EOO7ejtGxm
         rGpuMz8TSc41Rd0CqgMrnRmAyd78hXoOyX20rMVzW4B7HRPk7TWzG9UcwF9bAMMOpnNi
         5KG71st3Onz74dD68Cw8bWC4wpd8lvi9ESsctxt3gVrqCZsExjVp7M5pphVhUT0c931v
         Vl95nnDw5TBMb8zVk6XgFKjP1IdC97ToI9Lg1/bpesW7gVg2TMqkvBr3P+Y/OUPUPeFo
         2s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PbyIiFufSbyo/g1FNw00PACXkHOg84yyaWNB5eBEYCo=;
        b=X35OHsFFb2T72LtIGHe2NEADp6NjNzTWNIx6dx8RLW8xQ2GHPfaXM64d3mOLklrYZO
         GkacqnOdrWHh4e3/VzAXK4d3gfyRsMMhxhQNBjjQy+NXxng59TxLyx2xb9tJJxfcBgZu
         ZF8Cze0YBqj6OFyaSxhp0HISNg51p2Q+a3vuiEibRb797E1P7JqD0LJICMPqTRjPFbAM
         lsgaXoiGkoMVJBvWd/O0xvMLGywX+Bxua2ilOA7feXwZXJbBjC4+QZtwDKP7NxewHwcW
         Gi4r7U63Ci7+VUvxecxb18WtsRDbvknPyfi5hxW0cQ3N0PJqTE4oeywCykoVPlG6A6GL
         kdFQ==
X-Gm-Message-State: AOAM532GhF/oE5altArPRoSY/ZHonktEWJhAb6ph8qJVtOVUXWrKoc0+
        VP0QlcYLAeU8MrCcdGyaz4b0BqXuGqUfo4EUasdpGCL0bO/G6XSTkSWt3Hw1cCtCxdcGOC41Yvc
        gFOzo24ppmudx9yj3VOvXlWUSi29igWxwiema3ThcVWlTbqBLV8fgLxlPBMxXLw/KCu594i113w
        ==
X-Google-Smtp-Source: ABdhPJzdGmFvfMYboTX/WogeSQ2IyNEPpkM/5cZ+TPkaDg+td5BNhIbHyGDRPiUP54mr27EiweiTcufdM2hxcisXjEc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:fe4e:1417:67a4:42aa])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:9b82:: with SMTP id
 o2mr1652721qve.47.1619136946577; Thu, 22 Apr 2021 17:15:46 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:15:37 -0700
In-Reply-To: <20210423001539.4059524-1-emilyshaffer@google.com>
Message-Id: <20210423001539.4059524-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210423001539.4059524-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [RFC PATCH v2 2/4] t1510-repo-setup: don't use exact matching on traces
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests which interrogate the exact underlying behavior of the code under
test, instead of checking for the presence of desired side effects or
calls, are a known testing antipattern. They are flaky as they need to
be updated every time the underlying implementation changes.

By using 'grep --fixed-strings --file <expect>' instead, we can check
for the positive presence of lines we are sure should be happening, and
ignore any additional things which may be happening around us (for
example, additional child processes which are occurring unrelated to the
code under test).

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t1510-repo-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index bbfe05b8e4..8bd4f54d03 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -63,7 +63,7 @@ test_repo () {
 		rm -f trace &&
 		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
 		grep '^setup: ' trace >result &&
-		test_cmp expected result
+		grep -Ff expected result
 	)
 }
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

