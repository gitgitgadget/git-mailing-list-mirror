Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20C7B1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 17:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbdBIRpI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 12:45:08 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:36449 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbdBIRpH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 12:45:07 -0500
Received: by mail-io0-f171.google.com with SMTP id j13so22803412iod.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 09:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hN9yd9N7KJ2XnhbOmEo6RiVqjLFK2XxVhJ6o9TYY5xc=;
        b=DntE/phM8ppjt5mHT5eRxUhhRJGibLX5gviXv4S35x/7iCV6ERTdT/1vl1ZCAAYzDX
         vbmz64nCtm6tWJkcYEiXbt3u1HwdwDBEGR2bdJ8WR/+KexI9gHAG6yJYCw2zaOvbzpP9
         yJyeZ6UIfMC+I8cbNlK45W1y2V+wmcVhG7CVdjldwwM9VVr1NeqM9kmnFWDF/eREl3lV
         Lt/ZyIqt+F3zLvWbvOviFrvEIg9lzFIHO1ksf8s5wgYlsKrIbogSv6vLJHL9vEo/fYnK
         VvdUR4auyaUhStI9pTDn5eSWbOemtpWSXsB3+xI6LV6zUnXbskCRI5KvfuUbx9+1iPCs
         KM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hN9yd9N7KJ2XnhbOmEo6RiVqjLFK2XxVhJ6o9TYY5xc=;
        b=aj9e8nz8Mm9kymwHb57EZnw00KFGwODaUnYNTeiTViOR6UQulRE5s/KB9GMnwDDbt+
         YY/g0Xq1ipOmjFQxmJsxw0aCsBYjgadUUBb1dmtsogI6AL6cw2Zd0RND1N7DZzrZNZmY
         GrjA/OGwloWPNFnoYdEudzKkrouOyJAZmKwiYs65XlHJ9uWHZv9SsfLOGRfa0Sw6qF5+
         PdKgr1MuL39ifzEbKdckJMnp7A/zpyV0ngjqvPdrx1PNN3JcLbRwckMnKPFhU8VFjVYF
         vyvkkQysfDmW6OZVfplSTa/MbdXZbV0RT8XzW6gLk1qkQxvjCkhAvxjC8hSmgBtZ7fS6
         gwXw==
X-Gm-Message-State: AMke39lfB3F8IIUfGzuRbeUdEfMidsJ/N1oJE6p0KTSqRm5vgVMvY7AYYrrnTWRibOUQgXwYHg7GezDlMwj8hR8E
X-Received: by 10.107.3.160 with SMTP id e32mr4444598ioi.52.1486662230308;
 Thu, 09 Feb 2017 09:43:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 9 Feb 2017 09:43:49 -0800 (PST)
In-Reply-To: <4a21dba7-76ef-6aec-b326-c1046f3daad2@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu> <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
 <CAGZ79kau2bYs7zegEiacAdbhn1LyOfAH9__rePfbQkX2iLgmMQ@mail.gmail.com> <4a21dba7-76ef-6aec-b326-c1046f3daad2@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Feb 2017 09:43:49 -0800
Message-ID: <CAGZ79kb-uNnfrvCUk9PbXcFwOJSmSwccuSaZ2H_u61engE+H3A@mail.gmail.com>
Subject: Re: [PATCH 1/5] refs: store submodule ref stores in a hashmap
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 9:40 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 02/09/2017 05:58 PM, Stefan Beller wrote:
>>> @@ -1402,17 +1435,17 @@ struct ref_store *ref_store_init(const char *submodule)
>>>
>>>  struct ref_store *lookup_ref_store(const char *submodule)
>>>  {
>>
>>> +       if (!submodule_ref_stores.tablesize)
>>> +               hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);
>>
>>
>> So we can lookup a submodule even before we initialized the subsystem?
>> Does that actually happen? (It sounds like a bug to me.)
>>
>> Instead of initializing, you could return NULL directly here.
>
> The lines you quoted are only concerned with bringing the (empty)
> hashmap into existence if it hasn't been initialized already. (There's
> no HASHMAP_INIT.) I don't know what you mean by "initialize the
> subsystem". The only way to bring a ref_store *object* into existence is
> currently to call get_ref_store(submodule), which calls
> lookup_ref_store(submodule) to see if it already exists, and if not
> calls ref_store_init(submodule) to instantiate it and register it in the
> hashmap. There's nothing else that has to be initialize before that
> (except maybe the usual startup config reading etc.)
>
> I suppose this code path could be changed to return NULL without
> initializing the hashmap, but the hashmap will be initialized a moment
> later by ref_store_init(), so I don't see much difference either way.

Oh, I did not see that.

Thanks,
Stefan

>
> Thanks for your review!
> Michael
>
