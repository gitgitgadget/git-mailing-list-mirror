Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5843CC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B1761248
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGVHuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:50:40 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B666C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:31:15 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id u7so2892578vst.9
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SNGHoEup/c/SpdWMjjWk1+eGrYt3WqQtU6/vRxdoFp4=;
        b=gMNWOihJi+FZs5FRG+zRtY6GmcKhRPjkTaz+pDPmsnIPOMJtUFGI7NWpGwNTjOzQ1C
         FZriehbdpSkvTlaCeHo75lyksfXxHxGyC06Gn05pJlgjpP6M7DUC+N1OC5nLUUlT4t1O
         bEubXiu855NW0INaZDD9MK3/0HTmSoUNc/tNpOfRpS2GTDqZOdnYPmSBP6nspn4zXPDQ
         giogqqV4JiAsgsUSSfuXXVFYhdq1PUv2KJ4EMagrTS8qiGi2A6AFyx+7YUEQfjcCCT/o
         YRmzaxwa8UGY4UKuzXxOn/Gb2S4iF0hkVuQXiAyq5MrYDuI4F5KmBiGd17A7iR1JxZ/V
         T0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=SNGHoEup/c/SpdWMjjWk1+eGrYt3WqQtU6/vRxdoFp4=;
        b=Yxy//cdy1bugrKOuCPZKMGLzV63Mih3VKQhi+z1uqRJDc3+ruFegDIfrtzffQMc0wv
         ddsoBmz/q8qBN6PCBM2W3e1VoZDJq7yEBqj4zccPxfL5V2WKdyvnegcdApohnVN0VB/+
         M+vWXE9NFsZnT9VLbwlKOojoQ8vMshVxQOYKtzdjNnp73LQ1phTy46heT5XWdb7t4SFr
         czF0KhTI+BAml/hFMpLofok34GENDyD34Cs8CuMOpAMILxP5b9nN4bE+OhS0VVllKTlm
         u9fDONq2AtJgG8g7HBb2nYYz8gDq2lyHfkI7qIcGdyTm9TWVpsLWhlEPqotbLCXmNWnv
         hyug==
X-Gm-Message-State: AOAM533XpXGAQQgXbaiqnN3XBT3LsSFuYYwpM1C4dTCXHlC0TN/nyA4i
        UqB+j/iCmeI9vbjZt66Jr8IqLn9TvZjZS54+M1s29Q==
X-Google-Smtp-Source: ABdhPJzCjmWYMBhHx7a94pDQ5ZzADQGu7BHil5mnoCEsR4ZO0voAOGIjKraciJ9Yv8+8e21Cm3Yth5hTlTMPfylfykg=
X-Received: by 2002:a67:fe57:: with SMTP id m23mr11875739vsr.42.1626942674413;
 Thu, 22 Jul 2021 01:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <f0216ae20b6988514bdb60d8fff96e18c2ce9f1d.1618832277.git.gitgitgadget@gmail.com>
 <xmqqlf9c68iy.fsf@gitster.g> <YH96CcJhZt4CTPWD@camp.crustytoothpaste.net> <CAFQ2z_NAQ02y1gaTymzi21aHxh+bswvr6ko_Eg=1uuHds4mGyg@mail.gmail.com>
In-Reply-To: <CAFQ2z_NAQ02y1gaTymzi21aHxh+bswvr6ko_Eg=1uuHds4mGyg@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 22 Jul 2021 10:31:03 +0200
Message-ID: <CAFQ2z_NmYdckEQ2EfJyhvAYznhq7PdTaMxu+i-BatSkskvC-uw@mail.gmail.com>
Subject: Re: [PATCH v7 04/28] hash.h: provide constants for the hash IDs
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 11:43 AM Han-Wen Nienhuys <hanwen@google.com> wrote=
:
>
> On Wed, Apr 21, 2021 at 3:04 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > > I agree that it makes sense to have symbolic constants defined in
> > > this file.  These are values that fit in the ".format_id" member of
> > > "struct git_hash_algo", and it is preferrable to make sure that the
> > > names align (if I were designing in void, I would have called the
> > > member "algo_id" and made the constants GIT_(SHA1|SHA256)_ALGO_ID).
> > >
> > > Brian?  What's your preference ("I am fine to store HASH_ID in the
> > > '.format_id' member" is perfectly an acceptable answer).
> >
> > I slightly prefer FORMAT_ID because it's consistent (and for that reaso=
n
> > only), but if HASH_ID is more convenient, that's fine; I don't have a
> > strong opinion at all.  Definitely don't reroll the series because of m=
y
> > slight preference.  Either way, I think these are fine things to have a=
s
> > constants, and I appreciate you hoisting the comments here.
>
> Either way is fine for me. I can paint the bikeshed in your favorite colo=
r :)

This is now the first commit of the reftable series.  I think it could
graduate separately.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
