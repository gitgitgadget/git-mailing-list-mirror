Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B890FC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B46208FE
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d5osZ3ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbgJLLZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 07:25:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:48753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbgJLLZw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 07:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602501615;
        bh=bYlrZrZqMYtddnqEpQ8A55dPC3hNs537ZcluACSaTbk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d5osZ3psWuoG+xa9mWm28qgyHUzqBHmAEvOR2bXTuNaP3ZTElvwJGaUP8MJE5nStC
         0CvEqhgYSHpHwLn/d+Ii65gbjSU+DSiE0fvKaaZX4GHKOPEQlhdgs+ebsRqzZBH84Z
         7g0fMf3gasKkyJfT/fs8YNKIngplA3KtbrrpGk0I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.146]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1jxFpH1qaG-00dk4j; Mon, 12
 Oct 2020 13:20:15 +0200
Date:   Mon, 12 Oct 2020 13:20:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching
 changes
In-Reply-To: <20201012091751.19594-3-michal@isc.org>
Message-ID: <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
References: <20201001120606.25773-1-michal@isc.org> <20201012091751.19594-1-michal@isc.org> <20201012091751.19594-3-michal@isc.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-751567358-1602501615=:50"
X-Provags-ID: V03:K1:koicvmi26UFjQtYncMEnxQbU+4rMBqV8IlxqVXlAW9vrWe488LZ
 QbVZY4yaMAe3fUh5yO9bIlZ3lH6IUNa9Dz4kpQFQMnwnNhSxNPVUknRYCizMHNkQBOjFDJ9
 M/4lBFe45vNtQkKKvDnbetF2rzJgFPtrin5WUrivwGX31rPTmJv9xFl9l/+swG9V8hRoL8Y
 4LJWuBBhxH+Ftpdbd2A4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DwRAwC3NigY=:sPyCv6HRlRsW2YfNpiD1rW
 2Al3s6/Z1aVOgRDuN71pyk2NveAjMol2CfE48uYlhdHJq2/rJsseW4j7EKWjIK/qb9GEkKMpD
 NStuse+l1xoNPeS6IhoA6EgGsBKvbGGgM94IS79ErupVY6k8hEsEG8okOnmPg6zzer6PFRYPx
 Ot4otboY2OUsf5SCrwS3zNN4e5//rpnjH97b/Dg8RDH0oJvi2lOTNAl3KwBVJUoG+4sxIR6lz
 yl8KN8c7BK7OYqElYR3WVvaX4Ds1JH9AcgV0Y9AvI9xae7JyRxQvqq8PVJAebhQ8ULBWfR+Lr
 H5sEeMjXfDO/FsH1a7Y4QHYJ9+jr05H9JqliDpmiKbscj9O6DDxiM0vcML/fIgHDnJAm/PSFx
 PTOb7raUAeOSskPYivB618eNQiWq3fcEGeGsNqKcLesSV9ntDdg42Cs6DLaRjH8j4GBFFY+oY
 dtUFimo8nuK3EH11wjoGjAg5h0uK2mpIFUVhS6LMRn1ZUc/gaRJ2djRi03UU6mL59Gil7N2xt
 uwTTxBprau+40B0KGgKyioCmhzUPA54g8KnZ7QzDZfLRwYSEjV1oQT6iEs58KY8Mih3q3frmF
 +qtUS9exRsrhPK4iRywpTcG3ufXUpR59uM78QJBomhzucusyupjr6cB9BArfxLyH1tsqLAsOl
 vMIhe7TXeyxrsJalWrZwoE2ozljUKYimrBApaZw/zJDrNdk/Rf7PnqX+4RyNalBtM3FOXcEmn
 piBtIYJlcCDaPCshOZ85v2K40IVZbbXbEVZ4tzFJ48RYkLmXKB1Gs3LeZULwWkMjmToLwUm7S
 wlphe2uZerfalSnvtIF1kOT/6qb/EknUJqo+0dFMT9tGl8S+Wkdnkn6/oWUHxslMMOlIRWwgJ
 65+Uv1gwGIXGI8Nusa7yeFQSEcz09oEiHb0ECB7JsWjGzepX/x8mTSefAAzsILSdzIdxWIATB
 Ht4o2qaBMAxkDikywdf2vqW6UyKwebf2t/QGZUvQ6mkZ5o4nv+Nus+hq5SA7sQ4uRC5dCc5wq
 zwLJxmczWszNQjiwOkkEFXWCK48Uovktzj48OLBNVCUtDswyC6+3IJgGyCYoc6Jt/+TVjuoP+
 BEGokqF37NWYIDA+XyL0Rj1tR/b6BKZ2bLFefZKa8RnNdGz2hdIgWFAlVnudlYZto3HzT9Pg9
 Rg/aOpV0/OVvYKQEJQc5kcJUfNHgHYEIxXPfH9S/QYfv7MyufhSibgbNQgFicvpcR0GVq7Pjg
 HMnPNFj1IqHC/I0rgt79TvSPcBXp6J2uzEDdXkA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-751567358-1602501615=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Micha=C5=82,

On Mon, 12 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:

> @@ -5203,6 +5207,22 @@ static int diff_opt_patience(const struct option =
*opt,
>  	return 0;
>  }
>
> +static int diff_opt_ignore_regex(const struct option *opt,
> +				 const char *arg, int unset)
> +{
> +	struct diff_options *options =3D opt->value;
> +	regex_t *regex;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	regex =3D xcalloc(1, sizeof(*regex));
> +	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
> +		die("invalid regex: %s", arg);
> +	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
> +		   options->ignore_regex_alloc);
> +	options->ignore_regex[options->ignore_regex_nr++] =3D regex;

A slightly more elegant way would be to have `ignore_regex` have the type
`regex_t *` and use `ALLOC_GROW_BY()` (which zeroes the newly-added
elements automagically).

> +	return 0;
> +}
> +
>  static int diff_opt_pickaxe_regex(const struct option *opt,
>  				  const char *arg, int unset)
>  {
> [...]
> @@ -5491,6 +5511,9 @@ static void prep_parse_options(struct diff_options=
 *options)
>  		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
>  			  N_("ignore changes whose lines are all blank"),
>  			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
> +		OPT_CALLBACK_F('I', NULL, options, N_("<regex>"),
> +			       N_("ignore changes whose all lines match <regex>"),
> +			       0, diff_opt_ignore_regex),
>  		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
>  			N_("heuristic to shift diff hunk boundaries for easy reading"),
>  			XDF_INDENT_HEURISTIC),

Are we releasing the `ignore_regex` anywhere?

Thanks,
Dscho

> diff --git a/diff.h b/diff.h
> index 11de52e9e9..80dbd3dfdc 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -234,6 +234,10 @@ struct diff_options {
>  	 */
>  	const char *pickaxe;
>
> +	/* see Documentation/diff-options.txt */
> +	regex_t **ignore_regex;
> +	size_t ignore_regex_nr, ignore_regex_alloc;
> +
>  	const char *single_follow;
>  	const char *a_prefix, *b_prefix;
>  	const char *line_prefix;
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 032e3a9f41..883a0d770e 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -79,6 +79,10 @@ typedef struct s_mmbuffer {
>  typedef struct s_xpparam {
>  	unsigned long flags;
>
> +	/* See Documentation/diff-options.txt. */
> +	regex_t **ignore_regex;
> +	size_t ignore_regex_nr;
> +
>  	/* See Documentation/diff-options.txt. */
>  	char **anchors;
>  	size_t anchors_nr;
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index bd035139f9..380eb728ed 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -998,7 +998,7 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange=
_t *xscr, xdemitcb_t *ecb,
>  	return 0;
>  }
>
> -static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long fla=
gs)
> +static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, lo=
ng flags)
>  {
>  	xdchange_t *xch;
>
> @@ -1019,6 +1019,46 @@ static void xdl_mark_ignorable(xdchange_t *xscr, =
xdfenv_t *xe, long flags)
>  	}
>  }
>
> +static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
> +	regmatch_t regmatch;
> +	int i;
> +
> +	for (i =3D 0; i < xpp->ignore_regex_nr; i++)
> +		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
> +				 &regmatch, 0))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *=
xe,
> +				     xpparam_t const *xpp)
> +{
> +	xdchange_t *xch;
> +
> +	for (xch =3D xscr; xch; xch =3D xch->next) {
> +		xrecord_t **rec;
> +		int ignore =3D 1;
> +		long i;
> +
> +		/*
> +		 * Do not override --ignore-blank-lines.
> +		 */
> +		if (xch->ignore)
> +			continue;
> +
> +		rec =3D &xe->xdf1.recs[xch->i1];
> +		for (i =3D 0; i < xch->chg1 && ignore; i++)
> +			ignore =3D record_matches_regex(rec[i], xpp);
> +
> +		rec =3D &xe->xdf2.recs[xch->i2];
> +		for (i =3D 0; i < xch->chg2 && ignore; i++)
> +			ignore =3D record_matches_regex(rec[i], xpp);
> +
> +		xch->ignore =3D ignore;
> +	}
> +}
> +
>  int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>  	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
>  	xdchange_t *xscr;
> @@ -1038,7 +1078,10 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xppara=
m_t const *xpp,
>  	}
>  	if (xscr) {
>  		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
> -			xdl_mark_ignorable(xscr, &xe, xpp->flags);
> +			xdl_mark_ignorable_lines(xscr, &xe, xpp->flags);
> +
> +		if (xpp->ignore_regex)
> +			xdl_mark_ignorable_regex(xscr, &xe, xpp);
>
>  		if (ef(&xe, xscr, ecb, xecfg) < 0) {
>
> --
> 2.28.0
>
>

--8323328-751567358-1602501615=:50--
