Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BCFC433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 10:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiB0K0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 05:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiB0K01 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 05:26:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88EC3C4BF
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r10so11064919wrp.3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXhuLXHoQf4mOksGM1brpzXq2irR6upjrX63Ev+gocU=;
        b=qEpOKWrgA+N6WEe1SR3M8qJSxV6YKD5G+ehi1S1gfrUXr8ShnGAd4mMi5Usc+d+rVo
         1yEFrEFDoY9yLUD0OZOBBAVeAwAjFm09HDciT0IkjSwM8ntQhq/zx7WFWBVvrTqzuXME
         TayzHyWnGMQDTc6ZcH6/HJLcPagJ6TYch4TzZ45WlhCt5UGyiXxYES7VwU64AFT5Oo9N
         hALWPbN8oZ6UQJeFL11SOsxV8H7frOe7zafT2kMLiS3//cN5bgZtAbW1ZqBmnzpKzuVA
         TI4E+wkWFzgNTOSlhDw0pIZGZzya8QFqJp4aAFVmMdNxLTSGuI137QGFu8qhiSlm1Juk
         WvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXhuLXHoQf4mOksGM1brpzXq2irR6upjrX63Ev+gocU=;
        b=6nup6bWfex9vNvQUs68OucrZcVMoLL842tXy9DsrDzyKMdRO2BprxbltXFf1cLy3Ug
         13+nHYcBRVMCUAK2amc3q/XDpJnk1azEMWmLU6lCOg1js2YTwfgEOXgJ4UpX7jp1tFCu
         4jxvF0XJZv6CJWEeUO5Hs+JKI9FZsTOeTbrH1TBpDb2ReXppianeft0R0DW+E4EymuRm
         KU4oLL9OvaZIPf7pTSuoPr0RVHrqDk5Y1ifWNY7AxKXrc2S6pWue9u6DQQR7PxJIRjJJ
         Oy5nd1RkoCRwKyIYre5gYcGxxPDYyNMf9TXzei7u/sUncXHxPAgeZXJKHXIpxLe0e8HW
         s0PA==
X-Gm-Message-State: AOAM531iqyldrvbgIbMqc7fApVC2sJa5W6Vf8YnVPLpCyCJ2G++uivqJ
        tEMjp/fg080NNsEXUuzyPM00f+MR0GfnlQ==
X-Google-Smtp-Source: ABdhPJzt+colqzaEC3dUXnqan0m+LHLeyILrK03kPVduhMzIakWX0Zl+BNpB/ABHFNmBlqPW/Bs+Sg==
X-Received: by 2002:a05:6000:3c5:b0:1ef:8a00:93a5 with SMTP id b5-20020a05600003c500b001ef8a0093a5mr4449893wrg.642.1645957550103;
        Sun, 27 Feb 2022 02:25:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a3-20020a7bc1c3000000b00380e493660esm11031685wmj.42.2022.02.27.02.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 02:25:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
Date:   Sun, 27 Feb 2022 11:25:12 +0100
Message-Id: <patch-v4-3.4-c25c4532c72-20220227T102256Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1188.g137d9ee5e75
In-Reply-To: <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the GIT_BUILD_DIR from a path like "/path/to/build/t/.." to
"/path/to/build". The "TEST_DIRECTORY" here is already made an
absolute path a few lines above this.

We could simply do $(cd "$TEST_DIRECTORY"/.." && pwd) here, but as
noted in the preceding commit the "$TEST_DIRECTORY" can't be anything
except the path containing this test-lib.sh file at this point, so we
can more cheaply and equally strip the "/t" off the end.

This change will be helpful to LSAN_OPTIONS which will want to strip
the build directory path from filenames, which we couldn't do if we
had a "/.." in there.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 48ee3b16ecd..ba5186c859b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -41,8 +41,8 @@ then
 	# elsewhere
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
-GIT_BUILD_DIR="$TEST_DIRECTORY"/..
-if test "$TEST_DIRECTORY" = "${TEST_DIRECTORY%/t}"
+GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
+if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
 	exit 1
@@ -64,6 +64,7 @@ prepend_var () {
 # problems. The GIT_SAN_OPTIONS variable can be used to set common
 # defaults shared between [AL]SAN_OPTIONS.
 prepend_var GIT_SAN_OPTIONS : abort_on_error=1
+prepend_var GIT_SAN_OPTIONS : strip_path_prefix=\"$GIT_BUILD_DIR/\"
 
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
-- 
2.35.1.1188.g137d9ee5e75

