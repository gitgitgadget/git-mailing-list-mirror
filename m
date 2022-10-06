Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5006C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiJFUYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiJFUYr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 16:24:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4CC193CB
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 13:24:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u21so4411065edi.9
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BAB0kaqaPy8SOrpKxK2pA5QYxJKhmWYm36WoN+ozVag=;
        b=ROPy29zUoMZI2ZkxYQpIQHT39sUrgWt4MAHVYMBW5ZwnNzaiz5BdfNSpZ72xBsLsXr
         NU3gqjRo7CBVmOP4EWxYy9EAP0ridTPZciA7FR3jLLFgaGNgyt7ais8n5b8WIvxvK5fQ
         VtE0lZxrIhCIsli+I76AJ5DcU1LsrOBo5YOmTIdNF/fctB9QIoBSVlMMHdPJc7dESTLK
         1KVOoDPeEfeLU42HomRC159tmRfdUEOpDS71GU8aKsX/HnaHXc2ch8ARHoL+/5nFh22i
         TKlYxZRXdS1y3gG2cG6okGUkeuirUHhd3+9pm1XaWkCuqZ0N8TcxxuSqaHfY3vpzuNsu
         Dkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAB0kaqaPy8SOrpKxK2pA5QYxJKhmWYm36WoN+ozVag=;
        b=syJJrivg0QP4kkrQN2jwiJQmXxrsMAYSPJKAZ3jw9WPuj6aEqLDRrIB8TAZKoCtCXr
         D8FXtlkebNyIv1p6ASK8/JkONGN7s7s/X7JA9bN9bXTaQT4ooVnfRHi4hwRZrRtzgr+P
         SGR2uzotayM6fRAyUqQtVFqmZs3PMZ6tfSDDoHEjGkS6pvxXSDlUHoY3COr7Dl+R9eDf
         SucpEvXCwOsnB/kbEJ6A8vYepRopS5TOBi/2Y/FdKws1PLguZ8ENO/mRNs8UJlaPtqBI
         suT0FRxP9z8eegbLcUvjYOyAcf/OHciUNGeeQxFNrWGDr97VXTxdO/AlNbDI8PXmo/gj
         baIA==
X-Gm-Message-State: ACrzQf2BpQgf5HySbQdSf4R5ojFyKpSOYwbTfJNbv7u9JmE6ejTjTtur
        uc6Tz3XDaPvXIe+0Bn6/jhYhWY4cB50=
X-Google-Smtp-Source: AMsMyM64OfRUowiP27oGzZMga1vGyWLa6fPJ0G5P7QJ1eLuaUpk5settemyy7y8OSbZlw0UQb76z1w==
X-Received: by 2002:a05:6402:3988:b0:44e:6f08:ddfb with SMTP id fk8-20020a056402398800b0044e6f08ddfbmr1439614edb.89.1665087883533;
        Thu, 06 Oct 2022 13:24:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kw18-20020a170907771200b0078b551d2fa3sm168540ejc.103.2022.10.06.13.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:24:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogXQ9-0033lg-2v;
        Thu, 06 Oct 2022 22:24:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/3] [RFC] tests: add test_todo() for known failures
Date:   Thu, 06 Oct 2022 21:28:44 +0200
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
Message-ID: <221006.86v8owr986.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:

> test_todo() is intended as a fine grained alternative to
> test_expect_failure(). Rather than marking the whole test as failing
> test_todo() is used to mark individual failing commands within a test. Th=
is
> approach to writing failing tests allows us to detect unexpected failures
> that are hidden by test_expect_failure().
>
> This series attempts to keep most of the benefits test_expect_todo()
> previously proposed by =C3=86var[1] while being simpler to use.
>
> [1]
> https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab=
@gmail.com/

I like the interface you've got here much better than the one I
submitted in [1], so much that it's what I tried to write at first :)

But as you noted in 1/3:

	test_todo cannot be used in a subshell.

So when we do this:
=09
	diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
	index 93d3930d9f6..75b84a09592 100755
	--- a/t/t0000-basic.sh
	+++ b/t/t0000-basic.sh
	@@ -147,7 +147,7 @@ test_expect_success 'subtest: a failing test_todo' '
	 		false
	 	}
	 	test_expect_success "passing test" "true"
	-	test_expect_success "known todo" "test_todo test_false"
	+	test_expect_success "known todo" "(test_todo test_false)"
	 	test_done
	 	EOF
	 	check_sub_test_lib_test failing-test-todo <<-\EOF

We'll get:
=09
	+ diff -u failing-test-todo/expect.out failing-test-todo/out
	--- failing-test-todo/expect.out        2022-10-06 19:30:14.093338392 +0000
	+++ failing-test-todo/out       2022-10-06 19:30:14.093338392 +0000
	@@ -1,5 +1,4 @@
	 ok 1 - passing test
	-not ok 2 - known todo # TODO known breakage
	-# still have 1 known breakage(s)
	-# passed all remaining 1 test(s)
	+ok 2 - known todo
	+# passed all 2 test(s)
	 1..2

What I was initially trying to do when I tried this approach was to make
the "test_todo" be the equivalent of a sub-test, i.e. when we encounter
one we'd say "ok N - DESC" for the current test so far, and then an "ok
N+1 - DESC # TODO: $cmd" for the "test_todo" command.

I think I lost the code for that, but I tried hacking something rough up
on top of your series. I don't think it's a viable approach but it works
as long as we don't have a subshell (the "remaining N tests" count is
off, but it's fixable, I just couldn't be bothered for a WIP hack):
=09
	diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
	index 93d3930d9f6..7e8e0a54558 100755
	--- a/t/t0000-basic.sh
	+++ b/t/t0000-basic.sh
	@@ -148,14 +148,17 @@ test_expect_success 'subtest: a failing test_todo' '
	 	}
	 	test_expect_success "passing test" "true"
	 	test_expect_success "known todo" "test_todo test_false"
	+	test_expect_success "passing test 2" "true"
	 	test_done
	 	EOF
	 	check_sub_test_lib_test failing-test-todo <<-\EOF
	 	> ok 1 - passing test
	-	> not ok 2 - known todo # TODO known breakage
	+	> not ok 2 - known todo: test_false # TODO known breakage
	+	> ok 3 - known todo (post-test_todo)
	+	> ok 4 - passing test 2
	 	> # still have 1 known breakage(s)
	-	> # passed all remaining 1 test(s)
	-	> 1..2
	+	> # passed all remaining 3 test(s)
	+	> 1..4
	 	EOF
	 '
=09=20
	@@ -171,7 +174,8 @@ test_expect_success 'subtest: a passing test_todo' '
	 	check_sub_test_lib_test passing-test-todo <<-\EOF
	 	> not ok 1 - pretend we have fixed a test_todo breakage
	 	> #	test_todo test_true
	-	> # failed 1 among 1 test(s)
	+	> # 1 known breakage(s) vanished; please update test(s)
	+	> # failed 1 among remaining 0 test(s)
	 	> 1..1
	 	EOF
	 '
	diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
	index 068a0702809..54365fe202f 100644
	--- a/t/test-lib-functions.sh
	+++ b/t/test-lib-functions.sh
	@@ -826,15 +826,12 @@ test_expect_success () {
	 	then
	 		test -n "$test_skip_test_preamble" ||
	 		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
	-		test_todo_=3Dtest_expect_success
	+		test_todo_title_=3D"$1"
	+		test_had_todo_=3D
	 		if test_run_ "$2"
	 		then
	-			if test "$test_todo_" =3D "todo"
	-			then
	-				test_known_broken_failure_ "$1"
	-			else
	-				test_ok_ "$1"
	-			fi
	+			test_ok_ "$1${test_had_todo_:+ (post-test_todo)}"
	+			test_had_todo_=3D
	 		else
	 			test_failure_ "$@"
	 		fi
	@@ -1167,12 +1164,26 @@ test_must_fail_helper () {
	 # "test_*" assertions such as test_cmp().
=09=20
	 test_todo () {
	+	if test -z "$test_todo_title_"
	+	then
	+		BUG 'test_todo: expected a $test_todo_title_'
	+	fi &&
	 	if test "$test_todo_" =3D "test_expect_failure"
	 	then
	 		BUG "test_todo_ cannot be used inside test_expect_failure"
	+	fi &&
	+	# Tell "test_expect_success" it had a "test_todo"
	+	test_had_todo_=3D1 &&
	+	# We say that the test up until this point is OK, and emit an "ok .." fo=
r it.
	+	test_ok_ "$test_todo_title_" &&
	+	if test_must_fail_helper todo "$@" 2>&7
	+	then
	+		test_known_broken_failure_ "$test_todo_title_: $*" 1>&5 2>&6 &&
	+		test_count=3D$(($test_count+1))
	+	else
	+		test_known_broken_ok_ "$test_todo_title_: $*" &&
	+		return 1
	 	fi
	-	test_todo_=3Dtodo
	-	test_must_fail_helper todo "$@" 2>&7
	 } 7>&2 2>&4
=09=20
	 # This is not among top-level (test_expect_success | test_expect_failure)

Anyway, the core difference between the APIs we proposed for this is
that you'd do:

	test_expect_success 'desc' 'test_todo false'

Whereas I suggested:

	test_expect_todo 'desc' '! false'

Now, let's pick apart the differences:

 1. With "test_expect_todo" we're declaring "this is a TODO test" for
    the test as a whole.

 2. With your "test_todo" we're not doing that, instead we proceed as
    normal, and then we might note "we had a TODO" midway through, then
    at the end we'll spot that we had a TODO test (but this approach
    won't work with subshells).

 3. Your "test_todo" is basically a "let's let this pass", whereas mine
    was a helper which exhaustively declared *what* the bad behavior
    was.

    (Although some of yours seems to be midway between the two,
    i.e. https://lore.kernel.org/git/c3f4a79c-2dc6-fbf4-fc61-591ebf417682@d=
unelm.org.uk/)

I think the main critique you and Junio had of my series was to do with
#3, i.e. that it was a hassle to exhaustively declare what the behavior
is & should be, as you note in:
https://lore.kernel.org/git/c3f4a79c-2dc6-fbf4-fc61-591ebf417682@dunelm.org=
.uk/

	test_todo \
		--want "test_must_fail git" \
		--reset "git reset --hard" \
		--expect git \
		-- \
		rm d/f &&

That's fair enough, maybe that's not worth the effort. The reason I
initially hacked this up was because I'd noticed a behavior difference
in a command that was only revealed in a test_expect_failure block, but
because we didn't assert *what* the behavior was we didn't notice.

My version (if fully used) would spot that, but that's because of how I
wrote the "tes_todo", it's orthagonal to #1 and #2 above.

So I don't see why we wouldn't instead have a "test_expect_todo" and
just write the helper differently, or have a mode where it's less
strict, and (if we find it worthwhile) one where it's more strict.

I rebased my
https://lore.kernel.org/git/patch-1.7-4624abc2591-20220318T002951Z-avarab@g=
mail.com/
just now and applied the below on top, which seems to me to give you
pretty much the end result you want, the only difference is that my
version will also work in subshells (see the t2500 one):

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-b=
uiltin.sh
index de1ec89007d..fe47e503bd1 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -468,7 +468,7 @@ test_expect_success 'sparse-checkout (init|set|disable)=
 warns with unmerged stat
 	git -C unmerged sparse-checkout disable
 '
=20
-test_expect_failure 'sparse-checkout reapply' '
+test_expect_todo 'sparse-checkout reapply' '
 	git clone repo tweak &&
=20
 	echo dirty >tweak/deep/deeper2/a &&
@@ -502,11 +502,11 @@ test_expect_failure 'sparse-checkout reapply' '
=20
 	# NEEDSWORK: We are asking to update a file outside of the
 	# sparse-checkout cone, but this is no longer allowed.
-	git -C tweak add folder1/a &&
+	test_todo git -C tweak add folder1/a &&
 	git -C tweak sparse-checkout reapply 2>err &&
-	test_must_be_empty err &&
+	test_todo test_must_be_empty err &&
 	test_path_is_missing tweak/deep/deeper2/a &&
-	test_path_is_missing tweak/folder1/a &&
+	test_todo test_path_is_missing tweak/folder1/a &&
=20
 	git -C tweak sparse-checkout disable
 '
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriti=
ng.sh
index 5c0bf4d21fc..db7c72d38d8 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -167,7 +167,7 @@ test_expect_success 'git rebase fast forwarding and unt=
racked files' '
 	)
 '
=20
-test_expect_failure 'git rebase --autostash and untracked files' '
+test_expect_todo 'git rebase --autostash and untracked files' '
 	test_setup_sequencing rebase_autostash_and_untracked &&
 	(
 		cd sequencing_rebase_autostash_and_untracked &&
@@ -176,7 +176,7 @@ test_expect_failure 'git rebase --autostash and untrack=
ed files' '
 		mkdir filler &&
 		echo precious >filler/file &&
 		cp filler/file expect &&
-		git rebase --autostash init &&
+		test_todo git rebase --autostash init &&
 		test_path_is_file filler/file
 	)
 '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence=
.sh
index 3b0fa66c33d..b31b6b0f7a0 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -577,7 +577,7 @@ test_expect_success '--continue respects -x in first co=
mmit in multi-pick' '
 	grep "cherry picked from.*$picked" msg
 '
=20
-test_expect_failure '--signoff is automatically propagated to resolved con=
flict' '
+test_expect_todo '--signoff is automatically propagated to resolved confli=
ct' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick --signoff base..anotherpick &&
 	echo "c" >foo &&
@@ -591,7 +591,7 @@ test_expect_failure '--signoff is automatically propaga=
ted to resolved conflict'
 	git cat-file commit HEAD~3 >initial_msg &&
 	! grep "Signed-off-by:" initial_msg &&
 	grep "Signed-off-by:" unrelatedpick_msg &&
-	! grep "Signed-off-by:" picked_msg &&
+	test_todo ! grep "Signed-off-by:" picked_msg &&
 	grep "Signed-off-by:" anotherpick_msg
 '
=20
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index e74a318ac33..6c7929f5557 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -790,7 +790,7 @@ test_expect_success SYMLINKS 'rm across a symlinked lea=
ding path (no index)' '
 	test_path_is_file e/f
 '
=20
-test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index=
)' '
+test_expect_todo SYMLINKS 'rm across a symlinked leading path (w/ index)' '
 	rm -rf d e &&
 	mkdir d &&
 	echo content >d/f &&
@@ -798,10 +798,10 @@ test_expect_failure SYMLINKS 'rm across a symlinked l=
eading path (w/ index)' '
 	git commit -m "d/f exists" &&
 	mv d e &&
 	ln -s e d &&
-	test_must_fail git rm d/f &&
-	git rev-parse --verify :d/f &&
+	test_todo test_must_fail git rm d/f &&
+	test_todo git rev-parse --verify :d/f &&
 	test -h d &&
-	test_path_is_file e/f
+	test_todo test_path_is_file e/f
 '
=20
 test_expect_success 'setup for testing rm messages' '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ad5c0292794..a6a5a330180 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -165,12 +165,12 @@ test_expect_success 'additional command line cc (asci=
i)' '
 	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
 '
=20
-test_expect_failure 'additional command line cc (rfc822)' '
+test_expect_todo 'additional command line cc (rfc822)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@exampl=
e.com>" &&
 	git format-patch --cc=3D"S. E. Cipient <scipient@example.com>" --stdout m=
ain..side >patch5 &&
 	sed -e "/^\$/q" patch5 >hdrs5 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
-	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
+	test_todo grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
 '
=20
 test_expect_success 'command line headers' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f342954de11..9d5706454a5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1049,6 +1049,21 @@ test_must_fail_acceptable () {
 	esac
 }
=20
+test_todo () {
+	local negate=3D-ne
+	local cmp_op=3D-ne
+	if test "$1" =3D "!"
+	then
+		negate=3Dt &&
+		cmp_op=3D-eq
+		shift
+	fi &&
+	"$@" 2>&7
+	exit_code=3D$?
+	say "test_todo: got $exit_code ${negate:+negated!} from $*"
+	test "$exit_code" "$cmp_op" 0
+}
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #


