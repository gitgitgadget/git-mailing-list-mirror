Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167CC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 20:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6760F11
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 20:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350652AbhICUkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 16:40:02 -0400
Received: from mout.web.de ([212.227.15.4]:52015 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350736AbhICUj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 16:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630701512;
        bh=JTzh73t0i3Q0f6QwUMRym54t1JjzeZaoKZVzM0S/Jw4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EaBKYispGfNTENF91Q6n1zaTsh1SnnS/wNDc8V5VX2xXrYbpMANK7QLyNHtex/nON
         EMqrFzVrqQtVDp7xuIn+IPOKaGBR2DeG9HZh1TcCtfV65mUzzDsozzJrvnA75+OGGh
         PnFKrvwQNMy9PSDqD2ormIl7Eq5MQTDAsTG+ALDo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LfiZ8-1mjpD80Tww-00pIGJ; Fri, 03 Sep 2021 22:38:32 +0200
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        phillip.wood@dunelm.org.uk, sunshine@sunshineco.com
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
 <20210903170232.57646-3-carenas@gmail.com>
 <bc4789a0-ae80-c1dd-35b1-86949a807490@web.de>
 <YTKBzi3z5AotirNO@carlos-mbp.lan>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e20dc0b7-8925-1ccf-3adf-c52a892cc3f0@web.de>
Date:   Fri, 3 Sep 2021 22:38:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTKBzi3z5AotirNO@carlos-mbp.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ijj4ntFI5fV0P6fnvFRaL0z64P1WkLCBRyjLBUMhslPN6LjxQZM
 6eGJIMlqhKK2LkYq/A7kT7qy04MVHTO/2VEsVKBM59zOW10+bq/XdnZYzMMi9tg0tJ268Jj
 J9V/SEJUcPIGGj58ipdWtVRlj7J+sdXT5ewrJ4NYYfagVTpC28A5Me5JAVOV0EGm4IwrQAY
 6WS/28Xl2DHlCT7WoqfpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zo3g44fWQO4=:Df991ei940qP7dcJQQ1FwD
 ftg/jVg6J66l1Ubx3LMV1Hv7PoBDmVd7c8TVJmU7XGEz/U1Vfcju+ivEmW0nCnzW4POQ023uV
 7RMxhJCb9D+34en0W3bF8diMT5rMiDszDzWMcQJwjguh7HsM5L1zbD+qm0BSBAKMbVTyT1dPJ
 pxXa0ZZXassssHF8ltw4/M6PscAHVNGbFqE3G0J07Ta2IP/8xBhSpKujg/X7PDH/hMWPeTY+w
 MrPRhKm9TJvzLhcJnXtX9HPuNE4/Nhx0rwHVZ/BYdsYb1HT2Uw2Yu2LAAQqODDZW4yfd3CuWW
 UvoYTGn+JcmLUCJUae5d3w3rxL/DTuFpYviyO4o7unQjy848VhL8qZyasW5Gw9PXprhCX2Kxz
 kF0M7iiJoO293hEpI79UhQAzvurO6an9LagPNGKqc0uUYIUaJYjMhov0IVzanXNWsUdm2v8vD
 1jdFl7+DW5++lUtcteFmtWLffYh70y00mhk/M5dGHahLe0Emd72kmd8sCmRMCxSxMqqhPTNzc
 /JjQR/HjoAcrZrb2jGZKVMY3vY63SkU3R0a57XI56TUh6iYSi6I+ZTsXzwZuU5hcJqvHQ+O0E
 fyWbCV4XkjS8MRapQ6ntvkjBIJ2GSJfqsR18sIjr6qemv7u7wSU13l/1YCsaIDAvVLuwnP43g
 wyD0GI7X+Mq0lTeK/krAlyKrmsNojZ/XD/rmqiSmnqlzRmhTiBH7yvjxRlul3gXdmD3PsXaCG
 K2ZtpwBKd7wLqihyyXvAR7ot10CLt1UuksbFE3JsqUUvdixmK2srYpGHU/rKnlgc21NOT3qkw
 uNCxHl1H5QjW4hfgpUO82e/nEGGJB0MAHncyKD6HxElzmCUjA3TQ86cXb48ztYhp15CMYh/2D
 u3qCK7VQe16J+jyJqcOHBbAnYhvNtnFkz7DyON+LKyaGTM6+aETjLtWa/B8bB9mto3P5lb4Gs
 TuvJrBfKnjZQw6GuKmsmZEgKNGdWECGxiiVFLrlRxr4qioYhxY53NMKjWvT3X7219gBeKP9xl
 Oz0PsrixvOg6NKR29qSQkIt3QlnQr2Tbx+mapuVw9b3AQQEkVR2zOP2eltB2tCKOFc6iUST0s
 x3IvqR61Wr7fjjw23nJ7Ou5BjPNBWycqnEl
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.09.21 um 22:13 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> On Fri, Sep 03, 2021 at 08:47:02PM +0200, Ren=C3=A9 Scharfe wrote:
>> Am 03.09.21 um 19:02 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
>>> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc=
.c
>>> index 1cc31c3502..edb438a777 100644
>>> --- a/compat/nedmalloc/nedmalloc.c
>>> +++ b/compat/nedmalloc/nedmalloc.c
>>> @@ -510,7 +510,7 @@ static void threadcache_free(nedpool *p, threadcac=
he *tc, int mymspace, void *me
>>>  	assert(idx<=3DTHREADCACHEMAXBINS);
>>>  	if(tck=3D=3D*binsptr)
>>>  	{
>>> -		fprintf(stderr, "Attempt to free already freed memory block %p - ab=
orting!\n", tck);
>>> +		fprintf(stderr, "Attempt to free already freed memory block %p - ab=
orting!\n", (void *)tck);
>>
>> This change is not mentioned in the commit message.
>
> got me there, I was intentionally trying to ignore it since nedmalloc gi=
ves
> me PTSD and is obsoleted AFAIK[1], so just adding a casting to void (whi=
le
> ugly) was also less intrusive.
>
>> compat/nedmalloc/nedmalloc.c:513:82: error: format specifies type 'void=
 *' but the argument has type 'threadcacheblk *' (aka 'struct threadcacheb=
lk_t *') [-Werror,-Wformat-pedantic]
>>                 fprintf(stderr, "Attempt to free already freed memory b=
lock %p - aborting!\n", tck);
>>                                                                        =
     ~~                 ^~~
>> This makes no sense to me, though: Any pointer can be converted to a
>> void pointer without a cast in C.  GCC doesn't require void pointers
>> for %p even with -pedantic.
>
> strange, gcc-11 prints the following in MacOS for me:
>
> compat/nedmalloc/nedmalloc.c: In function 'threadcache_free':
> compat/nedmalloc/nedmalloc.c:522:78: warning: format '%p' expects argume=
nt of type 'void *', but argument 3 has type 'threadcacheblk *' {aka 'stru=
ct threadcacheblk_t *'} [-Wformat=3D]
>   522 |                 fprintf(stderr, "Attempt to free already freed m=
emory block %p - aborting!\n", tck);
>       |                                                                 =
            ~^                 ~~~
>       |                                                                 =
             |                 |
>       |                                                                 =
             void *            threadcacheblk * {aka struct threadcacheblk=
_t *}
>
> I think the rationale is that it is better to be safe than sorry, and si=
nce
> the parameter is variadic there is no chance for the compiler to do any
> implicit type casting (unless one is provided explicitly).

True, other pointers could be smaller on some machines.

> clang 14 does also trigger a warning, so IMHO this code will be needed
> until nedmalloc is retired.
>
>> A slightly shorter fix would be to replace "tck" with "mem".  Not as
>> obvious without further context, though.
>
> so something like this on top?

Nah, I like your original version better now that I understand the warning=
..

Though for upstream it would make more sense to report the caller-supplied
pointer value in the error message than a casted one..

>
> Carlo
> ---- > 8 ----
> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> index edb438a777..14e8c4df4f 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -510,7 +510,15 @@ static void threadcache_free(nedpool *p, threadcach=
e *tc, int mymspace, void *me
>  	assert(idx<=3DTHREADCACHEMAXBINS);
>  	if(tck=3D=3D*binsptr)
>  	{
> -		fprintf(stderr, "Attempt to free already freed memory block %p - abor=
ting!\n", (void *)tck);
> +		/*
> +		 * Original code used tck instead of mem, but that was changed
> +		 * to workaround a pedantic warning from mingw64 gcc 10.3 that
> +		 * requires %p to have a explicit (void *) as a parameter.
> +		 *
> +		 * This might seem to be a compiler bug or limitation that
> +		 * should be changed back if fixed for maintanability.
> +		 */
> +		fprintf(stderr, "Attempt to free already freed memory block %p - abor=
ting!\n", mem);
>  		abort();
>  	}
>  #ifdef FULLSANITYCHECKS
>
