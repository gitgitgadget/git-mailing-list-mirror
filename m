Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD141F731
	for <e@80x24.org>; Mon,  5 Aug 2019 22:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfHEWnq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 18:43:46 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:47485 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHEWnq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 18:43:46 -0400
Received: by mail-vs1-f74.google.com with SMTP id d139so21626002vsc.14
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 15:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=nzXciFsTiMatBZDVhDLZ10LqNSNnvu0f6Z8XDgGSdOM=;
        b=uALiLqwRsJ0gyrKV5DBYa3M42z9/mzaNaZGusB+1zleSf6yN03/311+bphHq3tgdlx
         WX+4zgAZg8b+iX/orb0b2Ls59cuRotjmINNyEGULHLXt795bYVCR59n45eyxF2kC3kK0
         w4V2bZ4zpAmjzMsAm2TRNqX8xdlTzMBWgYXHNQZAsnHk9Z+vZpkJm3ICjaten13HdJ4F
         O+nlRumalh4zLAde1Wx97yXvZmhsGzYB38Npc7emMrsA+cj//DKMu6xg9KKjyZ26fsWh
         NjpjEhRE62W7LpWFG/nTFJxTemXXH4dE+w+0yIHDaQmtKQpDjVNtiXyter4iILoGLTDc
         Q8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=nzXciFsTiMatBZDVhDLZ10LqNSNnvu0f6Z8XDgGSdOM=;
        b=lPqzyDY4gnmxwQllMEcnnjOsKumyGbnM9qF4bNdegdyb0ZzLGreC7NhEUdGu6kdSPr
         FCTOt1uWU2SvjKUAQqOQMWCHUVzMSyAxqlzwP6TjOJqyNUTb50s3DRZdLkfPzHLbwdgt
         vFzoxo9P8H7zK6VvDtTv8Ay2+G6W78uYpzcr27wAKgilWGVPbMQuoc28XFqyE9bqFkRc
         Byqvm8IlGwLcEOMzkdVf2ouB51it4EdR7wsUxjF15BXeeNQNHwg6g49lktQeEcqwgCTt
         40THS24gSjGiddud/1gJO5xkdG8wXDkuhwKyuClWrlarf5eoKyyArpAubE4WCzKeO4sn
         dd3Q==
X-Gm-Message-State: APjAAAWjjlSdewL+TGN+bAHp57Y1hg3eBn97dPUzhDf6IkRNFudXv39m
        sObDmHLYGXnX6fuFBAFkWVJKeaVim9SmRMV6kv6MLsxn6rsv3bmAI0H6yoeLzYbYmeB3c/KxGEL
        +Cc+b7z0QGMRFZ9vxNJNTbgYPAeeRzqqBFOKSzoG6yoOjJp/kOZJNzTxbX4Wmb9U=
X-Google-Smtp-Source: APXvYqyOjjvRpy5MYbq24vRy1swMVb6R0jy/3GEIXxMnEJPdGqk/ER1SYp50ZehnunnjY337xy5VnPJKscqrvw==
X-Received: by 2002:a67:ec42:: with SMTP id z2mr463125vso.218.1565045024599;
 Mon, 05 Aug 2019 15:43:44 -0700 (PDT)
Date:   Mon,  5 Aug 2019 15:43:36 -0700
In-Reply-To: <cover.1565044345.git.steadmon@google.com>
Message-Id: <50857290955c5467ef6f75083395c695340fa284.1565044345.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1564695892.git.steadmon@google.com> <cover.1565044345.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v4 1/4] t7503: verify proper hook execution
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t7503 did not verify that the expected hooks actually ran during
testing. Fix that by making the hook scripts write their $0 into a file
so that we can compare actual execution vs. expected execution.

While we're at it, do some test style cleanups, such as using
write_script() and doing setup inside a test_expect_success block.

Improved-by: Martin =C3=85gren <martin.agren@gmail.com>
Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t7503-pre-commit-hook.sh | 157 +++++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 68 deletions(-)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b39d..a71ec31222 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -4,124 +4,144 @@ test_description=3D'pre-commit hook'
=20
 . ./test-lib.sh
=20
-test_expect_success 'with no hook' '
+HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
+PRECOMMIT=3D"$HOOKDIR/pre-commit"
+
+# Prepare sample scripts that write their $0 to actual_hooks
+test_expect_success 'sample script setup' '
+	mkdir -p "$HOOKDIR" &&
+	write_script "$HOOKDIR/success.sample" <<-\EOF &&
+	echo $0 >>actual_hooks
+	exit 0
+	EOF
+	write_script "$HOOKDIR/fail.sample" <<-\EOF &&
+	echo $0 >>actual_hooks
+	exit 1
+	EOF
+	write_script "$HOOKDIR/non-exec.sample" <<-\EOF &&
+	echo $0 >>actual_hooks
+	exit 1
+	EOF
+	chmod -x "$HOOKDIR/non-exec.sample" &&
+	write_script "$HOOKDIR/require-prefix.sample" <<-\EOF &&
+	echo $0 >>actual_hooks
+	test $GIT_PREFIX =3D "success/"
+	EOF
+	write_script "$HOOKDIR/check-author.sample" <<-\EOF
+	echo $0 >>actual_hooks
+	test "$GIT_AUTHOR_NAME" =3D "New Author" &&
+	test "$GIT_AUTHOR_EMAIL" =3D "newauthor@example.com"
+	EOF
+'
=20
-	echo "foo" > file &&
+test_expect_success 'with no hook' '
+	test_when_finished "rm -f actual_hooks" &&
+	echo "foo" >file &&
 	git add file &&
-	git commit -m "first"
-
+	git commit -m "first" &&
+	test_path_is_missing actual_hooks
 '
=20
 test_expect_success '--no-verify with no hook' '
-
-	echo "bar" > file &&
+	test_when_finished "rm -f actual_hooks" &&
+	echo "bar" >file &&
 	git add file &&
-	git commit --no-verify -m "bar"
-
+	git commit --no-verify -m "bar" &&
+	test_path_is_missing actual_hooks
 '
=20
-# now install hook that always succeeds
-HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
-HOOK=3D"$HOOKDIR/pre-commit"
-mkdir -p "$HOOKDIR"
-cat > "$HOOK" <<EOF
-#!/bin/sh
-exit 0
-EOF
-chmod +x "$HOOK"
-
 test_expect_success 'with succeeding hook' '
-
-	echo "more" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	ln -s "success.sample" "$PRECOMMIT" &&
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo "more" >>file &&
 	git add file &&
-	git commit -m "more"
-
+	git commit -m "more" &&
+	test_cmp expected_hooks actual_hooks
 '
=20
 test_expect_success '--no-verify with succeeding hook' '
-
-	echo "even more" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
+	ln -s "success.sample" "$PRECOMMIT" &&
+	echo "even more" >>file &&
 	git add file &&
-	git commit --no-verify -m "even more"
-
+	git commit --no-verify -m "even more" &&
+	test_path_is_missing actual_hooks
 '
=20
-# now a hook that fails
-cat > "$HOOK" <<EOF
-#!/bin/sh
-exit 1
-EOF
-
 test_expect_success 'with failing hook' '
-
-	echo "another" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	ln -s "fail.sample" "$PRECOMMIT" &&
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo "another" >>file &&
 	git add file &&
-	test_must_fail git commit -m "another"
-
+	test_must_fail git commit -m "another" &&
+	test_cmp expected_hooks actual_hooks
 '
=20
 test_expect_success '--no-verify with failing hook' '
-
-	echo "stuff" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
+	ln -s "fail.sample" "$PRECOMMIT" &&
+	echo "stuff" >>file &&
 	git add file &&
-	git commit --no-verify -m "stuff"
-
+	git commit --no-verify -m "stuff" &&
+	test_path_is_missing actual_hooks
 '
=20
-chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
-
-	echo "content" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
+	ln -s "non-exec.sample" "$PRECOMMIT" &&
+	echo "content" >>file &&
 	git add file &&
-	git commit -m "content"
-
+	git commit -m "content" &&
+	test_path_is_missing actual_hooks
 '
=20
 test_expect_success POSIXPERM '--no-verify with non-executable hook' '
-
-	echo "more content" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
+	ln -s "non-exec.sample" "$PRECOMMIT" &&
+	echo "more content" >>file &&
 	git add file &&
-	git commit --no-verify -m "more content"
-
+	git commit --no-verify -m "more content" &&
+	test_path_is_missing actual_hooks
 '
-chmod +x "$HOOK"
-
-# a hook that checks $GIT_PREFIX and succeeds inside the
-# success/ subdirectory only
-cat > "$HOOK" <<EOF
-#!/bin/sh
-test \$GIT_PREFIX =3D success/
-EOF
=20
 test_expect_success 'with hook requiring GIT_PREFIX' '
-
-	echo "more content" >> file &&
+	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks suc=
cess" &&
+	ln -s "require-prefix.sample" "$PRECOMMIT" &&
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo "more content" >>file &&
 	git add file &&
 	mkdir success &&
 	(
 		cd success &&
 		git commit -m "hook requires GIT_PREFIX =3D success/"
 	) &&
-	rmdir success
+	test_cmp expected_hooks actual_hooks
 '
=20
 test_expect_success 'with failing hook requiring GIT_PREFIX' '
-
-	echo "more content" >> file &&
+	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks fai=
l" &&
+	ln -s "require-prefix.sample" "$PRECOMMIT" &&
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo "more content" >>file &&
 	git add file &&
 	mkdir fail &&
 	(
 		cd fail &&
 		test_must_fail git commit -m "hook must fail"
 	) &&
-	rmdir fail &&
-	git checkout -- file
+	git checkout -- file &&
+	test_cmp expected_hooks actual_hooks
 '
=20
 test_expect_success 'check the author in hook' '
-	write_script "$HOOK" <<-\EOF &&
-	test "$GIT_AUTHOR_NAME" =3D "New Author" &&
-	test "$GIT_AUTHOR_EMAIL" =3D "newauthor@example.com"
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	ln -s "check-author.sample" "$PRECOMMIT" &&
+	cat >expected_hooks <<-EOF &&
+	$PRECOMMIT
+	$PRECOMMIT
+	$PRECOMMIT
 	EOF
 	test_must_fail git commit --allow-empty -m "by a.u.thor" &&
 	(
@@ -133,7 +153,8 @@ test_expect_success 'check the author in hook' '
 	) &&
 	git commit --author=3D"New Author <newauthor@example.com>" \
 		--allow-empty -m "by new.author via command line" &&
-	git show -s
+	git show -s &&
+	test_cmp expected_hooks actual_hooks
 '
=20
 test_done
--=20
2.22.0.770.g0f2c4a37fd-goog

