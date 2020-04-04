Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA6C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636FA2071C
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8Km3DTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDDOgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:36:48 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:33649 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgDDOgs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 10:36:48 -0400
Received: by mail-ua1-f47.google.com with SMTP id v24so3861770uak.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rSFUmjkhUwFktMfFu5JtTTa4okfr9VyP4wgATYxrQks=;
        b=S8Km3DTagp80oKH+lOshnzZaidvaDBJ9ce3pykZe4i5pddJ25HVHnwQFpRD/luT1bJ
         g84MBMZOZBRi2QQHpyrGpFug6Yh09Tw+dvxHe26+q5CNYFZUO6x3bDIA1mJPwtALCaB9
         2SIUfjHU1GgXKynCO/1IB398gtGy0vxYIFNVgstXk5IS3ETtdLOBgef5p9Q0/+onDSqx
         mbTRIAixcl3MXR8HVVKrnU54RtdW82HJucD0Q0krLiG8mny3mSlruZ1tm0p0OZIxYlk+
         LQwSyw4JfqVLPbE6tsaWkLRaCNG6Qi0q5HH8+bccX6pUg4gpdJmFffrPgJUrBB+F0mh9
         mL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rSFUmjkhUwFktMfFu5JtTTa4okfr9VyP4wgATYxrQks=;
        b=fzBIoG/hjcmRu2qR2gipUC127vpKYfN/fEM8+TkEl6hdcOd0vKwMLdcksUNm7BjfHD
         B6hhsPDfLoUfvv54wCYdg8IVl0peWvOiL9UFG775VA2Ya5VnvO430Ulawvv2qORUQLBG
         yuH2NUMDA1pNagstOQ42n3gdECqAmq5Afs+BNVzx5H0D3qZelV0IvT0MdpYs/oV4wsgF
         fJJ9p9hNZXPopP+wJHuemIjofAupS5U+BrN4c1w9dJIAM4GDHRoWMojNwhy87FF8bMrt
         4IdZqrpDq+M4TO9HavCGd8D3A48QjLo1mm6XKmMPjNDCAPPXck4zUHTm7zMdL4PX2o2Q
         D7Qw==
X-Gm-Message-State: AGi0Puae6ZOv2qtINgfPM35tE/bQVVeG6QVUh0y1QWN/NWMjaGjuvljq
        K1WNbA2fYOAD9Ugv8y/C5ongM5jeXpzH0736Kow=
X-Google-Smtp-Source: APiQypJyK3him5adPyMj9wIdZM/AgwJrj0T71NeDEJv0bV2oCNp5Lrl2ZQsSNDjFPUo+Fi5x5QWOR/mZaLcipCyt1XE=
X-Received: by 2002:ab0:18a8:: with SMTP id t40mr10634129uag.115.1586011007769;
 Sat, 04 Apr 2020 07:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200331064456.GA15850@danh.dev> <cover.1585909453.git.congdanhqx@gmail.com>
In-Reply-To: <cover.1585909453.git.congdanhqx@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 4 Apr 2020 16:36:36 +0200
Message-ID: <CAN0heSrrhrPSqMr8hovdFxbM7+rYMS004KDr1NKuM8JwKXsxuA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Honour and Document --no-gpg-sign
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Dominic Chen <d.c.ddcc@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Apr 2020 at 12:28, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <co=
ngdanhqx@gmail.com> wrote:
>
> Multiple commands that understand --gpg-sign but haven't understand
> --no-gpg-sign, yet.
>
> Also, document more commands that honours --no-gpg-sign
>
> Change in v3 since v2:
> - Use `backticks` instead of "dquote" for options

Cool, thanks!

> - Add missing "--no-gpg-sign::"
> - Merge git-commit-tree --[no-]gpg-sign"

Martin
