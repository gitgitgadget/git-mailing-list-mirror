Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18429C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C641221E2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLF6W98s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHFUJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 16:09:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD01C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 13:09:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so53225191ljc.5
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dif2qzmxC5norY3tGOYV5diTox0N1HIOvuDBdAU1cVc=;
        b=QLF6W98snMDE5HecexROi9hqCEwcw4LJPl4t0G+tRNGTgwYvtFDbIkP2XNwq91YVhR
         O3TSw2NWGLzV7iBEbjdz+Py/zOtNSPdI/1Yg2yVrV1M255aTrvJCYHqZuy8gLZEHhnId
         PLxd6lsIyXlM5nWirOJahHkQ333xAXuJGaZN6Xsvtyb/ELhg4aCJw+qLO/dOBgQ5SOXz
         KnT00VemAFgFXc8HLVx2J+Fb+m3+zR1YLyRQQ8cyNvuLN4KtZTFlGpsqognU44DCKxxw
         iq7dzkTCNo2t/vsEwYhuGNUqpYTOGRNCvgQzirD1vBhU0WVssi2Bedfs5pdwz3EoEdRk
         RMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dif2qzmxC5norY3tGOYV5diTox0N1HIOvuDBdAU1cVc=;
        b=qhw7WhbqTodZObP4JOkFI0ruSx9HPY39BsEtfbG/MLEZpjJmu4SsGrWjkVcxouy0Sp
         IOz4K2tTHLJL9CE1v/YzPxG/rJiAnBnofkmbC0+K/yRzyqP8ioAHve4vrW0TKlUcLEXk
         Tx5Fy1Dn2zYbOZlZYgA1bLuAVpKL/43hpzAshjaO7mc/GsLvWCSsD0e8+I/mHKZRTQUi
         gKI4s6LFtFNqn5EGPGwnIl3EqBNPitAvz6R+d1Clgd8u/nhdQGvG+iFs+anXhrq4AYC1
         HL0yl0nsr7KLgOeMHkOCwXCYu6L4u9L/pqSBbhNtYXmTzfgRAnNXx2EcNPpCSFmw78as
         ijpQ==
X-Gm-Message-State: AOAM530G5mfxJTY78E6c1rg5tBmDbpeXEoxg/mBVeMElSMgGGCM9BJ9W
        ppHi5Zt9NDwM8Q5xeOMt5O5VkGoT
X-Google-Smtp-Source: ABdhPJxDhTigwN8wxx9+7FW58eBN9BxrT5TjLHHXlibscpEdxCeRTTEUqsdcb5wRyMqEpKVvze4EOg==
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr4878014ljk.81.1596744551915;
        Thu, 06 Aug 2020 13:09:11 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id k84sm3436130lfd.90.2020.08.06.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 13:09:11 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 2/2] t4104: modernize and simplify quoting
Date:   Thu,  6 Aug 2020 22:08:54 +0200
Message-Id: <3be4695a2778c9c72a943e438e61a18d4de468a5.1596742823.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.199.g4234a9100e
In-Reply-To: <cover.1596742823.git.martin.agren@gmail.com>
References: <20200802143018.5501-1-martin.agren@gmail.com> <cover.1596742823.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drop whitespace in the value of `$test_description` and in a test body
and use `test_write_lines`.

Stop defining `$u` with a trailing space just so that we can tuck it in
like `git foo $u$more...` and get minimal whitespace in the command:
`git foo $u $more...` is more readable at the "cost" of an empty `$u`
yielding `git foo  something...`.

Finally, avoid using single quotes within the test scripts to repeatedly
close and reopen the quotes that wrap the test scripts (see the previous
commit). This "unnecessary" quoting does mean that the verbose test
output shows the interpolated values, i.e., the shell code we're
running. But the downside is that the source of the script does *not*
show the shell code we're eventually executing, leaving the reader to
reason about what we really do and whether there are any quoting issues.
(There aren't.)

Where we run through loops to generate several "identical but different"
tests, the test message contains the interpolated variables we're
looping on, meaning one can always identify exactly which instance has
failed, even if the verbose test output shows the exact same test body
several times.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t4104-apply-boundary.sh | 57 +++++++++++----------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 32e3b0ee0b..71ef4132d1 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -3,80 +3,55 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-test_description='git apply boundary tests
+test_description='git apply boundary tests'
 
-'
 . ./test-lib.sh
 
 L="c d e f g h i j k l m n o p q r s t u v w x"
 
 test_expect_success setup '
-	for i in b '"$L"' y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b $L y >victim &&
 	cat victim >original &&
 	git update-index --add victim &&
 
 	# add to the head
-	for i in a b '"$L"' y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines a b $L y >victim &&
 	cat victim >add-a-expect &&
 	git diff victim >add-a-patch.with &&
 	git diff --unified=0 >add-a-patch.without &&
 
 	# insert at line two
-	for i in b a '"$L"' y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b a $L y >victim &&
 	cat victim >insert-a-expect &&
 	git diff victim >insert-a-patch.with &&
 	git diff --unified=0 >insert-a-patch.without &&
 
 	# modify at the head
-	for i in a '"$L"' y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines a $L y >victim &&
 	cat victim >mod-a-expect &&
 	git diff victim >mod-a-patch.with &&
 	git diff --unified=0 >mod-a-patch.without &&
 
 	# remove from the head
-	for i in '"$L"' y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines $L y >victim &&
 	cat victim >del-a-expect &&
 	git diff victim >del-a-patch.with &&
 	git diff --unified=0 >del-a-patch.without &&
 
 	# add to the tail
-	for i in b '"$L"' y z
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b $L y z >victim &&
 	cat victim >add-z-expect &&
 	git diff victim >add-z-patch.with &&
 	git diff --unified=0 >add-z-patch.without &&
 
 	# modify at the tail
-	for i in b '"$L"' z
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b $L z >victim &&
 	cat victim >mod-z-expect &&
 	git diff victim >mod-z-patch.with &&
 	git diff --unified=0 >mod-z-patch.without &&
 
 	# remove from the tail
-	for i in b '"$L"'
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b $L >victim &&
 	cat victim >del-z-expect &&
 	git diff victim >del-z-patch.with &&
 	git diff --unified=0 >del-z-patch.without
@@ -88,15 +63,15 @@ for with in with without
 do
 	case "$with" in
 	with) u= ;;
-	without) u='--unidiff-zero ' ;;
+	without) u=--unidiff-zero ;;
 	esac
 	for kind in add-a add-z insert-a mod-a mod-z del-a del-z
 	do
 		test_expect_success "apply $kind-patch $with context" '
 			cat original >victim &&
 			git update-index victim &&
-			git apply --index '"$u$kind-patch.$with"' &&
-			test_cmp '"$kind"'-expect victim
+			git apply --index $u "$kind-patch.$with" &&
+			test_cmp "$kind-expect" victim
 		'
 	done
 done
@@ -110,13 +85,12 @@ do
 	test_expect_success "apply non-git $kind-patch without context" '
 		cat original >victim &&
 		git update-index victim &&
-		git apply --unidiff-zero --index '"$kind-ng.without"' &&
-		test_cmp '"$kind"'-expect victim
+		git apply --unidiff-zero --index "$kind-ng.without" &&
+		test_cmp "$kind-expect" victim
 	'
 done
 
 test_expect_success 'two lines' '
-
 	>file &&
 	git add file &&
 	echo aaa >file &&
@@ -125,11 +99,10 @@ test_expect_success 'two lines' '
 	echo bbb >file &&
 	git add file &&
 	test_must_fail git apply --check patch
-
 '
 
 test_expect_success 'apply patch with 3 context lines matching at end' '
-	{ echo a; echo b; echo c; echo d; } >file &&
+	test_write_lines a b c d >file &&
 	git add file &&
 	echo e >>file &&
 	git diff >patch &&
-- 
2.28.0.199.g4234a9100e

