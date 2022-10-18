Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22F9C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 10:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJRK7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJRK7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 06:59:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA0980BD3
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l32so10450299wms.2
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEj13aDBcZ+qGqPB4u07gMH3+zEFKRTB1kYVmy2u0vs=;
        b=XYQ23By1TT1gCfC+IABzDe3nN/Od5bBvK5C4DauaLExguOQIcswLYMA/SQoMg/JwvE
         pjGJfJ5B/gNVCaPczx4vFDO8liSO8eNJ32ZrCIife/0RwksUHj06NIbMhaEpucZuosM2
         EH+iNUTdCuHtJNDYASqrT4CKLIUYOkVHnGJ4F/OOmrcfi2kNT3AW+fUROGw+ZTWW9RaP
         rfh2t65Hgw6yaXRg5AL5bGxynr4sGi7IE21ETsXaWB16cK9XEJv4OAprxGkOmaA2F8+A
         RofPMPJyyffi1lIo7PWe2eBcL9uefLumn3g8dGBf14QtnbOqAalzfhyJpl254Yb4mR3O
         QT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEj13aDBcZ+qGqPB4u07gMH3+zEFKRTB1kYVmy2u0vs=;
        b=oH3S/tSkSFdSyhOqin3/80JBVSEUBxESJ1ZaMP5QSuKg7ADYZqzl+LWzdnzYrjeElZ
         EZTHWr7sR4IXH9zqgrpfJztBpq9eDMRR6gQN22VZvpfU/iWJ5+ZDW9+SyfUYqwGfhSg+
         GrXV4N4tTiBQ2X/tTlXBeFcbK4MzWwTGhZv+bPG7ASQBISOjNqbQSn4EayI/RkLWKcMB
         aYFwrdUO1RjgN7XWZhjhFUTyzR+/gvVECy0RqC52pKrRPvdIk1KAO//PEUIgx9tcvyT4
         JShSX4oE8UHZehfaNWVc21eT61Wlc4IQ0O4FyF5YPC93wcbnbA6lGOAYnSIMgKhuUaic
         2nRg==
X-Gm-Message-State: ACrzQf25maL7ccMAdtK9W49ymJeXGFmFtZyEXDN0LVSIh9C/aI+gzeET
        zu7V5rErKhc42kfWNueun9azvkThwps=
X-Google-Smtp-Source: AMsMyM7BlKFVs5LVxlS08dWWFRdrYCyUiIvZOoDuGM2Um0bfC0mpmEocVfSFCrngiWyc5+CiEP1hAA==
X-Received: by 2002:a05:600c:3b99:b0:3c6:8b8e:a624 with SMTP id n25-20020a05600c3b9900b003c68b8ea624mr1551278wms.113.1666090748725;
        Tue, 18 Oct 2022 03:59:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3-20020adfee43000000b0022add5a6fb1sm10687523wro.30.2022.10.18.03.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:59:08 -0700 (PDT)
Message-Id: <356b2e9a1007bcd1382f26f333926ff0d5b9abe2.1666090745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
        <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Oct 2022 10:59:01 +0000
Subject: [PATCH v3 1/5] cmake: make it easier to diagnose regressions in CTest
 runs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a test script fails in Git's test suite, the usual course of action
is to re-run it using options to increase the verbosity of the output,
e.g. `-v` and `-x`.

Like in Git's CI runs, when running the tests in Visual Studio via the
CTest route, it is cumbersome or at least requires a very unintuitive
approach to pass options to the test scripts: the CMakeLists.txt file
would have to be modified, passing the desired options to _all_ test
scripts, and then the CMake Cache would have to be reconfigured before
running the test in question individually. Unintuitive at best, and
opposite to the niceties IDE users expect.

So let's just pass those options by default: This will not clutter any
output window but the log that is written to a log file will have
information necessary to figure out test failures.

While at it, also imitate what the Windows jobs in Git's CI runs do to
accelerate running the test scripts: pass the `--no-bin-wrappers` and
`--no-chain-lint` options.

This makes the test runs noticeably faster because the `bin-wrappers/`
scripts as well as the `chain-lint` code make heavy use of POSIX shell
scripting, which is really, really slow on Windows due to the need to
emulate POSIX behavior via the MSYS2 runtime. In a test by Eric
Sunshine, it added two minutes (!) just to perform the chain-lint task.

The idea of adding a CMake config option (á la `GIT_TEST_OPTS`) was
considered during the development of this patch, but then dropped: such
a setting is global, across _all_ tests, where e.g. `--run=...` would
not make sense. Users wishing to override these new defaults are better
advised running the test script manually, in a Git Bash, with full
control over the command line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2237109b57f..6ac20bc5054 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1088,7 +1088,7 @@ file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 #test
 foreach(tsh ${test_scipts})
 	add_test(NAME ${tsh}
-		COMMAND ${SH_EXE} ${tsh}
+		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
 endforeach()
 
-- 
gitgitgadget

