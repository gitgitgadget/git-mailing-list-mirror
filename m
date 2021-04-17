Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55970C43460
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379CB61186
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhDQM7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbhDQM7G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:59:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7EC06175F
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:58:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m9so16503114wrx.3
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iWbM+CDNzFxkO2DG3TEFGVGW7b8pODtnt1iCNZaO8k=;
        b=VZvLDpAEkZlkgSAJQ9O/qPdYVbFWRTtLq7pL2XRWQZ5A/IKTNnRZKMMqVz+8UKHNQz
         lUlEM8+N1Qj9IA15o/N4mdCGMksY6IigFHDpEcjo1fMS+bil1Bes4ykSE2VQkwNTcTwT
         jRIeVI7Ph6cssbCiJr/7L4yc79OS636sN8YP47fsj9mJ4xq/nHD2cTNa9d11LeqPUVOb
         jjqbf0XuyaqCXVmC7jO/0cyMMjWvqcCE0EVTdKHWJr2x6ZJOyy83iUwUZJBq7B8y/hL0
         tUx4iv6Gl/1GuI3CDLQTYwYZLXl0hD1d1nJGgOFNDcjzc2RO7E2887rLuyMl/hNAjpD/
         udOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iWbM+CDNzFxkO2DG3TEFGVGW7b8pODtnt1iCNZaO8k=;
        b=bfWcFOMG4jh8OOG0afVOIvZRsXCy/jN/F01kIOjpo/Vf9P5lcpmDF7GJ4oLJXdHnI5
         sLKq6yRBRH8Wecs92U+HJ3M0d3jyuotbExhyUNT+nj/AS/mBdf7jYALbryX5JVKALbTh
         o0u0IumX2Uto81r+BXlLGDcRWhOF+htz0M1qtiei/P9i9NViMZSvNpK2QZXsdnaoFg4o
         0O+0lULCHQwYmX2J/NVtIgth/9tM35Oh0rsyHvpLlv+TLfPXlYW1jGbUjMx9pZ38tW+P
         Hw7Ui+rYh3Vr7q3XJYL1GzXu1dySioq7DXm4lYCX66TFkYVz+8ETybDiySoVfnJLMN6Y
         KSCw==
X-Gm-Message-State: AOAM530Qh385Qa8igxlr6hnzVVu1YQUHfFgS98wijYTZkO3WBWyrPHrZ
        0D3CIbjUhJ6regu9AIn8lX/cOq1GvJRdnw==
X-Google-Smtp-Source: ABdhPJycpXlsRTgjQQs/BwrOixB9TOfAeXgJ1PIn71Zhdu/QokxMF4Sdaxm96E6mYUfL219NOhaSxA==
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr4282431wri.125.1618664319088;
        Sat, 17 Apr 2021 05:58:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12sm12452909wmd.3.2021.04.17.05.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:58:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] test-lib-functions: remove last two parameter count assertions
Date:   Sat, 17 Apr 2021 14:58:27 +0200
Message-Id: <patch-3.3-b7b11a60bcd-20210417T125540Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g7084a9d5a2d
In-Reply-To: <cover-0.3-00000000000-20210417T125539Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-0.3-00000000000-20210417T125539Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a couple of parameter count assertions where, unlike the
preceding commit's migration to 'test -$x "$@"', we'll now silently do
the "wrong" thing if given too many parameters. The benefit is less
verbose trace output, as noted in the preceding commit.

In the case of "test_file_size", the "test-tool" we're invoking is
happy to accept N parameters (it'll print out all N sizes). Let's just
use "$@" in that case anyway. There's only a few callers, and
eventually those should probably be moved to use the test-tool
directly.

That only leaves test_line_count, I suppose I could leave that one
alone, but since it's the only common function left that does this
assertion let's remove it for the brevity of the -x output and
consistency with other functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9f6d46b8b1b..a2081ebcdea 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -821,10 +821,7 @@ test_path_is_missing () {
 # output through when the number of lines is wrong.
 
 test_line_count () {
-	if test $# != 3
-	then
-		BUG "not 3 parameters to test_line_count"
-	elif ! test $(wc -l <"$3") "$1" "$2"
+	if ! test $(wc -l <"$3") "$1" "$2"
 	then
 		echo "test_line_count: line count for $3 !$1 $2"
 		cat "$3"
@@ -833,8 +830,7 @@ test_line_count () {
 }
 
 test_file_size () {
-	test "$#" -ne 1 && BUG "1 param"
-	test-tool path-utils file-size "$1"
+	test-tool path-utils file-size "$@"
 }
 
 # Returns success if a comma separated string of keywords ($1) contains a
-- 
2.31.1.722.g788886f50a2

