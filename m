Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8813C433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 15:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbiCTPPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiCTPPF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 11:15:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6743151C
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 08:13:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so16714572wru.4
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lDXNpQQ1KuwFfHnQM2rs19vrGjK0syV1vlbo4r938gQ=;
        b=fe1aZYUYKoHhRmiZVUduSNrOQIgskVZAj1uqOer2qxwQVvnW9YNgUoX658zcC4mz1S
         cBbzaZoR2FoIUd04gMNLL36Ye76lyEdPjbXpdNGtZhsXyPAm0Vi5k3v2atK5dJBTTWdi
         5Z3ltKFaJMLawRqPh0Sb3khHK6UL2ihxP2tzri4S0o2sG7M8bAEHThNGJYrGBh4wb1lX
         O2cALRZvk4JQO9XvTQwuDAnmG3NbUGIy8oKo8kfLekSj09QhHj8VkvJHwDW22oSjkc9G
         /GC3LZjstNsNrXf/rBLWmFChqN65z5rQX5HyBeBqC7nhUYUikRyx/AQE43DS0KNH9vNm
         dn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lDXNpQQ1KuwFfHnQM2rs19vrGjK0syV1vlbo4r938gQ=;
        b=KTi9ijMTpe+YdTdvI5ZJbGVjhgsoNYjByF3ovCtRrNxa6So1GnLEMXQTGvWhK0dvO0
         6PnF0MT1ZLHXiYiUh3JJ8mH3GZi2aggtzNldzymEwZ93a6SGPd2lRrpKa7s1V2yE+QVc
         7z4ZsDEoz7cQKlwZIEfycCyCmn1pWLxsNg6NzA3H/BjKe80icF6bq2VHakYzacvf/2MZ
         2xmdnJe69/FxKjhP0I2T44Bhsbj0zwb0VwZ9Kfo55Ll9r72aL7VrpQc1/pjz26ajW6EJ
         LJYLl6tpaRjIKsmhoYMv+/++TDtvBWApRNT6Ajc9z5lBBX/d3iWgUJ2uR/bMJtgLltNh
         GrdA==
X-Gm-Message-State: AOAM532E6iDQ6QFbmenPhtGxcgYnRsqtO+GR7hKUvwVRxltOxZrqOb2K
        5U7c85Ot0IDG5c+v5tGG6qo=
X-Google-Smtp-Source: ABdhPJzZQAgAuEr7f25rTjvkSYZ49CFgH+v94S6ZK/U/lmk2pFzbOk/u8HIDlEajBBXsZd6X7ZnT1Q==
X-Received: by 2002:a05:6000:1549:b0:203:f11a:ac4c with SMTP id 9-20020a056000154900b00203f11aac4cmr11580598wry.233.1647789219887;
        Sun, 20 Mar 2022 08:13:39 -0700 (PDT)
Received: from [192.168.1.240] (203.2.7.51.dyn.plus.net. [51.7.2.203])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d548c000000b001f1f99e7792sm10835948wrv.111.2022.03.20.08.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 08:13:39 -0700 (PDT)
Message-ID: <db558292-2783-3270-4824-43757822a389@gmail.com>
Date:   Sun, 20 Mar 2022 15:13:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
 <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
 <xmqqczij9jeg.fsf@gitster.g> <xmqq8rt77zp7.fsf@gitster.g>
 <220319.86v8waetae.gmgdl@evledraar.gmail.com> <xmqqilsa76ve.fsf@gitster.g>
 <220319.86ilsadw69.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220319.86ilsadw69.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 19/03/2022 11:11, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Mar 19 2022, Junio C Hamano wrote:
>[...] 
>>> I don't think we can categorically replace all of the
>>> "test_expect_failure" cases, because in some of those it's too much of a
>>> hassle to assert the exact current behavior, or we don't really care.
>>>
>>> But I think for most cases instead of a:
>>>
>>> 	test_ki ! grep unwanted output
>>>
>>> It makes more sense to do (as that helper does):
>>>
>>> 	test_todo grep --want yay --expect unwanted -- output
>>
>> My take is the complete opposite.  We can and should start small,
>> and how exactly the current implementation happens to be broken does
>> not matter most of the time.
> 
> Well, the tip of this series leaves ~20 uses of test_expect_todo v.s. a
> remaining ~100 uses of test_expect_failure, so it is a small start. I
> converted those things I thought made the most sense.
> 
> But I do think you want to test at least a fuzzy "how exactly" most of
> the time. The reason I worked on this was because while authoring the
> series you merged in ea05fd5fbf7 (Merge branch
> 'ab/keep-git-exit-codes-in-tests', 2022-03-16) I found that we had
> various test_expect_failure that failed in ways very different than what
> we'd expect.
> 
> Or, saying that something exits non-zero and we'd like to fix it isn't
> the same as saying that we'd like to e.g. exclude it from SANITIZE=leak
> or SANITIZE=address testing. I.e. it still shouldn't leak, double-free()
> or run into a BUG(), and if it does we'd like to know most of the time.

I think having test_todo based on test_must_fail as Junio
suggested avoids this as it means the test will still fail on SIGSEV
or SIGABRT (if we don't already do so we can make LSAN exit with the
same code as vargrind which test_must_fail checks for). I had a look
at some of the conversions with your test_todo --want/--expect/--reset
and found the result really hard to follow. Junio's suggestions chimed
with some things I've been thinking about so I had a go at
implementing it and doing some sample conversions (see below). Marking
the individual commands that should fail is a big step forward and the
failing commands are checked to make sure they don't segfault etc.

Best Wishes

Phillip

---- >8 -----
  t/t0000-basic.sh                |   9 +++++--
  t/t3401-rebase-and-am-rename.sh |  12 +++++-----
  t/t3424-rebase-empty.sh         |   6 ++---
  t/t4014-format-patch.sh         |  20 ++++++++--------
  t/test-lib-functions.sh         | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
  5 files changed, 116 insertions(+), 61 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b007f0efef..53217d4cd5 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -103,16 +103,21 @@ test_expect_success 'subtest: 2/3 tests passing' '
  
  test_expect_success 'subtest: a failing TODO test' '
  	write_and_run_sub_test_lib_test failing-todo <<-\EOF &&
+	test_false () {
+		false
+	}
  	test_expect_success "passing test" "true"
  	test_expect_failure "pretend we have a known breakage" "false"
+	test_expect_success "known todo" "test_todo test_false"
  	test_done
  	EOF
  	check_sub_test_lib_test failing-todo <<-\EOF
  	> ok 1 - passing test
  	> not ok 2 - pretend we have a known breakage # TODO known breakage
-	> # still have 1 known breakage(s)
+	> not ok 3 - known todo # TODO known breakage
+	> # still have 2 known breakage(s)
  	> # passed all remaining 1 test(s)
-	> 1..2
+	> 1..3
  	EOF
  '
  
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index f18bae9450..cc5da9f5af 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -52,7 +52,7 @@ test_expect_success 'rebase --interactive: directory rename detected' '
  	)
  '
  
-test_expect_failure 'rebase --apply: directory rename detected' '
+test_expect_success 'rebase --apply: directory rename detected' '
  	(
  		cd dir-rename &&
  
@@ -63,8 +63,8 @@ test_expect_failure 'rebase --apply: directory rename detected' '
  		git ls-files -s >out &&
  		test_line_count = 5 out &&
  
-		test_path_is_file y/d &&
-		test_path_is_missing x/d
+		test_todo test_path_is_file y/d &&
+		test_todo test_path_is_missing x/d
  	)
  '
  
@@ -84,7 +84,7 @@ test_expect_success 'rebase --merge: directory rename detected' '
  	)
  '
  
-test_expect_failure 'am: directory rename detected' '
+test_expect_success 'am: directory rename detected' '
  	(
  		cd dir-rename &&
  
@@ -97,8 +97,8 @@ test_expect_failure 'am: directory rename detected' '
  		git ls-files -s >out &&
  		test_line_count = 5 out &&
  
-		test_path_is_file y/d &&
-		test_path_is_missing x/d
+		test_todo test_path_is_file y/d &&
+		test_todo test_path_is_missing x/d
  	)
  '
  
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 5e1045a0af..b7cae26075 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -34,15 +34,15 @@ test_expect_success 'setup test repository' '
  	git commit -m "Five letters ought to be enough for anybody"
  '
  
-test_expect_failure 'rebase (apply-backend)' '
-	test_when_finished "git rebase --abort" &&
+test_expect_success 'rebase (apply-backend)' '
+	test_when_finished "test_might_fail git rebase --abort" &&
  	git checkout -B testing localmods &&
  	# rebase (--apply) should not drop commits that start empty
  	git rebase --apply upstream &&
  
  	test_write_lines D C B A >expect &&
  	git log --format=%s >actual &&
-	test_cmp expect actual
+	test_todo test_cmp expect actual
  '
  
  test_expect_success 'rebase --merge --empty=drop' '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7dc5a5c736..bb0fcef40e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -165,12 +165,12 @@ test_expect_success 'additional command line cc (ascii)' '
  	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
  '
  
-test_expect_failure 'additional command line cc (rfc822)' '
+test_expect_success 'additional command line cc (rfc822)' '
  	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
  	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout main..side >patch5 &&
  	sed -e "/^\$/q" patch5 >hdrs5 &&
  	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
-	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
+	test_todo grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
  '
  
  test_expect_success 'command line headers' '
@@ -195,16 +195,16 @@ test_expect_success 'command line To: header (ascii)' '
  	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs8
  '
  
-test_expect_failure 'command line To: header (rfc822)' '
+test_expect_success 'command line To: header (rfc822)' '
  	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
  	sed -e "/^\$/q" patch8 >hdrs8 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
+	test_todo grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
  '
  
-test_expect_failure 'command line To: header (rfc2047)' '
+test_expect_success 'command line To: header (rfc2047)' '
  	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
  	sed -e "/^\$/q" patch8 >hdrs8 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
+	test_todo grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
  '
  
  test_expect_success 'configuration To: header (ascii)' '
@@ -214,18 +214,18 @@ test_expect_success 'configuration To: header (ascii)' '
  	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs9
  '
  
-test_expect_failure 'configuration To: header (rfc822)' '
+test_expect_success 'configuration To: header (rfc822)' '
  	git config format.to "R. E. Cipient <rcipient@example.com>" &&
  	git format-patch --stdout main..side >patch9 &&
  	sed -e "/^\$/q" patch9 >hdrs9 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
+	test_todo grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
  '
  
-test_expect_failure 'configuration To: header (rfc2047)' '
+test_expect_success 'configuration To: header (rfc2047)' '
  	git config format.to "R Ä Cipient <rcipient@example.com>" &&
  	git format-patch --stdout main..side >patch9 &&
  	sed -e "/^\$/q" patch9 >hdrs9 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
+	test_todo grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
  '
  
  # check_patch <patch>: Verify that <patch> looks like a half-sane
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0f439c99d6..deb74a22f3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -739,6 +739,7 @@ test_expect_failure () {
  }
  
  test_expect_success () {
+	test_todo_=
  	test_start_
  	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
  	test "$#" = 2 ||
@@ -750,7 +751,12 @@ test_expect_success () {
  		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
  		if test_run_ "$2"
  		then
-			test_ok_ "$1"
+			if test -n "$test_todo_"
+			then
+				test_known_broken_failure_ "$1"
+			else
+				test_ok_ "$1"
+			fi
  		else
  			test_failure_ "$@"
  		fi
@@ -1011,8 +1017,20 @@ list_contains () {
  # Returns success if the arguments indicate that a command should be
  # accepted by test_must_fail(). If the command is run with env, the env
  # and its corresponding variable settings will be stripped before we
+# we test the command being run.
+#
+# For test_todo we allow a wider range of commands to and if the
+# command is run with verbose then verbose will be stripped before we
  # test the command being run.
+
  test_must_fail_acceptable () {
+	local name
+	name="$1"
+	shift
+	if test "$name" = "todo" && test "$1" = "verbose"
+	then
+		shift
+	fi
  	if test "$1" = "env"
  	then
  		shift
@@ -1033,44 +1051,22 @@ test_must_fail_acceptable () {
  	git|__git*|test-tool|test_terminal)
  		return 0
  		;;
+	grep|test|test_*)
+		if test "$name" = "todo"
+		then
+		    return 0
+		fi
+		return 1
+		;;
  	*)
  		return 1
  		;;
  	esac
  }
  
-# This is not among top-level (test_expect_success | test_expect_failure)
-# but is a prefix that can be used in the test script, like:
-#
-#	test_expect_success 'complain and die' '
-#           do something &&
-#           do something else &&
-#	    test_must_fail git checkout ../outerspace
-#	'
-#
-# Writing this as "! git checkout ../outerspace" is wrong, because
-# the failure could be due to a segv.  We want a controlled failure.
-#
-# Accepts the following options:
-#
-#   ok=<signal-name>[,<...>]:
-#     Don't treat an exit caused by the given signal as error.
-#     Multiple signals can be specified as a comma separated list.
-#     Currently recognized signal names are: sigpipe, success.
-#     (Don't use 'success', use 'test_might_fail' instead.)
-#
-# Do not use this to run anything but "git" and other specific testable
-# commands (see test_must_fail_acceptable()).  We are not in the
-# business of vetting system supplied commands -- in other words, this
-# is wrong:
-#
-#    test_must_fail grep pattern output
-#
-# Instead use '!':
-#
-#    ! grep pattern output
-
-test_must_fail () {
+test_must_fail_helper () {
+	test_must_fail_name_="$1"
+	shift
  	case "$1" in
  	ok=*)
  		_test_ok=${1#ok=}
@@ -1080,36 +1076,90 @@ test_must_fail () {
  		_test_ok=
  		;;
  	esac
-	if ! test_must_fail_acceptable "$@"
+	if ! test_must_fail_acceptable $test_must_fail_name_ "$@"
  	then
-		echo >&7 "test_must_fail: only 'git' is allowed: $*"
+		echo >&7 "test_$test_must_fail_name_: only 'git' is allowed: $*"
  		return 1
  	fi
  	"$@" 2>&7
  	exit_code=$?
  	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
  	then
-		echo >&4 "test_must_fail: command succeeded: $*"
+		echo >&4 "test_$test_must_fail_name_: command succeeded: $*"
  		return 1
  	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
  	then
  		return 0
  	elif test $exit_code -gt 129 && test $exit_code -le 192
  	then
-		echo >&4 "test_must_fail: died by signal $(($exit_code - 128)): $*"
+		echo >&4 "test_$test_must_fail_name_: died by signal $(($exit_code - 128)): $*"
  		return 1
  	elif test $exit_code -eq 127
  	then
-		echo >&4 "test_must_fail: command not found: $*"
+		echo >&4 "test_$test_must_fail_name_: command not found: $*"
  		return 1
  	elif test $exit_code -eq 126
  	then
-		echo >&4 "test_must_fail: valgrind error: $*"
+		echo >&4 "test_$test_must_fail_name_: valgrind error: $*"
  		return 1
  	fi
  	return 0
  } 7>&2 2>&4
  
+# This is used to mark commands that should succeed but do not due to
+# a known issue. Marking the individual commands that fail rather than
+# using test_expect_failure allows us to detect any unexpected
+# failures. As with test_must_fail if the command is killed by a
+# signal the test will fail. If the command unexpectedly succeeds then
+# the test fails. For example:
+#
+#	test_expect_success 'test a known failure' '
+#		git foo 2>err &&
+#		test_todo test_must_be_empty err
+#	'
+#
+# This test will fail if "git foo" fails or err is unexpectedly empty
+
+test_todo () {
+	test_todo_=todo
+	test_must_fail_helper todo "$@" 2>&7
+} 7>&2 2>&4
+
+# This is not among top-level (test_expect_success | test_expect_failure)
+# but is a prefix that can be used in the test script, like:
+#
+#	test_expect_success 'complain and die' '
+#           do something &&
+#           do something else &&
+#	    test_must_fail git checkout ../outerspace
+#	'
+#
+# Writing this as "! git checkout ../outerspace" is wrong, because
+# the failure could be due to a segv.  We want a controlled failure.
+#
+# Accepts the following options:
+#
+#   ok=<signal-name>[,<...>]:
+#     Don't treat an exit caused by the given signal as error.
+#     Multiple signals can be specified as a comma separated list.
+#     Currently recognized signal names are: sigpipe, success.
+#     (Don't use 'success', use 'test_might_fail' instead.)
+#
+# Do not use this to run anything but "git" and other specific testable
+# commands (see test_must_fail_acceptable()).  We are not in the
+# business of vetting system supplied commands -- in other words, this
+# is wrong:
+#
+#    test_must_fail grep pattern output
+#
+# Instead use '!':
+#
+#    ! grep pattern output
+
+test_must_fail () {
+	test_must_fail_helper must_fail "$@" 2>&7
+} 7>&2 2>&4
+
  # Similar to test_must_fail, but tolerates success, too.  This is
  # meant to be used in contexts like:
  #
@@ -1124,7 +1174,7 @@ test_must_fail () {
  # Accepts the same options as test_must_fail.
  
  test_might_fail () {
-	test_must_fail ok=success "$@" 2>&7
+	test_must_fail_helper might_fail ok=success "$@" 2>&7
  } 7>&2 2>&4
  
  # Similar to test_must_fail and test_might_fail, but check that a
