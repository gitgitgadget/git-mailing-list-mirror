Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E4EC35243
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 00:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A8621835
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 00:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuh34G7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgAXAVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:21:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52775 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgAXAVN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 19:21:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so91551wmc.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 16:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vzbm2jbZgmjXl+MHBE3DtIUgRyeqxuVjjO8cWWLto1M=;
        b=nuh34G7TwZWBCQCq22YQUEd3sy4wOgy1AxYZnPvrEmDaE6dpliSka1OYnQDMYxfSww
         FrdaOGB7PzkaA1UE9EqEcc6a/Dj4DmAeeUYeNsyf6SlmhsRDnO7UdAkFCjSqZTUllMmX
         mkQvtd/r2gZnLv9jjsYjZ7gKpNG5aBPID3FZLmVt7m1uFoh5sjb55YUi8XyPU24CEVfU
         /pgD3lW62Rc2H/rwxLUUwy8k7IJmetJBO4EMIDC8K//Js+JiH2k6v4EahVWL44IfcwLC
         K6YtdAly+ZV2htC5FkHJUHewXI3WHcqtpBSDjJhaCJi9l1GdtuHN4S1vWNFGHhYx9VFG
         BoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vzbm2jbZgmjXl+MHBE3DtIUgRyeqxuVjjO8cWWLto1M=;
        b=Rr2GAhDCbOGBbWO8cyd5NMavdzDWu3R35p5azx1xR9Fyi7MxAVBCRP0lAe05aB0nCR
         +1PHcae7OOR7eVK2YKpQehlJb3yxe/QPcHjFhS/eDysfGiCnt97Uc3Ni6ySMRZcDCRKU
         /hRgBhEhNhfVnkX0lQdGC390WuTtuRSE1S12+A9gdd3Yr2pMX93wfY64FJt/t/dphwaj
         9fQh5RQdUwT2wV0K+6xlGzbVQola0JZXDqVogSkXeeXhqOBlwk2JkoIpjPcL4nYRWXIJ
         f2UE0euQbVGz6sq+s8uLkKExdrWGOf+ALGuCjKsrGhzO9Rd05ItBUvazzR27pT2KXsB8
         m6pA==
X-Gm-Message-State: APjAAAWAmuINiyCkezU8qIIOfKQqr1gXUsHbEBa7UgleNgNtluUTifF+
        EBbRfcBvpFmd5HYsCM6Y22dh9Icg
X-Google-Smtp-Source: APXvYqzlOf97SIdyCWfq4i8DocVLuvE1TxnRelPzHPEb4X+EzKgatGMYWTkeumVDIwoykWnzKOt4uA==
X-Received: by 2002:a05:600c:291d:: with SMTP id i29mr486392wmd.39.1579825270969;
        Thu, 23 Jan 2020 16:21:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm4617041wmj.3.2020.01.23.16.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 16:21:10 -0800 (PST)
Message-Id: <9d19794dfd667b3f9752f0e8118dc9eb0c8f59f1.1579825267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 00:21:03 +0000
Subject: [PATCH v4 3/6] t1300: create custom config file without special
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

