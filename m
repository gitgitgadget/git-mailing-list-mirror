Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60242C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A35260041
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 09:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhKNJz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 04:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKNJzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 04:55:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284ACC061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 01:52:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t18so38141084edd.8
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 01:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sg80WX81iy5rW3O6HqfpI/mo/ZB4yDSlQLpD56Fz2zk=;
        b=Y2lpmlhhNsxjzwCg5v7jGvah2fS+VqOj5GS9XEHz9eXcB26AsFtC5FbcD9Nc0etIyN
         GIbfKt1uSZwV8pkJrjCh3S4lEyV8n3Stv6IFrtuET23Xebgg0bXNMCXWXUMe7ukbv8s8
         SWJNkPTv+0d+udAxfvXmy6AYjRUF2U6ESgR5m1Cicl3+8ACvqAMOJUojtlar6eKY7TOR
         mpWIUJjbnjOjt3PcWKk+jE4j828f68uLGRASTFfJrVijEHzBz3PSiN3OojPmbanYll3r
         i6s4JR+gFv72XlHtuj8Rd6IsnPx6oaaEE4Z34wsiybZdLaKtNRAyQyDR3Lnc4vCS4KJT
         WK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sg80WX81iy5rW3O6HqfpI/mo/ZB4yDSlQLpD56Fz2zk=;
        b=jD+gfn2LTb6YdqbI/G9MoD2Uw+NYd60td96IxzRNFKt0eHOepUgStE0A/6qQ/uUHeM
         Cwp4F30ax+sYQoAkLrgOau7DOAGn7B2efJj9bwXC+b6BRRTPa4E+PTnsIcoYxeXtTYZM
         3A1ekBtGHbPOxrcFIIbvAV3Ps+AL+H5QRGnrDyDycTzhbm0RN79rFnSPrErfqyhWlGtT
         E72BAhwKI4MbU1LO+m0GeQ5Qx0Tu12EV5xv03HfKg+oG/FxAo5fbE4/3bzuTeujZeGFj
         jyHJwWY09ySylm2Sp3Tiol6O3MOjLHbispkq4FWXV2ULLUS4DORJ3c2lj8XJglQC7E7s
         1ZvQ==
X-Gm-Message-State: AOAM532/k0GsufjcxdXc8X+I4fWLia0AEkc1XQ+9gEOgu9mkldQ1QfmJ
        3qiZYOYrOsCRdzABiFNa/92AyUzDFBw=
X-Google-Smtp-Source: ABdhPJz1k/oc/lnbCkYMFAtDZqejmlMp0K0gQLcOyjZCgkDzADtLav9LnkuIAbqggcgki/YjUp1J1g==
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr41849556edc.328.1636883550533;
        Sun, 14 Nov 2021 01:52:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id de37sm4832782ejc.60.2021.11.14.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 01:52:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmCBZ-000h7o-IV;
        Sun, 14 Nov 2021 10:52:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean?= =?utf-8?Q?-No=C3=ABl?= Avila 
        <jn.avila@free.fr>, Daniel Santos <hello@brighterdan.com>
Subject: Re: [PATCH] fetch-pack: add TRANSLATORS notice for packfile ready
 messages
Date:   Sun, 14 Nov 2021 10:50:58 +0100
References: <20211114073143.84004-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211114073143.84004-1-bagasdotme@gmail.com>
Message-ID: <211114.86czn3t676.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 14 2021, Bagas Sanjaya wrote:

> Two messages mention "... to be sent after 'ready'". The 'ready' string,
> however, is actually in part of packet stream, which shouldn't be
> translated. Because of lack of any notices, l10n teams treat it as
> ordinary string, which results to inconsistency across teams. That is,
> in `po/es.po` the string is translated:
>
> ```
> msgid "expected packfile to be sent after 'ready'"
> msgstr "se esperaba que el packfile fuera enviado luego del 'listo'"
>
> msgid "expected no other sections to be sent after no 'ready'"
> msgstr "se esperaba que ninguna otra secci=C3=B3n fuera enviada luego del=
 'listo'"
> ```
>
> whereas in `po/fr.po` and `po/de.po`, the string isn't translated:
>
> ```
> msgid "expected packfile to be sent after 'ready'"
> msgstr "fichier paquet attendu =C3=A0 envoyer apr=C3=A8s 'ready'"
>
> msgid "expected no other sections to be sent after no 'ready'"
> msgstr "aucune autre section attendue =C3=A0 envoyer apr=C3=A8s absence d=
e 'ready'"
> ```
>
> ```
> msgid "expected packfile to be sent after 'ready'"
> msgstr "Erwartete Versand einer Packdatei nach 'ready'."
>
> msgid "expected no other sections to be sent after no 'ready'"
> msgstr "Erwartete keinen Versand einer anderen Sektion ohne 'ready'."
> ```
>
> To avoid confusions, add TRANSLATORS notice.

Let's not and:

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  fetch-pack.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index a9604f35a3..0cda8fc518 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1410,8 +1410,12 @@ static int process_ack(struct fetch_negotiator *ne=
gotiator,
>  	 * otherwise.
>  	 */
>  	if (*received_ready && reader->status !=3D PACKET_READ_DELIM)
> +		/* TRANSLATORS: 'ready' string is in part of packet stream.
> +		   Leave it as is. */
>  		die(_("expected packfile to be sent after 'ready'"));
>  	if (!*received_ready && reader->status !=3D PACKET_READ_FLUSH)
> +		/* TRANSLATORS: 'ready' string is in part of packet stream.
> +		   Leave it as is. */
>
>  		die(_("expected no other sections to be sent after no 'ready'"));

If something isn't meant to be translated do this instead:

    die(_("expected no other sections to be sent after no '%s"), "ready");

I.e. pass it as a parameter.

There can then be a "TRANSLATORS" comment that explains that it's the
string "ready", in reference to that protocol keyword. We do it that way
in various other places, and it completely avoids the potential problem
of a should not be translated string being translated.
