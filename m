Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6251607B0
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706632; cv=none; b=Hj/ti8MNXY8lXnplu1bCczfvs79+NiQ5bgnWvmc4NPxUMftfPr/2ZlZv2cEc5ZGK1GwfAEcbiW6kbBNparofwFzgD0BB1mNvd1t5td/NhAx4mQc2Vxov+FGKCvuo3TwkyhYmEFJ0R/ggr9Ox2Hqlywr316ezvS/kxTUOktxrKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706632; c=relaxed/simple;
	bh=oCxqCdEeD2h4fve5R6zQezjb9Hx+wMRq0ZcPr0GKfRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGNN8+E4lB97Teg45jffnEb7QrWuV3X1o/cm0XlXryWY4k5a2NzCqHyxBA1v0oOJgth5chv4vQZpnQBh0TnsSSimUxwZmUE7MtMj/VoWvnGhJrFDoEucJhLd09qbaH9/lnnivySDmaCPsJLY41upPR6W6xK4i+8EcbWw10qHv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHbLHYPm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHbLHYPm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb1c918860so14457245ad.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720706630; x=1721311430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+2qSLCVgbdRGnRoY1VGP90H9oa+1yKokOZClIjvkec=;
        b=kHbLHYPmnlZCN6bPOjESdk1Egjblz6wQxYW6TOjfxW5JqiZwlomeqwuHbZvKp1T4Ih
         Nc8q9w3fURCog3PJR69YenjX+cFXkY0Wi0eI1jIa3x065EnKJXfwa12b9+f4fMNZfuSV
         uO9FneShloa2bIcaI9NdiD7OU06Jx2OgXELJv+8El01XJfFQByboZEUmyCIAVMJaqDSh
         dCk1JC6ViCg+Al4wHrL/E6KB+afW5QlZO3EwWgahRhPQunKisIV+5yDLLPAXag1ASaPQ
         ieSgIqKGCj4fEf7n4fsWS/MdMrRbOLfVC7zk9ME09d7/1C282/netoO5h3qXQ9EV2zlB
         6BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706630; x=1721311430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+2qSLCVgbdRGnRoY1VGP90H9oa+1yKokOZClIjvkec=;
        b=jJLUp4GoZcFacmIeIr+T7gh/P96DScwDYM0nnIKUrEt0SeBviOg4vTgo2IH8w+lVdg
         ns/c7KpIYll2zkSbnlBoQaK1Xc8G0j0f4iweLgz1xwNlz4r/odFg9wza8aWzaaNUuHk4
         eoMh/TMW/qlM2neiOZC5VrpzaAHu1eBqkimA+EOp0w85N2JkD6qMrz7hK5542S1heahW
         z+ixMmvOlrX8+TCFRA0qyPZwzQK4/o83nk9n4pel+H59OjInEzfeHtCuDsULZGY73mkC
         NXmfh9cgUhHs7ho/E01+WSyc4Msa+dwRaXfAgLWblCSFzOBIO7l0ccFlSvB12LN1bViI
         ESHw==
X-Gm-Message-State: AOJu0YwvEWIQhRTKM3Fa8WiPYF7z2O5tCvxkilnlJ3RtkzRqMeafgHr9
	qNGwPNp9m+sTmoEhNl0hVc0G3boJF8w/iLL3PMpFXFz0e8tzgpno
X-Google-Smtp-Source: AGHT+IHr5R2hUs1sEikGOu+mWUa9h8bddxvsJImUW0Te25uJPGWUWzxGPd4TJRH0EeI3qlScY7NqLQ==
X-Received: by 2002:a17:902:e88d:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1fbdb9c1cc4mr38704975ad.6.1720706630121;
        Thu, 11 Jul 2024 07:03:50 -0700 (PDT)
Received: from [192.168.43.32] (200.149.159.133.rev.vmobile.jp. [133.159.149.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad0298sm50802295ad.278.2024.07.11.07.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 07:03:49 -0700 (PDT)
Message-ID: <369826d0-ffeb-4f17-88ee-c168a99c8289@gmail.com>
Date: Thu, 11 Jul 2024 23:03:46 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by
 default
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
 <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>
 <20240710071621.GA2049772@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240710071621.GA2049772@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 10, 2024 at 03:16:21AM -0400, Jeff King wrote:
> On Wed, Jul 10, 2024 at 11:30:13AM +0900, Rubén Justo wrote:
> 
> > As we currently describe in t/README, it can happen that:
> > 
> >     Some tests run "git" (or "test-tool" etc.) without properly checking
> >     the exit code, or git will invoke itself and fail to ferry the
> >     abort() exit code to the original caller.
> > 
> > Therefore, GIT_TEST_SANITIZE_LEAK_LOG=true is needed to be set to
> > capture all memory leaks triggered by our tests.
> > 
> > It seems unnecessary to force users to remember this option, as
> > forgetting it could lead to missed memory leaks.
> > 
> > We could solve the problem by setting GIT_TEST_SANITIZE_LEAK_LOG to
> > "true" by default, but that might suggest we think "false" makes sense,
> > which isn't the case.
> > 
> > Therefore, the best approach is to remove the option entirely while
> > maintaining the capability to detect memory leaks in blind spots of our
> > tests.
> 
> Yeah, I think that reasoning makes sense.
> 
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 814578ffc6..51f8f59a29 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -370,7 +370,6 @@ linux-musl)
> >  linux-leaks|linux-reftable-leaks)
> >  	export SANITIZE=leak
> >  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
> > -	export GIT_TEST_SANITIZE_LEAK_LOG=true
> >  	;;
> 
> OK, we can drop this line snice it's now the default. Good.
> 
> > diff --git a/t/README b/t/README
> > index d9e0e07506..c2a732d59e 100644
> > --- a/t/README
> > +++ b/t/README
> > @@ -382,33 +382,9 @@ mapping between "TEST_PASSES_SANITIZE_LEAK=true" and
> > those tests that
> >  pass under "SANITIZE=leak". This is especially useful when testing a
> >  series that fixes various memory leaks with "git rebase -x".
> > 
> > -GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
> > -"test-results/$TEST_NAME.leak/trace.*" files. The logs include a
> > -"dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
> > -make logs +machine-readable.
> > -
> > -With GIT_TEST_SANITIZE_LEAK_LOG=true we'll look at the leak logs
> > -before exiting and exit on failure if the logs showed that we had a
> > -memory leak, even if the test itself would have otherwise passed. This
> > -allows us to catch e.g. missing &&-chaining. This is especially useful
> > -when combined with "GIT_TEST_PASSING_SANITIZE_LEAK", see below.
> > -
> >  GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
> >  will run to completion faster, and result in the same failing
> >  tests. The only practical reason to run
> > -GIT_TEST_PASSING_SANITIZE_LEAK=check without "--immediate" is to
> > -combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
> > -first failing test case our leak logs won't show subsequent leaks we
> > -might have run into.
> > -
> > -GIT_TEST_PASSING_SANITIZE_LEAK=(true|check) will not catch all memory
> > -leaks unless combined with GIT_TEST_SANITIZE_LEAK_LOG=true. Some tests
> > -run "git" (or "test-tool" etc.) without properly checking the exit
> > -code, or git will invoke itself and fail to ferry the abort() exit
> > -code to the original caller. When the two modes are combined we'll
> > -look at the "test-results/$TEST_NAME.leak/trace.*" files at the end of
> > -the test run to see if had memory leaks which the test itself didn't
> > -catch.
> 
> After this patch, the documentation seems to end abruptly with "The only
> practical reason to run". I think we need to either delete those lines,
> too, or complete the thought.

I accidentally left that line unfinished.  I'll fix it. 

> 
> I do think they are saying something useful, which is: in "check" mode,
> you should always use "--immediate" since the point is just to find
> scripts which aren't labeled correctly. But I think that is true whether
> you are using the leak log or not. Your log will be incomplete, of
> course, if you used "--immediate", but the point is to see whether we
> find even one.
> 
> >  GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
> >  default to n.
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 79d3e0e7d9..942828c55d 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1270,8 +1270,8 @@ check_test_results_san_file_ () {
> >  		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok'
> > with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
> >  		invert_exit_code=t
> >  	else
> > -		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory
> > leak, exit non-zero!" &&
> > -		invert_exit_code=t
> > +		say "Our logs revealed a leak!" &&
> > +		test "$test_failure" != 0 || invert_exit_code=t
> >  	fi
> >  }
> 
> This adds back in the test_failure fix from 47c6d4dad2 (test-lib: fix
> GIT_TEST_SANITIZE_LEAK_LOG, 2024-06-30), but in a different way. I think
> we'd want to build on top, and then you just need to update the messages
> on either side of that final elif/else.

OK.  I think simplifying those lines introduced unnecessary noise.  I'll
discard it and just adjust the messages. 

> 
> > @@ -1555,28 +1555,28 @@ then
> >  		passes_sanitize_leak=t
> >  	fi
> > 
> > -	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
> > +	if test -z "$passes_sanitize_leak" &&
> > +	   ! test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" &&
> > +	   test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
> >  	then
> > -		sanitize_leak_check=t
> > -		if test -n "$invert_exit_code"
> > +		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> > +		test_done
> > +	else
> > +		if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
> >  		then
> > [...]
> 
> I'm not sure why we need to touch this block. The "if
> GIT_TEST_SANITIZE_LEAK_LOG" just below it I assumed would go away. But
> all of this has to do with "check" versus "true", etc? There might be
> new refactoring / simplification opportunities opened up by getting rid
> of the LEAK_LOG variable, but we should do those on top.
> 
> I guess what's happening is that you've rearranged it so that:
> 
> > -	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
> > -	then
> >  		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
> >  		then
> >  			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
> 
> ...when this conditional goes away, the existing body is still in the
> "else". But even though it would make the diff noisy to reindent, I
> think we are better off doing so to make it clear what the actual change
> is.

OK.

> 
> > @@ -1599,9 +1599,6 @@ elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
> > ||
> >       test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
> >  then
> >  	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
> > -elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
> > -then
> > -	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
> >  fi
> 
> OK, this final elif is responsible for complaining when you set LEAK_LOG
> but don't have an actual leak-checking build. But once it goes away,
> there's no need to complain. Makes sense.
> 

Thanks for reviewing the patch.
