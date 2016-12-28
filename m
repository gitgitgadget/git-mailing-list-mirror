Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1DF200E0
	for <e@80x24.org>; Wed, 28 Dec 2016 03:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750740AbcL1DJR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 22:09:17 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34611 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750697AbcL1DJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 22:09:15 -0500
Received: by mail-yw0-f194.google.com with SMTP id a10so23706501ywa.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 19:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PJp4+jYcacR8E20lSPxNJqQVNm220wwKMkHwFqw2ufA=;
        b=Uip+QEt5AHhUMoIl0F6fwtjDSmiIq1dCwciawvA8X4A46aismRRRU3/7Qkp6ilhzN4
         mcb0yB16UpgLzLZKX/L9Dxomuyl65GSDjQVmiYpzRukPAcXTvVGas0jhACDGAIeVYvPo
         7E4OJpAH8jFYgbyZNQ8acpb22xJc0TLRW+luXJsuVNrPvuIlLtErCCswrOOH2OaxhNM4
         Z5NFR3+m1aBFbVLxO8oLwpyqWRmjIsXs1GEf2Xme27rxvqwnn9jGTEEXE082E0VUmxRV
         muBf0ilxYq5Ogak3TxuXnKuqbqO99rBXka+4kp8RXMSwcgpWTExafQIf067d620DSTYg
         m4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PJp4+jYcacR8E20lSPxNJqQVNm220wwKMkHwFqw2ufA=;
        b=gQrP/ekBCEH30JMnP5wFRn0fI8VRxVsmYoKb14FOg7MMiXh/itz0PHup+P61R74ErX
         GKebAgn5yVYH7991MD80tnp45+I8nobvC2xLx6QW0e3cJf+26RWi0ktgy3urubLvBnpK
         ITcb+zNXzcgHQ+00yegxxtZyxzZ+huoNwWYlLYZfC7eN5hC1gJ9XK3ntZSY6nEWAN7VE
         fVcTx6EHwrCiWBYRjl8twWm6uvSJxMpwh0zGBNKWYea4rqlgma9BcN+qqY7+2zjjgZYl
         c28mpD5Zs7Yx9/lS1/YB1rFNWzV+UKzfu29zEVfpGO8bQsO59ixntMJLQWgwvwN09RVE
         fjZA==
X-Gm-Message-State: AIkVDXLisqTRtVACbS48ztqw3YizsFHdsjjG5lsbnNIZ0FpJNQUjhvigmvoli0qHAdcLLnIZVDZUaeKR0BP1vQ==
X-Received: by 10.13.250.3 with SMTP id k3mr26547346ywf.276.1482894540394;
 Tue, 27 Dec 2016 19:09:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.177.158 with HTTP; Tue, 27 Dec 2016 19:08:39 -0800 (PST)
In-Reply-To: <xmqqo9zx6phw.fsf@gitster.mtv.corp.google.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com> <20161227162357.28212-16-Karthik.188@gmail.com>
 <xmqqo9zx6phw.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 27 Dec 2016 19:08:39 -0800
Message-ID: <CA+P7+xpe6XSDFqX+zLid-1M5P_WOzoeaB+fRkDw6Y+MP7qVA_g@mail.gmail.com>
Subject: Re: [PATCH v9 15/20] ref-filter: modify the 'lstrip=<N>' option to
 work with negative '<N>'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Currently the 'lstrip=<N>' option only takes a positive value '<N>'
>> and strips '<N>' slash-separated path components from the left. Modify
>> the 'lstrip' option to also take a negative number '<N>' which would
>> only _leave_ behind 'N' slash-separated path components from the left.
>
> "would only leave behind N components from the left" sounds as if
> the result is A/B, when you are given A/B/C/D/E and asked to
> lstrip:-2.  Given these two tests added by the patch ...
>
>> +test_atom head refname:lstrip=-1 master
>> +test_atom head refname:lstrip=-2 heads/master
>
> ... I somehow think that is not what you wanted to say.  Instead,
> you strip from the left as many as necessary and leave -N
> components that appear at the right-most end, no?
>
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -98,7 +98,8 @@ refname::
>>       abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
>>       slash-separated path components from the front of the refname
>>       (e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
>> -     `<N>` must be a positive integer.
>> +     if `<N>` is a negative number, then only `<N>` path components
>> +     are left behind.
>
> I think positive <N> is so obvious not to require an example but it
> is good that you have one.  The negative <N> case needs illustration
> more than the positive case.  Perhaps something like:
>
>     (e.g. %(refname:lstrip=-1) strips components of refs/tags/frotz
>     from the left to leave only one component, i.e. 'frotz').
>
> Would %(refname:lstrip=-4) attempt to strip components of
> refs/tags/frotz from the left to leave only four components, and
> because the original does not have that many components, it ends
> with refs/tags/frotz?
>
> I am debating myself if we need something like "When the ref does
> not have enough components, the result becomes an empty string if
> stripping with positive <N>, or it becomes the full refname if
> stripping with negative <N>.  Neither is an error." is necessary
> here.  Or is it too obvious?

I do not think it hurts to have, and makes this obvious.

Thanks,
Jake
