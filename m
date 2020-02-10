Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60792C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E14720870
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB4t6EnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJAbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38408 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgBJAbF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so8606569wmj.3
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QexdTKdKJuL+pTx5o5eRbAL7OmbTHwZGa4FyVyeaTWs=;
        b=dB4t6EnZXbU7sXIoLkADB5pwLNOpd/cOsYWOwIEXoQaKshrtWMHY+djpniMCacx+Bc
         uOtK4NU3pic4ZPjTPMz3dzF1k6vCQu9T2+mTI41tRjWPXPkbLqjn+fApjNkA6zA2ibn7
         Na7OoMNR1zJczCFbjmfeUWDm1io6tQOln6apNbuDsIaC3DrKN8T62G+xxhookvFYM34f
         5KrYMmAT5onJyb2Qzd9rCjoK+yyWNEgT0cwQ47xRXI0oi+hQuiBA4DeCldKtnV9xjmt3
         T7iaZaoMx1Lizp/vfd28mu9UQth/nBCJJHKRoR4Iy+Fmb0am70d9C6Udetl2fdirpoJb
         /DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QexdTKdKJuL+pTx5o5eRbAL7OmbTHwZGa4FyVyeaTWs=;
        b=TLG/T8Zf43lEkk3pbNBeMd6a9Q2v/eD/pk7QNu5eNp8N/NsG9FqeB4odExeB8rXEgz
         KyWtubTruoOAR7tVHo6YSTeYTvFWJWbNmIUmE6NJPaEvknDbLIZNMKgoucU9FSzQYniU
         BX05HTRZnOaZJrNUwKOE25/NWgMkPae1nvsDxHqUo26jAP+9U4zoVaAs5KG8JpSevcPO
         x18fSLE3e0CNZrfU28e1WTEyYR7tclvXjodrVd73LHH+DOEYjBytY9XpFa1Y8hZipRFw
         sF9MZyCwYt74T84E+m/3XstiDwike9zVfqlAUarlQE4DrpUiy5zf7rTEHfwPVcbRv460
         IKTw==
X-Gm-Message-State: APjAAAUZeU9HHCUqZWrifaZouGLChdQEHBuBFlfX1OrEKozssGc5XGu1
        te8fSlyVPWxRzOmMlTbvagZL4xAY
X-Google-Smtp-Source: APXvYqzLicDfvGQVc22eS6TatXaq3lVanG4lV2MQYRq9lDVOLpfn8nnj/fZp7q9Ab9+2BvU8CJkpog==
X-Received: by 2002:a05:600c:21c5:: with SMTP id x5mr11987435wmj.72.1581294664033;
        Sun, 09 Feb 2020 16:31:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w19sm12824372wmc.22.2020.02.09.16.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:03 -0800 (PST)
Message-Id: <c832293ca7ee3cb5013fe927cb2b97734e5039c4.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:52 +0000
Subject: [PATCH v7 03/10] t1300: create custom config file without special
 characters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

Tests that required a custom configuration file to be created previously
used a file with non-alphanumeric characters including escaped double
quotes.  This is not really necessary for the majority of tests
involving custom config files, and decreases test coverage on systems
that dissallow such filenames (Windows, etc.).

Create two files, one appropriate for testing quoting and one
appropriate for general use.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-config.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e8b4575758..e5fb9114f6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1710,18 +1710,23 @@ test_expect_success '--show-origin getting a single key' '
 '
 
 test_expect_success 'set up custom config file' '
-	CUSTOM_CONFIG_FILE="file\" (dq) and spaces.conf" &&
+	CUSTOM_CONFIG_FILE="custom.conf" &&
 	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
 	[user]
 		custom = true
 	EOF
 '
 
+test_expect_success !MINGW 'set up custom config file with special name characters' '
+	WEIRDLY_NAMED_FILE="file\" (dq) and spaces.conf" &&
+	cp "$CUSTOM_CONFIG_FILE" "$WEIRDLY_NAMED_FILE"
+'
+
 test_expect_success !MINGW '--show-origin escape special file name characters' '
 	cat >expect <<-\EOF &&
 	file:"file\" (dq) and spaces.conf"	user.custom=true
 	EOF
-	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
+	git config --file "$WEIRDLY_NAMED_FILE" --show-origin --list >output &&
 	test_cmp expect output
 '
 
@@ -1747,7 +1752,7 @@ test_expect_success '--show-origin stdin with file include' '
 	test_cmp expect output
 '
 
-test_expect_success !MINGW '--show-origin blob' '
+test_expect_success '--show-origin blob' '
 	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
 	cat >expect <<-EOF &&
 	blob:$blob	user.custom=true
@@ -1756,9 +1761,9 @@ test_expect_success !MINGW '--show-origin blob' '
 	test_cmp expect output
 '
 
-test_expect_success !MINGW '--show-origin blob ref' '
+test_expect_success '--show-origin blob ref' '
 	cat >expect <<-\EOF &&
-	blob:"master:file\" (dq) and spaces.conf"	user.custom=true
+	blob:master:custom.conf	user.custom=true
 	EOF
 	git add "$CUSTOM_CONFIG_FILE" &&
 	git commit -m "new config file" &&
-- 
gitgitgadget

