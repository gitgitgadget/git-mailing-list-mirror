Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C224C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 01:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhLFBXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 20:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLFBXP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 20:23:15 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE5C061751
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 17:19:47 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id q14so9375699qtx.10
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 17:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=znr19bgC+cduKaHq3sLW/AmQcziMwPywL4gE5d3q/jg=;
        b=CHBpj6+2TLMNKNK1Wb3SXADl6VAXpxVRZuj7ZVIzPmSi+iMIDTMdoI+22ariXx9H9a
         dSeU0tRjdaT8nJvJnk+mk7zxgSE2heeCdjdmJGPacpt7ludkXxtTB7DpS96USLr8EPK4
         MvZXDaG7xqkQHpe7hnSQm8m+dftqX/MdSbhmv0z6a/K1L8NVj8jyZ5bN3PdeMfxvnd5D
         xP+2pwVbsjWypezYShoMnYfPFq9vB5ALw9AAjMSdxjmeR3Heln/v0RoxTgdBWf3gdsBZ
         NZYpMkKxJOlA6lYwN0XybY1WjdpC3K0B/dKm6uwQt4I0KMCXuzc3r1L2wb3519T8RGIa
         5ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=znr19bgC+cduKaHq3sLW/AmQcziMwPywL4gE5d3q/jg=;
        b=0t4huz0HcE04FYgToDyQG8HJ1lVlDuw6qBLfECGtPIFvFXARcvRZ2pjWw6LeqHhjvi
         Xz+g26kc0VnLO5FO8abrojyR9dVEXyv9/wUaVR0/4G1h+eHeF2VSj75n/7E0i7F3QQ8W
         JLiAaHS9BtKM8G16KaLdPpHUMF1+M5HL01xJvdB8JgTmvKnyAPEErovVhL+OjiqZWiyd
         t0EXHM8gVfNXpjADKq64KvXN4L+JXzOoczkwV8/UFfTyGpl/weQKy0l7dqw0TfM2gM8e
         mdRFp3tfQ3xj3EU3XVkA4dW7cRr38s4b8sr1eZIwsALTjUKpqmQL8LxBp38xu9MSOSsl
         WKQg==
X-Gm-Message-State: AOAM533bb5JVQaVry2GeskPa4HjlQ69ObM/QE//iDt3Z9WVQdIoWK21N
        RSytEAxJeXSMJi0YnTAjKnnTTdpQOGxs6Rzru4kzvOF7PFg=
X-Google-Smtp-Source: ABdhPJzLnRi52JdMm+dYzbExVO4ltT18CHSUFZ7SZBOh6FTk1ZFuGtIZwiYhRkrlTfh2/Iaj5iiCCp2u+8yV9c9CruA=
X-Received: by 2002:ac8:5c03:: with SMTP id i3mr38196718qti.107.1638753587179;
 Sun, 05 Dec 2021 17:19:47 -0800 (PST)
MIME-Version: 1.0
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com> <patch-v3-07.10-ad79e2afc89-20211129T195357Z-avarab@gmail.com>
In-Reply-To: <patch-v3-07.10-ad79e2afc89-20211129T195357Z-avarab@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 6 Dec 2021 09:19:36 +0800
Message-ID: <CANYiYbF1vEnEvToSxSXHzDKTGNyB-Hk6fhBbMDpRX3cEw-Acxw@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] cat-file: fix remaining usage bugs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 10:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> -       if (force_path && batch.enabled) {
> -               error("--path=3D<path> incompatible with --batch");
> -               usage_with_options(usage, options);
> -       }
> +       /* Option compatibility */
> +       if (force_path && !opt_cw)
> +               usage_msg_optf(_("'%s=3D<%s> needs '%s' or '%s'"),

Unmatched SQ.  Should be  "'%s=3D<%s>' needs '%s' or '%s'" ?

See: https://github.com/git-l10n/git-po/blob/pot/seen/2021-12-02.diff#L31
