Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C82C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLOPHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLOPHK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:07:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9612FBE0
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so868440wml.0
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FotZg4yy9XlqAjPVJNxC5xwRpcqkYAtK4Jr/uCnQRcg=;
        b=F+3YFJ30hlTTIymb5qoXAhjNjB7FPUSEUAIOK6+/IWK4rik+midP55n0YZ8feMy8mM
         IHZxsD0b4U2RqtQvSAc342IGLOOE5amaORp9btKGPyOYNZAfkyigajfhOvU4cJw8On/t
         uDkm9D31qypeAAnbDux8ote/PMx8vCefD/9cxOul0eRVqqXA5CMf7v1P4Y6LfpkNRKRM
         WcRWLsk8xDCZBi+NNX3tfRbGO56nVdUoTmo3snOq37VGc0r2JotjGB6djQriOd7g0IIR
         oWF+v1NWLY7Zcq9NOju6En+WuQ8iBoJSj55XkGbIZGUHTxfC27VDVjVHOV62HdjR4xwp
         rhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FotZg4yy9XlqAjPVJNxC5xwRpcqkYAtK4Jr/uCnQRcg=;
        b=oPxHxrfGVAFDRUYisHfvV1R5+DqEjBJ4lODisaG20QCMqgtN1u9fawJxnKf4tNQRX2
         k/D6k3gnQkLRZmDf1SLyMKUxmFTj7HMsLXqlD04g9DBrhkWfTzzIExFs11+MAmTWJZcn
         ppO9F9Dc1bJ1zW5x7RGeyuqOtBzEsYko76e36ct38xmJQIy9/LtMuhEZgIAEHGVDY7ah
         4kxGbrmq2dFt1kRkF57tYyB8jdBtnJ/SX1B2HrlrYSQRuGLmi0c7mdkP+vWvdHPVHFof
         G8ex05ttAoEjSlV6cOR352/D7YDVlgh4qrZp8CT93PAsu8zr/+KmB9nGC3DhsON6FRFu
         wu8A==
X-Gm-Message-State: ANoB5pkOYS+4WMDgWfX8T/aL19eeyKQVV66M4vCof/Dx5AoTxff0Pi7s
        dKYmyVF6Hgn4tPli+p20ioFBwnhnjtE=
X-Google-Smtp-Source: AA0mqf51DOiyneBP2uyBQF+Bczp9vufcr2aa6ziaPGmC/gHqBVSsEWQJIG9RfitRn4HqKi72rAOr8w==
X-Received: by 2002:a05:600c:1e1d:b0:3d1:fd97:5157 with SMTP id ay29-20020a05600c1e1d00b003d1fd975157mr21709598wmb.14.1671116825504;
        Thu, 15 Dec 2022 07:07:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003c71358a42dsm9533936wmq.18.2022.12.15.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 07:07:04 -0800 (PST)
Message-Id: <86370af1351a275d5583c76c07b536754e4b6afc.1671116820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
References: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
        <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Dec 2022 15:06:59 +0000
Subject: [PATCH v3 3/4] test-lib-functions: add helper for trailing hash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It can be helpful to check that a file format with a trailing hash has a
specific hash in the final bytes of a written file. This is made more
apparent by recent changes that allow skipping the hash algorithm and
writing a null hash at the end of the file instead.

Add a new test_trailing_hash helper and use it in t1600 to verify that
index.skipHash=true really does skip the hash computation, since
'git fsck' does not actually verify the hash.

Keep the 'git fsck' call to ensure that any potential future change to
check the index hash does not cause an error in this case.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1600-index.sh        | 3 +++
 t/test-lib-functions.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 45feb0fc5d8..55914bc3506 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -68,6 +68,9 @@ test_expect_success 'out of bounds index.version issues warning' '
 test_expect_success 'index.skipHash config option' '
 	rm -f .git/index &&
 	git -c index.skipHash=true add a &&
+	test_trailing_hash .git/index >hash &&
+	echo $(test_oid zero) >expect &&
+	test_cmp expect hash &&
 	git fsck
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b32..60308843f8f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1875,3 +1875,11 @@ test_cmp_config_output () {
 	sort config-actual >sorted-actual &&
 	test_cmp sorted-expect sorted-actual
 }
+
+# Given a filename, extract its trailing hash as a hex string
+test_trailing_hash () {
+	local file="$1" &&
+	tail -c $(test_oid rawsz) "$file" |
+		test-tool hexdump |
+		sed "s/ //g"
+}
-- 
gitgitgadget

