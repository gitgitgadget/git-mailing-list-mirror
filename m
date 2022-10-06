Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3731AC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 19:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiJFTn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiJFTnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 15:43:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F1E319D
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 12:43:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r132-20020a1c448a000000b003bd44dc526fso10622wma.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPgyp4ckHqvvaJ6baaVJ8Jv77VXRgfst9Y/kaPB2P8s=;
        b=qpv5N+ONCXFCfRAgI2xbIcRloavUZH6qQS1ySgus6IzDzEtshfcF4oSLUbVaUk+8qI
         E0sKFsiEcUbXDaJq9DF/VZL465+U1tW1oYh19mp+8m1jKCxeYznUUGbOEHlXAnx/uqRr
         Z5KFdKoPSp7ZJZaD9TThgMjsYY7XItSQ1D7XtnFETfPH/PUjgTW2eSBV8ErJriiTq0wN
         QbOsA4s/4RNXQLz763xaaxcf3r9KBmQ644QDXfeyCup3mSMw6cVYcTl7r6w0YRzN1zRK
         Q/Oj1qwhA7FPkUuh8beddYzKDsUJ4IEVFh22u41wGfDZyDShqqAPxivfkN75qDBiQ46I
         Rpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPgyp4ckHqvvaJ6baaVJ8Jv77VXRgfst9Y/kaPB2P8s=;
        b=45RdQPOmUUGEz86iE3xvGmyI6PeY72gyxo7QGefI2Ba86bxCy+KM5O2i2JsGMs+9D5
         +5MoWk7A/4RA192S1YPTAkyfcVu44d8vWBhsn05qhDp+I9I95MEkgTr4q03aNGix26oE
         ra9V8trWmtwcQNFIy8dcNFAnBYiRmYEWE6hNGNNX+0g+KN5wFVnEDM1PEsw9fOatklEI
         +pMfFJgH8W9tjwWWPtTih/6tpF1AwRveM2GYUXU7ktzBgiXj7pbVk0SQ0LCX8pMe6J1q
         oZrmfVJzIHJL6eOryY/m8cET+AzOaMpg7n8ttB4yPW0EsyQdjSKgwbapscc4nku72BDw
         JL1g==
X-Gm-Message-State: ACrzQf3q42rNy0lsOPcPcW6u+fxvKXZZMWAhd9imOO5aC8cFBo8pLqTM
        aQ5mFXh3XvUrUtvktfvRRgzvpove70w=
X-Google-Smtp-Source: AMsMyM4fJgD1EbPPuPqXnCyqw0OuyfP6JKJLpVwrFUED1kOwNlFsb/Sgq0WK4KwHBuoadfGxCrIOLg==
X-Received: by 2002:a05:600c:4ec8:b0:3b4:bdc6:9b3d with SMTP id g8-20020a05600c4ec800b003b4bdc69b3dmr7955894wmq.181.1665085397801;
        Thu, 06 Oct 2022 12:43:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b003b4868eb71bsm6263587wmq.25.2022.10.06.12.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:43:17 -0700 (PDT)
Message-Id: <7cee38788a7a3c2c09a238e01c5bd825445f999d.1665085395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 19:43:14 +0000
Subject: [PATCH 1/2] builtin/merge-file: fix compiler error on MacOS with
 clang 11.0.0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add extra set of braces around zero initialization of two array/structure
variables to resolve compiler errors/warnings from clang 11.0.0 on MacOS.
This is not needed on clang 14.0.

$ uname -a
Darwin jeffhost-mbp.local 19.6.0 Darwin Kernel Version 19.6.0: \
       Mon Apr 18 21:50:40 PDT 2022; \
       root:xnu-6153.141.62~1/RELEASE_X86_64 x86_64
$ clang -v
Apple clang version 11.0.0 (clang-1100.0.33.17)
Target: x86_64-apple-darwin19.6.0
[...]

$ make builtin/merge-file.o
    CC builtin/merge-file.o
builtin/merge-file.c:29:23: error: suggest braces around initialization \
			    of subobject [-Werror,-Wmissing-braces]
        mmfile_t mmfs[3] = { 0 };
                             ^
                             {}
builtin/merge-file.c:31:20: error: suggest braces around initialization \
			    of subobject [-Werror,-Wmissing-braces]
        xmparam_t xmp = { 0 };
                          ^
                          {}
2 errors generated.
make: *** [builtin/merge-file.o] Error 1

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/merge-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c923bbf2abb..607c3d3f9e1 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -26,9 +26,9 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
 	const char *names[3] = { 0 };
-	mmfile_t mmfs[3] = { 0 };
+	mmfile_t mmfs[3] = { { 0 } };
 	mmbuffer_t result = { 0 };
-	xmparam_t xmp = { 0 };
+	xmparam_t xmp = { { 0 } };
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
 	struct option options[] = {
-- 
gitgitgadget

