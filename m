Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F5C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 17:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003FC613F9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 17:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhFDRq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:46:29 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38661 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFDRq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 13:46:29 -0400
Received: by mail-wm1-f45.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso8378300wmi.3
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nnJf0tHIxki5L5WIPkoLDvaxj0zlV3qOii/EBdifkio=;
        b=RMRG/2T2HDO9+nMPlLCHoB3jGMQrsmvA1IA23QqlkPM2oo5rZdw6xzKS8sZNRkA3/I
         DHD28KPZ9w2livsZ55AOpjS6sTh5BWfq59JP+1w9rswCEjvzEXV/7OombS9x5Kq5DIdp
         T+cPny4LFLUqVmB8WyD1IdkNqGQUixX3tq4EoaK2Ih5HysJv5RlspDfs1nWGsdQTr3IQ
         M5zr7soRd3xgxkJqT1URNWaQVoyvSpOHwTo3c+hrzt7oj5j5f5C1rnfC7imvN3+/2J/q
         CoVsIyPhqlNmx1a+pjG7/i8MrL9W5ChYgmxC+OGMTQCxId15jtzFrdkfvMBXHIyBvkya
         wRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nnJf0tHIxki5L5WIPkoLDvaxj0zlV3qOii/EBdifkio=;
        b=UtaBFw4Z0EyEEAAgnQcl0nZ8jneEi4u0AfvhNi5D5FUU40HCnfM8U3DR/KwShFozfL
         9IkO/FjD+U032uPb/6sX4fz7ZXybt9E6l9DR0UUuf9xCNcEos5+Boy31geMeM/SMsvet
         5dSY28tpfDtRlso6WAglWjA81v+VrUAOG0cQWhpkBVdKYD5Fnkvxkh32RaqT7yEwmXQb
         sr9UmxHK33Pi3EBbv9B2xdTTWj0/WCakjlMEhxBD6jNUJJ+6lMvxO/+Jr2CQKssaAWgq
         0D+y1ZERY2nysjXHRB4Y0wD9QfcM+jvWnPT69UB/WDvi7R/ELwj4mOyDzyJu9e+oRlmo
         Ewpw==
X-Gm-Message-State: AOAM533eh+9XmlvkLs1le35zuoiOEu0Brx0ABjkZN148/K+Bydi7t+vM
        7sHZZha0ZDebM3yGxEj1ZPAsJu7t5Kc=
X-Google-Smtp-Source: ABdhPJwiiicGy0ZCXin4EX5/zG0GN+QpjIWprn1wpAsfdioyORY9YDf0/7ml8f+8AtiLXOAW0O7YrQ==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4820800wmb.142.1622828608181;
        Fri, 04 Jun 2021 10:43:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm7022550wrx.74.2021.06.04.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:43:27 -0700 (PDT)
Message-Id: <c3bf266cf03a9678933623b48927ee749956218d.1622828605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.970.git.1622828605.gitgitgadget@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 17:43:24 +0000
Subject: [PATCH 2/3] cmake: create compile_commands.json by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

Some users have expressed interest in a more "batteries included" way of
building via CMake[1], and a big part of that is providing easier access
to tooling external tools.

A straightforward way to accomplish this is to make it as simple as
possible is to enable the generation of the compile_commands.json file,
which is supported by many tools such as: clang-tidy, clang-format,
sourcetrail, etc.

This does come with a small run-time overhead during the configuration
step (~6 seconds on my machine):

    Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=TRUE

    real    1m9.840s
    user    0m0.031s
    sys     0m0.031s

    Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=FALSE

    real    1m3.195s
    user    0m0.015s
    sys     0m0.015s

This seems like a small enough price to pay to make the project more
accessible to newer users.  Additionally there are other large projects
like llvm [2] which has had this enabled by default for >6 years at the
time of this writing, and no real negative consequences that I can find
with my search-skills.

NOTE: That the comppile_commands.json is currenntly produced only when
using the Ninja and Makefile generators.  See The CMake documentation[3]
for more info.

1: https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/
2: https://github.com/llvm/llvm-project/commit/2c5712051b31b316a9fc972f692579bd8efa6e67
3: https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 41320150bf66..99150c8f5853 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -58,6 +58,10 @@ else()
 	set(USING_VCPKG FALSE)
 endif()
 
+if (NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
+	SET(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
+endif()
+
 if(USING_VCPKG)
 	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
 	if(NOT EXISTS ${VCPKG_DIR})
-- 
gitgitgadget

