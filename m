Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B4C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhKVSo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhKVSoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:44:25 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54537C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:41:18 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id iq9-20020a17090afb4900b001a54412feb0so344204pjb.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ndyvjxWaeYb8PAIa8wuegvcFALqKom64nSch9q5g3ZE=;
        b=Rc660D0n4UOh1XRjomWIQNDQwfW4DXGsU6tuKqxGb4a4iDgimnGI9vnWcuxIh2fEvb
         zI55pbjjsEmWsBQg1B3lzzT6NvJAv9xPesaHqXsW4j0KzsAdqcJHO/WO6Uv9trAqIAGr
         22iuXQdADWK5QhjBz8Rm0uexQ4HmU4wG7PIObbRRtCApNJvLvD5d0zbaj5yrE0gSBuRJ
         jXjqVkhtmlOJsrW7CWSLYEfhIMnANNauk398r/0ZVBLoDa17GoGnjlwmcPHl7fscqENn
         +iQZtVC6+Jx70D1AqS+buHE9vyvK0cvvo/qXmIiWL6YrjBBsWUNM3l7rXYolUvCfHIU9
         FkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ndyvjxWaeYb8PAIa8wuegvcFALqKom64nSch9q5g3ZE=;
        b=5ld7QTcxuSRgNSAz4k79yoAJWkng+oJKLggMdnBfB9J12sTgeUNgHVVZXOnhHMX0SL
         p+vNsLO+leam6AaMmetpPxL1MWy62zyAt7CBUHv8gPJzpzb2n2rxAuGV839Ti9n09LpG
         dukMnIcuVrdd3sOnbFikJEcRDmGCO3ujAvY1Y30oR4CG4PcY6ho334zgiu/O6THR8MfB
         wFI1IZCoTexFhn7sEwCedjwuXVCxRJR6wEHAJUDyjWze6DKji3AZB6bYbJ3+GdZK7Ynb
         jgClmCjMcZB3hm+G3sjLTEPAHdNNRu4qQYbjYFvSzZY2oZvPjWuM/n/OARnnTcB0wg8m
         KBbA==
X-Gm-Message-State: AOAM53211rcUEluqv1osV1qCQMQdtsLtkkte3vEzbEl1wfQYF5/h/ty0
        q3bjqEAvJhsBLtuFVQX707NKwZk2s0RF29FdVLHUUFR5oMf1+Ip3gAcpMTB5KKvsDo04ATtmma1
        LJ4x7RyLh2w7YG1dSdjz+QwzVV4D31ICPEshG1qzfGR8TVvUbD6UW8KoleY1InlZTZb2LReW0dW
        fo
X-Google-Smtp-Source: ABdhPJzsObNtIHkLmUff/58dG31PfeDRgUxkOMgRxaOz1T+kr15FJGbV+f2snLg27ftIJB5cthjDpsZy8mPB+gxo44y8
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr35071pjf.1.1637606477148; Mon, 22 Nov 2021 10:41:17 -0800 (PST)
Date:   Mon, 22 Nov 2021 10:41:14 -0800
Message-Id: <20211122184114.3328662-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] Doc: no midx and partial clone relation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack index treats promisor packfiles (that is, packfiles that
have an accompanying .promisor file) the same as other packfiles. Remove
a section in the documentation that seems to indicate otherwise.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Stolee, can you check if my understanding is correct?

To my recollection, midx does not treat promisor packfiles specially,
and searching for "promisor" in midx.c seems to support that (the only
results are relating to selection of commits for midx bitmap creation).
---
 Documentation/technical/multi-pack-index.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index 86f40f2490..fc213cd1e6 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -87,11 +87,6 @@ Future Work
   helpful to organize packfiles by object type (commit, tree, blob,
   etc.) and use this metadata to help that maintenance.
 
-- The partial clone feature records special "promisor" packs that
-  may point to objects that are not stored locally, but available
-  on request to a server. The multi-pack-index does not currently
-  track these promisor packs.
-
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=6
-- 
2.34.0.rc2.393.gf8c9666880-goog

