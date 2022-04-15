Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A99C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 12:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352951AbiDOMGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352742AbiDOMGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 08:06:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71850BC854
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 05:03:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u3so10456124wrg.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FlU2QuEnr9gxGyrGYeoOj8wHr8lOa8svVTcm+i/X4ik=;
        b=Xa7qQDcgHXSBUqnUkANwhA+8LQBDJ3krf5q+9r6/b+udWdGO34EcRezExrHM8uDO3a
         Z4ztFHfaXnjpd7QJFft3/tFikAv17+KZQMfLNG+rz3L5EBAnP0SitFTRgO3PIPL6GH5p
         6Mh0U6r/9nrmQF/bn/45DCLGBN9rpZB6gg5GvLr0SDANG+ONqKKCtgZsDZv2EA3e2WwL
         OoUW/fsDpPnQHFETEdmFaDQxKB7jS2jtq+Zzaa99tCH3qpXDECLWCKTAjnFFPaZdllFS
         CPXiUnCVOCAqnM3YNRlcw7WhMQInWnOke+1ZcR3Pe2vjj/pKTDEX/d/RKL7bcWgc4Hey
         VhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FlU2QuEnr9gxGyrGYeoOj8wHr8lOa8svVTcm+i/X4ik=;
        b=7elyXvPqumaS8fT76cOlTAefL/ckHrLIOT8SyNs1sBoLSLPZatASavcKSvSDz2crYG
         LfhTFWAjqDV3vB0PrKdg4gK/nrSgtwFbAZwAkqDtQzr1rRjFgnd+DEG3nDTvMC265kH8
         +ur098RjSJ5SdxEBaUcPepLNhjq1mbAn7fL0/DV8FS9CRWmkGJuXyG+Yjs6IbbnUDDqz
         STCg7EjaDWTZJPuumd5pkh5zmazgsF/wvvXHgue6ZkpxY4F719wT4VA27toPA7sqvygN
         XilhxmoRUdC4bqAwDuR0TKsiyRIJcDQBUMnqIK0dXNJ1Z4A18SganoSxk9MefW/KWeAI
         0qtQ==
X-Gm-Message-State: AOAM5311dN4N29VuT4weSAcYG2d8cqUBeqKJx0mjYK4030KfWtTNhiOS
        JCp3YurQ5jEWig/08qqMcnsyDwN9e84=
X-Google-Smtp-Source: ABdhPJyAEBwu0s5/ohqYarttG1Idazd05uV5itD64v4rTGw9xRUbIW8i1JRkTvDCklHM1GlLWIjORg==
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id o12-20020a5d47cc000000b002041c9d2157mr5182403wrc.294.1650024210712;
        Fri, 15 Apr 2022 05:03:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10-20020a7bc08a000000b0039049f8b3f9sm3057836wmh.27.2022.04.15.05.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:03:30 -0700 (PDT)
Message-Id: <pull.1216.git.1650024209568.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Apr 2022 12:03:29 +0000
Subject: [PATCH] add coccinelle script to check the option usage strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" 
        <avarab@gmail.com>,
        "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
        "Junio C Hamano [ ]" <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

There is no check to see if usage strings for option flags are
following the style guide or not. Style convention says, usage
strings should not start with capital letter (unless needed) and
it should not end with `.`.

Add a coccinelle script to check the option strings against the
style convention.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    add a coccinelle script to check the option usage strings
    
    Fixes #636 [1]
    
    There was a previous patch request
    [https://lore.kernel.org/git/pull.1147.git.1645030949730.gitgitgadget@gmail.com/]
    where I implemented it in different methods (first version was written
    in bash and the second version was to add some checks in the
    parse-options.c file). But dscho [https://github.com/dscho] was
    confident to use Coccinelle here. So, here is the Coccinelle version.
    
    Previous discussion link -
    https://lore.kernel.org/git/nycvar.QRO.7.76.6.2203071709540.11118@tvgsbejvaqbjf.bet/
    
    [1] https://github.com/gitgitgadget/git/issues/636

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1216%2FAbhra303%2Fadd_cocci_check-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1216/Abhra303/add_cocci_check-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1216

 contrib/coccinelle/usage_strings.cocci | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 contrib/coccinelle/usage_strings.cocci

diff --git a/contrib/coccinelle/usage_strings.cocci b/contrib/coccinelle/usage_strings.cocci
new file mode 100644
index 00000000000..3fa34001a6b
--- /dev/null
+++ b/contrib/coccinelle/usage_strings.cocci
@@ -0,0 +1,53 @@
+@ usage_strings @
+identifier opts;
+constant opt_flag != OPT_GROUP;
+char[] e;
+@@
+
+
+
+struct option opts[] = {
+    ...,
+    opt_flag(...,<+... \(N_(e)\|e\) ...+>, ...),
+    ...,};
+
+
+@script:python string_checker depends on usage_strings@
+e << usage_strings.e;
+replacement;
+@@
+
+length = len(e)
+should_make_change = False
+if length > 2:
+    if e[length-2] == '.' and e[length-3] != '.':
+        coccinelle.replacement = e[:length-2] + '"'
+        should_make_change = True
+    else:
+        coccinelle.replacement = e
+    if e[1].isupper():
+        if not e[2].isupper():
+            coccinelle.replacement = coccinelle.replacement[0] + coccinelle.replacement[1].lower() + coccinelle.replacement[2:]
+            should_make_change = True
+if not should_make_change:
+    cocci.include_match(False)
+
+@ depends on string_checker@
+identifier usage_strings.opts;
+constant usage_strings.opt_flag;
+char[] usage_strings.e;
+identifier string_checker.replacement;
+@@
+
+struct option opts[] = {
+    ...,
+    opt_flag(...,
+    \(
+-    N_(e)
++    N_(replacement)
+    \|
+-    e
++    replacement
+    \)
+    , ...),
+    ...,};

base-commit: 4027e30c5395c9c1aeea85e99f51ac62f5148145
-- 
gitgitgadget
