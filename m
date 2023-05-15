Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D794C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 12:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbjEOMN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbjEOMNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 08:13:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054BE7B
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso96733795e9.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684152798; x=1686744798;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i66nhZjaFs3AutU0Y8gQx7xe6TXqeAneOZQeAU4NaLg=;
        b=pxH4IATVIzesB2GbB6DHUSKU5osRNA42bnYsKEqp9fGDmXkeYw/ezZhqvxKkuBEaC4
         wF2OsJQk6qz++K0MjG97LSBrgoOkif9bmadGVlXCPqyIrf/yW6Un3sjhD0ysRuJZ2uW0
         2EC7KU4U714/2/+7Cv1xyIItMm+0am091j3J9pQD9Ov5rkhEEK2iGgayY/pBK14bM/b4
         DhAcyIQ6wBeLH/OJpeKbPbAySvYvObAZnc5nEHJ3C16P/NKnaULo945ZRMhdR+PjGsdR
         58oMhOTueJCQ8r2Bnr/vSvQzDR6fqPDU0banmiisW2Fh9nzdX0EfAEsrU0DYj+8ZPpxp
         /kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152798; x=1686744798;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i66nhZjaFs3AutU0Y8gQx7xe6TXqeAneOZQeAU4NaLg=;
        b=HGj75CZk3Sw0pY0lvZ1p/I/k0vm6B5Lmn/OtM70BB80UEu2SBuAZNiQ/oVTKFzDAY9
         2h2pzwwFOHyUkSUuQCCGmUT+IvkBlk9gW8YAWtjCXsHWyA8Q4ME26bsSGn49cZslsPYb
         gBLX9qpW1Rxt+AKax9/dys/E5ahByZfSxZ0kohM3nGmodPRShttz427bvUqej4dCzNFH
         Z1qQfTIxOtFqu9UuAnUipa74HFy4fGC2G90Ds9qiIHrbGfPWqEF7Od3zhnscf8+8Zbd+
         pVKjxw2NQVEDFPflW7OMKT0JFxK23J7nbL/gBIW5HsxSgniodnmgkcTYOSzHXy0aXbbn
         wf9g==
X-Gm-Message-State: AC+VfDyPBehlzPiZkzWnOOyNU+SCXQpdLRapDOVLbErQwcTeWT5jqkwl
        WPW+isycl2oGTUY3tOQU/9T+NegE1hk=
X-Google-Smtp-Source: ACHHUZ444reKwa5JQEoFYQaZkFaZTnR1MKfTGG2pT35irKXWGaR2zBX6xtqi7QX2EnxPvUj+h8qDyg==
X-Received: by 2002:a05:600c:2108:b0:3f4:22ff:812 with SMTP id u8-20020a05600c210800b003f422ff0812mr19426298wml.26.1684152798358;
        Mon, 15 May 2023 05:13:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c0b5900b003f4272c2d10sm22071059wmr.1.2023.05.15.05.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:13:18 -0700 (PDT)
Message-Id: <de57b8aa563f20b45e18dbe45abaa14a2971da13.1684152793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:13:13 +0000
Subject: [PATCH v3 6/6] ls-remote doc: document the output format
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
 Documentation/git-ls-remote.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index c0b2facef48..15313f2b10d 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -96,9 +96,33 @@ OPTIONS
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
+When `<ref>` is a tag, it may be followed by `^{}` to show its peeled
+representation.
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
