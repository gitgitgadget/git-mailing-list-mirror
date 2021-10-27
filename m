Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEDFC433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE0861039
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbhJ0Hvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 03:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbhJ0Hvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 03:51:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7F5C061767
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 131-20020a1c0489000000b0032cca9883b5so4126936wme.0
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JvctJzyk4uLC8DEgkdfnF3rVG4fDq711e6qh07JXQJI=;
        b=qwOvkR9T564ScUdmQlSmu4nN5IwoFK9V3Z0766TCNr6ryZYaNCjj8N1LYrO0vdtrGR
         ELQCx2IREWlbxFOt+zXwKlf13Ff+ou9eTYIk+YuyTpDPPLWn49gBWYvGdVSAzX8+zIUi
         asRV7BsiBjo2nqkbTKNaCsSfhUOe1fXNsV60HGUo39VCjHW+tuYcKTpFnI0siQwQmc3Y
         Infdlw0T6xPcWpln2CZJ3E5suyJgjrKBwnIO2Wnw9Mg9trrmHCX1u6QrBQxm6+vJot1X
         aYHz0ntqB8CTob3Kqw2MW5NTog2pBEqk0zLE/Y8mWlTTXO650t1lFKNYQGseZSOT1kG1
         lDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JvctJzyk4uLC8DEgkdfnF3rVG4fDq711e6qh07JXQJI=;
        b=jyt5cqGiIC30SbeSLKORgEVk2u+X7arzUARvUl2zpJr3d88dNnpU52rRamQ0ac0+3F
         tf9p70a9FE68Paw95uLKK6T+ogUC3PMSCY2TgISk6+Adl0QwsVkExvQTzbnjqaAYvQ8y
         RGR810wKh72V756Elexd1iCnt7+SDmLK+qbyvs2EFnMOGC2rIxCDKK6oWxRNotmDg3CO
         3CzLI6NQr/9siK/O9HaLvWCqz5w4EydZfRc8XRbAMnhgpDzZe3wwY0TmaCvMFih7rX6G
         cNIt7XZebpYOdAT9WXpd8c7VlJpgRBTsbubaPHU3UtG4EIlZVNosSHzne7Ea4OCxK2TN
         kYbg==
X-Gm-Message-State: AOAM531aHC9/AfkR5JXQYrG8CmDmLMYbY0D3LtOY8LRYnI2veM7xqRoy
        z4zySvPklcA2cBHG79JO30zFBlF9aYo=
X-Google-Smtp-Source: ABdhPJx/Wwyd9Uh6xl+/TfNsCT/FNxcAyHYbWcKFJSeHsmPgAJ7tB+f3sSePB5ThUwzUksN1ChI4wQ==
X-Received: by 2002:a1c:ac03:: with SMTP id v3mr4231151wme.127.1635320954515;
        Wed, 27 Oct 2021 00:49:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm2754353wmk.23.2021.10.27.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:49:14 -0700 (PDT)
Message-Id: <449eb5c205e139e21b619c4eb975afc3d47427f3.1635320952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 07:49:08 +0000
Subject: [PATCH 1/5] t1051: introduce a smudge filter test for extremely large
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

The filter system allows for alterations to file contents when they're
added to the database or workdir. ("Smudge" when moving to the workdir;
"clean" when moving to the database.) This is used natively to handle CRLF
to LF conversions. It's also employed by Git-LFS to replace large files
from the workdir with small tracking files in the repo and vice versa.

Git pulls the entire smudged file into memory. While this is inefficient,
there's a more insidious problem on some platforms due to inconsistency
between using unsigned long and size_t for the same type of data (size of
a file in bytes). On most 64-bit platforms, unsigned long is 64 bits, and
size_t is typedef'd to unsigned long. On Windows, however, unsigned long is
only 32 bits (and therefore on 64-bit Windows, size_t is typedef'd to
unsigned long long in order to be 64 bits).

Practically speaking, this means 64-bit Windows users of Git-LFS can't
handle files larger than 2^32 bytes. Other 64-bit platforms don't suffer
this limitation.

This commit introduces a test exposing the issue; future commits make it
pass. The test simulates the way Git-LFS works by having a tiny file
checked into the repository and expanding it to a huge file on checkout.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1051-large-conversion.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 8b7640b3ba8..684ba5bd0a5 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -83,4 +83,16 @@ test_expect_success 'ident converts on output' '
 	test_cmp small.clean large.clean
 '
 
+# This smudge filter prepends 5GB of zeros to the file it checks out. This
+# ensures that smudging doesn't mangle large files on 64-bit Windows.
+test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
+	test_commit test small "a small file" &&
+	test_config filter.makelarge.smudge "dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) && cat" &&
+	echo "small filter=makelarge" >.gitattributes &&
+	rm small &&
+	git checkout -- small &&
+	size=$(test_file_size small) &&
+	test "$size" -ge $((5 * 1024 * 1024 * 1024))
+'
+
 test_done
-- 
gitgitgadget

