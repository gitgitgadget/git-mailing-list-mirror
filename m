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
	by dcvr.yhbt.net (Postfix) with ESMTP id 104B31F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfITQhS (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:37:18 -0400
Received: from mout.web.de ([212.227.15.14]:51011 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfITQhS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568997432;
        bh=gtjYqLr44oViADt8dKNO0U95ZV2u+RQ6YjgsRXC7ybo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BthHATrBhkkb7QeQIrt/sSwoicFjLIgf9I5cT3wMOgo+TbE1LSAgtVvQAQnyCZ3Nz
         Hs87IHKfM6NnvtfAl9SCHHfsBG6X4xbm5irJIwAJLOkql5PYzW87kgLkZhYpaWM1gt
         vSSvJW/sVESb+fSHQbf8HTV8FvDDyYg/x5KVBbaw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNcHy-1iIWu211L8-007HbC; Fri, 20
 Sep 2019 18:37:12 +0200
Subject: Re: [PATCH 03/15] name-rev: use strip_suffix() in get_rev_name()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-4-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bc885655-7b86-86b8-a653-5eecca56bfb2@web.de>
Date:   Fri, 20 Sep 2019 18:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-4-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3jSxkBJaZJ6W7YpTE5uCw35gAHr8D1zCZ/sqZHiPK4WaPnOJxV0
 X7fRVlIEsIOIH2I//VHr0SGSCx1bHPagXaFusFiw1XgqWTGKIAtngxmArmKze1PwTHjxbhn
 VhRIczUTI8HIHrSV4GGT4wKUoDvIk9Cjr7H70UBUj2IrY5LNJ1QvHOCwtjNMtUsG0INunYO
 ijoTLHn1SG/P+4I2SIdJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aiejmVAsroo=:gV2u/SBOLqQKqlpjxDVLP9
 PKBrhyMBFaOpOgoU73RNHqZi2gsvggqzJrQ927LMO/yMv9ZgHzD7mY/qpVnERrQLxue+kXsRF
 /C1qX9s/wAqmYzKOCQO7610mwy2k6NnY4+pPqiL+n+qcPockHzkh0v19kHy4zYxLd26CacbEc
 Iuwxi1sFT7GZt/QLxbgDHhocn6CEywgS9AaB/znbJjL6CTQgx2j3t4YHmJwIvlhOwAhNJ4o/Q
 sp19Nm2ZceqXZumQECWdqejIXBS7uKjHHbXtjxLjstvhLtY55QidAMwu+sQf9msXB8IVS6Pe6
 tZ0B9t/F7m/9feDxTj0nyVWg211HAIF8ijp9Bq5rWSuoCLC7m1Bp7cGH/0yMjfTRlgSG4mzqI
 lTnU7rd8uwmYFaH0+jZMYBP+VZHVFSQ7Do4lC2no1C7iOOzgw/fN+MWaqaXAa/sS1lK/YAvHL
 /Pu/dcKa/XILqft51+U3/4qJEFtnJFMK2epuLvzCzVEZ92Z2B2PxYwPDMkamvTsMTWy5iv9pD
 H7oEitJHEQPTYdp7cNC6zM6mvQ5zhNWr2hR23rIXd/MMhUiqtyWo4vRcgTEu5TMHqPX9hVl8k
 1qCIcuQ0rw+EpA1yDYwPGVv+KKXcHEVzEi/ay2NFvvutre3yIbl6PQamPNXsKH7JXSqwqLIUt
 oWEiOCVM04qQX1NaZdU/xtS2ISb+WvpaBWKq3jtBM5Mki/eBL6IpOyqKlB5WsXP2TxVxsojza
 pJgdnM1DiNCxFylv9Zdq6QVngmFNc5IuFm4KI5MgXlhe6ntuJtrUrPieFvZUw7J7ChR4z65zW
 4MWy37TUjA6HdYF8R7NBYtSIofTrsqbMsueLcRzSlRU6hmYKdjzQz7Xavmyni4ZkZeM1f5zoY
 tS3WGO99rRlZG8B9Pch/+tqNyDBeMAslPYogPgDQhOKQJ54xy58UIlN8oEU0NKtwyW2jvntXE
 X4q5UN1aoSrRJQnqTG4yN4Npr9FL5Ue26OHA6gdT3Zvp/ZttV844OBqMKTRNcK28NC59MXMw1
 AOTXecMfhtXWqLRo/z7NFauFVcjwjPs6NH9o06OlTrIs+PKg+WfuBKb0TMIHwq/6Y+EpLk34Z
 L/WIRXtUna4f5mZHztuYvKgGqyE90KNirKylzqZololqkE6laU03r6Ri58jc57r3g7FjoIesa
 QlzSXHBKu2KYs3JyBetaRJ0cmOBv8otJAQCMhoPgDwLXHsTmCyq8GwVOaUYGjlXhPGu9PKrHr
 9TSkeMjclSG/PdjrulPSwqhTQoK5yvR1K+03YWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.19 um 23:46 schrieb SZEDER G=C3=A1bor:
> Use strip_suffix() instead of open-coding it, making the code more
> idiomatic.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index c785fe16ba..d345456656 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -317,11 +317,11 @@ static const char *get_rev_name(const struct objec=
t *o, struct strbuf *buf)
>  	if (!n->generation)
>  		return n->tip_name;
>  	else {
> -		int len =3D strlen(n->tip_name);
> -		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
> -			len -=3D 2;
> +		size_t len;
> +		strip_suffix(n->tip_name, "^0", &len);
>  		strbuf_reset(buf);
> -		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
> +		strbuf_addf(buf, "%.*s~%d", (int) len, n->tip_name,
> +			    n->generation);
>  		return buf->buf;
>  	}
>  }
>

This gets rid of the repeated magic string length constant 2, which is
nice.  But why not go all the way to full strbuf-ness?  It's shorter,
looks less busy, and the extra two copied bytes shouldn't matter in a
measurable way.

	else {
		strbuf_reset(buf);
		strbuf_addstr(buf, n->tip_name);
		strbuf_strip_suffix(buf, "^0");
		strbuf_addf(buf, "~%d", n->generation);
		return buf->buf;
	}

