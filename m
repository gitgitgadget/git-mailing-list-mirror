Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC0F20229
	for <e@80x24.org>; Fri, 11 Nov 2016 05:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbcKKF0A (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 00:26:00 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35531 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbcKKFZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 00:25:59 -0500
Received: by mail-yw0-f194.google.com with SMTP id b66so387743ywh.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 21:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PzAysl1kVh5ewkroZKc5q/jo/njYi28N2LauPGN6bTo=;
        b=ZlrV95gU9w3hwjmZTrxtu66rsDq7uCdUCSmveUUsorXRdp7gF8YQuH9GLFuu+KTEWX
         t6u0UzSPCQdiatSv17B/4xBlxU03AQKllAz3KcNv8bCnzY2tBl5xMZCpW0dkQuevuOPd
         CKt9GAurgPdabHFU+NJRxJmxFKR6WHTtDqQPQlef6h03D9C2MkAuWwfP8kPlzhRSqRuB
         eYTDXGzD5fy4TigYLSc7rQ3JO6QBqLWNss5VgnFfskkrRKZDA3K2L9jXsnU5vaF2ghrL
         IduKhFpfuo05qgV9rCTru9QfZJtDbXQ4z5MaiK7wvQPNxJATzouyeWx23UzhbKyVU9jG
         49Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PzAysl1kVh5ewkroZKc5q/jo/njYi28N2LauPGN6bTo=;
        b=fHukAzeu0vZ0OKCc+o4ViiEtj3XdFkJt2Kv6KHAKKtdTdOlgrRlO9cL0rSun8DyV73
         0xJ9Omc7iO7NTszOk9yYleh9Dh+ladCwbQQH4Yrn9jUTM0SxDMTxi7206o9IICSfUU87
         bJXZZvj0jm96p2byhPx0JS9bWZfqDsnROSRVRW/SAIgwNz6OSt1FzPecuhLDh9sEAf36
         +bX+VW/sLJu0Bl/C2OvFIbKjq/NCxPuYGAs6wQOsgO42MZ9fmvB+7QdHuvz8U+mONPvT
         be4LLXvHHbU31Lm3yz56EdKlhUen46wGx5oMetz4sc36zO79TbAU8pDv/bpqvDw9150C
         i2pA==
X-Gm-Message-State: ABUngvcIdBViDnFE/4bxusyQzq/mhFZY5fcNJovvrohtvfIR5SozTGiGfFXh8jQ0gE5WcioKyTZ2FcpeQtQgvA==
X-Received: by 10.13.221.12 with SMTP id g12mr1367694ywe.257.1478841958230;
 Thu, 10 Nov 2016 21:25:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Thu, 10 Nov 2016 21:25:37 -0800 (PST)
In-Reply-To: <xmqqoa1m5335.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-4-Karthik.188@gmail.com>
 <CA+P7+xoavgQ=NK8GGGXf90ESuPs+mFwHzEWbsnjWjZ4V7TWpjw@mail.gmail.com> <xmqqoa1m5335.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 10 Nov 2016 21:25:37 -0800
Message-ID: <CA+P7+xr8bhUga3eByh2nrt+pUtPUaaXq8wScRjwZ33bY=xFEDQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/17] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 3:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> @@ -49,6 +51,10 @@ static struct used_atom {
>>>                         enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>>>                         unsigned int nlines;
>>>                 } contents;
>>> +               struct {
>>> +                       const char *if_equals,
>>> +                               *not_equals;
>>
>>
>> Same here, why do we need both strings here stored separately? Could
>> we instead store which state to check and store the string once? I'm
>> not sure that really buys us any storage.
>
> I am not sure if storage is an issue, but I tend to agree that it
> would be semantically cleaner if this was done as a pair of <what
> operation uses this string constant?, the string constant>, and the
> former would be enum { COMPARE_EQUAL, COMPARE_UNEQUAL}.
>
> You could later enhance the comparison operator more easily with
> such an arrangement (e.g. if-equals-case-insensitively).

The main advantage I see is that it ensures in the API that there is
no way for it to be both "equal" and "not equal" at the same time,
where as two separate pointers while not actually done in practice
could both be set somehow, leading to potential questions.

Thanks,
Jake
