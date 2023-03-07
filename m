Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47169C678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 07:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCGG7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 01:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCGG7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 01:59:23 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7A28860
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 22:58:41 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id r16so11784199qtx.9
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 22:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678172308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgVoanw/+v39j+sy3oPGO1zc8GbPNUKjVogyHFC0Gro=;
        b=Vp4jggabtzmyINtTkc8uLK8Cpl3+9lFYmIdKgkVjdSYvOxeMD9jOO/oR4kyVJ5G/MN
         EiFzSqHStUT+GYuSmv351nLK5IQBaGJUpJ0qGxaLuTIHW+466kwN8LEUdQK2UzzB7yR3
         YX8hgeA/9CeT13U/6cLLiVp9WyNAf8ms+1PBIzzC15ljj4WqJcD69jA7qJW8jZEDwcD0
         f6htSe9jXQTFXm++saaJU0Y9hZKUEFHFbRmNPvFc8GFfSNuybJXdoyI8DFGhlH89516Z
         HHeB6E+PDenX6XXgMu21hK4POtV4i9UBAZWRxgMjkArr66KZqAZB0h9KhCSA6KsuiE8S
         NnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgVoanw/+v39j+sy3oPGO1zc8GbPNUKjVogyHFC0Gro=;
        b=D8OpRq8HZhQH/xBZTJ8dGCZ2Bz3E/+VWL/WYf7U9NZUDiCflsNZ1UHkNfDTu5Jx+MB
         se5nhWifTmlw/3VxxNFlGabBQYH6oyc+sIVdtLmf16ylc1fGMo7ZLyZFoNUEZCZEa9nH
         WoQUVhFHjA60nMDKvPiww6VdW56YxP3LCEnq254n8BLIoDnbiyia+dNCqELuTPKLUpXc
         Qwocb8ujM6/i312T7BEBdJf2JCIWGrFqzppCnAIGIbqhxH7G/xrhjgdvBo2i5nYriYQ/
         vE8kTpz7zs9s1lCAJ1K830DdpUgZYXfUFc9GZkWgaad8VpsGLPT9tyMiMF/JPQI8TjrS
         Zjrg==
X-Gm-Message-State: AO0yUKUx1UY5M/9xd0zFp9JEXkWqQkoNgUF2uTMvPVNTfz+YwUFaEnOb
        HBjBiomh2KzHwihUl8EonHRVVGIwUEA=
X-Google-Smtp-Source: AK7set8nrs0Tgm20/TOJiUZQVQNU+dl1zJkEBc0EOEFLhZ33QY7lA2VYvhwHa9y96K5EEZmwSWj3kA==
X-Received: by 2002:a05:622a:d6:b0:3bf:a5fb:6d6e with SMTP id p22-20020a05622a00d600b003bfa5fb6d6emr22665637qtw.29.1678172308645;
        Mon, 06 Mar 2023 22:58:28 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id l5-20020ac87245000000b003b9a426d626sm9013958qtp.22.2023.03.06.22.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:58:28 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        derrickstolee@github.com
Subject: [PATCH v2 1/2] t1092: add tests for `git diff-files`
Date:   Tue,  7 Mar 2023 01:58:12 -0500
Message-Id: <20230307065813.77059-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230307065813.77059-1-cheskaqiqi@gmail.com>
References: <20230304025740.107830-1-cheskaqiqi@gmail.com>
 <20230307065813.77059-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before integrating the 'git diff-files' builtin
with the sparse index feature, add tests to
t1092-sparse-checkout-compatibility.sh to ensure it currently works
with sparse-checkout and will still work with sparse index
after that integration.

When adding tests against a sparse-checkout
definition, we test two modes: all changes are
within the sparse-checkout cone and some changes are outside
the sparse-checkout cone.

In order to have staged changes outside of
the sparse-checkout cone, create a 'newdirectory/testfile' and
add it to the index, while leaving it outside of
the sparse-checkout definition.Test 'newdirectory/testfile'
being present on-disk without modifications, then change content inside
'newdirectory/testfile' in order to test 'newdirectory/testfile'
being present on-disk with modifications.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..9382428352 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,42 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
+test_expect_success 'diff-files with pathspec inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git diff-files  &&
+	test_all_match git diff-files deep/a &&
+	test_all_match git diff-files --find-object=HEAD:a
+'
+
+test_expect_success 'diff-files with pathspec outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	#add file to the index but outside of cone
+	run_on_sparse mkdir newdirectory &&
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git add --sparse newdirectory/testfile &&
+
+	#file present on-disk without modifications
+	test_sparse_match git diff-files &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile &&
+
+	#file present on-disk with modifications
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git diff-files &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile
+'
+
 test_done
-- 
2.39.0

