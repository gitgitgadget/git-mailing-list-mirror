Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF8C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 13:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhLHNIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 08:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhLHNIz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 08:08:55 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350E7C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 05:05:23 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y5so4537955ual.7
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 05:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1u+VglSn0ycpCDbZvi7Z8tGL0EYnMlqsd1fhBhu1rUQ=;
        b=sP60vj5mzFL3ru3JEwfgaUnmXwJAcKbYvBFCUhcXvnFOJ9XpCZlGOCKivURV6jvSdQ
         MTgLwIrghYcYmKseq/VvlNh2uqb0rSL4TZxN/HbK+JxjCnu4AtPxl5/t2v216zbo1OdY
         1PWCAO9jqeK9WLmUzVKTiOF/le6jEnTLT8M48LvRXdk2bCmwdlmpeOw5rEwSmXipmtZ2
         3B3VtVCvMz20S6zwpw3opwJBXnfrbakZ1NrVRQ2bJQoVqN9wFMDhlYPjAcnvExwsX6id
         pnbXJAHeDRxrSZfZNiJA4S/vue53wK+vUKWMris/RUaYjQLFL8P3hdITPtxAqVB6TPNj
         Z3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1u+VglSn0ycpCDbZvi7Z8tGL0EYnMlqsd1fhBhu1rUQ=;
        b=QzYHtwbtZQMQd/7e5JS/DD/ANVvoz2cmswSeM7m91fxs2lLFfaDrHlJGuvr+TvPxJk
         YeaE+uipd4uQ0ZOMYJLyHQEaCi2GfEwtfY5p0PUsOk85wiHrSTt6RxeqMRZCwTAoGpwJ
         pthWzVExrzebtG8i3T8yCNjUJVggC/RYeHs6B7zqV30mLZyRp46bKlkZBsz+aJFjqF/Y
         zWH5tMW38DIQ3RhtbwatZmK6Vg0MPotYykh3BNVvoH5/OzLH8l1sr1BqJdgDrvJTHfxa
         HrT+XXf5LF9RIrXK1otdmQKmmVr9KiFYvYk8xpgft5vaYbQUEytZfoYvssTrWsmrbt64
         rSxA==
X-Gm-Message-State: AOAM533lSfybSqNhDowuwk93llQ1Z3XKmOlfePbS+TW7HwtzkTw+MEOZ
        teKuycVwJwaeBGwsyouZuXrZPQm4VFvfkn7ZDu0TUZNtJFQ=
X-Google-Smtp-Source: ABdhPJzPpUo+oc5KJZ0eySKi6GWfjLd59XUg3jv6NL4UF5ik48i0b0DmH0aEWKnGMNcvjsbkvzK/hEH48SduMdI1RP0=
X-Received: by 2002:a67:cd19:: with SMTP id u25mr19760344vsl.70.1638968722209;
 Wed, 08 Dec 2021 05:05:22 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_NHXKss4LVBAFVpE7LFXt2OeOz9P9wi-z8riwHXWDb28w@mail.gmail.com>
 <211208.86sfv3l0op.gmgdl@evledraar.gmail.com>
In-Reply-To: <211208.86sfv3l0op.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 8 Dec 2021 14:05:10 +0100
Message-ID: <CAFQ2z_MmWywH2AH3YaB+v67e-0jNsH9sz8dgqYenQNM6Gqz_Hw@mail.gmail.com>
Subject: Re: errno oversight
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 1:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> > In refs.c in origin/next and origin/seen, we have the following fragmen=
t:
>
> It's in "master".

Correct, but it's also in seen.

> >                    if (refs_read_raw_ref(refs, refname, oid, &sb_refnam=
e,
> >                                       &read_flags, failure_errno)) {
> >                         *flags |=3D read_flags;
> >                         if (errno)
> >                                 *failure_errno =3D errno;
> >
> > overwriting failure_errno looks like an oversight?
>
> This is from my ef18119dec8 (refs API: add a version of
> refs_resolve_ref_unsafe() with "errno", 2021-10-16).
>
> I don't see the bug here, overwriting *failure_errno is the point of
> that variable. We're keeping the right errno value right after a
> failure, and passing it up to our caller.

The reftable code for refs_read_raw_ref places a sensible value into
its failure_errno argument. Then the "if (errno)" replaces it with
whatever the outcome of the last syscall was. I started the errno work
to get rid of this kind of global state manipulation; am I missing
something?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
