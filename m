Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FF71FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbcIAIBw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:01:52 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37773 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753420AbcIAIBv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:01:51 -0400
Received: by mail-wm0-f47.google.com with SMTP id v143so7937989wmv.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Npeg4G1PvcD/6CO9Lzv7QF+8WNpk/hWYfSWz78jZ+8=;
        b=EydHLD3dPNtse8FBgd4QoafSGbZlPYy7GXtvLClx/gzB0DuWOPFoZlHl2S2UKdd7Kt
         tq4PbjJbtVq5ssYQBvKdMva8SwulsiI7+uv/IwbfT3kOP3npXkz4N/CK7f0V22DLt9hm
         +nPXJvfD2zh6/FelMhOuOhqhIy7yCGSlilh755ZuoskkBATEcaanHKyP7CwCubK60rUw
         yXuQcL2SsAw2WI28t0SKHv7zxEeTmeaxFSaBhgLZZ3aCa7BDyfnLXn1dHY/d/0EvLFeW
         sdzeN2vswLdFF1Eb5sgM35kFlO4HNIw5M1MyEjM//IhVVq1G1Z7pDhqC/WkKhkoiW7i8
         Gocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Npeg4G1PvcD/6CO9Lzv7QF+8WNpk/hWYfSWz78jZ+8=;
        b=CT8EgsUKkGUTTHq23LFpNNWQ32yG5GcbqZqQ2ERLKlxndVZJEa+GNyYj5CifedGG6K
         sdaSYApLomeSrHUH7/yJMa9nYlA2XpCdsqGVUokM4tU9Og8MSCZ/h3rkK/Q/heEDMk2C
         VR8xHdRWasZkA7Cz5tjwwsP/G0dHsBGxScMZ5Xqt1LrMSX5m6XriiO3N8ggTlKEaZ+6D
         kXYiMgLdk6xS+kcIScACWNHvpF+MAoCP/RcVxyVV+OG+tqCJG3eInyI6z7bIs5RVFTSW
         SeXcgEhEI5NONs1+qdVgc+Ejht663DxxVh2iRRCH1ZfqErYOEz43s9RtwYcTatKb6nNx
         LRHA==
X-Gm-Message-State: AE9vXwMbfu9Z/7Ambl9lkuD9CYhXr6FjUUorYmNqkdZPaSsJ4HearbIydWQrdobuFH3GSEiPH6PwMOEpFa9ljA==
X-Received: by 10.28.61.11 with SMTP id k11mr12978858wma.34.1472716910229;
 Thu, 01 Sep 2016 01:01:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Thu, 1 Sep 2016 01:01:49 -0700 (PDT)
In-Reply-To: <CAGZ79kYnp_8iew33KQJK1TB0ROLthHBtvHqf3wVzFkh_JSq5MA@mail.gmail.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-7-chriscool@tuxfamily.org> <CAGZ79kYnp_8iew33KQJK1TB0ROLthHBtvHqf3wVzFkh_JSq5MA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Sep 2016 10:01:49 +0200
Message-ID: <CAP8UFD3RE6L17nQmvZTkx6wycsdG7EA9eM=tYQD8nrS445zg1w@mail.gmail.com>
Subject: Re: [PATCH v13 06/14] apply: make it possible to silently apply
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 12:07 AM, Stefan Beller <sbeller@google.com> wrote:
>> Printing on stdout, and calls to warning() or error() are not
>> taken care of in this patch, as that will be done in following
>> patches.
>
>> -               if (state->apply_verbosely)
>> +               if (state->apply_verbosity > verbosity_normal)
>>                         error(_("while searching for:\n%.*s"),
>>                               (int)(old - oldlines), oldlines);
>
> But this is an error(..) ?

Do you mean that it was a bug in the original code to print this error
only in verbose mode?

> Have you considered to replace all these print functions (error, warning,
> fprintf, printf, fprintf_ln) with another custom
>
>     int say_when_at_least(verbosity level, const char *fmt,...)
>
> ? (I guess that would be more invasive, but the result would be more
> consistent.)

My opinion is that there is a reason (or there should have been a
reason) why people decided to use error() instead of warning() for
example.
If I use say_when_at_least(verbosity level, const char *fmt,...) like
you suggest, how do I decide if error() or warning() is used to
actually print the error message?
Another parameter to this function (severity level?) is needed.

Anyway I don't think such a refactoring is needed.
