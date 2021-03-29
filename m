Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92108C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5DF6193A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhC2X2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhC2X2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:28:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BCC061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:28:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so16043526eds.7
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tIbic7Z4SWDFKB8cHzz3U76vjSzEqxtnu78pc1hrIVY=;
        b=YQhYssoapLwEKQPigAxpPWSTbvS3acbhcluzZAnrlsrZfxCzJd3dvwEEL7LO1Lz8yF
         dVYe0Vl7M3iDkkoJFG/hXavkIqLmrfmhTned7oN1rAvyJ6CIBE8HtB/j94RPV7ztMUmU
         FhvWHXLymSSY6a08pI62NUZicIMcMwWrhTkAD1apfV272vdsPw9BZ71i+HLxg2BzqP2M
         3RGF25QaxIAddu07LpzTKuSjrA8KNcLCVIDydYJ8TcqVILhrazdsoURM4UR98CWAKqHH
         25+9cOsIR07H87bF7K9vGiqF3PtlMl1H1f0tDCp/LermXuZCK3fYPMLJFBMHzwPaodQ9
         zbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tIbic7Z4SWDFKB8cHzz3U76vjSzEqxtnu78pc1hrIVY=;
        b=jQbwAqRjvPcYgybdFO1fe21BYbBO5ctmvaBUdCYkpCOJCt9o8Ych8f3Th0xy8S2ugU
         bgiKMMAVmXaHp5TjPvXOZ9Sv529zOxbjsuGpiPKi7Z7cpB2CY7sn9HmneRB1tfZ4y88Q
         uoAcZjMaoklcmrZTw1994+lLLx1MYX3hpWygAo5Ug1PVBt77teIbKA75XqRD377jKPOM
         uQtjeQmJa47aTmXTa/cOft6CbgPbPHx/nyDAoKbT88Lp+Nj9LqChADufLEllcdZjhoO3
         kPAf6//yXg7VpeXjOTa+ovEYbb1YHtBL0yiSyPhACFRB/89PQ4KwMsZ35yKp4z7XPCSD
         jiLQ==
X-Gm-Message-State: AOAM533Zapg0Qeer0Q54vWM+zkYjUCAQU1n40UvxYYKaLFUTEQiIkpAA
        rlXTM2blnkiqeMxu946Rj6M=
X-Google-Smtp-Source: ABdhPJyJW/EaM4Ol/oKUMyRfsYUIDDe4wFvg4c7ImK1fO4COD/qZSNwP5qCWyVS+9qaCw9r5Y8k9lA==
X-Received: by 2002:a05:6402:3493:: with SMTP id v19mr31868977edc.355.1617060482805;
        Mon, 29 Mar 2021 16:28:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gb22sm8920155ejc.78.2021.03.29.16.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:28:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/5] Makefile: rename scripts in-place, don't clobber
References: <20210307132001.7485-1-avarab@gmail.com>
 <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <patch-2.6-49dbd54d0ff-20210329T161723Z-avarab@gmail.com>
 <xmqqk0ppkdmd.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqk0ppkdmd.fsf@gitster.g>
Date:   Tue, 30 Mar 2021 01:28:01 +0200
Message-ID: <87czvhmtfi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 29 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> It'll also guard against any weird issues with e.g. a command that
>> wants to read GIT-PERL-DEFINES to generate one of the %.perl scripts
>> racing with either a concurrent instance of "make" that has partially
>> updated the file, or test-lib.sh dying with some particularly weird
>> error because GIT-BUILD-OPTIONS was partway through being updated when
>> it ran.
>
> If something like that happens, doesn't that indicate a bug in the
> dependency graph in the Makefile or the implementation of "make"?
> The generated file is depended on for the consumer to be able to use
> a non-stale version---so the consumer should not start before the
> generator finishes.

If everything we were building in the Makefile would be invoked via
other Makefile rules, yes. But if I run say (cd t && ./t0000-basic.sh)
I'm having test-lib.sh pick up one of those (possibly partial) files,
this guarantees they'll all be atomically updated.

> You may be able to hide the breakage coming from "partially written
> file is easily recognizable and the consumer would barf".  But I am
> afraid that you are introducing a problem harder to diagnose, i.e.
> "the consumer reads from a complete file so there is no syntax error
> or other things that easily tells you there is a breakage, but what
> is used is stale and not up to date".
>
> The same comment applies to this step.  I do not think it would
> break (other than adding intermediate crufts) the result if you
> generate into temporary and rename to final, but it is not clear
> to me what the point is in doing so.

I just think it makes sense to do this for consistency. So on "master"
we've got 65 hits for $@+ in the Makefile, at the end of this saga we've
got 100.

I think being consistent across the board makes things easier to read,
and in combination with the later ".DELETE_ON_ERROR" we can also drop
other copy/paste cruft.
