Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4DCC48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE9460FE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhFPLjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 07:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhFPLjD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 07:39:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01ABC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 04:36:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k7so3318957ejv.12
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=79NGxeoIYk+OUFH/oLLCSXbkVVie7/f0BvxScrwxLVM=;
        b=XSzTMXMk2oNapM3aSKGaIBeZncenvYw2KydMiWEITtbW0KjHXeJJkkouuI8ccMUDPy
         wShCSUk1yCNIZ0rCoPknC+yoAxjZLUbcTELZqLKUeDOL2WLjIsfZtpuQ3MGSwzUvUZWY
         i26umEedu0qqk3xdLXEFg65UPpYzpvfyBLNbzpUMV+0v/F1aPYc6V/FwS2rvUk2/2rgZ
         42QGOzQSSKtA4CaM7RrAGiREwkN25aQx23VarTo0LWUhFrGerVzUb0KEZ0rBGGKjemdf
         7EaaCguKcfiZxDnjafawsS6MAbYOVkaZwUEb7xMt4zhB4x7x8n4EildlTrWB7RnkhxD1
         YcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=79NGxeoIYk+OUFH/oLLCSXbkVVie7/f0BvxScrwxLVM=;
        b=nkOBcJtvy8KuOpyNjluueGEXrLPeEk9HBpYRz214dQgdQh6scPX0lHaCC+nNt1j+mL
         UNvh/a0+A4U/bt3CgBK4dPI++AETsb2O1Rf1Pwbt2/8koJG2sY3pDKtKlxFzeAEr3jkL
         7/Ub/yniEkhdyuj6NY72KEMd5r6CL4DJUEyOl7tnXGOa/Fg1EVb7fNJklChvGlRe+odD
         KBIK6w1odi7QrJG3ofxw+lq/Osevt9/4+XDUuKs4g1oT778e1QcmQD4s5sf9rqFp6Z5N
         aAtMh1RQsA2tFXMvYrSRXembgXugZRUb2dgHnpGREd0L9XGlwqQZI467pVXBj6YDfcmi
         n+tA==
X-Gm-Message-State: AOAM532/ibrgWiYtcvAiowpjptKzexc/pE7RnU7rejKgOMcEKVdE1af3
        eRUJ3vOG521m1v8csYJWflh0HiO4OkIUeQ==
X-Google-Smtp-Source: ABdhPJyOmdFwhVEAOiEJbwj7FrpBscociBvsGx/FyqHc4DOccZsavIF+TqPgt76xah2Cq8Nw4/hJ0Q==
X-Received: by 2002:a17:906:fcb5:: with SMTP id qw21mr4754880ejb.57.1623843415453;
        Wed, 16 Jun 2021 04:36:55 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z19sm1517824edc.90.2021.06.16.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:36:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] perf: fix when running with TEST_OUTPUT_DIRECTORY
Date:   Wed, 16 Jun 2021 13:33:32 +0200
References: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
Message-ID: <87mtrqxcq1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 16 2021, Patrick Steinhardt wrote:

> When the TEST_OUTPUT_DIRECTORY is defined, then all test data will be
> written in that directory instead of the default directory located in

Is the timing of this patch a coincidence, or did you run into this
related to the other patches related to this variable now,
i.e. https://lore.kernel.org/git/20210609170520.67014-1-felipe.contreras@gmail.com/
and related.

> Fix the issue by adding a `--results-dir` parameter to "aggregate.perl"
> which identifies the directory where results are and by making the "run"
> script awake of the TEST_OUTPUT_DIRECTORY variable.

Makes sense.

> [...]
>  my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
> -    $codespeed, $sortby, $subsection, $reponame);
> +    $codespeed, $sortby, $subsection, $reponame, $resultsdir);
>  
>  Getopt::Long::Configure qw/ require_order /;
>  
>  my $rc = GetOptions("codespeed"     => \$codespeed,
>  		    "reponame=s"    => \$reponame,
> +		    "results-dir=s" => \$resultsdir,
>  		    "sort-by=s"     => \$sortby,
>  		    "subsection=s"  => \$subsection);
>  usage() unless $rc;
> @@ -137,7 +139,9 @@ sub sane_backticks {
>  	@tests = glob "p????-*.sh";
>  }
>  
> -my $resultsdir = "test-results";
> +if (not $resultsdir) {
> +	$resultsdir = "test-results";
> +}

Works, but FWIW in git.git's perl scripts it's usual to do:

my $resultsdir = "test-results";
GetOptions(...);

Which serves the same purpose. You can also inline this in the GetOptions call:
	
	GetOptions(...,
		"results-dir=s" => \(my $resultsdir = "test-results"),
	);

But maybe that's too obscurely Perl-ish, i.e. declaring a variable for
our scope inline in another function's argument list, and we should just
use the first idiom we use in most other places.


>  	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
> -		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl $(basename "$0") )
> +		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0") )
>  	fi
>  }

Makes sense to split up the overly long line at this point probably...

>[...]
> -mkdir -p test-results
> -get_subsections "perf" >test-results/run_subsections.names
> +if test -n "$TEST_OUTPUT_DIRECTORY"
> +then
> +    TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
> +else
> +    TEST_RESULTS_DIR=test-results
> +fi

Indending with spaces?
