Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDCC433FE
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1999D60F5A
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhKBPs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhKBPsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45808C0613F5
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso2332738wmc.2
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M2zhmpqsg9dQYn8ZojYNuH0ClVlSvTbD3hvmooXuDQA=;
        b=jHS5ZJBB5iFUAmqce6W7YYq0TGsymLrfXki1gXm9hGVwaLgcthlX1LzUaCrgidjfZV
         FjVTgKIU7q6M7KYNCocsOq4URJtkwe+0ttO974kJLJdoK928VnI2Q4pyz9b2IMJaO4DN
         whLWYK7PwREG4iysh6GHFRzhzadOsNCnivDkWJDk9m2Txi3ZSy+bbCEta6du+ha3meTs
         hgR3CWfLNMFaX3pzpfTUYfl/f8MXZ0WUl3TGZdoYID69FX9vL32wngjMum9IDYMxW0PM
         I7V5AajkC1MA8jCBgAsRBZexGfiVZOa2+WBDQ994UfoA6O+hmmblMgvAbZkJ7LnpZkcE
         i42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M2zhmpqsg9dQYn8ZojYNuH0ClVlSvTbD3hvmooXuDQA=;
        b=k14XP/lKiH5s7aSNtCNH+o4aJYzlwtmY2GlJMkZ2Z9twh3x/WmwcIcWwGuom14h54F
         reTyKCmwGAQQDgXglkTO9NM0WXxfUQZ8mXgglryjySa8MbbKow61JS4eTRlWe4mei9Qt
         w0+I7LjQCE/H8dcJPvltkhQXmn1BHoCOyBG5sIe9DiCiBnFurju+LF+SZ4gFi3zfA+0d
         DTcLyG9KpN8DXhw/eNuSJgBNiT2v17QhabKwdl255CLBtfbhGiJW5VR/ZErVblHGGrkh
         tQVJGYyMEKLkb/6nUsyz6JUFhoN8TGsr1gpTCQ3lSmiE5z7Is2Hd+R7y+Nfp4wVgv7oF
         CtRw==
X-Gm-Message-State: AOAM532FeJrYNxNSeUuGB7XvQt2Oz7sMAWuVAB5G8CUxnH9///8qyfhm
        YN5anWDHYB3WtZTkOwGXEzeM8NBXgXk=
X-Google-Smtp-Source: ABdhPJxm0qLojdOBVcNM895KVHbwHJW8iIYvHEMDE7JRPnKvEwrIrLxX0b2tSS3yTkQ7+WYh72To+w==
X-Received: by 2002:a1c:35c4:: with SMTP id c187mr6425154wma.193.1635867975761;
        Tue, 02 Nov 2021 08:46:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm3803570wmp.26.2021.11.02.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:15 -0700 (PDT)
Message-Id: <f099b4eaead1799908eee000c99af3a381394e6d.1635867971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:07 +0000
Subject: [PATCH v4 4/8] t1051: introduce a smudge filter test for extremely
 large files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

The filter system allows for alterations to file contents when they're
added to the database or working tree. ("Smudge" when moving to the
working tree; "clean" when moving to the database.) This is used
natively to handle CRLF to LF conversions. It's also employed by Git-LFS
to replace large files from the working tree with small tracking files
in the repo and vice versa.

Git reads the entire smudged file into memory to convert it into a
"clean" form to be used in-core. While this is inefficient, there's a
more insidious problem on some platforms due to inconsistency between
using unsigned long and size_t for the same type of data (size of a file
in bytes). On most 64-bit platforms, unsigned long is 64 bits, and
size_t is typedef'd to unsigned long. On Windows, however, unsigned long
is only 32 bits (and therefore on 64-bit Windows, size_t is typedef'd to
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
 t/t1051-large-conversion.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 8b7640b3ba8..e7f9f0bdc56 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -83,4 +83,19 @@ test_expect_success 'ident converts on output' '
 	test_cmp small.clean large.clean
 '
 
+# This smudge filter prepends 5GB of zeros to the file it checks out. This
+# ensures that smudging doesn't mangle large files on 64-bit Windows.
+test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'files over 4GB convert on output' '
+	test_commit test small "a small file" &&
+	small_size=$(test_file_size small) &&
+	test_config filter.makelarge.smudge \
+		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
+	echo "small filter=makelarge" >.gitattributes &&
+	rm small &&
+	git checkout -- small &&
+	size=$(test_file_size small) &&
+	test "$size" -eq $((5 * 1024 * 1024 * 1024 + $small_size))
+'
+
 test_done
-- 
gitgitgadget

