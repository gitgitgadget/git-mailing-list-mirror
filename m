Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEBAC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 22:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiLBW5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiLBW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 17:57:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6089857F
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 14:57:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e13so8258930edj.7
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 14:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GmtlJM7KkiCCmHovxaL0fPoiFZv7laicnorXH8G387w=;
        b=Nf6Okn0qKKqCg12fVdCkimlJTF4PJcQ9hbxzWVO0Tgt7BudQXM66X0iQ/Ti9VWVoFi
         bqfLtavfy6TkKf+oll+kehQjxbhtQgX+K9n4MHqmNIJmK3y6iucascEDmSjQFViGm6Cd
         rW0HHX5Eq99XVh13pmSmpISu8uzFUamau26i21volwZL1SduhoOZ21Va3wqaxPCVJC6P
         9tYCUYPQiitImeuoox2xlFr8l9faFapYKpJA+xwNH2o7cHN5NrE67HUOPe3tmKGE2zZ5
         RUMwlXkS+HXOW4GtjHWRZlSe+hJhvQZpKkwYXcTAVBdi6XNv+qEsqydxGVIjqFAiZGvl
         86LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmtlJM7KkiCCmHovxaL0fPoiFZv7laicnorXH8G387w=;
        b=6p8hxVx8rQ+oX9ndBzYigyQeH7bP2zEY2O0fH3LALn13B7QLoNAETdTh5kS3aloSo5
         olDRsSCeOrrvT4PGB3REU1vmWw1iBgMkmT3t/1CHKLJUXamgYoJq25miS2OskLv1wD1M
         sChFZfdoR5ycsxonoRNz3Fq0Iqv/a6uW+uh7ydroK2akojxsoKPrKYIDHL3RKYDw80xw
         dnjYpBMI8kmbm+PddaRqxqNC+Rfc/jjsGmla/sKOMZND5hR+zioqTpuHababwrgerFpz
         bnvd/g62ETTS+54DV75+aIBJcwDt0+1/8nFWyhq4ibDct9MpSqL0n9bx/gHpOX0eFaaK
         miKw==
X-Gm-Message-State: ANoB5pku69JyfY5dwN47dzJh0GXqaFF0Q+KBLrUZGgHr4vlTGVonhwnk
        /XeB7+5neWnb5htMxOITR14=
X-Google-Smtp-Source: AA0mqf5u2RcEmGVKnTF9WB0kxyK+KQKNJNHN7Dk+Hi/R35E8j7eqrXo4z9Q+lRZlIkAUAaXqORpXlA==
X-Received: by 2002:a05:6402:1002:b0:467:7c62:64 with SMTP id c2-20020a056402100200b004677c620064mr63787306edu.82.1670021870769;
        Fri, 02 Dec 2022 14:57:50 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b007bb32e2d6f5sm3469661eje.207.2022.12.02.14.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:57:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1Eyb-002w9E-1I;
        Fri, 02 Dec 2022 23:57:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija <doremylover123@gmail.com>
Subject: Re: [PATCH] maintenance: compare output of pthread functions for
 inequality with 0
Date:   Fri, 02 Dec 2022 23:46:25 +0100
References: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
 <221202.86k039fz7x.gmgdl@evledraar.gmail.com>
 <Y4pl5BzQnw0Fm+5S@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y4pl5BzQnw0Fm+5S@tapette.crustytoothpaste.net>
Message-ID: <221202.86y1rpe7ma.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-12-02 at 18:10:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> But (and especially if you're interested) we really should follow-up
>> here and fix the "error()" etc. part of this. After this we have cases
>> in-tree where we on failure:
>>=20
>>  * Call die_errno() (good)
>>  * Call die(), error() etc., but with a manual strerror() argument,
>>    these should just use the *_errno() helper.
>>  * Don't report on the errno at all, e.g. in this case shown here.
>>=20
>> It seems to me that all of these should be using die_errno(),
>> error_errno() etc.
>
> Actually, I don't think that's correct.
>
>> Or maybe it's the other way around, and we should not rely on the global
>> "errno", but always capture the return value, and give that to
>> strerror() (or set "errno =3D ret", and call {die,error,warning}_errno()=
).
>
> Yeah, I think we need to do this.  That's because unlike most other
> functions, the pthread functions _don't_ set errno, and instead return
> the error value.  That's why on a typical Unix system, we would have
> never failed before this patch: because errno values are always
> positive.

I was skimming the POSIX docs earlier, which seem to indicate that
you're not promised anyhting about "errno" being set, just the return
value.

But at the same time I was reading glibc's pthread implementation, where
a lot of the time (but not all the time!) you'll also get errno, just as
an artifact of the library carrying forward an error from an internal
API which failed while setting errno (e.g. malloc()).

In any case, the best thing to do for our codebase is probably:

	if ((errno =3D pthread_create(...)))
        	die_errno(...);

Since that gives our usag.[ch] library the chance to do something more
clever than doing the same strerror() formatting hardcoded at every
callsite.
