Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47259C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA6F61263
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbhIQTTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbhIQTTl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:19:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2321EC061757
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:18:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c22so33705745edn.12
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=b2yeFW0cZTel28BI2Nw35j64vqlU3qVKcQCTqDPn9zk=;
        b=ChuQxd4osZSCLdAXp6BeKNCUrRnkZme0/yuzaxOz9mqXonUA143SrIAMvSiYD3y0+P
         w8l0L17+zaIHNOn6W+DqPfHGQnr2AgUnJ/X1GdZy8U9fi1NofqLNoNF8+ULWOsVmg33P
         vZQkdclN7T481CJ5/TEtEFJvX7FWPNcm/63fB74tIKWTJeln/TiVHHncjC5PGJUvqF3E
         yxyLMs734gqe+jegV1AoJP6nAwppoHIMMMllpaq4LS8Q05uGkNWTvdn6X2AEGqm3Vt9j
         8OOzb8yxNYg6dkLcVh1S9lcNvsWTuodwsn/zA/69DbDk/+/y6aCcuQwfokCNbFTIRbaz
         NvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=b2yeFW0cZTel28BI2Nw35j64vqlU3qVKcQCTqDPn9zk=;
        b=RtkE6yvPRiN2V26e+V/Fhc29Uob1ZdBE9Isweb2Nwug/q12P4KeQCXCKEN/eJB+rNm
         uncdnh1bEIS1XbkjdA3baPStt5QjZePeA27XWbanza+dKnvYXTjH/hNTL4Ur4whyj5bZ
         otao2vuLwLzTlYeqYJyo6eU/mYF+Ci+EVl/L1rUTR6Gd41MVZNsNH/BFuUKIdA3QXiCy
         cR0Hprb+6aKJWBn8t9zo7TlbZjNJC9NoyuOFG5Ldao98r3mWuoKmPjJ9yJ1doa+JZrso
         Tt6O6g1U7qv9HvqD8ci7qs+41h8ozlyYRbZWduGE9pZ3XORR2sEgAZ+dYEyFKs/FJVMN
         PgsQ==
X-Gm-Message-State: AOAM5320mTMSD9UgKNOqaaNhojpa0KG1JjLA7JuU6sfr1pZN62Zri26N
        aC8qWUJBWoz5oIeHG970DpQ=
X-Google-Smtp-Source: ABdhPJxUnMBVt0tEP+xyzHIJjHN5pQO1qiblNEb+737E7CGbla2b5ieTaveZtFz6YNWpZYEjotFUxA==
X-Received: by 2002:aa7:db15:: with SMTP id t21mr13982269eds.229.1631906297605;
        Fri, 17 Sep 2021 12:18:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gx4sm2680843ejb.116.2021.09.17.12.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 12:18:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 5/7] simple-ipc/ipc-win32: add Windows ACL to named pipe
Date:   Fri, 17 Sep 2021 21:14:48 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5eadf71929559968cafa18d03c3a623b1adff926.1631738177.git.gitgitgadget@gmail.com>
 <877dfhm5ki.fsf@evledraar.gmail.com>
 <9b1c8691-936f-c481-e3af-dd94efa57152@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <9b1c8691-936f-c481-e3af-dd94efa57152@jeffhostetler.com>
Message-ID: <87h7ejdn9j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021, Jeff Hostetler wrote:

> On 9/16/21 1:47 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Sep 15 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> +struct my_sa_data
>>> +{
>>> +	PSID pEveryoneSID;
>>> +	PACL pACL;
>>> +	PSECURITY_DESCRIPTOR pSD;
>>> +	LPSECURITY_ATTRIBUTES lpSA;
>>> +};
>>> +
>>> +static void init_sa(struct my_sa_data *d)
>>> +{
>>> +	memset(d, 0, sizeof(*d));
>>> +}
>>> +
>>> +static void release_sa(struct my_sa_data *d)
>>> +{
>>> +	if (d->pEveryoneSID)
>>> +		FreeSid(d->pEveryoneSID);
>>> +	if (d->pACL)
>>> +		LocalFree(d->pACL);
>>> +	if (d->pSD)
>>> +		LocalFree(d->pSD);
>>> +	if (d->lpSA)
>>> +		LocalFree(d->lpSA);
>>> +
>>> +	memset(d, 0, sizeof(*d));
>>> +}
>> [...]
>>=20
>>> +fail:
>>> +	release_sa(d);
>>> +	return NULL;
>>> +}
>>> +
>>>   static HANDLE create_new_pipe(wchar_t *wpath, int is_first)
>>>   {
>>>   	HANDLE hPipe;
>>>   	DWORD dwOpenMode, dwPipeMode;
>>> -	LPSECURITY_ATTRIBUTES lpsa =3D NULL;
>>> +	struct my_sa_data my_sa_data;
>>> +
>>> +	init_sa(&my_sa_data);
>>>=20=20=20
>> [...]
>>=20
>>>   	hPipe =3D CreateNamedPipeW(wpath, dwOpenMode, dwPipeMode,
>>> -				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, lpsa);
>>> +				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,
>>> +				 my_sa_data.lpSA);
>>> +
>>> +	release_sa(&my_sa_data);
>>>     	return hPipe;
>>>   }
>> Just a nit on the init pattern, since we always allocate this on the
>> stack (this as all the relevant "struct my_sa_data") I'd have thought to
>> see:
>>      #define INIT_MY_SA_DATA { 0 }
>>      [...]
>>      struct my_sa_data my_sa_data =3D INIT_MY_SA_DATA;
>> Which gets rid of the need for an init_sa() function.
>
> The current "my_sa_data" is just a set of 4 pointers, so yes your
> INIT_MY_SA_DATA macro and my init_sa function are equivalent.
> (And assuming that mine and memset are inlined by the compiler, they
> are both probably exactly equivalent.)   So it really doesn't matter
> one way or the other.

Yes it's the same to the compiler, see 5726a6b4012 (*.c *_init(): define
in terms of corresponding *_INIT macro, 2021-07-01).

But being the same to the compiler !=3D the same to human readers. I was
going for the latter here, i.e. in git.git init with a macro tends to be
used if the init is simple enough to be run like that, and with a
function if it really does need to run some function (and then after
5726a6b4012 the init-via-function-via-macro for things that need init
after malloc() or whatever).

Whereas this one's just on the stack, and doesn't need anything special,
so the nit was about just preferring the simplest construct for the job.

>> Also having the release_sa() do a memset() is a bit odd, usually we
>> have
>> a reset*() function do that if the intent is to re-use, but it doesn't
>> appear to be in this case, and we don't return this data anywhere, do
>> we?
>>=20
>
> I use the release_sa() function inside my "fail:" label in get_sa()
> to cleanup if any of the component parts of the SA cannot be created.
> So the return value of get_sa() is either fully constructed or contains
> NULL pointers.
>
> (The docs are jargon heavy and little obscure and circular and it
> is not at all clear if/when we might fail to create some of these
> sub-structures.)
>
> So I allow the SA failure to be silently ignored and we create the named
> pipe without an ACL.  Normally, this is fine since the daemon usually
> isn't elevated.
>
> In create_new_pipe we always call release_sa to free the pointers if
> necessary.  (So in case of a failure in get_sa, we won't double free
> the pointers when create_new_pipe calls release_sa.)
>
> Another way to think of it is that in release_sa, I'd like to have
> FREE_AND_NULL() variants for FreeSid() and LocalFree(), but a simple
> memset is sufficient.

*nod*, I meant if functions are doing that sort of intent-to-reuse we
 usually call them *_reset(), with a *_release() that's just a plain
 free() and forget.
