Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD395C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiGHVqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbiGHVqM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 17:46:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5133524967
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 14:46:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l23so7960998ejr.5
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6Ju9DVne8IF7ZgBziGHhSk7cEtQ9ADHFESyB31MdYXw=;
        b=nuXx9qk5Ufy1BVtm4sReuPPyTcu6zt6Bx123jDc7dZHWXhV/SPeBbv9jE6k1zpSzpW
         B73/rwRwaH0ITDP63yQZiTuSnUDOAIrf5P0t3n/kdIbmhLRQC6Es3Oa9T752I3CYYv+0
         2dIha9TgmzDjap33wsX66TVdSmQONpmJ2S3c469PgZyzRhGR+ZisuSFeYtr7WN0TzWaF
         ZMCu55T0v7P4Ipbb7jvmG7VOI3Ij30bgRlPrDsAsUAexilElKAeeWR26Ig2ePhjLx3Wy
         ohL6cDh65Va2Jhy+pNHVF9fZuV59c49fUqaNzE3bvZgmmgH6nz7L24uuuxkq8E/GdNtf
         spMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6Ju9DVne8IF7ZgBziGHhSk7cEtQ9ADHFESyB31MdYXw=;
        b=QSoReAM9sAnqwTfBrsjSFfI0rOQrPhaM9THXckRXVIjHLvg/fvwLJ8DRQhynl8Qvuh
         /MSPLz1VgO70ffFEhhkq/d1JBowy/8ro84SMkRzGssuTIAC6rU61uIPFXZ22ckgKUDva
         UV32MTSg+VzEWzt5X5av7Qsnxxm5c7Ub4ANR2Z489R5ytXeLhqIW0Ye9aytwtT5IN4gh
         VINFAQ0MRjyuzHRnaCQGRJxnBjsr6KNVH4YczBIwK/x3QT/W7I6NhMydDyKgjzrXJ9G1
         9+mIn73gUYeN5JdWM+rzDVOKHAz1KxrV30dr2XiCfTfJqlr9aaDBKh8n4QgzT/cRy6QH
         0RBA==
X-Gm-Message-State: AJIora8jQ2V4DDuXx0StR22by75wgemcZZyJBUgKRVJLqP3MEzAKSF4v
        dZkBOlZb8hReaxb+TRHNaFU=
X-Google-Smtp-Source: AGRyM1vHhY0dhPHyVnSBLtBCWvZwx07D7bDUHpyIc3UhdjkHkxDJXP17+8cnV9jDcZOgEXfCIH/FbQ==
X-Received: by 2002:a17:907:868c:b0:72a:facd:c062 with SMTP id qa12-20020a170907868c00b0072afacdc062mr5848914ejc.727.1657316769766;
        Fri, 08 Jul 2022 14:46:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d557000000b0043a7c24a669sm8263769edr.91.2022.07.08.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:46:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9vnb-0002Te-TP;
        Fri, 08 Jul 2022 23:46:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/7] xdiff: remove xdl_malloc() wrapper, use malloc(),
 not xmalloc()
Date:   Fri, 08 Jul 2022 23:44:27 +0200
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-6.7-33d93f121a9-20220708T140354Z-avarab@gmail.com>
 <1bf5d574-4202-31e3-4dc3-d7890465d28f@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1bf5d574-4202-31e3-4dc3-d7890465d28f@gmail.com>
Message-ID: <220708.868rp39t28.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 08 2022, Phillip Wood wrote:

> On 08/07/2022 15:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> As noted in 36c83197249 (xdiff: use xmalloc/xrealloc, 2019-04-11) the
>> reason we have xdl_malloc() in the first place was to make the xdiff
>> code safer, it was not handling some allocation failures correctly at
>> the time.
>
> This is untrue, we do not have xdl_malloc to make the xdiff code
> safer, that macro was introduced with the initial import of
> xdiff. 36c83197249   just changed its definition, the entire commit
> consists of
>
> -#define xdl_malloc(x) malloc(x)
> +#define xdl_malloc(x) xmalloc(x)
>  #define xdl_free(ptr) free(ptr)
> -#define xdl_realloc(ptr,x) realloc(ptr,x)
> +#define xdl_realloc(ptr,x) xrealloc(ptr,x)

Yes sorry about that, I'm missing a few words there, and meant "the
reason we have this incarnation of xdl_malloc()[...]", or something to
that effect.

> I can see the argument for reverting that change now that we have
> fixed the error checking but that is not a good reason to remove
> xdl_malloc().

Indeed, but hopefully
https://lore.kernel.org/git/220708.86czef9t6y.gmgdl@evledraar.gmail.com/
is that argument.

>> But as noted in that commit doing this was intended as a stopgap, as
>> various code in xdiff/* did not correctly handle allocation failures,
>> and would have segfaulted if malloc() returned NULL.
>> But since then and after preceding commits we can be confident that
>> malloc() failures are handled correctly. All of these users of
>> xdl_malloc() are checking their return values, and we're returning
>> -1 (or similar ) to the top-level in case of failures.
>> This also has the big advantage of making the compiler and analysis
>> tools less confused, and potentially avoiding undefined (compiler)
>> behavior. I.e. we define our own xmalloc() to call die() on failure,
>> and that function uses the non-standard "noreturn" attribute on our
>> most common compiler targets.
>> But xdl_malloc()'s use conflicted with that, confusing both human
>> readers of this code, and potentially compilers as well.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   xdiff/xdiff.h  |  1 -
>>   xdiff/xdiffi.c |  2 +-
>>   xdiff/xmerge.c | 10 +++++-----
>>   xdiff/xutils.c |  2 +-
>>   4 files changed, 7 insertions(+), 8 deletions(-)
>> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
>> index 832cf9d977e..df048e0099b 100644
>> --- a/xdiff/xdiff.h
>> +++ b/xdiff/xdiff.h
>> @@ -119,7 +119,6 @@ typedef struct s_bdiffparam {
>>   } bdiffparam_t;
>>=20=20=20=20=20
>> -#define xdl_malloc(x) xmalloc(x)
>>   #define xdl_free(ptr) free(ptr)
>>     void *xdl_mmfile_first(mmfile_t *mmf, long *size);
>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>> index 077cc456087..6590811634f 100644
>> --- a/xdiff/xdiffi.c
>> +++ b/xdiff/xdiffi.c
>> @@ -368,7 +368,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xppara=
m_t const *xpp,
>>   static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, =
long chg1, long chg2) {
>>   	xdchange_t *xch;
>>   -	if (!(xch =3D (xdchange_t *) xdl_malloc(sizeof(xdchange_t))))
>> +	if (!(xch =3D (xdchange_t *) malloc(sizeof(xdchange_t))))
>>   		return NULL;
>>     	xch->next =3D xscr;
>> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
>> index ac0cf52f3be..676ad39020d 100644
>> --- a/xdiff/xmerge.c
>> +++ b/xdiff/xmerge.c
>> @@ -60,7 +60,7 @@ static int xdl_append_merge(xdmerge_t **merge, int mod=
e,
>>   		m->chg1 =3D i1 + chg1 - m->i1;
>>   		m->chg2 =3D i2 + chg2 - m->i2;
>>   	} else {
>> -		m =3D xdl_malloc(sizeof(xdmerge_t));
>> +		m =3D malloc(sizeof(xdmerge_t));
>>   		if (!m)
>>   			return -1;
>>   		m->next =3D NULL;
>> @@ -409,7 +409,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfen=
v_t *xe2, xdmerge_t *m,
>>   		m->i2 =3D xscr->i2 + i2;
>>   		m->chg2 =3D xscr->chg2;
>>   		while (xscr->next) {
>> -			xdmerge_t *m2 =3D xdl_malloc(sizeof(xdmerge_t));
>> +			xdmerge_t *m2 =3D malloc(sizeof(xdmerge_t));
>>   			if (!m2) {
>>   				xdl_free_env(&xe);
>>   				xdl_free_script(x);
>> @@ -670,7 +670,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *x=
scr1,
>>   						 ancestor_name,
>>   						 favor, changes, NULL, style,
>>   						 marker_size);
>> -		result->ptr =3D xdl_malloc(size);
>> +		result->ptr =3D malloc(size);
>>   		if (!result->ptr) {
>>   			xdl_cleanup_merge(changes);
>>   			return -1;
>> @@ -718,14 +718,14 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfil=
e_t *mf2,
>>   	}
>>   	status =3D 0;
>>   	if (!xscr1) {
>> -		result->ptr =3D xdl_malloc(mf2->size);
>> +		result->ptr =3D malloc(mf2->size);
>>   		if (!result->ptr)
>>   			goto out;
>>   		status =3D 0;
>>   		memcpy(result->ptr, mf2->ptr, mf2->size);
>>   		result->size =3D mf2->size;
>>   	} else if (!xscr2) {
>> -		result->ptr =3D xdl_malloc(mf1->size);
>> +		result->ptr =3D malloc(mf1->size);
>>   		if (!result->ptr)
>>   			goto out;
>>   		status =3D 0;
>> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
>> index c0cd5338c4e..865e08f0e93 100644
>> --- a/xdiff/xutils.c
>> +++ b/xdiff/xutils.c
>> @@ -98,7 +98,7 @@ void *xdl_cha_alloc(chastore_t *cha) {
>>   	void *data;
>>     	if (!(ancur =3D cha->ancur) || ancur->icurr =3D=3D cha->nsize) {
>> -		if (!(ancur =3D (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsi=
ze))) {
>> +		if (!(ancur =3D (chanode_t *) malloc(sizeof(chanode_t) + cha->nsize))=
) {
>>     			return NULL;
>>   		}

