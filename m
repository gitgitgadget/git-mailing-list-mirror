Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE7431F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeGVKFu (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:05:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40877 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeGVKFu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:05:50 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so383760ita.5
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3h+y/DLWEymQPP9Ck8fdAHHN4xdyHbid88Fmy4E3Ng=;
        b=LwvvYtqbief+yRiSDlbH5U4wOeUCgr/A+gQeOpnAmtyndXzu8lkPXxWXk1R5iyQQ3k
         RWhTlq0c/Z5gwtw7lQxAo2ksjfCMXY2aQdVzgg+tg42nWUz62+QJ1y6o1h/GaX/UH37h
         c2lfaGC1PgSmB7v+ZEoHTEhXrZHirxoRFStySC4BjlyHkbFYrsbHJbnolY18KIVcSRaZ
         uh/0xnc/2kiu//pqxLFlIIP/7wBkJmVatwGBv9ifu9nJHAha0YG7DKKuFbwDeMw7wPHl
         VSDriJYKbBX3B/UJBEuMCKYXOHXcM4eiqaX0d+v4UfQrPouyE9SrmISIMCG5xQLjYhRS
         J19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3h+y/DLWEymQPP9Ck8fdAHHN4xdyHbid88Fmy4E3Ng=;
        b=oPVcVEg417+pADobp5zATDQvtfrM57VP5WbZTV66W1BPej/cXrjS2A7Tt3ngNKiruX
         0l90D1SxqxMrGG0EyafaDKDIMLWqHiPkR6up5MSY6+69pEtYZx2Kmrxz7mKscY8Nia5w
         m2Gx8VUHxbsRhsVDhUaElfyB+MYxMgohbhnAuMCKqN7MoSTBQUExcgzkQYetmV6GCmyq
         NZQegD4mV8r3LhVPdNQ1XTsMX+VnKfwH2I2ZoNBh1b7HccTJT8lfBlVyoc3/S3XUByB0
         vIpcopwMjBG1j8NQP8awBVEqNmoTAcdDiIxyM6agoQhxjOCm6zCG+T7u7EyB0A6ds29M
         KqMA==
X-Gm-Message-State: AOUpUlEDnS2WdtN28HiC6Lo8Hl+EjQpU/i9bFblJLlMDFp2UQHYoOKtL
        C2wn6Z/qXjQn1kS2nTjPQRhB/TNvKMgcrO1Yg9L7fg==
X-Google-Smtp-Source: AAOMgpe5DOWDZAWCuLp1IzGqYDFpdwOkyy0PaK1QVt+HVNGtyt+YUcxFS/GlTARiVECJMbFNAXDY3m4mwWjypMOkpGk=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr6631275itf.121.1532250588275;
 Sun, 22 Jul 2018 02:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180625193752.255319-1-jonathantanmy@google.com> <20180702223944.224755-1-jonathantanmy@google.com>
In-Reply-To: <20180702223944.224755-1-jonathantanmy@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Jul 2018 11:09:22 +0200
Message-ID: <CACsJy8A02Au1ROU3_B1EmPnAHaRSBDJKNr9UeBSn0D7g=o4mZA@mail.gmail.com>
Subject: Re: [PATCH v4] fetch-pack: support negotiation tip whitelist
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 12:41 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> +static void add_negotiation_tips(struct git_transport_options *smart_options)
> +{
> +       struct oid_array *oids = xcalloc(1, sizeof(*oids));
> +       int i;
> +
> +       for (i = 0; i < negotiation_tip.nr; i++) {
> +               const char *s = negotiation_tip.items[i].string;
> +               int old_nr;
> +               if (!has_glob_specials(s)) {
> +                       struct object_id oid;
> +                       if (get_oid(s, &oid))
> +                               die("%s is not a valid object", s);

Please _() this string and the warning() below

> +                       oid_array_append(oids, &oid);
> +                       continue;
> +               }
> +               old_nr = oids->nr;
> +               for_each_glob_ref(add_oid, s, oids);
> +               if (old_nr == oids->nr)
> +                       warning("Ignoring --negotiation-tip=%s because it does not match any refs",
> +                               s);
> +       }
> +       smart_options->negotiation_tips = oids;
> +}
> +
>  static struct transport *prepare_transport(struct remote *remote, int deepen)
>  {
>         struct transport *transport;
> @@ -1075,6 +1112,12 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
>                            filter_options.filter_spec);
>                 set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
>         }
> +       if (negotiation_tip.nr) {
> +               if (transport->smart_options)
> +                       add_negotiation_tips(transport->smart_options);
> +               else
> +                       warning("Ignoring --negotiation-tip because the protocol does not support it.");
> +       }
>         return transport;
>  }
-- 
Duy
