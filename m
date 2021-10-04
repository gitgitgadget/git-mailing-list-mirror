Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9612DC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 11:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEEA61354
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 11:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhJDLdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 07:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhJDLdb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 07:33:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E781C061746
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 04:31:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bm13so13536707edb.8
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=s3nKTCciCz50KBHKbuKv0WayEi3mbwu7hOTWio4gPmY=;
        b=O8mv8xt9/LyBeYDLmCBCDmFi80HvbmnX9US2kZi4zGsY3ABNZg+LO8JS8dkZATD1Y0
         INTvd5M78Dpz/OG0kQg9T3JsqJlR522TOTPMmQGjs7CqO6oNc1D+XEJKoA5K5X5M3oMD
         2dGoE6bARJufkKqUM0RdnNAqm8uzBpT3oyyxwNVyIhwPHQqambKO/ggdy+KX1fotH20A
         cUQKOuBvDbOdINEZOAJN89+bIFsE1X2VsV4271RFBAnlZQ1N57Phu0BdtyWpnOcBT56G
         2nKKSmT/SofowYVD/r6zK7AS0m9WUEl7BYM2SwirZFiLlTxeo0PYEwnS625JcVa3wnep
         LEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=s3nKTCciCz50KBHKbuKv0WayEi3mbwu7hOTWio4gPmY=;
        b=o+h95sKNNhJ3fQAExhLmSCvL9rED8tFJ/sUMd6P2wKyvZy5zhHFQYWMzRTb+EkZiAH
         JSU3OXIp5N74g1ZwnIragUOlhyAKz+e/6W2GyWpOYpQQqHyNmIJncCf0TOJqdq16Hm/t
         jrq6pPdmcttRuLH4TW17NuV2iswMUoEUZhQ1pdCtXNUMUrnNHUvPbtmAMv3atU3cnXFp
         VDKkkKScBgG/uOsK6U52QJ/D16S96gFaC0e+eTQuMpCquvIBwjlDBBhKvLZUwIb/bIXJ
         Mdv8BNPbzHTxVvwb4kdqDulF225E/TF+Vd+k8jBXR/BDCqg5U8DvdoyfurgN/Hr1VuFZ
         P3kA==
X-Gm-Message-State: AOAM533vEkBy2AWJxMJdRcBimFxLeZtJr7PlbPE7pfcsAKIDUmevO/by
        63GAmFp+lyAWLHvLc0n1FyCgDZBrB8lzvA==
X-Google-Smtp-Source: ABdhPJwvMP7AvQa1K2JXDPtIWyViBPjL/m5odKgRDqaz7FQ7MKdXl8U20+40q1tmqFqLNsszGhcZ5Q==
X-Received: by 2002:a05:6402:78f:: with SMTP id d15mr7040010edy.44.1633347100932;
        Mon, 04 Oct 2021 04:31:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d14sm3817065ejd.92.2021.10.04.04.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 04:31:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-name: make ambiguous object output translatable
Date:   Mon, 04 Oct 2021 13:16:24 +0200
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <patch-2.2-b6136380c28-20211004T013611Z-avarab@gmail.com>
 <YVqu0aEBMy3mnYoE@coredump.intra.peff.net>
 <87o885nq4z.fsf@evledraar.gmail.com>
 <YVrJj0Ltuc1Tcm7t@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVrJj0Ltuc1Tcm7t@coredump.intra.peff.net>
Message-ID: <877detni03.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Jeff King wrote:

> On Mon, Oct 04, 2021 at 10:26:10AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> +		/*
>> >> +		 * TRANSLATORS: The argument is the list of ambiguous
>> >> +		 * objects composed in show_ambiguous_object(). See
>> >> +		 * its "TRANSLATORS" comment for details.
>> >> +		 */
>> >> +		advise(_("The candidates are:\n\n%s"), sb.buf);
>> >
>> > Here's where the extra newline.
>> >
>> > I understand why the earlier ones were changed for RTL languages. But
>> > this one is always line-oriented. Is the point to help bottom-to-top
>> > languages? I can buy that, though it feels like that would be something
>> > that the terminal would deal with (because even with this, you're still
>> > getting the "error:" line printed separately, for example).
>> >
>> > I don't think what this is doing is wrong (at first I wondered about t=
he
>> > "hint:" lines, but because advise() looks for embedded newlines, we're
>> > OK). But if the translation doesn't need to reorder things across line=
s,
>> > this extra format-into-a-strbuf step doesn't seem necessary. We can ju=
st
>> > call advise() directly in show_ambiguous_object(), as before.
>> >
>> > If it is necessary, then note that you leak "sb" here.
>>=20
>> I'll keep that bit as-is, it's not strictly necessary, but it gives
>> translators a bit more context.
>
> If it's just for the context, wouldn't this do the same thing:
>
>   /*
>    * TRANSLATORS: This is followed by the list of ambiguous
>    * objects composed in show_ambiguous_object(). See its
>    * "TRANSLATORS" comments for details.
>    */
>   advise(_("The candidates are:"));
>   ...
>   if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
>      ...
>
> I.e., leave the code as-is, and just add the extra comment. There is no
> need for the extra struct or any change of ordering between this
> advise() and the others.
>
> I would think it is worthwhile if we are de-lego-ing a message that is
> made in chunks, but in this case the we have to construct an opaque "%s"
> to represent the individual lines for each object, because we don't know
> how many of them there will be.
>
> -Peff
>
> PS In my "something like this" commit message, I indicated that the
>    "candidates" message was getting translated, but it actually is
>    already translated in the pre-image. So I think we would not need to
>    touch that line at all.

Yes you're right. You've got me, I guess :)

An unstated motivation of mine here is that I've got a series that
changes the advise() function itself so that it automatically adds the
"and run xyz to disable this message".

Now some don't emit it, some don't even have associated configuration or
documentation. It's a mess.

I originally hacked this up because this is the one in-tree user of
advise() that constructs output incrementally. So for that improvement
to advise() it either needs to be changed to not do so (this patch), or
I'd need an advise_no_template() or advise_hint_line() or whatever as a
workaround.

I didn't mean to be too subterfuge-y about it. It's just hard to find a
balance between a single long series & a few shorter ones, and when to
distract reviewers with "this design choice is also because of XYZ
tangentally related end-goal".

Anyway, now that we're here I'm not sure what the best way forward
is. One is to just address the pointed-out bugs and keep that
accumulate/print pattern I instituded, which would help that subsequent
series. But I agree that while I think it is a bit better to translate
the "foo:\n\n%s" message (it gives a bit more context about what sort of
message it is), it's not really worth it just in the context of this
patch.

What do you think? That we could let this pass for now, or we should
drop this and I can try to re-visit it as part of some larger topic?
That meaningful improvement to advise() depends on this + another series
of advise fixes I submitted in parallel at [1].

1. https://lore.kernel.org/git/cover-0.5-00000000000-20211004T015432Z-avara=
b@gmail.com/T/#t
