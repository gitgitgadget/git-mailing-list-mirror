Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C971F954
	for <e@80x24.org>; Wed, 22 Aug 2018 12:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeHVQJi (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 12:09:38 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39494 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeHVQJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 12:09:38 -0400
Received: by mail-wm0-f47.google.com with SMTP id q8-v6so2041870wmq.4
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/Cg+DgEOBPwuIQa1hK+cxO7Ng8K7x65lzc+wMwROfg=;
        b=Xf5A4yN16+Jso+9ddKbMyZO73UVMihBoz3TJGgnjQQmT/27dj4HD+OIoOHpJI6RdD5
         D26cBxdvCSdoLyMkRoeGvOHohBasDsLq6Jyok+kDZYL2KgqEkmIe0gNnudjJGVKzdKmK
         hkZrY0gLtnMVCmIEX1TusAzSuOoBJ3eTYyklfhMtO+bbDw4Gx8vTScmhrmJgeUQVLgfA
         +YgzfVuWBbSpGnL6WhYqDWq1ICNYYPIbXRd0pHLKW/AHL/OOLedHE4L0TuEvprlNy0Ad
         rhtArURiZRzAMWfx94TJpSmAyXBCzciecTMdgHVLTTe2g4AUg7vxpAMWbiDXGzqMpc4I
         lGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/Cg+DgEOBPwuIQa1hK+cxO7Ng8K7x65lzc+wMwROfg=;
        b=rbn0s4xTJGahE7kELoewNLLFy3CkFyTm3I/OT8zhzVoz3BDkSTeVFaL7ZZRAUOVzj/
         WyDlJf6dBlvrFUP+9uLezYRyYm6FfO0i+xX2Kd1pmu3Xw3k2qi1dYrdyYiEEJLn4cuVg
         2l6meXIMsORS/RKjyuUmx26MEnfPFBY6ry2E6G8DTAAPAM60DAac/iY23nXoHcKP15Uq
         5zx+ZRcR+ZH/ZwqlAMKTjjJlTfx0MmLzYgcZee5YBERYK6zQ10j8xNc/Bd1c0eNzywdy
         sMFEMdsQwuAmpBENoZZoeDTRgB262rDKq4ups5xTFEnwqVFy+M4PvQJSwkDTX6k45L6F
         ZSdQ==
X-Gm-Message-State: APzg51CVN6f4eF3Ox2D6NhPKB4OA2WDk96JFaHO6i+uNDCi7ntMcWenU
        KZTcL0qG3y6Q9k6GzgqEEPo=
X-Google-Smtp-Source: ANB0Vda7ZSWPpC1riA9Eysn/FOEaZOnGEBADbTAN7DYUYH52GNG8wD1v+CqoYQbP5hD3WniEPpIBNg==
X-Received: by 2002:a1c:6354:: with SMTP id x81-v6mr2097589wmb.23.1534941890144;
        Wed, 22 Aug 2018 05:44:50 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1931855wrw.35.2018.08.22.05.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 05:44:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] t4051-diff-function-context: read the right file
Date:   Wed, 22 Aug 2018 14:44:37 +0200
Message-Id: <20180822124437.11242-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.136.gd2dd172e64
In-Reply-To: <20180822124437.11242-1-szeder.dev@gmail.com>
References: <20180822124437.11242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test ' context does not include preceding empty lines' in the
block of tests 'change with long common tail and no context' in
't4051-diff-function-context.sh' tries to read the file
'long_common_tail.diff.diff', but that file doesn't exist as its name
contains one more '.diff' suffixes than necessary.

Despite this error the test still succeeded without checking what it's
supposed to, because this erroneous read is done on the line:

  test "$(first_context_line <long_common_tail.diff.diff)" != " "

which means that:

  - the command substitution hides the error, so it won't fail the
    test, and

  - the result of the command substitution is the empty string, which
    is, of course, not equal to a single space character, so the
    condition is fulfilled, and the test succeeds.

As a minimal fix, fix the name of the file to be read.

In the future we might want to reorganize this test script (1) to use
'test_cmp' instead of 'test's and command substitutions to catch
failing commands and to provide helpful error messages, and (2) to
specify what the expected result actually _is_ instead of what it
isn't.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t4051-diff-function-context.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 2d76a971c4..4838a1df8b 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -174,7 +174,7 @@ test_expect_success ' context does not include other functions' '
 '
 
 test_expect_success ' context does not include preceding empty lines' '
-	test "$(first_context_line <long_common_tail.diff.diff)" != " "
+	test "$(first_context_line <long_common_tail.diff)" != " "
 '
 
 check_diff changed_hello_appended 'changed function plus appended function'
-- 
2.19.0.rc0.136.gd2dd172e64

