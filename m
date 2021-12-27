Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE7C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 01:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhL0BLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 20:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhL0BLE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 20:11:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEEDC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:11:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v11so29461124wrw.10
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KjBKeOgvRlzSnBu8N4wysuRE//uuJfv+TG1AZ6UsPtg=;
        b=OHeedTqbTbb4PVfvKr0UXgR25p52QdsRPD9BhmmXtbzMk+Ofn2p6FZH0/rgyluSgg9
         F4mFxOq0zNzHawUNTyqxvnUgfy5ofN1N8dAuwOZzbJE5f0Lsi/AMTPdBqPHxdCXghjWO
         XXvHdoc9GbLYK2cEYZ/4doHa9XxLvkz4hMXjpg9mn1mZeQ2ia5V6CaiXsO7d/7kfR1ja
         EtHASKbk7ymEjbAj3L5PaNH5X1IwkYCInJdu/2D4bNX9WJYt21gbl+l/AFRrARx8aEiU
         4IDJe7tTxN+83/N568hp7SJtPOpW7cqX3Ln5BKJlDXslh+aQRbtrC5fZsgQYR8+3171W
         JyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KjBKeOgvRlzSnBu8N4wysuRE//uuJfv+TG1AZ6UsPtg=;
        b=KbbneCcU35O/wgH+CJXcU3hSzHSu+HMDFqYxjy2NFIAjbXkRvRP+fqrtMADnkxrEcO
         N8hirK3QTRCkjugGqqsd1AQRUjRQdRvx2sQni8hrzeOkdaXc/Nv1mV9Bvo/Uex/4HJ8Z
         ArGKYm281967ec4WNJxRPhjop1W04MlxgKMMcyYnAy7zWt9phWhIe95N53FDXuuITkBJ
         fHxSpIH4WQsOOMRNcXVXmXa54GESfxVp20BgmDUtzxRRE2eQeQia4jlVvEHgBSnkYGYa
         k0h995G1EGnK9qcishHyMCADk7RCdSa+0KpwG/os+87Y+JQz8Bl8zJRmm/B/XQaAudj9
         zqxg==
X-Gm-Message-State: AOAM533wPzvNv5wPrYj3DJy/K6xmiQjJXyZvJBXoMYDaMYS4VjWhJ6ux
        8qHlbsMflCmLLvXrxC94Pyg=
X-Google-Smtp-Source: ABdhPJzq/vYsl5Q4dw7GWL8M3o1DaHSPeuid0vdHDUU1zteD/76tv4Pl+VXo9Hvrw/ao3euOOFM5Ng==
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr10483188wrs.712.1640567462865;
        Sun, 26 Dec 2021 17:11:02 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id c2sm15328553wri.50.2021.12.26.17.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 17:11:02 -0800 (PST)
Date:   Mon, 27 Dec 2021 02:11:00 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v7 4/7] progress.c tests: test some invalid usage
Message-ID: <20211227011100.g3pwc67onlc7qs7t@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
 <patch-v7-4.7-40e446da277-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v7-4.7-40e446da277-20211217T041945Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 05:24:59AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Test what happens when we "stop" without a "start", omit the "stop"
> after a "start", or try to start two concurrent progress bars.

I think the concurrent case is missing (I guess that's not blocking)

> This extends the trace2 tests added in 98a13647408 (trace2: log progress
> time and throughput, 2020-05-12).
> 
> These tests are not merely testing the helper, but invalid API usage
> that can happen if the progress.c API is misused.
> 
> The "without stop" test will leak under SANITIZE=leak, since this
> buggy use of the API will leak memory. But let's not skip it entirely,
> or use the "!SANITIZE_LEAK" prerequisite check as we'd do with tests
> that we're skipping due to leaks we haven't fixed yet. Instead
> annotate the specific command that should skip leak checking with
> custom $LSAN_OPTIONS[1].
> 
> 1. https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t0500-progress-display.sh | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index 27ab4218b01..59e9f226ea4 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -325,4 +325,39 @@ test_expect_success 'progress generates traces' '
>  	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
>  '
>  
> +test_expect_success 'progress generates traces: stop / start' '
> +	cat >in <<-\EOF &&
> +	start 0
> +	stop
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace-startstop.event" test-tool progress \
> +		<in 2>stderr &&
> +	test_region progress "Working hard" trace-startstop.event
> +'
> +
> +test_expect_success 'progress generates traces: start without stop' '
> +	cat >in <<-\EOF &&
> +	start 0
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace-start.event" \
> +	LSAN_OPTIONS=detect_leaks=0 \
> +	test-tool progress \
> +		<in 2>stderr &&

nit: I personally prefer always indenting after continuation lines, like

	GIT_TRACE2_EVENT="$(pwd)/trace-start.event" \
		LSAN_OPTIONS=detect_leaks=0 \
		test-tool progress \
		<in 2>stderr &&

but we don't have a uniform style, so it doesn't really matter.

> +	grep region_enter.*progress trace-start.event &&
> +	! grep region_leave.*progress trace-start.event

should "!" be "test_must_fail"? Same below.

> +'
> +
> +test_expect_success 'progress generates traces: stop without start' '
> +	cat >in <<-\EOF &&
> +	stop
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace-stop.event" test-tool progress \
> +		<in 2>stderr &&
> +	! grep region_enter.*progress trace-stop.event &&
> +	! grep region_leave.*progress trace-stop.event
> +'
> +
>  test_done
> -- 
> 2.34.1.1119.g7a3fc8778ee
> 
