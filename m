Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00EAC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354200AbiDON6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354197AbiDON6A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:58:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C6A2DA9D
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:55:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g18so15457989ejc.10
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Qp7F9mOSjzSGinvTJ9Bdi5GiVjbDGMlEas28Y/f6qTI=;
        b=g0OKL34H6/OdHkWFGrt7kZ2Y7KQf27qdSmU3e2aaXSOMRKPcpbQ2g87ZYrIwPspqg3
         eoBjlF6ntcKwnr7ynWNy/peFI0nb+R9Ha0gJZBSyXoyrStb8TZg1Rt05eXDq5d1ab0Xc
         waP7Tzp/a0Y3P7sB/6mxZza8QGGFtCk4oxwj+1TcEYvuCodDOaKduZsDahehqsb/5Uub
         1NmuofmVgVchJ+ehdye+gViDy0EBXlgp3Z1npdyI42uonAB/udqps7us84/tnqj2Aazw
         tNKp6e/IMPh9CzCwdl98noAugekuhKxJGRQ0qhDPvzhop9rpi4xvN8jV02V6dMxCka0H
         a2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Qp7F9mOSjzSGinvTJ9Bdi5GiVjbDGMlEas28Y/f6qTI=;
        b=Ij+EKtxunXCX07sMRsViu5CtKB0bJ9r9QEETIdKM+e1gSaLSLH33rWx0Ohgbe24jEj
         WR4iYTjTbimrfg/IsO5qvSha6R2futPSLR2ZcyRjvoeXTslJ18Ux6ZmzjanY7ZdPB4G6
         T8Zcj61Pk0jGeur+xTID7tPhXyn1rMkKcuRzpiHJiI45Vkg7KWDo5IBc7J2iOzhZtcy/
         h1t7kO0Bp8uY4qXPW7JZyPBdyqtZr+5w0M7TjnVO37At27cqJqE5HyetQrdKbHrAw3jy
         IC+1k8QpafL4kM2o4AZp/pxdPfuZqAw6+XBMVom584Db63msa4tpz/7BHg5HvdkpZv0K
         vY/w==
X-Gm-Message-State: AOAM5339j6NKOnDNss+dn0STmAgzB0SXwGKquJjD8lBHp7tIC8RYcpSx
        7sYldYMXudIV1JpSNcda6p8=
X-Google-Smtp-Source: ABdhPJy70r2TNhmKLAe7VU+3STl7o6/c4SjdPREpJrXm+mtmGxMFeA9RFeFTSBdqbS62fDFSFJnh2g==
X-Received: by 2002:a17:907:97c8:b0:6ef:6a79:6285 with SMTP id js8-20020a17090797c800b006ef6a796285mr823676ejc.231.1650030929138;
        Fri, 15 Apr 2022 06:55:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fq6-20020a1709069d8600b006e891c0b7e0sm1689448ejc.129.2022.04.15.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:55:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfMQ4-005fe7-1u;
        Fri, 15 Apr 2022 15:55:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [RFC PATCH 2/2] reftable: don't memset() a NULL from failed
 malloc()
Date:   Fri, 15 Apr 2022 15:53:43 +0200
References: <20220415083058.29495-1-carenas@gmail.com>
 <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
 <RFC-patch-2.2-364d1194a95-20220415T101740Z-avarab@gmail.com>
 <4321a9dd-bb82-e2fe-5449-395f998378c5@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4321a9dd-bb82-e2fe-5449-395f998378c5@web.de>
Message-ID: <220415.86fsmebgds.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Ren=C3=A9 Scharfe wrote:

> Am 15.04.22 um 12:21 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Return NULL instead of possibly feeding a NULL to memset() in
>> reftable_calloc(). This issue was noted by GCC 12's -fanalyzer:
>>
>> 	reftable/publicbasics.c: In function =E2=80=98reftable_calloc=E2=80=99:
>> 	reftable/publicbasics.c:43:9: error: use of possibly-NULL =E2=80=98p=E2=
=80=99 where non-null expected [CWE-690] [-Werror=3Danalyzer-possible-null-=
argument]
>> 	   43 |         memset(p, 0, sz);
>> 	      |         ^~~~~~~~~~~~~~~~
>> 	[...]
>>
>> This bug has been with us ever since this code was added in
>> ef8a6c62687 (reftable: utility functions, 2021-10-07).
>
> Not sure it's a bug, or limited to this specific location.  AFAICS it's
> more a general lack of handling of allocation failures in the reftable
> code.  Perhaps it was a conscious decision to let the system deal with
> them via segfaults?

I think it's just buggy, it tries to deal with malloc returning NULL in
other contexts.

> When the code is used by Git eventually it should use xmalloc and
> xrealloc instead of calling malloc(3) and realloc(3) directly, to
> handle allocation failures explicitly, and to support GIT_ALLOC_LIMIT.
> This will calm down the analyzer and extend the safety to the rest of
> the reftable code, not just this memset call.

Yeah, its whole custom malloc handling should go away.

>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  reftable/publicbasics.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
>> index 0ad7d5c0ff2..a18167f5ab7 100644
>> --- a/reftable/publicbasics.c
>> +++ b/reftable/publicbasics.c
>> @@ -40,6 +40,8 @@ void reftable_free(void *p)
>>  void *reftable_calloc(size_t sz)
>>  {
>>  	void *p =3D reftable_malloc(sz);
>> +	if (!p)
>> +		return NULL;
>>  	memset(p, 0, sz);
>
> This function is calloc(3) reimplemented, except it can't make use of
> pre-zero'd blocks of memory and doesn't multiply element size and count
> for the caller while checking for overflow, making it slower and harder
> to use securely. :-/

*nod*, this is really just re-arranging the deck chairs.

Maybe Han-Wen had something in mind, but I really don't see the point of
having it use malloc wrappers at all, as opposed to just having the
linker point it to the right "malloc".

So if it needs to be used outside of git.git it would just need the
trivial xmalloc() etc. wrappers.
