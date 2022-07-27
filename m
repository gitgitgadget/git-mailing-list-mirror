Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1203FC19F29
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 09:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiG0JGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiG0JGC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 05:06:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6F4333F
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:06:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so1375651wrh.3
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=00rNgD+NSSIrzSrI3nfK0fu8K5EZiiXWeWT0lGQ7CDM=;
        b=hnaaeX2x6nEGDKmoPzw9vaDUDqHxSa8cAP12w0IFhzTJNjNKtf78AHQfAIGF1tqMEN
         QNBl9y1m7Ry5QDKmakArpG+G7xFRD6YMQgC4VF0cVGQaGXklmH36a1M8MPHeiIOTTK8O
         UFVsDUpavCIHNTE3L70hsi6iXycM4ncoI2g0/qOATtKVhCIMNHDBqcNQFPRCP3DbCJNo
         Sf6jHDAKi9PS+Wl5tALOpapgtP9wdrzQGkz10Awv56W88okeumJdIgvdQflOPYdOEpyo
         SYBnkxhe9GHW3oWsNsMi4KHnsC1JREMjh6I8GOCeg8jj3s7kosc9ouUoZCCIZ/peIGZo
         yMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=00rNgD+NSSIrzSrI3nfK0fu8K5EZiiXWeWT0lGQ7CDM=;
        b=0VwnklcD7kpj/n1+kupHMU/BdgiJGJ6zpbRCZjFWWwzD+wa1ImwTyaQ2vrSdLhBCE5
         FtxKFfY8TtY8MDZCTFn40zR2E0CWpdvsooxKdWdhV2XrbH/joMMjkdsXbj6534+JKUkw
         Dko7I0NGbHkQHreT6LJXBSca0QjcJpZ2Y1ZDgo4HOsairigO6fkXi+vmp86poTga+Nh+
         2rblH+qQeKj8yCR8TbqS08EO/9Ve916VWucf6bIyZnHpRfggSR0feoRp6sO81wa91apq
         0gSr93BQQzrZs33I378YumUBJCKKr2Hdcc6y8tYpzSBALtZZqs+it9k1jE+/Ab5or5oA
         Emlw==
X-Gm-Message-State: AJIora9AivIZLIqXkU3P9BtCvoLP/tu0cLroZKSfw7LYRzLeW6+SlHfq
        rvU7tqHWkCe07qyOLQ2fZVyGmC4k1UM=
X-Google-Smtp-Source: AGRyM1uunwqLgYm9jgbQ/ZOsydrZMz6VlquotQj22J4B/SyX6E8EKxB07U6/2G1JUeabGRu/7rXGtQ==
X-Received: by 2002:a5d:47a4:0:b0:21e:6994:9ec5 with SMTP id 4-20020a5d47a4000000b0021e69949ec5mr13395173wrb.568.1658912758341;
        Wed, 27 Jul 2022 02:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003a04d19dab3sm6734130wmb.3.2022.07.27.02.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:05:57 -0700 (PDT)
Message-Id: <pull.1304.git.1658912756815.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jul 2022 09:05:56 +0000
Subject: [PATCH] cmake: support local installations of git
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

At least in systems where the user is local and not an administrator
git will install in a subdirectory of %APPDATALOCAL%, so it makes
sense to also look there for the shell needed by the cmake integration
with Visual Studio.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake(windows): fall back to user-wide Git if there is no system Git
    
    On Windows, software is typically either installed into C:\Program
    Files, where all users can use it, or into a location inside the user's
    home directory, where only that particular user can use the software.
    
    Git for Windows strongly encourages system-wide installations, but does
    not prevent user-wide installations.
    
    When building Git via CMake, this matters because we rely on Git for
    Windows to provide the POSIX shell that is needed to run Git's generator
    scripts such as generate-cmdlist.sh. So far, we only found Git for
    Windows if it was installed system-wide, but with this here patch, we
    also find any user-wide installation.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1304%2Fdscho%2Fcmake-and-user-wide-g4w-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1304/dscho/cmake-and-user-wide-g4w-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1304

 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1b23f2440d8..2237109b57f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -77,7 +77,7 @@ if(USE_VCPKG)
 	set(CMAKE_TOOLCHAIN_FILE ${VCPKG_DIR}/scripts/buildsystems/vcpkg.cmake CACHE STRING "Vcpkg toolchain file")
 endif()
 
-find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")
+find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin" "$ENV{LOCALAPPDATA}/Programs/Git/bin")
 if(NOT SH_EXE)
 	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")

base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
-- 
gitgitgadget
