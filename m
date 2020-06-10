Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E53AC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 07:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF59207ED
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 07:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i795L5KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFJHiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJHiU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 03:38:20 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E446C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 00:38:20 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id g3so952771ilq.10
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 00:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9s9nJs8jrphVBdT2aqQKbFkutxKSf5bqXvVhcf8WxWs=;
        b=i795L5KMNX9SF/SslW1Z9U1VMMTF3cn0AQzpHKgvVAWUxvye7uNQExs6mUYOV+VtNz
         RYqJSHWbQxFMlvLURQrnR7oAovT1HYdVp5D8/bt5/prbII1LYqttW16O7c78kkkmejd/
         Tovn7Jlg/Ff/WLKY5Q7HwcR/4cPxcOrv6SLrXW2aKlmb5JewGLD7cX23LFxRQBbEBCAp
         2AE8Eque3QMAcdUxrLilNQoUT/fE/fCXidjH4QzMP9ehJo2hdYqV3/cbTdvbeAomKnBv
         9rFzg1Jo4vF6DajzxfXrwh9R7skRpd2DRbwjr2rk0VAoAAnBYRi3XVDf5IxMlWQEsfGW
         om9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9s9nJs8jrphVBdT2aqQKbFkutxKSf5bqXvVhcf8WxWs=;
        b=DxxtNb+jLKLYraxgctLvCH3Ytrz76U4fiBMec1yP8b+HTDagXlz3w1PBSdQ09mYpya
         +hWyydTZBopvb28V6tmZii+W868r4OGEElS88vOnXOXpS1Zze/fd4Qzy9WtnxUWDcJxQ
         JwVeyH8nzVto51aL7OYubn8DDwQM7kHEPs4l5cXZmD29cjpELJBV4Kl04hl5lxdFHuSc
         vFYp8nEO6hYGC94NbP9U+XRCVZbfMsvdJrgozZ8z8gX8BG5uN+htbhRoQQjgKfF5KUTL
         1WURJuBjiiycVPWGZeBvB+JI1qrDtcbek/gJbMZRe6KNk5nTY08VaE2owCG7WlrJPDOS
         2s7g==
X-Gm-Message-State: AOAM5304IYVNPxk8xmfA7wBefnP6kBPQjgvAWbDB7PPxVZw1qCVysZbK
        DLUJrmKefy+wKLjFUwcR8U3B3//5p+XPBg3K50Y=
X-Google-Smtp-Source: ABdhPJy5N/XmQ4W1FUKTx9h8J43LM+y+xatCoG7VorwOS78D4l+4WqXIVN9idjKiPEf29l5VmzLyd3QRjNrV1wnjoFw=
X-Received: by 2002:a92:914f:: with SMTP id t76mr385159ild.99.1591774699793;
 Wed, 10 Jun 2020 00:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
 <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com> <87bllsa47u.fsf@evledraar.gmail.com>
 <xmqqa71ci5vd.fsf@gitster.c.googlers.com> <CAKO26MuO6UR8c5U+WX0ayEJjmXEnsp9P=ujZGwasM7KbrUgcRw@mail.gmail.com>
 <20200610034759.GA18542@generichostname>
In-Reply-To: <20200610034759.GA18542@generichostname>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Wed, 10 Jun 2020 15:38:08 +0800
Message-ID: <CAKO26MsL0gRafj5GxNs1uAYUMGwuWTjoRz5Kx+Kjg+LyyM_VYA@mail.gmail.com>
Subject: Re: [PATCH v2] gc: recommend `git gc --prune=now` instead of `git prune`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Denton!

Best,
John Lin

Denton Liu <liu.denton@gmail.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8810=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jun 10, 2020 at 11:43:09AM +0800, =E6=9E=97=E8=87=AA=E5=9D=87 wro=
te:
> > Hi all,
> >
> > Thank you Bjarmason & Junio. If Denton doesn't have other concerns,
> > I'll start working on adding bash completion for "git prune".
>
> No concerns. Thanks for contributing!
