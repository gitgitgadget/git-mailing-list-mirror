Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2901F404
	for <e@80x24.org>; Thu, 15 Mar 2018 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCOVBX (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 17:01:23 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:37399 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeCOVBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 17:01:22 -0400
Received: by mail-qt0-f173.google.com with SMTP id a23so8787432qtm.4
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qNxvgQnDZX+QsCIqI/WGedjRCqs+sqRgX3p24sIUBaY=;
        b=aBNtTrXSvfS6T6v3epJvTgYz5t2q3ApPszPQtenN5s0+tZjk+UGUDPIKchLvSuwQxK
         BgHNe32bzJ1CoF4A09A675UWKhGosFpXZyAWyAApfxZUFLFJQbDsu00ZAwJQUA7EsK45
         Rb6ERJ5Qq1yyS5l/bYMidz3t+IGFiLYY9y6tVrGa6gN6hDiDQS/2MP6je2ih3YN2vhLq
         G1BGGmbT1NhbPw9JkqgYmLWlE5e8rnIPHkXonkEtAi+li8eT5uuU2N8rAlnwSLsWCvuX
         ODh03I/85UAOEpTn9f4RrqNXwUJF6xVm9XEXcmWwDu6+SXjDO77+duOia158XgtYq/zh
         wJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qNxvgQnDZX+QsCIqI/WGedjRCqs+sqRgX3p24sIUBaY=;
        b=iUtrcYqT7iJyxRTO82WMhjz77MXxTqyL+Tox+vwAUupWO0KjZpdBNS0SK886KnGgEX
         EmDCxIC1GuZW5KSfiVNalTKr7rO5vkyJVEWfwftBFmtCCLAQC5tTx2DksuuUjZACayoi
         k14+SUatAMd//NaKBUMLMazWEm9OiMlWrBO4vkC77hlAgrNuJrh1x2GlrXbxHiJNdnvj
         h9I0YKU58PwFFS3hNNzP0dHQxDhngAhMVDyZE1TBASUNeDRD1/Ok09DYhb+/dYscI2wc
         lpnamYCT3zTz+IWpO+HvpRe9pg7M4CW4N8PrCTVBt6ywUnZ1ZscH851Evg3MVaud/KLF
         uDFw==
X-Gm-Message-State: AElRT7EFu5WGhR7QbCZ0PxTerJgYFXOtKZGP4jQ/1dknrvM2yaQaPEHb
        cpWel1RhAH4ZLZMLELnkWeKDcUKuFw8aEmwlykY=
X-Google-Smtp-Source: AG47ELtVFIQEIC0ML1rmS6Xq2DKd6Z0LVNyKjbjHex7EVv+xFGKnHsczp0/0u1kfd6t/Y95Bf7xZxbBJfwFPoJEJVOg=
X-Received: by 10.200.50.174 with SMTP id z43mr14871062qta.250.1521147681310;
 Thu, 15 Mar 2018 14:01:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Thu, 15 Mar 2018 14:01:20 -0700 (PDT)
In-Reply-To: <20180315204709.1900787-1-martin.agren@gmail.com>
References: <0102016225e61cc2-0d0c05ef-b999-4bf2-88ac-db9840dd2a87-000000@eu-west-1.amazonses.com>
 <20180315204709.1900787-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Mar 2018 17:01:20 -0400
X-Google-Sender-Auth: MYDXfcZ1gNSC1qobtHtipENCH0A
Message-ID: <CAPig+cRbsDTTfbeQS5tXCCoDKvf2pXAe_suGs-yHY_qj=Go_1A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ref-filter: get_ref_atom_value() error handling
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 4:47 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> These are "real" errors and yield several more changes in the remainder.
> Ignoring those BUG-type messages at the beginning of this patch would
> give a patch like the one below.
>
> +static int get_object(struct ref_array_item *ref, const struct object_id=
 *oid,
> +                      int deref, struct object **obj, struct strbuf *err=
)
>  {
>         void *buf =3D get_obj(oid, obj, &size, &eaten);
> -       if (!buf)
> -               die(_("missing object %s for %s"),
> -                   oid_to_hex(oid), ref->refname);
> -       if (!*obj)
> -               die(_("parse_object_buffer failed on %s for %s"),
> -                   oid_to_hex(oid), ref->refname);
> -
> +       if (!buf) {
> +               strbuf_addf(err, _("missing object %s for %s"), oid_to_he=
x(oid),
> +                           ref->refname);
> +               return -1;
> +       }
> +       if (!*obj) {
> +               strbuf_addf(err, _("parse_object_buffer failed on %s for =
%s"),
> +                           oid_to_hex(oid), ref->refname);
> +               return -1;

Doesn't this leak 'buf'?

> +       }
>         grab_values(ref->value, deref, *obj, buf, size);
>         if (!eaten)
>                 free(buf);
> +       return 0;
>  }
