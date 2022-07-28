Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6789EC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiG1XCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiG1XCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:02:33 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D568DF9
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:32 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h8-20020a170902f54800b0016d9db4a55dso1921296plf.9
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=gw9HG870JjOPPSt4OJeW/zzfptYLg/V2X51R6t9Fnr0=;
        b=cp6HxDXkIAdrVcXtEKQDK6VZMRPCBUAsoVKh2VocltFAXGHvV/usjDE2GZrdATewIH
         O4Yqtxtmp8GU7P4K7SI/r3YKUIwRgf1nkaysBrYU9x7jywFMs0LnIhsMH/o5fuvvkLrp
         OCHXMwULIYbhHEQ3Sk1pSUcFmAM/c7xDfveKk6jS6xJoua0XQIeYSt05xCtCmSt5+k3W
         4WZlwbYYXsH8X97PbBmr+qSS9BbLkml4039ThqCcfRJ6FwNRm2DXESeKvK0ZSxDpQVtp
         Uxa2Js3EFgHDz0XAsQ+pTyISQ7fewAuriGu3GTeGXJZliFTTgYF7KQvwPotYXwLqFHtg
         C4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=gw9HG870JjOPPSt4OJeW/zzfptYLg/V2X51R6t9Fnr0=;
        b=1T5GecXHJCcyN451pvrUgN+PZJS6MQa0jBSHAp9fftZRVHUYWMt7tguQqEWd1tQXQX
         l6iynHyF63JX0zyVHPufSvWr7QLE6x+kXNdeARcGwLqYb11YjlCMUfKBKMvr9dAdpMvy
         LO6fZyBMtkNuynkYwva4YGN+yQp5iKdN1EieXVbxVGyoDOI3Azcq0Wk24IhEmiFcGuOt
         Cg4wBmAEgHi0vtH1POyPxSK8q/qDEDtyikmR9gVbZxDvq/komkRUDYGLBA/UNr05Zb3c
         aQ9pWRl/z88ujecArmIHBmiOx1vo0lrNOEXCSd5KpY3eLWeg3HXNLlwx/gZ1fTVgJhUB
         OYeQ==
X-Gm-Message-State: AJIora9B8oziWKEZf6vgxdUIuuRxWauigEl0VzOOxQXLyl33kxKtCXUy
        JZbdQ7VPuDeYeOVz4ciqvfIAtvF6X6A0yn2WIQj6UyJwRYF3F8vuuONRuODz+xMEcKFCA+kfUK7
        2Ygeo6XAfeWAWcSh/VTOga8tGsusqYmXQvn1REUujf2qH36QKYftPmdqCMLTAq1j2RA==
X-Google-Smtp-Source: AGRyM1twzhGMDQfW2zyVSc60vWIcuy6mmLoZ8DnmZU9TPvCkfWBRgE/WySEPCtlYto9XdFtZrGy1a5y4cyxQt0I=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:428e:b0:52b:7e40:56cf with SMTP
 id bx14-20020a056a00428e00b0052b7e4056cfmr725714pfb.72.1659049352009; Thu, 28
 Jul 2022 16:02:32 -0700 (PDT)
Date:   Thu, 28 Jul 2022 23:02:07 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220728230210.2952731-4-calvinwan@google.com>
Mime-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v5 3/6] protocol-caps: initialization bug fix
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initialize info. If info.size bit was on due to on-stack garbage,
we would have given our response with "size" attribute prefixed,
even when the client side never requested it.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
---
 protocol-caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index bbde91810a..2ad9f45c59 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -77,7 +77,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 
 int cap_object_info(struct repository *r, struct packet_reader *request)
 {
-	struct requested_info info;
+	struct requested_info info = { 0 };
 	struct packet_writer writer;
 	struct string_list oid_str_list = STRING_LIST_INIT_DUP;
 
-- 
2.37.1.455.g008518b4e5-goog

