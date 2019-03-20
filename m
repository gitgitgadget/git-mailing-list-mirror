Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B4A20248
	for <e@80x24.org>; Wed, 20 Mar 2019 09:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCTJvU (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 05:51:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51650 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfCTJvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 05:51:20 -0400
Received: by mail-it1-f194.google.com with SMTP id e24so30565698itl.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rhwi+TqpSolGHMwC5JedT30iOs8vq0jiGaVBELRdw04=;
        b=bowPXWM0B6PpsqqWX3HZRdovK35wLRY7QMLDlhIENuYT9pA66HBJ/YSipgJuvi45ac
         mWPLH/Pt+1UgfndxKNohoKmyk8COjTcE1MR5kw0SfoOZ47kr81+LBJRZulH4F39ZFFEN
         r3CFZaC8w0s8AFcsUHcGqpm51Mz/1F4QzonzOiR2BfByoqoqYgEMjzQOU9CDD74jMaCB
         tkSEwsCyO1+MR03U9AAldNQ9hLGDdxvApI9BuOBPTI9J3RrvbowQ4DcWqaiodqDSXmgB
         ZZCoOUFUOEcDfMDNgmuoLkG6amtSB/iVJJ0m/21IGE4pc5r9UKp+wqvZ3y/J/hXKwkZP
         s9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rhwi+TqpSolGHMwC5JedT30iOs8vq0jiGaVBELRdw04=;
        b=BjJ3eLxZtk/c8eg1UX4V0KMoiHWWkEDxVpLo+m6TEqSOlCKH3p7cEDvSVLKjAcd+7r
         3fAVbpGhukQFYyoQ6v3nkFIcB0OUVijELL4OdgaYL4+fp8PElykhyJC+xKaO2FeY46bz
         8hAcX28aJyqPKF8WTNuXKmB9gom2zVNrFkrir366UAn+W6g5R4N3V/Vk8rHrkgMTMNVc
         5f9+DwvN1ry8S8KWig+VtJWR0mPsvu7mT1pzi2wilMFBFdmmOyESV9UMV5/Bs/SUdbAp
         iSd3vlsRl5n4iOOpBSEWecHc6HuGNeUWtQcKwCrkq5Qdwgr4yM2GVPrpNi/N3jp1Gt3j
         w1tg==
X-Gm-Message-State: APjAAAU5kfC1MMakPJHLF/LRtpXMti44w2eMQTHmgFd9zI48cQBlXer0
        uFNv8XrHqkXMJ/8AQJYuguepilBa2gNz2SAdH2g=
X-Google-Smtp-Source: APXvYqwN1QLaxI6Q6pYvzSDMbbnkby8Z1OXGtW8oFfW40Y4Y+yniLAaC+ec0fdg1MdAzIRKP+O6AyHtN5DYMB4Y7vnw=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr4631858ita.10.1553075478969;
 Wed, 20 Mar 2019 02:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190317060023.3651-1-pclouds@gmail.com> <20190318113822.6195-1-pclouds@gmail.com>
 <228d681e-4cfd-7e2e-8bb9-1624cc244a9f@gmail.com> <xmqq5zsextqq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zsextqq.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 16:50:53 +0700
Message-ID: <CACsJy8ANaKRz04it93Xpodz1wZfUjsbZXbMfrUSLvtfWbZGQWw@mail.gmail.com>
Subject: Re: [PATCH v2] unpack-trees: fix oneway_merge accidentally carry over
 stage index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 7:41 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Thanks for doing this, one minor comment - I try to use
> > phillip.wood@dunelm.org.uk for git as it wont change if I change my
> > email provider.
>
> You mean something like this?

I think he meant fixing the Reported-by: line. But since there's at
least another commit in 'next' with the 123@gmail address, it's
probably best to update .mailmap too (and maybe still fix the
Reported-by: in this patch).

>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 82cd0569d5..6e137576ec 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -212,6 +212,7 @@ Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
>  Philip J=C3=A4genstedt <philip@foolip.org> <philip.jagenstedt@gmail.com>
>  Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
>  Philippe Bruhat <book@cpan.org>
> +Phillip Wood <phillip.wood@dunelm.org.uk> <phillip.wood123@gmail.com>
>  Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
>  Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
>  Randall S. Becker <randall.becker@nexbridge.ca> <rsbecker@nexbridge.com>



--=20
Duy
