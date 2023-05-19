Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88ECC77B7F
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjESESm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESESM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:18:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072F81711
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:18:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f475366514so18846025e9.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469880; x=1687061880;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUxDjmR2HiA0zivtxzM6KGVGVfv1DJVlGyegqAInWbg=;
        b=S/5vkgLwCx8dlNu2qtMSG46yxanQ5zAddCHVfZKkQ85sKDW5AQefxRir+0sgtU5opL
         cVL34Zg9N0s88c8/Bjgnv8CNicWtG7rQN75vaBejAbyEfwCF78eYDO9GcefBSPIo1E36
         kHri9YN7XVWKTnyHiRmHaN95OrJunxqu5r9EaIIGW8KL7n8a4ZivBezHDyCX8YgbEcwo
         pIFSnYw/B+hOmF9mnwyyP8VlgrJDPuOZq9/irkn6jxIh/GS3XPjc0Md5Kfu4vZWsoIbw
         c3NtcIWaGxpf5lQixy6QQSBk9SAfeovWzznlR/lRGy6ga4yL465PvLCwU7nHvLLP2F8I
         Cokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469880; x=1687061880;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUxDjmR2HiA0zivtxzM6KGVGVfv1DJVlGyegqAInWbg=;
        b=JcNa062BKavE7NBJZz4f0x1YLw0nmbjj59MWa/Ir/JaGPAu4njL2aftcY/XuHr+x03
         e7cAZlJUxTekulrCx+eEh6dWEYxtfpQs9GpXSGI/wuTM0L/fvDnWQXqkZhuZagm7AMBk
         zlW1SJoVKdoscJph2KJk6Bi9OpiwvnIVKUpnBfhaJ1BmYqKVeMeVemnNF0ruQy+l9Ggx
         zx8HaiWx2BS27GmlcZimT91nBzGdmeJdE6KEuhd0b+5vO2W46BsuScVT4EOW1LbzYtg+
         dcFd0ueyLzbMh/2pLP5aygUG+9HCsLmkTH05NIJFXO16eAcv9PJiKaUnrAJcYKKGDva9
         1b+A==
X-Gm-Message-State: AC+VfDzwKw7enxQ+NcVtNr21jaYiLwxztR11tjH65C6wX/YR67k5Us8e
        0FyaZAMvjTrueHTsx62u2WHPsxtBAK0=
X-Google-Smtp-Source: ACHHUZ7mcuO20XI/UO7n+jxyMubKbjlk9KZxfhBpU9G46iTWCHcTWWjvkOyiZ6fwrSRU+LHB/IHpwg==
X-Received: by 2002:a1c:f20b:0:b0:3f4:16bc:bd1b with SMTP id s11-20020a1cf20b000000b003f416bcbd1bmr188581wmc.39.1684469880206;
        Thu, 18 May 2023 21:18:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a7bc5cd000000b003f423f5b659sm1033559wmk.10.2023.05.18.21.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:17:59 -0700 (PDT)
Message-Id: <115dba15ce03bb2aadac43810738bd762d837b41.1684469874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
References: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 May 2023 04:17:54 +0000
Subject: [PATCH v4 6/6] ls-remote doc: document the output format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

While well-established, the output format of ls-remote was not actually
documented. This patch adds an OUTPUT section to the documentation
following the format of git-show-ref.txt (which has similar semantics).

Add a basic example immediately after this to solidify the 'normal'
output format.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-ls-remote.txt | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index c0b2facef48..1c4f696ab57 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -96,9 +96,35 @@ OPTIONS
 	separator (so `bar` matches `refs/heads/bar` but not
 	`refs/heads/foobar`).
 
+OUTPUT
+------
+
+The output is in the format:
+
+------------
+<oid> TAB <ref> LF
+------------
+
+When showing an annotated tag, unless `--refs` is given, two such
+lines are shown: one with the refname for the tag itself as `<ref>`,
+and another with `<ref>` followed by `^{}`. The `<oid>` on the latter
+line shows the name of the object the tag points at.
+
 EXAMPLES
 --------
 
+* List all references (including symbolics and pseudorefs), peeling
+  tags:
++
+----
+$ git ls-remote
+27d43aaaf50ef0ae014b88bba294f93658016a2e	HEAD
+950264636c68591989456e3ba0a5442f93152c1a	refs/heads/main
+d9ab777d41f92a8c1684c91cfb02053d7dd1046b	refs/heads/next
+d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
+73876f4861cd3d187a4682290ab75c9dccadbc56	refs/tags/v2.40.0^{}
+----
+
 * List all references matching given patterns:
 +
 ----
-- 
gitgitgadget
