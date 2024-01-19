Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466256B96
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695550; cv=none; b=H+wELmS68LuLbbdY6bXgW9O+ooKKl2lpggAxeMec9YJuKifqKzbVfSKrWM20eqdcGESWYi+Mn4vMyqmP7QRQqd1D6Uquiupfoxa4WlgNdWnk6kQp+1lhO/0qzBOj+J/RfWlsDwyH2MrYDC3qPbuOkgfBOJCP5uZY0aTAWgfQkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695550; c=relaxed/simple;
	bh=qAES9YaWNranJ/lJXueGiyAl/Ee/S/jRLyomz5xuSEc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sCb4ZupcfvFO36aVQXzgKPWdI47TaLeaxb0KVKacK3Qx9ab8WsWqfiHyu6CFwe426/SURkUsFX3z1yoX1RYLcTJhl/IrbmcDOXAibSSRhVQYH5VX1VIP88L6DPWC7wqsoi3lVP6rw8UZJZfehp/jdDNo1GRdh0ZKuLHzhL7VSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3Gy49Cw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3Gy49Cw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so12492405e9.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695545; x=1706300345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaMkTSmnhZAcYej+S0xa0GjaKrm2ThHqQBwsIjiqv2o=;
        b=g3Gy49CwstcO/E3r/j6sSgogv8kIJZnmyatr/5UJyQherYCcl+d4qMXVXeMHihJh5S
         1kMcVrVRoV0iqH7mh+Z75um0irlaA0wOLplv/X2dJYS5JEnXzrVsiwz0zf85yJLExsa+
         j5D+tiwkSwIpssvAsBgPMr91PMyD4MnqkG0mrTcPttb1hPYy0fdgMTksOX16pCMHdYEL
         4rLeSqz75HViZ6d16SWP0t74QtmIQnHVkB2URUy2+D6JcmslQn7/6u71g+Em9NoPKJ/T
         sd7s/bYssamvnzY4NUHoyDUZk1H+N8pAtea2ULfythAECXfJxWq8toSGRngE+xhnMlQo
         mPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695545; x=1706300345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaMkTSmnhZAcYej+S0xa0GjaKrm2ThHqQBwsIjiqv2o=;
        b=eT7GwU5bNXaymwA4X3/3iavChNC4meRmj4zOkrHHZx58ctCPfD0+wfO+W6ICRF52fu
         sQISvqQWZdJjzUjum7RFGQfp/F1OseRDcQPu35RhCg5vTKDeMepLpeYp0Q4WNZidQ8ON
         Ydg18MOMaBOcKfDU+wB84qmQEWPe+7uV/C41Boowb46zIWsxiFKX4NT0nsl2Pw8M12ev
         1DSqSxhTanHRTMjh6oijF+1oXyBWgS2oEWsccwOLavySexGLJpyA/9/ELJ32b9brEcAi
         tE1tiIifzAQSEE8xuiPxrG3uV6eD6sFJMnCGPbIoslwczF5N04fxvPhLhWPa3KrnSd+7
         4G9Q==
X-Gm-Message-State: AOJu0Ywi1/iGXjja0KXWkgrF0FFNxmWQN1jcck7OxhwL8Lm06zt4Y20l
	1c9WEQBZUSkr3v89ozuSIy5o1EGTnUGgYG+ye4G5ziPcnMrnZmEFiGMumEP/
X-Google-Smtp-Source: AGHT+IFCMvB/Zs1B7hvhMKXWDlSY1NnqWsqAh+ppiAU12Oe43F8tE3YOpTJqb6/3DuGoGz2OZwOWwg==
X-Received: by 2002:a05:600c:4a15:b0:40e:50d8:25c6 with SMTP id c21-20020a05600c4a1500b0040e50d825c6mr173387wmp.150.1705695544955;
        Fri, 19 Jan 2024 12:19:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16-20020adff550000000b00337712b065dsm7213430wrp.99.2024.01.19.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:04 -0800 (PST)
Message-ID: <c3f0b81200cb9199de96737745345ad93061a8d0.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:52 +0000
Subject: [PATCH v2 04/12] t1404: move reffiles specific tests to t0600
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

These tests modify loose refs manually and are specific to the reffiles
backend. Move these to t0600 to be part of a test suite of reffiles
specific tests.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh  | 263 +++++++++++++++++++++++++++++++++++
 t/t1404-update-ref-errors.sh | 237 -------------------------------
 2 files changed, 263 insertions(+), 237 deletions(-)
 create mode 100755 t/t0600-reffiles-backend.sh

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
new file mode 100755
index 00000000000..2f910bd76ad
--- /dev/null
+++ b/t/t0600-reffiles-backend.sh
@@ -0,0 +1,263 @@
+#!/bin/sh
+
+test_description='Test reffiles backend'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+if ! test_have_prereq REFFILES
+	then
+		skip_all='skipping reffiles specific tests'
+		test_done
+fi
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m Initial &&
+	C=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m Second &&
+	D=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m Third &&
+	E=$(git rev-parse HEAD)
+'
+
+test_expect_success 'empty directory should not fool rev-parse' '
+	prefix=refs/e-rev-parse &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	echo "$C" >expected &&
+	git rev-parse $prefix/foo >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'empty directory should not fool for-each-ref' '
+	prefix=refs/e-for-each-ref &&
+	git update-ref $prefix/foo $C &&
+	git for-each-ref $prefix >expected &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	git for-each-ref $prefix >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'empty directory should not fool create' '
+	prefix=refs/e-create &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "create %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool verify' '
+	prefix=refs/e-verify &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "verify %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 1-arg update' '
+	prefix=refs/e-update-1 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "update %s $D\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 2-arg update' '
+	prefix=refs/e-update-2 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "update %s $D $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 0-arg delete' '
+	prefix=refs/e-delete-0 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "delete %s\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 1-arg delete' '
+	prefix=refs/e-delete-1 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "delete %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'non-empty directory blocks create' '
+	prefix=refs/ne-create &&
+	mkdir -p .git/$prefix/foo/bar &&
+	: >.git/$prefix/foo/bar/baz.lock &&
+	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/foo$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
+	EOF
+	printf "%s\n" "update $prefix/foo $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ
+	EOF
+	printf "%s\n" "update $prefix/foo $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'broken reference blocks create' '
+	prefix=refs/broken-create &&
+	mkdir -p .git/$prefix &&
+	echo "gobbledigook" >.git/$prefix/foo &&
+	test_when_finished "rm -f .git/$prefix/foo" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	EOF
+	printf "%s\n" "update $prefix/foo $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	EOF
+	printf "%s\n" "update $prefix/foo $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'non-empty directory blocks indirect create' '
+	prefix=refs/ne-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	mkdir -p .git/$prefix/foo/bar &&
+	: >.git/$prefix/foo/bar/baz.lock &&
+	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/symref$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
+	EOF
+	printf "%s\n" "update $prefix/symref $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ
+	EOF
+	printf "%s\n" "update $prefix/symref $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'broken reference blocks indirect create' '
+	prefix=refs/broken-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	echo "gobbledigook" >.git/$prefix/foo &&
+	test_when_finished "rm -f .git/$prefix/foo" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	EOF
+	printf "%s\n" "update $prefix/symref $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	EOF
+	printf "%s\n" "update $prefix/symref $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'no bogus intermediate values during delete' '
+	prefix=refs/slow-transaction &&
+	# Set up a reference with differing loose and packed versions:
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	# Now try to update the reference, but hold the `packed-refs` lock
+	# for a while to see what happens while the process is blocked:
+	: >.git/packed-refs.lock &&
+	test_when_finished "rm -f .git/packed-refs.lock" &&
+	{
+		# Note: the following command is intentionally run in the
+		# background. We increase the timeout so that `update-ref`
+		# attempts to acquire the `packed-refs` lock for much longer
+		# than it takes for us to do the check then delete it:
+		git -c core.packedrefstimeout=30000 update-ref -d $prefix/foo &
+	} &&
+	pid2=$! &&
+	# Give update-ref plenty of time to get to the point where it tries
+	# to lock packed-refs:
+	sleep 1 &&
+	# Make sure that update-ref did not complete despite the lock:
+	kill -0 $pid2 &&
+	# Verify that the reference still has its old value:
+	sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
+	case "$sha1" in
+	$D)
+		# This is what we hope for; it means that nothing
+		# user-visible has changed yet.
+		: ;;
+	undefined)
+		# This is not correct; it means the deletion has happened
+		# already even though update-ref should not have been
+		# able to acquire the lock yet.
+		echo "$prefix/foo deleted prematurely" &&
+		break
+		;;
+	$C)
+		# This value should never be seen. Probably the loose
+		# reference has been deleted but the packed reference
+		# is still there:
+		echo "$prefix/foo incorrectly observed to be C" &&
+		break
+		;;
+	*)
+		# WTF?
+		echo "unexpected value observed for $prefix/foo: $sha1" &&
+		break
+		;;
+	esac >out &&
+	rm -f .git/packed-refs.lock &&
+	wait $pid2 &&
+	test_must_be_empty out &&
+	test_must_fail git rev-parse --verify --quiet $prefix/foo
+'
+
+test_expect_success 'delete fails cleanly if packed-refs file is locked' '
+	prefix=refs/locked-packed-refs &&
+	# Set up a reference with differing loose and packed versions:
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# Now try to delete it while the `packed-refs` lock is held:
+	: >.git/packed-refs.lock &&
+	test_when_finished "rm -f .git/packed-refs.lock" &&
+	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
+	git for-each-ref $prefix >actual &&
+	test_grep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
+	test_cmp unchanged actual
+'
+
+test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
+	# Setup and expectations are similar to the test above.
+	prefix=refs/failed-packed-refs &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# This should not happen in practice, but it is an easy way to get a
+	# reliable error (we open with create_tempfile(), which uses O_EXCL).
+	: >.git/packed-refs.new &&
+	test_when_finished "rm -f .git/packed-refs.new" &&
+	test_must_fail git update-ref -d $prefix/foo &&
+	git for-each-ref $prefix >actual &&
+	test_cmp unchanged actual
+'
+
+test_done
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 0369beea33b..00b70137053 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -191,78 +191,6 @@ test_expect_success 'one new ref is a simple prefix of another' '
 
 '
 
-test_expect_success REFFILES 'empty directory should not fool rev-parse' '
-	prefix=refs/e-rev-parse &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	echo "$C" >expected &&
-	git rev-parse $prefix/foo >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success REFFILES 'empty directory should not fool for-each-ref' '
-	prefix=refs/e-for-each-ref &&
-	git update-ref $prefix/foo $C &&
-	git for-each-ref $prefix >expected &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	git for-each-ref $prefix >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success REFFILES 'empty directory should not fool create' '
-	prefix=refs/e-create &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "create %s $C\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool verify' '
-	prefix=refs/e-verify &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "verify %s $C\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool 1-arg update' '
-	prefix=refs/e-update-1 &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "update %s $D\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool 2-arg update' '
-	prefix=refs/e-update-2 &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "update %s $D $C\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool 0-arg delete' '
-	prefix=refs/e-delete-0 &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "delete %s\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool 1-arg delete' '
-	prefix=refs/e-delete-1 &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "delete %s $C\n" $prefix/foo |
-	git update-ref --stdin
-'
-
 test_expect_success REFFILES 'D/F conflict prevents add long + delete short' '
 	df_test refs/df-al-ds --add-del foo/bar foo
 '
@@ -468,169 +396,4 @@ test_expect_success 'incorrect old value blocks indirect no-deref delete' '
 	test_cmp expected output.err
 '
 
-test_expect_success REFFILES 'non-empty directory blocks create' '
-	prefix=refs/ne-create &&
-	mkdir -p .git/$prefix/foo/bar &&
-	: >.git/$prefix/foo/bar/baz.lock &&
-	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
-	EOF
-	printf "%s\n" "update $prefix/foo $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ
-	EOF
-	printf "%s\n" "update $prefix/foo $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
-'
-
-test_expect_success REFFILES 'broken reference blocks create' '
-	prefix=refs/broken-create &&
-	mkdir -p .git/$prefix &&
-	echo "gobbledigook" >.git/$prefix/foo &&
-	test_when_finished "rm -f .git/$prefix/foo" &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
-	EOF
-	printf "%s\n" "update $prefix/foo $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
-	EOF
-	printf "%s\n" "update $prefix/foo $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
-'
-
-test_expect_success REFFILES 'non-empty directory blocks indirect create' '
-	prefix=refs/ne-indirect-create &&
-	git symbolic-ref $prefix/symref $prefix/foo &&
-	mkdir -p .git/$prefix/foo/bar &&
-	: >.git/$prefix/foo/bar/baz.lock &&
-	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
-	EOF
-	printf "%s\n" "update $prefix/symref $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ
-	EOF
-	printf "%s\n" "update $prefix/symref $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
-'
-
-test_expect_success REFFILES 'broken reference blocks indirect create' '
-	prefix=refs/broken-indirect-create &&
-	git symbolic-ref $prefix/symref $prefix/foo &&
-	echo "gobbledigook" >.git/$prefix/foo &&
-	test_when_finished "rm -f .git/$prefix/foo" &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
-	EOF
-	printf "%s\n" "update $prefix/symref $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
-	EOF
-	printf "%s\n" "update $prefix/symref $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
-'
-
-test_expect_success REFFILES 'no bogus intermediate values during delete' '
-	prefix=refs/slow-transaction &&
-	# Set up a reference with differing loose and packed versions:
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	git update-ref $prefix/foo $D &&
-	# Now try to update the reference, but hold the `packed-refs` lock
-	# for a while to see what happens while the process is blocked:
-	: >.git/packed-refs.lock &&
-	test_when_finished "rm -f .git/packed-refs.lock" &&
-	{
-		# Note: the following command is intentionally run in the
-		# background. We increase the timeout so that `update-ref`
-		# attempts to acquire the `packed-refs` lock for much longer
-		# than it takes for us to do the check then delete it:
-		git -c core.packedrefstimeout=30000 update-ref -d $prefix/foo &
-	} &&
-	pid2=$! &&
-	# Give update-ref plenty of time to get to the point where it tries
-	# to lock packed-refs:
-	sleep 1 &&
-	# Make sure that update-ref did not complete despite the lock:
-	kill -0 $pid2 &&
-	# Verify that the reference still has its old value:
-	sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
-	case "$sha1" in
-	$D)
-		# This is what we hope for; it means that nothing
-		# user-visible has changed yet.
-		: ;;
-	undefined)
-		# This is not correct; it means the deletion has happened
-		# already even though update-ref should not have been
-		# able to acquire the lock yet.
-		echo "$prefix/foo deleted prematurely" &&
-		break
-		;;
-	$C)
-		# This value should never be seen. Probably the loose
-		# reference has been deleted but the packed reference
-		# is still there:
-		echo "$prefix/foo incorrectly observed to be C" &&
-		break
-		;;
-	*)
-		# WTF?
-		echo "unexpected value observed for $prefix/foo: $sha1" &&
-		break
-		;;
-	esac >out &&
-	rm -f .git/packed-refs.lock &&
-	wait $pid2 &&
-	test_must_be_empty out &&
-	test_must_fail git rev-parse --verify --quiet $prefix/foo
-'
-
-test_expect_success REFFILES 'delete fails cleanly if packed-refs file is locked' '
-	prefix=refs/locked-packed-refs &&
-	# Set up a reference with differing loose and packed versions:
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	git update-ref $prefix/foo $D &&
-	git for-each-ref $prefix >unchanged &&
-	# Now try to delete it while the `packed-refs` lock is held:
-	: >.git/packed-refs.lock &&
-	test_when_finished "rm -f .git/packed-refs.lock" &&
-	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
-	git for-each-ref $prefix >actual &&
-	test_grep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
-	test_cmp unchanged actual
-'
-
-test_expect_success REFFILES 'delete fails cleanly if packed-refs.new write fails' '
-	# Setup and expectations are similar to the test above.
-	prefix=refs/failed-packed-refs &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	git update-ref $prefix/foo $D &&
-	git for-each-ref $prefix >unchanged &&
-	# This should not happen in practice, but it is an easy way to get a
-	# reliable error (we open with create_tempfile(), which uses O_EXCL).
-	: >.git/packed-refs.new &&
-	test_when_finished "rm -f .git/packed-refs.new" &&
-	test_must_fail git update-ref -d $prefix/foo &&
-	git for-each-ref $prefix >actual &&
-	test_cmp unchanged actual
-'
-
 test_done
-- 
gitgitgadget

