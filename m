Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1BC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A563A61154
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhDMUma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 16:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhDMUma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 16:42:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247BC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 13:42:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x7so17702360wrw.10
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aTeBZSUHKR9C1cDA5Fnj9Rt5HJG10zw5vtUF77goJKw=;
        b=vhjyy8TJTEohTZIUpyAi2i7uimEADbAIpncZojHgLdpMDRx13YsJiMl/vLPxtNXWAl
         ObTt1Ti3A6Hu7NjClszKL8iTAdD8ONOQAMqybVrnliL2nzQqGM2eoCMcUbHligGJnDf1
         4gsT7xxgvBVNLeaKpkJ8rX3lFicfbsHmYiAuAVP/blBqgb3Fji3lFhLI78YP5zrxm4jZ
         E4ZuLI68DyqmDTNF9SdMLhjXfg/a5RsI0ziZs+D4K2JoWgWonmIVX0Rofx8vOGvVa0c+
         BB5tj0qUzakhAic+mMvoFfFBBLimLEUvyNPUEQj0+ZuE9RtRoVfcFl6Oo1SFMzLfGk+Q
         bdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aTeBZSUHKR9C1cDA5Fnj9Rt5HJG10zw5vtUF77goJKw=;
        b=jY53HaqQAazf25HuPwVW+YmpyJ8O386ILrQARmXzRP9ORsB5dJdgFlrlkqAg+WUMm5
         AK+HY+Ndqn6oAt5so7XSA3/MHnX5kx4eX3RhcvXF50y6c0d9ad30KtsEnYBfOjYOJYWp
         kEB6jstg7zHB51nrWrZE8V8QBxAQtvhuIacNjlUldIxB8KaeGx+lDLYm4o8Y7YP1Adq9
         9IsvZ7SeqPjIKore05Yg08WurkIJ0WnVQLaBQrgeBfYu8RKHBOLMfAUZ1hR4BfTWqbkQ
         gfnmbcRKgNOg1QzT/B2tI8ETjvuOdG/yRyBaTH20wMeNzPgidS5v1WSbHgz1X7Mrwq2V
         beJg==
X-Gm-Message-State: AOAM532tsyfUnCP6uo8D2amw0cRh2f3r56n3C8u1aB2I2jP7gXsVMmRm
        pPFWgKy6KGm0voksosBcr5Y0WoBB7vImEQ==
X-Google-Smtp-Source: ABdhPJwB+GxR1yvWfAcAS9cyWYc65+jKun2jZEWutv5UxLWiY0JlRU9KOaKZF+cfVqu7hgaLj2Vtrg==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr2536305wrq.162.1618346528562;
        Tue, 13 Apr 2021 13:42:08 -0700 (PDT)
Received: from Inspiron (2a01cb04010c42008529471c2a12c435.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:8529:471c:2a12:c435])
        by smtp.gmail.com with ESMTPSA id u6sm3865529wml.23.2021.04.13.13.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:42:08 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC PATCH v1 00/13][GSoC] doc: (monospace) apply
 CodingGuidelines on a large-scale
In-Reply-To: <d2e78646-6735-2a27-735c-331de6411ca2@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
 <d2e78646-6735-2a27-735c-331de6411ca2@gmail.com>
Date:   Tue, 13 Apr 2021 22:42:06 +0200
Message-ID: <87h7k9hq75.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jean-No=C3=ABl,

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

> Le 09/04/2021 =C3=A0 06:02, Firmin Martin a =C3=A9crit=C2=A0:
>> This patch series aims to make the documentation fully compliant to the
>> CodingGuidelines regarding monospace font. After it, new contributors
>> who just want to change a little portion of the documention could just
>> look around how it has been done without being confused by the
>> inconsistency between the documentation and the CodingGuidelines.
>
>
> Thank you for tackling the task of formating the docu and directing to
> CodingGuidelines for some markup rules. It appears that the last rule
> about backticks is wrong with late Asciidoctor, for which backticks are
Thanks. As a new Git contributor, I used to think that we don't use asciido=
ctor,
until I see in Documentation/Makefile:

    ifdef USE_ASCIIDOCTOR
    ASCIIDOC =3D asciidoctor
    ...
    ASCIIDOC_EXTRA +=3D -acompat-mode -atabsize=3D8
    ...
    endif

So, we actually use both depending the variable USE_ASCIIDOCTOR.=20

> only a font switcher and no longer hold any semantic meaning. This means
> that double-hyphens may need escaping (see:
> https://asciidoctor.org/docs/migration/#migration-cheatsheet) when
> switching style and tools.

In the helpful link that you provide, it says that the "setext-style
(i.e., two-line) section title" enables compatibility mode.  As far as I
can tell, most man pages (git.*.txt) fall under this category, except
the most important one: user-manual.txt.  But this is in fact not
relevant, because the snippet above of the Makefile suggests that we
actually explicitly running asciidoctor in compatibility mode.

> One other rule worth adding would be that tabs are banned from asciidoc
> because they cannot always be matched with correct indentation.

I'm an absolute novice regarding AsciiDoc vs. Asciidoctor. But from the
user guide of AsciiDoc (https://asciidoc.org/userguide.html#_tabs), it says

    By default tab characters input files will translated to 8
    spaces. Tab expansion is set with the tabsize entry in the
    configuration file [miscellaneous] section and can be overridden in
    included files by setting a tabsize attribute in the include macro=E2=
=80=99s
    attribute list. For example:

    include::addendum.txt[tabsize=3D2] The tab size can also be set using
    the attribute command-line option, for example --attribute tabsize=3D4

... and we also explicitly set it to 8 spaces (see above). Could you
elaborate a bit on the matter ?

Thanks,

Firmin
