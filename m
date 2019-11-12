Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35ED61F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKLTCR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 14:02:17 -0500
Received: from mout.web.de ([212.227.17.12]:54159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfKLTCR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 14:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573585331;
        bh=sLN1YNeoxicnOJuP7dY80OfvBuqs9vyrk0X4NHKm7Sw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qE6j2F5Mm2Bhsl/8wiuhXK8cfOSOwtgEKF/BZQU0jbioUlPnqOJVvmAvSGlQeINen
         p9cs33LrK/xis3g/KM55zmNDU4+37gidZqXraDrlCauuxQe7ZGHrQr2Z0EZrjf45LG
         1hxmpyZ7VCgalg6ZvjSfXhYZ63Np6YAUzTptrASE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxODe-1hoWW91s8w-016zxO; Tue, 12
 Nov 2019 20:02:11 +0100
Subject: Re: [PATCH v2 03/13] name-rev: use strbuf_strip_suffix() in
 get_rev_name()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191112103821.30265-4-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cb647cde-a7a5-a610-e17e-6cca5d88e10e@web.de>
Date:   Tue, 12 Nov 2019 20:02:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112103821.30265-4-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PvkF+ct3YmjrZ2ut7w8PnMRRKmQ8wHv99v1J7e2S2QlG3fay7sA
 vVWIvyRPtV9jLqf4Vxg+Erj/hBr34xdqirmtXtGKso7XN+it6sMLZyzJf/A0jKftCFq2Cw6
 nVDfhtMW8fvc7Cm72BUtI5ybq5dBLMyIzKHHPNC9WLM/OUcAg6ZZ8bFjJ05E+cnkZxdW8i1
 egTepxaMQwbK0/PD5FE8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KmTstQFE8gA=:l/NvrJwB6T7cnpugr/nfut
 mAgyF0nkjSiYau8pNHnBAaKcVm7PGiqjcz9YSwrDNSlN95v3FTN0Y9DzH3RdEw5z9vcpcdGs8
 qkVbdlpmWYjBgdhe5K7H7A53E0r4y7dNSTgJknpNKCDBXyoX49YcAiym62Ws0y9Usn81PKNED
 TKkTt21nYTC6FUSNfjnDqrf2m7EaqKXYf0HcK5+fAPi9hIIVuB+ijNUEXk/45Jd8zunD+R2yh
 Uay7+PRfVEOlFBrv8EMKwkMF+2cxyiGyylVQv/z0h+QQf5wt5x2Ug9oEKO3e9Vf53Lbuivg5L
 3cMoZTqSV7SB7j+afHWQczVlc7qV9hPwCFvfcdS7aBpV3rpg88BdnVyZzqarJODh7yzzNxDkg
 JJQ5pfBHndYNsxmjieGYgd2N28KTBsK2GXhrxCry4Jluh9SJ46bspRZpDnikKnZxRpHEoXpDA
 G4Rg3EGZIkRmY4NWhrRKrSTbVJWkDOzbPC9AbcNjuLGlMunhYSJbanU2Vn6kjKSe6fDfQ9V1R
 UPMtUwiqX1MA+DUMQXs7LvH8ngyaTdvr7mve9PQzR7rGD4TCG+AlSHj22RolfW++vlxQr0W7x
 P6ewHcn/GT8p6d/r1VKSkocGD5JDRypEBb/f+o4WtDsuZlOs52vhaZA/OBOahzMepdlDcEgOc
 7O2hcEQBqQJR9QzL2bZoaKcTNmxTpfIh2nRlAgtah0WT6NMj7uoDFKIWgj3n6PkPI/30x7ErA
 npM0rgakvTeHituJVobYFMH2+Nwwe0A/eoIaJhNnBNwZkgIoapSzfP0EItn9UBNjStTtJJKmR
 soaM+EYbYRp4sRQf0DY7Pmj56iPTLnvlt3HUBC8f8IbFNSkeGbYplaVnYumKcy7b9BApfqBdb
 TQ4mdwL97fQJRoyZH3P5IvYrHWg7tDnXgB6SG9BxIhUFw9/QLGvpkpQXw66WI0e8+f7exMMBn
 JeC2ua2ow+ujdVVH7al5dXp7m7l4jZyT7piZtRY94HTz2DdZcvBhW/r1xNhFnW9ReoKbGSDAX
 MFMqZW4+cvlb7LFc1UQRjHIUv0pNx5ContcKvuaRhBR0A+S1A/gaZEALPkw/4mYrurzdT0v4O
 U0Uvvd5/zgcgdPYO7wc/cQEM9xEfoKB+xPM+0e+9W15QQRqtYVyzHwtWAabKX76uCmh27okMs
 hR19KZAbpR3zl8Z7aVeM8Nfg+XYt+FxrVEVeGQo6a4nJ22yi6QV2MzJO8uqM78SXG5wmANF8n
 xZYwKqCef7uZP7L4W0dtyEenXpKTElwWYF0YBqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.19 um 11:38 schrieb SZEDER G=C3=A1bor:

Thanks for keeping the ball rolling, G=C3=A1bor!

> From: Ren=C3=A9 Scharfe <l.s.r@web.de>
>
> get_name_rev() basically open-codes strip_suffix() before adding a
> string to a strbuf.
>
> Let's use the strbuf right from the beginning, i.e. add the whole
> string to the strbuf and then use strbuf_strip_suffix(), making the
> code more idiomatic.
>
> [TODO: Ren=C3=A9's signoff!]

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index b0f0776947..15919adbdb 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -321,11 +321,10 @@ static const char *get_rev_name(const struct objec=
t *o, struct strbuf *buf)
>  	if (!n->generation)
>  		return n->tip_name;
>  	else {
> -		int len =3D strlen(n->tip_name);
> -		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
> -			len -=3D 2;
>  		strbuf_reset(buf);
> -		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
> +		strbuf_addstr(buf, n->tip_name);
> +		strbuf_strip_suffix(buf, "^0");
> +		strbuf_addf(buf, "~%d", n->generation);
>  		return buf->buf;
>  	}
>  }
>
