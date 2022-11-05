Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86716C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKERIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKERIA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50820DFCC
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:07:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so6979533pjd.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFtyYRE/QfCJSzHWQ5G/2Hcs0YCzicj8Mpg0peBNurk=;
        b=M0fVL96fR586kojBwNsFRxSh/zFXsqvWG2Psxe8saWm0D9ZYK8sydiSStlWARez7Bh
         NEXYqeVTUxXw0eLavViNp0UtdoU6jiiGdN3vFhJx61eUQHWK1qtSS/0BxL15KjWLrqWE
         epn7mkfKYhNvrmSQpcw3pSC7Oei5MaIHe3dPd35GakpV1hvfLgSZs94RfgGcpGdb1EFE
         4M4U2WAm2K/mLZrU87IJZ1LUkwCHvnnPL0ftNYdhbHId1+ytl7KFO7XrwK1oTt6lh2Sa
         BzNs5Zf4Q2B2P4bpCxGGjJ/eVKk0quTIVwwC87oYY0S9hwaE1tsSeQsGKVIYlOVdIFUm
         trCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFtyYRE/QfCJSzHWQ5G/2Hcs0YCzicj8Mpg0peBNurk=;
        b=ClA1u448DTXoltZZidI8hmWpp++4u1ldVPVgkF7yvl7FQQ6ZQDFhH7T2PZoVgi/8hK
         xtTSBp48rOZxjmebjQXJsFBXDdjGRET6MdD0DiDZFg1Wdmhiyl7xd/x2dZTvVSFADxnL
         cIpdSnxZFIuMZp8kLAHx7X224YEUAGgs+0S7z+1qOcfQnR8jefHr/aBwUL0HB6CgKub/
         LsNYf/tzXabu0skjTf8FWlOPHDvkRKWM4TdqS8MsFKgCyIeGZ23t0U4dX4bT/cMauFgp
         C5h9KC4b1j+B3NI/4ef3yXvWwsMI6p3jJgBsqEWcJ5hI6Jl/l/ool7Jt/eX0tprLITLK
         wWfw==
X-Gm-Message-State: ACrzQf28maxJUD+XERZ+pKFRe+SFzcExJiX1RW7XG7/SyiJy8DrpUVob
        PKSUoIfLVSm5jCf/WH0hnAGJNlDX9XQ=
X-Google-Smtp-Source: AMsMyM40psWJ3q9AIBDxuJUSjdFlFFVdYGbnhbRoU5x08Ec32If3zK+h1vUY6Omo8wlgyE+pF0jd2w==
X-Received: by 2002:a17:90a:8a8c:b0:213:c06c:7003 with SMTP id x12-20020a17090a8a8c00b00213c06c7003mr39108862pjn.147.1667668078466;
        Sat, 05 Nov 2022 10:07:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:07:58 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 01/13] bisect tests: test for v2.30.0 "bisect run" regressions
Date:   Sun,  6 Nov 2022 00:07:32 +0700
Message-Id: <5571bc36b84210e16ab8731fea8bf0ed8d62cca3.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
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

1. 0a4cb1f1f2f (Merge branch 'mr/bisect-in-c-4', 2021-09-23)
2. d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
   function in C, 2021-09-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 79 +++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 6dbbe62eb2..6901bbd202 100755
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
+test_expect_failure 'git bisect run: args, stdout and stderr with no arguments' '
+	test_bisect_run_args <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
+	EOF_ARGS
+	running ./run.sh
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' '
+	test_bisect_run_args -- <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
+	<-->
+	EOF_ARGS
+	running ./run.sh --
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' '
+	test_bisect_run_args --log foo --no-log bar <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
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
+'
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" argument' '
+	test_bisect_run_args --bisect-start <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
+	<--bisect-start>
+	EOF_ARGS
+	running ./run.sh --bisect-start
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+'
+
 # We want to automatically find the commit that
 # added "Another" into hello.
 test_expect_success '"git bisect run" simple case' '
-- 
2.38.1.157.gedabe22e0a

