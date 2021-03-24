Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E9FC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 23:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3386661A10
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 23:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCXXFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 19:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhCXXFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 19:05:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505FFC06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 16:05:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so35590690ejj.7
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JMPrr8xva6srItE/MoYZPZwyEK3X6g8nEXAvfLveSxU=;
        b=Lufq0R1nDQVF1LSwMTPrdsbCUD19o71i3ecJjf/MGewj/xySV27nE8+Tt5mDjLVltF
         GY6NMFgVNDXIEu4b4utxttxNJg8tORznl1kBbnGYoA+ogoCUbFS4W3H5kXLLUBvho2c8
         2g8HrRn8v8OUos684hZtE/JjMFSF2EVbaE9C7SYEV8UyvEAn7I5SXg3efUczVkXS2fzO
         gz3y0QObZmfjP6eKLe7ZE8jqfHQjmmn+/eHUAgCHBg6HbKE31PLRyF/CN3GUeOHtWzwZ
         UgcJvrrYDgABna2xN1thytvAnGOe4e/WiYGrdF5Xknm+eFzuJIQzdsrzmDafJ9mdd+fu
         IzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JMPrr8xva6srItE/MoYZPZwyEK3X6g8nEXAvfLveSxU=;
        b=WzO/uA3j65S/JVcoAV6WFH/3gpHW6Re0x1Orbp1Y9OGIkQgoGaYjThoV0r61/6L9Wk
         R/NAxXszjgpwvJgeIer5MFWsXgIamxrn8GSJ4t4Xhk8V/yRQDCKfavEYVGr3RW43bgL1
         N2DfJ529OG8XblChsEKGM8lwUzE4zB1bxPGPoivecbSaS2HT2ZJn0mcjvfgrygR2mn4P
         e94zDC3Mo3+Nymn/p7lpODxuvr6aE0znHoR5hf5CpHTrYwQnUJvrks5AvukRyfEYKYO+
         L0q2b3kOfF3WlgfrGeCRr5ZKS5sv4hoybRUP1qUrnOlLLeWRuHdThGXi7ksp7QkJvkQ8
         AMdA==
X-Gm-Message-State: AOAM531RXtL6KaH9pmJjqvT8VKvHYwrS+JAoRNGhGHOIsA9d7B29jPOC
        gBw+lmqeu/EpMt72LfJKXqph6cVMyfBY3Q==
X-Google-Smtp-Source: ABdhPJwXyySl/7M4cBLBfgE2mvRdpDVW//5xGbsUwyDkqNXWAW6O6ODAt50js5+iEblG0u7ererUiA==
X-Received: by 2002:a17:907:248b:: with SMTP id zg11mr6096268ejb.364.1616627110798;
        Wed, 24 Mar 2021 16:05:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y17sm1561838ejf.116.2021.03.24.16.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:05:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
 <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
Date:   Thu, 25 Mar 2021 00:05:09 +0100
Message-ID: <87im5gp2ze.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 24 2021, Jeff King wrote:

> On Wed, Mar 24, 2021 at 02:48:47AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Refactor the userdiff_find_by_namelen() function so that a new
>> for_each_userdiff_driver() API function does most of the work.
>>=20
>> This will be useful for the same reason we've got other for_each_*()
>> API functions as part of various APIs, and will be used in a follow-up
>> commit.
>
> The refactorings up to here all made sense, but TBH this one makes the
> code more confusing to follow to me.
>
> Perhaps part of it is just that the diff is messy, but I had to read it
> several times to understand what's going on. Here's what I think were
> the tricky parts:
>
>> -static struct userdiff_driver *userdiff_find_by_namelen(const char *k, =
size_t len)
>> +struct for_each_userdiff_driver_cb {
>> +	const char *k;
>> +	size_t len;
>> +	struct userdiff_driver *driver;
>> +};
>
> Our callback function does _one_ type of selection (based on a "type"
> parameter), but not another (based on the name). That feels
> inconsistent, but is also the reason we have this awkward struct.  Part
> of my confusion is the name: this is not something to be generically
> used with for_each_userdiff_driver(), but rather a type unique to
> find_by_namelen() to be passed through the opaque void pointer.
>
> So "struct find_by_namelen_data" would have been a lot more
> enlightening.
>
> The fact that callbacks are awkward in general in C might not be
> solvable, at least not without duplicating some iteration code.
>
>> +static int userdiff_find_by_namelen_cb(struct userdiff_driver *driver,
>> +				       enum userdiff_driver_type type, void *priv)
>>  {
>> [...]
>> +	if (!strncmp(driver->name, cb_data->k, cb_data->len) &&
>> +	    !driver->name[cb_data->len]) {
>> +		cb_data->driver =3D driver;
>> +		return -1; /* found it! */
>>  	}
>
> This "return -1" took me a while to grok, and the comment didn't help
> all that much. The point is to stop traversing the list, but "-1" to me
> signals error. I think returning "1" might be a bit more idiomatic, but
> also a comment that says "tell the caller to stop iterating" would have
> been more clear.

*nod*

Also thanks for all the reviewing so far both, I'm not replying to all
of it point-by-point here, will respond with a re-roll at some point.

>> +int for_each_userdiff_driver(each_userdiff_driver_fn fn,
>> +			     enum userdiff_driver_type type, void *cb_data)
>> +{
>> +	int i, ret;
>> +	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_CU=
STOM)) {
>> +
>> +		for (i =3D 0; i < ndrivers; i++) {
>> +			struct userdiff_driver *drv =3D drivers + i;
>> +			ret =3D fn(drv, USERDIFF_DRIVER_TYPE_CUSTOM, cb_data);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_BU=
ILTIN)) {
>> +
>> +		for (i =3D 0; i < ARRAY_SIZE(builtin_drivers); i++) {
>> +			struct userdiff_driver *drv =3D builtin_drivers + i;
>> +			ret =3D fn(drv, USERDIFF_DRIVER_TYPE_BUILTIN, cb_data);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +	return 0;
>> +}
>
> I spent a while scratching my head at these types, and what they would
> be used for, since this caller doesn't introduce any. Looking at patch 7
> helped, though it's unclear to me why we need to distinguish between
> custom and builtin drivers there. As you note there, nobody calls
> list-custom-drivers nor list-drivers. And if we haven't configured
> anything, then wouldn't list-drivers be the same as list-builtin-drivers?
> Or for the purposes of that test, if we _did_ configure something,
>
>   As an aside, it feels like this is something we ought to be able to
>   ask git-config about, rather than having a test-helper. This is
>   basically "baked-in" config, and if we represented it as such, and
>   parsed it into a struct just like regular config, then probably "git
>   config --list --source" could be used to find it (and differentiate it
>   from user-provided config). Possible downsides:
>
>     1. Would people find it confusing that "git config --list" suddenly
>        gets way bigger? Maybe we'd want an "--include-baked-in" option
>        or something.
>
>     2. Is the cost of parsing the config measurably bad? Obviously a
>        user could provide the same content and we'd have to parse it,
>        but there's a lot more rules here than most users would probably
>        provide.

Also:

 3. Only the PATTERNS() macro translates as-is to config syntax. We
    don't have a way to do what IPATTERN() does in the config syntax
    currently.

    We could add a ifuncname and xifuncname or whatever for it I guess,
    but currently the ICASE behavior in the C code is magic.

>> +enum userdiff_driver_type {
>> +	USERDIFF_DRIVER_TYPE_UNSPECIFIED =3D 1<<0,
>> +	USERDIFF_DRIVER_TYPE_BUILTIN =3D 1<<1,
>> +	USERDIFF_DRIVER_TYPE_CUSTOM =3D 1<<2,
>> +};
>
> I was confused by these being bits, because some of them seem mutually
> exclusive (e.g., UNSPECIFIED and anything else).
>
> Perhaps it would make more sense as:
>
>   USERDIFF_DRIVER_TYPE_BUILTIN =3D 1<<0,
>   USERDIFF_DRIVER_TYPE_CUSTOM =3D 1<<0,
>   USERDIFF_DRIVER_TYPE_ALL =3D USERDIFF_DRIVER_TYPE_BUILTIN | USERDIFF_DR=
IVER_TYPE_CUSTOM
>
> Or the one caller who wants "ALL" could even do the OR themselves.
>
> I do kind of wonder if there's much value in having a single function
> with a type field at all, though, given that there's no overlap in the
> implementation. Would separate "for_each_custom" and "for_each_builtin"
> functions make sense? And then the existing caller would just call them
> sequentially.
>
> I dunno. I know a lot of this is nit-picking, and I don't think there's
> anything incorrect in this patch. I just found it surprisingly hard to
> read for something that purports to be refactoring / cleaning the code.
>
> -Peff

