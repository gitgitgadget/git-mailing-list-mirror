Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BCC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 20:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844BD207F7
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 20:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Cvgb8cf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIZU5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 16:57:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:58383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgIZU5T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 16:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601153831;
        bh=fF2s0xw+wIbRoL8YA3KzSyCrbgE+TCazCGFKE4QGlQc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Cvgb8cf2i8oQSHG1PzAqiFS4+W3fdRB21P1Yzy71F3kryiHzZi/PLcWwzWAwaCW+O
         4/jOgEpb1o593rJ6EfTN0zJjvt0EJi5cBt1qFKlGGEqJtS/9mSDu19phGT+GJy8R3S
         hqnaA4ZLXX3RQ7iP899cEChrLYAZnt8KIkPUzCfI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1kwAuI2SHV-00hQqi; Sat, 26
 Sep 2020 22:57:11 +0200
Date:   Sat, 26 Sep 2020 22:57:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 10/10] hashmap_for_each_entry(): work around MSVC's
 run-time check failure #3
In-Reply-To: <xmqqy2kwiimi.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009262254310.50@tvgsbejvaqbjf.bet>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>        <dc46d39611df4ebd90d9308364d887e638c1bc30.1601044119.git.gitgitgadget@gmail.com>        <xmqq8scxln10.fsf@gitster.c.googlers.com> <xmqqy2kwiimi.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I9XRkdEh/yRBq8O4b0liWBEFJqr44N7VT+NFuCL9U2Wj5gqc3kM
 Vmfl3NWlslUzCVqiqjjGmVVnYEmMs4Itt3q6rSFwfEB7ji/EXssG8NYrWQZpBngdPNoYjDI
 OrK50I4d1H7IImXUxHV/Fy1QDpI4zFPQ0GVsSMtDDi8r1lM9wCUFTXWAaIR6RdiVclj24hO
 tTRFdsFoGkl0u5HhzsmNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fLufLh+6eik=:IrGuIZNPn/JVJvbJhrDntz
 m1vRE5kW7/Yrw2jtDK0QZw0Fp9Wr43YnVoUhM3lM7eE5eOgkYzB5ynNExJXBm4+XfvXr/UBVM
 w59WtHtXl/CBlDAHDb/CBVlEgFq2LMkgvZQCVaBKnCJYda4kyATVCiwdbsvfaPg3bFNfws7Wc
 pjoe6rbZS39LxSn+YrVkvXqAHu4nsW0EPXGW1LAZsgHT1xFwj2kLrXQimqbIB0O6rmVBCFY67
 xBaiwkRXDSr5Oug1Zn91oNJIjTXB/d5gDKEW0hWiq7h4PgBYnlzcjbnDycmXEuFNkDwcAb0fQ
 GM1lSwzr8A26RzQI9g3gMknoQCWB7v5ndpthLsYKgSTBIULvd1HuZwVe0r957hJm3PLJeHuXA
 YMjBmZgIOFP1wDlZ3vCae6eLZg0luqZjxasG7zyu67CfqDYd8n30JtBBYLc20kE4vfCFxUXJ1
 3iU/vY8a9iZCewhjIUXD5518QSUhjdubgcFmDA402K/XNgNgA0fYGw1MuJp8UVoKjKfr8u8uA
 n7GaT56wobHB1wXqH0TfuEVP15UdWaLu1lVtvwyHX3veGIhvPdH4vi7Vp6hg7XcJ2p+JHSea+
 DaZrvgGGD2yJd3PfJNxD9oohblpYYylVVl4jqf+C9y+4eUe43yhsUFLw0atY/dAhNQXTeIfoI
 sbQGWx9NGHiAyiJdqnDs2EgQ7FJ2Gi8bOUQF/4HdE0U6mzZOaGXWpIIsdc/wLagqOU59oWfWQ
 QXlg4BK/5e83UecXQHJCdgpExRv9uKjAVbyqYGw112mYmNOW4pWzeco1Y+UYKTpLqXdxhSANB
 7sVTnfpUCjp7Z/i0X76FzCoBmdS28Y55r0fynUv1JOwipl2XqyfxCqtomyyGhsmnh4/a21Isc
 ojLsGYViHoN71GrO/VDVKTaoQMGQwWVvng+ygvqwBlQ9aqiBNeg675JEFAaUqY2Rjp0VYszXT
 EW+xYI6Q6mv0EEG8OYtF4QY/3uA7eM3r1kBNUmRFUCI1iKGZTS4+yHGXEnE4ZaB0huZYa+88o
 D8HTpL/Fejv7ZlWUL7mlkzP9ZC+MCJEZOzS3JIylo4Hf431tGJdUFIQKukRaUFQRbedn1NPlJ
 xE0Tg5krzYmFtEB91tohIA6dFobF3W8gYPFKVhtyYY3xr1uJkKyyN0FshlrAmKKeYPM0IA75O
 iPVP9UkXbMxM9C2LARlSGl/zD/R6IWLpADb2cDRPiFdBca2jg7JffTdby4E2Yo7gryAXz+lzz
 DIagi+YEAephMATRLP5lboCQfUzJXEYq1mkulYA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 26 Sep 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Whoa, wait.  If it is just that macro, can we perhaps do something
> > like the attached patch?
>
> I looked at all the uses of OFFSETOF_VAR() and I think the one used
> for hashmap_for_each_entry() is the only instance that 'var' given
> to it can legitimately be uninitialized, if typeof() were available.

Thank you for doing all that leg work. TBH I didn't even think about
looking further, after having run a couple tests manually that I thought
were exhaustive in exercising this type of code pattern.

> Here are the findings.
>
> #define hashmap_put_entry(map, keyvar, member) \
> 	container_of_or_null_offset(hashmap_put(map, &(keyvar)->member), \
> 				OFFSETOF_VAR(keyvar, member))
>
> The keyvar is a pointer to the entry being placed in the map; it
> must hold a valid one so the pointer-diff implementation of
> OFFSETOF_VAR() should work fine, or we are putting garbage in to the
> map.
>
> #define hashmap_remove_entry(map, keyvar, member, keydata) \
> 	container_of_or_null_offset( \
> 			hashmap_remove(map, &(keyvar)->member, keydata), \
> 			OFFSETOF_VAR(keyvar, member))
>
> The keyvar is used to match against an existing entry in the map to
> be removed---it must have a valid value.
>
> #define hashmap_for_each_entry(map, iter, var, member) \
> 	for (var =3D hashmap_iter_first_entry_offset(map, iter, \
> 						OFFSETOF_VAR(var, member)); \
> 		var; \
> 		var =3D hashmap_iter_next_entry_offset(iter, \
> 						OFFSETOF_VAR(var, member)))
>
> This, as you discovered, can be fed an uninitialized var and the
> first thing it does is to use OFFSETOF_VAR() on it in order to call
> hashmap_iter_first_entry_offset().  After that, i.e. when we called
> that function to start the loop, var is defined and we would be OK.
>
> The trick I suggested is to initialize var to NULL before making the
> call to hashmap_iter_first_entry_offset(), i.e.
>
> 	for (var =3D NULL, \
> 	     var =3D hashmap_iter_first_entry_offset(map, iter, \
> 						OFFSETOF_VAR(var, member)); \
>
> #define hashmap_get_entry(map, keyvar, member, keydata) \
> 	container_of_or_null_offset( \
> 				hashmap_get(map, &(keyvar)->member, keydata), \
> 				OFFSETOF_VAR(keyvar, member))
>
> Must be OK for the same reason _put_entry() is OK.
>
> #define hashmap_get_next_entry(map, var, member) \
> 	container_of_or_null_offset(hashmap_get_next(map, &(var)->member), \
> 				OFFSETOF_VAR(var, member))
>
> This tries to go to the next-equal-pointer starting from var, so var
> must be valid already.
>
> So, perhaps the attached may be a viable replacement that would be
> more futureproof with less maintenance cost, I suspect.

Definitely much nicer to maintain, and easier to verify. In my hands, this
works better than my manual touch-ups of _all_ the call sites. So I
replaced my patch with yours (adding your SOB).

Ciao,
Dscho

> Thanks.
>
> --- >8 ----- cut here ----- >8 ---
> Subject: hashmap_for_each_entry(): workaround MSVC's runtime check failu=
re #3
>
> The OFFSETOF_VAR(var, member) macro is implemented in terms of
> offsetof(typeof(*var), member) with compilers that know typeof(),
> but its fallback implemenation compares &(var->member) and (var) and
> count the distance in bytes, i.e.
>
>     ((uintptr_t)&(var)->member - (uintptr_t)(var))
>
> MSVC's runtime check, when fed an uninitialized 'var', flags this as
> a use of an uninitialized variable (and that is legit---uninitialized
> contents of 'var' is subtracted) in a debug build.
>
> After auditing all 6 uses of OFFSETOF_VAR(), 1 of them does feed a
> potentially uninitialized 'var' to the macro in the beginning of the
> for() loop:
>
>     #define hashmap_for_each_entry(map, iter, var, member) \
>             for (var =3D hashmap_iter_first_entry_offset(map, iter, \
>                                                     OFFSETOF_VAR(var, me=
mber)); \
>                     var; \
>                     var =3D hashmap_iter_next_entry_offset(iter, \
>                                                     OFFSETOF_VAR(var, me=
mber)))
>
> We can work around this by making sure that var has _some_ value
> when OFFSETOF_VAR() is called.  Strictly speaking, it invites
> undefined behaviour to use NULL here if we end up with pointer
> comparison, but MSVC runtime seems to be happy with it, and most
> other systems have typeof() and don't even need pointer comparison
> fallback code.
>
> ---
>  hashmap.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git c/hashmap.h w/hashmap.h
> index ef220de4c6..b011b394fe 100644
> --- c/hashmap.h
> +++ w/hashmap.h
> @@ -449,7 +449,8 @@ static inline struct hashmap_entry *hashmap_iter_fir=
st(struct hashmap *map,
>   * containing a @member which is a "struct hashmap_entry"
>   */
>  #define hashmap_for_each_entry(map, iter, var, member) \
> -	for (var =3D hashmap_iter_first_entry_offset(map, iter, \
> +	for (var =3D NULL, /* for systems without typeof */ \
> +	     var =3D hashmap_iter_first_entry_offset(map, iter, \
>  						OFFSETOF_VAR(var, member)); \
>  		var; \
>  		var =3D hashmap_iter_next_entry_offset(iter, \
>
>
