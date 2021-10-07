Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C52C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E100610E6
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbhJGKD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhJGKDr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:03:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134BC061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:01:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so17344050wrg.5
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AN1AIWQCUFRhS3mKmfAn4+sELbMSyOhU+N4C2UODX8g=;
        b=CIL1L2z3y8/FiFN3wt7aHwUcJ60Zfpr+3B3MYIHYHijSjsBMAsITL5ekt+XWg4Lwjd
         3r7lMU4GA3qr50Yke9xSBdF95ganM7bdTEblufwXrBtLdoYbqZG8XcknQunXrB1ofvtZ
         QVuBkLn2c9GhoCSBTX9fCp6+6u+1Kp5VU5E4QEf91FX/FO0CUmEXCnMTFLo17P9tUdi9
         7Mx05cb/nJoRcdpA/iLTnY8gVN7JaDqP7HWeD0X35AgbiAdetyOnikWKKySy89yzZroL
         ZfCo3FN2bTpAUUQXPogaLQNUBwK7LHoXUyX9f3O1mT5ZSGQeLsNm32F0t09nkefXi17C
         C8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AN1AIWQCUFRhS3mKmfAn4+sELbMSyOhU+N4C2UODX8g=;
        b=4kELXNBryz2HKVZw3W1dF7tI4gPP6e6Jzv7psrHJKmt2UtQ6Ah5HfyBJrTDYwVVn6y
         hOU9y0lxZoFQ3r92VYwdkzBC0zr+dPJ/kzmiu2h6735dvls2lyH3c/bTeJnUmtkA9ybJ
         3uTVC6tXBny1MrucIKxlrX3bIaf/uJQgG31CL1fA+p9FnDgYh7trh8Fex2NwDrKoofv9
         B94J2cOKhrNfwalZiZbnuMIxiOb8PzvVQjecpAPIve6PrmZORTe0iMs8J8HtCeqZ6hNK
         eru+BCVedxDRUGsliBrGk8SDzAdkugY/wNcX8Jvjm/ocVYoWLQm6lnwKklVK21fRIiCE
         p/Zw==
X-Gm-Message-State: AOAM5305cmgtnlNuHAMxw90AD9RccxodxqC47ZCHLUUZno3cON97t/M1
        3tR/LP5BVFDe8fErALbgr9ee6TRXUZYKzg==
X-Google-Smtp-Source: ABdhPJxijtrteznNUzXi/nupej6PqwbAEK9tU9oF6UR1m3qRBs8Kb3xxxcs6Caipkvk5SIJlvoonkw==
X-Received: by 2002:a1c:8054:: with SMTP id b81mr3617718wmd.87.1633600910344;
        Thu, 07 Oct 2021 03:01:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm628559wrr.53.2021.10.07.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:01:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] ls-files: add missing string_list_clear()
Date:   Thu,  7 Oct 2021 12:01:36 +0200
Message-Id: <patch-v2-6.7-fc10353c0c5-20211007T100014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been here ever since 72aeb18772d (clean.c,
ls-files.c: respect encapsulation of exclude_list_groups, 2013-01-16),
we dup'd the argument in option_parse_exclude(), but never freed the
string_list.

This makes almost all of t3001-ls-files-others-exclude.sh pass (it had
a lot of failures before). Let's mark it as passing with
TEST_PASSES_SANITIZE_LEAK=true, and then exclude the tests that still
failed with a !SANITIZE_LEAK prerequisite check until we fix those
leaks. We can still see the failed tests under
GIT_TEST_FAIL_PREREQS=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c                 | 1 +
 t/t3001-ls-files-others-exclude.sh | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index fcc685947f9..031fef1bcaa 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -781,6 +781,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		ret = 1;
 	}
 
+	string_list_clear(&exclude_list, 0);
 	dir_clear(&dir);
 	free(max_prefix);
 	return ret;
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 516c95ea0e8..48cec4e5f88 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -8,6 +8,7 @@ test_description='git ls-files --others --exclude
 This test runs git ls-files --others and tests --exclude patterns.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 rm -fr one three
@@ -102,7 +103,7 @@ test_expect_success \
        >output &&
      test_cmp expect output'
 
-test_expect_success 'restore gitignore' '
+test_expect_success !SANITIZE_LEAK 'restore gitignore' '
 	git checkout --ignore-skip-worktree-bits $allignores &&
 	rm .git/index
 '
@@ -125,7 +126,7 @@ cat > expect << EOF
 #	three/
 EOF
 
-test_expect_success 'git status honors core.excludesfile' \
+test_expect_success !SANITIZE_LEAK 'git status honors core.excludesfile' \
 	'test_cmp expect output'
 
 test_expect_success 'trailing slash in exclude allows directory match(1)' '
-- 
2.33.0.1446.g6af949f83bd

