Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB84C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhK2WwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhK2Wuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:50:40 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34386C12A4E0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:29:30 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id b192so11776579vkf.3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZHD04RfGuvQi5myjHt1WNpY7mRIP8qGZDU9pNCBp+4Q=;
        b=CezOtGNl75a/oJfAiT0KzCsCJFx+qPqd49JfFMqAZ4dDKKS5VXuRqsbzQKkac0K1Cj
         R1E+2yqPIqNbiYFgPbeyocHbXbbgx0PTX8d8yqrulBl2dIkSFcmExLGQS5UFz2PB5wk0
         IizBC/LeIiTz93gQzQKzhIMLHdwWLkJAKtIUB/yAcSv0ffxY5ThZCZXnoEN6fQZXExTR
         uUoMeGEbQ7TTmo2qnoNQ72QXb9ArIrr6FN3rDGyATwTg6Lne7KB7sB+I1qGQA4pNebxH
         ydYYtm0xXolj8UcbqREcSVoo+fGmnx7KKgt7+T9n7tOQslHTGD3mOPfspNDC8Kxc2Iz6
         F5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZHD04RfGuvQi5myjHt1WNpY7mRIP8qGZDU9pNCBp+4Q=;
        b=R2BTLWk4LpEAkdOMOTpa0Gp60qLYUO0irs7dZSd/lsbzBlkWYMI53U6cv0+RlyaIgT
         047wWfitT7XVGfwy3mqz+k+3lH+YEXPqt6M30ivQaH+Sn/NAJTnUaois1hCVRA/FXkMI
         SWbGjH54XvJ4TJUvIf3nTVb0yhrUi6ZtgWdne0Sf6rUZgdBFFZjA7hXsM8kkkM6JTUIR
         zRW03ZSRdpzytjRJwETGr+VhViR6ytsveCyAEN/dOHCxe26hHf84fgrYfTJh6MmUtLPV
         p/IWGGjYDFlB0kkAwl7ytUOYgJH6RHZwPYBIrfeiYDKM0ba27PGg4bdci1z6MLPub7RL
         dUfw==
X-Gm-Message-State: AOAM532lR+u0J2gQQBZ+qLazmcLCknIf7vpwfiBwe4brFMse2k93qvPz
        ADHIz7bdzCqPpPtu+Hp4lrhw7oBhvLnoaP1U8pL7bg==
X-Google-Smtp-Source: ABdhPJz+ljZklk7HGGcmwei3jRX9gVK23F9LTNi3OLf46RXgd552q9HNcMQfSvFSVgqU/G0sbBJ200AdSbeSW0mrZQw=
X-Received: by 2002:a1f:a3ca:: with SMTP id m193mr38214068vke.4.1638210568909;
 Mon, 29 Nov 2021 10:29:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com> <0288e743eb2e96e2effd6b0b90c6f885009bf337.1637855872.git.gitgitgadget@gmail.com>
 <xmqqilwf72nf.fsf@gitster.g>
In-Reply-To: <xmqqilwf72nf.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 29 Nov 2021 19:29:18 +0100
Message-ID: <CAFQ2z_N20ESyzkPLdGbS9q8HEHGB7_gmaX8FUBR=jGqXLGcL1Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] refs/debug: trim trailing LF from reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 26, 2021 at 9:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The API promises to have only LF, not CRLF, at the end, so
> strbuf_trim_trailing_newline() is a bit overkill (and if payload
> happened to end with CR, we would lose it).

it would be best if there was a way to escape characters (ie. "\n" =3D>
"\\n"). Do we have a function for that?

> > +     trace_printf_key(&trace_refs,
> > +                      "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"=
\n",
> > +                      dbg->refname, ret, o, n, committer,
> > +                      (long int)timestamp, trimmed.buf);
> > +     strbuf_release(&trimmed);
> >       return ret;
> >  }
>
> Can we use counted bytes in trace_printf()?  If we can, it would be
> simpler to just scan "msg" for LF and then show only the span
> between the beginning of the string and the found LF using "%.*s",
> perhaps like this?

I beg to differ - despite this being fewer lines of code, I think
pointer arithmetic is best avoided if possible.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
