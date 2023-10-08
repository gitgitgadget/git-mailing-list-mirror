Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FFCE95A8F
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbjJHGq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbjJHGqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C84F113
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso34727615e9.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747546; x=1697352346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KDqXP/eUms7G3CyORS3ngCYk+WazKj6xhF+VZ3AxxU=;
        b=m96uTy3XWvkW4L7w7e8TmyyYiY7BK8gKIyH46FXP8VcYVA15wpuy15f0qofRX/9VCy
         9baNJ6xBiJWSH9oW0oOuk3c8YjzxubVq3IojWju/I09TfX2uuZIx7DRh3o3lVlGKEPjn
         9l1UxdwSV1hQC4rgBPC9SCo6Vji2FgR+zSfD/qDzUBraM1d1Z+SqKF54o1WptLUfE02Q
         Z4OeTXmTIOCoKU4dcme7f1K7r5uxFXMAQ9deo4QzO64PELWcKjBG2gBV1DBAYw1U6Kv9
         OQyM7NZs0C3iKg06oog39B0YkHxo/T16vZH+YKUoo/gZ5b00nNudbaJ5FTijgc86StxK
         J3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747546; x=1697352346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KDqXP/eUms7G3CyORS3ngCYk+WazKj6xhF+VZ3AxxU=;
        b=b9+n1iBnbM5LSrcntGUHFo4J8QT7C/5XJG19AccnrTayQDwSWwWQLRtCdTzEvIsvrv
         XZyuR+gBg/PZUPH6QkJX6nC1SzSWusK4qBskpfnKGR9gojxRbQ2jrdFmBeDzahl8Hg39
         RK429SPGs4XS5ExOCuMuPhmD7g3n3NKPjcp4rzi1UFl42GIUR2CEeJexOvBIBV9PEj70
         Vp2NjP81wvrgN3q80eMIXiupBL+0TB92cJ5O0flO0sjei90jre89SsW7TtI150DcCkuM
         l7fFEHnVRM/U0OB/CuQ39AMAH042nBIa8jFQI1ucTx+pCstHCxP9YGuXb6dmgiLiPhEX
         mmCA==
X-Gm-Message-State: AOJu0YyotgEPH9m+f1Hkd6uUaU2lA0t6/7o2eopIJ2sV58uG1mEFeO7b
        n2/RUE9J8TQ8KB+Y2QEsMRKNRYHK43k=
X-Google-Smtp-Source: AGHT+IGuM9C5EbE8J03KYUjnUpaeJxFqPDqg6Mhw+yNKtQMgEvhfNDqcwhxF088woXT8uTvJMfNt1g==
X-Received: by 2002:a7b:ce07:0:b0:406:4501:9095 with SMTP id m7-20020a7bce07000000b0040645019095mr11308244wmc.40.1696747546425;
        Sat, 07 Oct 2023 23:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y24-20020a7bcd98000000b004064741f855sm7755588wmj.47.2023.10.07.23.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:45 -0700 (PDT)
Message-ID: <ed8de13f0a33121f4932a0f0c63ff59566d5d9dd.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:26 +0000
Subject: [PATCH 24/25] documentation: add missing quotes
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
 Documentation/git-quiltimport.txt             | 4 ++--
 Documentation/technical/parallel-checkout.txt | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 70562dc4c02..40e02d92eb2 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -38,14 +38,14 @@ OPTIONS
 	a patch.  At the time of this writing only missing author
 	information is warned about.
 
---author Author Name <Author Email>::
+--author 'Author Name <Author Email>'::
 	The author name and email address to use when no author
 	information can be found in the patch description.
 
 --patches <dir>::
 	The directory to find the quilt patches.
 +
-The default for the patch directory is patches
+The default for the patch directory is 'patches'
 or the value of the `$QUILT_PATCHES` environment
 variable.
 
diff --git a/Documentation/technical/parallel-checkout.txt b/Documentation/technical/parallel-checkout.txt
index b5f54dcd451..b4a144e5f47 100644
--- a/Documentation/technical/parallel-checkout.txt
+++ b/Documentation/technical/parallel-checkout.txt
@@ -126,7 +126,7 @@ Then, for each assigned item, each worker:
 
 * W5: Writes the result to the file descriptor opened at W2.
 
-* W6: Calls `fstat()` or lstat()` on the just-written path, and sends
+* W6: Calls `fstat()` or `lstat()` on the just-written path, and sends
   the result back to the main process, together with the end status of
   the operation and the item's identification number.
 
-- 
gitgitgadget

