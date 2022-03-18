Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC4CC433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiCRAfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiCRAfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:35:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6EA248786
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so4091633wmf.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSbOsbWVrOFdKCsTEtyep1+U0vfkKtouaI19vMKrna8=;
        b=K2MM88hnitvD824iv9fYJ+dYjjT9lrcWYao8n54PK0eZ1K5W8p7X4shOZqgF/2rM/u
         c1PwQECzoMHXzvtoLqBJ1OGYO52Ix5C+HVZ+GFC7rTt7yXWJrQSxjLx/AZ7HpdA9b5kb
         KeOHfrHNJEjJbp4zCipb9VGHdp2SdNE6h1HETqkbF6Kxw5nGNrWV0Ydvo7ztt5v9ItFd
         vy6fp99OayEx5zdvzMBKuGyImzZnIvXp5QyLK0nRkmdoxW6yEkbUyoa9Q+IAQEQ2TDc1
         HxZ92hVKSOzAlDYbLNnVX15fLSmiwzAeDFnDVOOH5gSbc5UPEROh/OFmQP1PF3y+RQBc
         8MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSbOsbWVrOFdKCsTEtyep1+U0vfkKtouaI19vMKrna8=;
        b=az0ItdbypV8VOOyGGqWuqZqIghmgMnt2i5tejVTudiupdSZPaI7s5GxzYY9cnsjLsH
         HL2Mgtjr1MgGPE2lYogz27NvYgyYbkR5QFYNQQGCzGnQ078FR9r844HSUjfSt8sf5hbt
         0LSqnUuPEyKeS2svb574xmYeklkUuv0RQ+YobokCV3TlgnaFZpnAfWoHvw2qIcOBhsCS
         y+WAPF5hg+BpWAIHJTHDHgV8cYrgc6OzujFDP8yiaP5Ei2hJdnYWASzGl+szxunpZoB2
         WucHOMl7Baq6SFJYLyyAQkRKQh47JsfgqAjjj86kxsGxf73YgabQr+NIE0kIj6pWmW6b
         Bs0A==
X-Gm-Message-State: AOAM530iq6R5mjF/q+QpdCWab+8EyNcVoyNQMyAlEMmuPZaPEeIWqe8p
        Sfh6c49ysOZezgWPniCWf+xR5Fxy9z73DQ==
X-Google-Smtp-Source: ABdhPJzhxAdSSYWQBetdMG2zCoLopm3W7Sokjpu0lLS9dL+xrB9fKslPrHJksOcRFxIIG7wpAG9Pxw==
X-Received: by 2002:a05:600c:4e4a:b0:38c:801c:2984 with SMTP id e10-20020a05600c4e4a00b0038c801c2984mr3674492wmq.168.1647563654848;
        Thu, 17 Mar 2022 17:34:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b00203dde8d82bsm5096548wro.88.2022.03.17.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:34:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] test-lib-functions: make test_todo support a --reset
Date:   Fri, 18 Mar 2022 01:34:01 +0100
Message-Id: <patch-6.7-2ee27a7773e-20220318T002951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1436.g756b814e59f
In-Reply-To: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the preceding commit that introduced "test_todo" we
couldn't run something like "git rm" since we run both the --want and
--expect variants, and if --want has removed a file the --expect won't
succeed.

Let's add a --reset option to the command, this allows us to convert a
test added in 03415ca8db2 (t3600: document failure of rm across
symbolic links, 2013-04-04) to a more exact "test_expect_todo".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3600-rm.sh           | 23 ++++++++++++++++++-----
 t/test-lib-functions.sh | 26 ++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index e74a318ac33..42879e9060b 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -790,7 +790,7 @@ test_expect_success SYMLINKS 'rm across a symlinked leading path (no index)' '
 	test_path_is_file e/f
 '
 
-test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
+test_expect_todo SYMLINKS 'rm across a symlinked leading path (w/ index)' '
 	rm -rf d e &&
 	mkdir d &&
 	echo content >d/f &&
@@ -798,10 +798,23 @@ test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
 	git commit -m "d/f exists" &&
 	mv d e &&
 	ln -s e d &&
-	test_must_fail git rm d/f &&
-	git rev-parse --verify :d/f &&
-	test -h d &&
-	test_path_is_file e/f
+	test_todo \
+		--want "test_must_fail git" \
+		--reset "git reset --hard" \
+		--expect git \
+		-- \
+		rm d/f &&
+	test_todo \
+		--want git \
+		--expect "test_must_fail git" \
+		-- \
+		rev-parse --verify :d/f &&
+	test_todo \
+		--want "test -h" \
+		--expect "test_path_is_missing" \
+		-- \
+		d &&
+	todo_test_path is_file is_missing e/f
 '
 
 test_expect_success 'setup for testing rm messages' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3febf4b0811..5313ab28e72 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -966,6 +966,10 @@ test_path_is_missing () {
 #	--expect <expect>
 #		The condition we have now. Injected in the same way as
 #		the arguments to --want.
+#	--reset <reset>
+#		A command to run between the <want> and <expect>
+#		conditions to reset the repository state. Used e.g. if
+#		both run a "git rm" command that might succeed.
 #
 # test_todo is a wrapper for use with "test_expect_todo". It declares
 # an outcome we want, and one we currently expect:
@@ -985,8 +989,12 @@ test_path_is_missing () {
 # Because we run both neither of them can mutate the test
 # state. I.e. they must be read-only commands such as "wc -l", and not
 # a state-altering command such as "rm".
+#
+# To run a command that mutates the repository state supply a --reset
+# option, e.g. "git reset --hard" if you need to run "git rm".
 test_todo () {
 	local common_fn= &&
+	local reset= &&
 	local have_want= &&
 	local want= &&
 	local expect= &&
@@ -1004,6 +1012,10 @@ test_todo () {
 			have_expect=t &&
 			shift
 			;;
+		--reset)
+			reset="$2" &&
+			shift
+			;;
 		--)
 			shift &&
 			break
@@ -1028,10 +1040,16 @@ test_todo () {
 	then
 		BUG "a test_todo succeeded with --want ('$want').  Turn it into a test_expect_success + $@ $want?" &&
 		return 1
-	elif $common_fn $expect "$@"
-	then
-		say "a test_todo will succeed with --expect ('$expect'), we eventually want '$want' instead" >&3 &&
-		return 0
+	else
+		if test -n "$reset"
+		then
+			$reset
+		fi &&
+		if $common_fn $expect "$@"
+		then
+			say "a test_todo will succeed with --expect ('$expect'), we eventually want '$want' instead" >&3 &&
+			return 0
+		fi
 	fi &&
 	BUG "a test_todo didn't pass with either --want ('$want') or --expect ('$expect')"
 }
-- 
2.35.1.1436.g756b814e59f

