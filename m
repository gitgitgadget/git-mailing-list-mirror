Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE4C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 05:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A90611AC
	for <git@archiver.kernel.org>; Thu,  6 May 2021 05:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhEFFEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhEFFEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 01:04:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CFFC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 22:03:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t4so6393463ejo.0
        for <git@vger.kernel.org>; Wed, 05 May 2021 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ynt8I1gbVlKb5qW3bxl1shs41U/ltQcNZ2/6/aQkNr0=;
        b=K50nmz2v0hLbO4Fqc2zqmY6dby0lSDUfOFWaR3bLXkc78mv5st3qr1zRjcpeY6JxmG
         NVL5Erlh/SWlGOhuC6rGlHSgKnJTFjngVbLHfjz4md4Y0Ro2IDidDBb6nvHAiXB5ArBT
         LgCWeY3LYv7h2ox0qR3248Ghi6LSzZXeRfmEvYG9CnqPSj7IfyY2JRuw3/mE3PV6nrme
         lkv4x6ZCaP0Hc2zjcwEuZiOwVEKZHi/wcgkJ9sqnht+B9PFmskcAaZ2o4yuAxPUt+bYV
         /lMvXx0SBuKctenv/1SRgYpNGNkoCFIRbGRZimtSXcNIhI7IKF1nGmMgOTElucE0G9kR
         3wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ynt8I1gbVlKb5qW3bxl1shs41U/ltQcNZ2/6/aQkNr0=;
        b=QSQH4TefAhEwVd+/9EF203oT0J7LRr3B6x3VvU7YhC807x7P845dFeC5CucLB6wk+N
         bziJ6C99S2dSd9qhvVnYmt/3L1JFRwXSsKwDm0j5jX8A1m+wzVra2Fo0N2NGXYwff+9W
         PweWZSXf13URlTGi2reGqTB+71vNbFchLpHTgpOr7dyDJbZhHGrtSg5xW/DGxX/xG0B0
         X5yJpgH+CSTAm7nEXc1UlhS3lczmCpAwmLzvHKk7ICADSvxJc8jmFGwWgQiIJAakhgET
         ItYGYAgtOjZoumf5uOhLsARl7gLVx/uX8Umjhio5uLPKATH/usElhFJ968ULMKt1IjiU
         WYjw==
X-Gm-Message-State: AOAM531RapBmn1/Igx+LgMeNzDPe4y6hKjI7lDb/I/7p44YiWe6nyF5Z
        CUa2P2iMFMueiV16YR8n0VO8NkBsNH8l8sNeSeg=
X-Google-Smtp-Source: ABdhPJwsW5ALLvd84EJNsOmLWnen3kBmkY4d4NdbXgvhiMBEqrHS0IkAI/Bskx8n+yKobqGROM7srfz9KhwvJJ8B+R4=
X-Received: by 2002:a17:906:e28c:: with SMTP id gg12mr2303827ejb.483.1620277385400;
 Wed, 05 May 2021 22:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com> <xmqqfsz01vc2.fsf@gitster.g>
In-Reply-To: <xmqqfsz01vc2.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 6 May 2021 13:02:51 +0800
Message-ID: <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=889:53=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Johannes Schindelin seems to have introduced a bug in
> > cc72385f(for-each-ref: let upstream/push optionally
> > report the remote name), it use `atom->u.remote_ref.option`
> > which is a member of enumeration in the judgment statement.
>
> Sorry but I am not sure if our readers would understand what "a
> member of enumeration in the judgment statement" is (I certainly do
> not), and even more importantly, "bugs caused by enumeration" on the
> title does not hint much about what problem the patch is trying to
> solve.
>
> > When we use other members in the enumeration `used_atom.u`,
> > and it happened to fill in `remote_ref.push`, this judgment
> > may still be established and produces errors. So replace the
> > judgment statement with `starts_with(name, "push")` to fix
> > the error.
>
> And this paragraph does not enlighten all that much, unfortunately.
>
> Is it that a check refers to one member of a union without making
> sure that member is the one in effect in the union?  I am most
> puzzled by the mention of "enumeration" when there does not appear
> to be any enum involved.
>

Sorry, I didn't make it clear. I re-describe the problem first, and then
modify the commit messages.

Suppose we are dealing with "%(notes)", the name member of our
`used_atom` item at this time is "notes", and its member union `u` uses
a `struct notes_option`, we fill some values in `used_atom.u.notes_option`,

When we traverse in `used_atom` array in `populate_value()` and previous
judgement like "if (starts_with(name, "refname"))" will failed, because we
are dealing with atom "notes", but in judgement "else if
(atom->u.remote_ref.push)",
The value we fill in `used_atom.u.notes_option` just makes
`used_atom.u.remote_ref.push` non-zero. This leads us into the wrong case.

Is this clearer?

Thanks.
--
ZheNing Hu
