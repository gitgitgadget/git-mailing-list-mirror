Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D281F454
	for <e@80x24.org>; Sun,  3 Nov 2019 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfKCDv6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 23:51:58 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54340 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfKCDv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 23:51:58 -0400
Received: by mail-wm1-f47.google.com with SMTP id z26so4890wmi.4
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 20:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KDIk4ffW2RYCRlkFzVFoI+02v8CD5eqDsEAp9MPbdjs=;
        b=YAXg20tnVDQYRLaUYKC1Ae2JM9ymACETkk7CVjXb4VteownUl3Fpnau62Spj0bXDWl
         twN4shUewCZBt3onHcU50j5XDUSGTh1IiVKVImNcYATf/rW7L8eOuhTUeUFhrete4jfT
         3z+YRELkGCy8s5uRl6j81imqAL5OUTIlT6XNCdOTtiNbt2cJIIY+6XzXn30phchh4XqJ
         ZrRdfNpF6ZuhcJfEyYQckAfH7kbj1+E/uBGO6kk1wjaGKxlfw/j8iBEqm8r/PzV9JzoL
         298dll0SVW0YeL/QGEAlxYgrbhpgWiXAxaDKXKc+mH6VjVbMy4OaXTNvWotg7KQBXc4g
         kHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KDIk4ffW2RYCRlkFzVFoI+02v8CD5eqDsEAp9MPbdjs=;
        b=S6dJkk49ekyAMV315ZRt8Yw6im3hShoJ1xvckxWg5wiZei83urdBct6eIXrNK1Rk2Q
         NAkSLrX4QU1ySZE7bYFUPm8bgkkeqlwsWPqqkD0OJQU0R1QKoBnB2I7FRCQEm9qtsChy
         e7M+ZGhe8j0s77eSaIzkLtOAC1gpEcmXWEsjAlfupEFsUezKKJMt6Q7smBtc9bnuPK8z
         Fehm4XEqvEyaCWd9DfKi9dz/CRKOmU9crSOXyYiVYCZvRKyFFcP67ohldA2EjeBz3dNh
         3iJCIVN7lrSJbt2XqaVs/9h2QmlWejQS/fdCRYtb9y2USrXJTePbFUxS9j829VxpyMJ6
         bksw==
X-Gm-Message-State: APjAAAWWVkEcOMSOOteBsLGLsWhJYOimEjeqqQAaZUmoKjKhyKJh6rGB
        Gsxs7+3esTgePTWJ1EMM2ah6zsc9
X-Google-Smtp-Source: APXvYqw+fRE0RVYoJL02hI1llZe2jvLRP+Bph0j2YA1fTW0Susx5+oaF7xxtevnf+maLNWX5Vx5yhA==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr11650406wmi.67.1572753115895;
        Sat, 02 Nov 2019 20:51:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c144sm11982975wmd.1.2019.11.02.20.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 20:51:55 -0700 (PDT)
Message-Id: <pull.442.git.1572753114.gitgitgadget@gmail.com>
From:   "Abimbola Olaitan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 03:51:49 +0000
Subject: [PATCH 0/5] Teach git annotate to use parse option instead of its own argv
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abimbola Olaitan <craftwordltd@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file builtIn/annotate.c was removed, letting git annotate use the
cmd_blame directly.
===================

The following files were edited
===============================

--- Makefile --- git.c --- builtIn/annotate.c was removed

Abimbola (5):
  remove-annotate: change cmd_annotate to cmd_blame
  edit the makefile
  remove-annotate: comment out annotate BUILDIN_OBJS
  remove-annotate: delete builtin annotate file
  fix unproper comment in Makefile

 Makefile           |   1 -
 annotate.txt       | Bin 0 -> 163170 bytes
 blame.txt          | Bin 0 -> 177882 bytes
 builtin/annotate.c |  22 -------
 git.c              | 143 ++++++++++++++++++++++++++-------------------
 5 files changed, 82 insertions(+), 84 deletions(-)
 create mode 100644 annotate.txt
 create mode 100644 blame.txt
 delete mode 100644 builtin/annotate.c


base-commit: efd54442381a2792186abc994060b8f7dd8b834b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-442%2Fcraftword%2Fremove-annotate-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-442/craftword/remove-annotate-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/442
-- 
gitgitgadget
