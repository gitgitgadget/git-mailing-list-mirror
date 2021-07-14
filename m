Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C718C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4396A61260
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhGNSt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGNStz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 14:49:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E3FC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 11:47:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dj21so4602363edb.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4lSsCYJX5rpRB8rM3lfWfRlZS3JfTjzvCk++Rw2vD8k=;
        b=KUdR6YfOWAg8hCy11pnO/x1qW+2Jug7rhuZ9HxVJRDMGiPY2MKThEpF4UK8vXdBEdG
         woSAE6l0MlTVQIyfIpRv5n++C+BSws+xOo49Jo1/sf66sYv8GtyeaWk/dmVB2J/i6Fc1
         tkmKJaaSml/UINpQu2F01rXTYbD54YboFmV6yHSU3X409BcjiFL5wzn689hYa7F/oxZP
         m1F2vp9++FFybl/wNcBwij6cphENqRFcLokC9JgaHckwigLYmU6f3bc5sT+Z16KJNMXH
         D2U07NruQY43kDsLTzJnC9+727fYn7xUUr38VGW+g1+I3kDTyFAaHlqY2v1yGsNsxmg7
         ZB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4lSsCYJX5rpRB8rM3lfWfRlZS3JfTjzvCk++Rw2vD8k=;
        b=uPGUziBiDUbVZfi2YZV/qQPXfWYaLC0X7HNTI808XyTjyrXmxhgBsU2UHK90DGwerw
         Q0z5EzyY6bQ0FMy9imzouXTBnK52pdzHA+i0NPjo9PZ5YI7X77rYUvaRJ0qESgz5aPor
         4jFfZO/dWdT7xm/VB0HwHtvkcpgJT+iF6dVHNDe+Ck74Ck9KzcG/zSeMRnzGoMh1vp3D
         SzfFGWTbXg3ktJjhVcv+34yo7dLwHUh5qtTMH8Y5rvkpJZYiJfN1lk6X7a6thnsjm3Ns
         vaaLBu7332QYW26Ug8pt5/VkF578AaRUwCLLv0uRMXNvqeambKdyOepk9jul27XlB+Ea
         js0g==
X-Gm-Message-State: AOAM531YDgxc3Q6QHQHwGyJF3V/MI4L8du9EctYweRWuXr48uZaj9yMH
        txBCQbguqcxF48Ggxy4eUwg=
X-Google-Smtp-Source: ABdhPJwZ1J+jgVEFBRdYmRJIzEOFGNdmWgBGBByiAoMUBsl7IJeaOMEfw4fTOtPiA4Gk7B/y3Gez8A==
X-Received: by 2002:aa7:d991:: with SMTP id u17mr15552942eds.240.1626288421169;
        Wed, 14 Jul 2021 11:47:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n11sm1084357ejg.43.2021.07.14.11.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Date:   Wed, 14 Jul 2021 20:44:27 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
 <87eecqzvld.fsf@evledraar.gmail.com> <YO8fpVZhoCiEiurR@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO8fpVZhoCiEiurR@nand.local>
Message-ID: <874kcw20nq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Taylor Blau wrote:

> On Fri, Jun 25, 2021 at 01:23:40AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Mon, Jun 21 2021, Taylor Blau wrote:
>>
>> > -static uint32_t find_object_pos(const struct object_id *oid)
>> > +static uint32_t find_object_pos(const struct object_id *oid, int *fou=
nd)
>> >  {
>> >  	struct object_entry *entry =3D packlist_find(writer.to_pack, oid);
>> >
>> >  	if (!entry) {
>> > -		die("Failed to write bitmap index. Packfile doesn't have full closu=
re "
>> > +		if (found)
>> > +			*found =3D 0;
>> > +		warning("Failed to write bitmap index. Packfile doesn't have full c=
losure "
>> >  			"(object %s is missing)", oid_to_hex(oid));
>> > +		return 0;
>> >  	}
>> >
>> > +	if (found)
>> > +		*found =3D 1;
>> >  	return oe_in_pack_pos(writer.to_pack, entry);
>> >  }
>>
>> So, a function that returns an unsigned 32 bit int won't (presumably)
>> have enough space for an "is bad", but before it died so it didn't
>> matter.
>>
>> Now it warns, so it needs a "is bad", so we add another "int" to pass
>> that information around.
>
> Right. You could imagine using the most-significant bit to indicate
> "bad" (which in this case is "I couldn't find this object that I'm
> supposed to be able to reach"), but of course it cuts our maximum number
> of objects in a bitmap in half.
>
>> So if we're already paying for that extra space (which, on some
>> platforms would already be a 64 bit int, and on some so would the
>> uint32_t, it's just "at least 32 bits").
>>
>> Wouldn't it be more idiomatic to just have find_object_pos() return
>> int64_t now, if it's -1 it's an error, otherwise the "pos" is cast to
>> uint32_t:
>
> I'm not sure. It does save the extra argument, which is arguably more
> convenient for callers, but the cost for doing so is a cast from a
> signed integer type to an unsigned one (and a narrower destination type,
> at that).
>
> That seems easier to get wrong to me than passing a pointer to a pure
> "int" and keeping the return type a uint32_t. So, I'm probably more
> content to leave it as-is rather than change it.
>
> I don't feel too strongly about it, though, so if you do I'd be happy to
> hear more.

I don't really care, it just looked a bit weird at first, and I wondered
why it couldn't return -1.

Aside from this case do you mean that such a cast would be too expensive
in general, or fears abou going past the 32 bits? I assumed that there
would be checks here for that already (and if not, we'd have wrap-around
now...).
