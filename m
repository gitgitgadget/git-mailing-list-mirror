Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ED4C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216BD6108B
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhGLNy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhGLNy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:54:26 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A9C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:51:38 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id m3so12861159ilj.8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e/fAeAjeV7ThSBnqRbVcW9Wb0IpH/QSnM98C3L0C/Cw=;
        b=LbWK4fJlLlMi22YeyShjU0P2CqpfCetJSXjCv6RwVoyqlRv1jzcHun/twGqmc5HjqO
         HaJnwEdDj7eOP7Zi8lZ1wGGOI2gIwPxeOXlNWdcPBosfVfPSTYpQkShGPiWMJbNRvpjO
         46AWE9ZPSpau87Qr5j1LskvJYQ6LMCk87Z+JflGr2bEMxlJFfRJpWm3LiijFz7TKZjyT
         7Aac+JqV4XheSbYBwK5r8YDN49sx7uQ4wdxGR/Sl0jNnlD+ndBFnEacCHo1IHLB9R6wh
         hz1jRbgK+ynxreZpzmd6wyRwX+Eg4Ca5LJnAy+oxeTxQXwyz4MlAYmRQqjYVhkvsWnTK
         XweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e/fAeAjeV7ThSBnqRbVcW9Wb0IpH/QSnM98C3L0C/Cw=;
        b=tooxfogXOB7AAWyfA7RNKtE3AHYqRJJcwxz6QSYcNDwc2Ro/9DnYi2NXwnfaayEzhM
         HTWRmJl20g4a3H2M8Uk8cfqSuEu0IFE4eiDFqhj8RuyOMpXWFx7tuXqWlkFrjTtUJB7K
         iuVyxhcuAxB5Y5N1qnI4ffPEjaun1HsHMM4J4m4yNvtRUEisJpJgK/ew4piNgSJlEWom
         kqKG27/FYZJbWF29/frb3c3HUxo5wU+RUe5LY4TPKR5zVx0JQeG3Rw0wBiE2x49pOiwf
         OHTR0p5HgQpXPXOYEu8r1NMf8HnDSBWvz8sI572ut4d4BJ8txURyNgqT01MWEa/LLDbN
         v6yQ==
X-Gm-Message-State: AOAM533RYn8NwkEQhYdAPy4wF3r3Ptorb6bwQscZl8TSISDrN5ckq2Gc
        nyeqTC037ABrVxtGk3+8opzVJDmOhmBagafaRt8=
X-Google-Smtp-Source: ABdhPJxYQQ4mNw77mE0sj2Cw2EKw5SbPG5TrB7FBa2evsGi9tXoSM1poBTQvcrvuqxRnCgy/VEVu59v+NTXga9RgUrA=
X-Received: by 2002:a92:dd02:: with SMTP id n2mr3094923ilm.259.1626097897696;
 Mon, 12 Jul 2021 06:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
 <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
 <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com> <CAP8UFD1NfCXDVwaVWKvTWofFHbLee=JRzr4sQBecMMaqi0eWBw@mail.gmail.com>
In-Reply-To: <CAP8UFD1NfCXDVwaVWKvTWofFHbLee=JRzr4sQBecMMaqi0eWBw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 12 Jul 2021 21:51:47 +0800
Message-ID: <CAOLTT8QzBQOJahy2_MX_ShwErfxgwfGByfsjdZBy2C=qStCswA@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:26=E5=86=99=E9=81=93=
=EF=BC=9A
>
> >
> > I wonder if the above function and some of the tests below could be
> > introduced in a preparatory patch before this one. It could help check
> > that reusing ref-filter doesn't change the behavior with some atoms
> > that were previously supported or rejected. Of course if some atoms
> > are now failing or are now supported, then it's ok to add new tests
> > for these atoms in this patch.
>
> For example maybe some of the tests could be introduced earlier when
> the reject_atom() function is introduced.

Yeah, move it to "[GSOC] ref-filter: add %(rest) atom"  is better.

Thanks.
--
ZheNing Hu
