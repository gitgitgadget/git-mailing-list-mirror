Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A681C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 09:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIMJLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiIMJLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 05:11:16 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D25A3DF
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 02:11:13 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id h1so11671108vsr.11
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 02:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=dSkUxNfXBFTdzBZZfxHJEN9SW6Jv9Mn0thxv5toZBT8=;
        b=qSs0aaePXAJWf3qWW0JU3WXmgJYWRd+Kd53cOqLe+0Z8mgqHAlr0o8ltt2yt53Ou/O
         09wsrWTbCjY+mDtwDd2in9z7DT6PCoBUOwKEooKWDz9+Osgzj7a5dPiw9WR5hlphgC1g
         DWitS6YUxeyLsXg9Sr+9yIibz7VhweP3AosawLSaYPADB0RMZMyIa1PelqLy3Lmx46Pq
         lZkEVpYdh8fAHOgWOsx+YrReRkY1tHl06QWeLK6EIgXoy4ww8klIAEeFeRt/nL00EpS6
         ACTB6FHGTOh9QRx04iyC+z1C6obxa2W0K+Zu1zqvgDUBZsbCa6pOG7H/Y1cu0//cMUhL
         8wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dSkUxNfXBFTdzBZZfxHJEN9SW6Jv9Mn0thxv5toZBT8=;
        b=7ASpAOk2OwW6trD3XHO6lxw+7vQ84+hR9cFKILjg0WLt7Vx+pJ5FAH8aCzsIbGxwlv
         Tkb9V9RDQ03YxMYdhGq8HjPVP9YVgZW9t6oxa1mtRX2PdsI0Xkrl2JFFQo0DQUyy3IVN
         FShtnoew/8LGBbP7e3fxbLbls1SsvpVWRYkJgRcM7vIWzabkeUDtLiztO5w0ylE/b1DH
         rQjM1B62gSzKVal43A/LcEyG6pSzQz8WR5xpChJRtGTEQdLT72JGeAcHn+HU9VdObQgf
         AuQHx5Ye74VR9IvHpvV8YeDGYxt1lhsSkV0bTg09RGeth74dZPrR+UxScD+GFCAkrX+9
         UrcA==
X-Gm-Message-State: ACgBeo2jRWHIlhmTHOEooW2GdoeHO690+ltuH3kPFWahqFTTTXtrxeV1
        5IEFowE0Apt5UTxbnuAcO5p8TFOePUgzY+odRFnpMSBHNXo=
X-Google-Smtp-Source: AA6agR5gYCUBLW0OUxImv9uJKyqHSSPfyN3ga+h6ITNIe/s67esvzp8h2gJWeysqJ/hW48zCvGYGbraPktrwOUqFxCA=
X-Received: by 2002:a67:d906:0:b0:398:42b4:7e22 with SMTP id
 t6-20020a67d906000000b0039842b47e22mr7244798vsj.31.1663060272099; Tue, 13 Sep
 2022 02:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
In-Reply-To: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Sep 2022 11:11:00 +0200
Message-ID: <CAFQ2z_PATan--dz79j1MUHFCobegX8id=zMxGxk5ftzwK70bnw@mail.gmail.com>
Subject: Re: [PATCH] reftable: pass pq_entry by address
To:     Elijah Conners <business@elijahpepe.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2022 at 6:53 AM Elijah Conners <business@elijahpepe.com> wr=
ote:
>
> In merged_iter_pqueue_add, the pq_entry parameter is passed by value,
> although it exceeds 64 bytes.


LGTM.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
