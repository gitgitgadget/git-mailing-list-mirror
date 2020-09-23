Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E2C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A933920725
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RLPqqS51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIWUh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:37:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:39355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWUh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 16:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600893471;
        bh=h/OmQIBlorAPGtlZNVUCQ0Pd7qSCGH+jZvst7eBThgI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RLPqqS51eG8mfx9VkVV4VlABSz2CCKLMBMcSJeP6mF5L1GYHglBfv82GOC7h2ANIA
         pkJ3Rm6fAwnpEPkO1KZH/PQZfTVcyW59yThhCNuY927zUb+vtTLyodDqHAcALbSr3I
         7i5kEkHneQo8lsu7Pql4K+KydFM3sds7OSfZHrNk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1kn3Dw3uOY-00pJsk; Wed, 23
 Sep 2020 22:37:51 +0200
Date:   Wed, 23 Sep 2020 22:37:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
In-Reply-To: <20200923170915.21748-1-chriscool@tuxfamily.org>
Message-ID: <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet>
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BbIi899Xlo/5UmYBpAj9Qq+byq58z0GgoPCWDOMPwXuYU6/Jxyb
 0c8GnURHwpSwWw/1gMxPFA7MSN58nlEdMGWqSyvcKO7PUma0AXMjwbmL6cxE+o7JxEN0Axv
 /vwa0MJvzMjM/TE7gzRSuHRtJL7664w/xU0wknst3/Sv+zF5j3/De1rkQPjDkjEbo7jwqmg
 FsKSC7CXkNDO3uD/ev7XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jIIpl28FExo=:tm18X58m/8ZAB/oIaHLJGe
 Rd2EvgipwDWd2b38Ng+obTGiwD2rzmyBtYyUns2BOwXqpWojab0CLTygGs261DPXxQSmszYhV
 UqZCRwSkRvdsG0ERehliXiA8nNOuKLDqZ7am9F71hej1qVm1VYym8MJzuzNqPdmXDDd5pDE+A
 j5irhoSNXDauM9/6hDysy9TM9dnsXHCNLPKBPoWPm3gK5oqoDf1XVVFEalp7F1sOKA+Eai15G
 ydeuEr1fpoxyjU34UVGz6h/YoZID/FjsPy2PL4Q154NB22q/wXcDvPINQjHADWkyyFgyBPSRW
 v8iFW+A/6Iph3PeVWUEhPd3ib9NK5CgQ/Y/RZM52whweZgj1WFAfeDjkhYXj/rUob1xs2raZ/
 cCuLmDzDwG0DPngggqI05+6eiYGtEJx0fAkmtazBLlMxiJxfLaWUla4n99m3EvK6wEiDgTD2h
 nsGb6wWXbt6OTucxeA6nlxDkNtZA9SiQGVgCCL6dJw1/C9cYb+lYHi9YbNUMibkqJA0tniCvk
 a3wFjzscKrYqlCQklTiWJ0Q9MFt5EqTLFpJzHsAjwLYBjuYc2UCQJj+4ZUbyuEo2QQjMq4KDY
 4ZlJ208a7jp0WOU0KsXHdJYLni2siHQPxROXS75TgV1aM4440AgDoRI1T52wGAZWMU3QYOMRc
 xleos2ypoDWou6+witDunfcc4rAvcpJ+Z9fpZFZ2v5gSxjdQWCUpqmXaKGqYNfrMF9oObqa4j
 ycjtR+vwZ2cgY5HOxTSqBoVY6igyF3+8r2FwD4CDx9HyNCa3Q4xtewXxE24cGAs4DMWMyxb+l
 2u/Lt6Ny+1/h1W0qwCYO15GFPiHPwc+Nb/lnSCaY4LgYOOo3wvZWTw4KsajREviiRrTTCw7cn
 MqSyuAqKz7QBITadt0IRRi9/dCT+rhrp5kUQ6iYK+Tjp5iUqL3nQJFjipK07qpyd2skipewHJ
 oWybGB63ts/yaBMJXoLHfBcsTS6YCS2bPdN1kLsqSmMD3KeMQnPLXLzQuUwy8pRsgt0MGqtlJ
 f5Ean8p1k5v/svwbVEthXofaKlnbdI9uvyoSouSn6wA68DK3kiYXTD7y9zX4HDHqaksi/gRTz
 redYje1epJGFs0Nb3LZdjdUbG6rv80wBgyiAj/V+KGoJvQ55sofEYq9SOjicE8UHnzp5g+8UF
 Ki1xGv5szbX2Oj9SUcnh0GRgGk8I1HK1AJaX5lX+6nQoMFgzRPqJCh70l6a6xWK8yDf2QZa9c
 2+g8nigwn8pBxEzl4A7PRIjOanYbKaFgVvNxoSw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Wed, 23 Sep 2020, Christian Couder wrote:

> In 06f5608c14 (bisect--helper: `bisect_start` shell function
> partially in C, 2019-01-02), we changed the following shell
> code:
>
> -                       rev=3D$(git rev-parse -q --verify "$arg^{commit}=
") || {
> -                               test $has_double_dash -eq 1 &&
> -                               die "$(eval_gettext "'\$arg' does not ap=
pear to be a valid revision")"
> -                               break
> -                       }
> -                       revs=3D"$revs $rev"
>
> into:
>
> +                       char *commit_id =3D xstrfmt("%s^{commit}", arg);
> +                       if (get_oid(commit_id, &oid) && has_double_dash)
> +                               die(_("'%s' does not appear to be a vali=
d "
> +                                     "revision"), arg);
> +
> +                       string_list_append(&revs, oid_to_hex(&oid));
> +                       free(commit_id);
>
> In case of an invalid "arg" when "has_double_dash" is false, the old
> code would "break" out of the argument loop.
>
> In the new C code though, `oid_to_hex(&oid)` is unconditonally
> appended to "revs". This is wrong first because "oid" is junk as
> `get_oid(commit_id, &oid)` failed and second because it doesn't break
> out of the argument loop.
>
> Not breaking out of the argument loop means that "arg" is then not
> treated as a path restriction (which is wrong).

Good catch!

> This is a bug fix for the bug Miriam talks about in:
>
> https://lore.kernel.org/git/20200923072740.20772-1-mirucam@gmail.com/
>
> and:
>
> https://lore.kernel.org/git/CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+=
WyqKiQQ@mail.gmail.com/

Thank you for clarifying.

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 7dcc1b5188..538fa6f16b 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -486,12 +486,16 @@ static int bisect_start(struct bisect_terms *terms=
, const char **argv, int argc)
>  			return error(_("unrecognized option: '%s'"), arg);
>  		} else {
>  			char *commit_id =3D xstrfmt("%s^{commit}", arg);
> -			if (get_oid(commit_id, &oid) && has_double_dash)
> -				die(_("'%s' does not appear to be a valid "
> -				      "revision"), arg);
> -
> -			string_list_append(&revs, oid_to_hex(&oid));
> +			int res =3D get_oid(commit_id, &oid);
>  			free(commit_id);
> +			if (res) {
> +				if (has_double_dash)
> +					die(_("'%s' does not appear to be a valid "
> +					      "revision"), arg);
> +				break;
> +			} else {
> +				string_list_append(&revs, oid_to_hex(&oid));
> +			}

I would find that a lot easier to read if it was reordered thusly:

			if (!get_oidf(&oid, "%s^{commit}", arg))
				string_list_append(&revs, oid_to_hex(&oid));
			else if (!has_double_dash)
				break;
			else
				die(_("'%s' does not appear to be a valid "
				      revision"), arg);

And it would actually probably make sense to replace the `get_oid()` by
`get_oid_committish()` in the first place.

>  		}
>  	}
>  	pathspec_pos =3D i;
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index b886529e59..cb645cf8c8 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk i=
nstead of revs' '
>  	git bisect bad $HASH4
>  '
>
> +test_expect_success 'bisect start without -- uses unknown stuff as path=
 restriction' '

s/stuff/arg/ maybe?

The rest of the patch looks good to me.

Thank you,
Dscho

> +	git bisect reset &&
> +	git bisect start foo bar &&
> +	grep foo ".git/BISECT_NAMES" &&
> +	grep bar ".git/BISECT_NAMES"
> +'
> +
>  test_expect_success 'bisect reset: back in the master branch' '
>  	git bisect reset &&
>  	echo "* master" > branch.expect &&
> --
> 2.28.0.587.g1c7fdf1d8b
>
>
