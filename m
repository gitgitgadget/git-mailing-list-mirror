Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A101F461
	for <e@80x24.org>; Mon, 24 Jun 2019 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfFXOqK (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 10:46:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45202 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXOqK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 10:46:10 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so2170226ioc.12
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nf+tQc54epBnmPg6ofQg3pZ9B4AvmK5EnTzd0f48lN0=;
        b=GHcxPuZ5L9+FtD1OJHZmmbeheqyuEwmMLbUHSw8k+ICyGWar0ex+zXnrCTNwCyqbFE
         oyvrh/cBA/WsgsP2V3VIQeAnhG4iouWwA7L7QFxhIeivCNPC/39p/Y9REZ+RaExpTuks
         NkxhmrYOEBDuweziX+UeKmuB3X+A0lClSYsUlKHfgha+VdkeKSEIbTs+Ym+fSjZl0BYG
         tL/ee9PnZGPVU9H5ajjvPusiH1xJiLslQTrMOQwc8q9QJsli9MPGEYjONXbhJOOO387A
         WCIvf7aKmn4zStzhTSaBxBhJ+P4+aWRMMJUpLa0FTjGux0NV4qrKCvrf4VLbYdJbAhF6
         0Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nf+tQc54epBnmPg6ofQg3pZ9B4AvmK5EnTzd0f48lN0=;
        b=VrvxDehkMv2FYZWvHa/zOcjiL78VHMc/L4TXOrdU4+pXX88Q/ki6W3mrp8y+45U5iC
         rUmLKvY9sPXa/IMLve+QCMTZ1kpNCipCQu0PJ7Td+Dt3lYoCuLS7r1vnvT/6sD+Ae/u7
         x6PiHrz8JD+mQhH5xqchF6XRsfBHicuUyndZjtd5/WKryhWkXiMj2OM+c2dxp1KZnF9d
         ndbJoRpGvJxzvgYzggBR99F8gGeQRjOvfq2RkhTGcTiXUXhDFE37Mb5pH2leJZw8AvSo
         fTchhJ8gB4+nc/5ecCvIIVoxV8vmFZP9rTatg3yz1K6h/cwDpt8cztc3FDXGMrAg2X7i
         +2EQ==
X-Gm-Message-State: APjAAAWiXZTKEuvZe/39dIfh09N3SNRtarULE+pGUXjCMOxl+VVWgzp+
        vDt/yitgEasZjlqQaqdYS7yzrEHcRlsvsnoWh/k=
X-Google-Smtp-Source: APXvYqyG7lCjY3bn1vEa1cv2KRynNBUrJgRwZQHB0G20QVxLi7O9vBvuDegP7/PeMk6W2ILUJnHtruRV0ntSrp8khas=
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr112827572ioq.282.1561387569519;
 Mon, 24 Jun 2019 07:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190624095533.22162-1-pclouds@gmail.com> <20190624095533.22162-7-pclouds@gmail.com>
 <166543de-bc25-ca2c-326a-4497688aa235@gmail.com>
In-Reply-To: <166543de-bc25-ca2c-326a-4497688aa235@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Jun 2019 21:45:43 +0700
Message-ID: <CACsJy8A7JT404tMFLs4-qS=S7Sj_dS4NGtXFd0q7xDq0senF_Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] Use the right 'struct repository' instead of the_repository
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 9:24 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/24/2019 5:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > There are a couple of places where 'struct repository' is already passe=
d
> > around, but the_repository is still used. Use the right repo.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
>
> nit: the subject line doesn't use the standard "area: topic" format

because there's no specific area to this patch. I don't think sticking
to a fixed convention for the sake of it is really sensible.

> (including
> the capitalization of the first word). Perhaps:
>
> treewide: use the right 'struct repository' instead of the_repository
>
> The changes here are straight-forward, but how do we check if we are done=
?

At this point, you can't. At some point we should be able to
optionally disable the_repository, at least per file [2]. But even
then some function calls inside could still hide the_repository and
you would need something like [1] to reveal them.

The problem with [2] is it will cause a lot of problems when adding
new code until most of the code is converted. I will bring that up
when the number of the_repository (outside builtin/) goes down below
~50. With all my patches, I think we're at 300.

[1] https://gitlab.com/pclouds/git/commit/902a4dbdef6829ca06e12dbf74b069045=
6733351
[2] https://gitlab.com/pclouds/git/commit/f03f915294210baf038ee72d76ee998d9=
387028b
--=20
Duy
