Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AADC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 03:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLGDtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 22:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiLGDtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 22:49:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286264D5E2
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 19:48:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m19so23135334edj.8
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 19:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uiFZCvPZPOL74nG5XaGzWagCc03e0GeyZuqFerUnGCA=;
        b=qBPUVQxP2catBgvhfc0wavg1J0KzTTWAE2sKvMGb0OVOR6korxz9jQztUs47u7DB5Z
         ymve4Aah3HA5TzmtHW/gLb/Op2vo8Moyk2ohelqUSCmxjJv6SQKWouE+xzqk3Z05GTg+
         pCbIPBl2uF54kYqXh1JvQQVx7SC+IYp3Alh2b1ck/9ZQdtrWSqn0k/PhBKiMC9kB8F42
         9qtakfX0rJpa1Yk1qLWflu3Zc33NyxDaiQRtyu8M69jMro6iBQOqTPilvkiM+tRSKq4A
         CHeTWSvY4rBWEYehggI1hG+CD0qZ/ZKmbTzQGGDmXqN0EZZPHLEZ0Usqj02+jbcJzGJO
         RTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiFZCvPZPOL74nG5XaGzWagCc03e0GeyZuqFerUnGCA=;
        b=iLKWllZbxqMUEADv5sv6LEGnMvYP7tlTrvSMzphQhzP57clLzJ47iitZ/k+Cf/Z69S
         yRKM79FRYs6BJd96xg05Pu2TZLB6iTFhDtbD+tTUN3F9+VUm1IMOCis1dtinM3FUSwd1
         6L5OKYLTBI+yZpTgUHvorAcK2XeegpvZsiUlDyXUHBBV070B0YWP4+PtDI+YRXaLnluo
         KQgf/rGn8jF1wJ3aVXcBH/tyoH1AGo64ZdDHJyikndfkYLcwRTxe3nZzSqTt69u6ov6U
         r0AfRTKpuFrExifMB4IUcWR6MiVEAqzi2SXze1giPUoPpjNHG5OFIZyhG3xlH+XdDvkM
         OROg==
X-Gm-Message-State: ANoB5plQ91AB5EEGYJtd8uPiQHDso/tAsBcWUqlaqhOFSNk7lwLSA6zW
        hqOOUhbUK1TW2ATlhsXkJAE=
X-Google-Smtp-Source: AA0mqf58KNrDgZ6BIe761s3JS3LfHQTjlRAkxKAX7pT4qDyMQ+qv7Qetrfl/OBFsfHTw2NXd5tOvcA==
X-Received: by 2002:aa7:c1d0:0:b0:46b:431f:f2d4 with SMTP id d16-20020aa7c1d0000000b0046b431ff2d4mr12810988edp.198.1670384936448;
        Tue, 06 Dec 2022 19:48:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090632c300b007aece68483csm7965048ejk.193.2022.12.06.19.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 19:48:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2lQV-004IyO-1g;
        Wed, 07 Dec 2022 04:48:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Date:   Wed, 07 Dec 2022 04:17:07 +0100
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
 <221206.868rjle7za.gmgdl@evledraar.gmail.com>
 <Y4/7txDTWK5nGPDu@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y4/7txDTWK5nGPDu@nand.local>
Message-ID: <221207.86bkofc1qw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Taylor Blau wrote:

> On Tue, Dec 06, 2022 at 12:12:32AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> First, when you add *.pending.cocci rules they shouldn't be pseudocode,
>> but things that are too large to apply right now. I think my recent
>> 041df69edd3 (Merge branch 'ab/fewer-the-index-macros', 2022-11-28) is a
>> good example.
>
> Agreed, but I do tend to consider this patch too-large to apply right
> now.

I think it's OK if a *pending* patch is 10k lines or whatever, as long
as the result of applying it compiles. I.e. if it doesn't compile the
semantic patch is broken, and doesn't really help to clarify what the
proposed change is.

Whether the change itself is too large to be worth it or whatever is
another matter, but we can always consider it advisory.

E.g. consider a change to remove braces from if/else per our coding
style, we don't have such a *.cocci now, but if we did it would be a
very large patch. It might still be useful in *.pending.cocci, e.g. to
run new code through it.

> Whether or not 2k lines of diff is review-able or not (and FWIW, I think
> that your recent Coccinelle-generated patches were quite easy to review
> pretty quickly), I think there's a bigger question of whether or not we
> want to make such a sweeping, tree-wide change. And assuming the answer
> to that is "yes", there's is also a question of timing. Proposing it
> towards the middle or end of a release cycle seems in bad taste.
>
> But I think splitting this discussion up into, "should we introduce
> something like CALLOC() into our style conventions?" and "do we want to
> apply this everywhere?" is worth doing. The former doesn't seem to take
> a ton of time away from polishing the release candidates, and the latter
> can be done only after the former has settled.
>
> So the decision to make this a *.pending.cocci rule was definitely
> intentional in this case.

Yes. A sweeping change like this should definitely start there (although
see below).

> [...]
>> Third, the resulting patch is currently ~2k lines. Can we really not
>> make it non-pending with some whitelisting/gblacklisting. E.g. see this
>> out-of-tree patch for an example of opting out certain functions:
>> https://github.com/avar/git/commit/bedd0323e9b
>
> See above.

What I'm demonstrating with that commit is that you can make a
non-pending patch by blacklisting the functions, filenames etc. that are
known to be outstanding.

The advantage of doing that being that you'd apply it for any new code
outside those scopes.

So re the "see above" it's an explicit end-run around the "do we want to
apply this everywhere?".

>> Fourth, I must say I'm kind of negative on the proposed change. I.e. the
>> foot-gun is definitely worth solving, but why not just create a
>> coccinelle rule to narrowly address that? In that case we can presumably
>> start with it non-pending, as we don't have that many of them.
>>
>> On the notion that we need to special-case:
>>
>> 	- CALLOC_ARRAY(ptr, 1)
>> 	+ CALLOC(ptr)
>>
>> Because an array of one is "not an array" I don't really buy it. The
>> calloc() interface itself exposes that, so I don't see why we'd consider
>> those separate on the API level for these wrapper macros.
>
> I think the point is that it's just weird. Yes, an array of just a
> single element on the heap is indistinguishable from asking malloc() to
> give me the same bytes and then memset() them myself, just as it's
> indistinguishable from calloc()'ing the right number of bytes for a
> single structure to begin with.
>
> But whether or not the two are indistinguishable doesn't mean that it
> makes intuitive sense, and that is the goal of CALLOC().

I understand that's the goal, I just don't get how it's intuitive.

First we had REALLOC_ARRAY(), which is the same as a reallocarray(3)
where the "size" is computed for you based on the "ptr", which we know
to be a variable name in our case. Later we had ALLOC_ARRAY() and
CALLOC_ARRAY(), which aim to provide the same sort of interface for
malloc() and calloc().

The reallocarray() function comes from OpenBSD, where it's always
supported nmemb =3D 1:
https://man.openbsd.org/OpenBSD-5.9/malloc.3#reallocarray~2

It has always been redundant to use it for nmemb=3D1, but as arrays in C
don't have containers (unlike some higher-level lanugages) it would be
odd to disallow it, and force the user to do:

	mem =3D n =3D=3D 1 ? realloc(mem, sz) : reallocarray(mem, n, sz);

Instead of:

	mem =3D reallocarray(mem, n, sz);

I.e. you don't need the overlfow check for n * sz if n =3D=3D 1, but
treating it as a special-case is a hassle.
