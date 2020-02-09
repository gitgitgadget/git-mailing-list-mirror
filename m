Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD69C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 10:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E3620733
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 10:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOCyKTlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBIJ77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 04:59:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39366 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgBIJ77 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 04:59:59 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so4329308ioh.6
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 01:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vkbWCqJZkbcXpbPJEYosz2rCx5T5j40X2xXv3/TvfXw=;
        b=DOCyKTlH56PN3TigAO/F35ZBtcHA1RFrbdIRexbD9hRFXXkkOAu7IHND+EjF/0yc28
         IF5jW4l/ASRJocz9pVNnvB7qvxv6Nmn3CtFzetMfKhGfG0w5d7c0yaF6Z0MgwjYGkci1
         8vl4Cgzsk5F04OKz5XbyRJdQxPfntY+iMjyIJxJQyUf9+BzEu9Vk7TuiX0jLnYGl56ed
         PE4SSq8mXdkBS69GoebKKPHrZOJOFkLYNpMAKjJC3bq2/AcrxNb776/u2dtvBroBpDzI
         +8TFg5ig1RY1OLAif9YJ3K9SaHHcVhlSbaqNKgjEdzOIn/HNSteKlG0M+3vFL1JrL5Fu
         JN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vkbWCqJZkbcXpbPJEYosz2rCx5T5j40X2xXv3/TvfXw=;
        b=CnMpX8D0V26KGDix0/Z0gp0yIH6UFS/J1mSyNzefdNupc/ZwGpc/X5o0ed2P1G0wNs
         9NltYneQaPexwfQhAYwmFy9MW7q0MzlD3lA+sB5+PRb66czN4S87W1CPJHC6WLTomtDy
         iFLCZ4REB15Ku0PC9OupB4YWbs4gHBjYZjK4pwijcBkuv83N2GNEw/qnxdTSGjl8AZGL
         WFctSUepJ5tpb8edbka7awbbIgYi+ALcZlbwTmdXLIXQLLhYgntbCx6KzTw5H+G72RVj
         Q2qewAN9rRtxFWWVYrguoZBEBBf8zYxot0cCf8DVCwFFnKNa7L4s7w4cWzwKCbLxDpht
         9L2A==
X-Gm-Message-State: APjAAAXCPKfzK+BzDdhI3rugtkTxxd7Otj8imuqap4FjgqK4zQqkY62G
        CoMU4eGdBRUxaEtWs4X2fVYx5szEjymJc5dggUY=
X-Google-Smtp-Source: APXvYqx2BRFkodS7KvLWEfDIJl+aH9TgN+X9dMgPQSiLPJZ9Eut88QYapBxt6gTi0gDtiiON6TSQsQAS6w/OXDoey3Q=
X-Received: by 2002:a05:6638:3f9:: with SMTP id s25mr5613329jaq.83.1581242398560;
 Sun, 09 Feb 2020 01:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20200208090704.26506-1-mirucam@gmail.com> <20200208090704.26506-5-mirucam@gmail.com>
 <4550b9a5-74ef-2739-990b-6f41f3319129@web.de>
In-Reply-To: <4550b9a5-74ef-2739-990b-6f41f3319129@web.de>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Sun, 9 Feb 2020 10:59:47 +0100
Message-ID: <CAN7CjDB8NKQg279WjT6kWNaENiBRSEqztL0g9HbnS6RB_ZV7+A@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] run-command: make `exists_in_PATH()` non-static
To:     l.s.r@web.de
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El s=C3=A1b., 8 feb. 2020 a las 11:55, Ren=C3=A9 Scharfe (<l.s.r@web.de>) e=
scribi=C3=B3:
>
> Am 08.02.20 um 10:06 schrieb Miriam Rubio:
> > From: Pranit Bauva <pranit.bauva@gmail.com>
> >
> > Removes the `static` keyword from `exists_in_PATH()` function
> > and declares the function in `run-command.h` file.
> > The function will be used in bisect_visualize() in a later
> > commit.
>
> I couldn't find the mentioned later commit in this series.  Do you
> actually still need to export exists_in_PATH()?

This series is part of a bigger patch series
(https://public-inbox.org/git/20200120143800.900-1-mirucam@gmail.com/)
that has been split as a suggestion of a reviewer in order to be
easily reviewed.
This first part is formed of preparatory/clean-up patches and all
`bisect.c` libification work. The actual patch is one of the
preparatory patches and the function will be used in the upcoming
patch series.

>
> And if yes: locate_in_PATH() splits PATH by colon.  That means it
> doesn't work on Windows, where the paths are separated by semicolons.
> exists_in_PATH() wraps it, so it shares that limitation.  Wouldn't that
> cause issues for your use?

Thank you, for point that out.  I will check this.
Best,
Miriam
>
> Ren=C3=A9
