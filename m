Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9136DC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F0B61429
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFOJIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFOJIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:08:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD48C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:06:34 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j14so11876462ila.6
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0SWrkJseB/GwNISqjZ69FWirxKLQ+bZ+QV/RHc5Z7CY=;
        b=cAUNn8nq8a1i8u5SZfRYd+52i33F/FfDt8WS0UzRZKGuKtRBX4NhXGV2M8zhEIbzFX
         my6AvKs4ADsd4S21pi8SnbGFMZ7ZSZgW7CTFOhmSVarBEGikA41xcJ0yQlnoni0sadsn
         i99sh4nurWCCGAL7t0VsX6odvyPDlK587BD6oF5vJ3NSFebUP9hSDww/jD7CQKrxjK8x
         0EAWETOmKAk5TcMjOAyCNGKGQyRrVN/SQ64N8josT/WCPKP2I9sFKRHkNkazny+4Jf10
         IdNzDgwZa1U8tn1XxL2OmsaDgVWQNGeUXFf0imu1qIKSmNWycOj6ij7yD86C+t+vew6r
         iEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0SWrkJseB/GwNISqjZ69FWirxKLQ+bZ+QV/RHc5Z7CY=;
        b=ospMF7jn7/ixm97tvus2wFfAuHOi6eairwg2jai4jKWd0zgUips8Lu7gimYrhj/4aa
         8594Z3e7HDFYQcpqKXXCyYybwIPzN5b4eClesSzXftTMVlBjf1uPHAK7Lg2UB47CgH8n
         04Xuf8XZll98RcypLqJyvmygquX9GGepaz0WTK2WxnNDiLPN4SuXe8KYzmNEdxkAxEPy
         1ulmmOecfKIGL8uzAymq5oo6OFFg1ejHXMkIcc4KVCJAhxlcG0kOfWOf1OU7vSXrJH4C
         3S7Uj4ldr785l/sBepSXJbLNEPEGuH9vWq1KFarkU3qblLjr/344ISe5kIlgEUj7p9a9
         PQcQ==
X-Gm-Message-State: AOAM531ulbzuZiE8L5/xV5gmf0EGOpxV24adY1v4oO9FM3jMmuKGvCgt
        jdelkSx4Q1m7qdQZxesIeR9T5nVys91J99RbYx4=
X-Google-Smtp-Source: ABdhPJynbtV6/8r5IEftYv84hwWNvePTMY4SoNpGz7I9Vfq4K82wjEohcHZB9QRw4wvHUKIipKZA1OB6XcPE8PxDXzc=
X-Received: by 2002:a92:b0b:: with SMTP id b11mr17115378ilf.301.1623747993602;
 Tue, 15 Jun 2021 02:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
 <1A4656C1-770C-429D-92A5-7A77453627D7@gmail.com>
In-Reply-To: <1A4656C1-770C-429D-92A5-7A77453627D7@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 15 Jun 2021 17:06:22 +0800
Message-ID: <CAOLTT8T8Vq6eurhkzQFLuBEoAL0h6ffRhrQiVCGMY1+rwitThw@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 4
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On 13-Jun-2021, at 19:47, ZheNing Hu <adlternative@gmail.com> wrote:
> >
> > [...]
> >
> > Since I am a newbie to docker, I would like to know if there is any
> > way to run the Git's Github CI program remotely or locally?
>
> Whenever I push to my fork on GitHub, a GitHub Actions workflow gets
> triggered. I don't think you need to do any special setup for it.
>

Well, maybe sometimes I might want Github to give me a more humane
error message instead of just telling me where the test failed. So I may
need to make some changes to ".cirrus.yml" to do it. (just for debug)

> You should be able to just access it from the 'Actions' tab.
>
> Either way, if you are looking for something specific, there is some
> work going on to update the documentation to mention this:
>
> https://lore.kernel.org/git/patch-2.3-7add00cc87-20210512T084137Z-avarab@=
gmail.com/
>
> Maybe that might be of help to you :-)
>

Thanks, it's helpful!

> ---
> Atharva Raykar
> =E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
> =E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
>

--
ZheNing Hu
