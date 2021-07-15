Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED3CC636C7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31907613C4
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhGORrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhGORrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:47:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B633C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:44:43 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ot1-20020a17090b3b41b02901733dbfa29cso6268040pjb.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MCXirLcD1cb7d90D8zMsYpJZG1GEX1vr1fg5guTPV+Q=;
        b=EClTQ0B1GDVSV9gpRICqhJ8AvewvC5ViUC1swxHdqxcfrYhh6hvTqVNsbyCAGKA8fh
         N6OUQYBq7wFUMK6/515vqwP/g2OBbQYD5S94bazywxxPnavEsH7TOngm+DaNxRwowlz6
         p09LABmxsOHu0zZYEBPYTH/eJ6K9ZX1ZvIE6Wj9KwY77w3aZEKK2q4CxUAQBdwKIk5L2
         3J+ZLuOph4abiHzIATa/tg0AT8uGu6SOnB+L9ztEPK4F5Qu/5Bs74REy+X1R8VV0LfXn
         ohFbI39J2miIvTvum4aZXwhYsyTS517M5Q70+OezqwxIHdIceWyMHjGsWUZ/zypPwFjj
         bftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MCXirLcD1cb7d90D8zMsYpJZG1GEX1vr1fg5guTPV+Q=;
        b=kFeMV/PUa4ndTaYQgcNpoh7EWv57NO5CL5GhQPlvpwsSmFGefr5xudQ/BrLzch1hrI
         WNtYvBhYSFYMdVm2tQLaE4MNsvSc9wR/juBUgHLwCgMXM9xfSpvTXB0F59wtTAZu3EmC
         OmlqLeJQQqG949rqut2NLKIr7QWyqkhCIHiI4hgRNZVsF+EbKGR7NIR/pdDU7vDPuZM5
         7GV8vOK9GevaCyi/wjtIjl54oqj5nsfuq2xPRQRGcOJm7m57tf/QuAkekuJa8hh16aeO
         yFvR2G6vF3dkhn+pF4dyjmJBrYeCyv785t5iVzZaU0wq0I8CGfGoBbDuMVHnzCD76BRh
         ZdFQ==
X-Gm-Message-State: AOAM530t7BKjsdFqisTffZAa5P7XKTydMPhQC5jZRclBwcjbSzCnzs4H
        I4IfMpdH01STtooY7HwpNkW93XbF6t+mAl0YcjgsiCZtw6Y/9teD4m+9oBMW1DXRJbpkeP7rz1B
        T6FsCPWiz+PKrSDys31s/OGRZkJGGd5MT73l2Bt9dVJCiQPDL+qOZh6NdXL5YfAfNsnNVFtPcil
        P8
X-Google-Smtp-Source: ABdhPJzKAoXECeeN9NlNuIAp1DOHx1t8y5PXsYc+FHUGy/+Rk0M2btaq3DjpQgx/w/3PSrQhs0Pe4w2C0I4jyM/CN2Bs
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:800b:0:b029:330:455f:57a8 with
 SMTP id j11-20020aa7800b0000b0290330455f57a8mr5566455pfi.7.1626371082494;
 Thu, 15 Jul 2021 10:44:42 -0700 (PDT)
Date:   Thu, 15 Jul 2021 10:44:32 -0700
In-Reply-To: <cover.1626370766.git.jonathantanmy@google.com>
Message-Id: <476da85859eb333573c3f87cc7284b8b28032214.1626370766.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1624486920.git.jonathantanmy@google.com> <cover.1626370766.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v2 3/3] fetch: die on invalid --negotiation-tip hash
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        emilyshaffer@google.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a full hexadecimal hash is given as a --negotiation-tip to "git
fetch", and that hash does not correspond to an object, "git fetch" will
segfault if --negotiate-only is given and will silently ignore that hash
otherwise. Make these cases fatal errors, just like the case when an
invalid ref name or abbreviated hash is given.

While at it, mark the error messages as translatable.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c  |  4 +++-
 t/t5510-fetch.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index dfde96a435..0aeb043840 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1428,7 +1428,9 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 		if (!has_glob_specials(s)) {
 			struct object_id oid;
 			if (get_oid(s, &oid))
-				die("%s is not a valid object", s);
+				die(_("%s is not a valid object"), s);
+			if (!has_object(the_repository, &oid, 0))
+				die(_("the object %s does not exist"), s);
 			oid_array_append(oids, &oid);
 			continue;
 		}
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e83b2a6506..a0faf0dd94 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1214,6 +1214,19 @@ test_expect_success '--negotiation-tip understands abbreviated SHA-1' '
 	check_negotiation_tip
 '
 
+test_expect_success '--negotiation-tip rejects missing OIDs' '
+	setup_negotiation_tip server server 0 &&
+	test_must_fail git -C client fetch \
+		--negotiation-tip=alpha_1 \
+		--negotiation-tip=$(test_oid zero) \
+		origin alpha_s beta_s 2>err &&
+	cat >fatal-expect <<-EOF &&
+	fatal: the object $(test_oid zero) does not exist
+EOF
+	grep fatal: err >fatal-actual &&
+	test_cmp fatal-expect fatal-actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.32.0.93.g670b81a890-goog

