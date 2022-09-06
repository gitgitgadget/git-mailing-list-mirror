Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30012ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 13:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiIFNLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiIFNLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 09:11:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8791C6BCE9
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 06:11:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b17so2043716wrq.3
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=lK13n0J9B0+HA/bv4Q2PLLry6hE1FNg3803j+DY/GdQ=;
        b=Y1VAktafrTOIz4vf6+f/XeTWUdrvib+Gn/mBBpr6Me6CZn7hooHWsUkUkQmeL23BTh
         NQjDpqV5zTMCaDhCSPuwvEqNsrTtXGXKvGQuwsVm5Ui2gU8uwikv3NbnLIqLzGGgpsUh
         wvlPdfI+O42DCoXhmRUSaSlfQeaDCLGZ5yNjhcNd1A097SMsjO9jdNpNm1vcG8MIwNTu
         thGDQ18rFI4YvgvcJa28CR78HWOz/MX2ykPTgqehngrEchBlh2F+DdrQzATkagHcHeRx
         kutySizL71UupB/hfTVTrk0vs8GEATW8d4czdmicmBfBIKbbBDzm5eTjRbKNgHa6MYIn
         t1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lK13n0J9B0+HA/bv4Q2PLLry6hE1FNg3803j+DY/GdQ=;
        b=c1+2OdSNXwKMlnPO9P7YL8Vqr9BratUdd0lGXBh2c2onYpHidy5/plI1OlzjphbTca
         6LXkKWwirdo2I6kNELb+hed1+8T8tDRZMocFeIsGK5AQxuJ3D0vu9g3JYtw/cv/XeOhp
         LpcPL/qiL0q7bIxJOjlsRm3xKqlxPR3d1+ZOii4yXDpM7Tt1Vw06ioXpDXN3Vy72dkI4
         kd4gRjqtnvl/nkXFAvS+GwRc9xU3AyJhexzNvXOee0lgDwa6U++jiDCSW/t6thTlWS/b
         http7xwCey3VdoLu1sxnKe+/KS6LMqUta/A75Yok75EdyL/DRh0SiDGVTuc2bZmQ5n28
         zJGg==
X-Gm-Message-State: ACgBeo2FQX24xT1LFy5d0p7ctDsb7wR+Vy/4P7Ufj4K4MkaPk3IdRZqg
        GqjpyaUucFO6b0k7iKY8fvilN76YH3Y=
X-Google-Smtp-Source: AA6agR4WKb6ikcahsyqi+vooC+xSid9iHYpLI9QXLPrp4O3DzUVp9EdFy8j8ShiEKFcW5Uz/Hd5dag==
X-Received: by 2002:adf:d1c7:0:b0:226:ee75:3e73 with SMTP id b7-20020adfd1c7000000b00226ee753e73mr16947665wrd.239.1662469860761;
        Tue, 06 Sep 2022 06:11:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh6-20020a05600c3d0600b003a845621c5bsm15257257wmb.34.2022.09.06.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:11:00 -0700 (PDT)
Message-Id: <ad7c41401ee942152b525de27b809b6458f2159a.1662469859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
        <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Sep 2022 13:10:57 +0000
Subject: [PATCH v2 1/2] t0021: use Windows-friendly `pwd`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows, when passing paths from shell scripts to regular
Win32 executables, thanks to the MSYS2 runtime a somewhat magic path
conversion happens that lets the shell script think that there is a file
at `/git/Makefile` and the Win32 process it spawned thinks that the
shell script said `C:/git-sdk-64/git/Makefile` instead.

This conversion is documented in detail over here:
https://www.msys2.org/docs/filesystem-paths/#automatic-unix-windows-path-conversion

As all automatic conversions, there are gaps. For example, to avoid
mistaking command-line options like `/LOG=log.txt` (which are quite
common in the Windows world) from being mistaken for a Unix-style
absolute path, the MSYS2 runtime specifically exempts arguments
containing a `=` character from that conversion.

We are about to change `test_cmp` to use a test helper, which is such a
Win32 process.

In combination, this would cause a failure in `t0021-conversion.sh`
where we pass an absolute path containing an equal character to the
`test_cmp` function.

Seeing as the Unix tools like `cp` and `diff` that are used by Git's
test suite in the Git for Windows SDK (thanks to the MSYS2 project)
understand both Unix-style as well as Windows-style paths, we can stave
off this problem by simply switching to Windows-style paths and
side-stepping the need for any automatic path conversion.

Note: The `PATH` variable is obviously special, as it is colon-separated
in the MSYS2 Bash used by Git for Windows, and therefore _cannot_
contain absolute Windows-style paths, lest the colon after the drive
letter is mistaken for a path separator. Therefore, we need to be
careful to keep the Unix-style when modifying the `PATH` variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0021-conversion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bad37abad2c..15482fa78e3 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -8,8 +8,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-TEST_ROOT="$PWD"
-PATH=$TEST_ROOT:$PATH
+PATH=$PWD:$PATH
+TEST_ROOT="$(pwd)"
 
 write_script <<\EOF "$TEST_ROOT/rot13.sh"
 tr \
-- 
gitgitgadget

