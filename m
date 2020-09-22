Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF2C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82C220BED
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="xUosciuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgIVWva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIVWv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:29 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13BFC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:29 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cv8so10397092qvb.12
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lbaPV17AcHOGfhR/neKqPzAHtfoFiFxXZYHRMTvLD8=;
        b=xUosciuPlujDWEFigqR53E/jwc6Uaqz1J4ALSpi/7dbI2osvR7GVbThtZepElsOLIX
         /CV1pbnSQiG6THWCdF5IL7Q1zNrXU0SjsJlnHy9qQPRAtEg32ECDdqFepEZ3WdlzMHMU
         Wbv9x4OFweH4UNkTTEK9hSXGCMtR1nRDjuco9UgO/IKzYlNqp1GoCmzJxkGtQ+LE8q4s
         eiE4uS4zw5jeFsidCas62vDyZoZZi7d/P9EAVOpaHC65COcmOxEF7UHzlTgRCQErv+Uc
         JN8V9KaA6l9ZabJreLcKKKh6z4aXyIyqLWUAPnAjHl9VQWez4KtzN8RelLkLXdwp0egq
         /Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lbaPV17AcHOGfhR/neKqPzAHtfoFiFxXZYHRMTvLD8=;
        b=WkCFOiuhDTkjyuvjyTpGTbJN/vQPhWUowrHzCl6gJ+6domp3EgHiK0wJNYBrPgB5Gp
         iFwBgrROQsoZkaAbHFlGYcWh8FIR51LAjzSx8Ts4e/wBwb9gGV1fMBIK3naFc0XouQi5
         kBzvXMQh7TZM25HrlsXGOZR+TcQHn4oYCLwwihsyv8o2lCSTr0l7kQTehoM3YAQmRUR+
         qT5E4jvNsKWhGKRK4sij+4FESzYmZ6uN7PhBj67+2rkv8zI2KKdS0BeICOMbH4KzfYlD
         pIBxZC2PofW8IAniDt6knk431JJjJJPhOTzXW7s4QafF/vtuLWAMpZ1HwoLuaiJVzDLx
         dPhA==
X-Gm-Message-State: AOAM530dhV0eR/pbhgMybTHRcd+IN4t5jvBUGx/fSrimBm+K2hYpgXR1
        vCyOSpxXq/2Hxb5/r7QptAhIjMCsC1hEcw==
X-Google-Smtp-Source: ABdhPJzTR+g4P4FhkItqHoyFsy6IMbz+ZORkzPXYJj2Uy2f/xDxhIdPoUw/cTjY3kgpA4qFW/oeqhw==
X-Received: by 2002:ad4:518c:: with SMTP id b12mr8595588qvp.38.1600815088218;
        Tue, 22 Sep 2020 15:51:28 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:27 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 18/19] parallel-checkout: add tests related to .gitattributes
Date:   Tue, 22 Sep 2020 19:49:32 -0300
Message-Id: <ece38f04832b291d6ef9f6d6998fe2ebb9e9d6e8.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to confirm that `struct conv_attrs` data is correctly passed
from the main process to the workers, and that they properly smudge
files before writing to the working tree. Also check that
non-parallel-eligible entries, such as regular files that require
external filters, are correctly smudge and written when
parallel-checkout is enabled.

Note: to avoid repeating code, some helper functions are extracted from
t0028 into a common lib file.

Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-encoding.sh                       |  25 ++++
 t/t0028-working-tree-encoding.sh        |  25 +---
 t/t2082-parallel-checkout-attributes.sh | 174 ++++++++++++++++++++++++
 3 files changed, 200 insertions(+), 24 deletions(-)
 create mode 100644 t/lib-encoding.sh
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

diff --git a/t/lib-encoding.sh b/t/lib-encoding.sh
new file mode 100644
index 0000000000..c52ffbbed5
--- /dev/null
+++ b/t/lib-encoding.sh
@@ -0,0 +1,25 @@
+# Encoding helpers used by t0028 and t2082
+
+test_lazy_prereq NO_UTF16_BOM '
+	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
+'
+
+test_lazy_prereq NO_UTF32_BOM '
+	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
+'
+
+write_utf16 () {
+	if test_have_prereq NO_UTF16_BOM
+	then
+		printf '\376\377'
+	fi &&
+	iconv -f UTF-8 -t UTF-16
+}
+
+write_utf32 () {
+	if test_have_prereq NO_UTF32_BOM
+	then
+		printf '\0\0\376\377'
+	fi &&
+	iconv -f UTF-8 -t UTF-32
+}
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index bfc4fb9af5..4fffc3a639 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -3,33 +3,10 @@
 test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-encoding.sh"
 
 GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
 
-test_lazy_prereq NO_UTF16_BOM '
-	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
-'
-
-test_lazy_prereq NO_UTF32_BOM '
-	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
-'
-
-write_utf16 () {
-	if test_have_prereq NO_UTF16_BOM
-	then
-		printf '\376\377'
-	fi &&
-	iconv -f UTF-8 -t UTF-16
-}
-
-write_utf32 () {
-	if test_have_prereq NO_UTF32_BOM
-	then
-		printf '\0\0\376\377'
-	fi &&
-	iconv -f UTF-8 -t UTF-32
-}
-
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
new file mode 100755
index 0000000000..6800574588
--- /dev/null
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+
+test_description='parallel-checkout: attributes
+
+Verify that parallel-checkout correctly creates files that require
+conversions, as specified in .gitattributes. The main point here is
+to check that the conv_attr data is correctly sent to the workers
+and that it contains sufficient information to smudge files
+properly (without access to the index or attribute stack).
+'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
+. "$TEST_DIRECTORY/lib-encoding.sh"
+
+test_expect_success 'parallel-checkout with ident' '
+	git init ident &&
+	(
+		cd ident &&
+		echo "A ident" >.gitattributes &&
+		echo "\$Id\$" >A &&
+		echo "\$Id\$" >B &&
+		git add -A &&
+		git commit -m id &&
+
+		rm A B &&
+		git_pc 2 0 2 reset --hard &&
+		hexsz=$(test_oid hexsz) &&
+		grep -E "\\\$Id: [0-9a-f]{$hexsz} \\\$" A &&
+		grep "\\\$Id\\\$" B
+	)
+'
+
+test_expect_success 'parallel-checkout with re-encoding' '
+	git init encoding &&
+	(
+		cd encoding &&
+		echo text >utf8-text &&
+		cat utf8-text | write_utf16 >utf16-text &&
+
+		echo "A working-tree-encoding=UTF-16" >.gitattributes &&
+		cp utf16-text A &&
+		cp utf16-text B &&
+		git add A B .gitattributes &&
+		git commit -m encoding &&
+
+		# Check that A (and only A) is stored in UTF-8
+		git cat-file -p :A >A.internal &&
+		test_cmp_bin utf8-text A.internal &&
+		git cat-file -p :B >B.internal &&
+		test_cmp_bin utf16-text B.internal &&
+
+		# Check that A is re-encoded during checkout
+		rm A B &&
+		git_pc 2 0 2 checkout A B &&
+		test_cmp_bin utf16-text A
+	)
+'
+
+test_expect_success 'parallel-checkout with eol conversions' '
+	git init eol &&
+	(
+		cd eol &&
+		git config core.autocrlf false &&
+		printf "multi\r\nline\r\ntext" >crlf-text &&
+		printf "multi\nline\ntext" >lf-text &&
+
+		echo "A text eol=crlf" >.gitattributes &&
+		echo "B -text" >>.gitattributes &&
+		cp crlf-text A &&
+		cp crlf-text B &&
+		git add A B .gitattributes &&
+		git commit -m eol &&
+
+		# Check that A (and only A) is stored with LF format
+		git cat-file -p :A >A.internal &&
+		test_cmp_bin lf-text A.internal &&
+		git cat-file -p :B >B.internal &&
+		test_cmp_bin crlf-text B.internal &&
+
+		# Check that A is converted to CRLF during checkout
+		rm A B &&
+		git_pc 2 0 2 checkout A B &&
+		test_cmp_bin crlf-text A
+	)
+'
+
+test_cmp_str()
+{
+	echo "$1" >tmp &&
+	test_cmp tmp "$2"
+}
+
+# Entries that require an external filter are not eligible for parallel
+# checkout. Check that both the parallel-eligible and non-eligible entries are
+# properly writen in a single checkout process.
+#
+test_expect_success 'parallel-checkout and external filter' '
+	git init filter &&
+	(
+		cd filter &&
+		git config filter.x2y.clean "tr x y" &&
+		git config filter.x2y.smudge "tr y x" &&
+		git config filter.x2y.required true &&
+
+		echo "A filter=x2y" >.gitattributes &&
+		echo x >A &&
+		echo x >B &&
+		echo x >C &&
+		git add -A &&
+		git commit -m filter &&
+
+		# Check that A (and only A) was cleaned
+		git cat-file -p :A >A.internal &&
+		test_cmp_str y A.internal &&
+		git cat-file -p :B >B.internal &&
+		test_cmp_str x B.internal &&
+		git cat-file -p :C >C.internal &&
+		test_cmp_str x C.internal &&
+
+		rm A B C *.internal &&
+		git_pc 2 0 2 checkout A B C &&
+		test_cmp_str x A &&
+		test_cmp_str x B &&
+		test_cmp_str x C
+	)
+'
+
+# The delayed queue is independent from the parallel queue, and they should be
+# able to work together in the same checkout process.
+#
+test_expect_success PERL 'parallel-checkout and delayed checkout' '
+	write_script rot13-filter.pl "$PERL_PATH" \
+		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
+	test_config_global filter.delay.process \
+		"\"$(pwd)/rot13-filter.pl\" \"$(pwd)/delayed.log\" clean smudge delay" &&
+	test_config_global filter.delay.required true &&
+
+	echo "a b c" >delay-content &&
+	echo "n o p" >delay-rot13-content &&
+
+	git init delayed &&
+	(
+		cd delayed &&
+		echo "*.a filter=delay" >.gitattributes &&
+		cp ../delay-content test-delay10.a &&
+		cp ../delay-content test-delay11.a &&
+		echo parallel >parallel1.b &&
+		echo parallel >parallel2.b &&
+		git add -A &&
+		git commit -m delayed &&
+
+		# Check that the stored data was cleaned
+		git cat-file -p :test-delay10.a > delay10.internal &&
+		test_cmp delay10.internal ../delay-rot13-content &&
+		git cat-file -p :test-delay11.a > delay11.internal &&
+		test_cmp delay11.internal ../delay-rot13-content &&
+		rm *.internal &&
+
+		rm *.a *.b
+	) &&
+
+	git_pc 2 0 2 -C delayed checkout -f &&
+	verify_checkout delayed &&
+
+	# Check that the *.a files got to the delay queue and were filtered
+	grep "smudge test-delay10.a .* \[DELAYED\]" delayed.log &&
+	grep "smudge test-delay11.a .* \[DELAYED\]" delayed.log &&
+	test_cmp delayed/test-delay10.a delay-content &&
+	test_cmp delayed/test-delay11.a delay-content
+'
+
+test_done
-- 
2.28.0

