Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8918E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 15:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344866AbjJHPTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjJHPTd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 11:19:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722B9F
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 08:19:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so35116565e9.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696778368; x=1697383168; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAWyv7WypXHcqegy6U3kAo8N0XW0cdvMhZc3KlVxMDA=;
        b=FjrRU1WC8dyCsPA8a4ZQjVAVJZ4JdQwHBShS8nIoLz7G8yaDOUhr9NlamVp1Vb+ou4
         5V6cRW5VITNJeUUVIaP7w9gAmvn8JUE7n5Lk5issHV94G1NUon/GwdTmoHeQKFF1EPFz
         +i1mXPNGg2rZV3nD5OPCZUaD7XK4bnyxLkIwsyuPZR0+T6TI7F+6HDie8cNmO94bvQgg
         w25BxD8F5sD/PEYakPdx8FNFBaRXtZwJqxNqS3dDzqm16LKNUym/H71dBvK9Jr6Wt37C
         +TF1Nj4m4kZVo4YuJSVzZTXv6fVz1Qbom50tgUMs8r8Of8U2BM0WwiDGQtigawc3bvgt
         gA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696778368; x=1697383168;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAWyv7WypXHcqegy6U3kAo8N0XW0cdvMhZc3KlVxMDA=;
        b=d8CR5KM/lWZtUbn0hhpqUHq8pIFJ3soaxbBDUK2/1uRrDNOUB0274IfHjybdkj0xwL
         zA1bdtnbLfnvmsYG7DBWsWxkGtOIpKyikQ+OhpYHUqsDoyXraW3E51K9xEX1ezHWKrGo
         8ent3xMzM2CFY2MmsnVD4hPgrWDpaKc9SWdRPuJmIqVWEJwJKV80/qHKwXd6or7Wsicc
         9bKKwAtsayS67hU6oVBHST4DogA0CPxlm209gQDWz9ct/wNlWYNAeKnVaiD7QndUjeXt
         P1pTbWL/bM4ZS1vBBTpepngo+9/VCVBXZDFxhZ2cfk5s2UMZHI6MdEzUaRRnMVbMXgut
         hUVQ==
X-Gm-Message-State: AOJu0YypgzozQiZEpzt02VC9E4fRBNALh8wIXVpHNKirRrPzGp4n42Ps
        tYJNB4HCfSTMpBs0xYwM/HOZFHlNnvI=
X-Google-Smtp-Source: AGHT+IGLDPaKcrci5Qjf18fetT4+jRiGt+7efAyRKvBQdjtLYl/HAVfotEu8QO7ViAs8ogzYwulHBg==
X-Received: by 2002:a5d:4149:0:b0:31f:eb8d:481f with SMTP id c9-20020a5d4149000000b0031feb8d481fmr12267994wrq.29.1696778368193;
        Sun, 08 Oct 2023 08:19:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020adff30a000000b0031f8a59dbeasm6994554wro.62.2023.10.08.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 08:19:28 -0700 (PDT)
Message-ID: <pull.1585.v2.git.git.1696778367151.gitgitgadget@gmail.com>
In-Reply-To: <pull.1585.git.git.1696774217058.gitgitgadget@gmail.com>
References: <pull.1585.git.git.1696774217058.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E8=AC=9D=E8=87=B4=E9=82=A6?= (XIE Zhibang) via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 15:19:26 +0000
Subject: [PATCH v2] doc: correct the 50 characters soft limit (+)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        "=?UTF-8?Q?=E8=AC=9D=E8=87=B4=E9=82=A6?= (XIE Zhibang)" 
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

This is an addition to commit c2c349a15c (doc: correct the 50 characters
soft limit, 2023-09-28).

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
    doc: correct the 50 characters soft limit (+)
    
    The soft limit of the first line of the commit message should be "no
    more than 50 characters" or "50 characters or less", but not "less than
    50 character".
    
    This is an addition to commit c2c349a15c (doc: correct the 50 characters
    soft limit, 2023-09-28).
    
    Change commit reference format, thank Kristoffer Haugsbakk.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1585%2FRed54%2Fdoc-patch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1585/Red54/doc-patch-v2
Pull-Request: https://github.com/git/git/pull/1585

Range-diff vs v1:

 1:  5b750bdf471 ! 1:  1808fcc3727 doc: correct the 50 characters soft limit (+)
     @@ Commit message
          "no more than 50 characters" or "50 characters or less", but not
          "less than 50 character".
      
     -    This is an addition to commit c2c349a15c0430a2ef9f858d69d095a00693379c
     -    ("doc: correct the 50 characters soft limit").
     +    This is an addition to commit c2c349a15c (doc: correct the 50 characters
     +    soft limit, 2023-09-28).
      
          Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
      


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
