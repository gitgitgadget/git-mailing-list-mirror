Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E13C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434A46120C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhJUWdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUWdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:33:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B79C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:30:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r4so2341755edi.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q1FjZL2XzIqxdPR4f5TblM0aUX8yN64MkULUW2cbzDs=;
        b=HRCVLTX7PJTypc9xrLD15mKrhZy13oHKE1W0E5j4/quxx65uiDQ0tcASLUO+5MGdUO
         IZonU/BGtZZN/1iAaHWGoBqd0YOJRODpqhtQF91NRsOQryWON7zPqHlgzuqskY9ya88/
         0SIZyVZcsiPvEYZwbCKYfmYaEXK+PHIAkhYCpvsHmuJA6NTfDVT5oV+XREeWjhymPtwt
         yyGykDqHz9RZO5peY0o868GH+sT3kK4enJkh0Tqn1YQhAG/t9uHfCQKF2bWhU/Pnqios
         BJvXbDnidymYacDxwmmR8PN1QOpoTo68etXw84OhYfWxNYDkmwvSolx5/lADYzGsmcFm
         4dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q1FjZL2XzIqxdPR4f5TblM0aUX8yN64MkULUW2cbzDs=;
        b=Js5r1b644f5ogjIUzX7Tv3LS9upCxuqYewquhzPpqvLwtf43kIvL6SAjRyct2KFKru
         IG4tBpmxq7xC/0DK5yPA5lBaB6S2lpmjSHLCtZIvLUfONvX/94IoZv5kRNPNlVO/xr8g
         z2ZilcDBqu8KZbjU1o+65RQREHYPW8HKfz8dMUcxJUUIG4Er7U0DdKC8joYX6ZFlUYPR
         zKrGIhCoLC5/5NnjeHnqrohfEHmqiTzhVtLXmc5mgHBH2LVYYhYWLa/p/95eUCiHxuGe
         3sGSy05uBMxoo5IJohMIkgQAHkVtDJMbtnZjJ8bEkycxYs4zL1JvlBEtHYYctIfnN/io
         wk2g==
X-Gm-Message-State: AOAM5327u08Qr3P2dGCCSNykqNHACEpAElMIjnin5MX6r+ztmnDh79qa
        tJNSZjKOGQM1UEi9R7+00ls=
X-Google-Smtp-Source: ABdhPJykeQItYpYxegr2ypI3LkZdNUCehZl4bFDkDiBv3Un9c0VHLLmgVTdo4NdcBigNFS9Dma8jkA==
X-Received: by 2002:aa7:c359:: with SMTP id j25mr11508791edr.348.1634855449957;
        Thu, 21 Oct 2021 15:30:49 -0700 (PDT)
Received: from szeder.dev (94-21-23-225.pool.digikabel.hu. [94.21.23.225])
        by smtp.gmail.com with ESMTPSA id z4sm4014778edd.46.2021.10.21.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 15:30:49 -0700 (PDT)
Date:   Fri, 22 Oct 2021 00:30:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 03/10] progress.c tests: make start/stop verbs on stdin
Message-ID: <20211021223044.GA3615@szeder.dev>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-03.10-045d58d8201-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-03.10-045d58d8201-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:19AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Subject: [PATCH v3 03/10] progress.c tests: make start/stop verbs on stdin

s/verbs/commands/ or instructions.

Please call them what they are in the context of Git in general, or in
a test script in particular, instead of what part of speech they would
be if they were to appear in a sentence.

> Change the usage of the "test-tool progress" introduced in
> 2bb74b53a49 (Test the progress display, 2019-09-16) to take command
> like "start" and "stop" on stdin, instead of running them implicitly.
> 
> This makes for tests that are easier to read, since the recipe will
> mirror the API usage, and allows for easily testing invalid usage that
> would yield (or should yield) a BUG(), e.g. providing two "start"
> calls in a row. A subsequent commit will add such tests.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/helper/test-progress.c    | 37 ++++++++++++++++-------
>  t/t0500-progress-display.sh | 58 +++++++++++++++++++++++--------------
>  2 files changed, 63 insertions(+), 32 deletions(-)
> 
> diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
> index 50fd3be3dad..45ccbafa9da 100644
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
> @@ -19,34 +23,43 @@
>  #include "parse-options.h"
>  #include "progress.h"
>  #include "strbuf.h"
> +#include "string-list.h"
>  
>  int cmd__progress(int argc, const char **argv)
>  {
> -	int total = 0;
> -	const char *title;
> +	const char *const default_title = "Working hard";
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +	const struct string_list_item *item;
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
>  
>  	progress_testing = 1;
> -	progress = start_progress(title, total);
>  	while (strbuf_getline(&line, stdin) != EOF) {
>  		char *end;
>  
> -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
> +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
> +			uint64_t total = strtoull(end, &end, 10);
> +			if (*end == '\0') {
> +				progress = start_progress(default_title, total);
> +			} else if (*end == ' ') {
> +				item = string_list_insert(&list, end + 1);
> +				progress = start_progress(item->string, total);

Why is it necessary to use a string_list here?  This is the only place
where it is used, so I don't understand why we should store anything
in it.

> +			} else {
> +				die("invalid input: '%s'\n", line.buf);
> +			}
> +		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
>  			uint64_t item_count = strtoull(end, &end, 10);
>  			if (*end != '\0')
>  				die("invalid input: '%s'\n", line.buf);
> @@ -65,12 +78,14 @@ int cmd__progress(int argc, const char **argv)
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
> +	string_list_clear(&list, 0);
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
> -		<in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -89,16 +93,16 @@ Working hard.......2.........3.........4.........5.........6:
>  EOF
>  
>  	cat >in <<-\EOF &&
> +	start 100000 Working hard.......2.........3.........4.........5.........6
>  	update
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
> @@ -117,14 +121,14 @@ Working hard.......2.........3.........4.........5.........6:
>  EOF
>  
>  	cat >in <<-\EOF &&
> +	start 100000 Working hard.......2.........3.........4.........5.........6
>  	progress 25000
>  	progress 50000
>  	progress 75000
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
> @@ -141,14 +145,14 @@ Working hard.......2.........3.........4.........5.........6.........7.........:
>  EOF
>  
>  	cat >in <<-\EOF &&
> +	start 100000 Working hard.......2.........3.........4.........5.........6.........7.........
>  	progress 25000
>  	progress 50000
>  	progress 75000
>  	progress 100000
> +	stop
>  	EOF
> -	test-tool progress --total=100000 \
> -		"Working hard.......2.........3.........4.........5.........6.........7........." \
> -		<in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -165,12 +169,14 @@ test_expect_success 'progress shortens - crazy caller' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 1000
>  	progress 100
>  	progress 200
>  	progress 1
>  	progress 1000
> +	stop
>  	EOF
> -	test-tool progress --total=1000 "Working hard" <in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -186,6 +192,7 @@ test_expect_success 'progress display with throughput' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 0
>  	throughput 102400 1000
>  	update
>  	progress 10
> @@ -198,8 +205,9 @@ test_expect_success 'progress display with throughput' '
>  	throughput 409600 4000
>  	update
>  	progress 40
> +	stop
>  	EOF
> -	test-tool progress "Working hard" <in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -215,6 +223,7 @@ test_expect_success 'progress display with throughput and total' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 40
>  	throughput 102400 1000
>  	progress 10
>  	throughput 204800 2000
> @@ -223,8 +232,9 @@ test_expect_success 'progress display with throughput and total' '
>  	progress 30
>  	throughput 409600 4000
>  	progress 40
> +	stop
>  	EOF
> -	test-tool progress --total=40 "Working hard" <in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -240,6 +250,7 @@ test_expect_success 'cover up after throughput shortens' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 0
>  	throughput 409600 1000
>  	update
>  	progress 1
> @@ -252,8 +263,9 @@ test_expect_success 'cover up after throughput shortens' '
>  	throughput 1638400 4000
>  	update
>  	progress 4
> +	stop
>  	EOF
> -	test-tool progress "Working hard" <in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -268,6 +280,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 0
>  	throughput 1 1000
>  	update
>  	progress 1
> @@ -277,8 +290,9 @@ test_expect_success 'cover up after throughput shortens a lot' '
>  	throughput 3145728 3000
>  	update
>  	progress 3
> +	stop
>  	EOF
> -	test-tool progress "Working hard" <in 2>stderr &&
> +	test-tool progress <in 2>stderr &&
>  
>  	show_cr <stderr >out &&
>  	test_cmp expect out
> @@ -286,6 +300,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
>  
>  test_expect_success 'progress generates traces' '
>  	cat >in <<-\EOF &&
> +	start 40
>  	throughput 102400 1000
>  	update
>  	progress 10
> @@ -298,10 +313,11 @@ test_expect_success 'progress generates traces' '
>  	throughput 409600 4000
>  	update
>  	progress 40
> +	stop
>  	EOF
>  
> -	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
> -		"Working hard" <in 2>stderr &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress \
> +		<in 2>stderr &&
>  
>  	# t0212/parse_events.perl intentionally omits regions and data.
>  	test_region progress "Working hard" trace.event &&
> -- 
> 2.33.1.1346.g48288c3c089
> 
