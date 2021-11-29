Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FAFC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 21:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhK2VPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhK2VNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 16:13:44 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A549AC0E499F
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:24:42 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a14so36105609uak.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nCxvgk6O70z5LWyWdAsQtpMgkv+4ixFFOPISCCkMMoA=;
        b=qWBdQZb4ULVOdSHztJRoLzSHZWmGCjRmAN7YDn+H27Wv0d7GmAF/Axl6rrD0FRioII
         jmxD8uddn8DWkhwMd6wyGkONtYaMGhJJFOY6tLw9ggyzdBJK/Q58c3/StdTjABl9joHa
         3lJTvsNBKD45Ih4Syq+Uw4OiI6edjHIgQvuxG1sjCZxqydOBq2esUSsIg93lHwNnjvBf
         UQkT5VGRhBAMgvg47inh4JpgOcH4W6FoBU4Cewkm3p0jY/4qXajgy7LAUhv54U+mi0br
         Yti2gv8vHJQX6HH1tilnx78cH4bEgXLtTWip7gsveJwzXFjN76WhBNyJbLgt+du0LZ63
         hlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nCxvgk6O70z5LWyWdAsQtpMgkv+4ixFFOPISCCkMMoA=;
        b=NCHgQGNR75RMP7u3RXu7NkFq8N6RFo6rgg4J5bytZ0/7ENF/znmev82hYHIT4VIW16
         rgwtxIveZJfGJdTJ5V1hoeHImgS9pmWWPWkdG9Zx0hKEiMtfugMJotSbUz3NrGeASxtr
         KdxKQjQWLFUwzVd75AfZvqtZEJdgZ+u0XLGje8guIyQ02pIQi9VcKdhpa1FlxYTFcima
         VA965tXhY71o7miampqC+RP/M0FvwsQxjxcmb6Nbh0SZjnmF43RTXxTUHS1fPp/msFqU
         F8FIuXWvrFtpqQWhQHeeMlgICEbdSgo15iwzcKTv42QeixlJNW4PI9Y3t5BqCADX/VJZ
         2fvg==
X-Gm-Message-State: AOAM530+01/+Tqz6lguptSCtiPeS6B02PwB75V9VlD5oSiavk8mzmQCu
        dF4UNFR5Bm1FjGpxAOVa9gvC7Ygd5aG8wuwJF79RKw==
X-Google-Smtp-Source: ABdhPJxNvKXp6nGClvjqbKyoOeXsWKVBt5HReWWEBMPKPXgLDod76Xvn9jysJRlQljlSMd7qHU6n2nsQrrhR6hxvSzo=
X-Received: by 2002:a05:6102:dcb:: with SMTP id e11mr35943537vst.8.1638210281628;
 Mon, 29 Nov 2021 10:24:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com> <211129.86czmjgtfd.gmgdl@evledraar.gmail.com>
In-Reply-To: <211129.86czmjgtfd.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 29 Nov 2021 19:24:28 +0100
Message-ID: <CAFQ2z_OioNmOP+_VvP71DTDqkaVLZg01yx5QVNo+mVGXxsUJ9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Inspect reflog data programmatically in more tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 11:14 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > This helps for reftable support, and will help if we want to reconsider
> > under which conditions reflogs get created/updated.
>
> Having looked at this in a bit more detail than last time
> (https://lore.kernel.org/git/211123.864k83w3y4.gmgdl@evledraar.gmail.com/=
)
> I applaud the goals, but to be blunt the specific approach just seems a
> bit backwards to me.
>
> As noted in that message I have patches to tweak the "verbose" mode to
> be backend-independent, which as we see from your series is one thing in
> the files backend that consumes the "message" and assumes things about
> newlines.

In v2, I went with Jun's suggestion, and left the newlines alone, just
trimming them in refs/debug.c .  I think that makes most of your mail
irrelevant?

> Perhaps reftable is capable of just handing the underlying code pointers
> into the mmap()'d file, so we could even skip all (re)allocations? Or if
> not, that certainly seems like a sensible thing to anticipate in a
> backend-independent interface. We could do that in the file backend if
> we were a bit smarter and used mmap() instead of the
> fopen()/read-in-a-loop pattern.

It sounds like premature optimization. Reading reflogs is not usually
a performance sensitive operation. Also, if you hand out mmap'd
pointers, how would the reftable storage code know when it is safe to
close and munmap the file?

>
> Just my 0.02, if you're interested in running with the below assume my
> SOB.

What is SOB in this context?



--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
