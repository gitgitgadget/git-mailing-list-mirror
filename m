Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7CC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 12:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLGMa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiLGMaX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 07:30:23 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DB4E686
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 04:30:22 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1442977d77dso19965541fac.6
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtTwUXJKoD/00ueo2hB9yuK+P9ZU5hFSO4jtlAxUEzM=;
        b=JcA6I6AvJjXRsDw9grNV1Y+TUwqz1eCLL3RMcFcMiEvFrOTGzTR8yIV8Q0ECZqXgiS
         nk0I89MZ4MNqKmCe/07POU7qERt1QQxb8l2B7oJ0FXTItHploAAqpo9ldwQaV9GOk0YO
         Y5NdCSq3tNtowokIBGqDB6IlLOMQMpTGJ0EsZvK8W0b+i/bXxWdys7jMpXqrE6JNAiGq
         AyF0H35orZvo7qSNC7p1P6soJMQrmWLBz0IhDAy2jw/ELlvGRAT1iD3c4sTYtgNIZJMF
         +fDvgvenkXvcbDNJVkR3MSNMM0aIrKE/H+biPOpaFgUm5iqCVmqCLxbX3Kw0ndpdlhmB
         JblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtTwUXJKoD/00ueo2hB9yuK+P9ZU5hFSO4jtlAxUEzM=;
        b=SnXlwL+G0qp+h+LfqbZ2T6w8QvEmVZ8KqZ0OzJmWCZgRBOVxKFc5xPPIApTYUjGBiJ
         yo49s1uqaMceLGiVEmztB5MxsS0fR92ZRpd+pO2RnVF+M3N7wyz/O32ehtTh0TY78VbN
         ZelFFKPuZIXER87MBV5HAk1exqmLJ5UMkH1tLt/j0VIBObteF1052eSIZf51iOEOcw8s
         DGVaVQXPiNquoVkVESwFeZQtEwPVoIrZ6ssAc1NaTDIzFJh7ThXiFLZq5/Df7Fmuuds2
         RSSE6RrdC8WplFXftyfCwwQGHW1zpvjqpq2VVuh0sPKV7/DPRaWCDmU9OHqkZs83qOVb
         6hvw==
X-Gm-Message-State: ANoB5pkjivBd7ISZgaAiW1GjjJZVZpABEEbJsiToRXTkaYizsknaICKI
        /7uF4GDMyNQ2hR7IZQJuODsabhxhhnP3Tgn+2KE=
X-Google-Smtp-Source: AA0mqf5LNTbLcTXUFQepyB/GdCzg+MQ4gLMUxD8diwsMUC9kMMrTrnPdWlNXZ5J5maB+poDfv938tstYB79Ge9eRTcU=
X-Received: by 2002:a05:6870:f71a:b0:144:e55e:4248 with SMTP id
 ej26-20020a056870f71a00b00144e55e4248mr746024oab.270.1670416221116; Wed, 07
 Dec 2022 04:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20221206103736.53909-1-karthik.188@gmail.com> <20221206103736.53909-3-karthik.188@gmail.com>
 <xmqqedtc842m.fsf@gitster.g> <CAOLa=ZS5k=s98Bo9GE+RRa3jtanehL35y-hhLhy1DoM7GyO0cQ@mail.gmail.com>
 <221207.86h6y7a0l7.gmgdl@evledraar.gmail.com>
In-Reply-To: <221207.86h6y7a0l7.gmgdl@evledraar.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 7 Dec 2022 13:29:55 +0100
Message-ID: <CAOLa=ZTQ9R1dyCb5xp0c5JBLjE33dJFVPg8jQfprU1iSGq+O4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2022 at 12:56 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Dec 07 2022, Karthik Nayak wrote:
>
> > On Wed, Dec 7, 2022 at 1:12 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> > [...]
> >> Also, at the C API level, I suspect that we strongly prefer to pass
> >> around either the "struct object_id *" or "struct tree *", not working
> >> with end-user supplied character strings without any sanity-checking
> >> or parsing.
> >>
> >
> > I must admit, I did take the path of least resistance here. So we final=
ly need
> > to parse the `revision:<pathname>` where the `<pathname>` is generated
> > dynamically as we move through the check-attr stack.
> >
> > My question is, if I generate an `object_id` at the start (in
> > builtin/check-attr.c)
> > with only the `revision`, is there a way to traverse to find the blob
> > for each of
> > the different <pathnames>? I haven't looked at Git code for a while now=
, and
> > I'm not sure what the best way to do this. Maybe I've missed some API w=
hich
> > would make this simple, any help is appreciated.
>
> The get_oid() that you're doing now happens in a loop, and should be
> pulled out of it.
>
> I suggested making that a feature in
> https://lore.kernel.org/git/221207.86lenja0zi.gmgdl@evledraar.gmail.com/;
> but if you keep the interface you've got where you only support a single
> <rev> it would make the most sense to do that get_oid() in the builtin/
> code at the start, and then pass the oid/path pair down.
>
> You'd still need to call read_object_file() or equivalent for each
> <rev>:<path> pair though.

That's exactly my question, now we're calling `get_oid()` with the pathname=
.
Which would directly give us the object_id for the blob. Whereas if we call
`get_oid()` _without_ the pathname, we would still need to get the object_i=
d
for the blob.

My specific question being, how do I, given:

struct object_id oid_1;
get_oid(revision, &oid)

and pathname, get the equivalent of:

struct object_id oid_2;
strbuf_addf(&sb, "%s:%s", revision, path);
get_oid(sb.buf, &oid)

?

Basically, I fail to see how to transform oid_1 to oid_2, using
pathname. I agree
this would eventually be fed into `read_object_file`.

--=20
- Karthik
