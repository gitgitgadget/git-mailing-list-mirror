Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74933C433E6
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 22:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3233721D94
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 22:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgL2Wmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 17:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL2Wmw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 17:42:52 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96059C061574
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 14:42:12 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id u7so7761417vsg.11
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y1xb5t/3aIREJXcpOxUbSCd/KX7T1Ijw9LpcTHhCTqY=;
        b=OFs4ckUxjbV3T5crxoJXEqr2EUJ0xGtRmUo5wER45NHiXEdRuRB+ZW/GXYAO2rI9wF
         eITWFp6CVNuwjNYW2ltXf5iy55VbnXtmmhk/BzBIkJ5y6gfoPe+k6/L6AiiR8drTv4o5
         ynDmjGboORf5wDNNcp1aYM8Ns1/KZCADPzHVEajPxHbNIgR/28chJUxRCYYFL+hyXb/R
         RKlLcxQGK+H5o2kSpA8w/CxUp3lQaxmcSGVdNA/9VG2ObpxoI9+0J8ju8TcbTtz9wiN3
         Dh4Yu7THk1HsOeOfGVl9c51Y60qBHbFn9WgxDfDSjqD1Icog5r+eZfGeBS0BKAhXBR1b
         JI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y1xb5t/3aIREJXcpOxUbSCd/KX7T1Ijw9LpcTHhCTqY=;
        b=D8AbI8a2OBIW1YcxGV21gTwIiY1kV/bv7ItV257Gh7OIhfH5HSz9oTg8TJ7SsmiyS9
         TYQxQyFQP6sF5cKBKNNMr5uXAntcCxJNwtN7qAjLwaEJur0Qs7TyFbh9OFoo+Ss6Mbvc
         K3mUbmydCcqWswy2Xqcvt11lypaiqaqqyF8Vai7qw+XhBECrnB3QGaFoW5q+rqKHhOpX
         4PU3js7QqyEq+y7LtOvFcbMhCzIgMz/fj+3yYyNFSj23klDdCzQq1nL5LkgeGItocEN8
         Za0Qafbw5OjOAnolvwMlP9LUXwM/TyGag8OsKhf5wxdE+r0+An2wT4hSDmz5kzczpCin
         9BIw==
X-Gm-Message-State: AOAM530ikpQkKBW05NbStx6YJ6EOhjn+d6c7ADawXQO5OWsVsywwfwEL
        LqXfnbB0eRP60Hy8bT6DOhb+LLmXBfst59tm3RfjhEdxuwA=
X-Google-Smtp-Source: ABdhPJy8534yU1yjyXnEXsN6b5eXBRyyl3F2+GyouXsfmzN85OAG8SIOcAOPf11Fp18/Lv+dNF+f/RxbDKibQhofqXg=
X-Received: by 2002:a67:2d84:: with SMTP id t126mr30523131vst.49.1609281731762;
 Tue, 29 Dec 2020 14:42:11 -0800 (PST)
MIME-Version: 1.0
References: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com>
 <cover.1608537234.git.martin.agren@gmail.com> <42c6206b102cd97290fd9ad207bb39b20660064c.1608537234.git.martin.agren@gmail.com>
 <xmqqft3yltxo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft3yltxo.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 29 Dec 2020 23:41:58 +0100
Message-ID: <CAN0heSrEPt3=-uccGk2fKu=ScbE1Bq-cpsvisBcsoXdUC2sz5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pack-format.txt: define "varint" format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ross Light <ross@zombiezen.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 21 Dec 2020 at 22:40, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > We define our varint format pretty much on the fly as we describe a pac=
k
> > file entry. In preparation for referring to it in more places in this
> > document, define "varint" and refer to it.

> We need to be careful when using a generic "varint" to mean the
> older variant as it would confuse readers of OFS_DELTA section.
>
>         ... goes and looks ...
>
> The phrase "offset encoding" is used in the document to talk about
> OFS_DELTA offset.  It is actually what the rest of the code thinks
> is the canonical varint defined in varint.[ch]).
>
> A way to avoid confusion would be to refrain from using "varint" as
> the primary way to describe this size field; instead explain it as
> the "size encoding", to match "offset encoding" used for OFS_DELTA.

Thank you very much for these comments. I will post a v2 soon, which
will do exactly this: avoid "varint" in favor of "size encoding".

> It may also help if we added to the description of "offset encoding"
> that it is what other parts of the system consider the canonical
> "varint" encoding.

I will leave this as #leftoverbits, though. I'll "only" fix the omission
reported by Ross.

Martin
