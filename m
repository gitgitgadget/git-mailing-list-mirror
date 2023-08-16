Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43E3C001B0
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 14:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjHPO0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 10:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343610AbjHPOZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 10:25:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12BE2711
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:25:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff8a1746e0so2334132e87.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692195956; x=1692800756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDLADkHWny+5n9d4AZ1kvLFwk9O09aZP8EJ2B/g78W4=;
        b=UQi8LX72sRTSBmThK0D/bpAlPAseMyWrT7AJVQ3KvE0ZBflZ2LKw5Ny0nDyL4zQWeN
         dQouFVBQ8J9yoFTyjV1K9cSm6kRClZ2uDYqpsz8yscOpAuP+UN9uVBoaa5bgZgHMgz/a
         w+903KjEWGOqig2xIdddrWvt4DZPJhN7TDZFaXSQRMJg5OZR7VcT8u5W60vfKeL8THEG
         TQX+AZOiJfVQsVv9/mmdL4Pl8wFCOxd77519j8sMLuonrTXWYhrgd7fsOIOALmh4QJ56
         e6I0XGryarhwt7ApBkgEhn9/c6cVU2u3/9ecpOpkHBqM5tLlt3cjhLDSTxkdWZHO0+QJ
         I1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195956; x=1692800756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDLADkHWny+5n9d4AZ1kvLFwk9O09aZP8EJ2B/g78W4=;
        b=kwxcZsF9wLOe+wSYyEJOzS/Qm3LlwYg/V4SBDtOwn1D/n97+fMMktv4Vbvtcln1HtA
         fsy+4Npuv3mlsPSTRzSTNoJTp/tuD0Tnia89IcGH7F3s8Vy7Nqkqbp3hf5/IdnBuHvh5
         M4NodFtmaB5aK4HCD//PLSoct5Z6NtxW+d2Qy7i3GHPcdveh36VKqPHjyjWMzTug+N6f
         M70FlD+DA1VTB6A5taf7Qie94W65lHg8BDEhW4b7sLShY3huAV5RN/+zyGkAj2TFKMmX
         nBIUedxYpHjSZjIHM38emujG5lsyOL6yRdZPGFx3C1Rl9UkBtbdqyoEZB3uKTgKW5OLr
         kacQ==
X-Gm-Message-State: AOJu0Yw9YVFHpGtQ/PrZJqVULyz32yVVp993zIT2h4ogN7JRpa7BOITY
        ds7a5ShnnFb9qW5Qd3cYMkv3j9mCQUk=
X-Google-Smtp-Source: AGHT+IHLRcM+AN7bEg9XS7uRvcQ41P1oZwZPrdARg4l9WgulxLEi57NoXMmHgfpdjJVyZhshUlpspA==
X-Received: by 2002:a05:6512:12c1:b0:4fd:fadb:e6e4 with SMTP id p1-20020a05651212c100b004fdfadbe6e4mr2149325lfg.69.1692195955709;
        Wed, 16 Aug 2023 07:25:55 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id c18-20020a05651221b200b004fe1c9ce61bsm2927925lft.116.2023.08.16.07.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:25:55 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 1/4] notes doc: split up run-on sentences
Date:   Wed, 16 Aug 2023 16:24:33 +0200
Message-ID: <a8e5a98da5f577fc6235bff07d7430377344dd93.1692194193.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.42.0.rc2.215.g538df5cf27
In-Reply-To: <cover.1692194193.git.martin.agren@gmail.com>
References: <cover.1692194193.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When commit c4e2aa7d45 (notes.c: introduce "--[no-]stripspace" option,
2023-05-27) mentioned the new `--no-stripspace` in the documentation for
`-m` and `-F`, it created run-on sentences. It also used slightly
different language in the two sections for no apparent reason. Split the
sentences in two to improve readability, and while touching the two
sites, make them more similar.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-notes.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index bc1bfa3791..9043274ce8 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -141,17 +141,16 @@ OPTIONS
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
 	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out,
-	if you wish to keep them verbatim, use `--no-stripspace`.
+	single line between paragraphs will be stripped out.
+	If you wish to keep them verbatim, use `--no-stripspace`.
 
 -F <file>::
 --file=<file>::
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
 	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out,
-	if you wish to keep them verbatim, use with
-	`--no-stripspace` option.
+	single line between paragraphs will be stripped out.
+	If you wish to keep them verbatim, use `--no-stripspace`.
 
 -C <object>::
 --reuse-message=<object>::
-- 
2.42.0.rc2.215.g538df5cf27

