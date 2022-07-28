Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDF6C19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiG1XCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiG1XCb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:02:31 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4956BB9
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q5-20020a17090a7a8500b001f0253f5aa3so1559544pjf.4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=wgvstYkC+DXXoe1uWNdzNrd/uDiXK2oE9zEoaiEDL/U=;
        b=PaxOsm1Mv7QjIWrZWTxjHnnPAE5dgJQg1Gvq4OG8dDBV3ifdJ8Iawiq0dl8OvULVYH
         kMooCLZdJ0kMx3qD5oJKK6MEE4Ng9vR+mUc+6iJtrxKVSl9O3NRa91mWsB3utj9WDVvQ
         he9Z3jjpa/uohv6f2152LslH8SOlnlUhztnhavUKQh9NtNi+1EF5Q3zlMDUGTzRyngfv
         JYrIi+5xiKJ8RbtrCFwUsct/htwCTu5IvpXpHl60UpBCLS6fqMwlaWkv+f8dofmgezB2
         Z2N1LrfdiH19gEevOSFyFZFacxXv2Jmj8cwBR0Ft8HSHQzBBh2hKMtKUAFVpAag3eNd1
         xztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=wgvstYkC+DXXoe1uWNdzNrd/uDiXK2oE9zEoaiEDL/U=;
        b=NkAP4RbXSa8Q/6RTrVUMXuM1ZKuqTrw27cGbReMNQh1fR1H05sEXGhg380MdKawEvZ
         nYtcDWzVg+Hgx2WIW42a2klo2QYGFK5MYN1D/nj9ar80I81ae8hx29IBNdMgNDhCCVfk
         Re5FC+FZ88yUaWOMtZMA8+B22D9nr4gXV7c2dgo79osslrBGskpsZtJUW8WJK6TZj491
         egVb+hNTBct0OZxvpKyc+TCvWVKCJWS6HRROiXcJzaON/TTM6JkwQg9Z2HXGhQWLhkYE
         9IvmFQHpcdweVZO9p1ca0oEGxK4o90n9zf4Z2D6hvshzbEIgQyWIS70W/2yzVZpdTC+Z
         QmXQ==
X-Gm-Message-State: AJIora9NtQGm22pQRa3HZu3zjiCwHEwUxhaNkoiXVS+NWKNyenR68Lv3
        YpiBnElpWIcX3wkw3iB13NwElcxmTSSrRRudhYIZ1PcmU8xZTuGpXMEaXaQM2rblegjj8N8lWpi
        DMK5RpAKEeWhuj7q1cY0HhhCVKET3H4m4/QZISmi89yySYvY4MSudG1aRVDWaR/0j6w==
X-Google-Smtp-Source: AGRyM1vZDN6UUPTG1UthN8+1n/E0+J+Llb3rO/6dDLOTbf4PjKvAtJ/iOvU02tdLGjW5uaCRJ+iYBCKfsfkVKn4=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:150d:b0:52b:1ffb:503c with SMTP
 id q13-20020a056a00150d00b0052b1ffb503cmr1050831pfu.44.1659049349428; Thu, 28
 Jul 2022 16:02:29 -0700 (PDT)
Date:   Thu, 28 Jul 2022 23:02:06 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220728230210.2952731-3-calvinwan@google.com>
Mime-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v5 2/6] fetch-pack: move fetch initialization
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some variables that are initialized at the start of the
do_fetch_pack_v2() state machine. Currently, these are initialized
in FETCH_CHECK_LOCAL, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables. Therefore, move
the initialization to before the state machine, so that they are set
regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 5176420b62..8c862b017e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1628,18 +1628,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-- 
2.37.1.455.g008518b4e5-goog

