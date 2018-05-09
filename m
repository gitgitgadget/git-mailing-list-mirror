Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312BA1F424
	for <e@80x24.org>; Wed,  9 May 2018 18:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935054AbeEISBM (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 14:01:12 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:46945 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934783AbeEISBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 14:01:11 -0400
Received: by mail-ot0-f179.google.com with SMTP id t1-v6so41141656ott.13
        for <git@vger.kernel.org>; Wed, 09 May 2018 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W0HVzDF79D4jlRwdAek0GnrJzD2s+59Y+HmqnSnEpZ8=;
        b=HFkSHq+tAHJ9DMCE5gSwW9ZJpFJBsJOgSidL2jpXSw8g1/lj9zdwsJz6o3JJe4hAVc
         fwVaOfZXJr6VwjfkLQmaEoBBtJ1MZ+p61NvX5BDEkB1G6L/bcjSy9kRsi7IS2T0aifWq
         1gZ1mJae6Pgcur6yt1uH0m3MSy+Bvui+FbGaC4ddJ0D9c26VPiZF3LvGrL46p8gT390Q
         kuQ21PBMe0jzL0egIDhMAfPYvlcV58jDpmXOsgg79GEjrmPkU4mK+7QmyZKiGRWuqTo4
         V6AW9vtl+ZqxgOK7N9WfBfcPyV4xCbUaj/dvpGKm1nv1nPcWMhFpGeBWFFEoN242UOwU
         yiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W0HVzDF79D4jlRwdAek0GnrJzD2s+59Y+HmqnSnEpZ8=;
        b=kVAS/pgmG7dsxuFgXQ892myx5mGgws+S89YvgZpSkpPYTPofDZA1duAmB11dtgqxM7
         j0Ye0NWJmw4MVdRhDMGYODEAIpwtioTMTN9VUF1lgtDeJWAgQAhGzUUZ2bFhWAp4y0Hg
         w+sIJxRZuwRlXPy+ilpbYObTqec6XZTENDe/w3WlAfMInMSY65TwqrshtOE08wGt/ZVo
         a2cCHqRYkWgB6zNwKyNnT2bRHeJ3Yzt31xcGKJCWE0xKIXh1NHn90CyUjDa8z0hufv6q
         x/hamPw08vl/UiEQO/SwTYexvUeYNgbiYjeufCas+pbnTePrtnSvMOrLDUJqUkfC0I/y
         6pRA==
X-Gm-Message-State: ALQs6tB7FWO26FiFWxItyvvmM99yLhwNMwCid5udDJYZF1MdFfRWvylS
        4nVkCoLzboqxkxeTm5VOyq6UPqp/1OZvZnvf4Jg=
X-Google-Smtp-Source: AB8JxZoqJ5b0Ekb7QNc60QskkH4z2nBUQ/XJRCFI/S9iD2Gb3nca+no6G/xX4N1YuPLg36e75j81IOfD5yRJlW4cHLc=
X-Received: by 2002:a9d:4197:: with SMTP id p23-v6mr34999962ote.75.1525888870326;
 Wed, 09 May 2018 11:01:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 11:00:39 -0700 (PDT)
In-Reply-To: <CAGZ79kbFiULj1NJARm6ObYrqv_Fu+U2sb8h_sNJwdWur+JqrvQ@mail.gmail.com>
References: <20180509170409.13666-1-pclouds@gmail.com> <CAGZ79kbFiULj1NJARm6ObYrqv_Fu+U2sb8h_sNJwdWur+JqrvQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 20:00:39 +0200
Message-ID: <CACsJy8AdJcQpiGrR3p6xfuqU0=qoP3=StgbWRNCkdfka6di+5w@mail.gmail.com>
Subject: Re: [PATCH] repository: fix free problem with repo_clear(the_repository)
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 7:50 PM, Stefan Beller <sbeller@google.com> wrote:
>>  I was trying to test the new parsed_object_pool_clear() and found this.
>
> So this would go with the latest sb/object-store-alloc ?

No this should be separate because sb/object-store-alloc did not even
touch this code. I mistakenly thought you wrote this and sent to you.
I should have checked and sent to Brandon instead.

> My impression was that we never call repo_clear() on
> the_repository, which would allow us to special case
> the_repository further just as I did in v2 of that series[1] by
> having static allocations for certain objects in case of \
> the_repository.
>
> [1] https://public-inbox.org/git/20180501213403.14643-14-sbeller@google.com/
>
> We could just deal with all the exceptions, but that makes repo_clear
> ugly IMHO.
>
> I would rather special case the_repository even more instead
> of having it allocate all its things on the heap. (However we rather
> want to profile it and argue with data....)

I'm actually going the opposite direction and trying hard to make
the_repository normal like everybody else :)

>>  repository.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/repository.c b/repository.c
>> index a4848c1bd0..f44733524a 100644
>> --- a/repository.c
>> +++ b/repository.c
>> @@ -238,7 +238,9 @@ void repo_clear(struct repository *repo)
>>
>>         if (repo->index) {
>>                 discard_index(repo->index);
>> -               FREE_AND_NULL(repo->index);
>> +               if (repo->index != &the_index)
>> +                       free(repo->index);
>> +               repo->index = NULL;
>
> So after this we have a "dangling" the_index.
> It is not really dangling, but it is not part of the_repository any more
> and many places still use the_index, it might make up for interesting
> bugs?

Hmm.. yeah, as a "clearing" operation, I probaly should not clear
repo->index. This way the_repository will be back in initial state and
could be reused again. Something like this perhaps?

discard_index(repo->index);
if (repo->index != &the_index)
        FREE_AND_NULL(repo->index);

> What is your use case of repo_clear(the_repository)?

No actual use case right now. See [1] for the code that triggered
this. I do want to free some memory in pack-objects and repo_clear()
_might_ be the one. I'm not sure yet.

[1] https://gist.github.com/pclouds/86a2df6c28043f1b6fa3d4e72e7a1276
-- 
Duy
