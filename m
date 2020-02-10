Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77147C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 16:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B47A24685
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZMTGu1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBJQFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:05:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43086 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgBJQFo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 11:05:44 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so8119167ioo.10
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cwoqnGluJsLwdgsR12avKD1uh6s+87b9aFZe5tB0/2U=;
        b=TZMTGu1IrXYXuLXJR6v2FRxHFRhdDXVbV5eF2CeynUjtcefpdiSYbtQILu0a5aj9bo
         ovfEhWpyOUjT002elq31VoYC1Iq43hMHbdC31oYpnn9dRyA60S0iokoP829aNRP8aNKX
         RYkqLhgigDrwJkDHURppUORvNZsRGGLn1jzDSofGGp1mns2B5NmAtMWpcwx/PI4beQww
         XCYBZGPUxpMgfy0O4YxwLKDdUwoSP2H+9TYgY1MAhtAOmdk5jJX5vmwc8Rs9bgVZOYFl
         5Q073JX+SL0/nnMRGl81+2ih7ntcfEAsC72m9MnFUQey8YVdemUw1JTVHSUJkiN+DG5Y
         7Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cwoqnGluJsLwdgsR12avKD1uh6s+87b9aFZe5tB0/2U=;
        b=lJlKqGowG6VODHMFMHl4fdTnE8IemqwKRzWv2cf6KCR4fYbGiGsymEZ5QPLadi7Svd
         VdLYzfOIFwy9KjSWsSACtNlnliE4QzXza964UascaFvsC+qvL13rUAq/+IarzJ9OiT94
         34pECPu4Oq1O5IsPZv/3/v9POGIsQeLoJknuVmz1EjGflX7roA0smqBUB913AjN92gtu
         J2FFInyc0PjLlYnEl9pIUJnXpkTGUzr5tNfdqE1IxHxQKFcNmJp+QO8y/yU/0CujIb1u
         a6STChQ4qRLZzumMEPdzpHIiODLfII/V4HrgwsWMavfUNOIV8SmwsX9/egZAfoShQwii
         gsug==
X-Gm-Message-State: APjAAAW+08dHgN5rIMS5r/+cGnu7vEUlUUjlMvF9AdoHolwFQoYjBZNh
        Lwn5ML70IIidQ71MzPmYocNMU+fEIjxP++LrtxUXrA==
X-Google-Smtp-Source: APXvYqx7Dnn6PNZUgGSW35ZH16eSeCPnv9O/HhHs9vjcNdi9z6yVJ5g0ppiBjtAnqCEBDjoeEC/zY9fjxb6PPYDjgew=
X-Received: by 2002:a05:6602:2113:: with SMTP id x19mr10353177iox.227.1581350741971;
 Mon, 10 Feb 2020 08:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20200208090704.26506-1-mirucam@gmail.com> <20200208090704.26506-5-mirucam@gmail.com>
 <4550b9a5-74ef-2739-990b-6f41f3319129@web.de> <CAN7CjDB8NKQg279WjT6kWNaENiBRSEqztL0g9HbnS6RB_ZV7+A@mail.gmail.com>
 <CAN7CjDC46xTHBxvkbWvYfUt91Z6sdPP1tT3rJBoc4x6QCrv+2A@mail.gmail.com> <47b51655-6373-0d5f-1397-8cbbb73d6661@web.de>
In-Reply-To: <47b51655-6373-0d5f-1397-8cbbb73d6661@web.de>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 10 Feb 2020 17:05:31 +0100
Message-ID: <CAN7CjDB=n=wfkEb=9kR7RKRm9oUAOsyxYJeU1w5MW=QH40kJVw@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] run-command: make `exists_in_PATH()` non-static
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ren=C3=A9,

El lun., 10 feb. 2020 a las 16:43, Ren=C3=A9 Scharfe (<l.s.r@web.de>) escri=
bi=C3=B3:
>
> Hello Miriam,
>
> did you remove the Git mailing list from cc: intentionally?
No, no.
Maybe I clicked reply, instead reply all. Sorry.
It is included in CC now.

>
> Am 10.02.20 um 12:16 schrieb Miriam R.:
> > El dom., 9 feb. 2020 a las 10:59, Miriam R. (<mirucam@gmail.com>) escri=
bi=C3=B3:
> >> El s=C3=A1b., 8 feb. 2020 a las 11:55, Ren=C3=A9 Scharfe (<l.s.r@web.d=
e>) escribi=C3=B3:
> >>> And if yes: locate_in_PATH() splits PATH by colon.  That means it
> >>> doesn't work on Windows, where the paths are separated by semicolons.
> >>> exists_in_PATH() wraps it, so it shares that limitation.  Wouldn't th=
at
> >>> cause issues for your use?
> >>
> >> Thank you, for point that out.  I will check this.
> >
> > This function is used only to test if gitk exists. But as gitk does not=
 work
> > on Windows, then I think it is all ok because the evaluation is going t=
o
> > return false and nothing has to be changed.
>
> Now I'm confused, because I do use gitk on Windows.  The third
> screenshot on https://gitforwindows.org/ shows it as well, so you don't
> have to just take my word on it.

Ohh, as I'm not a Windows user, and after some google searches it
seems to me it doesn't. It is clear that I was not asking the correct
things, hehe. Thank you for the clarification.

>
> > Also, as this patch is not really needed for this part1, I will move
> > it to the upcoming patch series.
>
> That makes sense.
>
> I guess it's to used in the C equivalent of the Shell function
> bisect_visualize(), which resolves gitk using type, calls it if it's
> found and falls back to git log if it isn't.
Exactly.

>Why not try to exec gitk
> and fall back to git log if that fails?
>
It seems a good solution for me :)

Thank you for reviewing.
Best,
Miriam.

> Ren=C3=A9
