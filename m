Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8281FC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60368613DC
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 08:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFCIQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:16:02 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41728 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCIQC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 04:16:02 -0400
Received: by mail-ed1-f52.google.com with SMTP id g18so4072649edq.8
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=A0n+p3K96G2J/bdRxz2h5YatncUnyTIbtKFGv0a/90U=;
        b=Ff+dlIMeQwsROPHsxc+XCEUI3UJTina9DgvmhEcdre5k3Rk5eksAZNnFp6RpJ7s0kO
         WP/q/wtsSWQD5lYBdpPUADZiFfuRXZohYNyheyFv1oIwSRzx6sgtuN33yEBEHFSYKBGt
         AvWaNE5WsXONBFA24UTU1d5oanMtBYpR95EjQm50Hc48Xv/LGRAVJizbuVi3tzT1xJCL
         S+asqAgmvwgssbQfS8Q3ailxIXvsmrq9lWb4qssApnDQA2SH38Rw2nlb4Zp1WKOkM1Ec
         CEAPuxlA90BD0b1O9Z+lrS+thvXbUR129EhrUmqei4YODwRvCBwAW5NwuyiRCQVfpSp+
         aBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=A0n+p3K96G2J/bdRxz2h5YatncUnyTIbtKFGv0a/90U=;
        b=VNJ0isqCgmYv62epKsprHBeTHPfvcivBAaytSfFkZvfCb2NdexAPR+bqfG8ScLtV4Q
         kDBQRZ8l3goxB2PmVPAshH6YebI48fgsGJlxNrojwh67hswNtS/NZSHdwzEEQBI95qcJ
         fvY7J2+MgN57ZvY4LDS72elhdedayA+vpGQcebZ0mJN961SSyuSh/IaTXNrUaE5N/3pg
         YnI+52K9+5jEqZsbdWKWLX9dohCXRBmIRnl0qi4zL6By5p/C07h2F/8vM/NCTVlcSJTa
         LcQmFyJU27z7OX5jmdQyzParYWBphTNRTA+DkeKS1DMzqqJs3EWtu/uwIc/lXgJnLcVb
         uB4Q==
X-Gm-Message-State: AOAM5331xDkFh4HuNQNaVH9UlCmAzHmmebqNox6E2ZFQhQqdHNRv80Qd
        PBIHz7Wn2rKM36dghfhiRJs=
X-Google-Smtp-Source: ABdhPJyfCwwkWT7dabxqmclPp3L1+DDRJw7kuQaqunGF9RCP1RH9+smVYIq1ILEj4tYSHdeS+DNm+Q==
X-Received: by 2002:aa7:c5c6:: with SMTP id h6mr42938672eds.127.1622707985467;
        Thu, 03 Jun 2021 01:13:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bd3sm1368735edb.34.2021.06.03.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 01:13:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Date:   Thu, 03 Jun 2021 10:03:25 +0200
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev> <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLcFU+ORZTzAsyBy@danh.dev> <60b70eb930614_4abd208ad@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b70eb930614_4abd208ad@natae.notmuch>
Message-ID: <87eedj74dr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 01 2021, Felipe Contreras wrote:

> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
>> On 2021-06-01 05:48:41-0500, Felipe Contreras <felipe.contreras@gmail.co=
m> wrote:
>> > > How about alias? It's part of my muscle memory.
>> >=20
>> > No aliases.
>> >=20
>> > If a new user doesn't have them, neither should you.
>> >=20
>> > All VCSs have default aliases, and I advocated for git to do the same
>> > [1], but it wasn't accepted.
>> >=20
>> > The whole point is to suffer like them.
>>=20
>> Get back to the alias topic.
>> I also agree with other people's opinion in that thread.
>> IOW, I support the decision to not accept those default alias ;)
>
> Why?
>
>> It's not required to be different people to have alias defined to
>> different command. I have alias conditionally defined to different
>> command based on git-dir. For example, I had ci alias to "commit" by
>> default, and "commit -s" on other repositories.
>
> So? They would still work.
>
>> So, Git decides alias for me will not only break my current alias, but
>> also break my conditional alias.
>
> No it wouldn't. They are *default* aliases, not overriding aliases. They
> would be used only if you haven't set the same alias yourself.
>
> Try it.
>
> --- a/alias.c
> +++ b/alias.c
> @@ -28,13 +28,27 @@ static int config_alias_cb(const char *key, const cha=
r *value, void *d)
>         return 0;
>  }
>=20=20
> +struct config_alias_data default_aliases[] =3D {
> +       { "co", "checkout" },
> +       { "ci", "checkout" },
> +       { "rb", "rebase" },
> +       { "st", "status" },
> +};
> +
>  char *alias_lookup(const char *alias)
>  {
>         struct config_alias_data data =3D { alias, NULL };
> +       int i;
>=20=20
>         read_early_config(config_alias_cb, &data);
> +       if (data.v)
> +               return data.v;
> +       for (i =3D 0; i < ARRAY_SIZE(default_aliases); i++) {
> +               if (!strcmp(alias, default_aliases[i].alias))
> +                       return xstrdup(default_aliases[i].v);
> +       }
>=20=20
> -       return data.v;
> +       return NULL;
>  }
>=20=20
>  void list_aliases(struct string_list *list)
>
>
>> Anyway, remotes/branches are all configuration values.
>> Would you prefer:
>
> I meant global configurations. If it's a per-repository setting surely
> it wouldn't be something amenable for the Git project to set as default.

I agree with this batteries included sentiment, but would very much like
to not see this as hardcoding of ours, but us shipping optional config
files to be included.

We could then just extend the include syntax rather easily to include
"libraries", which would be like the current include.path, but would
understand a library:: prefix (better name bikeshedding welcome). We'd
then just ship these in /usr/share/git-core/config/includes or whatever,
e.g. /usr/share/git-core/config/includes/aliases/svn-like.cfg

Part of that goes against what I was arguing for in [1], but I suppose
if that's a problem we could always optionally compile these in (in
Go-like fashion), while retaining the semantics.

The advantage of doing that is that you don't have to bless one set of
aliases, e.g. you could have cvs-like.cfg, svn-like.cfg etc.

1. https://lore.kernel.org/git/87czvoowg2.fsf@evledraar.gmail.com/
