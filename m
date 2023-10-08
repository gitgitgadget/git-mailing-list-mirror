Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F40E95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 14:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbjJHOKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbjJHOKX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 10:10:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD199
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 07:10:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40666aa674fso34927495e9.0
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696774218; x=1697379018; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kss0oTQiitzXn8ALqzsQGUcB0ZXKdfrt6tRcJr72QEI=;
        b=TWrI28fD8KVqFg1brbqtyKIzOvbH6NVzUWJ4OV+bF3EWfP5Rb7Kk3RAPByi0KAmdUB
         2wcA1RuB5sN79nRUQK5/ccCWR7wfagQKiKk8GjO/GlDLWMYVP0tutjUK9jZr1oAjKp4w
         jo2Ku0nq78UPKioFe2Dtwwj0YSOaVvk6aEOKhvBJX8H977TCwRc6xuXa408/RPQ5YcSU
         /Tflc84nM5FmBEacsihbsVnVfWzNt373H4hktkjQoKzbwaOv/x1gfRiQAlwZuUBQe63E
         kjfLJ+6Uwt3JSx/ZRotOcsIFwKl4lrbZn62vywwxMt8ECR4RqracK7PvY+1MkKN0S7df
         pBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696774218; x=1697379018;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kss0oTQiitzXn8ALqzsQGUcB0ZXKdfrt6tRcJr72QEI=;
        b=fb/27ux7s12NR+rweRh2YY9qlIepvutL/bXU/4fTW20CM2mCcQu3tf1YqLJUwOj0le
         0TpStAI/CBTJi3LswLeWnJCRxLe/5skqrR2mXU+YY0pgKZYAcY2nm+w6UMfqWY/JWt3I
         Pn8DjloKID/e2wRcffdEsH5QWjwFRExZrYbjMjXKQDrGjqaHLqV4xfTW+QK7pU2khzi2
         yEtXIogZd0uX/I79BsBK+sHTmFLwH/fiPjcWhfjhY3FYV4GTXALg+3Jfp3jPVnWZkDyp
         GlrPk8nTBElbIEqT61muAGrBqlDbKNrNoEztGbaNeG2H45BJ7GnT3JufVUVyJKxo1sBp
         u9Rg==
X-Gm-Message-State: AOJu0YyuLqrw7hFCym3JYff/ej8GZEYkMbiuQUS4BWTtzw6zjGLfWu0P
        gClpnf9zzeUGJlXuwNFV++EyBUK5OT4=
X-Google-Smtp-Source: AGHT+IHczoVGs0kbaQoeQBu74adKh6BWvnipQyQd4a63nIc4NMAE1ZGlyjGDz1Tix0T2XsSnuZVdJg==
X-Received: by 2002:a05:600c:2303:b0:402:ee9e:ed98 with SMTP id 3-20020a05600c230300b00402ee9eed98mr12109810wmo.34.1696774218055;
        Sun, 08 Oct 2023 07:10:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e14-20020adffd0e000000b00315af025098sm6974507wrr.46.2023.10.08.07.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:10:17 -0700 (PDT)
Message-ID: <pull.1585.git.git.1696774217058.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E8=AC=9D=E8=87=B4=E9=82=A6?= (XIE Zhibang) via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 14:10:16 +0000
Subject: [PATCH] doc: correct the 50 characters soft limit (+)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "=?UTF-8?Q?=E8=AC=9D=E8=87=B4=E9=82=A6?= (XIE Zhibang)" 
        <Yeking@Red54.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= 
        <Yeking@Red54.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?=
 <Yeking@Red54.com>

The soft limit of the first line of the commit message should be
"no more than 50 characters" or "50 characters or less", but not
"less than 50 character".

This is an addition to commit c2c349a15c0430a2ef9f858d69d095a00693379c
("doc: correct the 50 characters soft limit").

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
    doc: correct the 50 characters soft limit (+)
    
    The soft limit of the first line of the commit message should be "no
    more than 50 characters" or "50 characters or less", but not "less than
    50 character".
    
    This is an addition to commit c2c349a15c0430a2ef9f858d69d095a00693379c
    ("doc: correct the 50 characters soft limit").

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1585%2FRed54%2Fdoc-patch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1585/Red54/doc-patch-v1
Pull-Request: https://github.com/git/git/pull/1585

 Documentation/gittutorial.txt | 8 ++++----
 Documentation/user-manual.txt | 2 +-
 po/README.md                  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index c7cadd8aaf1..47594087880 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -137,10 +137,10 @@ which will automatically notice any modified (but not new) files, add
 them to the index, and commit, all in one step.
 
 A note on commit messages: Though not required, it's a good idea to
-begin the commit message with a single short (less than 50 character)
-line summarizing the change, followed by a blank line and then a more
-thorough description. The text up to the first blank line in a commit
-message is treated as the commit title, and that title is used
+begin the commit message with a single short (no more than 50
+characters) line summarizing the change, followed by a blank line and
+then a more thorough description. The text up to the first blank line in
+a commit message is treated as the commit title, and that title is used
 throughout Git.  For example, linkgit:git-format-patch[1] turns a
 commit into email, and it uses the title on the Subject line and the
 rest of the commit in the body.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 4281396093d..d8dbe6b56d4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1122,7 +1122,7 @@ choosing "Stage Hunk For Commit").
 === Creating good commit messages
 
 Though not required, it's a good idea to begin the commit message
-with a single short (less than 50 character) line summarizing the
+with a single short (no more than 50 characters) line summarizing the
 change, followed by a blank line and then a more thorough
 description.  The text up to the first blank line in a commit
 message is treated as the commit title, and that title is used
diff --git a/po/README.md b/po/README.md
index 3e4f897d935..ec08aa24add 100644
--- a/po/README.md
+++ b/po/README.md
@@ -412,7 +412,7 @@ There are some conventions that l10n contributors must follow:
 - Do not use non-ASCII characters in the subject of a commit.
 
 - The length of commit subject (first line of the commit log) should
-  be less than 50 characters, and the length of other lines of the
+  be no more than 50 characters, and the length of other lines of the
   commit log should be no more than 72 characters.
 
 - Add "Signed-off-by" trailer to your commit log, like other commits

base-commit: 3a06386e314565108ad56a9bdb8f7b80ac52fb69
-- 
gitgitgadget
