Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB463C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991D1610D0
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbhHXSCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhHXSBz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:01:55 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADBFC029828
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:45:58 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i3-20020a056830210300b0051af5666070so38511297otc.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZGc51i0m8YMB7V5ebDlOB/yykeZBtVXMQQiC5UcCgY=;
        b=naVsCaXn1GhKeedvvCiicpbKz1obC1FXxR7hqBQWIjGxG/skHoB1UMHizSZ8Dj/uec
         01Wrey353C9lP6NRkNB1zavRDtMHU2npm7U44AqeIfSEsf8bUzOdEkS2rdVkaqL+HoV0
         clw11i0MNP5OUqNmLnxk7xUK7DOCHUXtsEssKpc3N/tFdzFrnVrRc0vBJpcBR01F0w9K
         uRIkkbsqt3j4U/95uljJHdwn1PeoO+AgujyBo7yDqZvh68yJrxkEnpl+sKHg3tDMCDue
         LVEgOfiawZ5+Nv/0s9bCYGaIP9fuCcCmNcOcG8dmADGhkfRLTBPPKc2vZTMyQOQga8sz
         QsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZGc51i0m8YMB7V5ebDlOB/yykeZBtVXMQQiC5UcCgY=;
        b=my3CJFTKuZAMa/B6innQIMXqBwSG8wdvffcSLOSO6WeEgkstUA5+ICmkaumqIa0V3l
         0FbpnZq49Ibh7O10M7l3ek94Iu+aS5HU5KQzq8t0SId+ZcK4snlAAkUz8v6RV+jHIJlQ
         CVOEnRjzl3lQb43U192IJoiW9K6e+3xauzONnVQw2aBYr08konpvVSr3M2WSJyzsnEgu
         hPDF/SmS28uvqrPWIuX6/HKymRIbGcQYNtqq2q/7A0rDPY5++1uuqpiYtwR4mu5/l4/I
         3YNolOii68GL1d1fRa1JLObTFzavma3Qu6MHA31KsLIYiryN6h4CWCQBBgkOJy8GBU33
         AzWQ==
X-Gm-Message-State: AOAM530k5S9TW1IiVbwvC4JlshD/QjZHqfo+uj0FAcAx+wgouN23j1/W
        6VQq68eG0p456uB8OdCe0fM=
X-Google-Smtp-Source: ABdhPJyjf2aWFc0VhfLC0R0XCkL3iPf8T1RuWXTJVXSeqkag5laDBYjyaFIE/zX2ilJDiYy8JDu6jQ==
X-Received: by 2002:a05:6808:7ce:: with SMTP id f14mr3696813oij.119.1629827157360;
        Tue, 24 Aug 2021 10:45:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id bd27sm1478343oib.43.2021.08.24.10.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:45:56 -0700 (PDT)
Subject: Re: [PATCH v8 2/3] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210823204011.87023-1-lenaic@lhuard.fr>
 <20210823204011.87023-3-lenaic@lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd93fdca-3b37-2d71-2e6c-6e0e38ad098f@gmail.com>
Date:   Tue, 24 Aug 2021 13:45:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823204011.87023-3-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 4:40 PM, Lénaïc Huard wrote:> + * Ex.:
> + *   GIT_TEST_MAINT_SCHEDULER not set
> + *     +-------+-------------------------------------------------+
> + *     | Input |                     Output                      |
> + *     | *cmd  | return code |       *cmd        | *is_available |
> + *     +-------+-------------+-------------------+---------------+
> + *     | "foo" |    false    | "foo" (unchanged) |  (unchanged)  |
> + *     +-------+-------------+-------------------+---------------+
> + *
> + *   GIT_TEST_MAINT_SCHEDULER set to “foo:./mock_foo.sh,bar:./mock_bar.sh”
> + *     +-------+-------------------------------------------------+
> + *     | Input |                     Output                      |
> + *     | *cmd  | return code |       *cmd        | *is_available |
> + *     +-------+-------------+-------------------+---------------+
> + *     | "foo" |    true     |  "./mock.foo.sh"  |     true      |
> + *     | "qux" |    true     | "qux" (unchanged) |     false     |
> + *     +-------+-------------+-------------------+---------------+
> + */

Thank you for updating to this ASCII table. It has the same amount
of visual information without requiring special characters.

> +static int is_launchctl_available(void)
> +{
> +	const char *cmd = "launchctl";
> +	int is_available;
> +	if (get_schedule_cmd(&cmd, &is_available))
> +		return is_available;
> +
> +#ifdef __APPLE__
> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}

I find this use of #ifdef to be perfectly fine. Adding a layer of
indirection into the compat layer through another macro is
unnecessary, in my opinion.

Thanks,
-Stolee
