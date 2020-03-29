Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496FFC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD672073B
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCijbXrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgC2Of7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:35:59 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38257 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgC2Of6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 10:35:58 -0400
Received: by mail-yb1-f194.google.com with SMTP id 204so7523356ybw.5
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m5GiN8+AfwbpW6EyfdoyVaa6e5RWhw7ZcYqe+K/55nc=;
        b=BCijbXrIUDn3M2mSr7IsrLHSzXW5U4czfphmufDvD/eNV53xsm+c0JxjUn1gn/GNJB
         t8+53ET5Xvi1iw7AMBkBImi26Row7Dq/AWQ0A6q18K3jo1IdsQjIKsUHYd50gZfBixma
         CMV1QlWl53aoUjmdWK3R3cE/SkiOvokLiveFQ8hdMEKLS45lYkzmDQQZulDIkqh4RU36
         bjXh2KpdWPvg5eMcvI5MuN3G6FQMoLEdzRUqrweRHYP4uzStvzJqxgdcJ/SLgOI7ySl/
         Dtkd9NZG2hnPPi5yoBF1u2QUKcIJHKCQerL9i8kDgkexQvCOa0UDQftVlfkwpRMmXZ4K
         NtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m5GiN8+AfwbpW6EyfdoyVaa6e5RWhw7ZcYqe+K/55nc=;
        b=ECJmB+cF8AepRTFJllJg5MoRyV8+RKQeCnbxAN/baqr7+gmxuNj/kHyJ1RifrPyoiP
         06lBBmKTazcer3rVk+GP5dABDkSzpAkARtYqPbOt8/QJRhUOU4eoohhD9v9vu+TAJ6z3
         BkVcIYyK8bEJWlR+qLUOpRvmt28B0pqn4k2uQ1cUy91XTI+VSm1QozJyzk4X4SrEk28e
         7463sunTp15Gb50Av7lPnpaYIOws97fPmH1SQ/Jhlbi8Leu3OosoCwYQvmS6pyZQ0mV3
         y4R0sC2oasJdUyy3cCxo4wCBFsoWX7DG18NU7fHuHjtwmaWL4wxY4PEW0EjsOYHxch93
         /eAA==
X-Gm-Message-State: ANhLgQ3K1WNFuXromIzcohxVg9tSVPQLQazPnQu9fsTl6GbPpMK9PgLu
        NDrTx1SUWWxomBcfrRDoxTdfYQbXHjcO/ruFbLwv6Jy6
X-Google-Smtp-Source: ADFU+vtC833iVcQeThbA6OoVl3WYsqvu2njiClcJaRWG8znPiOsd14D2Mwy+5iOTVDfPmqMtDQ6vrP81pdNnzjUuB+M=
X-Received: by 2002:a5b:ed2:: with SMTP id a18mr12685227ybs.520.1585492557987;
 Sun, 29 Mar 2020 07:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com> <20200329143329.13846-1-worldhello.net@gmail.com>
In-Reply-To: <20200329143329.13846-1-worldhello.net@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 29 Mar 2020 22:35:47 +0800
Message-ID: <CANYiYbH1eaw6WT8qPfc3afwEDnv07uhq7_92VpdBgDKzZhFqcA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Never report references we not push
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8829=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:33=E5=86=99=E9=81=93=EF=BC=9A
>
> ## Changes since v1:
>
> * Add a new common method `reject_atomic_push()`, which is reused for
>   atomic push rejection for SSH and HTTP protocol.

I first try to add some common methods in `transport_push()` of
"transport.c", but I find it is hard to do this.  Because the
capabilities has not been set after calling
`transport->vtable->get_refs_list` for HTTP protocol.

And for the same reason, the following code in `send-pack.c` cannot
move to `set_ref_status_for_push()`.

    /*
     * NEEDSWORK: why does delete-refs have to be so specific to
     * send-pack machinery that set_ref_status_for_push() cannot
     * set this bit for us???
     */
    for (ref =3D remote_refs; ref; ref =3D ref->next)
        if (ref->deletion && !allow_deleting_refs)
                ref->status =3D REF_STATUS_REJECT_NODELETE

I wonder if we can extend method `get_refs_list()` of
"transport-helper.c"  and "remote-curl.c", so we can all method
`server_supports()` in `transport_push()` of "transport.c".
