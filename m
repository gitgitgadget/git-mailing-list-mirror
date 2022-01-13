Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD76C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 17:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiAMRkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 12:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiAMRkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 12:40:23 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5490C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 09:40:22 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 78so4331027vkz.7
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EEvwjd7AUN7ZKWDjKIAv8msWS57srZhYtaC3wwpPp64=;
        b=oOzH2SPNEwtYtSMH6rOq5D+oKCtqNGWp7C62fPciBDTOVwYJ7LzyWDQClTV56mvqhP
         0q6+3FOtD755agiA2Z6X8jLJtsckwgYsWpPPH6/Y8FnFGJq5rQUn+Ja/G9BzJ4FNbadM
         /GbMLmp4xc/3R71cw3jXm8cSwhVwuB+9agsPh+5+ncCbitTA6e/+/UrhcQyezlko52ls
         f0eS2INHJdrWISZccFmfiuv2sr2WAx+93lOQXKDDrM688x5oWwTrT//tZLswyaybR/+t
         GAaN5yALNxoxDWpvW9yCCJSx2Y78w+ekLKLAHReXGBoOnqHQ1CPuoax5hHJWnKyUvRGG
         mnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EEvwjd7AUN7ZKWDjKIAv8msWS57srZhYtaC3wwpPp64=;
        b=PjkVj0tyaAfZRM1TlEoPGv8WstGxE3OK6dNoC8rTrR56JWDNvQanQw03XcDhYQzUJj
         kNLKTyTSCmkDbu0C0U9QAg1NvxEF/SnAAZa575HROvqHv2SRytfoAsU/GrnE+B+LK8rf
         Wq5MUYhHdXmExPeTK8D2gbBqJapHHBi7DV4NXL7G+PrjMPuRTn/Vx5QY+Pat568VTgr6
         YP7Ax097nzr+7qcA5GAcZUnT40CWjB34d2EF9B8+mL7jOFZBE0XKuJ0HcflbQYmAkcCp
         vTRX0bK+WsQPJsFqy/ua7xW73FKcCUJv7zx6Dzlg6onLfSIRuJvEL+ls6h0aaooWzCjE
         6XTQ==
X-Gm-Message-State: AOAM533YFA/cVtOAVVQxenk0xttMWrKc0CAVxZE7BndIpbyMPQ+qE15H
        I2QTkN2rUzCJ46oJuME8RgT4DvRyOmtSbZ+4YC++wA==
X-Google-Smtp-Source: ABdhPJyYNlGu4doKSnwZjw2UJJ/ZhwvUaq8FIOSwBfv2McXWFlaoCLIBrx6q+RNXpT0e4QyJPocL/qi9S+a/UmQuPWk=
X-Received: by 2002:a1f:3213:: with SMTP id y19mr2869447vky.7.1642095621678;
 Thu, 13 Jan 2022 09:40:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1188.git.git.1642092934523.gitgitgadget@gmail.com> <220113.86r19btv5a.gmgdl@evledraar.gmail.com>
In-Reply-To: <220113.86r19btv5a.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 13 Jan 2022 18:40:10 +0100
Message-ID: <CAFQ2z_Nng6woxKVCpGzL95EOkuBFMQW7FtCTJfyaAZaZ-HMQcA@mail.gmail.com>
Subject: Re: [PATCH] reftable: avoid initializing structs from structs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 6:14 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I can confirm that this works on the xlc version that errored on this
> before, the reftable tests even pass!
>
> > Apparently, the IBM xlc compiler doesn't like this.
>
> Would make sense to steal the compiler version etc. details from my
> <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>. I.e. eventuall=
y
> we'll be able to change this & other code back, as nobody will care
> about that older compiler version. It worked before in the pre-image on
> a more recent xlc.

Feel free to butcher this in any way you like for your series. :)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
