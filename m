Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A32C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 12:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiITMfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiITMfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 08:35:21 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D063F2C
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 05:35:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e205so2103384iof.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GFZrs2UI/RWz4claDSZ6j+hNx9LDhlCU1EuaBY7xxkY=;
        b=Wwqq/VBR/VgQjXNgen2yHwdfbh6ZdkL2NFO3mxwpZeYc844j6cbzwn2XnkwX1oLUf7
         +RM0855PgJd9W4CvReqNaJTv75HuUIt5Mm+lreScn3NIjacAZ8lK7oSrdLh1tP5lCyE9
         496sT+K5mBN9rzRYMTbMtCGc1wD3feGIJj5vC4GFHZRDIQohaetPJhQ0YEwJ9H3b8BBi
         HWP6wBdi5kmnzLnBwsOj1rTQDnw8Mx9K3XN0Ym9nMIhljqAtQgiZ3IyPDnTNShI7JN2l
         QZK33T7VVHEbumOARGeN7/KWg8ZSF3/xCj3h47FQ0KNyaTDB5vWQrU1fdIq8HkH3LMkg
         vsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GFZrs2UI/RWz4claDSZ6j+hNx9LDhlCU1EuaBY7xxkY=;
        b=hXG8cIJGKzxOmspt2aqvEb2xhw1Tyb+m+dhEzWj088T798Ukiyso33ut5ozYylPccv
         ODKt4ifaYT135RilK4+5kI72h34uyxXoYR8zrkf/TSBQVFpjUCMWwY+ASAXI4bXfSgTI
         Ad8+Es7kruJk+Mu6RIXQ+6bTe9se6bciIin0rEfSBwxGIcpV+DxyMXogaGMJ9I0ZwXGU
         GuJaUEOd9SqAp9EfD+yhRGUGq5UOkrK4xPQlv/NxamUo8hxkQZXIhxg1rXu45/RY0+cS
         o3sXXgU4sZHgKg0/5q89HEvs4EiOEmsyZpWCkAkJFgMH4EVBqLe59rGIDGYDcYO8Lwxt
         6iPg==
X-Gm-Message-State: ACrzQf3jFkxBE10ildG+rpyP0RT+v5aLkc5MedUA2tWycYTNCCSumH21
        YVP8AQXVf53q5B823AkPRFW+oCg2P0jv
X-Google-Smtp-Source: AA6agR6lE7dS007FT+U/L1HWM3NqXxNLGlk47Veg4PI16tnjMzj9+3s6r18unqSLItmtOQSI4p6U2g==
X-Received: by 2002:a02:7a4a:0:b0:35a:338e:e9ef with SMTP id z10-20020a027a4a000000b0035a338ee9efmr11067639jad.34.1663677316907;
        Tue, 20 Sep 2022 05:35:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ece2:5e56:6003:4064? ([2600:1700:e72:80a0:ece2:5e56:6003:4064])
        by smtp.gmail.com with ESMTPSA id z15-20020a92cecf000000b002eb52f831f6sm15524ilq.57.2022.09.20.05.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:35:16 -0700 (PDT)
Message-ID: <84848326-5cd9-b5b9-2dcb-a6d49879f47b@github.com>
Date:   Tue, 20 Sep 2022 08:35:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] builtin/diagnose.c: don't translate the two mode values
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        vdye@github.com, gitster@pobox.com
References: <20220920050632.326307-1-alexhenrie24@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220920050632.326307-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2022 1:06 AM, Alex Henrie wrote:
> These strings are not translatable in the diagnose_options array in
> diagnose.c. Don't translate them in builtin/diagnose.c either.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/diagnose.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/diagnose.c b/builtin/diagnose.c
> index cd260c2015..576e0e8e38 100644
> --- a/builtin/diagnose.c
> +++ b/builtin/diagnose.c
> @@ -22,7 +22,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
>  			   N_("specify a destination for the diagnostics archive")),
>  		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
>  			   N_("specify a strftime format suffix for the filename")),
> -		OPT_CALLBACK_F(0, "mode", &mode, N_("(stats|all)"),
> +		OPT_CALLBACK_F(0, "mode", &mode, "(stats|all)",
>  			       N_("specify the content of the diagnostic archive"),

In terms of the existing string, this makes sense. Initially, I
thought that maybe we would rather have N_("mode") to match the
N_("format") in the above. Then, I went poking around to see what
patterns we had for these across the codebase (never a good idea).

An example similar to what you propose exists in builtin/branch.c:

		OPT_CALLBACK_F('t', "track",  &track, "(direct|inherit)",
			N_("set branch tracking configuration"),
			PARSE_OPT_OPTARG,
			parse_opt_tracking_mode),

or this instance in builtin/checkout-index.c:

		OPT_CALLBACK_F(0, "stage", NULL, "(1|2|3|all)",
			N_("copy out the files from named stage"),

In diff.c, the descriptors exist in angle brackets, so the right thing
would be N_("<mode>"). This seems non-standard compared to most other
places.

Here is a similar stale translatable regex in diff.c:

		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
			       N_("select files by diff type"),

So if you are looking into these kinds of replacements, it might be
good to add instances like this. They are less important to the 2.38.0
release, though.

This long-winded email is all just to say that I've looked into the
standard way to handle this and agree that you are changing the code
to match our best practices.

Thanks,
-Stolee
