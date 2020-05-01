Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A197BC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F42F2076D
	for <git@archiver.kernel.org>; Fri,  1 May 2020 09:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxAFVVl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgEAJf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728325AbgEAJf6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 05:35:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA02C035495
        for <git@vger.kernel.org>; Fri,  1 May 2020 02:35:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so627010qke.8
        for <git@vger.kernel.org>; Fri, 01 May 2020 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zDamm7GIxsAX+MA7DRY1YkYKjAQaMQt/OFd6hMuNQEI=;
        b=hxAFVVl5XVCv473eDcK1OZAZ/FJ+k67tNh4CK/7KAjcXaz4vnwil6WQq7AqR5UDChq
         rwe5u2TiORII4BEbEAY1XP+W/ZdbpIFMQiO+hKN+NIHaD6ygdJ1EohlCBrSCaiB3MpaJ
         OZp3ovZuTRZ57Q42TX68DVQIQGm5ShMGzEiEQqVejKQDTM8gMmKdAlLmOr3n9APdjIz3
         tY0995aSGVAzno/b76C4oZsTnYTnesmRm4YV79T3KRk18Pfz2u+l7yGdm0Kbqcb+d6oy
         Y5BzB9gCL7BsrIoxPXqn/mwoiIL4nxkU2kxXgdwtCcNFN0obnD3NtDRXrbX5VU1cGN8T
         +Gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zDamm7GIxsAX+MA7DRY1YkYKjAQaMQt/OFd6hMuNQEI=;
        b=ACirFazw25Lre6xWm1qIub9dyNljQcOVwb4+8Lwy7Gl13HL8TfjouYDsplkan2XIfG
         gTfbT33kNJ/E6kWeKmtps8pAFvWefSdRfhWHTy2jBceijT0lIT/PlvXOTBVsG+kSqVts
         rpAv1yoVHhRWQneYHkXAtvxJp/LZWg8cotd945VS7ebQIRhbJXcFSbhvZdh4U+jbb43I
         7s4YoFitnNWCYSKGuN68K3Ax1+onm7BuQZraIunuEBLd4JRvjpE1iV+7j52bB6OdxWru
         SpSko4o0IalBDDKueO59/40kaaM332MGR/gyMecjzwEGAz6Uhsmenzs4VIdDCor1Mrif
         puhw==
X-Gm-Message-State: AGi0PuZXmZ5n+p1w0qchdOGYG3eUhunrMbf/d5CqC76vxejh/kX+13/j
        9WFjLtAqHaeGauhMBF63WyCR822I
X-Google-Smtp-Source: APiQypK35reTHEcdJ+bKMaAf72Mtf3fkoq3JO8eJf9sZ0CmIE9wMJwCqGbd52FBeQ6kDv0OK3AkZIg==
X-Received: by 2002:a05:620a:22ee:: with SMTP id p14mr2746334qki.248.1588325757361;
        Fri, 01 May 2020 02:35:57 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c139sm2303041qkg.8.2020.05.01.02.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 02:35:56 -0700 (PDT)
Date:   Fri, 1 May 2020 05:35:54 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1.1] lib-submodule-update: pass OVERWRITING_FAIL
Message-ID: <20200501093554.GA49619@generichostname>
References: <22eacd20a8213c3281974a6c103fd2d00c95efaa.1588162842.git.liu.denton@gmail.com>
 <f0d8dcf7dc52fe5ad2f1e173cd744bfdeb55eb45.1588242122.git.liu.denton@gmail.com>
 <xmqqpnbor9ng.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnbor9ng.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Apr 30, 2020 at 01:38:59PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > We are using `test_must_fail $command`. However, $command is not
> > necessarily a git command; it could be a test helper function.
> >
> > In an effort to stop using test_must_fail with non-git commands, instead
> > of invoking `test_must_fail $command`, run
> > `OVERWRITING_FAIL=test_must_fail $command` instead.
> 
> This description alone does not make much sense to me as a reader.
> For "when OVERWRITING_FAIL environment variable is set to
> test_must_fail, something magical happens while running $command" to
> be true, $command (which may be "a git command", or "a test helper
> function") must be aware of, and must be told how to react to the
> OVERWRITING_FAIL environment variable.  For example,
> 
> 	test_must_fail test a = b
> 	test_must_fail git cat-file leaf HEAD
> 
> may succeed because "test a = b" and "git cat-file leaf HEAD" fail
> and test_must_fail would notice that these commands exited with
> non-zero status without crashing.
> 
> But how would the same happen for these commands,
> 
> 	OVERWRITING_FAIL=test_must_fail test a = b
> 	OVERWRITING_FAIL=test_must_fail git cat-file leaf HEAD
> 
> which is what the above paragraph tells me to write "instead of
> using test_must_fail".  There is something gravely missing from the
> description.  

Because of the previous patch in this series, helper functions are
called using test_submodule_switch_func() while git commands are invoked
using test_submodule_switch() and test_submodule_forced_switch(). As a
result, helper functions that are invoked must learn to handle
$OVERWRITING_FAIL appropriately. The latter two functions now feature
something like

	test_submodule_switch_func "eval \$OVERWRITING_FAIL git $1"

Does this commit message increase the clarity?

	lib-submodule-update: pass OVERWRITING_FAIL

	We are using `test_must_fail $command`. However, $command is not
	necessarily a git command; it could be a test helper function.

	In an effort to stop using test_must_fail with non-git commands, instead
	of invoking `test_must_fail $command`, run
	`OVERWRITING_FAIL=test_must_fail $command` instead in
	test_submodule_switch_common().

	In the case where $command is a git command,
	test_submodule_switch_common() is called by one of
	test_submodule_switch() or test_submodule_forced_switch(). In those two
	functions, pass $command like this:

		test_submodule_switch_common "eval \$OVERWRITING_FAIL git $command"

	In the case where $command is a test helper function, increase the
	granularity of the test helper function by marking the git invocation
	which was meant to fail like this:

		$OVERWRITING_FAIL git checkout "$1"

	This is useful because currently, when we run a test helper function, we
	just mark the whole thing as `test_must_fail`. However, it's possible
	that the helper function might fail earlier or later than expected due
	to an introduced bug. If this happens, then the test case will still
	report as passing but it should really be marked as failing since it
	didn't actually display the intended behaviour.

	While we're at it, some helper functions have git commands piping into
	another git command. Break these pipes up into two separate invocations
	with a file buffer so that the return code of the first command is not
	lost.

	This patch can be better viewed with `--ignore-all-space`.

> Is it that $command is *NEVER* a 'git' command, but just a selected
> few helper functions know how to honor this convention?

With the changes made, it is now either a helper function or an eval of
a git command, as described above.

> If that is
> the case, perhaps can we teach these helper functions an *option* to
> expect a failure instead of expecting a success?

I don't think this is possible because $command is some arbitrary
command string, in particular due to the eval stuff. I suppose we could
write something like

	test_submodule_switch_common "f () {
			# handle potential --expect-fail
			git $command"
		} && f"

but I'm not sure if this would even work. I haven't tested it and I feel
like doing this would be far too unwieldy. Also, since
test_submodule_switch_common() uses $command as the test name, I don't
think it's feasible to take this approach.

> These are all
> speculations, because the above description is too vague as a
> starting point for clear thinking.
> 
> > +			OVERWRITING_FAIL=test_must_fail $command replace_sub1_with_directory &&
> > +			OVERWRITING_FAIL= &&
> 
> If we have given up the "single-shot environment export" for
> compatibility reasons (which is a sound decision to follow), we
> should make sure it is clear to our readers that we are not using
> that shell feature.  I.e.
> 
> 			export OVERWRITING_FAIL=test_must_fail &&
> 			$command replace_sub1_with_directory &&
> 			unset OVERWRITING_FAIL &&

Makes sense. I would drop the export, though, because $OVERWRITING_FAIL
should only be handled within the shell environment. We're never calling
any external commands that need to know about this variable.

On a tangent, I got a response[1] from the dash people about the
"single-shot environment export" propagating past a function. It seems
like in the most updated version of POSIX addresses this and it's up to
the implementers whether or not variables propagate past a function
invocation.

Thanks,

Denton

[1]: https://www.mail-archive.com/dash@vger.kernel.org/msg01925.html
