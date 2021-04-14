Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC15EC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 06:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC57460FD8
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 06:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345775AbhDNGNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhDNGM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 02:12:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2211C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 23:12:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so29626104ejc.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=r9VAvkIciehPXqEvEw44qv/vZYjiMGfz6lFhmEJ8gVg=;
        b=plo0aHsNAA9rFaNqNAUCljFWTWVVdOGxN873mitq438NysEDcaOeCIKldF5Z2ki5Vg
         Rr5j5focWIwl1Y22AU+Jq/WM1M+AHLVpYfapFalNkeUzEpImCFw0rczYah8/koO5kd7P
         DFFMmgjkG2BzWOBJ4BZsGaUXDUal81aPuVJSlkdgHzo8cKUi2GxWXpcqe13AwuUGu36S
         k5yRtXJgKTMKpryDapnH2UeWRINdgHGS//Zz8DxFgQ12SGunARbCUkZVU0ggPN5r4BAf
         QWiu2/4YwZhq7ZdBv7uy9KcS1yB/0ZFb7XLUYHbF2JBq34lH92h/Byspj4NuwnV/Xb9F
         OmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=r9VAvkIciehPXqEvEw44qv/vZYjiMGfz6lFhmEJ8gVg=;
        b=AMwhkEeCOJ1hiSOTVR7K3+j6fg0C+SEc6P5Uyy3X7QyE8PTthqJaOcQnwTIA06/JsL
         OK6Z1r7BTeEohgKundv1DPHjy9zfSFaa5u4ssjIMpeT+KvNZf6oeccFP3NT6j7cGMare
         CTJS1HQv/hO6ACV/+cHbuFqdHgKmX2VatAU4tvih4Lwl3LknvJv9CK/kMaivt42pC2AX
         mOMu4LanPFk0p4xfwPOlz5a/lSvZI9NW9lq2Q8dUZCkM/W1y5q5yc+FXQgo0uMaekKVB
         pbcjXPesTMY/GDnXW/62GYcqABk3C//ICrHm4PFBGcxohpFSdMFRUJCBmKRNXU7LImP0
         v50A==
X-Gm-Message-State: AOAM532kWOMeiiCzx2KRIXUTeObSRGqU9kKUuiEqBj1MWmnmhjGVcMSA
        bjKwJmV6fXLLwf+hzdwJCsier3/VLQBbtQ==
X-Google-Smtp-Source: ABdhPJwICyehoqqUErohmW0IlGqipUvUlyoH5NvMmgH5QZjGOd6ZZi/w6Horxge4oo39XZalhSzxQg==
X-Received: by 2002:a17:906:7fd3:: with SMTP id r19mr10681184ejs.286.1618380755493;
        Tue, 13 Apr 2021 23:12:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cq26sm11041211edb.60.2021.04.13.23.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:12:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] git-compat-util.h: clarify comment on GCC-specific
 code
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
 <YHVPAGVDjS1EH6L3@coredump.intra.peff.net> <xmqqblahlwqm.fsf@gitster.g>
 <YHZ72NVfEUXZmBoz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YHZ72NVfEUXZmBoz@coredump.intra.peff.net>
Date:   Wed, 14 Apr 2021 08:12:34 +0200
Message-ID: <877dl52y3x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 14 2021, Jeff King wrote:

> On Tue, Apr 13, 2021 at 02:07:13PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> >> + * We restrict this trick to gcc, though, because while we rely on t=
he
>> >> + * presence of C99 variadic macros, this code also relies on the
>> >> + * non-standard behavior of GCC's __VA_ARGS__, allowing error() to
>> >> + * work even if no format specifiers are passed to error().
>>=20
>> The last part of this comment is puzzlling.  Do we ever call error()
>> without any format specifier?  There may be GCC-ism behaviour around
>> the __VA_ARGS__ stuff, but are we relying on that GCC-ism?
>
> I took "format specifier" to mean the "%" code within the format. E.g.:
>
>   error("foo");
>
> has no format specifier, and thus no arguments after the format. But
> every call will have at least the format string itself.
>
> AFAIK, portably using variadic macros means you need there to always be
> at least one argument. Hence "error(fmt, ...)" is wrong (the "..." may
> have no arguments) but "error(...)" is OK (you always have a format
> string). I'm not sure if =C3=86var knows about some other portability got=
cha,
> or if he just didn't realize that this was written in the portable way.

No, I just read elsewhere that GCC had non-standard behavior, and didn't
look carefully at your implementation, but since it explicitly depended
on GNUC etc. understood it to mean it was GCC-specific, not just
C99-specific.

So it can simply be changed to depend on HAVE_VARIADIC_MACROS instead?
