Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFBBC10F1B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiLSKc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiLSKcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:32:55 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAFD6347
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:32:54 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a16so12187186edb.9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHJtcCXxvgJtmSGiGjJvyzcO09YKQEqOfUIkN13cJRE=;
        b=BWPSbqRD8PaXox0tZJ2Hdhl2cKTwf1PZgt+/2V9WXZS3va+gPLAnaygbdnF+M9eMV9
         vV/ayvGCk/6XF+9eiIPXqJ85BaOXsURq/+HaoZSKCOMBqX06vnDVgLUh5GYak14Oa205
         CpRvWGC11WWC+u+OdrSzpfhEiBB+ycF3YLw5puG1k+/LWpnExOk3Vw0GOSULvURzxQpn
         nyyPFjAT2mCTvNoCUntRNhurUnQTt7bWZcxAzRXd06NeXCwiDCz9jcwJWWsw2G7N86cK
         pV6kEXI777hxBBvchcaXxh3nEGyKBFSLpPilXOUVPpp+6ObsKmYjzTUI1hazHrNuF70o
         RyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHJtcCXxvgJtmSGiGjJvyzcO09YKQEqOfUIkN13cJRE=;
        b=LablNBqa3Tz9saUP0cwzCEGbAf1Z/Oc7VOiisEGOqgvH5JrGIX/Avf3DjTL5tx8lff
         Il5eSnsfuzAdJu9jo9P4IlooVR0RC9ErYPNYtG44zu94pTu1vFHgzFqm/jUJD3iZOGpa
         vfaIHWtGh3YWU3a3JAEvtDnm05CEyJo8sBDD2D8xioqgCylzdw4F1IsnGUicwDTaj6+j
         reVVsNAEE45x1PuUtsN1fA7d27dy/aTBUVNUcCiQCEOp/DEkSiT+BUWq+6vhjHeKHqbI
         VP9c+LBUciJ4L9wTvc7cHhrnNK9jRAGIiluRZ+3S6JEghEf9SVDEktaKmAXWLkZf7wkn
         ZwMg==
X-Gm-Message-State: AFqh2koR0MdXG43YKEK9EiDEVDLTBbNjdwO17Uzjkh0iuSK6+WbI1vji
        JHxboOU4NKHdZiC4pKBMBzhv1da4+VGFyA==
X-Google-Smtp-Source: AMrXdXurkT0+EXPp83dskmhlvywBZ00Tj5E/4voixgK65A+K5S/jyRYnVSIoA7enkC/mXm7BsPHRpA==
X-Received: by 2002:a05:6402:1595:b0:475:c621:a0e4 with SMTP id c21-20020a056402159500b00475c621a0e4mr10900486edv.26.1671445972436;
        Mon, 19 Dec 2022 02:32:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p26-20020a056402045a00b004610899742asm4177918edw.13.2022.12.19.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:32:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] cmake doc: modernize and cross-platform-ize the docs
Date:   Mon, 19 Dec 2022 11:32:44 +0100
Message-Id: <cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the cmake docs to use one-command build instructions using
options that "cmake" supports an ill our supported versions, and in
2/2 re-arrange the docs to make it clearer which part of the
instructions are platform-specific.

Like the just-submitted [1] this extracted from [2], and the range
diff below is to [2]. The only change since [2] is a trivial reflow
change in the commit message.

There were no outstanding issues or feedback with this part of [2], so
hopefully this can advance relatively quickly.

1. https://lore.kernel.org/git/patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com/T/#u
2. https://lore.kernel.org/git/cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  cmake: use "-S" and "-B" to specify source and build directories
  cmake: update instructions for portable CMakeLists.txt

 contrib/buildsystems/CMakeLists.txt | 70 ++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 20 deletions(-)

Range-diff:
 1:  fc190b379cd <  -:  ----------- cmake: don't invoke msgfmt with --statistics
 2:  1a11aa233a3 !  1:  2411acc9d4c cmake: use "-S" and "-B" to specify source and build directories
    @@ Commit message
         cmake: use "-S" and "-B" to specify source and build directories
     
         Rather than the multi-line "mkdir/cd/cmake" recipe provide an
    -    equivalent one-liner using the "-S" and "-B" options, and then suggest building with "make -C <build-dir>".
    +    equivalent one-liner using the "-S" and "-B" options, and then suggest
    +    building with "make -C <build-dir>".
     
         The rest of these instructions discuss e.g. running tests from our
         top-level "t/" directory, so it's more helpful to avoid changing the
 3:  b9ddb5db1d3 =  2:  d6058ed0f22 cmake: update instructions for portable CMakeLists.txt
 4:  7b7850c00ee <  -:  ----------- cmake: don't copy chainlint.pl to build directory
 5:  82ecb797915 <  -:  ----------- cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
 6:  1f326944a07 <  -:  ----------- cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
 7:  973c8038f54 <  -:  ----------- cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
 8:  b8448c7a8a6 <  -:  ----------- Makefile + test-lib.sh: don't prefer cmake-built to make-built git
 9:  5135e40969e <  -:  ----------- test-lib.sh: support a "GIT_TEST_BUILD_DIR"
10:  65204463730 <  -:  ----------- cmake: optionally be able to run tests before "ctest"
11:  e25992b16f1 <  -:  ----------- cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
12:  4905ce5321d <  -:  ----------- cmake: increase test timeout on Windows only
13:  6c6b530965d <  -:  ----------- cmake: only look for "sh" in "C:/Program Files" on Windows
14:  563f1b9b045 <  -:  ----------- cmake: copy over git-p4.py for t983[56] perforce test
15:  917a884eb65 <  -:  ----------- CI: add a "linux-cmake-test" to run cmake & ctest on linux
-- 
2.39.0.1071.g97ce8966538

