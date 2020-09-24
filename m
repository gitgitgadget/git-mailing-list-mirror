Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2A2C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808A42396E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cMMabMoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgIXKAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:00:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:45933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIXKAH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 06:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600941591;
        bh=qOMPw/jNafgNNgxCA46KScTsIXUfFJH/HwdrIW7x0XM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cMMabMoLwdWpiHCjZ/RJTZ5g0Lq0H/47vnuazkE2qT3EIMQ7U3H2wLp1/1A80sZpR
         rzDTldKXpfQpgw6MZBwDcuxEihdtJC6xVYF6vf3k6Llo8Evp+IQLYG+x/wgf7r57dY
         LxSKnqrErllusRoYxIvJPH0S2wmvJf61l/rCXHfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.214.175]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1juKTh1rEs-00S9XT; Thu, 24
 Sep 2020 11:59:51 +0200
Date:   Thu, 24 Sep 2020 09:49:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH v2] bisect: don't use invalid oid as rev when starting
In-Reply-To: <20200924060344.15541-1-chriscool@tuxfamily.org>
Message-ID: <nycvar.QRO.7.76.6.2009240947080.5061@tvgsbejvaqbjf.bet>
References: <20200923170915.21748-1-chriscool@tuxfamily.org> <20200924060344.15541-1-chriscool@tuxfamily.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xRQyECog+akPhTB70ISOC7VYnvx8lhwTWFktHg/4a2AwuezSQh8
 nOttyKKJTKCjlOj1E/nBgOablmGbPJ6xQJM6DTGtXW81Zw2ETNTYgJ/S/nQ3tZDogDeRNa8
 c2ipASGffbN2e6TADwiVead79r8ndWL2ocfsZztj9q2JSxspMNUC8LIpagYDacjoCLT5tYX
 Tn+fKf3mPh27FnnGdpccw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zidPUj2MuUA=:w1gADeN4pt46BLo8jVAU/P
 KmJgPy7R87kkHjX333ZrBB9uG5YSdtCSBSAupdalzQ1BY5T2QYvIc4TXGZ/kT1D6RB1u9xblh
 0ZubaWujpov5RgqU/t2x6h/IqU5zcUWrhwBRTQwtsDqUg6S2MexzPGcZaUrF+VSANe09pyd8u
 WqY6NGkrZco6A9kLJfw3k/+pfmmHBd4p+hhzsEXAbTTaZdMzkHMfXlcPQiO6A0uQ7ypj/Np9+
 wnS3o5Z/u4F9u/nSwTIi5qdSGYLZ6BSlbPXIWxV7IDPGy+ql0kf+Vj/EJ9l6v40CWYQVcTCbc
 WvXbO2MYB3m9QOUI0FEc99XJY0SsZPKkKPEVofmZQPIq6wqy4xi6e3VHv6lN4Mz2DkceFa1/g
 Lv9pd6s7p6r1uCaB/rixaHSvwW5C/HorrmmQDphs8R5uPKYM8gyaQfoKMUB1aKePP/HTyiHrF
 dQh/CoAZgabqpdYJHF5Xwo4XTzle1rfRBxvWKMX2ObgMimCHN1qmyFsk20KZQD1wX2HjQpMT3
 ZLfz/qE81br+LPPvWXwIsSThqxpyd6QS+QnJpCR4Pm4ArDtYpynOILlkFLfpmbE/8IUy4qWKO
 sA58UyskzBkxIXV3Iaji5fHbrfMpZA8lEvb3Xj2MZufek4YVhfefvva93cEUo/evmjt7sL4Ps
 YJPqhWZp7iPm/PhBgdMCRA1v4fGFqJX1iZVxIcvD15crtksSKltFkR6ixc7oB8DvvV6iGN5B3
 g0wctBxGpJKTecfz44e/PElGFc3+ib6A4r0Ue4Zvlbz1yi06qXoI8Ta28JKjPpHryQyEiDQRP
 sHrtrJHUP/grV8vFAQf4P0ZqoUYxokAypZnFFMGF3GfI83MTAXH4v5eIf7amrV9MtEC1rAOiv
 z4rr/Ojk0CKYOESF3doKFrFvtFYSBi59s8e7+id3CCOyi5kvGAu0hJPCg75xd57b0QA0aOuvF
 8u8M+w8qh8t36iRmXeviIkr8E4sGqjQz5/yRAlmDGFBmRfg9HPYYBmxx65HDJGMylKxFugrc1
 GZdcCFOuqxJz4ZP6K4bv/AK9r8BA03sm4kE3f8CWpHe+onQZ+ZWf2HToRXT6G280mWMbSFeMs
 8+vi5ZuxyvRUFpQa9/xbr1kbj/KsxOkDUK7qdHi9OMqjfueeKAzNI09N+kqOeLorFkSPCcuJG
 PXRZAJurVuLAwamM3FsjbMJ7I8ivPJUGBsdAQYCZTVkVuyX/wOi9njNuZd1bBOgnIUAx6LhFK
 aIacVbDzorRgbhpB7jBI17ZZqvkX541kMi1A0jA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, 24 Sep 2020, Christian Couder wrote:

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

These are awfully long lines. The reason is that you kept the indentation
of the diff. But that's actually not necessary, because we do not need to
apply a diff here; This code snippet is intended purely for human
consumption.

What I suggested in my adaptation of your patch was to lose the diff
markers and to decrease the insane amount of indentation to just one (and
two) horizontal tabs.

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
> treated as a path restriction.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> This patch is made on top of e1cfff6765 (Sixteenth batch, 2020-09-22)
> and incorporates Dscho's suggestions.
>
> Thanks to Junio and Dscho for reviewing the first version.
>
>  builtin/bisect--helper.c    | 14 ++++++--------
>  t/t6030-bisect-porcelain.sh |  7 +++++++
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 7dcc1b5188..f4762e1774 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -484,15 +484,13 @@ static int bisect_start(struct bisect_terms *terms=
, const char **argv, int argc)
>  			terms->term_bad =3D xstrdup(arg);
>  		} else if (starts_with(arg, "--")) {
>  			return error(_("unrecognized option: '%s'"), arg);
> -		} else {
> -			char *commit_id =3D xstrfmt("%s^{commit}", arg);
> -			if (get_oid(commit_id, &oid) && has_double_dash)
> -				die(_("'%s' does not appear to be a valid "
> -				      "revision"), arg);
> -
> +		} else if (!get_oid_committish(arg, &oid))
>  			string_list_append(&revs, oid_to_hex(&oid));
> -			free(commit_id);
> -		}
> +		else if (has_double_dash)
> +			die(_("'%s' does not appear to be a valid "
> +			      "revision"), arg);
> +		else
> +			break;

Thank you!

>  	}
>  	pathspec_pos =3D i;
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index b886529e59..70c39a9459 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk i=
nstead of revs' '
>  	git bisect bad $HASH4
>  '
>
> +test_expect_success 'bisect start without -- uses unknown arg as path r=
estriction' '

To avoid the overly long line (and also to re-use existing naming
conventions), I replaced "path restrictions" by "pathspecs" here. What do
you think?

Ciao,
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
> 2.28.0.585.ge1cfff6765
>
>
