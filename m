Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8110C211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 23:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeLFXKL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 18:10:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35112 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbeLFXKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 18:10:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so2735392wmh.0
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 15:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gfgZDRV2DIozgkWgy+7WwIhcznjUljVeokE6ERLbfAo=;
        b=urSCdHypBrGKh5u6C2w/GV7D1/CZ/ffFoIjfnA2z39nbxz09H/+MVPfE0nqB0i1Bv4
         8EOaQF6fYxZ9rd5aH9fYYal0lPkIhg7+K6wLaluohT5N+77r+r6ItIJANrSRMaP1+Vno
         h/j0Igjd8EdJX9YE9mbGkxTbOBraEed2yTYHehbvFhvHmsaCazVbroPNi1Uja1BIF1rX
         3smdk9KWGcSQTt5jJCgHD/JsjcV2dbKISLhutRfUtIAQBLulyPJPzaWUAkb3/rCBhR0R
         +7FpANqrBsrzG90FcBBiuVsByYmSrGrJhRpWFzXMFuXkzOwc721feau+500CFP9WQm/9
         jBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gfgZDRV2DIozgkWgy+7WwIhcznjUljVeokE6ERLbfAo=;
        b=OHYHDQTviLb0nr9RlA+jyuK18lMlqcolBUS2IV4NAtF0rbBlVzm7CfIXPdGL+vqqvk
         qxlD6voFIJ0zQVrgA9GhVxlAiKsFuEagtAd8ZpmK6ACiq6OCg8LVNbezwVj7XZ7PrJQ+
         qGXNOda6BEhRaGx+3rHCes31XFxMz6w9VYWJ+Pn+5inVrfL62+nBe+f7ntlNR+uv9mn+
         YsijZR7BkGzR3IXleSrbCX19VzDJBMSrm7rfGDSQUT+YnmyYzGmPCjkDG2t+5xK8rQ+e
         5PW0TdtbibEUt12OUInE096ZHELmiIJ3pOaQp2JoCGb+rMiV9G4dfYbSSoUVkplnBvpG
         N2uA==
X-Gm-Message-State: AA+aEWaXtqeMduR/bmDguX27C4W+5gIVNbZrq8Z2JRijOxtBJlR3hA+G
        qjFwXkGZ+dAM3OGaxG2BjbA=
X-Google-Smtp-Source: AFSGD/UxOZkqN6Du1mlxA1/yL50kX+1oaOHhAjTH2R6AKUzZJI4yNCG+sZeY3NdARj3EqVG1iGZDrQ==
X-Received: by 2002:a1c:8104:: with SMTP id c4mr156077wmd.133.1544137808474;
        Thu, 06 Dec 2018 15:10:08 -0800 (PST)
Received: from szeder.dev (x4dbd2bae.dyn.telefonica.de. [77.189.43.174])
        by smtp.gmail.com with ESMTPSA id h62sm2440298wmf.11.2018.12.06.15.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 15:10:07 -0800 (PST)
Date:   Fri, 7 Dec 2018 00:10:05 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181206231005.GP30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
 <20181205140106.GM30222@szeder.dev>
 <20181205215621.GE19936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205215621.GE19936@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 04:56:21PM -0500, Jeff King wrote:
> Could we just kill them all?
> 
> I guess it's a little tricky, because $! is going to give us the pid of
> each subshell. We actually want to kill the test sub-process. That takes
> a few contortions, but the output is nice (every sub-job immediately
> says "ABORTED ...", and the final process does not exit until the whole
> tree is done):

It's trickier than that:

  - Nowadays our test lib translates SIGINT to exit, but not TERM (or
    HUP, in case a user decides to close the terminal window), which
    means that if the test runs any daemons in the background, then
    those won't be killed when the stress test is aborted.

    This is easy enough to address, and I've been meaning to do this
    in an other patch series anyway.

  - With the (implied) '--verbose-log' the process killed in the
    background subshell's SIGTERM handler is not the actual test
    process, because '--verbose-log' runs the test again in a piped
    subshell to save its output:
    
      (GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
       echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"

    That 'kill' kills the "outer" shell process.
    And though I get "ABORTED..." immediately and I get back my
    prompt right away, the commands involved in the above construct
    are still running in the background:

      $ ./t3903-stash.sh --stress=1
      ^CABORTED  0.0
      $ ps a |grep t3903
      1280 pts/17   S      0:00 /bin/sh ./t3903-stash.sh --stress=1
      1281 pts/17   S      0:00 tee -a <...>/test-results/t3903-stash.stress-0.out
      1282 pts/17   S      0:00 /bin/sh ./t3903-stash.sh --stress=1
      4173 pts/17   S+     0:00 grep t3903

    I see this behavior with all shells I tried.
    I haven't yet started to think it through why this happens :)

    Not implying '--verbose-log' but redirecting the test script's
    output, like you did in your 'stress' script, seems to work in
    dash, ksh, and ks93, but not in Bash v4.3 or later, where, for
    whatever reason, the subshell get SIGINT before the SIGTERM would
    arrive.
    While we could easily handle SIGINT in the subshell with the same
    signal handler as SIGTERM, it bothers me that something
    fundamental is wrong here.
    Furthermore, then we should perhaps forbid '--stress' in
    combination with '--verbose-log' or '--tee'.
    

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9b7f687396..357dead3ff 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -98,8 +98,9 @@ done,*)
>  	mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
>  	stressfail="$TEST_RESULTS_BASE.stress-failed"
>  	rm -f "$stressfail"
> -	trap 'echo aborted >"$stressfail"' TERM INT HUP
> +	trap 'echo aborted >"$stressfail"; kill $job_pids 2>/dev/null; wait' TERM INT HUP
>  
> +	job_pids=
>  	job_nr=0
>  	while test $job_nr -lt "$job_count"
>  	do
> @@ -108,10 +109,13 @@ done,*)
>  			GIT_TEST_STRESS_JOB_NR=$job_nr
>  			export GIT_TEST_STRESS_STARTED GIT_TEST_STRESS_JOB_NR
>  
> +			trap 'kill $test_pid 2>/dev/null' TERM
> +
>  			cnt=0
>  			while ! test -e "$stressfail"
>  			do
> -				if $TEST_SHELL_PATH "$0" "$@" >/dev/null 2>&1
> +				$TEST_SHELL_PATH "$0" "$@" >/dev/null 2>&1 & test_pid=$!
> +				if wait
>  				then
>  					printf >&2 "OK   %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
>  				elif test -f "$stressfail" &&
> @@ -124,16 +128,11 @@ done,*)
>  				fi
>  				cnt=$(($cnt + 1))
>  			done
> -		) &
> +		) & job_pids="$job_pids $!"
>  		job_nr=$(($job_nr + 1))
>  	done
>  
> -	job_nr=0
> -	while test $job_nr -lt "$job_count"
> -	do
> -		wait
> -		job_nr=$(($job_nr + 1))
> -	done
> +	wait
>  
>  	if test -f "$stressfail" && test "$(cat "$stressfail")" != "aborted"
>  	then
> 

