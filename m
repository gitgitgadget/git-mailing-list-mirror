Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8131DC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B8760FDB
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhETANV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 20:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhETANU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 20:13:20 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69904C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:12:00 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c13so6613066qvx.5
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9LTR3EgojnZXa1EmbOb1mWXwktsByA311lSxxT2wflQ=;
        b=jGe/utFCZlbvamA7Rpn55oseUmjCyqyHZZuyOCouqkj6Ije9qiSrJ9i12PJ0c3Ek/O
         z4M/7bJIt1dueo+Z+gd9N1ucCoEE9ytwU7CzyfPHAPlzPqiVaxF9U2Qz+gqFnF7YuKir
         RqBCtS1Qem8kE99ERJb4UHXadxxsQqvi8foFXM8AhDe2W5h6IwuF2Puc9FL24NJHWgfa
         NCOnpFNqj2FO2yDGLJ4+X4ItVihSzt87briYBNdUVNIXUTBHS3kn3ZIvcOB9ClA0vwOo
         3/lJxnD1uwLXXtnrnU+A+maPfbd2lIPNm0QnRUjeTMDfQ8WK5z7NPgb0fVbkAIp+bUbd
         l69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9LTR3EgojnZXa1EmbOb1mWXwktsByA311lSxxT2wflQ=;
        b=aVN4ziBxEXpb3GTRoKv6uuRgGVbR6ZX7rLbdK0uBKHlUM013zwhRTnxzfhlBhFHMXL
         GOszrcQ0X1t9floYCdUDXcl1IOkmpr3fgdf3Fg+FjKoeEHuabw+b0bQQqlDGttPkafm8
         GnlQ0QJBINnwqDGjwrLJLE9mAihOIT2G50Xl01HCX4T8AUFFeEQOl4F7rViVf8NIz6V5
         yeFia3jin0NmWk3rUwP8uVlXO3HYQkJPvMRYkGTXYXgdlQdHu7ZGFjLbLtteep7ireer
         ic5mKT3NASLxHb++P6Ddfa7SCpU8aXfoXX5jqdhmZNCtFi2ElOP4WZcTjtBbD3ITapC1
         rEjA==
X-Gm-Message-State: AOAM530Qn09ejrb5LqC8GxequByhv85Ba5Qgd31rXLgXGfAEQdBMGXYa
        H6MXD1vPzBlIfzYMp+lUNGVZnkHLTfcGIyGSAkA4ljLFBr3rsw==
X-Google-Smtp-Source: ABdhPJyrs6PAQTGXE/YlL2ysU17PMoy+Izg+Jx8zLMMSgSOvTl6MVbU6G+M6vRXePMe3oMOHd8LUWESZ+TyqLNzQudY=
X-Received: by 2002:a0c:f603:: with SMTP id r3mr2512042qvm.59.1621469519445;
 Wed, 19 May 2021 17:11:59 -0700 (PDT)
MIME-Version: 1.0
From:   Weishi Zeng <amwish.zeng@gmail.com>
Date:   Wed, 19 May 2021 17:11:48 -0700
Message-ID: <CAH6yD_bkY+_7XrzHdOqnnE=qvnnvxAWEQPtOyVh=BwvbcheTCA@mail.gmail.com>
Subject: [Bug Report] git log -L:<funcname>:<file>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Summary:
git log -L:<funcname>:<file>
would fail if there's any java-style comment that appears before the
<funcname> string in the file.


Details:
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git log -L:'myFunction':~/a.java
The file is a java file that contains comment before the function name.
E.g.
/**
* comments will interrupt the regex match
*/
private static void myFunction() {}

What did you expect to happen? (Expected behavior)
As described, it should return me the commit history that touched this function

What happened instead? (Actual behavior)
It returns error:
fatal: -L parameter 'myFunction' starting at line 1: no match

Anything else you want to add:
If the function name string to search for appears before any
java-style comment, it returns a valid response.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.1 (Apple Git-130)
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.4.0 Darwin Kernel Version 20.4.0: Thu Apr 22 21:46:47
PDT 2021; root:xnu-7195.101.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.5 (clang-1205.0.22.6)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
post-commit
post-rewrite
