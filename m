Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03813C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D486A61027
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhJOMQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbhJOMQi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:16:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFEEC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:14:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i5so27089pla.5
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fe+fBmLgCf3Ouan+2vuK4YU+O9h9t+C+Z3Ss/WUMuOo=;
        b=k1bk8ot2LiPHuKWjZ8HVZCTTzzJQ0uIbpLIvq79E2xMv+xloE1tGtHkQQO02DegIhi
         2UTv5ol63QY09zugd7yXldTIeboyc024DMvsoFjfmhQR4MyoNE60ybtp5iULTtQMElF3
         k4CWpzkupb9u57WY4MPViKm0xep2Qy8Xgm9yKeTLMWyGbPrtLFHGJ2iYMMZmi1aJ5xF8
         5GfETKxicLPgB8+7gXecKgcDVX8HXfYN6d17dJ3I1aFHM3wr9b8GPXq+sdaCfgNDQPwp
         8krkaOCLYUBX4JVYR4b3OD99XJC6XSjrQlzG9vSuqidOs8WbUVqkRidU/q4K9WI7tHsA
         Phlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fe+fBmLgCf3Ouan+2vuK4YU+O9h9t+C+Z3Ss/WUMuOo=;
        b=xfWA+hDbKUW50smk5I7LaIv578bMbWqyO6Tvpanx3KN4aNQ1KJoPhiPXXYWN34ebhv
         u4TA8nvbw2SkFeLCB1RIbSS6I2XmE3LPF7aM7HsFabG/0LvNvIEttVSTx8oZko1K5cO5
         G10a3JixMCeFU0D20yrbMcobCWZtRKoUEa2N2JKdeERyE8kCwugZNH44cTwU1/7WHwkC
         mj7UtZXJkTW8SkN6Bb8aoGCA2kp8RxixfO0d/YpmxiXuD/JsgPEQgpC7bffwvPhCLDVk
         J35zUvWIe7kgaTOkHjuV798q6WnnLLxFuQDEV71DApKcHxTkuYpjjfKq99xiyBjfi1QK
         Ti/Q==
X-Gm-Message-State: AOAM530/8luJYfc3a5JSbZs0nFIijliVrpbWwpDcoYnK7jHYLc7bc2e7
        t+JPIjaEWqlRb4/NO58Yk0ovlT0pgBrYS/xm
X-Google-Smtp-Source: ABdhPJzu5xLvQpCxo3QpDtycT1fNYy8h20hh4NZluZtdDjc5qxmO+APC2bZhAQPvrzMY2598x4nBwA==
X-Received: by 2002:a17:90b:4a8d:: with SMTP id lp13mr10795369pjb.240.1634300070616;
        Fri, 15 Oct 2021 05:14:30 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id g3sm4842406pjm.22.2021.10.15.05.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:14:29 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, vagabon.xyz@gmail.com,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] archive: rewrite description for compression level option
Date:   Fri, 15 Oct 2021 19:13:37 +0700
Message-Id: <20211015121336.46981-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite the description of `-#` option. Since the option is also
supported on tar archive, move to OPTIONS section and remove EXTRA.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:
     - Mention common levels (store-only, fastest time, and best
       compression).
     - Note that compression level option is supported by both zip and
       tar format, so move the description to OPTIONS section.

 [1]: https://lore.kernel.org/git/xmqqpms6akup.fsf@gitster.g/T/#t

 Documentation/git-archive.txt | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..9aecc0936c 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -9,7 +9,7 @@ git-archive - Create an archive of files from a named tree
 SYNOPSIS
 --------
 [verse]
-'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
+'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [-#]
 	      [-o <file> | --output=<file>] [--worktree-attributes]
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [<path>...]
@@ -65,10 +65,6 @@ OPTIONS
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
 
-<extra>::
-	This can be any options that the archiver backend understands.
-	See next section.
-
 --remote=<repo>::
 	Instead of making a tar archive from the local repository,
 	retrieve a tar archive from a remote repository. Note that the
@@ -88,17 +84,13 @@ OPTIONS
 	of the current working directory are included in the archive.
 	If one or more paths are specified, only these are included.
 
-BACKEND EXTRA OPTIONS
----------------------
-
-zip
-~~~
--0::
-	Store the files instead of deflating them.
--9::
-	Highest and slowest compression level.  You can specify any
-	number from 1 to 9 to adjust compression speed and ratio.
-
+-#::
+	Select the compression level. The supported levels and default
+	value (if none is selected) are depending on compression command
+	backend configured for the selected format (either explicitly with
+	`--format` or inferred from file name specified with `-o`). Common
+	values are `-0` for only storing files (zip only), `-1` for fastest
+	compression time, and `-9` for best compression ratio.
 
 CONFIGURATION
 -------------

base-commit: 2bd2f258f4195ac54293a3f45b86457c0bd5fc11
-- 
An old man doll... just what I always wanted! - Clara

