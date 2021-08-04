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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC323C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE9260BD3
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhHDXGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhHDXGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:06:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC85C061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:05:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l8-20020a05600c1d08b02902b5acf7d8b5so1691061wms.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kh/lsZojwFcKxM/TjeP6CdgNWnVvWNQHrpOLt5Wghoc=;
        b=uR7LEOFQgchD/lbvyVCgemyX1OZaUsXYtRVPND6hirBWLZ8i5+X7BdFDSVQKnXzbOL
         TqkbcMKUTQhq3q5K0KszMZLmk6qCdVGqt0uib+0JpYrwCMaYwdbi6/MWqxicagIYjc/6
         9p1AA9FnFNTaxUJ1XIcTHZ6j6WugPwEvnWBDZgTzwSAQku/Vg/fMdJCQSCE1mNl+oVwE
         k67+Q/l9nHPBcnTapC15SHDXn7lwV36XJiqBUZ7f2ueNMHQQ/e7FacvuNt1RUbS3DzT8
         zKXqZ7yRY4r+p6CD386Hv1wJQAxmahx3YH/KgngN7ruc63GR2+kwdBqiisLa+XPk8Tc/
         h6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kh/lsZojwFcKxM/TjeP6CdgNWnVvWNQHrpOLt5Wghoc=;
        b=ESZBEmymZuu4tlVBJ6d5pMcSb8Ypt+h8kXp/SP4Km5tJCTvGJB6FXVwKcmHpk4FbkH
         W0mdjklyAfNWEwzYS2CDZRr4teZND2Xml8Jd+2KXTaSOO5gMbwnzIHinPBTz/hr1QgjL
         3D3Q52HSXFS7cISuq47db89Cb05r4EiKzjwETlAL4GCBbSRlGgFh5EU6Mr3a9/ch7SY1
         fxUVYBsRzlqR+WED8Ghqq22ITzldZQXMJKZk++Xs9QKC/4xp8Ka/oHkmqEw9wOaPp6FC
         big/cr86SU8dMr2yRYYkk+sDWRoh+i5957ujQOAqFjWjrtXif8gZezsb2jknQMynjL6b
         831Q==
X-Gm-Message-State: AOAM531T6RQtdwIpTylUKrDxqa0gzf8J2lFCnO5WuVm3yySv4x+JJjwK
        d1nNVPUdGMcjgp5TSYQsedC0O6Peo8gTOg==
X-Google-Smtp-Source: ABdhPJwia6q8FLNu0DtiTOQfSUqr3msvQpQyRHdYvfreVzSziKAHCbGtgdBFwQLYHh2Km18E+s10cg==
X-Received: by 2002:a05:600c:1906:: with SMTP id j6mr11488923wmq.108.1628118349616;
        Wed, 04 Aug 2021 16:05:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f2sm3994917wrq.69.2021.08.04.16.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:05:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] test-lib-functions.sh: rename test_must_fail_acceptable()
Date:   Thu,  5 Aug 2021 01:05:44 +0200
Message-Id: <patch-v3-1.3-f45590a76d5-20210804T230335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v3-0.3-00000000000-20210804T230335Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20210804T230335Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail_acceptable() is really a generic function that can
check if something is a real "git command", e.g. "git", "test-tool"
etc. Let's rename it in preparation for using it in another test
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75a..37da7d9a99a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -895,7 +895,7 @@ list_contains () {
 # accepted by test_must_fail(). If the command is run with env, the env
 # and its corresponding variable settings will be stripped before we
 # test the command being run.
-test_must_fail_acceptable () {
+is_git_command_name () {
 	if test "$1" = "env"
 	then
 		shift
@@ -943,7 +943,7 @@ test_must_fail_acceptable () {
 #     (Don't use 'success', use 'test_might_fail' instead.)
 #
 # Do not use this to run anything but "git" and other specific testable
-# commands (see test_must_fail_acceptable()).  We are not in the
+# commands (see is_git_command_name()).  We are not in the
 # business of vetting system supplied commands -- in other words, this
 # is wrong:
 #
@@ -963,7 +963,7 @@ test_must_fail () {
 		_test_ok=
 		;;
 	esac
-	if ! test_must_fail_acceptable "$@"
+	if ! is_git_command_name "$@"
 	then
 		echo >&7 "test_must_fail: only 'git' is allowed: $*"
 		return 1
-- 
2.33.0.rc0.597.gc569a812f0a

