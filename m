Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29216C4743D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E4461408
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFFMGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:06:02 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35530 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFFMGA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 08:06:00 -0400
Received: by mail-wr1-f42.google.com with SMTP id m18so14173874wrv.2
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QVYidJVjvN8UjKUUznUYyJfwF6LhpwcZXlKQZ3a0M/Y=;
        b=XKAEh9kFc4b7VQpyv9tMgWtqgBEgAnrFsgZO4zEnLh7BwukakkkMKoNHUR8y15fful
         GG5TbrNPL3olPW7eduTj4Ig8mzH6LISTALXS39pEoZ3ATpJVpvFDgcfjv9DzuaxNc/2Z
         8XCmNAtt/w9Q6CbbOUv9+lgIEMY2MmfNqy1dfd7TXectHrbQO4WE1z0etxMUzVfNHBIf
         YQ6gdl6d6csQ5ApELoAYZbQSvpMCQ/86kdqxn+5/cyd52Nsyzzp3jGu0gWxIjQSNWOgd
         OWqOtjDpQYsVMFs6du+lfTI7xmQGaScwax/bwxZ/1qzTiKIBqqphpIbOlu1Tu3+ncInX
         3F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QVYidJVjvN8UjKUUznUYyJfwF6LhpwcZXlKQZ3a0M/Y=;
        b=W9gRtUjkmpGVsCrcbSX+BM2yke1RrBVpZKJ9h8RQ5ldk2YE4XgoK3JX7rLNIXrhO2Q
         7OYbAMqi45FaEqiuFBZgUPMe/WQ96kzL6Ix9O+ZZDlnEfgXCcE5yBBPmkqOukoQfUMky
         KGVwhBw/JA8qz0wCWKonSy7hnp+EYdJQmGf2s9hY8+Yv3on6oLjBYXEqBauMn2/Fm6W5
         g5rkcZouc/W8AFih898a2LY/c2GNWdsiyr1UnwntrFYNlyhPjN7qvwqlm9N42TF5s8An
         WrZxnWJd8c5MzMPPzjP8UejAL30pyE7s4z+TlbZbV/0jHCw3q9a3FtGdOXQSeALksG/i
         E6KA==
X-Gm-Message-State: AOAM531umbFYDrFHppWv5n5dof57B5F6xYWveW/I5Dr8kBVd4qY0RHfl
        MZkroUfTBTLWta12aw2Iw2XacY8eAcs=
X-Google-Smtp-Source: ABdhPJyMV7zCvFsjo1tToxu7bwLWj6OrfLIggDPLiYpYwNWfNhvjU+Yz2T/POqoVcHhvj/FHCmW7ZQ==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr12698767wrr.26.1622980977872;
        Sun, 06 Jun 2021 05:02:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm12914382wme.43.2021.06.06.05.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:02:57 -0700 (PDT)
Message-Id: <2110c8ffa423e90224089d048291f4392aa50eab.1622980974.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
        <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Jun 2021 12:02:54 +0000
Subject: [PATCH v2 3/3] cmake: add warning for ignored MSGFMT_EXE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

It does not make sense to attempt to set MSGFMT_EXE when NO_GETTEXT is
configured, as such add a check for NO_GETTEXT before attempting to set
it.

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 399a3cd6c071..3dc7ffcd98bb 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -189,14 +189,18 @@ if(WIN32 AND NOT MSVC)#not required for visual studio builds
 	endif()
 endif()
 
-find_program(MSGFMT_EXE msgfmt)
-if(NOT MSGFMT_EXE)
-	if (USE_VCPKG)
-		set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
-	endif()
-	if(NOT EXISTS ${MSGFMT_EXE})
-		message(WARNING "Text Translations won't be built")
-		unset(MSGFMT_EXE)
+if(NO_GETTEXT)
+	message(STATUS "msgfmt not used under NO_GETTEXT")
+else()
+	find_program(MSGFMT_EXE msgfmt)
+	if(NOT MSGFMT_EXE)
+		if(USE_VCPKG)
+			set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+		endif()
+		if(NOT EXISTS ${MSGFMT_EXE})
+			message(WARNING "Text Translations won't be built")
+			unset(MSGFMT_EXE)
+		endif()
 	endif()
 endif()
 
-- 
gitgitgadget
