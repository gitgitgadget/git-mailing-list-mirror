Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D6C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3D961879
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhGCLje (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGCLjd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 07:39:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2103AC061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 04:37:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so16840689edt.13
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=auNoiS09u3bAo86w3C1x6uCIzx3XgKCzAxlj5ieZgp4=;
        b=M1ltp8mOqbxvhNTnEMoV2LwF1dmjPHdi7K9IhRxxbnwp6vu+aQ/heQ07anXoqmVq2l
         Aky4Mew7B9qfvAKw+CzmcEt60YgBNk3ryGM4A6dWw3x5ZTxb88+biot8eLfOws8OM0aT
         vR+mxq+qQlugVwXv2OyIGJaaxoBqENs2TwRvWMZ9v0O06UvKAcprde1uzGAVZtNR1FGs
         vRljWLuJXn0qvgGi8BNNwvNao8dqUexUxxMvRZDSqTZXFpScw0/71gA1S0O3ACGceMjC
         I5NvXX26n5u6LNjDavjFmRyqywn4qA89Br2D0299V/d0/6wbNxMF5mbK+9r0R/s5xmF5
         fYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=auNoiS09u3bAo86w3C1x6uCIzx3XgKCzAxlj5ieZgp4=;
        b=keO5t7cq8DMkMx9eZCXLGbXDNqv5wknpCaZKnrA89AONN74GSU69LLH5QIkeae9VJG
         M2gmhZhF2bXIa2odog7nUWprAy6TzLwAnxlv2LHUV+vfoCEGBTvdLdeQ+GLw44CzhUnw
         b39szsLU8r5tddC8KtDX3KJPwjBoaB3k+kYgjXX6p4+daNol1iFGWBf1Jhr5p7VAv0ty
         E42jV7qXTxQJT4asR9vAWia1lUtLeHEXFek5irFZBiDdsUjCOa+9G9zFfP+vUrQayNlL
         aP08UjhbN1rCSoi2e+giaLLlnqMVsmIiWGJjl6gFAfWS2llSxY383cni5yuOGPQpSqGL
         AU8Q==
X-Gm-Message-State: AOAM532abgpoUbI/95VNbWhVl2miIoO280ZWUohUrjyWY34tRLo+f9v9
        ST9Ewt71NIQKsnTwBJSasIs=
X-Google-Smtp-Source: ABdhPJwgBqKBz4gnDvlRJ66qkhZuBpuQ2CEK5r0Dnx8Fm1yuP/iOWWVJEfUEcWpjXZTGd8opWEyZYw==
X-Received: by 2002:aa7:cb90:: with SMTP id r16mr4830106edt.121.1625312218630;
        Sat, 03 Jul 2021 04:36:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mm27sm2060971ejb.67.2021.07.03.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 04:36:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] khash: clarify that allocations never fail
Date:   Sat, 03 Jul 2021 13:35:45 +0200
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
Message-ID: <87v95r8w86.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 03 2021, Jeff King wrote:

> On Sat, Jul 03, 2021 at 12:05:46PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> We use our standard allocation functions and macros (xcalloc,
>> ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
>> the program on error, so code that's using them doesn't have to handle
>> allocation failures.  Make this behavior explicit by replacing the code
>> that handles allocation errors in kh_resize_ and kh_put_ with BUG calls.
>
> Seems like a good idea.
>
> We're very sloppy about checking the "ret" field from kh_put_* for
> errors (it's a tri-state for "already existed", "newly added", or
> "error"). I think that's not a problem because as you show here, we
> can't actually hit the error case. This makes that much more obvious.
>
> Two nits if we wanted to go further:
>
>> diff --git a/khash.h b/khash.h
>> index 21c2095216..84ff7230b6 100644
>> --- a/khash.h
>> +++ b/khash.h
>> @@ -126,7 +126,7 @@ static const double __ac_HASH_UPPER =3D 0.77;
>>  			if (h->size >=3D (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) j=
 =3D 0;	/* requested size is too small */ \
>>  			else { /* hash table size to be changed (shrink or expand); rehash *=
/ \
>>  				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
>> -				if (!new_flags) return -1;								\
>> +				if (!new_flags) BUG("ALLOC_ARRAY failed");				\
>
> I converted this in b32fa95fd8 (convert trivial cases to ALLOC_ARRAY,
> 2016-02-22), but left the now-obsolete error-check.
>
> But a few lines below...
>
>>  				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_=
t)); \
>>  				if (h->n_buckets < new_n_buckets) {	/* expand */		\
>>  					REALLOC_ARRAY(h->keys, new_n_buckets); \
>
> These REALLOC_ARRAY() calls are in the same boat. You dropped the error
> check in 2756ca4347 (use REALLOC_ARRAY for changing the allocation size
> of arrays, 2014-09-16).
>
> Should we make the two match? I'd probably do so by making the former
> match the latter, and just drop the conditional and BUG entirely.

Yes, I don't see why we should be guarding theis anymore than we do
xmalloc() or other x*() functions in various places (which is what it
resolves to).

If anything we might consider renaming it via coccinelle to
XALLOC_ARRAY(), XREALLOC_ARRAY() etc. to make it clear that they handle
any errors themselves.
