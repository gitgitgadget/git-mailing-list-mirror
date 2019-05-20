Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F421F462
	for <e@80x24.org>; Mon, 20 May 2019 16:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392552AbfETQO7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 12:14:59 -0400
Received: from mout.web.de ([212.227.15.14]:37241 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733050AbfETQO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 12:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558368891;
        bh=eZ0Ihyd2/Gjwk1+unaZvdozkMR0TiDwOO9LwRYnuR3k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Tfd+olQdmx2j7oBdVxDk6PFCLwGUdTYuwlWcFbtQ2lp81JQT4xoguvZQAFtj3YaF6
         zUSuVHOchKgQ9buhHYf6R5M0YF7YSczzIEi8kVOGjuD1Xp8s2vbYmVUvIIl3xSYxmW
         zxx+PTDcKrfYkJTqu4dXUDRnK6iZOXrHqYb5/jws=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.192]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MC6ZE-1hJzUh1Se8-008qCe; Mon, 20
 May 2019 18:14:51 +0200
Subject: Re: [PATCH 1/3] transport_anonymize_url(): support retaining username
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20190519050724.GA26179@sigill.intra.peff.net>
 <20190519051031.GA19434@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <29276251-0dd4-d22c-4479-7de52efc35b2@web.de>
Date:   Mon, 20 May 2019 18:14:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190519051031.GA19434@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IbE7Rd1ycICbgLDxCj2DO0/L84Sn19LPGlwEhrXIzBhVdJ8iCr3
 gIRxjFTDHT9KPFoOH8+5jcIe4BNhxhUT7FIfDAX9Gi2tlgQhQsbLoLG3MDh5FVgC1ev9uJu
 wuEBj9umXe2bsRdZyUrkVu973pSjxXHw9bzZOUEfqhCpoSDE4u0QR+dmx2ATH0bMItkYcLG
 tigOJSwFu8h1Aa/dZfC3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MqnXGuzeAFY=:ZYcAZtk+REV3lrkeqhuC1k
 HCM2G5pRWbsjledqb/9Cr7iEZEcj/Z2l3zA47EyhLs55X1fpeJn4MbDhGooxLPlG/oeS9ejfz
 8GZPKGCGqbabfxhFzO0Dnz4GFrvt7vYnN7VCZ0TXFz5njjtzHgwe5+rtBIIzApSNgv3olJyaw
 0EzjLh9QJyDa2OoAzKd9cNn+av3uOG86bLMPCOk1vM4q+CMfu0lSMYRURLuYyPz21MyyYh15W
 V5nXhJDkriaQ1xaLAlFv8ywlJtmD/6HYP6fjxcZj6kOUOO1hKBuut5IAcl7vApRPSwyEgUvdk
 2qBABaDs039VV18CMLCKgkgajm4kXlf7ZqU9EComYT4UJFLLMS/w71+rtDLeo5wDOI/bPiuMz
 K8Ivqv+2oZ8rQs5a4BP9S+2HnjquQSF9Lp+cdwe09ikqyOpoaYbzc4XTxOCHmv2CrTV1k2MpL
 0uXZIfRCIOPcmhh7/Xmh2yQIdnwXOYA9nh1L0MK0IA9zBdaJHz/Q8Ty3i/ueTXnEiDBibzbve
 8N2IYVMgstke6b5N7UncQYEPjA+ykxDa49igL2lQ8gzenT8f0POs32zdoeQY8LtIG5Cs6Tol3
 2xg4k0e9BwZzOg3m3LeGEW7/w77j0FJ6IDGXFlwLXa/Xz6sQVPueEhJXM1PYBxfVZZq+8/WpX
 F9P8chMgEXmlApQc2T0XuNe7CF2zQuPuGAgp4Gn/DqqGdyQDDgtMFC17lrA89ElBQ9DOg/UsK
 tqqMleWyHSaXxq5nL/xMeAtk2kYKwvc25ehSePBycE5KfuzGCchVJxlu7A/VmDCcbmHK6FUj+
 ynhSXi40o3epy34R8AO4EnkOnb/tWXovUm1swyw6Ky9lVy6sLMj470zwIuKu7EejgTsDsysON
 bLDt7rfVVXqSD5Gft4sUxoRpeh6ATgxCinHhq2P+S9O4Jt1/jMMjhDCjm1m2PK9S8pHeR2+dD
 xcMnrHrWElfoR78avwuVGdz7UngRK2/Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.05.19 um 07:10 schrieb Jeff King:
> diff --git a/transport.c b/transport.c
> index f1fcd2c4b0..ba61e57295 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1373,7 +1372,15 @@ char *transport_anonymize_url(const char *url)
>  		cp = strchr(scheme_prefix + 3, '/');
>  		if (cp && cp < anon_part)
>  			goto literal_copy;
> -		prefix_len = scheme_prefix - url + 3;
> +
> +		if (strip_user)
> +			prefix_len = scheme_prefix - url + 3;
> +		else {
> +			cp = strchr(scheme_prefix + 3, ':');
> +			if (cp && cp > anon_part)

Don't you mean this?

			if (!cp || cp > anon_part)

Or the search could stop at anon_part in the first place:

			assert(scheme_prefix + 3 < anon_part);
			cp = memchr(schema_prefix + 3, ':', anon_part - schema_prefix - 3);
			if (!cp)

That whole thing looks fragile.  I wonder if using the official regex
(https://tools.ietf.org/html/rfc3986#appendix-B) would make it easier
and more robust.

> +				goto literal_copy; /* username only */
> +			prefix_len = cp - url;

Anyway, you don't want cp == NULL here.

> +		}
>  	}
>  	return xstrfmt("%.*s%.*s", (int)prefix_len, url,
>  		       (int)anon_len, anon_part);
