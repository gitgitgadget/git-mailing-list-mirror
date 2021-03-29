Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B27C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5CC61990
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhC2Xbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhC2Xbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:31:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36395C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:31:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so21960373ejc.10
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=IukwHYztEwM16BrR5DJy8KcsrURI+OxLJIZ1AInSu9Q=;
        b=CR2wykobEqzuet6fMrx9LfWl30b+6eMri8rylUYs+ivLzvU9BOhOOBj1/gGUDCpPRl
         GnGodbaSUpbQIwG3RCoZcWM2GGZ/XjoviGFTvUfkGUR8Oor2l6/i0qoCTOnUMDKWtpuh
         jiZTbngx/sZLA8hXay14aley5T53CQ7b9Ku653foN43/NsV7OD8sjkyDigjWoiGnQ8tp
         2GDoVT4W77rwdC9igS1chMukXszYv2pt1wkV+J8u5V/UaIPeRaVVs/jGtMYJ+V4V0BzY
         qGBMEVzZhjXy2hwFXiMkkj0tf9XNhtW1Ciy5mtJz9YqLcshO4got79VYGkUf6IVKQktg
         vgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=IukwHYztEwM16BrR5DJy8KcsrURI+OxLJIZ1AInSu9Q=;
        b=WHpWE0chk19yz2sq8Hm8c0hq4aYBOzbHq6oQELjG7vUzyDkl4lHXYVS3AkjLAp8l/R
         BH5TwhZjoefPJnAbCVeLbtecu23AO5bArVM6cuncBC3cZ5xd6K67ZgtOWysEoCCMbqf5
         P1o8rmiQELQgwy+aB+WZkpQKJDmd2h+cF3y7sbi/cMkLnAEoAohSeXGNQjh4ULUE0cNO
         NbFGD8DNXz896SpDHalRKECsEmJ5MDL5w3EeMlHW+D1G3eSZKL75gS7mv0o9BNSXRhQU
         nXarTtsNi7ZbFNbwuUaUFqeKQ/++AVeblMTgeAVLbHMMXzSUJte8fedAVXZdbPPqoo/1
         oUPg==
X-Gm-Message-State: AOAM532wJAAs6rzhRF9ebGuRrcYR9zOjVXMSEhdDMS/8RlFF05lKIvZh
        349BT+ES6vvugJhVidfhnvU=
X-Google-Smtp-Source: ABdhPJwpmeHi033pkjzS1i2QxlabBxIFZLoN5Z0b4H6SD5rLPpSjc0lVQ2mSOeE3Edww2R2mLrfPrQ==
X-Received: by 2002:a17:907:766f:: with SMTP id kk15mr31228213ejc.24.1617060701950;
        Mon, 29 Mar 2021 16:31:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e16sm6924267edu.94.2021.03.29.16.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:31:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
References: <20210307132001.7485-1-avarab@gmail.com>
 <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
 <xmqqblb1kd47.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqblb1kd47.fsf@gitster.g>
Date:   Tue, 30 Mar 2021 01:31:40 +0200
Message-ID: <87a6qlmt9f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 29 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Use the GNU make ".DELETE_ON_ERROR" flag.
>
> Yay!
>
> With versions of $(MAKE) where this feature is available, it is far
> more preferrable to use it than "generate into temporary and rename
> to the final" dance.
>
> We do require / depend on GNU but I do not offhand know if this is
> available in all versions that still matter.  If we know we can
> assume the presence of this feature the I do not mind if we jump
> directly to this step without those "do the same for $(CC)" steps
> (which I deem crazy) before it.

Even if it's not available in all versions that's OK. You just won't get
the nicer removal behavior on on error on such a jurassic gmake, but
you'll probably have way bigger issues with your late-90s-era software.

It's not a syntax error on a gmake or other make that doesn't know about
it either, i.e. you can also add a target like:

    .THIS_DOES_NOT_EXIST_AS_A_GMAKE_FEATURE:

And gmake willl happily ignore it.
