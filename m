Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3419C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 11:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3AB6134F
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 11:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhFHLMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 07:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhFHLMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 07:12:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428EC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 04:09:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so24042616edc.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CtDvOJZ7N8gH5IPjVoXTwgT7VobqApvqxSHqXDCHf2c=;
        b=kA9zYyqgnzI9TLDZuPGUoaw7jnferFft4M03rS6KB1LFIcv3r3L/1tLnOY22esIRXp
         12tD/+lfiKfTAypYpnkp0cA4XSFcxTw6OUTlAKrReDwpX1I6wYNPOIp8ei1WQlF2/PiA
         sRklKsdAOJ/D+1zH0bSFrHtL6zfRL7i0/2rAnK4OiazvvOYEEu9OCaX2E2/vDmd2AKVK
         OgbhnQerSlDvyfFHOxGR2/Koo45pO6shJ5wqHjoZtfkhV9lTCz2/ju/5wXL11jt1D+qG
         3og8X2m21BlfZ/m84V6lKTB/GJ1QSuUloNX6Ftt5qsMaBZVgQmePfOGMRC86yN9zugYD
         rRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CtDvOJZ7N8gH5IPjVoXTwgT7VobqApvqxSHqXDCHf2c=;
        b=Ilb+ogoTqRvCypN0hb2fVrxyNSWmf96ujktpgccs2lSqPiGYTG9SLrklwuuIV6lY6j
         HSWPLOOPYm3awFiClYiFEO7XFflvaLAnUmc77K0i441MCa7/RZc2SWQLKzv3EJnk+Cew
         W1kisgemsI+FsEgcyStqm2pRq/bQgNsoKgX3XoiWMGDY3lOoOnLwpNV+2sDi63gduZ4T
         MFE9ApDTUIA5weEGbyVv5rniRviQKV0Ecv5m+CQ0EwsqR1rgk1tBwMHMjxve1+fcFBmg
         9TL1fx8G59xFfMmV6tjTRINqqKekRUyNmyGzF0W44npj9ApqYZt5YZYCRaLNV35drDwT
         1LKQ==
X-Gm-Message-State: AOAM530VTst4H/0BkQpT6XxZ41Fr8BrQNwEWAeZhvdcStlz6Pa2UoFFj
        podx+/81E9LrUe1Wl6aFtUM=
X-Google-Smtp-Source: ABdhPJyxAKsqz8eSeuEG8JowHpkr+i97dNvRpxY71wGicLGkXLAA+dljc0A844e4CDhlNWZ3HRQVeg==
X-Received: by 2002:a50:9345:: with SMTP id n5mr6049572eda.289.1623150590606;
        Tue, 08 Jun 2021 04:09:50 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v4sm4307729ejh.86.2021.06.08.04.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:09:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
Date:   Tue, 08 Jun 2021 12:58:42 +0200
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
 <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqczsxtf8g.fsf@gitster.g>
Message-ID: <87wnr4394y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 08 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> So I think this pattern works:
>>>
>>> 	for (i =3D 0; i < nr; i++) {
>>> 		display_progress(p, i);
>>> 		/* work work work */
>>> 	}
>>> 	display_progress(p, nr);
>>>
>>> Alternatively, if the work part doesn't contain continue statements:
>>>
>>> 	for (i =3D 0; i < nr; i++) {
>>> 		/* work work work */
>>> 		display_progress(p, i + 1);
>>> 	}
>>
>> But yes, I agree with the issue in theory, but I think in practice we
>> don't need to worry about these 100% cases.
>
> Hmph, but in practice we do need to worry, don't we?  Otherwise you
> wouldn't have started this thread and Ren=C3=A9 wouldn't have responded.

I started this thread because of:

	for (i =3D 0; i < large_number; i++) {
		if (maybe_branch_here())
			continue;
		/* work work work */
		display_progress(p, i);
	}
	display_progress(p, large_number);

Mainly because it's a special snowflake in how the process.c API is
used, with most other callsites doing:

	for (i =3D 0; i < large_number; i++) {
		display_progress(p, i + 1);
		/* work work work */
	}

Which yes, as Ren=C3=A9 points out *could* hang on 100%, but I think in
practice isn't an issue here, and changing the code per my patch here
solves the practical issue with us always taking the maybe_branch_here()
(or enough that the progress bar hangs).

> I agree with the issue and I think we should count what we have
> finished.

Fair enough, but in the meantime can we take this patch? I think fixing
that (IMO in practice hypothetical issue) is much easier when we
consistently use that "i + 1" pattern above (which we mostly do
already). We can just search-replace "++i" to "i++" and "i + 1" to "i"
and have stop_progress() be what bumps it to 100%.

I have some unsent patches queued on top of this which has some general
fixes to edge cases in the progress.c API making that & more easier...q
