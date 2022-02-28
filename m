Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A0DC4332F
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 11:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiB1Lwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiB1Lwe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 06:52:34 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E1593A9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:51:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o23so11134497pgk.13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPUPt+KBQ01851GigLinwvGMm5XpsCSl1+9QeVdm/dk=;
        b=Jj2z/v2X6426f/hsLatC75zFkJl8uQTRnml506f8mKWINwvy39CXfZFpvmIkOffO4u
         gPdr5XHm2c/2LJgq/Mni/48I0PjMz/ayLOk/v/MYHeg2pymi8i0JsouhXBIA7d1NJ1AE
         27/2mom7NZqiY1i6yFngyY6ZjDTTzXMFOaA4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPUPt+KBQ01851GigLinwvGMm5XpsCSl1+9QeVdm/dk=;
        b=4y/unp1TdL/T3U2WSLY5SW9tOmpxnn+JhjsoSBuUxzTC3c03VFCESO3RylC/gh3zJP
         WuuomgAsvYdBkLHilPy5MePf49er+st1F2kRUJ91uIRXbOOEXK5ziwxYYX7a6P8hZkhh
         Arj96GiMb/qK4iOzM/opDbgVVWpBrZUIlfy/mHaQGlAi1acaCa6ISKRMQ5jxmI/Fe36g
         v+/ajQ6iFh8VJAMgd4SEMmX7R8A8oXChc7v/Vai3XXJ+DQNWr0vPu0x0wf+4BjOXzzzz
         8Inpoalgrb7FNY/fHPJfQhEgwrVGBHaCiImGGlCf9MMti7tp/HLoQiJQro6llrg1x5xs
         /r5w==
X-Gm-Message-State: AOAM532hrIFfQRaK2N5cGk0nVnxPQYHN4S6J9uJ1kXRb5ZX3mWvUDqj3
        cU506AuDHvsBoa4844MrPUDULVbQ6d7sahT5MY1V4g==
X-Google-Smtp-Source: ABdhPJy60p6hJ50urNpcUwtwxO7nACFV+rg7AsoTsSI3J2mua7oP5orZICfnNaGfb+GcXjDb63BsNF+9gKijlRZWct4=
X-Received: by 2002:a05:6a00:2346:b0:4f0:fece:1247 with SMTP id
 j6-20020a056a00234600b004f0fece1247mr21211749pfj.29.1646049113048; Mon, 28
 Feb 2022 03:51:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com> <cfa6dca8ef4a64b6233e3b7b6021571447fc5ba9.1645719218.git.gitgitgadget@gmail.com>
 <220225.86tucn8ch4.gmgdl@evledraar.gmail.com>
In-Reply-To: <220225.86tucn8ch4.gmgdl@evledraar.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Mon, 28 Feb 2022 11:51:42 +0000
Message-ID: <CACf-nVd77JCO9tGcO3ELg3975H73_+yuTi2GvR96rpqFh0zS0w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] maintenance: add ability to pass config options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Fri, 25 Feb 2022 at 10:30, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
> Shouldn't this bei using git grep the git_config_push.*parameter()
> functions instead of adding a new custom method to do this.
>
> Perhaps there's some subtle distinction between the two that's important
> here, or perhaps you just didn't know about that API...

I didn't know of it =E2=80=94 it could probably use a docstring too ;-) A f=
ew
other sub-commands seemed to use the `-c key=3Dvalue` approach so it
didn't seem like GIT_CONFIG_PARAMETERS was universal.

Easy enough to swap to, thanks. Assuming we want it, but I'm about to
reply to Junio's email.

Rob :)
