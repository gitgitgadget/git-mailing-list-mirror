Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C9C11F6A
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C1261413
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 12:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhGBMsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhGBMsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 08:48:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC53C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 05:46:21 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b5so9565137ilc.12
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o4m4SvkZW5GNFT71O1zeYteeohTR13JH6ptn4k/UKqk=;
        b=dPu/+r7ROoM0I97tTG64YcvqHcU9WoaE1oKoq+NpVr+Af79wIoFWxGgQ6MxwByjlIe
         nBiIUju7b09wqDF9+yqI2f/0+UzNdyyPIwxZrTicpnxQJzb3dwvur1TLem5gUe6UyHf2
         EoRE0wODPeM/e9l9dXW5FSlAP46uZCO0EbX8gfe7lIRc45k7Qff6e5E+YdrwWPXLKcty
         hBveq3I6a24DU9t5wW9X0i7sn/Ei9aqN+0gZ49pt3NWpJVNGKgUj8tztSIV8Xbmr6b3B
         cWd5esd3neCbcFFdmTf0vQzUAThEMX43xzf6pwStaw3mTI4xgO4VAkWKBk0tMJVhoUxT
         oLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o4m4SvkZW5GNFT71O1zeYteeohTR13JH6ptn4k/UKqk=;
        b=OSUKYw9jLLTAuy8h3WbR3Q6v7/J3xlxuZViBbtg02YGKNaBCCHYlEs1aloBeoNmQYo
         3+SFeFvmwmWdEt+h8bskY7ThPeTGdy+85PZaWdGGLjyK8eGMzMeY4uRhy/A+0Jwtb5Zh
         cnj8ulilsyfvC/K1DBs/UfibUBvsmTkmFyV5RF8tUnLK1hHZIhA2ZAWXz98vpfQtlH0s
         46vWremZzuqWJvo3Uj6O/C+ruLCXKkrEpBfsGGxNIEOiFhruVJu6ogS6GG7eydwM2WrF
         HTc7fCrEg1iw2zbAjZGcEjeD2BxotxvZnwJ/WjBnqWJxt6qk+9sJwUUwQZfFiRp1+uDe
         lNRA==
X-Gm-Message-State: AOAM5330+wTm82iP6l6dcKPhAgUJKBEt8W2uaYL2BTSathDmPMlYRtjl
        sRDPu3ZMw7/8UoYU+y5fxP62AwvyCJ4YFhsKplk=
X-Google-Smtp-Source: ABdhPJwkMHo6WGV6SfRPhC+DyeJg2Y17YHh2+K2bjOSuzqm/BAA92KkLWDE4gDvVEsig+Dnq0Csq7cr1d2LDqY1pjso=
X-Received: by 2002:a92:d2c5:: with SMTP id w5mr313945ilg.174.1625229981258;
 Fri, 02 Jul 2021 05:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <3aeb4d3d3ec9dc112a19a8b4adeaf213577b4028.1625155693.git.gitgitgadget@gmail.com>
 <xmqqo8blrdzr.fsf@gitster.g>
In-Reply-To: <xmqqo8blrdzr.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 2 Jul 2021 20:46:15 +0800
Message-ID: <CAOLTT8Qj0BO35+gTFdZ4jkNP=n8TarQX+s0PeCz2i+5yCCj-4w@mail.gmail.com>
Subject: Re: [PATCH 14/15] [GSOC] cat-file: re-implement --textconv, --filters options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:11=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > After cat-file reuses the ref-filter logic, we re-implement the
> > functions of --textconv and --filters options.
> >
> > Add members `use_textconv` and `use_filters` in struct `ref_format`,
> > and use global variables `use_filters` and `use_textconv` in
> > `ref-filter.c`, so that we can filter the content of the object
> > in get_object().
>
> These global variables are problematic.  The places that check them
> are quite isolated, and it makes me wonder why we cannot pass a
> format instance through the callchain down to get_object().

If we pass such two options In such a deep call chain, it seems not
worth to do it.

format_ref_array_item()->get_ref_atom_value()->populate_value()-->get_objec=
t()

But if we puts them in struct ref_array_item, It may be a solution,
but it may not be
very good.

Or just use "static" prefix?

>
>

Thanks.
--
ZheNing Hu
