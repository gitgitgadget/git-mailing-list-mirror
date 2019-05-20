Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0951F462
	for <e@80x24.org>; Mon, 20 May 2019 16:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfETQn2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 12:43:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:40469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388804AbfETQn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 12:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558370604;
        bh=W7f/lFzD94WLi5fUjHyqf5TPEqhtxS37egaIVZHayhA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ph6D0/YE/6y3T9ZR2gI3sopl5uD3Hq7fsdzXyYaqNt/gxTng+IVMJ4r9xjdC51D8a
         MZ2s7Aogwdmgn8/M6b19ku7+pvhKmGL+huaHtlW+WPip/jRpJ8uflsdsQ+3zpifZPK
         5WcXuihB1fZw2/p+aNKjtGpigBtl2sXccfcPMKas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSMw7-1h4FRA34xf-00TWm4; Mon, 20
 May 2019 18:43:23 +0200
Date:   Mon, 20 May 2019 18:43:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] transport_anonymize_url(): support retaining
 username
In-Reply-To: <20190519051031.GA19434@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905201836380.46@tvgsbejvaqbjf.bet>
References: <20190519050724.GA26179@sigill.intra.peff.net> <20190519051031.GA19434@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9NwMWMSxNaEEJStDF6uuRcov7NgF9zX/w7aBPAUWPi+81rDhbQ9
 /kHTcmnLw9Ja1PEDsL3MgmD51Ycv8UIfzzgQuEKRhWi30jgsQ5BaUN0eo9XAa77SPGuakY5
 kTcHdRr/R5EnYtZRbBpAzpUXGXB8fMmmAemkXsZJhJvljYGWmwL/wnspTrox363tjQPZcy+
 5Byh3cuZk79CmBPvMczyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BDJBP5n1zWM=:5FyO+dsSvwl4NMY71Cfhow
 dB0Q+xTPWa4KkAnbKJo4E3Rs6yz2ZhW8t8I9kFbFtaebQwGNK5XR0RI9MvpNu0vsrtOKqm3VS
 UjTTxEZwGHeIUlX8zzrUA8EY/VAAOty6QgLbtsTzBxOj0E97h72qhzdtAzAxTsuWkj4yFqCuU
 HXpXNtdJ6wxY0OfGSS1nxnU7taaiyah4aCG6fQ83lds+9GbGB0PYAkhcKkEp53yT2lTKA0B7j
 HRZZrDTdlqpwdKmcVrYpxzmVBQNBZM5e47Ot1AKzFPbdBqoMjC4kLUM0B3F8PaG2LzqFTDWlY
 EdtEpa/OdFZhT69sC/iZaPKLGunKqTv9p825ZOL7yCNZNoCB0gEamA7R125xqttBxFBZ1gfw3
 kiByhPlbhDGdNAb8jBV1F/38EV1cR6JEzrA1dHXq06B0HTM0Puk4bTEwu3Kqr5WuEw0IuECcH
 1e4t/wwIPG51Ci80N94JOwLbXYSGYwy1wQiFcdwLd4HTJfQ1cr+6D2QbjzW+1szK1T1YWJb5Y
 YIhtefq4rhSCMnLjaq07uuKJv6H5OFrlG2O4Sku4fKlWtSneDx8rT5EZKzp0qir6vB5RyPc8R
 oKhwW63G9mcxpjSm6fL18N+dLEbWIQ3vD/hmlS/4xqB02gDrk0oPOLSs7JxBe3QsMUfNGCBDN
 C4TUOOWaqWAbAdNLJDyZjyWjwKW2dO44DDFBpLfU7fOmXNys+XN2EGmb33xRv+ZAE9pJd7dRZ
 UF7CvgQqXsHRSBscht163Z29By1eyYq4nUeewCJaCZlVYimZ8ItI6Od53U+Xt/gDIuvGrW8dQ
 m1KoF+hSQJKm1rnDlURe02RO6ufNhx0/aprlLpzifQ3C9BgG/ZoKxpDroq0OIE5hPO7pPt5x8
 Pf0MFWEHi0uQ19KbI5m3jB2vy4ayqKxLFNXzw9cUzjGSek2evBB9tohZ0pUA7S1KCxBSnE6cD
 HNDf9lDs9ky2VxaCy73PMcJUUUb4lKiORVrbwr+zz/i2tb2WR7E0W
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops. Meant to comment on this:

On Sun, 19 May 2019, Jeff King wrote:

> diff --git a/transport.c b/transport.c
> index f1fcd2c4b0..ba61e57295 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1335,11 +1335,7 @@ int transport_disconnect(struct transport *transp=
ort)
>  	return ret;
>  }
>
> -/*
> - * Strip username (and password) from a URL and return
> - * it in a newly allocated string.
> - */
> -char *transport_anonymize_url(const char *url)
> +char *transport_strip_url(const char *url, int strip_user)

It might make more sense to skip the "transport_" prefix here, and maybe
use a slightly more descriptive name? My current favorite would be
`strip_credentials_from_url(const char *url, int keep_user)`.

>  {
>  	char *scheme_prefix, *anon_part;
>  	size_t anon_len, prefix_len =3D 0;
> @@ -1348,7 +1344,10 @@ char *transport_anonymize_url(const char *url)
>  	if (url_is_local_not_ssh(url) || !anon_part)
>  		goto literal_copy;
>
> -	anon_len =3D strlen(++anon_part);
> +	anon_len =3D strlen(anon_part);
> +	if (strip_user)
> +		anon_part++;
> +
>  	scheme_prefix =3D strstr(url, "://");
>  	if (!scheme_prefix) {
>  		if (!strchr(anon_part, ':'))
> @@ -1373,7 +1372,15 @@ char *transport_anonymize_url(const char *url)
>  		cp =3D strchr(scheme_prefix + 3, '/');
>  		if (cp && cp < anon_part)
>  			goto literal_copy;
> -		prefix_len =3D scheme_prefix - url + 3;
> +
> +		if (strip_user)
> +			prefix_len =3D scheme_prefix - url + 3;
> +		else {
> +			cp =3D strchr(scheme_prefix + 3, ':');

How about `scheme_prefix +=3D 3;` (actually quite a bit earlier than here)=
,
followed by `memchr(scheme_prefix, ':', anon_part - scheme_prefix)`?

Ah, I see you just copied that part from above...

Thanks,
Dscho

> +			if (cp && cp > anon_part)
> +				goto literal_copy; /* username only */
> +			prefix_len =3D cp - url;
> +		}
>  	}
>  	return xstrfmt("%.*s%.*s", (int)prefix_len, url,
>  		       (int)anon_len, anon_part);
> diff --git a/transport.h b/transport.h
> index 06e06d3d89..6d8c99ac91 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -243,10 +243,19 @@ const struct ref *transport_get_remote_refs(struct=
 transport *transport,
>  int transport_fetch_refs(struct transport *transport, struct ref *refs)=
;
>  void transport_unlock_pack(struct transport *transport);
>  int transport_disconnect(struct transport *transport);
> -char *transport_anonymize_url(const char *url);
>  void transport_take_over(struct transport *transport,
>  			 struct child_process *child);
>
> +/*
> + * Strip password and optionally username from a URL and return
> + * it in a newly allocated string (even if nothing was stripped).
> + */
> +char *transport_strip_url(const char *url, int strip_username);
> +static inline char *transport_anonymize_url(const char *url)
> +{
> +	return transport_strip_url(url, 1);
> +}
> +
>  int transport_connect(struct transport *transport, const char *name,
>  		      const char *exec, int fd[2]);
>
> --
> 2.22.0.rc0.583.g23d90da2b3
>
>
