Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A482C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 21:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiBVVzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 16:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiBVVzo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 16:55:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD6A2505
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:55:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j17so9316689wrc.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/oIHLK4I63Sfe9D8hsmoCh3J+3T/h1GMT5THQxy34QI=;
        b=NwuBCZYEmeVOLh0gh3am1VfIz6BLKCRpjRhnlye6/BkvcbHxILE4qElp+Or/q8uAVZ
         tyq/ZfHJFRdLhrbnK+mGwMGEYg8OCyuBXG53QTh7G37kKloPyvfiXuCFHO8AXQdwiArW
         2ldN+HEs+NNaRQYd8yJrMrBlmhi50r2s1s5HqJ71nbyetTOQA4maJGpOv8tFKFiBQ07X
         5xbKqaT7//lihYG0VqSD5ZgYjYMJBrhSMc8lq9ZfqoJq0xoR5Qcu1UvtaDSjN0nRbqp2
         D4RgAZDCq5gG5dwlxMtBEUb6XWdTi/ouG+vJSZX0ACdZac1IeCD0shKrKFPLhxA5bHhh
         B8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/oIHLK4I63Sfe9D8hsmoCh3J+3T/h1GMT5THQxy34QI=;
        b=kRdLFi1V7k0czzmBeq6RjY2zeOlJjBI6XymxIFZXu4FZLVyzTNqpT80qgDMh+KC67q
         tD5tVaijb96V9hHpCHcWxZ2LAbZ+qo8Y082v9zv8aGs2nkdxInQFNFI8D+GYaXJm1Q0H
         VZXtr77mQ0KtZdQtjs9UaKahwdKKP+lQBjJBHfxaW1gkhNpx3/rSrnEFW0lTxBbjblgW
         MCwH7lunBVszEwi7LbFJg5clJlcMP4kO9lsWoEKWE7JcU8Cpp01JtbfAllwPZwpyngh/
         /py5ZD77MS8Z6Nq2Mkup7ItfcchRLOur58x6diplFZ2pOpbv6Gaoy2PUE9UKAjFhf0Y8
         JZJw==
X-Gm-Message-State: AOAM532/f8bWZymvdIin2xUlkaGi49uVj/CEpxTK+mf7T5kBDuGQZboQ
        +UeIno7Aq5lC+YizHlpYSL8=
X-Google-Smtp-Source: ABdhPJz/oSappAf2RRrnAlTPZO3lU1EDDbUF8uT2pcdig/Dx2pYRWiYRRRyAYtHF+FSy0/4kESyyIg==
X-Received: by 2002:adf:ebc1:0:b0:1e6:1109:5a1c with SMTP id v1-20020adfebc1000000b001e611095a1cmr21308514wrn.228.1645566917388;
        Tue, 22 Feb 2022 13:55:17 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id u12sm39471997wrw.32.2022.02.22.13.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:55:17 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, cogoni.guillaume@gmail.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, matthieu.moy@univ-lyon1.fr
Subject: [PATCH v3 3/3] tests: make the code more readable
Date:   Tue, 22 Feb 2022 22:54:30 +0100
Message-Id: <20220222215430.605254-4-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222215430.605254-1-cogoni.guillaume@gmail.com>
References: <xmqqbkz4105s.fsf@gitster.g>
 <20220222215430.605254-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the parsing of the output of "ls -l" by test_path_is_symlink() and
test_readlink().

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
---
 t/t3903-stash.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index a6ad52db9f..d5ecee4fcc 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -393,7 +393,8 @@ test_expect_success SYMLINKS 'stash file to symlink' '
 	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	test_path_is_symlink file &&
+	test "$(test_readlink file)" = file2
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
@@ -404,7 +405,8 @@ test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
 	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	test_path_is_symlink file &&
+	test "$(test_readlink file)" = file2
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
@@ -416,7 +418,8 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
 	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	test_path_is_symlink file &&
+	test "$(test_readlink file)" = file2
 '
 
 # This test creates a commit with a symlink used for the following tests
-- 
2.25.1

