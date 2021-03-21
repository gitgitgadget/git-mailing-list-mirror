Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46228C433E0
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1818C6194F
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCUSme (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhCUSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 14:42:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD554C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 11:42:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w3so17726887ejc.4
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GoQVnR2+qKSOJHrjkLprS2TDJE8Avg2R4D5TbE5sVdo=;
        b=SuAzPXIGSIWJ04rsLsBCjvfBWdfedZMei49LtqCw/2babhUrwntUuVnTa2ArpztNKT
         C2dez0i/+99ul8a+KMk4gyVCBvCGAX/VJdRzHuj+wmN4w8ln9qMlO4MZWFWl5XBC8Nz1
         WNRHkpEf5iHPDHr6bt4Vir5Vq/Gg08sJpXFdfyo3PGYENZxPFcUxAU7hNg9La1eA4dI2
         Gf3YIvzdlTa17PkIKhHufaThdKRY60dPPxqDwq0XyW6zPm9V/e9r+Fk5/jQCU6xZetkU
         iVPxp3c2fc7jYl8vnkfzIAaztN3sTbcVEH1hMUvzUMnz2mxMwCoilxppZMlaDDDL2WUi
         Ww+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GoQVnR2+qKSOJHrjkLprS2TDJE8Avg2R4D5TbE5sVdo=;
        b=NUZs4ZwMOzJvkFbIrpLtMPHf8Z383apJoZPb3NChVx2yUCdNsEav1p9ceMDmGPU/mT
         SYkeQSi2P6PYNOrsKz4FpNIQcS8ux3MoBoak7fzfr9SXZ6OWAhZr2//pzas/yqkX1Dol
         k4rsk1cgkYNPBpOAOTXdR4KkHjH/3up6jgPAGr5UQuz+bxaeyWGdYk/G1TWThQFVsN30
         fYsUlVysda8i8XV7O0Cc8iJznfc52PWeTdaL3QQrastHbjXuSQjZesiZdRfU5z7BLAdy
         PGLTRs7uOSO+KK0RSqWomwZunVIRMbw3nmks6py06u0XTR9Rxh0XSsnzJZFBYQM2e6MT
         YWFA==
X-Gm-Message-State: AOAM531vubM0wstBqlvfjtCl3o8J6v//lzsXs3fdv5rHxKsh2YqiJFo5
        WVthPcLpHMNbcUjz7fNl558=
X-Google-Smtp-Source: ABdhPJxdpPkWOYWkhhC2jI9KG9KQBbE+hX1sof4oQalKOUOvn5bEP2xU2k8bgSzczlRmkK0d/uklSw==
X-Received: by 2002:a17:906:b846:: with SMTP id ga6mr4294322ejb.542.1616352136394;
        Sun, 21 Mar 2021 11:42:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id si7sm7677449ejb.84.2021.03.21.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 11:42:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/29] tree-walk: mostly replace "mode" with "enum
 object_type"
References: <20210316155829.31242-1-avarab@gmail.com>
 <cover.1616282533.git.avarab@gmail.com> <xmqqtup5cnlu.fsf@gitster.g>
 <87wnu0r8tq.fsf@evledraar.gmail.com> <xmqqlfagbfbk.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqlfagbfbk.fsf@gitster.g>
Date:   Sun, 21 Mar 2021 19:42:15 +0100
Message-ID: <87o8fcqrg8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 21 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Yes, that would be a serious regression. I agree that all these
>> functions/callbacks etc. should have a way to get at the mode bits.
>>
>> I'm adding "enum object_type", not removing the "mode" parameter in
>> read_tree_fn_t. This function (which is in "seen" as 03316f20347
>> (sparse-index: implement ensure_full_index(), 2021-03-16)) works just
>> fine in combination with this series.
>>
>> The other APIs modified here all retain the ability to give you the mode
>> bit, they (the tree-walk.h changes) just optionally give you the option
>> of getting just the type (or just the path), and as it turns out most
>> users of the API can be converted over to that.
>
> I have a vague feeling that such an approach may be still repeating
> the same mistake.
>
> If the original premise is that "unsigned mode" bit can be abused to
> feed impossible values like 0100653 to the system and the code
> should catch it, ...
>
>> The current codebase will allow you to stick arbitrary mode bits in
>> trees, ...
>
> ... then I would understand it if the approach is to introduce a
> distinct type that enumerates all possible mode bit values (and
> nothing else), and have the compiler validate the callchain, so that
> nobody can pass bogus mode bits (and when reading mode bits fields
> in existing objects, the one that converts from the series of octal
> bytes to that distsinct type would notice and complain).  And we've
> already seen from this particular breakages that the "distinct type"
> appropriate to be used for that purpose is not "enum object_type".
> It is not expressive enough to enumerate all possible mode bit
> values (besides, an enum is interchangeable with an int, so there
> isn't much protection we would be getting from the compiler---we
> could use a small struct of a new type, and have one static const
> instance for each possible mode bit combination, I guess, but the
> point here is that insisting on using "enum object_type" seems to be
> the source of the problem).

Yes, this is a good suggestion, but one which'll be much easier to do
after this series. Since the majority of callers don't care about the
raw mode bits or anything except if the entry is a blob/tree/commit.

> I am afraid that it is even worse to pass both object type and
> "unsigned mode" together.  It would still leave room for a bug to
> pass nonsense mode bits, which we said we wanted to catch in our
> original mission statement.  In addition, we now have a new room for
> a bug, which is to pass an inconsistent pair of object type and mode
> to the callchain.  Somebody would need to say "yuck, we got a mode
> 100644 but the type says TREE" now, in addition to validating if the
> mode is sensible, which we should be doing somehow, no?

Indeed. This goes back to my "bear with me" comment upthread. I'm
planning to fix these cases too, and starting by moving most things to
"enum object_type" makes that a lot easier.

Right now we simply trust the mode bits, but that opens the door to the
same sort of bug I'm fixing in another series (that I need to re-roll)
where we have a "type commit" and "object ID" in a tag, but the ID is
really a tree or whatever.

We then get confused because we trusted the invalid metadata over
checking the type of the object ID we have in the object store.

So this particular series doesn't fix this bug at the end of it, the
"object_type" in tree-walk.c is just a function of deriving it from the
mode bits.

But once I've audited the cases where we're really just acting on the
type and don't have or use the mode (so we know we're not re-writing the
mode somewhere) then we would set the object_type to the actual type, as
in what we'd get from oid_object_info(ID).

Then we can e.g. scream murder about a mode/type mismatch in fsck, but
still be able to list/diff/inspect etc. that object in any codepath that
just wants to e.g. recursively iterate over the tree.



> So, I am not sure how these changes are making anything better.
>
>> ... I had a
>> summary of this in v1, but should probably have provided a recap[1].
>
> Oh, absolutely.  When we iterate, we should be welcoming to those
> who missed earlier iterations.

