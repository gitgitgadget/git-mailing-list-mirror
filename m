Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08529C43457
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BD820FC3
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XI+sEFj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbgJLUjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:39:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:60165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387764AbgJLUjj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602535163;
        bh=LrSVSHQwbzvau8ZXjdWmgJb5y7hrUzr1Wgwjkmy0sxc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XI+sEFj+IhaT1WTS7um4kZNzpThPtJT/QibTrXonlh5+Ftmve0ar75Bxgv+1gY1DL
         Op/00vKsA0iJLJfk0c+5XJYfZo/MlBTO5oU0OBhsZecLFjII2uI11BVvbwWw2iygk1
         lRA4ENEgCBhL4gUl4EroqpwzSPGeWFgsGVa/K8Pc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1kKnwa3x8g-013cd8; Mon, 12
 Oct 2020 22:39:23 +0200
Date:   Mon, 12 Oct 2020 22:39:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching
 changes
In-Reply-To: <xmqqo8l7nrjc.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010122236130.50@tvgsbejvaqbjf.bet>
References: <20201001120606.25773-1-michal@isc.org> <20201012091751.19594-1-michal@isc.org> <20201012091751.19594-3-michal@isc.org> <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet> <xmqqo8l7nrjc.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-527273458-1602535163=:50"
X-Provags-ID: V03:K1:DIK9VXM2/iZnGq7epdNkvftBmhldwgqAYI0ohZp4SoF3aC+i4SW
 LwwuzH21Ly/IAF9GuMMjuMrzU6EZJnIARtFZYwWbsb5fOY46dKImtl+E58fnB93fq/rya6h
 Vo15ft63YBIl5LhyPM7YzMT+v3IFchjYeC7/UpDDi//k3beFXlRRVuu4rbI6/bocgSevK1f
 vYxjwWN2skG8L1KFoT4lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QkINS0v7IhI=:I0vJ7y28EbD4nhNH1E19N6
 RfHmPYoazTPxAA75oIYfo/s+O12t40JQSsmR2OaxwvYMGjh9cwhxxbkFx7S4oTopPVB4g3urf
 agRs5tbjRbe2GC6kdzfZwyDzKooCEP6/bap6a6ZSgSS4reY2u3PwdZVo9DlKxdyKk4015TWZf
 aruExxg2y+nzVIF7/8PWojswkckvNyddaTu7UGNidlNv0CpUd24vn3Svf0iTSBTP8VeYkDobI
 J1xYI1SVVveZfI8+XUsIlIWb2LXvPOP3wGBJEG60mxN0Y3PpxvYVfXA4nTJBR03m3Zj6IflG5
 PNjvxXlbdO45+INd01KvlnzXKMuE7is6+0lE5Y3A0NH+3XO2v2ylTVV/wmnSofYimn7uTqr7X
 iBtJ0dflQEdGT4FJXqkcJgsCXtTeGVoD4MhXN4Nt3ybBLHzB4AtSSQTHsf8Xn6x0WSbMoF6yV
 7ubwc1ciMKdyg6/knrJNthuWRxa870n7VLkoMNs6cyP/LSBTZhb6Fn5p/3au9dv+rzg6ovlUS
 JWCJh4SZTaFdRR7duW0eifnmsdXdXHByx+dXl3nFtBPIYY8LXNLuyP4bihvjr/K1GUaENwcJV
 jIqjMiZbQSN1rOOg0HKUa2v3zRAZUMrrcc0cD+peMJ61XJ5Q8GfH6yw71wAe+vgvmZZtjiTCC
 oAvJmTI2IRNGCSHVdHRZp/LBu7Imh9Dd/RkFrFhVfBXHQerlBfatxQJEo/9BfFhGh88WJ8osA
 CGo4+oqzvXK/sfaDecrDmW2B7XKKxtSsHAlQ6qWgn5N3/IwyGC9913f17tPZ2gIFRAAJ4MOaM
 SOvaFz8jF2AnsoqztPVy7dYl+evus5rWLoCj7mte8+dpruf2WCdOoXKEBZVvhWb+GWL0/qWwn
 eUIP5JIAwU24HbVcNS+d4rESSvTtTGbwuEHYic4j6YpxiVuZZzymPWu4E28/jHMdfpwXVpIrY
 vU2LUY449FGCm56+2qu7Uneqk2Jrv/YYJkcyUCLnlXXeHOvtmvNjY1Kg69cqMZbtc+84TAvVj
 vB3++A7aFQRp7Z7j/yyxnuvLKJnCJ6rGVBxt/oPnWg/LnudmeJIKaSmHAqMjQB5N+2+SodwnE
 5cX7Exiz7H/26+tgUrchd9dcNrnDcpalYV8j1kRGR94IaGsTPpzfGa9ICnQ21luWTVBIUdT9E
 mMsy/hhMZ9SJHXGMfoG2l5XAI8X4J/LZh9gsz9RRYRzohISMG8QEDeV3bog936FSu+VYbu8M9
 lH67IRlbFLYpGeTpgLa6WkMJXErXYXihhhBdTsQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-527273458-1602535163=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 12 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Micha=C5=82,
> >
> > On Mon, 12 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:
> >
> >> @@ -5203,6 +5207,22 @@ static int diff_opt_patience(const struct opti=
on *opt,
> >>  	return 0;
> >>  }
> >>
> >> +static int diff_opt_ignore_regex(const struct option *opt,
> >> +				 const char *arg, int unset)
> >> +{
> >> +	struct diff_options *options =3D opt->value;
> >> +	regex_t *regex;
> >> +
> >> +	BUG_ON_OPT_NEG(unset);
> >> +	regex =3D xcalloc(1, sizeof(*regex));
> >> +	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
> >> +		die("invalid regex: %s", arg);
> >> +	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
> >> +		   options->ignore_regex_alloc);
> >> +	options->ignore_regex[options->ignore_regex_nr++] =3D regex;
> >
> > A slightly more elegant way would be to have `ignore_regex` have the t=
ype
> > `regex_t *` and use `ALLOC_GROW_BY()` (which zeroes the newly-added
> > elements automagically).
>
> It may be "elegant", but we we know if it is "correct" on
> everybody's implementation of regex_t?
>
> A struct like
>
> 	struct foo {
> 		char *str;
> 		char in_place_buffer[10];
> 	};
>
> where str points at in_place_buffer[] only when it needs to point at
> a very short string, and points at an allocated memory on heap, can
> not be safely copied and used, and an array of such a struct breaks
> when ALLOC_GROW_BY() needs to call realloc().  Keeping an array of
> pointers to regex_t and growing it would not break even for such a
> structure type.
>
> Since we cannot rely on the implementation detail of regex_t on a
> single platform, I'd rather not to see anybody suggest such an
> "elegant" approach.

True, such an implementation detail is totally conceivable.

Thanks for the sanity check.

Having said that, my suggestion to use `ALLOC_GROW_BY()` was triggered by
the use of `xcalloc()`, and now that I think further about it, an
`xmalloc()` should be plenty enough: `regcomp()` does not need that struct
to be initialized to all zero.

Ciao,
Dscho

--8323328-527273458-1602535163=:50--
