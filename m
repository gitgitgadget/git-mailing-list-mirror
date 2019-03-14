Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B78920248
	for <e@80x24.org>; Thu, 14 Mar 2019 17:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCNRka (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 13:40:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44953 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCNRka (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 13:40:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id w2so6774064wrt.11
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yr5EOEy+2Ho30DUcF2NQtpeu5N+9DtTn3E3WYHxn9rc=;
        b=KAkVuGGE7IPdJsKgHVAyeQPY64yYxM9TwYbujwzW9YgX5rS/TTPZ5jsznySV0IVa1+
         48koQyOzfl1fzN66giFZwvCIgEGg3jbkTka723QdYzTXWfjr9W7S9rfqIE+bMHCgZFRT
         YpitOVWFWKvUb8le8ZknAu49rPvYK9fIpV177Nv1vjT9gb9dMKOO+TAhCiQoQllz6mDI
         yMFh8zehB4VpMqcu2YMVPDhQ9WGyXLjEz2uMpYTQB0QgLUcE9HHK5VcqtFuge/ebq3BZ
         kP+RweFLubEccITVqUMjDOK/amBdJvrXgRTT7s9B8A3So482R8Fu8AgYY2Q+fOT+Ak8/
         beTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yr5EOEy+2Ho30DUcF2NQtpeu5N+9DtTn3E3WYHxn9rc=;
        b=qg+d6hfTbkl4RJ/uJgfiQrYNEMPPyTjYnnSW5NTIwawt9Ox+EVlH27HDfCJz2aFJ5B
         4UUjCOcUvvgKWw7pWXc6yXnsbt1Z+8cNvgn9X0NWCSTvxh1RX/HiPebSI7ywRsb7OxLP
         PbfFlFGfqpwv+rCKPNc8+1gg6wL5ddjUiBJz6+TB/o7Nh7y/s6g6QsvnWdLUpliTrkSe
         wpHMNLhJG0RtAco5QS570tShh/Gcb7wAvIwfjoMOsbIMwb9rsgvSv73WhwQfjeLZ7zW3
         MAbWfuF6n9RTD0KbSyG3KfGyf7i2wjgX7TuwWHQp4Z/+l/CdmlVBsg2MD4/ot+l4XqCv
         Fg2g==
X-Gm-Message-State: APjAAAVpHxmsmfg3w3Jl5u/gAZ+FP6m5Xk6n0gXBuAwtBHIgG8FJf+Nm
        Wio89R/4YG2WigiFABplJ/4=
X-Google-Smtp-Source: APXvYqzoVu1IyrmOI0hzqU+0dTc4aH8tO0Y0BuFp1rTPrD2VdLDfuBqwLpTCGZtF90tV3DbWCe/O/Q==
X-Received: by 2002:a5d:45c8:: with SMTP id b8mr13733994wrs.3.1552585227869;
        Thu, 14 Mar 2019 10:40:27 -0700 (PDT)
Received: from szeder.dev (x4d0c0ea6.dyn.telefonica.de. [77.12.14.166])
        by smtp.gmail.com with ESMTPSA id y63sm2459615wmb.31.2019.03.14.10.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 10:40:27 -0700 (PDT)
Date:   Thu, 14 Mar 2019 18:40:24 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 03/11] test-lib: introduce 'test_atexit'
Message-ID: <20190314174024.GH28939@szeder.dev>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
 <20190313122419.2210-4-szeder.dev@gmail.com>
 <xmqqh8c6b0pv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh8c6b0pv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:21:00PM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > +test_atexit () {
> > +	# We cannot detect when we are in a subshell in general, but by
> > +	# doing so on Bash is better than nothing (the test will
> > +	# silently pass on other shells).
> > +	test "${BASH_SUBSHELL-0}" = 0 ||
> > +	error "bug in test script: test_atexit does nothing in a subshell"
> > +	test_atexit_cleanup="{ $*
> > +		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
> > +}
> 
> This chaining is modelled after how $test_cleaup is built and
> maintained by test_when_finished.  Use of eval_ret makes sense in
> that original context as eval_ret _is_ used to keep track of the
> result of 'test_eval_ "$1"' in test_run_ that executed the body
> of a single test_expect_$something, and $test_cleanup would want to
> keep the resulting status from that body when clean-up succeeds (or
> otherwise, make that failure to clean-up visible as $eval_ret).
> 
> But does it make sense in the context of the whole test script to
> try maintaining $eval_ret?

Right, it doesn't, as 'die' preserves the last seen exit code, and any
exit codes from the atexit commands are ignored anyway.

> >  # Most tests can use the created repository, but some may need to create more.
> >  # Usage: test_create_repo <directory>
> >  test_create_repo () {
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index db3875d1e4..b35881696f 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -620,6 +620,10 @@ test_external_has_tap=0
> >  
> >  die () {
> >  	code=$?
> > +	# This is responsible for running the atexit commands even when a
> > +	# test script run with '--immediate' fails, or when the user hits
> > +	# ctrl-C, i.e. when 'test_done' is not invoked at all.
> > +	test_atexit_handler || code=$?
> >  	if test -n "$GIT_EXIT_OK"
> >  	then
> >  		exit $code
> > @@ -1045,9 +1049,28 @@ write_junit_xml_testcase () {
> >  	junit_have_testcase=t
> >  }
> >  
> > +test_atexit_cleanup=:
> > +test_atexit_handler () {
> > +	# In a succeeding test script 'test_atexit_handler' is invoked
> > +	# twice: first from 'test_done', then from 'die' in the trap on
> > +	# EXIT.
> 
> We are guaranteed to still have the trash directory when we are run
> in the exit handler after getting interrupted or test_failure_()
> exits under the "-i" option, and when test_done() calls us.  What
> will cause us trouble is the exit handler at the end of a successful
> run after test_done() finishes.  At that point, test_done would have
> already cleared the trash directory, so we may not have enough state
> to allow us to clean-up at exit.
> 
> Clearing the exit trap in test_done after it calls us might be an
> alternative, but I think it is equivalent to clearing the
> test_atexit_cleanup variable, and it is cleaner, so I think I agree
> with the approach this patch uses.
> 
> > +	# This condition and resetting 'test_atexit_cleanup' below makes
> > +	# sure that the registered cleanup commands are run only once.
> > +	test : != "$test_atexit_cleanup" || return 0
> 
> I think test_when_finished uses a special value in $test_cleanup in
> a similar way

That's right.

> but it even skips when there is no point doing the
> test_eval_ of the "accumulated" scriptlet when it is empty.

But this is not, because $test_cleanup is initialized to this special
value and it can never be empty, and indeed 'test_eval_' uses this
condition:

  if test -z "$immediate" || test $eval_ret = 0 ||
     test -n "$expecting_failure" && test "$test_cleanup" != ":"

and it never checks $test_cleanup's emptiness.

> Shouldn't we be doing the same thing, i.e.
> 
> 	if test -z "$test_atexit_cleanup"
> 	then
> 		return 0
> 	fi
> 	... do the heavy lifting ...
> 	test_atexit_cleanup=
> 
> That will make the handler truly a no-op when there is no atexit
> defined.

$test_atexit_cleanup is used the same way as $test_cleanup; it's
initialized to the same special value and can never be empty, so there
is no need to check for its emptiness either.

> > +	setup_malloc_check
> > +	test_eval_ "$test_atexit_cleanup"
> > +	test_atexit_cleanup=:
> > +	teardown_malloc_check
> > +}
> > +
> >  test_done () {
> >  	GIT_EXIT_OK=t
> >  
> > +	# Run the atexit commands _before_ the trash directory is
> > +	# removed, so the commands can access pidfiles and socket files.
> > +	test_atexit_handler
> > +
> >  	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
> >  	then
> >  		test -n "$junit_have_testcase" || {
