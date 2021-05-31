Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2BAC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223B5613C1
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhEaOQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 10:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbhEaOO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 10:14:28 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B1C034609
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:41:09 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x22so6028659vsn.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R5Cxx1OunpnWVZwcOHTLg4ZHSBB126VJYgwADg2v60c=;
        b=jdaY5n17/UmKkEncs8ZJ3tHwXs0TKkvAKzgf72JbP11FZree319QSTVxFiKeOqdV8D
         iM7MZeGsDtD/MdXeom9XKuAbiVrNcJCG6V+AlSFHvEPfTHsjkFeGyWLDlddm6mLkTk3r
         eZ24Wy0owTBb2e5D1yUDFKQImSEpRzfMm8Qivg0OYwDKy4v9jAM30zirOCvSnrYXQ0FA
         rw/p8AVqqfgnWkzJQ8ijBNxiypaQp6UjckeSqb6wZqw1QGYpRhBWV7fr3MupV3NkqOCY
         37IK1CuyVoHMyZgpvAAHctSYHnz+CJBJMyuZktuFDBSbnhLfM835ODRu7BJ/RrzLoi0H
         YcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R5Cxx1OunpnWVZwcOHTLg4ZHSBB126VJYgwADg2v60c=;
        b=dZzgh+5d/hNgbGDWBecQ5+Gm5Z4BKXgM597Fn9W904jALTt/0kofvh/Bc+60hdWQfJ
         tD/u5an8mE1Z+IlH0BcbnkHX1o/oDTz1ykNZoWPytnnfaIi7T4YjnnTWX0gN5YaruCTm
         eQXN/bAEBlo0Cp9zzshT1/vk3eDWwdeElAphg+pDzTEnY/vEqLw7xYzI7ZZYqB3Gb9C5
         /v/YdyJXN2iivOnmsFUSKAwk78W9MeQgxn6ANfwzQH5UDoOZc7zw+K50Uk8G1Q/Ws5s5
         oZoKTVGayTWIUW0gm2Dyn2tXSzC4bGvBWDhBiDmeeJBMiOxo7lOrPQgRY8H13ptXAXK7
         T+Zw==
X-Gm-Message-State: AOAM5305soolCKV17NDsOVp7SOZApSsGFvju+og2R4SX8iiNhJtsh03s
        N1E9Iq3NIJQWCnsbEWRNc3ZmhTyhmJq64paH0MyAgg==
X-Google-Smtp-Source: ABdhPJwtVw7VWNY2WgnyvC4IXx/ITcTOANO1g0UeWN5EYBwYz48YvZk8X5yuxy+NG7wimGVDfHDyxOa9vg9ltku7sY4=
X-Received: by 2002:a67:ec99:: with SMTP id h25mr14383936vsp.5.1622468468026;
 Mon, 31 May 2021 06:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <248d9ffe79272c7a6efef64512d72ccb9a91349a.1619519903.git.gitgitgadget@gmail.com>
 <871ra1qvli.fsf@evledraar.gmail.com>
In-Reply-To: <871ra1qvli.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 15:40:57 +0200
Message-ID: <CAFQ2z_NFeYf=3=LXwoKjDPh0Lop3GB0OEmqWwOaqJMQA4JGhEg@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] t1401-symbolic-ref: avoid direct filesystem access
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> But since we're encountering this "reset_to_sane" pattern, can't we just
> as easily fix it up with something more obvious than replacing an echo
> to a specific ref with a tarring up and untarring of the whole .git each
> time?
>
> I.e. something like:
>
>    # setup the .git initially
>
> Then:
>
>    test_when_finished "rm -rf copy" &&
>    git clone . copy &&
>    # munge the repo and use "git -C copy" for the tests"

I think this is actually worse than tarring up the tree. By using
clone, your initial state will be affected by any behavior that
git-clone does that makes sense when the user is a human. For example,
refs/heads/x is renamed to refs/remotes/origin/x. Also, all the
timestamps will be off, which might be a problem if there is
infrastructure (index refreshes?) that uses timestamps. By contrast,
using tar (re)creates a precise snapshot of the initial state.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
