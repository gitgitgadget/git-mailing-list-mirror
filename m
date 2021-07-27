Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC24C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 01:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547C460F6E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 01:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhG0BAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 21:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhG0BAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 21:00:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C9C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 18:40:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nb11so19533118ejc.4
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eRA+tJLgPb5HGv9AB2fKr8+rEL0uVrvdc51rIXROJZw=;
        b=ovJIfDP56gXnFvViDRe0YZ3LtolWf2B9v7M6Js475qyKhdvrF07WAe/0riIj7YT13i
         srvbUf0JwZ+63eBcjfKy5N4YsCs2MQwaRLkcmpsBbnP2eW9PUJJWuY8A+VTVbKMFBNuw
         ypzE1congXx+9k2wiAWArZxaD602GxAp8sYIlRPDW2rILHR+63z4jyfwJYXiu0W+1H43
         AA4UWG2uJhFNfmkuJN1hp1jSg5CkGBx1nM5isLzjVx+7chHx+WOpOyUzkvGcdx31a93D
         T6cQANnhESIGKcbG4L5+w85Qo+kSpmn3exf6quHUMTxl3iAVZrKu/WSywfAsL9WGNorO
         VPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eRA+tJLgPb5HGv9AB2fKr8+rEL0uVrvdc51rIXROJZw=;
        b=F0my3v8ez27OViq/37K+WsRsQI3q/M6XR8Ui1oL1QeKGw5iZjnX/fMSlmvU8Jqi0Sg
         wsAXs4pyUJnz25W2ix/d5aFC13vAqv5dUrhSrGXRaVsxY2R3Nu0oYe/sb4vSGzZ3AJvv
         9BTo1JDGTlnUv0Gp+6uQiwgx6saooA5nyjStvJrXHrzmu+uE0HqbMdMq5jdKbbQ9nrxX
         uVf/JE6ouD63Tqa1vEte2lFXJfE3fm4ek9W8tnwrF0XvcL35T3XaNMmFlEnBilM5gQcr
         /OTXwKCLGrN74pyLxoRGM/DXn8+24o7re/uPXFfeQ1nlSPwprre+rEtta+KZvODNbG8o
         Rt5Q==
X-Gm-Message-State: AOAM5321CJclMBz99p3FtytYpi2SQcncDt9E9AuhpBgfnPJ/7hwrd/s9
        EJqQieje5AkPwR0rMpSgFGol7Eq8b5S5DuJbEDg=
X-Google-Smtp-Source: ABdhPJx+ZAW/ilpAmavUTaA7WN3SzEk6n063p6uwcEu0aQtefkdPayXgYnTEvHYuDKq24FypUHVcqleaoVChIBlvNQ8=
X-Received: by 2002:a17:907:3f9a:: with SMTP id hr26mr19679388ejc.110.1627350033022;
 Mon, 26 Jul 2021 18:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
 <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com> <0e294ff1626ef2b7992e84e8d960f5058bd39bdc.1627270010.git.gitgitgadget@gmail.com>
 <xmqqv94wj38w.fsf@gitster.g>
In-Reply-To: <xmqqv94wj38w.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 27 Jul 2021 09:41:05 +0800
Message-ID: <CAOLTT8QHKjubYowdCERs3ujcCsB7HNAK6+703rbSHRBKcR_nsg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] [GSOC] ref-filter: add obj-type check in grab contents
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:15=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Only tag and commit objects use `grab_sub_body_contents()` to grab
> > object contents in the current codebase.  We want to teach the
> > function to also handle blobs and trees to get their raw data,
> > without parsing a blob (whose contents looks like a commit or a tag)
> > incorrectly as a commit or a tag. So it's needed to pass a
> > `struct expand_data *data` instread of only `void *buf` to both
> > `grab_sub_body_contents()` and `grab_values()` to be able to check
> > the object type.
> >
> > Skip the block of code that is specific to handling commits and tags
> > early when the given object is of a wrong type to help later
> > addition to handle other types of objects in this function.
> >
> > Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Hariom Verma <hariom18599@gmail.com>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
> It is not a huge deal, but are these trailers given in a sensible
> order?  The order of event happened were that help and mentoring
> were given, your finished version of the patch came after that to be
> signed off by you, and then a reviewer gave you a reviewed-by, no?

Indeed so.

Thanks.
--
ZheNing Hu
