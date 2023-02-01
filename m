Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B837BC636CD
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 12:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjBAMsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBAMsb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 07:48:31 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C04480
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 04:48:30 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t9so7920869qkm.2
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 04:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvBlcM1jLRCbdawNf9e0KBSyHBNkh6NRSQtXf04AnVY=;
        b=bhNxwxB65Wqgr8xQebJnI6Ckb4Oqh6lYPZ99FMIA/xj7V6+gMtUuMF5PqcPBmIRMBe
         t98tRxEJm018OMBDRswQoTN6Txt8jLclglkWTCBi3ffgGbDiwXjkHWkM8SexHYxRjbQY
         vGYzZXNWos274A9y1PQf1n3sBMeJBT8E1yPphLmsC7qxcBwBlmu0af0V42c8fVGRr6wP
         m3kKjiYy2ylLUMx0MZ94/38L7o9+huZHjG32eiWPZLCvhGfj3iWlsRWkBOR+UH3MxOv6
         SiOCplxqM0sYtD5JzIx5g5oVQTGq/H3gEvX0SciCPxbkQhNjQ8NnbaA4dWUYaYlBU7jy
         OrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvBlcM1jLRCbdawNf9e0KBSyHBNkh6NRSQtXf04AnVY=;
        b=FkbD9YRKqdc1tWBpddhuSqM3U0ux+sURvUkdLuV5/yV5YnWpJNwv4/UmzLlemy1iuQ
         WH4w3Lz5kWXEPPMpJxtLWV3+57NSr8XiWXeWrRv83BSX801A1J9sVsYaI+/53iV04piw
         DNMIStJ15vJT9lnPwqPNHEZdT9pFpbfJvOB87CKsKdRV7rZaBGlkXXpMQWd/SwQIHFlT
         yGfUG7Dx+J5ApFKL7FhOgTIvUGcNfFHOHAUaFSwgRfaZXDWYNoQ1D6b7vLvX29VPrpyY
         gPwbVzJZu+zeOQRJT+vAuGEy1ZviFm9Rj2XDDnFhfENhxwWkiMlcSw2NKQE9UQuTTuIX
         4wkg==
X-Gm-Message-State: AO0yUKW5uocU77KNDmCP5UY8JYWLJken/WanoOCxqJiqLbCox0l/bmsq
        GSyAd3O24z8GooRXOTMx2DUS80yhP1CHYcjIBCo=
X-Google-Smtp-Source: AK7set8CuQ1co2Yn/TCvFDOaeFJED1kRBQHconXYi+IoHNPj2A3gcRKtKXSC8qGUF+nqBRvxqosyiHfU4Cq8TSaRLD0=
X-Received: by 2002:a37:c85:0:b0:71a:6288:9ea7 with SMTP id
 127-20020a370c85000000b0071a62889ea7mr212931qkm.221.1675255708608; Wed, 01
 Feb 2023 04:48:28 -0800 (PST)
MIME-Version: 1.0
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net> <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net> <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com> <20230201122152.GJ19419@kitsune.suse.cz>
In-Reply-To: <20230201122152.GJ19419@kitsune.suse.cz>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 1 Feb 2023 13:48:17 +0100
Message-ID: <CANgJU+VLseURimM++38WA81uFPbnoHiToOt4F4UFL9yVbQpBEw@mail.gmail.com>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and a
 possible solution
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Feb 2023, 20:21 Michal Such=C3=A1nek, <msuchanek@suse.de> wrote:
>
> On Wed, Feb 01, 2023 at 12:34:06PM +0100, demerphq wrote:
> > Why does it have to be gzip? It is not that hard to come up with a

> historical reasons?

Currently git doesn't advertise that archive creation is stable
right[1]? So I wrote that with the assumption that this new
compression would only be used when making a new archive with a
hypothetical new '--stable' option. So historical reasons don't come
up. Or was there some other form of history that you meant?

I'm just trying to point out here that stable compression is doable
and doesn't need to be as complex as specifying a stable gzip format.
I am not even saying git should just do this, just that it /could/ if
it decided that stability was important, and that doing so wouldn't
involve the complexity that Avar was implying would be needed.  Simple
compression like LZ variants are pretty straightforward to implement,
achieve pretty good compression and can run pretty fast.

Yves
[1] if it did the issue kicking off this thread would not have
happened as there would be a test that would have noticed the change.
