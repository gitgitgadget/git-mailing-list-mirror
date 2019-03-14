Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4956C20248
	for <e@80x24.org>; Thu, 14 Mar 2019 03:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCNDVG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 23:21:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51670 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCNDVF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 23:21:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id n19so1334257wmi.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 20:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=U5VBNIWRFiLPyj/t4Tew9Mt71FaL9cy7RUxybnC0Gec=;
        b=H3uPL5ybwqgyKR9Lih8noYy95vv1TlLEOyLshYGzUsH3BV3fK9515yJVb6H/x2vM0l
         irBFKJYS+ne8pi3QCAHTJ0ntE/oQngK+K/CvHHlCLQfrAisYqp/PtBfAaHf10FmXshiz
         bnUjT+4ppmfUVmme3iW5o4RTg6nwnslmwg9NKsBrhX+MVXvUQMQVYgglY5OOJ/CkAU9q
         oS/yGppZYqDQzLhFFWNyqP+4FNfoXi0wLUHYqmAV6YR3KChXCvljZ+o7mYnnNs35b/8r
         4IJx0WdXKOtTVjmL43fzsoY2LYj7gEEob9oMy2RhyPoaHdzEovNmkTmxzpwrfO0krZom
         e0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=U5VBNIWRFiLPyj/t4Tew9Mt71FaL9cy7RUxybnC0Gec=;
        b=FkHg5e+h5h6XuydTol6ukN6e62CqnKZZ+YeN6ENRD0G99hq93CYViQaPtDmxtP5j5G
         QkJn+i3WbcMWJIaukoV6mrk+2CNHfhNTDJSWJUq5rKNM10Jwvg2TQSZmQySVDIHvyJYh
         wgQ3A9dpNmai6L50sQgWAyIary1ZFQvcfV9tFa+B5iO9owi6jlNeWYPbJsInqV9CAUEy
         0Lj7ToQsgMbc6Ioa602/X/kGygPHXK7LTksh48MgJRgCoapFiQm6VEnn02IQdy3UbCaY
         nX4sH2Vi0WiKiknUgODR45Ng5VpntgxVPGyxqCUbJUY0nECLHTtc/Hrja8mzlZEiSnd4
         PpOg==
X-Gm-Message-State: APjAAAUWleqDAIAMflHIvB4oVOG4AE04gfTypi71Vu3s32rx4TsscnfO
        8l0ptkkGMvRqWeRWimgLvFM=
X-Google-Smtp-Source: APXvYqwcQOG7EHL7LEYWgpnqIySgrqzeriuZAKb5LhPrzCU0EGvpq7zIJ4G1VZ/XGFarBeaSStV6SQ==
X-Received: by 2002:a7b:cb48:: with SMTP id v8mr775788wmj.138.1552533662188;
        Wed, 13 Mar 2019 20:21:02 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 93sm24942637wrh.15.2019.03.13.20.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 20:21:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 03/11] test-lib: introduce 'test_atexit'
References: <20190313122419.2210-1-szeder.dev@gmail.com>
        <20190313122419.2210-4-szeder.dev@gmail.com>
Date:   Thu, 14 Mar 2019 12:21:00 +0900
In-Reply-To: <20190313122419.2210-4-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 13 Mar 2019 13:24:11 +0100")
Message-ID: <xmqqh8c6b0pv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> +test_atexit () {
> +	# We cannot detect when we are in a subshell in general, but by
> +	# doing so on Bash is better than nothing (the test will
> +	# silently pass on other shells).
> +	test "${BASH_SUBSHELL-0}" = 0 ||
> +	error "bug in test script: test_atexit does nothing in a subshell"
> +	test_atexit_cleanup="{ $*
> +		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
> +}

This chaining is modelled after how $test_cleaup is built and
maintained by test_when_finished.  Use of eval_ret makes sense in
that original context as eval_ret _is_ used to keep track of the
result of 'test_eval_ "$1"' in test_run_ that executed the body
of a single test_expect_$something, and $test_cleanup would want to
keep the resulting status from that body when clean-up succeeds (or
otherwise, make that failure to clean-up visible as $eval_ret).

But does it make sense in the context of the whole test script to
try maintaining $eval_ret?

>  # Most tests can use the created repository, but some may need to create more.
>  # Usage: test_create_repo <directory>
>  test_create_repo () {
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index db3875d1e4..b35881696f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -620,6 +620,10 @@ test_external_has_tap=0
>  
>  die () {
>  	code=$?
> +	# This is responsible for running the atexit commands even when a
> +	# test script run with '--immediate' fails, or when the user hits
> +	# ctrl-C, i.e. when 'test_done' is not invoked at all.
> +	test_atexit_handler || code=$?
>  	if test -n "$GIT_EXIT_OK"
>  	then
>  		exit $code
> @@ -1045,9 +1049,28 @@ write_junit_xml_testcase () {
>  	junit_have_testcase=t
>  }
>  
> +test_atexit_cleanup=:
> +test_atexit_handler () {
> +	# In a succeeding test script 'test_atexit_handler' is invoked
> +	# twice: first from 'test_done', then from 'die' in the trap on
> +	# EXIT.

We are guaranteed to still have the trash directory when we are run
in the exit handler after getting interrupted or test_failure_()
exits under the "-i" option, and when test_done() calls us.  What
will cause us trouble is the exit handler at the end of a successful
run after test_done() finishes.  At that point, test_done would have
already cleared the trash directory, so we may not have enough state
to allow us to clean-up at exit.

Clearing the exit trap in test_done after it calls us might be an
alternative, but I think it is equivalent to clearing the
test_atexit_cleanup variable, and it is cleaner, so I think I agree
with the approach this patch uses.

> +	# This condition and resetting 'test_atexit_cleanup' below makes
> +	# sure that the registered cleanup commands are run only once.
> +	test : != "$test_atexit_cleanup" || return 0

I think test_when_finished uses a special value in $test_cleanup in
a similar way but it even skips when there is no point doing the
test_eval_ of the "accumulated" scriptlet when it is empty.

Shouldn't we be doing the same thing, i.e.

	if test -z "$test_atexit_cleanup"
	then
		return 0
	fi
	... do the heavy lifting ...
	test_atexit_cleanup=

That will make the handler truly a no-op when there is no atexit
defined.

> +	setup_malloc_check
> +	test_eval_ "$test_atexit_cleanup"
> +	test_atexit_cleanup=:
> +	teardown_malloc_check
> +}
> +
>  test_done () {
>  	GIT_EXIT_OK=t
>  
> +	# Run the atexit commands _before_ the trash directory is
> +	# removed, so the commands can access pidfiles and socket files.
> +	test_atexit_handler
> +
>  	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
>  	then
>  		test -n "$junit_have_testcase" || {
