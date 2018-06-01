Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE281F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 22:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750736AbeFAWwc (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 18:52:32 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45350 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeFAWwb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 18:52:31 -0400
Received: by mail-qk0-f195.google.com with SMTP id c198-v6so21107392qkg.12
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UeDrv3tsKe7rb3VCZFBL+7XeoIWUt685TdidH8xE3iU=;
        b=PaePMoYYZreZbV2zvj3O2IZ5HZ78k2BD1+2kNrK1HH7wqu+YMRIDuNgVV0rxiTGeUz
         sPQNc2jo+iaWF8cHW7HtTBHvDA9eOUxCraNggIWRFCrvyN5D6lIlMAE1it/WL4Vx9UnV
         S7PuooHFnjVuj1/IMwev5zt3qlif5YOW9b0wZL9Ms6ucV/9Gdw8ra4lXr5+L1ugIWIxM
         0/zLR0FedJECLvhKZiqpalFZC59sx4gBz9q3Jliqrec6p3t9SVxv5QObTZr87RhxcIN6
         e0Y31Ia1JHTlkjsX96lZBmDOm2UfQ0r5vFjD2TWPfUEQwJycAMWNTAURj5vd3/ryVR60
         RGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UeDrv3tsKe7rb3VCZFBL+7XeoIWUt685TdidH8xE3iU=;
        b=qO4qSvAHv3keRbzIGgw8Ro22gMCwHp898Sbh2c270H+LAm9q4D2uUgO2cJX3JfZfx3
         wsT0ny7fc6rV0bSJ6bQaECM3wMkhywdtLK8GNucQ/WpsxtnpejKQkkfLwohZ6gX22T7y
         1yIFq1JIMp9gF7WCb2BUMvToEKlJVAN2m12Dsm6SFrwz/AVPFwbW/0StV9xwyuqG6PFS
         TykyInD16gL91NJVfjBsv6Ew+vbzAj0Sst0vgJ3qn3y0KOhSwOR19toPsBmXf/NAy8Sp
         MYZw+7lR5zTHXGb/NZZXsQalKiUlyBdfWSGorEpWXlpktdwYTNE2fOQpoOXzxhtaFc+/
         HiNA==
X-Gm-Message-State: APt69E2xQxxx3fnxwI5pCAuNdCAhriyrFYpf9sI8mt0d+X9v3gU2UDCU
        28BiyO4IR/dSvfIxeSZg2PYFIBYKZW+KWmolKEs=
X-Google-Smtp-Source: ADUXVKIIk0PD97cE8NeeNmHcCgoyxYJXjZOVl1nVYQH6Q5+nZ4KWESmpAWMdYAdXWhJcpDZAYOIO1HeK/dujOuGlErk=
X-Received: by 2002:a37:270b:: with SMTP id n11-v6mr11655307qkn.91.1527893550648;
 Fri, 01 Jun 2018 15:52:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 15:52:30 -0700 (PDT)
In-Reply-To: <20180601211015.11919-8-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com> <20180601211015.11919-1-avarab@gmail.com>
 <20180601211015.11919-8-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jun 2018 18:52:30 -0400
X-Google-Sender-Auth: ZnYuuik_YvVQWNGf4hrVCi58R6s
Message-ID: <CAPig+cRGDi-FX1Pr-7dt7G1fbP=ZabFNimuMr-OheBabKAXHLA@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] checkout: add advice for ambiguous "checkout <branch>"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 5:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> As the "checkout" documentation describes:
>
>     If <branch> is not found but there does exist a tracking branch in
>     exactly one remote (call it <remote>) with a matching name, treat
>     as equivalent to [...] <remote>/<branch.
>
> This is a really useful feature. The problem is that when you and

s/and/add/

> another remote (e.g. a fork) git won't find a unique branch name

Missing comma: s/)/),/

> anymore, and will instead print this nondescript message:

Perhaps s/nondescript/unhelpful/ ?

>     $ git checkout master
>     error: pathspec 'master' did not match any file(s) known to git
>
> Now it will, on my git.git checkout, print:
>
>     $ ./git --exec-path=3D$PWD checkout master
>     error: pathspec 'master' did not match any file(s) known to git.
>     hint: The argument 'master' matched more than one remote tracking bra=
nch.
>     hint: We found 26 remotes with a reference that matched. So we fell b=
ack
>     hint: on trying to resolve the argument as a path, but failed there t=
oo!
>     hint:
>     hint: If you meant to check out a remote tracking branch on e.g. 'ori=
gin'

Missing commas: s/on e.g. 'origin'/on, e.g. 'origin',/

>     hint: you can do so by fully-qualifying the name with the --track opt=
ion:

s/fully-qualifying/fully qualifying/

>     hint:
>     hint:     git checkout --track origin/<name>
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Aside from the s/and/add/ botch, all of the above are tiny nits which
don't actually impact the meaning of the commit message, thus not
really important.

> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> @@ -1267,6 +1268,18 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
> +               if (ret && dwim_remotes_matched > 1 &&
> +                   advice_checkout_ambiguous_remote_branch_name)
> +                       advise(_("The argument '%s' matched more than one=
 remote tracking branch.\n"

You could drop "The argument" prefix, without hurting the meaning at
all, in order to gain a bit more horizontal space for the '%s'
interpolation. (Not worth a re-roll.)

> +                                "We found %d remotes with a reference th=
at matched. So we fell back\n"
> +                                "on trying to resolve the argument as a =
path, but failed there too!\n"
> +                                "\n"
> +                                "If you meant to check out a remote trac=
king branch on e.g. 'origin'\n"
> +                                "you can do so by fully-qualifying the n=
ame with the --track option:\n"
> +                                "\n"
> +                                "    git checkout --track origin/<name>"=
),
> +                              argv[0],
> +                              dwim_remotes_matched);
