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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE888C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C23610C7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhDIBKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 21:10:22 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544BDC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 18:10:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p12so1562460plw.0
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 18:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9rG1RVlYLpWnmmm7A7tHfxBU24I6z4/saTdGC4Vl0EM=;
        b=J3RzSEBFY4qOnsbKLR6UWt7pQMqYKTZzL+Lww7uyd5HeXGzjLE9xZMpEcjHsh2LvmU
         b1GJ9T+InT2iWZsHOiycy6AYGkDi0MsYAB1lSEkJPV3bYb7YKEkD0DUbSsQ8kSZsOpGb
         hLBBUJ+v8Ad54HNHg4wwWgJ9xVl765N03sVjo77idkAEsDCdZfOUkPOwoeIQ7hIzEdtX
         NDrxc5FjrvIZwkYrMN17QuQR2O/dPPhNMVzKOZL5lF7CZcuk4gRoSAxp7XaHGIGcdHsA
         8t1TjAoSqayRBqV+XncawkpTC2UXvAqPByqHHQjMScCEozVv6s9h0Terz4emYPY3V6V1
         YRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9rG1RVlYLpWnmmm7A7tHfxBU24I6z4/saTdGC4Vl0EM=;
        b=PSoPe2xZAvvtXQ5T95HmRfy97jYgPFYhLIizqN/QuYcIGw8Qs8ii4L8eAA0BLXkbq0
         fqq3JfJxs6EPdPIQwEts3eA8ZNS2XoAR9fd+GDZn6vmSeF3Sq+fYSKV01Bzn74SvYDzE
         AqszMLMKd5L83rEPsy6onyFEDj71cH26Mjs/K452nXSTkMfAomPDJkufcMptvJPxcclj
         8zOzxwKikdc0OqiWDwmlqnx/PVpS5aVAKMCQsjfYTBx8LhRET1eSZchehbBKjkN93w8U
         oGShj7HcySWw9Ph3yytUtffbagM0cMFHjMhD2py5zdPiLSsFdjO4hmMnxlfWJWnVsxM2
         chig==
X-Gm-Message-State: AOAM530k8ndxgCeKT22Bz6VlXU4P6cJPG8M1RAm737aLGAUwK0lDPwP0
        9qHJvWIkyB5rc4Igxn8BNOpqb+W05OcUJoWKnD1kzgQ3oz8os0EycaS+a0G9MHkP2kWjNlgqurE
        yF/MgkSFh04KjHSbnrzINswGV5G5bc+XlKiMdkJ/am0RNwDFVq5ky8ZAzPuuHQsEk4WZ2GqlA0/
        NS
X-Google-Smtp-Source: ABdhPJxl02FoaUR/as8YA+58cNf6//+9zeVpApeSBO1xa9rwAAxKnfGt7P2Udm8FZ0FlPKK3rP8alfWE9MaTSMipwkJi
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:185:b029:e9:9253:5328 with
 SMTP id z5-20020a1709030185b02900e992535328mr5418243plg.58.1617930609697;
 Thu, 08 Apr 2021 18:10:09 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:09:58 -0700
In-Reply-To: <cover.1617929278.git.jonathantanmy@google.com>
Message-Id: <86e4ce0e8d9665b1c5a2b30173be4afffe0a0abd.1617929278.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 1/6] fetch-pack: buffer object-format with other args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In send_fetch_request(), "object-format" is written directly to the file
descriptor, as opposed to the other arguments, which are buffered.
Buffer "object-format" as well. "object-format" must be buffered; in
particular, it must appear after "command=fetch" in the request.

This divergence was introduced in 4b831208bb ("fetch-pack: parse and
advertise the object-format capability", 2020-05-27), perhaps as an
oversight (the surrounding code at the point of this commit has already
been using a request buffer.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6e68276aa3..2318ebe680 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1251,7 +1251,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);
-		packet_write_fmt(fd_out, "object-format=%s", the_hash_algo->name);
+		packet_buf_write(&req_buf, "object-format=%s", the_hash_algo->name);
 	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
 		die(_("the server does not support algorithm '%s'"),
 		    the_hash_algo->name);
-- 
2.31.1.295.g9ea45b61b8-goog

