Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5A4C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 04:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjAMEmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjAMEl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 23:41:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC038AFE
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:41:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso16571233wms.5
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rBwBgIE7ZP8HfZKGwSh8qb1OuUAOB0M4xS/rJ/gTBI8=;
        b=kGYZdSoFKpmFpugJ4GZUIdEvVi95b+XIktRui9eSo+PnQ131qsqjVAJQWAZpcZmIiZ
         v4sxZf2tZb3ggoOlXr4oG9smdFQSaKgI7GzF4F+n9hyPW/VaSWvVtzKyfXCbK/1JT+ze
         iDR5/KzXf8GiKBtfVIg0ybmdglnbzqFOYeQoT3uU+gH9r/YSQl5E9B4P8i8T8chrvLcZ
         98UAmcnd/1I+rKEfOo7BP3qP70QZGwg4bySsYornH2QNum8VrP9wZOp5G0Ar9I0gT38K
         O0oxbK74SwVSBxcRRmkD7I5Wmzc5bnEkc8B5NEDnoPxtQKqxqNM1ZiESQWUdXQyi/jcU
         TJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBwBgIE7ZP8HfZKGwSh8qb1OuUAOB0M4xS/rJ/gTBI8=;
        b=dKeoaDBQeT1nTwrTVOtL4BPXe9JGoC4JuhTY9M3ZTbJBTObnx+gadYYer3gHngIrlk
         A7JMjjaIWVMIGuTfb4ifO7Qrr2xm+SJz9hLqJmHZ5yvRURXOGCblL2KdZ7lKv4NAH4de
         IfQAJqfIrhyErF9SwgEAJeQxTm3EUp2WmaiBe97EVXRkjbtX0IsQyclkfOwe/3mJ7Cf9
         BgcUiJ5X68K9eewTCvaUIBJ6g/dSYxIfvmQEuWUBqUHSCCWSZDjOivINo+8F2InBUrYP
         VGAD7gQPEv/WkURwQ0x9iu7oT+DTiU1YsAXp9JDIyqsZocA7gGjctnvm5+uGPmtK9Ujw
         AxRg==
X-Gm-Message-State: AFqh2krzLWuilS/HbvsfU5RLG/2zx7E4iAhvm9kz6D5erUSqH0rJ9VrN
        FvzaKLxGlWWHh6a/KzSp4+Hfeowlf+s=
X-Google-Smtp-Source: AMrXdXtkk19RbTrBQ0UwGyyn8qyKC3pWhVYw166Supip1zjkQwovvjc6KydVA9Mj3QB3np4UP9JLyg==
X-Received: by 2002:a05:600c:3ac8:b0:3d3:4ae6:a71b with SMTP id d8-20020a05600c3ac800b003d34ae6a71bmr57873041wms.2.1673584915546;
        Thu, 12 Jan 2023 20:41:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b003d9fb59c16fsm11649353wms.11.2023.01.12.20.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:41:55 -0800 (PST)
Message-Id: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 04:41:50 +0000
Subject: [PATCH 0/4] clarify ls-files docs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git ls-files -t" was marked as semi-deprecated back in 5bc0e247c4
("Document ls-files -t as semi-obsolete.", 2010-07-28); quoting that commit
message:

    git ls-files -t" is [...] badly documented, hence we point the
    users to superior alternatives.

    The feature is marked as "semi-obsolete" but not "scheduled for removal"
    since it's a plumbing command, scripts might use it, and Git testsuite
    already uses it to test the state of the index.


Looking over the manual, "git ls-files -t" is very easy to
misunderstand...as are several things besides the "-t" option within that
manual page. I recall a number of discussions over the years on the mailing
list about various confusing aspects of ls-files, and I think a number of
those misunderstandings could have been avoided with a few small
clarifications. This series sets about to do that, as well as remove the
"semi-deprecated" notice on git ls-files -t. That particular command is
rather integral to sparse-checkout usage (and doesn't seem to confuse in
that case), and I think the improvements avoid the original problems.
However, I have kept the comments about git status --porcelain and such
being likely better candidates for a number of things that git ls-files -t
might have historically been used for.

Series spurred by
https://lore.kernel.org/git/CABPp-BGsD=6PiJtnsuYPsiZJ1rm2X8yTeu-YeP4q5uu5UDw2og@mail.gmail.com/

Elijah Newren (4):
  ls-files: add missing documentation for --resolve-undo option
  ls-files: clarify descriptions of file selection options
  ls-files: clarify descriptions of status tags for -t
  ls-files: guide folks to --exclude-standard over other --exclude*
    options

 Documentation/git-ls-files.txt | 79 ++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 27 deletions(-)


base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1463%2Fnewren%2Fls-files-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1463/newren/ls-files-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1463
-- 
gitgitgadget
