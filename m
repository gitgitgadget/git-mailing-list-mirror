Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F7E1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfJGRrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:47:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41124 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfJGRrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:47:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id i26so3444231qtm.8
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xel+pOBKbODaeiO7UYik3TbdoQBRifhXJFM8N2nbTHw=;
        b=CpYErgzzEO7k+mdMxbgbKl5wt7lD5FJfXVqswgYk4drt6QrD/ESzYSOGGw5kdjT7O4
         P4bI2PBMZu4lgkUnKytZgMhIubtv9lJkaHsnxYIUmO3//XrR/mZLNYonW49Vw6W0TTfo
         p3BNXXBdN4fmFA6XWFbCHrPhYA5v9hNlhAQjpThmxkvWaPb5cx8EhAkOKQ1WOBe9U6o9
         V7E8Prga3w2fiJGNYIYLarKZMDPSSUKIfu89IRilt2UwFES3R7sO911bQos7r2ZAaWrP
         oLpIT2VDFQPuq9vYwlWrdIMFcVktSBboH2MbJ4MEs51iYHgIZZXlzKsEDmRezWeVYH7b
         Ylbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xel+pOBKbODaeiO7UYik3TbdoQBRifhXJFM8N2nbTHw=;
        b=UHbeci0oHBJnre6o9h4XP04EfJESh3Dbbde+aF7j4hf1dZhQugR+Hyaz0eU4fb3ggD
         qCVq3c+4IAPmPiZJEhECNaknpzyyhzS725sJylODcb41e/1mdIZdfsCv0nptgcSHLLij
         J+6MLT/D5+vL4f3xIVzGAPN17uVl2LNNnyeX9LKxEQ2GaXANSoID2twtONw48Gz0ec/6
         NGTa7zmKfeAzlTuH3lE9vhVFvxevQLtrXCCWmtJ6d5aOG4j2BX1yNBX9cPkpp6WhJPVo
         OZJ6cgFX7UK2F+qAXa7F9vKt/ZbpX6Lqf+F/DtiTWxQkOTqbfGpoTuw30NvTR9LxJLEr
         NxcQ==
X-Gm-Message-State: APjAAAUUSiLRxdqzAwMYJMyL1M4KO5qiAwaSOFzzlw9w7xN6k6FNus8i
        Pn2GwV39E97gNuGcH1S2Stk=
X-Google-Smtp-Source: APXvYqxOt+1GBk48+LTZH6/FfGYojs2XT3YMMgCk4AdoDZFKmpF4i9smE6H+hVpEufpPNhYeIMxYbw==
X-Received: by 2002:ac8:1812:: with SMTP id q18mr31092721qtj.192.1570470436446;
        Mon, 07 Oct 2019 10:47:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13f:fd03:573e:b9a8:e7f6? ([2001:4898:a800:1010:ae3a:573e:b9a8:e7f6])
        by smtp.gmail.com with ESMTPSA id 22sm7602650qkj.0.2019.10.07.10.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:47:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] quote: handle numm and empty strings in
 sq_quote_buf_pretty
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.314.v2.git.gitgitgadget@gmail.com>
 <pull.314.v3.git.gitgitgadget@gmail.com>
 <399fe02cb155770fc2d937607014677874075458.1570465059.git.gitgitgadget@gmail.com>
 <CAPig+cRtL1YPxTHfZ+uYek6hBbRmKJgSNiPNX_zM-Tc_7LnhWA@mail.gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <74a65796-ee00-66b5-a2e9-3173b057d7eb@gmail.com>
Date:   Mon, 7 Oct 2019 13:47:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRtL1YPxTHfZ+uYek6hBbRmKJgSNiPNX_zM-Tc_7LnhWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/7/2019 1:27 PM, Eric Sunshine wrote:
> On Mon, Oct 7, 2019 at 12:17 PM Garima Singh via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> quote: handle numm and empty strings in sq_quote_buf_pretty
> 
> What is "numm"?

Typo. Fixing in next update. 

> What does it mean to "handle" these things? A possible rewrite of the
> subject to explain the problem more precisely rather than using
> generalizations might be:
> 
>     sq_quote_buf_pretty: don't drop empty arguments
> 
>> The sq_quote_buf_pretty() function does not emit anything
>> when the incoming string is empty, but the function is to
>> accumulate command line arguments, properly quoted as
>> necessary, and the right way to add an argument that is an
>> empty string is to show it quoted, i.e. ''. We warn the caller
>> with the BUG macro is they pass in a NULL.
> 
> s/is they/if they/

Typo. Fixing in next update. 

> By including the final sentence in this paragraph, the reader is
> confused into thinking that warning the caller with BUG() is the
> overall purpose of this patch and is the "fix" for the stated problem.
> At minimum, the final sentence should be yanked out to its own
> paragraph or, better yet, dropped altogether since it's of little
> importance in the overall scheme of the patch.
> 
> As a reader of this commit message, I find it difficult to understand
> what problem it's trying to solve since the problem and solution and
> existing behavior are presented in a circuitous way which doesn't make
> any of them stand out clearly. Here's a possible rewrite:
> 
>     sq_quote_buf_pretty: don't drop empty arguments
> 
>     Empty arguments passed on a command-line should be represented by
>     a zero-length quoted string, however, sq_quote_buf_pretty()
>     incorrectly drops these arguments altogether. Fix this problem by
>     ensuring that such arguments are emitted as '' instead.

Works for me. Thanks! 

>> Reported by: Junio Hamano <gitster@pobox.com>
>> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
>> ---
>> diff --git a/quote.c b/quote.c
>> @@ -48,6 +48,16 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
>> +       /* In case of null tokens, warn the user of the BUG in their call. */
>> +       if (!src)
>> +               BUG("Cannot append a NULL token to the buffer");
> 
> The comment merely repeats what the code itself already says clearly,
> thus adds no value and ought to be dropped.
> 
> Moreover, this entire check seems superfluous since the program will
> crash anyhow as soon as 'src' is dereferenced (just below), thus the
> programmer will find out soon enough about the error. I'd suggest
> dropping this check entirely since it's not adding any value.
> 

Fair enough. Removing the comment. Leaving the check. I would
rather the caller of the function know what went wrong instead
of a segfault. 

>> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
>> @@ -37,4 +37,11 @@ test_expect_success 'looping aliases - internal execution' '
>> +test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '
> 
> Is "parses" the correct word? Should it be "formats" or something?
> 
Sure. 

> Also, the bit about "using sq_quote_buf_pretty" lets an implementation
> detail bleed unnecessarily into the test suite, and that detail could
> become outdated at some point (say, if some function ever replaces
> that one, for instance). It should be sufficient for the test title
> merely to mention that it is checking that empty arguments are handled
> properly. So, perhaps:
> 
>     test_expect_success 'run-command formats empty args properly' '
> 

Sure. 
