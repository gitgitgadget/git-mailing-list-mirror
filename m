Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04055C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 05:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCJFAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 00:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCJFAm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 00:00:42 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188B8E4D87
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 21:00:40 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id f14so1610139iow.5
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 21:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678424439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB3fsYMlnsLx8y7wTn3cWgwLPLVNtmj9u1hnm5h9Ypc=;
        b=lB29yCKUoyXYL5WnjuYcqkc/486YIC/0WHR9fRanKURsvsjHIqXOgE6dAFb6uV7HMk
         9q6xlXRFs1aT4iPS0Btz3kj0W30BVC8eUHDkDI9m9zQgJ1nLTQtLB5fcGty2Xg9/mlJ3
         WySJrtFvirvebp94USkhcQ/fhvqqjBsrJH6KKC136OCn+OeOykPiRVcKFgofB+HBYjRK
         xIkt2X6VQxub8lT2la0IHc2BMBWiPl+SljVcmHFRzLkYsn4lrdEDj50Vn7DTR2P7J+pG
         8rUQMmg7DnhuGVB1khyg+BsOjnE4a/SlwjfXPOE5JXkKaXGKSuGcF8iMAKRTABlu2t+b
         q/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678424439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB3fsYMlnsLx8y7wTn3cWgwLPLVNtmj9u1hnm5h9Ypc=;
        b=ERhHkVjZh6exXLHvmVjbs47O2YZHnCX84m3UBN+eFVm9FhoKq4ND14s7XgMFVwnoFb
         FiQOwL90DuwUIJMg801ThT/q30vu6CqqEqrAJYKSCL28USkEPXUH7aFGsdkxQZlaPjAu
         2wuBwc8T+qvdnyPSd76iNXejaOsWjiKEC1MrqTV+V37gLIUxeIM13Q99sG+easY1vQOI
         MTnCUrr/m5ds7knhvCgxWmviKcwQcBtWtEEFaTUFSafeW8GRbCx7Oyr4ql/Hv/DKoLBR
         OhYgKeu3Ba/IeGmuK85zWGYv47NhM49/5zoyS5gkmzNbHEGTecGeXPAJNZGwLaBCrAlU
         0XwQ==
X-Gm-Message-State: AO0yUKW757SJSAEpPDzh6VFRvhYq+/wU8yWhamBCO7UfUPQRhYvm/wJx
        dFH2setdsWC2DtDyzRzAqokrvDbkp20=
X-Google-Smtp-Source: AK7set8CVxMtEqgX1dke81b5C7WwtSJbyWCaPeQQ1a7Fs8SDSjO9o83V4GdjuO0OLKbVApBXVG3NyQ==
X-Received: by 2002:a6b:a07:0:b0:6e5:25a2:c63d with SMTP id z7-20020a6b0a07000000b006e525a2c63dmr14166459ioi.21.1678424438805;
        Thu, 09 Mar 2023 21:00:38 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id c4-20020a6bfd04000000b00734ac8a5ef7sm323930ioi.25.2023.03.09.21.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 21:00:38 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v5 1/2] t1092: add tests for `git diff-files`
Date:   Fri, 10 Mar 2023 00:00:20 -0500
Message-Id: <20230310050021.123769-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230310050021.123769-1-cheskaqiqi@gmail.com>
References: <20230309063952.42362-1-cheskaqiqi@gmail.com>
 <20230310050021.123769-1-cheskaqiqi@gmail.com>
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
 t/t1092-sparse-checkout-compatibility.sh | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..9b71d7f5f9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,52 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
+test_expect_success 'diff-files with pathspec inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git diff-files &&
+
+	test_all_match git diff-files deep/a 
+
+'
+
+test_expect_success 'diff-files with pathspec outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	# add file to the index but outside of cone
+	run_on_sparse mkdir newdirectory &&
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git add --sparse newdirectory/testfile &&
+
+	# file present on-disk without modifications
+	test_sparse_match git diff-files &&
+	test_must_be_empty sparse-checkout-out &&
+	test_must_be_empty sparse-checkout-err &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_must_be_empty sparse-checkout-out &&
+	test_must_be_empty sparse-checkout-err &&
+
+	# file present on-disk with modifications
+	FN=newdirectory/testfile &&
+	OID=$(git -C sparse-checkout hash-object $FN) &&
+	ZERO=$(test_oid zero) &&
+	echo ":100644 100644 $OID $ZERO M	$FN" >expect &&
+
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git diff-files &&
+	test_cmp expect sparse-checkout-out &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_cmp expect sparse-checkout-out
+'
+
 test_done
-- 
2.39.0

