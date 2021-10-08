Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04327C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1AA60FC3
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbhJHDpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 23:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbhJHDpn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 23:45:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3A7C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 20:43:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o133so780442pfg.7
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 20:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1ysqa9BE2G8XOOx3K8E7aKBCTtQyZK45N0CMPM4rccI=;
        b=magBcslb2jOiQvZrrh2prVzu6iBFp7hClcwqoLrd8B1KA1oUShsMwUOFx9S8A8uCs5
         cAAX2RzIWYzouYqRHgJ7KJOR/ZTYif1lCjG+bdeZaROq3TbK9s4WjjPx677BxGKS/rRq
         9/fbb/OOwPftJVR/BPiyGZvoiTtpVHRVJ7YEdaowRrqJeslUpd5DWNnk8eIUp0BlCgF8
         qZG7KkG1yhDsyJCpWfj/uLE03jrPD9Z9vYHU2AuKFWjs03iNG8FPxZTXjiib1KMoeOvW
         u91Sd33lOqRFgEjxsvwk7gT5efRAIZZ6IK2Pl5CaFsPP/ISt86B4L/jDUkZr9oY0fIif
         ny0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1ysqa9BE2G8XOOx3K8E7aKBCTtQyZK45N0CMPM4rccI=;
        b=cqc8korfuBAhEHI6iCTHEuAO1/U3W+A1gYFv6dMnqLUl+cJxFgUbGgMuUtkkj73WWX
         QTSBhjmFBLqwX6VMQLBh/zMKPyxWAb7kmWobexe2crrZYp4udvEQP2ONbbBAGmEBvZOV
         /oQzuSc8pX5JIsUSVluBjeLiXXD7Hq9KcS/Y33BOYUkfOQr831E5WQvSX2KYau7/hJH4
         wbG4KPhqvz2DveF9CwLH11jcXhYwY0Z0iJoG2TwK6G+UWXB4A68bJDZR7U6P8NwnSzjU
         H4B+xiqvp1iEQdfSOuwaa7o5zjfnrRLO14GZ3Z2Chm1Su1oMf0ohsxLY9Cx2pETvKDl/
         X/2Q==
X-Gm-Message-State: AOAM531613OUUN/+Jx3AUvIVuo90KqXQvjzlXmcykE89Gxz3XLZ+e64V
        sCUXSjNr0BlshIydv95N09g/9A==
X-Google-Smtp-Source: ABdhPJwJjbXJCHmtabuiX+mN82kej9+bYypQMGifkeAm1qGbYV3pzyXXy0/RIhYDpfGhpiJQsFBD1g==
X-Received: by 2002:a63:d34f:: with SMTP id u15mr2716561pgi.200.1633664628559;
        Thu, 07 Oct 2021 20:43:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:970b:a182:aca1:37a6])
        by smtp.gmail.com with ESMTPSA id w2sm800000pfq.207.2021.10.07.20.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 20:43:48 -0700 (PDT)
Date:   Thu, 7 Oct 2021 20:43:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 1/8] progress.c tests: make start/stop verbs on stdin
Message-ID: <YV++bhK2sscQt5bc@google.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-1.8-e0a294eb479-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-1.8-e0a294eb479-20210920T225701Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:09:22AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Change the usage of the "test-tool progress" introduced in
> 2bb74b53a49 (Test the progress display, 2019-09-16) to take command
> like "start" and "stop" on stdin, instead of running them implicitly.
> 
> This makes for tests that are easier to read, since the recipe will
> mirror the API usage, and allows for easily testing invalid usage that
> would yield (or should yield) a BUG(), e.g. providing two "start"
> calls in a row. A subsequent commit will add such stress tests.

Ok. So this is just a readability change, and not a functional change to
the helper, for now.

Or so I thought, but I was surprised to see the usage changing and the
total count moving to stdin. I don't think that's a bad change but the
commit message doesn't mention it in a way that I expected to see it in
the diff.

> diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
> index 5d05cbe7894..685c0a7c49a 100644
> --- a/t/helper/test-progress.c
> +++ b/t/helper/test-progress.c
> @@ -22,31 +26,41 @@
>  
>  int cmd__progress(int argc, const char **argv)
>  {
> -	int total = 0;
> -	const char *title;
> +	const char *default_title = "Working hard";
> +	char *detached_title = NULL;
>  	struct strbuf line = STRBUF_INIT;
> -	struct progress *progress;
> +	struct progress *progress = NULL;
>  
>  	const char *usage[] = {
> -		"test-tool progress [--total=<n>] <progress-title>",
> +		"test-tool progress <stdin",
>  		NULL
>  	};
>  	struct option options[] = {
> -		OPT_INTEGER(0, "total", &total, "total number of items"),
>  		OPT_END(),
>  	};
>  
>  	argc = parse_options(argc, argv, NULL, options, usage, 0);
> -	if (argc != 1)
> -		die("need a title for the progress output");
> -	title = argv[0];
> +	if (argc)
> +		usage_with_options(usage, options);

Ok. We lose the args entirely, moving them to stdin lines, and that
cleans up the usage() check. Nice.

>  	progress_testing = 1;
> -	progress = start_progress(title, total);

Getting rid of the implied start. Ok.

>  	while (strbuf_getline(&line, stdin) != EOF) {
>  		char *end;
>  
> -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
> +		if (!strcmp(line.buf, "start")) {
> +			progress = start_progress(default_title, 0);
'start' with no args...
> +		} else if (skip_prefix(line.buf, "start ", (const char **) &end)) {
'start 1234'...

Would it be more readable to use strbuf_split_buf() here instead? Maybe
it doesn't fix the need for strtoull() but it could make the parsing
clearer. I did have to think about this one for a bit.

> +			uint64_t total = strtoull(end, &end, 10);
> +			if (*end == '\0') {
> +				progress = start_progress(default_title, total);
> +			} else if (*end == ' ') {
'start 1234 lorem ipsum dolor'. Ok.
> +				free(detached_title);
> +				detached_title = strbuf_detach(&line, NULL);
> +				progress = start_progress(end + 1, total);
> +			} else {
> +				die("invalid input: '%s'\n", line.buf);
> +			}

I wondered why we had to do all this title parsing from scratch now when
we didn't before, but I guess it's because we don't get a nicely
allocated argv[0]. Ok.

> +		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
>  			uint64_t item_count = strtoull(end, &end, 10);
>  			if (*end != '\0')
>  				die("invalid input: '%s'\n", line.buf);
> @@ -63,12 +77,15 @@ int cmd__progress(int argc, const char **argv)
>  				die("invalid input: '%s'\n", line.buf);
>  			progress_test_ns = test_ms * 1000 * 1000;
>  			display_throughput(progress, byte_count);
> -		} else if (!strcmp(line.buf, "update"))
> +		} else if (!strcmp(line.buf, "update")) {
>  			progress_test_force_update();
> -		else
> +		} else if (!strcmp(line.buf, "stop")) {
> +			stop_progress(&progress);
> +		} else {

And 'stop' doesn't take any args. Ok. Do you need the {}?

>  			die("invalid input: '%s'\n", line.buf);
> +		}
>  	}
> -	stop_progress(&progress);
> +	free(detached_title);
>  
>  	return 0;
>  }
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index 22058b503ac..ca96ac1fa55 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -17,6 +17,7 @@ test_expect_success 'simple progress display' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 0

Does it need the total arg?

>  	update
>  	progress 1
>  	update
> @@ -88,16 +92,15 @@ Working hard.......2.........3.........4.........5.........6:
>  EOF
>  
>  	cat >in <<-\EOF &&
> -	update
Was it intended to drop the 'update' line here? Does this not change the
content of the test?
> +	start 100000 Working hard.......2.........3.........4.........5.........6
>  	progress 1
>  	update
>  	progress 2
>  	progress 10000
>  	progress 100000
> +	stop
>  	EOF
> -	test-tool progress --total=100000 \
> -		"Working hard.......2.........3.........4.........5.........6" \
> -		<in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out

With whichever nits seem appropriate,

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
