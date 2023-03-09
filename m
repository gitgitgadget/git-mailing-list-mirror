Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A23AC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 01:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCIBdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 20:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIBdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 20:33:36 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8E50F9B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 17:33:31 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y140so118791iof.6
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 17:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678325611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlsbFSZQzka+e26isMcxrdIYLvOWz8hEjtKWDrB/baQ=;
        b=Xk/oVNmHoAWvlGBlRopdYwGx15wEzd9gVWzxMZHcQ3DeuHJNBcQS7JokrZhVcjlYMX
         E9g0WDWRsRGMa/oKEywiq6VyQmkIR0rqYDYzM9O4rfScTUgHyNAKGHzn01/Eiu+6qTBB
         Cy/i9gvU2wvJRGDW+Vf1ismSuN26jQDIhVGLZS9P9teJYRdLiIkcQ+pt8k9cIe32LpZS
         BxNbkxYLVgCuOAdxo4q/NNAcmV3TwuHF2xrXFqt8uvrv0+ls+D4G/kEN6qUgEqhmkTMb
         7F3IU8UjUULS05a5RvulfxoloSe9OLIRVGaGly/93ZIYLOVQH8BEWdICTql8lUCa+Efy
         jcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678325611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlsbFSZQzka+e26isMcxrdIYLvOWz8hEjtKWDrB/baQ=;
        b=CeNQuj+Vx5Qw8l/Lut4kL0StHabh56E1VOgeMQtJvZBf11Z+akCWMP4K83ibsxoEf8
         l2ku13J5tecMamptDJbtSerC9hWGd8NIy/7gdOznnBEBQhp/1MXGeHOCrk41Cl7m1CdY
         eJb/ZdpXH2yeTPKKU7qo2cemNgP4a0ZqXtzDWGrYMVEcgQl+VMrZ8pgp/xRL9AbNQDRe
         PxWCW3qs0x5HOOIT5yHRtK8EjO1H97VpW1JjwPaLp3vdNM1Dpshn7e+KSjAVe+9xS5Sd
         EE8VxTFeD9MZqdweeKgZDuOkhQO9cjK1X52lFkhQooID4X0Ubu++IFHtogD3a7+XQHSS
         2huw==
X-Gm-Message-State: AO0yUKUrOwun78p7LUzq5Ell1chl4G1sS6zp8sUmi6BRv9g/ttZKIB2N
        VJk93UNYjVBK3qmcRgq7EwRzzUn0qrg=
X-Google-Smtp-Source: AK7set8Y4hmZ3nl2a8JwxnFtRs+76qD1YKMt9QPALxgn5dA3fLZ3OGFGsSNime2yo/psyHPDaFBvGQ==
X-Received: by 2002:a5e:8811:0:b0:719:fd3a:395 with SMTP id l17-20020a5e8811000000b00719fd3a0395mr12581647ioj.12.1678325610952;
        Wed, 08 Mar 2023 17:33:30 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id j4-20020a056e02124400b003153213c586sm4997828ilq.30.2023.03.08.17.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 17:33:30 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v3 1/2] t1092: add tests for `git diff-files`
Date:   Wed,  8 Mar 2023 20:33:13 -0500
Message-Id: <20230309013314.119128-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230309013314.119128-1-cheskaqiqi@gmail.com>
References: <20230307065813.77059-1-cheskaqiqi@gmail.com>
 <20230309013314.119128-1-cheskaqiqi@gmail.com>
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
 t/t1092-sparse-checkout-compatibility.sh | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..bdf3cf25d4 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,44 @@ test_expect_success 'grep sparse directory within submodules' '
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
+	test_all_match git diff-files  &&
+	test_all_match git diff-files deep/a 
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
+	! test_file_not_empty sparse-checkout-out &&
+	! test_file_not_empty sparse-index-out &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	! test_file_not_empty sparse-checkout-out &&
+	! test_file_not_empty sparse-index-out &&
+
+	# file present on-disk with modifications
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git diff-files &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_file_not_empty sparse-checkout-out
+'
+
 test_done
-- 
2.39.0

