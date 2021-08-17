Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C21EC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1955060F22
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhHQL62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 07:58:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:38181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236751AbhHQL61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 07:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629201473;
        bh=HZaPiNL5Rvs1fMc+k2J7HKyXaTwMHZKlH7Agc/iH0ys=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W9R67JWHAZ6YmKAAGxetshggmDtdUffG1FrHKvEnab6PFmE8cH5AGU9wmXVkE6AnR
         mVKTIpfam2vxnCDKXdPlDKN2R0FkQ+LiaYCvP8+dwZ4dbZI3h27Y2l4pckpcHtAaHs
         MqbeinavbOsjf6o+u42pqOnZR9it2zQOCZ5rA3gw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5R-1mjopu0wF9-00ecKE; Tue, 17
 Aug 2021 13:57:53 +0200
Date:   Tue, 17 Aug 2021 13:57:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 6/6] bisect--helper: retire `--bisect-next-check`
 subcommand
In-Reply-To: <20210817081458.53136-7-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108171357170.55@tvgsbejvaqbjf.bet>
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-7-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9OVMJouasJEtqSB+shBz0PRtMgrrfaJEV1ka3ZwLpH1ZLCsUjQ5
 /XUuXmKN+1wGGmBaDyHYeBxk4Ct4nrXXCIQZ7eTdcktQlQsvkNJ5ouFK+EUpdwh6gcLmNFh
 PDmtZ7OzgpZ84N8shsYhRVlQyg8bVoJ66ljhWW99Jq5ynmSvwMnncsfmf6+DzdFCQ0stcLr
 CBZ5g9s9yKZWBQ+da7yuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XOtRWbdYtFQ=:MiUGfR4gE7FOgSYKOvruhU
 QXwmGE6kf1DiaoWxuX/sPdMb+77E1c/HEvN9DnmoGn3Q3+o9X2WQuUuY8+wqNaHhSt+GapnzA
 NHiHHDwNRJVb0hQ4uSljPYgyp/p3T1lBeBPMfcm8zjKrW0ZLR/Ou9Xa5fFg74BptHDy3Ccf8M
 IPrvFnmRSsi7x3KmPOSgrQUQ+wB3o8/eiVLjSZiiZ/4x3bdEgtBFo00FToTgKXcRI+rK5hLpX
 eJbjhHAfbVWV4iaxrygPBSxZp+jy6NyhspIWIjazRtzqiwLdlL9spiEN4q0LtCs6FkfKIAdqw
 bNDAomBCA2Q18p+s9TB/yWD7dN3arlpC/lIFNefcOhoghlE39IN3JjwmJFXUVyEwvh1kVPZje
 nyu1tBj1NVq5bfBGPwBmAYWwZttNsocDV8jgxqVraEofYQbO9S3/a0oEIxpkwvIb9lAz9KqWe
 ++mnD30EZFATEtdCgh2kk2efuJtA7/RGa5Qmq+1jt19lKm85GfPrDESzQMC5pr8Mc1TIEJctk
 iddgtzBMN50sH8xYiS7A1kcDG9OJF6l46FKcsauYBWd3Goe7r7Ue66uvXkbVuagrdt1QQ8s/D
 zc1gnk6SjMGT+YmqWhXxu39KzOuNgnn8698DtnYLu7I0BjX7YF3gth6nFtFF6ZN+0FMFsC7dk
 EJGCMkWC16O6sDVd5whohO9fzb8dLqcUg4QrZhdrL4wJr4O+ZrB0cxQpRr/D4mmnffwbnzNhT
 xoEFCqsQqmQ8P8uHKaO0OSdPG80+huAXw45cKgOkSkFcEFDg3Eu1q/qRJ3SXZhB14EIBM/Vkp
 vy9eC3iX+LFhM2bpV/M729e11w+qH/3LndDzLzMneQrLE5FmZ4VzYheNPv4bjR6qPlv+hwIaF
 +3kTQJmP01AoF0Jk7OD1PM1qpcWp/+wZe99nhsCRWaCBexpV9LIeIosDKVAtr24ivnRRKY3fu
 jUsNvWFkTLSORsj3ozMfWTrUGm3Lub0cbo5LT+/g6zpu2E1T6UpsI0tmi3jq4F7RDc2ycq8vH
 kGsmTMw8p5ULv1YukXiGujd3a4qxMFKXW3UMA7ehGdFR1TkAY0Jpcgb4Tda6iktBSVrMXa7oH
 k0X4QDqFhavZgUOfbvooaWoZZMbCY8zjDoz47oCBYg1peCM3VMqoNxi7Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Tue, 17 Aug 2021, Miriam Rubio wrote:

> After reimplementation of `git bisect run` in C,
> `--bisect-next-check` subcommand is not needed anymore.
>
> Let's remove it from options list and code.
>
> Mentored by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 7 -------
>  1 file changed, 7 deletions(-)

Exciting! This is inching closer and closer to a fully-built-in `git
bisect`.

Thank you so much!
Dscho

>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 852e0a30fb..d749747639 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BI=
SECT_FIRST_PARENT")
>
>  static const char * const git_bisect_helper_usage[] =3D {
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
> -	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<te=
rm>]"),
>  	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --te=
rm-bad | --term-new]"),
>  	N_("git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --ter=
m-{old,good}=3D<term>]"
>  					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<=
paths>...]"),
> @@ -1200,12 +1199,6 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
>  			return error(_("--bisect-reset requires either no argument or a comm=
it"));
>  		res =3D bisect_reset(argc ? argv[0] : NULL);
>  		break;
> -	case BISECT_NEXT_CHECK:
> -		if (argc !=3D 2 && argc !=3D 3)
> -			return error(_("--bisect-next-check requires 2 or 3 arguments"));
> -		set_terms(&terms, argv[1], argv[0]);
> -		res =3D bisect_next_check(&terms, argc =3D=3D 3 ? argv[2] : NULL);
> -		break;
>  	case BISECT_TERMS:
>  		if (argc > 1)
>  			return error(_("--bisect-terms requires 0 or 1 argument"));
> --
> 2.29.2
>
>
