Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C3C2D0DC
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADF4206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oStFr1rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfLZRnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:43:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37014 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfLZRnk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:43:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so23251738edb.4
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I8f3xSDsUXIfoZkionzYqDbsTTalc1rHn66p4RC8so8=;
        b=oStFr1rRUxjUeN7GHVSra8zght8g8f+4b/lFUadqY/kUpn7xcgaYD6fQyvzGLLDD7g
         j1HCn/AdkwCwhpZ/yzYAqAs0OLhUwWabqJIpa5obdmZhuTbwuiwsJ5p6CwMeQX0rua7V
         WKXbq31rdGEiYWSIWWtBs5EzNKAMkLPeRVW8pFo5dlj4rwSWm6njEgH33mGynsKY1779
         iA1ICJYn40o8SLDLW6418Q8F23Dlm476kZkfu5KNDPfSazM/XTTxaaaP34fwfVrlW4Cf
         An+te5TsBwzXReS2Tk1Jj+13ralvUgmCbCNKeSV0oBg/46dhESEH6vbuHYRH4A0zXSgx
         peBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I8f3xSDsUXIfoZkionzYqDbsTTalc1rHn66p4RC8so8=;
        b=MDPKZ1UOBP6EuSMOrro7yzSHeFNoYaLalDRMGDJ2hv9Sz289Vy8FAJFqAVmc/UQma7
         liWGDHxMIPGHTZU9zZqj+BLD5dkNPKuHiJ5ZnKd79SHAhNYwCcY7BHqhCvZfI3DTGpcc
         Dyk1KVs+ifwYqyCDLe3tCrjb8YcLZl6HneE2hHHNK41NM+pMgEu2i/05EILTQF2VHsZD
         R/RsTKcvqqyW9BZ9jnxposF/4uTcta2w1NXFr01UM5N3JicBkno/DlKzuvM+QBoAGfGp
         YuciTBql41MwV+n9/hjihkBmp4q21Yazk95/0jJjds6tKugvkKB/f86G/i8x9/szBlyY
         coeg==
X-Gm-Message-State: APjAAAXm8yqLg3+nmluCdLeGcte4E8xCGi//XqigfA0rGgupdrcqBPfH
        CmyL9yT2GRfBs0Op/tCMXhY20i6L
X-Google-Smtp-Source: APXvYqzPbFM++7xXD5uVdB0itMvlqVYMpwKApQU7lcMnqHGWwmoUYHPeKT6GyyZ8trYFT/Js83QnEw==
X-Received: by 2002:a50:fc85:: with SMTP id f5mr50997345edq.294.1577382218980;
        Thu, 26 Dec 2019 09:43:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e21sm3653673eds.36.2019.12.26.09.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 09:43:38 -0800 (PST)
Message-Id: <e68ef0ced3b6ec34009f725a7ac762e6df4fa868.1577382217.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.494.v2.git.1577382217.gitgitgadget@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
        <pull.494.v2.git.1577382217.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 17:43:36 +0000
Subject: [PATCH v2 1/2] doc: log, gitk: document accepted line-log diff
 formats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Currently the line-log functionality (git log -L) only supports
displaying patch output (`-p | --patch`, its default behavior) and suppressing it
(`-s | --no-patch`). A check was added in the code to that effect in 5314efaea
(line-log: detect unsupported formats, 2019-03-10) but the documentation was not
updated.

Explicitly mention that `-L` implies `-p`, that patch output can be
suppressed using `-s`, and that all other diff formats are not allowed.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt | 5 ++++-
 Documentation/gitk.txt    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b406bc4c48..6574c0d91f 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -77,7 +77,10 @@ produced by `--stat`, etc.
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments.
-	You can specify this option more than once.
+	You can specify this option more than once. Implies `--patch`.
+	Patch output can be suppressed using `--no-patch`, but other diff formats
+	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
+	`--name-only`, `--name-status`, `--check`) are not currently implemented.
 +
 include::line-range-format.txt[]
 
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 1eabb0aaf3..c487af5b74 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -106,7 +106,10 @@ linkgit:git-rev-list[1] for a complete list.
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments.
-	You can specify this option more than once.
+	You can specify this option more than once. Implies `--patch`.
+	Patch output can be suppressed using `--no-patch`, but other diff formats
+	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
+	`--name-only`, `--name-status`, `--check`) are not currently implemented.
 +
 *Note:* gitk (unlike linkgit:git-log[1]) currently only understands
 this option if you specify it "glued together" with its argument.  Do
-- 
gitgitgadget

