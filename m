Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFCC77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 07:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjEEHBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 03:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjEEHBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 03:01:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D241EAD20
        for <git@vger.kernel.org>; Fri,  5 May 2023 00:01:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so2395651a12.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683270067; x=1685862067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ITkO84isEDSVJaiiwzhxRpxp8C1wUirhcxm/D3pvGLE=;
        b=Ukl1XueY43yRCLb/9KR/qM7G/juMuQkn/R6FDqX5x3231PkV8+1SVbiGgMOa2j0d5a
         05FDpbvv8A2FPRNs+EQ/U3BBm1ZEdsSQTV8jrIkemlIrd6UP5xRWsu4qJUVyHqQkW/Xi
         dWjcV1/V1AnP6gBQETF8ZTm2kr58zGhnh+GXD8FuFX7ZORrCORwlQdFihtzSIKaw+DIn
         eMPnXvzgtOGun1K6w/H+0v82nCKbHb63INcCYr3K9Da2bhnoI3+q3ySWA4Q0Lerx7CT0
         5Mdxl7gygeIbSz913CnGKAJHRmSBlAiJ1ITP3VS5RQ8b19UTJDF2wrpMcnoX8ctMvmxj
         adHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683270067; x=1685862067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITkO84isEDSVJaiiwzhxRpxp8C1wUirhcxm/D3pvGLE=;
        b=QWEpKJxnvzgMwODmg66ds/ouNsDiCOlw/uNk2Vr1onUBUAf+gIN5YmU0qUU3Sr+5al
         qi59FTC4xSqBJJuW17caZ1URwvzAWZy0okBbhGO2JMJ7A06b1X6/1PBQ+cp3EoUliloV
         xKUpKFlp0KG+CCVKLvBhOPtHlRl6M94Pty6N11UzRo3SorNGIgyL1vYzCepL5ZOXmrlL
         jKaxHrzDoko5U/1cTYYqDWD3tpGJ+tl930Zi36hTPt0W53METdxCz03sNb/Fi1xoK1k0
         d4GFzBR6FLWaQ/8xQ0+PpL3v8NpBS5HUcUj/BmZwe/Qi/bsAntLbSO+iUX5KKkdIIh7c
         gV+w==
X-Gm-Message-State: AC+VfDyHQzul7PWvQaAntBTv60zN/byPWg+DsgPevg9RIlPlSU0q0iQi
        awlcdnSIMuUZed/KsTh7axh69aqdy6ym9HgKTmE=
X-Google-Smtp-Source: ACHHUZ7wngUDFm2jW6Um9WCOQSeLVm2L22liJS5iR8ejcVn8o5YC1laP1avV4C2369kC800+5qdbsybfMwmv0U0C/lw=
X-Received: by 2002:a17:907:7ea0:b0:953:457c:7977 with SMTP id
 qb32-20020a1709077ea000b00953457c7977mr302301ejc.38.1683270067046; Fri, 05
 May 2023 00:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1469.git.git.1678829531648.gitgitgadget@gmail.com>
 <pull.1469.v2.git.git.1679729764851.gitgitgadget@gmail.com> <xmqqjzxoj8mm.fsf@gitster.g>
In-Reply-To: <xmqqjzxoj8mm.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Fri, 5 May 2023 08:00:31 +0100
Message-ID: <CAGJzqsmL6AK8BsxJJzRRddcdep-F2szUAvE-2ep5KBsmUVnghw@mail.gmail.com>
Subject: Re: [PATCH v2] credential/libsecret: support password_expiry_utc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>,
        Matthieu Moy <git@matthieu-moy.fr>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 4 May 2023 at 18:42, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> We used to use the bog-standard "COMPAT_NETWORK" but now we are
> adding an extra element, and that makes it necessary to define our
> own?  OK.

Exactly.

>
> >  static char *make_label(struct credential *c)
> >  {
> >       if (c->port)
> > @@ -78,6 +93,9 @@ static GHashTable *make_attr_list(struct credential *c)
> >               g_hash_table_insert(al, "port", g_strdup_printf("%hu", c->port));
> >       if (c->path)
> >               g_hash_table_insert(al, "object", g_strdup(c->path));
> > +     if (c->password_expiry_utc)
> > +             g_hash_table_insert(al, "password_expiry_utc",
> > +                     g_strdup(c->password_expiry_utc));
> >
> >       return al;
> >  }
> > @@ -101,9 +119,11 @@ static int keyring_get(struct credential *c)
> >
> >       attributes = make_attr_list(c);
> >       items = secret_service_search_sync(service,
> > -                                        SECRET_SCHEMA_COMPAT_NETWORK,
> > +                                        &schema,
> >                                          attributes,
> > -                                        SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
> > +                                        SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK |
> > +                                        // for backwards compatibility
>
> No // comments please.

I'll amend in v3.

>
> > +                                        SECRET_SCHEMA_DONT_MATCH_NAME,
>
> SECRET_SCHEMA_DONT_MATCH_NAME does not seem to be listed as one of
> the flags to be used with secret_service_search_sync(),
>
>     https://www.manpagez.com/html/libsecret-1/libsecret-1-0.18.6/SecretService.php#secret-service-search-sync
>
> and the only reference to it I found was as a flag to be placed in
> the schema.
>
>     https://www.manpagez.com/html/libsecret-1/libsecret-1-0.18.6/migrating-schemas.php
>     https://www.manpagez.com/html/libsecret-1/libsecret-1-0.18.6/libsecret-SecretSchema.php
>
> But I'll take your word for it.

Good spot. I must have misread the docs. I shall fix in v3 and test
backwards compatibility carefully.

[1] https://gnome.pages.gitlab.gnome.org/libsecret/migrating-libgnome-keyring.html#working-with-schemas

>
> I found nothing unexpected or surprising in the rest of the patch to
> this file.  They all looked just a fallout of having to store and
> retrieve one extra item from the database together with many other
> things we already store and retrieve.  Cleanly written.

Thanks Junio for the review.

>
> > diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> > index 5ea8bc9f1dc..9ebf7eeae48 100644
> > --- a/t/lib-credential.sh
> > +++ b/t/lib-credential.sh
> > @@ -43,6 +43,7 @@ helper_test_clean() {
> >       reject $1 https example.com store-user
> >       reject $1 https example.com user1
> >       reject $1 https example.com user2
> > +     reject $1 https example.com user3
> >       reject $1 http path.tld user
> >       reject $1 https timeout.tld user
> >       reject $1 https sso.tld
> > @@ -298,6 +299,35 @@ helper_test_timeout() {
> >       '
> >  }
> >
> > +helper_test_password_expiry_utc() {
> > +     HELPER=$1
> > +
> > +     test_expect_success "helper ($HELPER) stores password_expiry_utc" '
> > +             check approve $HELPER <<-\EOF
> > +             protocol=https
> > +             host=example.com
> > +             username=user3
> > +             password=pass
> > +             password_expiry_utc=9999999999
> > +             EOF
> > +     '
> >
> > +     test_expect_success "helper ($HELPER) gets password_expiry_utc" '
> > +             check fill $HELPER <<-\EOF
> > +             protocol=https
> > +             host=example.com
> > +             username=user3
> > +             --
> > +             protocol=https
> > +             host=example.com
> > +             username=user3
> > +             password=pass
> > +             password_expiry_utc=9999999999
> > +             --
> > +             EOF
> > +     '
> > +}
> > +
>
> Is any random number usable for this test, or is there some
> constraints (like, "it cannot be too small to be a timestamp in the
> past, because the entry will be expired immediately")?  If there is
> some constraint like that, is it a good idea to also test that
> (like, "make sure an entry with expiry already happened is
> rejected")?

The date has to be in the future otherwise the credential will be
discarded by `credential approve` before it reaches the helper. That
logic is already tested in t/t0300-credentials.sh. There isn't any
expiry logic in the helper itself to test.

>
> Thanks.
>
