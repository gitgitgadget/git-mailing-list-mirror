Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F348420966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbdDGMaE (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:30:04 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33319 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932317AbdDGMaC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:30:02 -0400
Received: by mail-oi0-f48.google.com with SMTP id b187so84094883oif.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uswB/7IGX+Iyq9+C8GoflFWbVREPf5UVVV6oZYEUwp0=;
        b=dtDXekLOVm8oPPBTXs409T16qjOXtff/wyVzLUmWUXqh+2AKC56mzaZPkvNTZ9L/8C
         wKde06e/t2haypBIEXN/XVLV4V6X4he5wJ60vYYAzeomuyM/GKKpfCc2IIO+Wm7NEFR5
         9yskE1/6pFGfCrfC4lh0kvBrHGDGjrG98q/6dFyvHCmvUqFVRUqVU1xVZlzdZarJyq5X
         qdawlMd2EdzyQL3ty0tqCDFzHX5mRUrqN3jn9U87ducTLK+sGmDRq0DuHErjDID9FBBx
         0iltXSufxtNZ18Ap0/dpRPvRwqI1/LBditnFr6HFrK+zm4VYc7Qj4V3KQsDwcm5g7uEv
         kLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uswB/7IGX+Iyq9+C8GoflFWbVREPf5UVVV6oZYEUwp0=;
        b=mvPAvjKjDzYLjgwWPsiFHc6auMU87+buBXmPttsn2da8npKCS8JJQqtgEXyLXnkVwj
         TQXbLbokYFaVqqXHTJvwP1v/h8SLkBgFgaxOPcF/yWK3gINRC7LHy1PV8u0PJPvXjAND
         AU7AqNB89xvImp0UINvSC14NFVJAc9DoVj4juJuTpAzgKk8MUkb9+btbtsoOuk+keb5A
         +qKOfbArCpAURNrwsRt2az7qkS0+IviDANN/lm/0l1qJm+5DKgla4KeDC/Fwhyb8L5Vv
         /rtxyJbbbFHTE/UpDF2ZMZ8/WbFNs6m1g/HAd7yOlBGAA4Bi9Y0lzk5IlBF9ZSU2ZYRT
         IB/A==
X-Gm-Message-State: AFeK/H2EijWoDOsvW3Ro+0gDXcWJSAhU/Be+m1CAvSNkZDaPWGxV1kTjbY5AIupnJ8RA64zB8O+5BxgNuwj1XQ==
X-Received: by 10.202.72.7 with SMTP id v7mr20482139oia.175.1491568202040;
 Fri, 07 Apr 2017 05:30:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 7 Apr 2017 05:29:31 -0700 (PDT)
In-Reply-To: <07e96aa2-6733-474a-118b-05c533f49592@alum.mit.edu>
References: <20170318020337.22767-1-pclouds@gmail.com> <20170326024241.31984-1-pclouds@gmail.com>
 <20170326024241.31984-23-pclouds@gmail.com> <07e96aa2-6733-474a-118b-05c533f49592@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Apr 2017 19:29:31 +0700
Message-ID: <CACsJy8AHGmbPrV50u0XbgGFyYxvE-guk+vt6aUiNM3RtdDj=_A@mail.gmail.com>
Subject: Re: [PATCH v7 22/28] refs: new transaction related ref-store api
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2017 at 11:54 AM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 03/26/2017 04:42 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> The transaction struct now takes a ref store at creation and will
>> operate on that ref store alone.
>
> Having worked downstream of this patch series for a while, I started to
> wonder why a `ref_store` has to be baked into a `ref_transaction` at
> creation. I haven't noticed any technical reason why it must be so.
>
> If we expected to need to virtualize `ref_transaction_begin()` sometime,
> then of course your design would be preferable.
>
> It surprised be, because until now `ref_transaction` has been a plain
> old data structure unconnected with a particular `ref_store`. I would
> have expected `ref_transaction_commit()` to gain a more general sibling,
> `refs_ref_transaction_commit()` [*], that takes an additional `ref_store
> *` object argument, and for `ref_transaction_commit()` to call that
> function.

I almost went with that, but the question that stopped me was, "what
if people do X on ref store A, then Y on ref store B, using the same
transaction?". I suppose we could even support that (which basically
turns one transaction into two), or check for same ref store and
reject. It's too complicated though. So I went a safe way, making sure
people won't be able to change ref store half way.

> It would feel slightly more natural to me, given that
> `transaction_commit` is a virtual method of the `ref_store` class, for
> `refs_ref_transaction_commit()` to take an explicit `refs` pointer
> rather than having that pointer buried in the `ref_transaction`.
>
> I think this is mostly an aesthetic issue (about which opinions can
> legitimately differ) rather than a concrete problem. I haven't yet had
> any difficulties working with your interface. But I wanted to mention my
> observation anyway. As far as I'm concerned, you don't need to change it.
>
>> [...]
>
> Michael
>
> [*] The name could obviously be improved, but you get the idea.
>



--=20
Duy
