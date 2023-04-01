Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F179C761A6
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 01:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjDAA76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 20:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjDAA74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 20:59:56 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072561D853
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:59:56 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5445009c26bso446414767b3.8
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680310795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeILpiV/CS/YO82xfHJ+1blebrRjB3olMxG8+wpkXpQ=;
        b=bRDdB9/Bou4Kjdpucjxi+KwayM9EHuFS9t9RS6VxTqtwJRBPBNkkYkZ1vSK6M78Xya
         E/ca84coVMzDBxUrmGgOyv+8CzihytkxtcAdw6RPxIvjcv8sXLYpZGXwKZY++qrEBq/G
         1M/QFb+ptZEqmLIR4I3kZj5JNoF/tZ9aRhQj9kXhAHLwvmMwgcqb1icdLK3P1KVyvzNz
         cg5qN3plDMkhQ+9957keT2kkFQ2uOvtXbw2xB5I64TQnnEY+mOZ1F9tc4UxUHrd2xqfC
         7iqTYVetsx2Okhio0sLBb1kJ5a4e75fbiW4JUNg7g/4iZTg4mFwwIYpPY8LWqVc1Sb1e
         87VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680310795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeILpiV/CS/YO82xfHJ+1blebrRjB3olMxG8+wpkXpQ=;
        b=odtvB9PNK36JGlTIsNNKag9rTUE+cEaCqvYqvaXtQSCHENnQ9Go1C/K0wW90q2Cmrs
         C1SMlyGjX6uJ4lfRK4vz8TzXo32EsGZVPsytqUQTTbbd31sJaqyLq+enuC9aI6fp3Tis
         3n/zA2O1NyEfb45yjOM3qTxpgn1DBgUuvfMFqTxPs5/zb8J0LJrACkc/gYC9z/3vQX8G
         ulK83rr+lzQDKrUfVjhCtA8dQxgMcpXpYV+aI1aBuAhqPz7aRAZbuzHGGmcelWe6m9IO
         jXKtc1VjzFoU4HqudJMAcVnJAV05ROklH77eQv7FL5Nq47vrrccLFaoXsfC+uaFhHxMf
         cK5w==
X-Gm-Message-State: AAQBX9fYvcB2Z9B88741o1BrBMBXcFK91+ibpnGFxNKWyteP9296zlcm
        9+sP2Fy130djrihWnxvKfNKK5ZzN5/vV0JuvVbbSGDHN
X-Google-Smtp-Source: AKy350ao8vZ6wjdGyMITBD/ZxcaVP7+Echlf/v5GkDak2lbGT+B+lnkXKelPrN+bpKxlg5kn1Iq69u2kDdejQcqLwHE=
X-Received: by 2002:a81:7e10:0:b0:52f:184a:da09 with SMTP id
 o16-20020a817e10000000b0052f184ada09mr6150708ywn.2.1680310795032; Fri, 31 Mar
 2023 17:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> <xmqqh6u3d119.fsf@gitster.g>
 <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com>
 <xmqqa5zu4ka3.fsf@gitster.g> <CAMP44s3xVL0UHCHh2Ei=STTx=grkpvUTfj6o9roe3tL35GhG4Q@mail.gmail.com>
 <ZCd0+MqwYkKBO1DK@nand.local>
In-Reply-To: <ZCd0+MqwYkKBO1DK@nand.local>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 31 Mar 2023 18:59:43 -0600
Message-ID: <CAMP44s0FMQhRCLnx0eLr-Xz3ajn_+83eCpdJMcda6wovtUHuwQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023 at 6:04=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Mar 30, 2023 at 08:19:08AM -0600, Felipe Contreras wrote:
> > > It is my impression, however, that zsh in its native mode is even
> > > further out and away, pushing it on the other side of the line of
> > > being reasonable to force our develoerps to adjust to.
> >
> > Just because it's your impression doesn't mean it's true.
>
> Sure, but zsh's incompatibility with bash is clear evidence that it is
> further out from the POSIX standard.

No, the POSIX standard is not whatever bash does; bash does many
things that are not part of POSIX, and it even has a POSIX mode
precisely because it does not follow it to a tee: `bash --posix`.

If `ksh` does something that bash does differently, is that evidence
that `ksh` is further out from the POSIX standard?

This argument does not make sense.

> But I think the argument is missing the point, anyway, which is that it's=
 incompatible with POSIX.

So is bash.

All shells in the world are incompatible with the POSIX standard in
one way or another.

POSIX doesn't say anything about the $COLUMNS variable, and yet bash
sets it (and many other variables). Does that mean bash is
"non-POSIX"?

Of course not; POSIX doesn't say "thou shall not set the $COLUMNS
environment variable", so it's OK for bash to do that, it's still
compatible with posix (as long as you use `--posix`).

This's just not how standards work.

> Is it worth adapting our explicitly POSIX-compatible test suite to work
> with a non-POSIX shell? I think not.

All shells are non-POSIX.

--=20
Felipe Contreras
