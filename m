Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863A0C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 07:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63EC3610C7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 07:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhGOHwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhGOHwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 03:52:25 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC62C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 00:49:31 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id i14so1107226vkd.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XwMByaSSSwcd27AC54YncvqG3d+bvNECZeWoLsWSjp8=;
        b=Yq93+bFEt+2cB2F7kKliKKkj/oxz4CRoPnBtvLRsf83ESWh+i8eM3nCUFBY60Wnv/z
         yS8D7bFYgmiCHYSh4vfxrIvIyRkjn0/bAqvSxo1gonmoFK5VAfCTPYl3DBVuHmveWgPh
         wShMFvvmmVnvrzrUMvHdDpEjJdPIsAAmNDyGE+YQ7oPi0J3zOQXKsSVtlvAgkhAwogfg
         UPmUf06uDwy11neVZxIGmsAZkuNXhw54CrrxjnSImOFL44vJbP14LQG03SCkzkpsd8t5
         rHMkWrl+UWT8F2IZlh9CwmHIHbh+J4CYWMSB2LqZj4goQKV/mxz+kMq9wsrWrrazXiZI
         SbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XwMByaSSSwcd27AC54YncvqG3d+bvNECZeWoLsWSjp8=;
        b=DAw7WmQl7wmGAQQWWbX9GG6yfctrtISgkPtm875ZINPMEkHxvqLeRM0tzgnef35ezi
         XBwaaJeXIQLZfy6Bl0IoctqS7PbDInssCqGA4KdyraS+WHH2e1agvoeeeNbca9LeNaMp
         ljn5IHHzLGUS6MI1Tr+vTkRjOWla7ccMoti9JVvtBr+7bzMWNwd5gXWc3DQnXefhRgZM
         Dzdoe+PxYTKMvP3ZnzEYCcoOAmNHbaidNHTlbk+M3/FmlDIrSFzSb4it8nRYtZyrKAOB
         4dASOKkfL8kbPjjGs38CKYJKmtgG/ZD1FLrQ8bVHGMI11OMvzII3Yu4EhtLBLFWbjNmf
         MacA==
X-Gm-Message-State: AOAM531QHD+12GCDdqgeULgcARR9ebkcJ3Knsm4kDPtiuHmhcotu3584
        nNrb6AiOfl/dZaco6e0hKMoOywgHOnAJVGhUozAHgA==
X-Google-Smtp-Source: ABdhPJxm2BaF1S3lbPKmXs+5rk5rtf8UvHSE7NKC0eZGziBIpvgRW13wj0RX2jfXKb3iK9W1FVb3i+0pw8wolNRZuzk=
X-Received: by 2002:a1f:d083:: with SMTP id h125mr4047093vkg.14.1626335370305;
 Thu, 15 Jul 2021 00:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com> <b84b2812470ea45a85d624ec339f35bb0107493d.1626264613.git.gitgitgadget@gmail.com>
 <xmqqr1g0ve8w.fsf@gitster.g>
In-Reply-To: <xmqqr1g0ve8w.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 15 Jul 2021 09:49:18 +0200
Message-ID: <CAFQ2z_POEE3F_WPAPy4YRRnZONvsg=MOPmti2YT0me+M7eLFvA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] ssh signing: retrieve a default key from ssh-agent
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> > calls ssh-add -L and uses the first key
>
> > +/* Returns the first public key from an ssh-agent to use for signing *=
/
> > +static char *get_default_ssh_signing_key(void) {
>
> Style.  Open and close braces around a function sit on their own
> lines by themselves.

I recommend using clang-format (there is a config file checked into
the tree) which handles most formatting conventions automatically.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
