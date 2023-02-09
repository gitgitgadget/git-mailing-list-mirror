Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98AAC636D7
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 15:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjBIPpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjBIPpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 10:45:33 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84B2194E
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 07:45:00 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z2so996572ilq.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmpb4/gPoCwA7dUNv68wjFxO2bFg6bKJXC5BEAhEk3A=;
        b=Y32+r3ZO/XzthB9Fo1OPZM2bAwWoBbonh50h1cuLyPE/08X7TSvUa1ZmApOud22XCy
         mEwCfjredlS7Ox8lp1edwg3kk7+GIAv793t4s9fqWzTs+MZ+01zyaXPoukG04dzk8PrP
         oSkSAIgpBYgKDj+LSZK6jQpVwMhdKt2yn1ArI4Py2uOwqRDxJ46/eWiEu+wMLnzQ30kK
         t5tau4qjk/MVZzrsi7+nW+BgwkiBvqZIUKJHsUVso4NYxvllgAKEY9mT2uGvbMdP0KPo
         OFrSDWviZXsY2NlsxQ4WI7FOb1I2EwavaksZMhPf/sMdxeo5ju3lpIfdxaiNRl2GRg/e
         N1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmpb4/gPoCwA7dUNv68wjFxO2bFg6bKJXC5BEAhEk3A=;
        b=4HDeL7nEhDD/++TDG0m1t7SgVQRgKyvn+g//FKvaQrzlav7kcT+P7+kAU6gzxt48XK
         ba/Fp8HTHjgXdXSjujJV2b5sFl8QGOE+XejKEutidpyRmQFVbk94PqfuPdwBhxaJwYUO
         zwAZa/4CdlqMI2eCRPxm5D1qNjR1DHd4d0J2g74vahygjCY5+BHYZRxxY2UWitByiify
         yEcaRMyDtBuP7Z0sSXLEkrxVIKaBkHUlzysT/SF6jUGfePbTBZ0kZVqULvSHi9w84mDG
         0Xz+Gf4wKqlPUME0jjFSZg6ypCFf6mwISw26dAoL8cv/yEaWxIYvrEtQvz39zAJGf+2s
         MKWQ==
X-Gm-Message-State: AO0yUKX6mRgemKcYUl9YUaHxejD5jSyCndbcOkgb8Cg0CUrmprUafope
        7KxXRYmAAax92wU/WUBw6j9q18lDmoaJbw==
X-Google-Smtp-Source: AK7set9riyKV4Py62KQ0Zzz+Lr8dc0s26oJ3JK0wolYbz1MsTKriASWe1YW9jGri8yN+bt25+WBsfg==
X-Received: by 2002:a05:6e02:1bab:b0:310:b34e:23d7 with SMTP id n11-20020a056e021bab00b00310b34e23d7mr12224712ili.21.1675957490453;
        Thu, 09 Feb 2023 07:44:50 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a1-20020a92d581000000b0030c0dce44b1sm563570iln.15.2023.02.09.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:44:50 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v5 3/3] t4113: put executable lines to test_expect_success
Date:   Thu,  9 Feb 2023 10:44:17 -0500
Message-Id: <20230209154417.10763-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209154417.10763-1-cheskaqiqi@gmail.com>
References: <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230209154417.10763-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As t/README says, put all code inside test_expect_success and
other assertions. This script is written in old style,where there are
some executable lines outside test_expect_success. Put the executable
lines inside the test_expect_success.

As t/README says,use "<<-" instead of "<<"
to strip leading TABs used for indentation. Change the "<<" to "<<-"

for example:
-cat >test-patch <<\EOF
-diff a/file b/file

 test_expect_success 'apply at the beginning' '
+       cat >test-patch <<-\EOF
+       diff a/file b/file
+       --- a/file

As t/README says,chain test assertions.Chain this test assertions
with &&.

For example:

-cat >test-patch <<\EOF
-diff --git a/file b/file

+ cat >test-patch <<-\EOF &&
+ diff --git a/file b/file

This script is written in old style,where there are something like

        echo x >file &&
        echo y >>file &&
        echo z >>file

  Change it to this stlye :
        {
        echo x &&
        echo y &&
        echo z
        } >file

In order to escape for executable lines inside the test_expect_success.
Change ' in executable lines to '\'' in order to escape.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 61 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index a470c9ce7b..c70429bd07 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -8,46 +8,45 @@ test_description='git apply trying to add an ending line.
 '
 . ./test-lib.sh
 
-# setup
-
-cat >test-patch <<\EOF
-diff --git a/file b/file
---- a/file
-+++ b/file
-@@ -1,2 +1,3 @@
- a
- b
-+c
-EOF
-
-echo 'a' >file
-echo 'b' >>file
-echo 'c' >>file
-
 test_expect_success setup '
+	cat >test-patch <<-\EOF &&
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	 a
+	 b
+	+c
+	EOF
+
+	{
+	echo '\''a'\'' &&
+	echo '\''b'\'' &&
+	echo '\''c'\''
+	} >file &&
 	git update-index --add file
 '
-# test
 
 test_expect_success 'apply at the end' '
 	test_must_fail git apply --index test-patch
 '
-cat >test-patch <<\EOF
-diff a/file b/file
---- a/file
-+++ b/file
-@@ -1,2 +1,3 @@
-+a
- b
- c
-EOF
-
-echo >file 'a
-b
-c'
-git update-index file
 
 test_expect_success 'apply at the beginning' '
+	cat >test-patch <<-\EOF &&
+	diff a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	+a
+	 b
+	 c
+	EOF
+
+	echo >file '\''a
+	b
+	c'\'' &&
+	git update-index file &&
 	test_must_fail git apply --index test-patch
 '
+
 test_done
-- 
2.39.0

