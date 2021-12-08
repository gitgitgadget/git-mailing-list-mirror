Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38212C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 10:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhLHKyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 05:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhLHKyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 05:54:00 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C66C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 02:50:29 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id y5so3896618ual.7
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Sz5GGsuwihtZ2DA8AwSa8lxNx998o7SOE4mKFZN6nQ=;
        b=f7rNAkVYhywzREOCbAxL4t3H8o1FCXukaQRi21CuAXC56WIDP3N86TNA/U4UfOJXo0
         PAXUtUYhidsRrgFoaUcrQtijHrlh/bEAixIqzIoq+K8LILB+zQGdo5waO40vODToqe4Q
         r8Syv9f5n7nJN5KVuoNzLjA1d5F6O1MtX6GLR5QAz9F/8y0VMVHehazYtd7KYYIeMR3h
         mj8mMCDecW7kOg6BKsuM1iXJK6T32VN/IwY6tKA7djw2d2hIwcA4cX41d3ThHI2Os/Q7
         +mtzc9nxf+n/igZR45rE2WY7GYfer9xQzern6u9wWjYyi4sRvbMeoz5IU/A/x0NEz9Hh
         RQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Sz5GGsuwihtZ2DA8AwSa8lxNx998o7SOE4mKFZN6nQ=;
        b=ZTiPf//e8ovhXsia4urunszK7mfj2w6q8zysdsnyAroJoe6Q9sdGETuDoNe2RzwaZE
         sUFs57W13Rq8PJ8aPj2QL+5fGniWN7LTuv4F6cVoB0mf2hc6vfljr0W6ttfmzg3ewK3K
         0KBgSM8Ui6SHpJW/ggkCVHYBw9pq96slZPpfIShsbAcKj7PCdu0DJMCflEooIvBhGVhQ
         E1IUi4dqfAB+/9Fb5g1lcPDFc/M6Jl8OEFsYExzaJPRO/JhWoUZ1rsCVPmAVQL73vx0i
         Ice2ai8bTs/prAS1p20D5rTV8/3UzbKcFkAR+gOB6EXTNLUY9quycKMHuok9u/kTQ85c
         SA4w==
X-Gm-Message-State: AOAM531GyG57fHwY/I/CgLrGq1T/2M3whDknajj+08lIl8HliTIr3waI
        +XDUcwSNLcJ0BhkUky5z0YyrN+Xb/rRMZiIurXDRnU4JnLJ5ZQ==
X-Google-Smtp-Source: ABdhPJwtMEhcg6XuhfkjM8zBAgyb4366TEwShiYBWcno8fGupgu+zzBs0tIrhEWJtGob+nAq+4Jer+UXnjUOPI6koK8=
X-Received: by 2002:a9f:21d7:: with SMTP id 81mr7518942uac.39.1638960628096;
 Wed, 08 Dec 2021 02:50:28 -0800 (PST)
MIME-Version: 1.0
References: <YarO3nkrutmWF7nb@coredump.intra.peff.net> <CAFQ2z_OK5949p1WfovJ00Katk5hTv_oeLo-ZRCi1XqrtzQqL2g@mail.gmail.com>
 <CAFQ2z_OrN+RkwnMyrJHdh5xN6ueOP8KKBVQ7-U4kEkA3ApcuNg@mail.gmail.com>
 <YbAOZMxGDELhgfut@coredump.intra.peff.net> <YbAmANn6t9S5qKWA@coredump.intra.peff.net>
In-Reply-To: <YbAmANn6t9S5qKWA@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 8 Dec 2021 11:50:16 +0100
Message-ID: <CAFQ2z_NUCj00981oQiswaYTK6iJ=HuPjNGP46tLL-RGL2xHbEw@mail.gmail.com>
Subject: Re: Fwd: coverity problems in reftable code
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 4:26 AM Jeff King <peff@peff.net> wrote:
> I also applied your coverity fixups to my tree, and pushed up the
> result. As expected, Coverity claims many problems fixed, but also a few
> new ones found.
>
> Summary is below, but I'm not sure it's that useful without the whole
> code flow. The unreachable-code one seems just wrong. We can get there
> via the "goto done" in the BLOCK_TYPE_LOG conditional, it looks like.
>

they're all valid. There is a shadowed variable in the unreachable code one=
.


> The first FORWARD_NULL doesn't look obvious to me from the code. But it
> triggers a segfault running "test-tool reftable". (It didn't immediately
> for me on Linux, but Windows CI shows it, and compiling with ASan on
> Linux does too).

yeah, that must be the problem on windows too. The 3rd test case
passes NULL into memcmp() with a 0 length.

I've folded in your patch and fixed the issues.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
