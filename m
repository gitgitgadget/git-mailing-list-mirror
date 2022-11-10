Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0277C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiKJQhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiKJQhC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C632B88
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1977029pjc.5
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGRNZJ7R8R137LYyl64MvyDYRT0NOXfXf+zLd+XPZu8=;
        b=Gk0+Pu3QCzq412wB4uWUp59qjzbBCOzxYTUAkYHmC5Tsh/FgbWoFdJGfxyQ7bn0FaO
         +FjEBjNlyoM1l+KRCq6mydagbgshzAMGRzuT7Pe8DkPtU49+9df77IJ4Y5sEqbVj+6B9
         h8BSXlKFVdTNDpyZOKz59birgONQkmQQeb9gZPYFHowxF8s6vqG2u7I0cO3G2BHYfXhT
         QJfAB3Q3lhSIGBQgUUnK5LF3CusT8AwDbVQGYcJ1AETH7WyAVU4zNjWFtxw3avzpK3Ll
         Mr3VuBiNcKGa7UbSoon8Cm0GvbWsFFz41L8ftwP/OJBClSVXDz6E35kuN86hUDqyzDjz
         lfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGRNZJ7R8R137LYyl64MvyDYRT0NOXfXf+zLd+XPZu8=;
        b=YWhKD5pJow8le5vc57t3LMH5f229rXz6PZhfU5y8TQm7/GnRyNmMbrWzN1o335E2NZ
         5aJ6jBAESU0j0GFQCv+jzKY90+qlggGc2sSHUdFQPDO4lqFswj9+x7gIeyX85bTeilG0
         UbYjaky/xX9dvgM/DS8N9UK4Sg6x5MIdO/3+ZX7+KV6lQIE8hnIAVcM+T4E9PJKmNgN7
         JE+yl5dmO1gMOs3j/Af3UuZ/Zv8T2QUM8ywixukVnF6Yy5snisqZLSmcrQsy/URg7F3U
         T6XvIO2f5Np8ljIVkac5lEJYoMA5RYXEB0PLo68Qp6AMZ8PtqZa3o8UwR+iDdQ9icbtA
         lRlg==
X-Gm-Message-State: ACrzQf25t6XcYoKGfeCP7pRmQiN/hCKSMeqp1DjHtZmbCmdroENYtowD
        XJ7yxs5YprQ5HGuXQWRZjbmFesPhbzQ=
X-Google-Smtp-Source: AMsMyM4xOu6I6dJrlPxtoJAOthZPamoLTO8kLR7keWxIyT4LJiajAPpGBEPTBLCsfWe5wIUWFWy89w==
X-Received: by 2002:a17:90a:5898:b0:214:1804:d96b with SMTP id j24-20020a17090a589800b002141804d96bmr1361794pji.90.1668098221442;
        Thu, 10 Nov 2022 08:37:01 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:01 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 01/11] bisect tests: test for v2.30.0 "bisect run" regressions
Date:   Thu, 10 Nov 2022 23:36:36 +0700
Message-Id: <b6fd4ecd66137710c76617aa05a16ad9cdd8ceb1.1668097965.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add three failing tests which succeed on v2.29.0, but due to the topic
merged at [1] (specifically [2]) have been failing since then. We'll
address those regressions in subsequent commits.

There was also a "regression" where:

	git bisect run ./missing-script.sh

Would count a non-existing script as "good", as the shell would exit
with 127. That edge case is a bit too insane to preserve, so let's not
add it to these regression tests.

There was another regression that 'git bisect' consumed some options
that was meant to passed down to program run with 'git bisect run'.
Since that regression is breaking user's expectation, it has been fixed
earlier without this patch queued.

1. 0a4cb1f1f2f (Merge branch 'mr/bisect-in-c-4', 2021-09-23)
2. d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
   function in C, 2021-09-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 79 +++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 6dbbe62eb2..6c2c57cadf 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -252,6 +252,85 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 	grep $HASH4 my_bisect_log.txt
 '
 
+test_bisect_run_args () {
+	test_when_finished "rm -f run.sh actual" &&
+	>actual &&
+	cat >expect.args &&
+	cat <&6 >expect.out &&
+	cat <&7 >expect.err &&
+	write_script run.sh <<-\EOF &&
+	while test $# != 0
+	do
+		echo "<$1>" &&
+		shift
+	done >actual.args
+	EOF
+
+	test_when_finished "git bisect reset" &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run ./run.sh $@ >actual.out.raw 2>actual.err &&
+	# Prune just the log output
+	sed -n \
+		-e '/^Author:/d' \
+		-e '/^Date:/d' \
+		-e '/^$/d' \
+		-e '/^commit /d' \
+		-e '/^ /d' \
+		-e 'p' \
+		<actual.out.raw >actual.out &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err &&
+	test_cmp expect.args actual.args
+}
+
+test_expect_failure 'git bisect run: args, stdout and stderr with no arguments' "
+	test_bisect_run_args <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
+	EOF_ARGS
+	running ./run.sh
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+"
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' "
+	test_bisect_run_args -- <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
+	<-->
+	EOF_ARGS
+	running ./run.sh --
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+"
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' "
+	test_bisect_run_args --log foo --no-log bar <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
+	<--log>
+	<foo>
+	<--no-log>
+	<bar>
+	EOF_ARGS
+	running ./run.sh --log foo --no-log bar
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+"
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" argument' "
+	test_bisect_run_args --bisect-start <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
+	<--bisect-start>
+	EOF_ARGS
+	running ./run.sh --bisect-start
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+"
+
 # We want to automatically find the commit that
 # added "Another" into hello.
 test_expect_success '"git bisect run" simple case' '
-- 
2.38.1.157.gedabe22e0a

