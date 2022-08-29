Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79AEECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 12:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiH2MfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiH2Meq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 08:34:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF963BA9C9
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 05:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661775472;
        bh=s1YXfryq5FHG3CbIvtjKE2ybw+uRl0KnfYQaRgMcm0o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YKwmgzIycfQPfJk68DfQz3ES5wwLwfueTqd1xRoQYlTV2B2z132RwjZsbWFaR2Tjt
         8ijbx4tzGESYSnaemipfzb9XNxzf6ftEhuR9Caekis0RpM4D8xZEdD8fR4wnR9GxXu
         v3EQ5AOkCX8gwJOYf+t07oQ2ktYwV5gIG0ESlvN8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvrB-1p35FP2C69-00hKLl; Mon, 29
 Aug 2022 14:04:42 +0200
Date:   Mon, 29 Aug 2022 14:04:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH v2 1/1] diff.c: When appropriate, use utf8_strwidth()
In-Reply-To: <20220827085007.20030-1-tboegi@web.de>
Message-ID: <0q921n79-sr17-2794-83r0-r59rnqq03pp2@tzk.qr>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com> <20220827085007.20030-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1794559620-1661774683=:189"
X-Provags-ID: V03:K1:h7fmuaA+uoHdiaJLl+blkR6I+mRbZL3vGrXxYAA1g+zUn4o1a7Z
 SpStZmGxuyoOGYHCE88xAMtv8cnugKN46dI/AZAm7NpHyFbyxFMfZwIJFiv1cKNpZmlxkIB
 GDGXABZCCUxSYrCzQlwvJWjwx4AFlI2AOi1ycBxfu2iWNF5Pw0FILKjzAW+WtLjcRL0NiZj
 wff0WaFUq8nXWe+Dzt2MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6jmxsDMT0MM=:VZGNGoj25MX4PpCmuDFEAB
 Qj+HO5SGrdMHjqHQ/5lHb5CPz6m3YA3NIu4pP9JrJqKzyNpdyW8bLPluXbgQ/fHRRtyOp21zt
 jSuU9LPMc+3Vqkl7JEKuGpZ6mZFbC+PIDMsji5yRTYAKG7T5un8xfCPWpS3NQ3IzRuVrndUfG
 KnIBYOQ1Odiov2vdFDvQ+YVspVLZR8wSuJ+T3PvjdTrCvkUuezguOAv5XC4xm3bHbG8fZnn/C
 3DIU1t/u04Iw/NZkBC9suMd+TUiNYYaWTu8i2mkJaKvfQsv6dTzOmtKjHxnELAr4od8UpSlVK
 uwp9qIjDW6E7BSojMx/FjFgoevSp74/fGMVBH+NiAmrPQwRzYzCil/4gPhTxg6tJzNaxnK95Q
 BGXA39+G/X4RvR7aO93je4uT8dzEHKXBjrn2ijxWjnYnd5n9VImdVFpRDK+T33caK0f9WEBRU
 y61p74snHpDVZkdoTLBRN5jYZU1Re3xfgPJv6YvN73LEWTtoQiABiuZlc3AVlQOJdwTy8xV+i
 pBii+FkRlR1dkmBMVa++ba3nH0KQdr5wsUp3B6J+cWVERudRZcdVJZVLuEAN7H4RHqrunzXPC
 0zMmXYbrJWvClAS1Wlyqh4HI0CZm3C3AzScez7KIcJYkQ4C2zlQGCKDxyH/fFeLOxhXoZyiPY
 4L6+GvNa5Oq34cs+2UIkcogbo/zmf0JFNxIwMeP61c2385tZvOZ9PkrxRUozAg+TLiFBEdJqU
 +cFqDMGSp8FrPAitYcyFipY86xpNy8q2tjwyKdof435DMqCej7neBTo9wAqiC/+2VTpLZ8M8M
 M7j9vm7qT/w6LmPX7h8FvK3oM1/dLYRfg2Tmj+Jsri/aHH78iATFuhFvhy/mVQMvSFSOWNWBY
 x1xNJNDtHl74xw1kVRAbeqESnpBmOFBf553E+vlxwxo4/XE7X36cj/qV0ksAhRuu97VHCj9ic
 o8N4AFkqUV+D3l5oakSPdmZaw7vJB+Hrq/rOpxHfL3KY4SRCLeNvI78TOC4hTOh4uYWUEkgte
 /jjj2x8o7yY3wmhd1tz3aN9xFxfp6TPgmLiW6ydr87sF/ux3GviSV/wD6oEk1AEYAk37hvhUZ
 f713lWKOnWYNZxP0uCtJvbGPgJkpNQ5zXDrrs6QHnnx3Ug9mkiuGeKrqA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1794559620-1661774683=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On Sat, 27 Aug 2022, tboegi@web.de wrote:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When unicode filenames (encoded in UTF-8) are used, the visible width
> on the screen is not the same as strlen(filename).
>
> For example, `git log --stat` may produce an output like this:
>
> $ git log --stat
>
> [snip the header]
>
>  Arger.txt  | 1 +
>  =C3=84rger.txt | 1 +
>  2 files changed, 2 insertions(+)
>
> A side note: the original report was about cyrillic filenames.
> After some investigations it turned out that
> a) This is not a problem with "ambiguous characters" in unicode
> b) The same problem exist for all unicode code points (so we
>   can use Latin based Umlauts for demonstrations below)
>
> The '=C3=84' takes the same space on the screen as the 'A'.
> But needs one more byte in memory, so the the `git log --stat` output
> for "Arger.txt" (!) gets mis-aligned:
> The maximum length is derived from "=C3=84rger.txt", 10 bytes in memory,
> 9 positions on the screen. That is why "Arger.txt" gets one extra ' '
> for aligment, it needs 9 bytes in memory.
> If there was a file "=C3=96", it would be correctly aligned by chance,
> but "=C3=96h=C3=B6" would not.
>
> The solution is of course, to use utf8_strwidth() instead of strlen()
> when dealing with the width on screen.
>
> And then there is another problem: code like this
> strbuf_addf(&out, "%-*s", len, name);
>
> (or using the underlying snprintf() function) does not align the
> buffer to a minimum of len measured in screen-width, but uses the
> memory count, if name is UTF-8 encoded.
>
> We could be tempted to wish that snprintf() was UTF-8 aware.
> That doesn't seem to be the case anywhere (tested on Linux and Mac),
> probably snprintf() uses the "bytes in memory"/strlen() approach to be
> compatible with older versions and this will never change.

An interesting read so, far, but...

>
> The choosen solution is to split code in diff.c like this
>
> strbuf_addf(&out, "%-*s", len, name);
>
> into something like this:
>
> size_t num_padding_spaces =3D 0;
> // [snip]
> if (len > utf8_strwidth(name))
>     num_padding_spaces =3D len - utf8_strwidth(name);
> strbuf_addf(&out, "%s", name);
> if (num_padding_spaces)
>     strbuf_addchars(&out, ' ', num_padding_spaces);

... this sounds like it would benefit from beinv refactored into a
separate function, e.g. `strbuf_add_padded(buf, utf8string)`, both for
readability as well as for self-documentation.

Also, it is unclear to me why we have to evaluate `utf8_strwidth()`
_twice_ and why we do not assign the result to a variable called `width`
and then have a conditional like

	if (width < len) /* pad to `len` columns */
		strbuf_addchars(&out, ' ' , len - width);

instead. That would sound more logical to me.

Besides, since the simple change from `strlen()` to `utf8_strwidth()` is
so different from changing `strbuf_addf(...)`, I would prefer to see them
split into two patches.

>
> Tests:
> Two things need to be tested:
> - The calculation of the maximum width
> - The calculation of num_padding_spaces
>
> The name "textfile" is changed into "textfil=C3=AB", both have a width o=
f 8.
> If strlen() was used, to get the maximum width, the shorter "binfile" wo=
uld
> have been mis-aligned:
>  binfile   |  [snip]
>  textfil=C3=AB | [snip]
>
> If only "binfile" would be renamed into "binfil=C3=AB":
>  binfil=C3=AB |  [snip]
>  textfile | [snip]
>
> In order to verify that the width is calculated correctly everywhere,
> "binfile" is renamed into "binf=C3=AFl=C3=AB", giving 2 bytes more in st=
rlen()
> "textfile" is renamed into "textfil=C3=AB", 1 byte more in strlen(),
> and the updated t4012-diff-binary.sh checks the correct aligment:
>  binf=C3=AFl=C3=AB  | [snip]
>  textfil=C3=AB | [snip]

I wonder whether you can change only _one_ name and still verify the
correctness. When you make two changes at the same time, it is always
possible for one change to "cancel out" the other one, and therefore it is
harder to reason about the correctness of your patch.

Better keep it simple and change only one instance (personally, I would
have changed two letters in the longer one).

>
> Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  diff.c                 | 37 +++++++++++++++++++++++--------------
>  t/t4012-diff-binary.sh | 14 +++++++-------
>  2 files changed, 30 insertions(+), 21 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 974626a621..cf38e1dc88 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2591,7 +2591,7 @@ void print_stat_summary(FILE *fp, int files,
>  static void show_stats(struct diffstat_t *data, struct diff_options *op=
tions)
>  {
>  	int i, len, add, del, adds =3D 0, dels =3D 0;
> -	uintmax_t max_change =3D 0, max_len =3D 0;
> +	uintmax_t max_change =3D 0, max_width =3D 0;

Why rename `max_len`, but not `len`? I would have expected (and agreed
with seeing) `len` to be renamed to `width`, too.

>  	int total_files =3D data->nr, count;
>  	int width, name_width, graph_width, number_width =3D 0, bin_width =3D =
0;
>  	const char *reset, *add_c, *del_c;
> @@ -2620,9 +2620,9 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>  			continue;
>  		}
>  		fill_print_name(file);
> -		len =3D strlen(file->print_name);
> -		if (max_len < len)
> -			max_len =3D len;
> +		len =3D utf8_strwidth(file->print_name);
> +		if (max_width < len)
> +			max_width =3D len;
>
>  		if (file->is_unmerged) {
>  			/* "Unmerged" is 8 characters */
> @@ -2646,7 +2646,7 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>
>  	/*
>  	 * We have width =3D stat_width or term_columns() columns total.
> -	 * We want a maximum of min(max_len, stat_name_width) for the name par=
t.
> +	 * We want a maximum of min(max_width, stat_name_width) for the name p=
art.
>  	 * We want a maximum of min(max_change, stat_graph_width) for the +- p=
art.
>  	 * We also need 1 for " " and 4 + decimal_width(max_change)
>  	 * for " | NNNN " and one the empty column at the end, altogether
> @@ -2701,8 +2701,8 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>  		graph_width =3D options->stat_graph_width;
>
>  	name_width =3D (options->stat_name_width > 0 &&
> -		      options->stat_name_width < max_len) ?
> -		options->stat_name_width : max_len;
> +		      options->stat_name_width < max_width) ?
> +		options->stat_name_width : max_width;

It is a bit sad that the diff lines regarding the renamed variable drown
out the actual change (`strlen()` -> `utf8_strwidth()`). But the end
result is nicer.

Thank you for working on this!
Dscho

>
>  	/*
>  	 * Adjust adjustable widths not to exceed maximum width
> @@ -2734,6 +2734,7 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>  		char *name =3D file->print_name;
>  		uintmax_t added =3D file->added;
>  		uintmax_t deleted =3D file->deleted;
> +		size_t num_padding_spaces =3D 0;
>  		int name_len;
>
>  		if (!file->is_interesting && (added + deleted =3D=3D 0))
> @@ -2743,7 +2744,7 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>  		 * "scale" the filename
>  		 */
>  		len =3D name_width;
> -		name_len =3D strlen(name);
> +		name_len =3D utf8_strwidth(name);
>  		if (name_width < name_len) {
>  			char *slash;
>  			prefix =3D "...";
> @@ -2753,10 +2754,14 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
>  			if (slash)
>  				name =3D slash;
>  		}
> +		if (len > utf8_strwidth(name))
> +			num_padding_spaces =3D len - utf8_strwidth(name);
>
>  		if (file->is_binary) {
> -			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> -			strbuf_addf(&out, " %*s", number_width, "Bin");
> +			strbuf_addf(&out, " %s%s ", prefix,  name);
> +			if (num_padding_spaces)
> +				strbuf_addchars(&out, ' ', num_padding_spaces);
> +			strbuf_addf(&out, "| %*s", number_width, "Bin");
>  			if (!added && !deleted) {
>  				strbuf_addch(&out, '\n');
>  				emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
> @@ -2776,8 +2781,10 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
>  			continue;
>  		}
>  		else if (file->is_unmerged) {
> -			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> -			strbuf_addstr(&out, " Unmerged\n");
> +			strbuf_addf(&out, " %s%s ", prefix,  name);
> +			if (num_padding_spaces)
> +				strbuf_addchars(&out, ' ', num_padding_spaces);
> +			strbuf_addstr(&out, "| Unmerged\n");
>  			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
>  					 out.buf, out.len, 0);
>  			strbuf_reset(&out);
> @@ -2803,8 +2810,10 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
>  				add =3D total - del;
>  			}
>  		}
> -		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> -		strbuf_addf(&out, " %*"PRIuMAX"%s",
> +		strbuf_addf(&out, " %s%s ", prefix,  name);
> +		if (num_padding_spaces)
> +			strbuf_addchars(&out, ' ', num_padding_spaces);
> +		strbuf_addf(&out, "| %*"PRIuMAX"%s",
>  			number_width, added + deleted,
>  			added + deleted ? " " : "");
>  		show_graph(&out, '+', add, add_c, reset);
> diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> index c509143c81..2d49de01c8 100755
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -113,20 +113,20 @@ test_expect_success 'diff --no-index with binary c=
reation' '
>  '
>
>  cat >expect <<EOF
> - binfile  |   Bin 0 -> 1026 bytes
> - textfile | 10000 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> + binf=C3=AFl=C3=AB  |   Bin 0 -> 1026 bytes
> + textfil=C3=AB | 10000 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++
>  EOF
>
>  test_expect_success 'diff --stat with binary files and big change count=
' '
> -	printf "\01\00%1024d" 1 >binfile &&
> -	git add binfile &&
> +	printf "\01\00%1024d" 1 >binf=C3=AFl=C3=AB &&
> +	git add binf=C3=AFl=C3=AB &&
>  	i=3D0 &&
>  	while test $i -lt 10000; do
>  		echo $i &&
>  		i=3D$(($i + 1)) || return 1
> -	done >textfile &&
> -	git add textfile &&
> -	git diff --cached --stat binfile textfile >output &&
> +	done >textfil=C3=AB &&
> +	git add textfil=C3=AB &&
> +	git -c core.quotepath=3Dfalse diff --cached --stat binf=C3=AFl=C3=AB t=
extfil=C3=AB >output &&
>  	grep " | " output >actual &&
>  	test_cmp expect actual
>  '
> --
> 2.34.0
>
>

--8323328-1794559620-1661774683=:189--
