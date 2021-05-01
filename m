Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B019AC433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CB161481
	for <git@archiver.kernel.org>; Sat,  1 May 2021 18:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhEASiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhEASix (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 14:38:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520FFC06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 11:38:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q127so1474218qkb.1
        for <git@vger.kernel.org>; Sat, 01 May 2021 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=76E6wWrF6WMDj6nl0PDTBorLA7JQIgvG8Pg4nRoU4Zk=;
        b=N1tEnvvHdKF4YWdGUlMC64AiSNcaofbUW+VKxu982MNOVhoVF3x9kGpwzEa+wBEQoZ
         opr1enEmLOvxCPkJgRWzXO+0DQZhQbIrXBGyDfq6LaZsZQL7tuNrrIHvtLSQjV3US7su
         r+3/hcrcdKzlmkG4OnmFSkbW1uGurmeUO/ichYs5R/1VoA1kyIYooxnsgHfRAmiYlDB2
         diFOwW4vJ8bnKa5ll/1bzYoqz4KdDWWLrKhJqfp9JHYPueHEeZlCzBE0uHiVD+dktC77
         /A592GwINv4rFRtLFL+7B930Inw1Xf+ZKlw2hc7UF7wGLQMa3jKX1qvt6WOLW0kzjBAk
         jVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=76E6wWrF6WMDj6nl0PDTBorLA7JQIgvG8Pg4nRoU4Zk=;
        b=Rw9sMzUohzkk3ycmV/BLYwadQzaZJV/tcBORomCcIxbLRNlKXLYrvnL7KJKGLLoS+p
         5KApEAgZ5BgqAl0BK/acdi/+2nf5Gi4z20LcdDV3AU9/o5JCBcsZtmAALyr11m+zuLUT
         ocn56bn7rpMkerrZv6LRDUSdigAZVO6i/Vp2sN3nI7q+EWKIHt02p+i1Fnhydl40aHQb
         yZrw3aOym52M37D7BTQSHioJabtGQq+jt0Z6u+Wk9oRGljkvrCEkd4FsU2dpqbNWxRTE
         3SFTPRrHktFB2F42seH6xyXwG+xpEfxMYDWOObWa1Nm71Yr7oOwl7UPBYZ8/gkBBN4CD
         lF1Q==
X-Gm-Message-State: AOAM530MyYH/ujVcoM/6imXeWeS5vQLG0PJDP88tLfWLj6wXUXs4tkGe
        //GhRTkR5jVhwygysll4a7D7da9tT+Tw4N5nQ9s2EwA2+xYRRg==
X-Google-Smtp-Source: ABdhPJyLBl/OOcqeW6byu6Sqq1RU3lfAqSCxKskqfe45GgFvd4RQKeG5KnJ2LJlYzN2WksSCxMAIIgQxpTb/J+8HoZA=
X-Received: by 2002:a37:8744:: with SMTP id j65mr12315967qkd.304.1619894282386;
 Sat, 01 May 2021 11:38:02 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Jackson <mailnew4ster@gmail.com>
Date:   Sat, 1 May 2021 21:37:52 +0300
Message-ID: <CAGKR6vKwojz8_bs9oRasQPCamZJ-4mrmBKBZQCJKhX=8w+SzDg@mail.gmail.com>
Subject: gitignore + commit with excludes = bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I stumbled upon what I believe is a bug in git.
See the following reproduction steps:

mkdir test
cd test
git init
echo 1 > ignored
echo 1 > not-ignored
echo ignored > .gitignore
git add -A -- ':!ignored' || echo 'ERROR!!!'

In these steps, I ignore the "ignored" file twice - first time in
.gitignore, and second time in the "git add" command. I didn't expect
this to be a problem, but I'm getting the following error message:

The following paths are ignored by one of your .gitignore files:
ignored

It looks as if git thinks I wanted to include, not exclude "ignored"
in "git add".
