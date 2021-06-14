Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37800C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 03:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B0A6128E
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 03:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhFNDo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 23:44:59 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:38648 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhFNDo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 23:44:58 -0400
Received: by mail-il1-f180.google.com with SMTP id d1so10995232ils.5
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ioT0q7rkDYjwtRceJFxfd94mqdmjvmdACls0X9OFjXM=;
        b=SruIJxyK4udAFy5s8aAymq/LHG93h2uK0gz4b9u9AwFaf39+BCnopDUdArNQIHzWbs
         3SzkBU6kPLBBOx4Bx2IhCCIJL4QKyiUy/KmTizVf7QKbzoELw9Vtw08pgSO5FTysH7fZ
         5qhfkMoF1H5d/NXqcUAuuAaI3QYIChZ0Q62e4gBUs0GIRwoA3sTzU92LitTwJq9jcE+8
         G6b0mQz/ASrR27KV7FA7LbaQTAzOhdGeZ+KepkKR9wVF6NJNFr0GyVRO2QDBjn1W2lyp
         uI/8ABXqUzsdPv3W8vJlBVyY/rshDqnxszWNfXUBdM0F93cLOwbMasurMl9O/ksWb4TI
         NbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ioT0q7rkDYjwtRceJFxfd94mqdmjvmdACls0X9OFjXM=;
        b=aYw/p3279EBmEiHczoo88F3vZnlVdr4dYHNaXzbURbXvcbaHwHr0FOg7VXJtDqirNU
         i0WFR91XvsMmTtn4H2kf6TpR4x22AD5k5VV+G3WHs8EAHxaDDNB0mAg+PJwqHwLkJXH5
         aL9yO6N6qwmZO2iJJhU3npy1ZtPPm8lSF7ciwIvpjQeCFxM19iAgfR6yLqPaNSpXvvt4
         Qa8nKY+4WwYFy43AtoJx462Dyh5A2hlaD1i2zWZYO1gOt4CfUU03WFW7x5csF4ZuQAv9
         dXNNYO8hfJbjt1e3qHib+IsHhaETKeJMyuuO6zgMm0pkMSPxYMFppgWNjPxn+1mQRSGZ
         NkNg==
X-Gm-Message-State: AOAM530s2EOQ5CVVFEK12BGh5qEM+XR6H8bQCju9KXwTFZbo614alkiE
        SlMtzkmitbmC43OwlJT8NC21qAya91Q0QM/L2bk=
X-Google-Smtp-Source: ABdhPJxZ+N3bcPb0Y0FM/o+Iz00R9o6t6F63eeRJyqjjBakx2cG8KEBLTE6pon5XzJfQG4kzUQezqesWnVZeWkLItbk=
X-Received: by 2002:a05:6e02:12c9:: with SMTP id i9mr12425085ilm.17.1623642101569;
 Sun, 13 Jun 2021 20:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
 <CAPig+cT09Y9GSTnbtY8d9e0=2C8398Ey=+p2e3L6tArOrsnaAw@mail.gmail.com>
In-Reply-To: <CAPig+cT09Y9GSTnbtY8d9e0=2C8398Ey=+p2e3L6tArOrsnaAw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 14 Jun 2021 11:41:30 +0800
Message-ID: <CAOLTT8TegJSKgf97F_4AF8p40sifo_1=bjNDZFkhHmuozfd+bA@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 4
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:28=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Sun, Jun 13, 2021 at 10:18 AM ZheNing Hu <adlternative@gmail.com> wrot=
e:
> > My fourth week blog finished:
> > The web version is here:
> > https://adlternative.github.io/GSOC-Git-Blog-3/
>
> I suppose you meant: https://adlternative.github.io/GSOC-Git-Blog-4/

Yeah, it is 4. :-)

--
ZheNing Hu
