Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE22C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 01:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhL0BKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 20:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhL0BKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 20:10:17 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8EC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:10:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so7657172wmb.0
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dG06fYdsIr6SZbIShpSaLLZzQAENG+Y5jJnmd08xCDI=;
        b=bmx/DOg0jiXzKRzH+8QRZ1OltW6v8BiFVV6fw6Mtc+Oa8d6XvlUs1gMwAJjHxwykst
         Jpdi7ZuyWzLJGwodkL1y2/lau5Z5o3gXBjaxtGi76W6PwL/y8VTiOypiwFk1605bfjnh
         sFccVeHscuGAEkIzVPMkKAilG6zN0gH/wa9KVk3qALzEbODOKPMc73jzmDmstDeKJysY
         g/69MEW+u5met4WXADchXM/l33j8fDRpSf+iukk4YQBbo85HTk684kTQQZSwm0JafZbj
         afVVfCaE7iwmSVYTGoZjrm2JfRcWcP09qkKqvuuKn9C5NpBnFXPIuXxbv1KkerO5bcih
         EMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dG06fYdsIr6SZbIShpSaLLZzQAENG+Y5jJnmd08xCDI=;
        b=z9Sr4I6couYbXTEabEGPwyvD1lf3GK5vBZHMhlakG83Nc3hL+LPVo8gOFl6KA0/zep
         3RSjuzDzGC95T+AF/etf4FPuKp1APdPQjNI034cR0s4TukFDibSAkqlGSwKRRZJ1UkR5
         oAqIJEX/ByTDt6xWBLn6brSNbcMexVWS8l2fxyjTtj+PLk75543sJtj7JKMj3I9zRBYe
         WMqCeXDcOJze9r7ungALfqQNMwj4D5kKFnY3ko5ihRqG3Fp4n91bOUQoJM+Kyu8gbSkw
         2Fc+r5rXBrrCFf4qNDJUx0myDa9zObvC2V8UFgZ6IhdFPfPDyrdEmtiwp9NfnbhT3X1m
         1A+Q==
X-Gm-Message-State: AOAM5314Kr9BT0EUeq5csEvwwhyjkwojc9SZerbo9xI+4eXOOXudrpsH
        0JHDglNeu7FXNT+rxvyv5RA=
X-Google-Smtp-Source: ABdhPJx8YOQxRkHB6nK6I4AcRggkR40yK7BViTfdzHHaenLGcgAttR4gHdNO2BjejmCdhA+Qw8f8LQ==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr11711450wml.0.1640567415964;
        Sun, 26 Dec 2021 17:10:15 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id p1sm14718834wrr.75.2021.12.26.17.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 17:10:15 -0800 (PST)
Date:   Mon, 27 Dec 2021 02:10:13 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v7 3/7] progress.c tests: make start/stop commands on
 stdin
Message-ID: <20211227011013.3ngeh57llxnknphf@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
 <patch-v7-3.7-d685c248686-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v7-3.7-d685c248686-20211217T041945Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 05:24:58AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change the usage of the "test-tool progress" introduced in
> 2bb74b53a49 (Test the progress display, 2019-09-16) to take command
> like "start" and "stop" on stdin, instead of running them implicitly.
> 
> This makes for tests that are easier to read, since the recipe will
> mirror the API usage, and allows for easily testing invalid usage that

(Of course invalid API usage wasn't really a problem before, but it's good
that you mention the upcoming tests, to calm any concerns)

> would yield (or should yield) a BUG(), e.g. providing two "start"
> calls in a row. A subsequent commit will add such tests.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/helper/test-progress.c    | 46 ++++++++++++++++++++++-------
>  t/t0500-progress-display.sh | 58 +++++++++++++++++++++++--------------
>  2 files changed, 72 insertions(+), 32 deletions(-)
> 
> diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
> index 50fd3be3dad..1435c28e950 100644
> --- a/t/helper/test-progress.c
> +++ b/t/helper/test-progress.c
> @@ -3,6 +3,9 @@
>   *
>   * Reads instructions from standard input, one instruction per line:
>   *
> + *   "start <total>[ <title>]" - Call start_progress(title, total),
> + *                               Uses the default title of "Working hard"
> + *                               if the " <title>" is omitted.
>   *   "progress <items>" - Call display_progress() with the given item count
>   *                        as parameter.
>   *   "throughput <bytes> <millis> - Call display_throughput() with the given
> @@ -10,6 +13,7 @@
>   *                                  specify the time elapsed since the
>   *                                  start_progress() call.
>   *   "update" - Set the 'progress_update' flag.
> + *   "stop" - Call stop_progress().
>   *
>   * See 't0500-progress-display.sh' for examples.
>   */
> @@ -19,34 +23,52 @@
>  #include "parse-options.h"
>  #include "progress.h"
>  #include "strbuf.h"
> +#include "string-list.h"
> +
> +/*
> + * We can't use "end + 1" as an argument to start_progress() below, it
> + * doesn't xstrdup() its "title" argument. We need to hold onto a
> + * valid "char *" for it until the end.
> + */
> +static char *dup_title(struct string_list *titles, const char *title)
> +{
> +	return string_list_insert(titles, title)->string;
> +}

It seems weird to reference someone else's local variables in "end + 1" here.
How about inlining this function instead?

			} else if (*end == ' ') {
				char *title_duped = string_list_insert(&titles, end + 1)->string;
				progress = start_progress(title_duped, total);
			} else {

and maybe add a comment there, but I'm not sure if we still need it.

>  
>  int cmd__progress(int argc, const char **argv)
>  {
> -	int total = 0;
> -	const char *title;
> +	const char *const default_title = "Working hard";
> +	struct string_list titles = STRING_LIST_INIT_DUP;
>  	struct strbuf line = STRBUF_INIT;
> -	struct progress *progress;
> +	struct progress *progress = NULL;
>  
>  	const char *usage[] = {
> -		"test-tool progress [--total=<n>] <progress-title>",
> +		"test-tool progress <stdin",
>  		NULL

(unrelated: I'd always add a trailing comma if I can, even though in this case it won't ever matter)

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
>  
>  	progress_testing = 1;
> -	progress = start_progress(title, total);
>  	while (strbuf_getline(&line, stdin) != EOF) {
>  		char *end;
>  
> -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
> +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
> +			uint64_t total = strtoull(end, &end, 10);
> +			if (*end == '\0')
> +				progress = start_progress(default_title, total);
> +			else if (*end == ' ')
> +				progress = start_progress(dup_title(&titles,
> +								    end + 1),
> +							  total);
> +			else
> +				die("invalid input: '%s'\n", line.buf);
> +		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
>  			uint64_t item_count = strtoull(end, &end, 10);
>  			if (*end != '\0')
>  				die("invalid input: '%s'\n", line.buf);
> @@ -65,12 +87,14 @@ int cmd__progress(int argc, const char **argv)
>  			display_throughput(progress, byte_count);
>  		} else if (!strcmp(line.buf, "update")) {
>  			progress_test_force_update();
> +		} else if (!strcmp(line.buf, "stop")) {
> +			stop_progress(&progress);
>  		} else {
>  			die("invalid input: '%s'\n", line.buf);
>  		}
>  	}
> -	stop_progress(&progress);
>  	strbuf_release(&line);
> +	string_list_clear(&titles, 0);
>  
>  	return 0;
>  }
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index f37cf2eb9c9..27ab4218b01 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -18,6 +18,7 @@ test_expect_success 'simple progress display' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 0
>  	update
>  	progress 1
>  	update
> @@ -26,8 +27,9 @@ test_expect_success 'simple progress display' '
>  	progress 4
>  	update
>  	progress 5
> +	stop
>  	EOF
> -	test-tool progress "Working hard" <in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -42,11 +44,13 @@ test_expect_success 'progress display with total' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 3
>  	progress 1
>  	progress 2
>  	progress 3
> +	stop
>  	EOF
> -	test-tool progress --total=3 "Working hard" <in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -63,14 +67,14 @@ Working hard.......2.........3.........4.........5.........6:
>  EOF
>  
>  	cat >in <<-\EOF &&
> +	start 100000 Working hard.......2.........3.........4.........5.........6
>  	progress 100
>  	progress 1000
>  	progress 10000
>  	progress 100000
> +	stop
>  	EOF
> -	test-tool progress --total=100000 \
> -		"Working hard.......2.........3.........4.........5.........6" \

I don't know enough about progress tests to judge if this is better.
The start invocation does look nicer, but it might feel weird to always
include "stop". We could do that automatically but then we're no longer
mirroring the API...

> -		<in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
