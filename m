Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C32C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 20:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiK3Ubb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiK3UbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 15:31:07 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305134E690
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:30:56 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u15-20020a170902e5cf00b001899d29276eso7074758plf.10
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqK6HkWezKvySIHusR17fdjJw5ozc30S5dl097gY6+E=;
        b=sx3TfKK1R5sdes/RF1RasncChxmVsLHydmGVIX79q6maNxPproBwtCepG65mK8tE9Q
         7ZdwfKND/DUpeCeYeQukblGa6OJdt/M65ynmpQqmJrXwnu616+JyoGJwY7vmfU+tJH9N
         9QuuPxBKMjvFc3rwgnOOO2+qfxiG2RzLOSnlIFJ3OzylEjOMlscMVPTmrrOlubd6dtnz
         cbKnwZ/q0PbGkcCb+w6xO/Y5LLCtOhXL7pImnNjtEdwHGrMlNnUWTpIoQYC4RY6vmHtG
         XCxmtVJfxTrsqGOFIe45WuqJj0riLe4lyfanG5bzsv3lU3ZqugNftren1Z1WCiXVbtK+
         LGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqK6HkWezKvySIHusR17fdjJw5ozc30S5dl097gY6+E=;
        b=iJIOO5Wuh9ZKH/9z28z4GQUxUH3xZIyib/n4cLgMg7pXsZn2P3k80gLQ+P5kzgqfVl
         r8ANl8XMG5ZprvTow8KzvbTpQbTfcFejcpMBMwjXCJX3BV29CozHY6iOfRPGgnUsK3uS
         Z2U87fL+feFd6bIzauOwrn+QHy0cEPRmou3vpNIoTfh1rBGIjdACUXRroockPZ0m6aJY
         NdzarG5vfVVmWJqCiXtpkhkkJTJKsKrgJunrg0qOVyxSfoGOt92G/HvIrkLQHhg64h3w
         ZwIW+eMX+li2p/LgDa7mLkhFTBBSTYijJyz3NhBf1Wc9NaTWrkVMQ5wzQnVQ0FSo3v2d
         WEOg==
X-Gm-Message-State: ANoB5pnZhOokE3C8o9W2L07eL7stn6bWF0/qiLtFsLGwD5OrbIAAl99K
        pPytvv31USinXbjLrJDYST6f6Pw5V+c85CUNqBVRZtpgjydvzF5r6rZrShElg/gsrhKaPpms49u
        EjXsKEPORxntuIRq+R8+2fPwxBrP/qq2tQEUSjOFjDQFtUGd3yrG6MjUwmxdkmjImy23Hk3uial
        jO
X-Google-Smtp-Source: AA0mqf583nFDtdBNbj7uoh6nQwGvXTbsJ0N+9jDMUtChUoR8Lo+9GHg+wauU8CGrdYIXcV4s3gUGrXrpWSZgG8FmPBdv
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:f92:b0:562:317c:2a8 with
 SMTP id ct18-20020a056a000f9200b00562317c02a8mr66534322pfb.49.1669840255628;
 Wed, 30 Nov 2022 12:30:55 -0800 (PST)
Date:   Wed, 30 Nov 2022 12:30:46 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <604160e79cef94fd8e03fe025990c999bb795395.1669839849.git.jonathantanmy@google.com>
Subject: [PATCH 1/4] object-file: reread object with exact same args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an object in do_oid_object_info_extended() is found in a packfile,
but corrupt, that packfile entry is marked as bad and the read is
retried. Currently, this is done by invoking the function again but with
the replace target of the object and with no flags.

This currently works, but will be clumsy when a later patch modifies
this function to also return the "real" object being read (that is, the
replace target). It does not make sense to pass a pointer in order to
receive this information when no replace lookups are requested, which is
exactly what the reinvocation does.

Therefore, change this reinvocation to pass exactly the arguments which
were originally passed. This also makes us forwards compatible with
future flags that may change the behavior of this function. This does
slow down the case when packfile corruption is detected, but that is
expected to be a very rare case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 26290554bb..1cde477267 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1621,7 +1621,7 @@ static int do_oid_object_info_extended(struct repository *r,
 	rtype = packed_object_info(r, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		return do_oid_object_info_extended(r, real, oi, 0);
+		return do_oid_object_info_extended(r, oid, oi, flags);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
-- 
2.38.1.584.g0f3c55d4c2-goog

