Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEBAE95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjJHGqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbjJHGpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CF4E9
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3215f19a13aso3488876f8f.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747541; x=1697352341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hApyy/CNLzOk95mMp5/RTpFogDTryDVmcpCw4Nlk750=;
        b=EzQVedAnpX4c0L+qRzwmDm7QCls2LfR3OrItrThmFeIk61JStM5TjaUJ1WMRA51UKQ
         aqhlizQH9cTwmXNGWl/EzUdS3kBty60CQEenO5tfjlmuQaa27o4TGBuQteY42QoBqHOo
         IuL/5fhxJpjFL96PQwLTBkfBq5WrPCjIdxQ+ix2x3tHa4jn8JSnPzZ5+HCi6vE66bWcA
         AmGvW/bLtlJs85vrnmmSxuhTadCJRb8lgVgycN6AHemHRRjfGkS9GS+Bw2d+XebKzdZg
         TDGWTqa9RFnXss5R9c6qT0KshTCTsRxZrD9CdMtOK9f6LNkqzPn4W7+qv9uM9bZc0EGZ
         a2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747541; x=1697352341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hApyy/CNLzOk95mMp5/RTpFogDTryDVmcpCw4Nlk750=;
        b=BZb+fGXg+9XGsZgmuli08E3Rt+3jJ2m844ukj49VnUOUykvheCjVEX+2FCm9aJM5Oo
         3lxrPVXwEy4dZKRmGhCUZh5NzA4melc+ZrOF7l4CEWB92TJglDZsuj6dSUMmO9lyUzh0
         HFUqQxysgpCXGbumMyc7SRvj5yMsAcYEUXqxyFl17hTQEcbYKQnO4A4RMEtWurAqHg5E
         J17LrSwTacn0XdOUFnB3DpUvBKfuA5bv7p9NEM7KbfHmWNLRBglL7LdVeVmxakXLaAQY
         uUuXJwUpyUjV7ZHRtf7810O8xEnwS4eUtdvK7WqzzuF2jqVD5ZMi8xhwKugr6Q6lawJX
         gteg==
X-Gm-Message-State: AOJu0Yzi3WEazCiyQRvztRf96jnxWE5m8//rGSgmNb6ttpxY2LFwfeMj
        gIVJDMdGbJXXpk3BKqPqhFxFwOegy1Q=
X-Google-Smtp-Source: AGHT+IEqwRqGcL348yo29SeHCX6Zm+U7QhEvWerI4h1vPRUqASzRRyAOZvSwsJy8IlCe27JxS3N3Sw==
X-Received: by 2002:a5d:6145:0:b0:31f:ec91:39a7 with SMTP id y5-20020a5d6145000000b0031fec9139a7mr11482290wrt.14.1696747540993;
        Sat, 07 Oct 2023 23:45:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d6902000000b003250aec5e97sm6097566wru.4.2023.10.07.23.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:40 -0700 (PDT)
Message-ID: <36251f19f736cf2004c325e2418d786acd1334bc.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:18 +0000
Subject: [PATCH 16/25] documentation: remove unnecessary hyphens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/ReviewingGuidelines.txt | 2 +-
 Documentation/git-check-attr.txt      | 2 +-
 Documentation/git-merge-base.txt      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ReviewingGuidelines.txt b/Documentation/ReviewingGuidelines.txt
index 3e98c8a6af0..515d470d23c 100644
--- a/Documentation/ReviewingGuidelines.txt
+++ b/Documentation/ReviewingGuidelines.txt
@@ -126,7 +126,7 @@ Terminology
 -----------
 nit: ::
 	Denotes a small issue that should be fixed, such as a typographical error
-	or mis-alignment of conditions in an `if()` statement.
+	or misalignment of conditions in an `if()` statement.
 
 aside: ::
 optional: ::
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 6e4f3aaf34c..7fea245ed22 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -29,7 +29,7 @@ OPTIONS
 
 --stdin::
 	Read pathnames from the standard input, one per line,
-	instead of from the command-line.
+	instead of from the command line.
 
 -z::
 	The output format is modified to be machine-parsable.
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 463764b9c1e..5cdcb5663cd 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -130,7 +130,7 @@ When the history involves criss-cross merges, there can be more than one
 ---2---o---o---B
 ....
 
-both '1' and '2' are merge-bases of A and B.  Neither one is better than
+both '1' and '2' are merge bases of A and B.  Neither one is better than
 the other (both are 'best' merge bases).  When the `--all` option is not given,
 it is unspecified which best one is output.
 
-- 
gitgitgadget

