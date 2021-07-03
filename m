Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D0BC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 06:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B7C6141C
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 06:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGCGUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 02:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhGCGUW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 02:20:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEA3C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 23:17:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g22so14352773iom.1
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 23:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zgk5Jc5X9GYe7oC3fYlZNrpGTqpEDi8jgk0cpCT/9r8=;
        b=N3Lq4dVjuM+DFQpTLVlMyGELFwPqgCehn8abSelbtqipS/g7ZG4KdsPOFgKqO7wpmH
         iwORKRgYoBYNRi/wwy8iQl0iHv248H38HIB9LZaL7Q4/vg2/4vXWaWozKhG33n2wuTo3
         7tHqIKvGtwNz1/gh4O6dVI/cKCn3PbKkw9yyAyNAzwaHkBkP/6TPa2xzwkaUdk/dVA8+
         Dz7aK7mTBgHw4Z0p8bccWklSE5rMJcezGJ1hvRR5bwob07io6wnk8w+VgodFksojT6kX
         83yLIl+p+0wGX5lqyw/DrCyOsnnei1mzs3LaVPZzRgwa+EtHsYgEaqZsOT0nClrCOIvr
         jYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zgk5Jc5X9GYe7oC3fYlZNrpGTqpEDi8jgk0cpCT/9r8=;
        b=G8zpaQwBJ8oJ2XvSSyux6Rnu7dC7V5+eWqvixqb+P1lhRT5HeZ+imV4f0iMzMWmpDT
         z/qf6eZZGt2AVtyuiPVRLgaU2AKs1FoG7tdEhWBrwet6ADMiqmZJqhX1PeLPaTYxwwmT
         r/u9zcbEIA1Y9LdNPRalY2niz8HCOnNiH8dl3MWEguNigLKI54QJVyWUClhT11R4bGGF
         aCzuNoVGGYmc9Tr6TYf//SbdktZsD50cFE175P1x3HSOvefQrI3Fn+02QYCzQN2FNxXg
         egq8Zm6+CCgzjSf2gfCWP5n3b3pPnIUIrEfrZ8VL7VlZYRDk1xiHW5asPFlQ7MT9r4lw
         AWlg==
X-Gm-Message-State: AOAM533M2VnaTcFcbmm3il3kFv+o0ryZVzJUtJB2cDSnrQV5uNqW6znE
        pS7NlE9Sn5b0KuqJ+NKE7Ng3ydtqZgaNUP8f9AA=
X-Google-Smtp-Source: ABdhPJwmcGsKtWIri1VWb2GZkEOMBikpEPxFb59++Yvn7d3YBRlY0dy/qGTKolNwvp71e6SX3ZqVnBrgUue1BADIjm4=
X-Received: by 2002:a05:6638:1301:: with SMTP id r1mr2586119jad.29.1625293067856;
 Fri, 02 Jul 2021 23:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <3aeb4d3d3ec9dc112a19a8b4adeaf213577b4028.1625155693.git.gitgitgadget@gmail.com>
 <xmqqo8blrdzr.fsf@gitster.g> <CAOLTT8Qj0BO35+gTFdZ4jkNP=n8TarQX+s0PeCz2i+5yCCj-4w@mail.gmail.com>
 <xmqqy2aopwg2.fsf@gitster.g>
In-Reply-To: <xmqqy2aopwg2.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Jul 2021 14:17:40 +0800
Message-ID: <CAOLTT8S4XnekSCAFNgPeQZD7JU2p3bm==9vHRDxcir-K+w4rqA@mail.gmail.com>
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
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:27=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> These global variables are problematic.  The places that check them
> >> are quite isolated, and it makes me wonder why we cannot pass a
> >> format instance through the callchain down to get_object().
> >
> > If we pass such two options In such a deep call chain, it seems not
> > worth to do it.
>
> OK.  After all, ref-filter.c has too many existing global variables
> (starting from the used_atom[] array) that makes it impossible to be
> a proper API that can be used to handle more than one invocations at
> once, so two more globals aren't making it any more hopeless than it
> currently is.  If we wanted to make the API reentrant, we'd need a
> bigger change anyway.
>

Yes, Using global variables may make the code non-reentrant.
Now I think because the "rest" is already in struct ref_array_item,
we can emulate "rest", adding these two flags "use_textconv"
and "use_filter" to struct ref_array_item. Then we can use them
in get_object().

> > Or just use "static" prefix?
>
> Yes, that is needed regardless to pass "make sparse".
>
> TShanks.

Thanks.
--
ZheNIng Hu
