Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D93C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 15:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiJFPwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJFPwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 11:52:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E321A98F2
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 08:52:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y100so3447593ede.6
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cogn/xkG9LLMj4BmrUTClRriNlaHx+iVWgaZ3lffW0=;
        b=HneU5ff0n/I6XAeNdLlJR6WDPTASkQAEeIYJWxFvTos/iL1X2OhtyzVO0VSslvgxmW
         0maJZyXlrtGtGAgl8Pm3vSBYKPlgOvyH3lGzjdwSkbZXhcTshzQmjWHZuHfHVhb9SAY1
         i2LJ6U4V9qItOAeovrHGQL3AeK+yLDeIs+pMTyp0cdc6bYEqaPqG58+epFoPZEbCINgY
         WPKzkKPT+KVWUa35LPDmUZMlyOik6kvtYGyL0/x38loSOAB08Ru5L/VZ5XKHnR4pZLYW
         1EOmol/sblNxZAWkvW4q1FhJAx15ufXKaH9bMlsEH3IRkJkPYHj96c4LWgpKkK5znlrF
         gRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cogn/xkG9LLMj4BmrUTClRriNlaHx+iVWgaZ3lffW0=;
        b=4dkjLoVxLg1yaIupoGLj4QVIYy9LCCaML8BEivAmpKUpchQueywXxS8dczCFKGICYi
         Lwi02bY6Vhpc94q4yB1EZHZCqRK57TY/0rkVG0vTJU4rJVZKGAVpyWr8yrk84z2schqq
         l1qJCaBV7jTPsyrit1OVqDlx6F7LJ2bIJwwk8gL/MVxLUCTuuT+Y/cgYv60e4VvyvzTO
         7wPlj33pNdWxoO+Bvv7HtDDzXW62bbl59RrFMTBfVOwugZIwHv4BSkyL+xj9Cs36u4jc
         Th6fQVaz7mHIewnVR3OP/zkNmgTyDGaz9SOfD4JmqLX/89TumkOoOXdhed+eY/MCX3Py
         0QXw==
X-Gm-Message-State: ACrzQf3QjeBsqxpVGTXrj99TcJue5pGoGM/UHnNVgRX/eV3PqwOWfOK9
        BDWEk0/F6/PbEhhGYCCe+fiza16Yn6Y=
X-Google-Smtp-Source: AMsMyM43NYgqgkJg5MQbFA3Xm9VWau62hqJBopPkiuBHqH/YbFxHgs7jGBrKKCgDHvHuRNGp4lzmGw==
X-Received: by 2002:aa7:c607:0:b0:458:fe72:4756 with SMTP id h7-20020aa7c607000000b00458fe724756mr380020edq.423.1665071553546;
        Thu, 06 Oct 2022 08:52:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906670f00b0078258a26667sm10529743ejp.52.2022.10.06.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:52:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogTAj-002xAq-0i;
        Thu, 06 Oct 2022 17:52:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
Date:   Thu, 06 Oct 2022 17:36:35 +0200
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
Message-ID: <221006.868rltrltu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> test_todo() is intended as a fine grained replacement for
> test_expect_failure(). Rather than marking the whole test as failing
> test_todo() is used to mark individual failing commands within a
> test. This approach to writing failing tests allows us to detect
> unexpected failures that are hidden by test_expect_failure().
>
> Failing commands are reported by the test harness in the same way as
> test_expect_failure() so there is no change in output when migrating
> from test_expect_failure() to test_todo(). If a command marked with
> test_todo() succeeds then the test will fail. This is designed to make
> it easier to see when a command starts succeeding in our CI compared
> to using test_expect_failure() where it is easy to fix a failing test
> case and not realize it.
>
> test_todo() is built upon test_expect_failure() but accepts commands
> starting with test_* in addition to git. As our test_* assertions use
> BUG() to signal usage errors any such error will not be hidden by
> test_todo().

I think they will, unless I'm missing something. E.g. try out:
	
	diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
	index 80e76a4695e..1be895abba6 100755
	--- a/t/t0210-trace2-normal.sh
	+++ b/t/t0210-trace2-normal.sh
	@@ -170,7 +170,7 @@ test_expect_success 'BUG messages are written to trace2' '
	 
	 test_expect_success 'bug messages with BUG_if_bug() are written to trace2' '
	 	test_when_finished "rm trace.normal actual expect" &&
	-	test_expect_code 99 env GIT_TRACE2="$(pwd)/trace.normal" \
	+	test_todo env GIT_TRACE2="$(pwd)/trace.normal" \
	 		test-tool trace2 008bug 2>err &&
	 	cat >expect <<-\EOF &&
	 	a bug message

I.e. in our tests you need to look out for exit code 99, not the usual
abort().

I have local patches to fix this, previously submitted as an RFC here:
https://lore.kernel.org/git/RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com/

I just rebased that & CI is currently running, I'll see how it does:
https://github.com/avar/git/tree/avar/usage-do-not-abort-on-BUG-to-get-trace2-event-2

When I merged your patches here with that topic yours started doing the
right thing in this case, i.e. a "test_todo" that would get a BUG()"
would be reported as a failure.

> +	test_true () {
> +		true
> +	}
> +	test_expect_success "pretend we have fixed a test_todo breakage" \
> +		"test_todo test_true"

"Why the indirection", until I realized that it's because you're working
around the whitelist of commands that we have, i.e. we allow 'git' and
'test-tool', but not 'grep' or whatever.

I'm of the opinion that we should just drop that limitation altogether,
which is shown to be pretty silly in this case. I.e. at some point we
listed "test_*" as "this invokes a git binary", but a lot of our test_*
commands don't, including this one.

So in general I think we should just allow any command in
"test_must_fail" et al, and just catch in code review if someone uses
"test_must_fail grep" as opposed to "! grep".

But for the particular case of "test_todo" doing so seems like pointless
work, if we think we're going to miss this sort of thing in review in
general, then surely that's not a concern if we're going to very
prominently mark tests as TODO tests, given how the test of the output
shows them?

> +test_must_fail_helper () {
> +	test_must_fail_name_="$1"
> +	shift
> +	case "$1" in
> +	ok=*)
> +		_test_ok=${1#ok=}
> +		shift
> +		;;
> +	*)
> +		_test_ok=
> +		;;
> +	esac
> +	if ! test_must_fail_acceptable $test_must_fail_name_ "$@"
> +	then
> +		echo >&7 "test_$test_must_fail_name_: only 'git' is allowed: $*"
> +		return 1
> +	fi
> +	"$@" 2>&7
> +	exit_code=$?
> +	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
> +	then
> +		echo >&4 "test_$test_must_fail_name_: command succeeded: $*"
> +		return 1
> +	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
> +	then
> +		return 0
> +	elif test $exit_code -gt 129 && test $exit_code -le 192
> +	then
> +		echo >&4 "test_$test_must_fail_name_: died by signal $(($exit_code - 128)): $*"
> +		return 1
> +	elif test $exit_code -eq 127
> +	then
> +		echo >&4 "test_$test_must_fail_name_: command not found: $*"
> +		return 1
> +	elif test $exit_code -eq 126
> +	then
> +		echo >&4 "test_$test_must_fail_name_: valgrind error: $*"
> +		return 1
> +	fi
> +
> +	return 0
> +} 7>&2 2>&4
> +
> +# This is used to mark commands that should succeed but do not due to
> +# a known issue. Marking the individual commands that fail rather than
> +# using test_expect_failure allows us to detect any unexpected
> +# failures. As with test_must_fail if the command is killed by a
> +# signal the test will fail. If the command unexpectedly succeeds then
> +# the test will also fail. For example:
> +#
> +#	test_expect_success 'test a known failure' '
> +#		git foo 2>err &&
> +#		test_todo test_must_be_empty err
> +#	'
> +#
> +# This test will fail if "git foo" fails or err is unexpectedly empty.
> +# test_todo can be used with "git" or any of the "test_*" assertions
> +# such as test_cmp().
> +
> +test_todo () {
> +	if test "$test_todo_" = "test_expect_failure"
> +	then
> +		BUG "test_todo_ cannot be used inside test_expect_failure"
> +	fi
> +	test_todo_=todo
> +	test_must_fail_helper todo "$@" 2>&7
> +} 7>&2 2>&4
> +
>  # This is not among top-level (test_expect_success | test_expect_failure)
>  # but is a prefix that can be used in the test script, like:
>  #
> @@ -1061,43 +1160,7 @@ test_must_fail_acceptable () {
>  #    ! grep pattern output
>  
>  test_must_fail () {
> -	case "$1" in
> -	ok=*)
> -		_test_ok=${1#ok=}
> -		shift
> -		;;
> -	*)
> -		_test_ok=
> -		;;
> -	esac
> -	if ! test_must_fail_acceptable "$@"
> -	then
> -		echo >&7 "test_must_fail: only 'git' is allowed: $*"
> -		return 1
> -	fi
> -	"$@" 2>&7
> -	exit_code=$?
> -	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
> -	then
> -		echo >&4 "test_must_fail: command succeeded: $*"
> -		return 1
> -	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
> -	then
> -		return 0
> -	elif test $exit_code -gt 129 && test $exit_code -le 192
> -	then
> -		echo >&4 "test_must_fail: died by signal $(($exit_code - 128)): $*"
> -		return 1
> -	elif test $exit_code -eq 127
> -	then
> -		echo >&4 "test_must_fail: command not found: $*"
> -		return 1
> -	elif test $exit_code -eq 126
> -	then
> -		echo >&4 "test_must_fail: valgrind error: $*"
> -		return 1
> -	fi
> -	return 0
> +	test_must_fail_helper must_fail "$@" 2>&7
>  } 7>&2 2>&4
>  
>  # Similar to test_must_fail, but tolerates success, too.  This is
> @@ -1114,7 +1177,7 @@ test_must_fail () {
>  # Accepts the same options as test_must_fail.
>  
>  test_might_fail () {
> -	test_must_fail ok=success "$@" 2>&7
> +	test_must_fail_helper might_fail ok=success "$@" 2>&7
>  } 7>&2 2>&4
>  
>  # Similar to test_must_fail and test_might_fail, but check that a

I remember finding it annoying that "test_might_fail" is misreported
from test_must_fail_acceptable as being called "test_must_fail", so this
refactoring is very welcome.

But can you please split this into its own commit? I.e. that improvement
can stand on its own, i.e. just a change that has "test_must_fail" and
"test_might_fail" reporting their correct name.

Then this commit can follow, and then you'll just need to add (for this part):

	test_must_fail_helper todo "$@" 2>&7

And it'll make the resulting diff much smaller & easier to follow.
