Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05DA1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbcK2Rhr (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 12:37:47 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35252 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753668AbcK2Rhq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 12:37:46 -0500
Received: by mail-qk0-f175.google.com with SMTP id n204so182203349qke.2
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zTk5mBXoZGVRhL7hbrJoepJHXZ4NyAGadLQHRfortxY=;
        b=QTpAAKHRmE45kkcUZ2hoDjBvw2rD6LxyoAkn09HGflUxWFsnyIu6U3jiTV9GkebL6e
         vNctjeBErtAKZN4MCUjAKduK9/STyqjEahWgEJ7AXpfESHF1jHb99jmNJjAicvhj0GVi
         q39MVH5eT4nEn6/Y2V8brDcnhMeZ6GdXmU0rNDNlcm/oJCYZ5WJNAtYopknHWSp4zy8V
         0bXfxIGxzQ0vwIFVsmSVgcia1z7DId6TrUkuDGLF2De7PsLPwJUgrjkIEvBnUdpO182M
         KC5rV3sqVuztTFieNySE6BV6uSvhpzRj5whxUq1FQR635Z5w+JeTOkjHhYy+9VJ/+ocy
         zkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zTk5mBXoZGVRhL7hbrJoepJHXZ4NyAGadLQHRfortxY=;
        b=AS5lJ7gH6Fg5V1iEf7lDo5Out1MDSYNrJKLZSXvN4v05FX95fc6nAMkLDSBwgUcU3g
         4+Tv8SFti/QKGYT6Q1Nz2qYjF10I+21U+a+c40MlNFb1eS9LiFX/D0mWYXy5CpekKnsW
         htAM5Y9Xg4sCFi1eRSh75W6pmGFw3nsO44i/CcugrfkQaJGztp3tgjXCMRgbL7GjXKcl
         a6RCxpcXoa5rkbubxotDVT2o6n8/vGOpkGYnoJAfW1eGq3CnPOnR8I2ACiDcCY2ywaJx
         3qGMtTXCgpEyxVQFAq/sqjk7NvN7lezYQF9Ff261PacFptOwl9NNcgQsPySwiKNEzQX3
         ZQDw==
X-Gm-Message-State: AKaTC03SlEIydqOXqt50dgeyMiAINFtQ0Oke2EdjaLSG1V994Em04043pSzBtcaN8RcisjQfDIdF3TA5ptolh93A
X-Received: by 10.55.186.3 with SMTP id k3mr27608823qkf.47.1480441063614; Tue,
 29 Nov 2016 09:37:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 29 Nov 2016 09:37:43 -0800 (PST)
In-Reply-To: <20161128221123.GC150448@google.com>
References: <20161110203428.30512-1-sbeller@google.com> <20161110203428.30512-32-sbeller@google.com>
 <20161128221123.GC150448@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 Nov 2016 09:37:43 -0800
Message-ID: <CAGZ79ka9K=VM7afW5E4=e52JOwpKe=o3TTYqWFVrf6TnptSHcA@mail.gmail.com>
Subject: Re: [PATCH 31/35] pathspec: allow querying for attributes
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 2:11 PM, Brandon Williams <bmwill@google.com> wrote:
> On 11/10, Stefan Beller wrote:
>> @@ -500,6 +586,18 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
>>
>>  void clear_pathspec(struct pathspec *pathspec)
>>  {
>> +     int i, j;
>> +     for (i = 0; i < pathspec->nr; i++) {
>> +             if (!pathspec->items[i].attr_match_nr)
>> +                     continue;
>> +             for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
>> +                     free(pathspec->items[i].attr_match[j].value);
>> +             free(pathspec->items[i].attr_match);
>> +             if (pathspec->items[i].attr_check)
>> +                     git_attr_check_clear(pathspec->items[i].attr_check);
>> +             free(pathspec->items[i].attr_check);
>> +     }
>> +
>>       free(pathspec->items);
>>       pathspec->items = NULL;
>
> You may also want to add logic like this to the 'copy_pathspec' function
> so that when a pathspec struct is copied, the destination also has
> ownership of its own attribute items.
>

Thanks for the review comments, I'll plan on resending this series after the
submodule checkout series (which is nowhere near done, but the foundation
is set with sb/submodule-intern-gitdir as a preparation.)

After discussion with Jonathan Nieder, I think it may be possible to make
this new pathspec magic work without the need for thread safety. This is
archived by constructing all relevant attr_check stacks before the preload_index
functionality (which is threaded) and then use the preconstructed attr_checks
to get attr_results just like in this series.

That approach would come with the benefit of not needing mutexes
at all inside the attr code.
