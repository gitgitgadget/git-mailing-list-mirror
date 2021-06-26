Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A033C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 18:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EA8619D1
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFZSKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhFZSKw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 14:10:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D24C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 11:08:29 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so15699539oiv.1
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydigFvYTUTMPMaOXr/bitPnHmspOOPtClCqplZzFXJk=;
        b=i2ER9oz4BiN/nZgxNQDR78KXiinuBgRP1B+5urPTsIYQ+VeLfL/fit4dSsbDs3ikoD
         LA7L/WQpqExPTdAlzFuG5zNc1lFo7iDPJMWzbRk3uii1If1vxJs+cz9rDLQ2b1W4NJyM
         mVlI3ozZxHwCCYLU27GlZkSLwVxxIVX3/XKf1Dnc7zHYaRyUri8Zf15TLJ8ABG95ed8H
         ruLDVZ5//07WnRkrAsI2U5os2bU5kMlQ9HUzJHMJesDzWxdd7VFWXXEjCS7uz1G2tK2f
         EqXEVNdv3FjoqTQv9dQYGtHpZLRGxQsbFicaVJpTT5XE8vZNN87UVbqh3S0/er/Qk8/3
         7pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydigFvYTUTMPMaOXr/bitPnHmspOOPtClCqplZzFXJk=;
        b=fc1edUvM/pJePovqwiL6OyjP8UMkkCZdj6+k6awNa5zSb92P+UdNG0wQVmVJZ29MNi
         jIgGRmJKbwCz9zvvv22TJcjdp8KrNGxvU+QRX4/ngObagiwW2OshI0+RYqbf+k9KThqm
         uxxbKbx8Tfjp5ODdSEYZ0j9a2RDPAHyLNKuQswDT6XyWzz16ng5RTLu+Erzzmt9D89L5
         5fYT8LTs0cR+d+rKyKvKoxKIvnxp2112oynOsOmGtG1SYiAHpRxZsPWtEh9rFz8YRUtR
         q3eT74vWeqdenI1l733K76th5LDATqP+XoGL4sHsRh0rTdbcRuoXJqAhNJfNl+PBy1hX
         L3BQ==
X-Gm-Message-State: AOAM5333jOU+jxN5luLXRMpmVfoWKVYiHYXcFE5M4LdOPL8dvGkiOFel
        NO8m2nEhBMmGB42VgxueZI/wXnOeVPP066mV45c=
X-Google-Smtp-Source: ABdhPJz3uKQVYCz8LT7nBLEM0RU27G9LWzLzfvHhWNjzYyr75oePBDHWhGgRP/eg/FbiH4PFZmHWY/yfpM276UsEqkM=
X-Received: by 2002:aca:4c03:: with SMTP id z3mr2102885oia.105.1624730908350;
 Sat, 26 Jun 2021 11:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
 <pull.980.v5.git.1624636945.gitgitgadget@gmail.com> <370101ba65f0989487360366f8b83144a6641a04.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <370101ba65f0989487360366f8b83144a6641a04.1624636945.git.gitgitgadget@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 26 Jun 2021 23:38:17 +0530
Message-ID: <CA+CkUQ9XR4TjEea0Z4pHBeOdQi7fuTLPtzi01JdTKSS38=4CMg@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 9:32 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
>  static void batch_object_write(const char *obj_name,
>                                struct strbuf *scratch,
>                                struct batch_options *opt,
>                                struct expand_data *data)
>  {
> -       if (!data->skip_object_info &&
> -           oid_object_info_extended(the_repository, &data->oid, &data->info,
> -                                    OBJECT_INFO_LOOKUP_REPLACE) < 0) {
> -               printf("%s missing\n",
> -                      obj_name ? obj_name : oid_to_hex(&data->oid));
> -               fflush(stdout);
> -               return;
> -       }
> +       int ret = 0;

No need to initialize `ret` with 0. Later we are going to assign it
with the return value of `format_ref_array_item()` anyway.

> +       struct strbuf err = STRBUF_INIT;
> +       struct ref_array_item item = { data->oid, data->rest };
>
>         strbuf_reset(scratch);
> -       strbuf_expand(scratch, opt->format, expand_format, data);
> -       strbuf_addch(scratch, '\n');
> -       batch_write(opt, scratch->buf, scratch->len);
>
> -       if (opt->print_contents) {
> -               print_object_or_die(opt, data);
> -               batch_write(opt, "\n", 1);
> +       ret = format_ref_array_item(&item, &opt->format, scratch, &err);

Here.

-- 
Hariom
