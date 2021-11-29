Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F9C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 21:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhK2Vz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhK2Vxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 16:53:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9771C043CE5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d9so18082700wrw.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tvdxG4YI1fiCV7Kztp+p5tDITH73b9li/1WLF/raObo=;
        b=pXRQdkQ/cFZmJeUBnNM6tUj9ApuJhBNB7Pu0P15Jv1zSkUpznZrHXrDOwegsrZH6ue
         ZGELUG75SCQ3X3YXrEbY506hBbokxDfKg1QV3sEY4xw8b/lZIFO7jv2estSF36cuJ5W2
         dlpcGfOqIQNF3/Xb8vPCb06JQ5jDAHaHGQRxkkzT4v4KdbKrrZAwsO+hA12tfHeIF77m
         gujYQT3FtNSZBabXSWjzwMon1rRc32t5ynmFQfyoTOlP2YRwvPrxAP5lAVdFsLhDbWJ5
         9UgxR7WOMedu565qr/9AGsF/TbU1ha11qy8XXmSyljvoQYi+Zj4gaxAtSQLroxs6jV4g
         LTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tvdxG4YI1fiCV7Kztp+p5tDITH73b9li/1WLF/raObo=;
        b=oVFPoo668KsT8myRizlihJO8Gr+FWGr61peXdK46vQRgCTWs37ZrbMdxvgdwOvaDVp
         fOiqvvTY2r4J+NzteprZkgxN5C+XlKFdU6tGndoF93K7f6ewe4vPbSNL6l0qzIAN77Vq
         p9mtma/zaX1xNLk4FCbVQPzu1Dco3cu97VHRjGcXmkUTP50tiS/GniW+vcIr2iH+tFJG
         f5Quugcwk578YFc5Gzx/bZdiFhRgW+zZ94p6Y3ApbQgiitLttXxY6RGAbky+UGSbKRqI
         plYuRWjQLy8BHUceAqckrhoPcwsJwnMdFxQwpqSZF2Rlw0sT6CZl2wlRVOM7HXbPjY8c
         y5jg==
X-Gm-Message-State: AOAM530Hd4Uq4wTj4FtfIiuBhiO2y5zViNLwNfrmn3CkNiL2s+nYJS/G
        hC3rMkMGsf0/ATD53L7iYIAY/2GmXaU=
X-Google-Smtp-Source: ABdhPJwrPGmUXtV/RXAa4lWg/+EbcDuyWNStS0Sf4PONwuLoKg16Pz/ILWZxfxIaLAqPxwooj5rU2A==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr35714138wrj.589.1638211791119;
        Mon, 29 Nov 2021 10:49:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm130239wmq.34.2021.11.29.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:49:50 -0800 (PST)
Message-Id: <3c100702fda81bf4ba572085ebce4e4fee94a4f3.1638211786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 18:49:46 +0000
Subject: [PATCH v2 6/6] t1430: create valid symrefs using test-helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This still leaves some other direct filesystem access. Currently, the files
backend does not allow invalidly named symrefs. Fixes for this are currently in
the 'seen' branch

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1430-bad-ref-name.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 5c600980b5f..05a4ee712ca 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -153,7 +153,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	git branch shadow one &&
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
+	test-tool ref-store main create-symref refs/tags/shadow refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
@@ -203,7 +203,7 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
 
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -215,7 +215,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
 
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -224,7 +224,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -233,7 +233,7 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref to brok
 '
 
 test_expect_success 'branch -d can delete dangling symref to broken name' '
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -245,7 +245,7 @@ test_expect_success 'update-ref -d can delete broken name through symref' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
 
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/badname" &&
 	git update-ref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...ref &&
-- 
gitgitgadget
