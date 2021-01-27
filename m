Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B0C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116D3207C4
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhA0OPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhA0ONZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 09:13:25 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528FAC061756
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 06:12:45 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e1so1870629ilu.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TfFd4yCkk6HyNQ50INkMwuN/Znvlfht/VQWUOJeyVaQ=;
        b=RkkWTWFQKks76RwBs/qMKHR20Uj9Q9p/eICTxgiOYqwy03AQ1vUKLNxMKbUmS3CARC
         rTBrkaepaGMViY6rzuFLR+CTkRocdkVvotggVhs4eyQcX4fiIlGb+3iUe0PVLLQOajXM
         5jpLYY4uefbgIfz/K1tX9Z4CnT9xhBsaAzugtx9YxTHX6OSOiXJZOAkjXyt3rpiCWkyZ
         HeSrgTLrHIsIz/k37AOw43r1kPUPWPt5eFCuwUNlHQWsqqqfbO6AWe1O5UzXigX5jGFC
         Y9dY67GTu8dlqc7RVxOn+Hk06Ns0tI6K+AnRbUEhUOBNAwhR0jene7Qh26Hhz/bikc0K
         bsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TfFd4yCkk6HyNQ50INkMwuN/Znvlfht/VQWUOJeyVaQ=;
        b=jC4H2rKiIptrWfxo1woqqAVNGZawgmqhIIrtNbOFOYEXy2n64bbeetyf52cswdSH2l
         Z7z7kGltHrZP41Z3F5iaVYJgOhoSy+QO3vCdCaSOEHeAzXW0dAKScrSJHo/O4Z1kCuIe
         6RrebiulKvQt3yYgtK9TsRjjMne4cU5+BPu2wlkcHeAD3lSUinCpaMSZWVucX2Q2fiZh
         9CW3CLhFB+ERnQBoP9fctYZtwFDXx8hy2HyLfRudSvD/5iWKHoTrzCl6Z5vXZIuiaw4A
         JChHuxEr+QPaxefuRYH0ktqMm2rVuTjeuJxj6JrhhZ5p7tVpqUvgPPvNCikiS1zBkVt8
         0fSg==
X-Gm-Message-State: AOAM530KW4YgZQ54UaSAcN2nTPxH/PspMT5hMUAzqUdDA6SiCKtA4K0H
        6QfKko68W7JkEelxnQE/QHvNGSXUVqf7/3+oXRw=
X-Google-Smtp-Source: ABdhPJwWFdcs643H9ANZY5zohGl2DmmM8JcFD/feyhmRGa1+n64kmRDKfBnYfuTSsFpLd5XFCYI9FeMNYKYQ4XAG6fo=
X-Received: by 2002:a92:d987:: with SMTP id r7mr8572665iln.3.1611756764812;
 Wed, 27 Jan 2021 06:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20210125191710.45161-1-mirucam@gmail.com> <xmqqh7n337nq.fsf@gitster.c.googlers.com>
 <CAN7CjDDQw-Vr_pV=yM0eRXi02F4LjcMfE-9gs5iLS_MU-JPYKQ@mail.gmail.com>
 <CAPc5daWO8JT1p0xhBtNyAjvy1hzjt3s-ho7LCPxEe-E_y8-a-w@mail.gmail.com> <xmqqv9bjz5vm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9bjz5vm.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Wed, 27 Jan 2021 15:12:33 +0100
Message-ID: <CAN7CjDDH+XyM2y+em=rRTG8aDR7Rb7jBmx+BdJ5BbEe_OESABA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Finish converting git bisect to C part 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

El mar, 26 ene 2021 a las 23:32, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> > Did we lose [2/7] somewhere in the mailing list?  I see the same
> >> > thing as what is shown in
> >> >
> >> > https://lore.kernel.org/git/20210125191710.45161-1-mirucam@gmail.com=
/
> >> >
> >> > i.e. a 7-patch series that lack its second part.
> >>
> >> I received the [2/7] patch:
> >>
> >> -------------------------------------------
> >> De: Miriam Rubio <mirucam@gmail.com>
> >> Date: lun, 25 ene 2021 a las 20:17
> >> Subject: [PATCH v4 2/7] bisect--helper: reimplement `bisect_replay`
> >> shell function in C
> >> To: <git@vger.kernel.org>
> >> Cc: Pranit Bauva <pranit.bauva@gmail.com>, Lars Schneider
> >> <larsxschneider@gmail.com>, Christian Couder
> >> <chriscool@tuxfamily.org>, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de>, Tanushree Tumane
> >> <tanushreetumane@gmail.com>, Miriam Rubio <mirucam@gmail.com>
> >
> > It does not count---you are on the direct path of the message
> > and are not relying on the list to relay it back to you.
> >
> > It seems that today's one of those days that the mailing list is
> > hiccupping. The message I am responding to, which is sent both
> > to the list and directly to me, hasn't appeared either on the public-in=
box
> > or the lore list archive, either.
> >
> > Hopefully we'll see all 7 messages eventually ;-).
>
> Now I am seeing it on the lore NNTP server (so presumably it has
> been relayed to list subscribers).
Ok, perfect!
Best,
Miriam
>
