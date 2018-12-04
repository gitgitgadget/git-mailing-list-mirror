Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2116211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 05:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLDFky (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 00:40:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34580 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDFky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 00:40:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so7725143plz.1
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 21:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=31tbmMis6ZT1V55ghF9X2L938wFLORT3hO/n0U5UBpU=;
        b=aL/LjVM9TZHdYzLbQV1Np1uxYg38t7dx8kHBLItMHjR11PGTNOqKEJClaTlVbGH1Ze
         EvdPknVKsTOzJUFtRHmDfZWxxEPszldUTMD/nDcmTbjyIf21ZBaqlsTrbUUK57IKLWZI
         cLwdHQTzWuv1OpMiRPzmr86ZyCif9/xNAJgNJLVlVzD9R2s+MCJ22FCp2ybOwfohbslZ
         NVj/71kSkWO2UhuzjETBg5ERD8MhuYAr5bWReoPA8CzBaP+Z/6C7IoJQ80rtCX/sj++y
         IVJTl4LblqJB/R5g+QpQVKq8jHXIYxyJyhljbpFx6JAtPzU6DY3fEGpJoAGku4LGNQrd
         g7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=31tbmMis6ZT1V55ghF9X2L938wFLORT3hO/n0U5UBpU=;
        b=UjMMjUZTTCzj+a6TC2p5lbn475UvUMc/eDpmPhUSCCQuQ+d5EiKjD43XMX63GyHlyM
         kldDDAa5UCf/hOYPyk+FOEd3W6e/kiCz0TUqUVRIUIy+JR3VTN8aXPYt2IQ92S4fI+/T
         M0Yu9nSxUIADThiXgC69vPUTfEevbnoZRJO1DS9yIShmoPmpZmRPOX//q+O8yCNJoJEf
         9ahZSi9BR9XGPCrBX9oPRWyPaxmVvSYzHJZBthtQxAVTM1pCLr+m55kkcWdWZyofa28R
         fJLbyXscAuYjXw4lWomL0/LMgcgIXxA4J9p9T058sMAirOrrjpLbiCKOnw3PKQjG9+54
         YGrg==
X-Gm-Message-State: AA+aEWZhwc8QbX8pyvdUW8s/SabNDmZSmrGP9a1X0yPr+qzZZ+Km3skC
        WD0tutxC8BrltLS9tKXw7KFLPkVvFllT560AA6U=
X-Google-Smtp-Source: AFSGD/V1tyDYBaB74Iwv8yl5ig1nwhGBDBeLf7dbq1Ptew5bUEu/D7aO+5U37p5Yfp+b+bMK3D6zvU75YnwdXzgKj0I=
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr18533710plo.96.1543902054092;
 Mon, 03 Dec 2018 21:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20181203200734.527341-1-martin.agren@gmail.com> <20181203212131.11299-1-sunshine@sunshineco.com>
In-Reply-To: <20181203212131.11299-1-sunshine@sunshineco.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 4 Dec 2018 06:40:42 +0100
Message-ID: <CAN0heSr6wNnFF76ushBO4ErOPpLs3_aUkqkUvY7buK31Sf89Jg@mail.gmail.com>
Subject: Re: [PATCH v3] range-diff: always pass at least minimal diff options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 Dec 2018 at 22:21, Eric Sunshine <sunshine@sunshineco.com> wrote:
> [es: retain diff coloring when going to stdout]
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This is a re-roll of Martin's v2[1]. The only difference from v2 is that
> it retains coloring when emitting to the terminal (plus an in-code
> comment was simplified).

Thank you so much for this.

>         if (rev->rdiff1) {
> +               /*
> +                * Pass minimum required diff-options to range-diff; othe=
rs
> +                * can be added later if deemed desirable.
> +                */

Agreed.

> +               struct diff_options opts;
> +               diff_setup(&opts);
> +               opts.file =3D rev->diffopt.file;
> +               opts.use_color =3D rev->diffopt.use_color;

Ah, s/0/rev->diffopt.use_color/, well that's obvious.

Thanks!

Martin
