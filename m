Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D04C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKUDA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKUDA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:00:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C82F642
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:00:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z4so3328908wrr.3
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyza2Qzfb0o7qIYUjovbLXZQXbGbmQ6n4f7Hjeg6syY=;
        b=Yqmzdy8cNf7TAEc7U0mPuCQkHk/oo/gHt8lp7bBNa8ItC8DrYZBl7mGUCLFsWWLpX9
         vQ54UTRv2E0X3bYMm7T8IxwatJ2M04s23h8r6DixwX511LEGgGI666mnWiP7F7DjU9C2
         3yxmtXdMMIwP1rAAhbjjzNy18zrUA9l8Oq6VIYULRND6Emx7rOF/jOu6Sryf90FVIiIM
         cWtEv3JdmGX0bMTQPDxT1bK1RPuNAkUaIf5nkInBPTRKN26PlsQO8B3h4aoieU0EL4z3
         qVQb54K3JcHKJlhE3P6nYlBiypbESMahYxqMH89QlrehNaWpEgcuQU9qqjvKKjUTWXk9
         fcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyza2Qzfb0o7qIYUjovbLXZQXbGbmQ6n4f7Hjeg6syY=;
        b=dlvgt+5wwZql7KNNDhh/YNYQ/DXLabIDAz2cn+TJOoBJhjC5Q6sgCi+RwuVuiVjoIy
         hLRFV/Uh81uuM9nqe+zpgcT1l0+TCk2rH1GzvU6nd1qIlASKXChM1ZAU+uV2s/YcMpZ2
         W7UyiwraGwAsGSZtTPZtFUwFLZYf2Knv0vO5aqiymTc2WI8gJo0FEfAkGW4FKmf7mexZ
         SOlCFk3k2vxJp+pJ/vp3eDPsMXhcuZs0M6QizwFq9KcKVTF2M3AwGvnRXKD14T/e0riR
         0GIfyt2DcwGaeEj6PDr2PBZ5ls/3PIN7PK75XDKodk9W3OU+hOMGzw0h0LFecAI04IBc
         4vjw==
X-Gm-Message-State: ANoB5pkECgGPp8mW8N32AW9rupeDC2GfgXzHgwmQLmNGZ92n7ARi9TFa
        DCxIkGko5enQBuaKPBG+n4MCBdstYuA=
X-Google-Smtp-Source: AA0mqf6hRzCgOnJFKUlTFjoP3+nZotqXwn2DUcBtySkelw1a4WkvkOWoif6qDGMWLv5tQjbqP6ujTg==
X-Received: by 2002:a5d:6707:0:b0:241:c56f:583b with SMTP id o7-20020a5d6707000000b00241c56f583bmr6436357wru.382.1668999623754;
        Sun, 20 Nov 2022 19:00:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056000081500b00241cbb7f15csm5278605wrb.106.2022.11.20.19.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:00:23 -0800 (PST)
Message-Id: <0efeec8abdb913786c67775cbd79c8e4285ded10.1668999621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 03:00:19 +0000
Subject: [PATCH 1/3] t1509: fix failing "root work tree" test due to
 owner-check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

When 8959555cee (setup_git_directory(): add an owner check for the
top-level directory, 2022-03-02) tightened security surrounding
directory ownership, it neglected to adjust t1509-root-work-tree.sh to
take the new restriction into account. As a result, since the root
directory `/` is typically not owned by the user running the test
(indeed, t1509 refuses to run as `root`), the ownership check added
by 8959555cee kicks in and causes the test to fail:

    fatal: detected dubious ownership in repository at '/'
    To add an exception for this directory, call:

        git config --global --add safe.directory /

This problem went unnoticed for so long because t1509 is rarely run
since it requires setting up a `chroot` environment or a sacrificial
virtual machine in which `/` can be made writable and polluted by any
user.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1509-root-work-tree.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
index 553a3f601ba..eb57fe7e19f 100755
--- a/t/t1509-root-work-tree.sh
+++ b/t/t1509-root-work-tree.sh
@@ -221,7 +221,8 @@ test_expect_success 'setup' '
 	rm -rf /.git &&
 	echo "Initialized empty Git repository in /.git/" > expected &&
 	git init > result &&
-	test_cmp expected result
+	test_cmp expected result &&
+	git config --global --add safe.directory /
 '
 
 test_vars 'auto gitdir, root' ".git" "/" ""
-- 
gitgitgadget

